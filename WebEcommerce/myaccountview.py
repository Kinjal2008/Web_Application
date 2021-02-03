import datetime
import json
import stripe
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.core.exceptions import ObjectDoesNotExist
from django.core.mail import EmailMultiAlternatives
from django.db import connection
from django.shortcuts import render
from django.utils.html import strip_tags
from django.views.generic import ListView

from ManorPharmacy.util import render_to_pdf
from adminpanel.models import *
from django.core.exceptions import ObjectDoesNotExist
from django.contrib import messages
from django.http import JsonResponse
from django.template.loader import render_to_string
import stripe

stripe.api_key = settings.STRIPE_SECRET_KEY


# This function display the list of the customer's (who has logged in) all orders.
# It will display the list like Order#, Total amount to pay, The Full amount (in case of FUll payment),
# Payment method and Payment status whether all amount has been paid or some instalments are pending.
# On the site it will be display under: My Account/My ProLongevity / My Plans.

class PlanView(ListView):
    model = Product
    template_name = 'webecommerce/myaccount/planlist.html'

    def get_context_data(self, **kwargs):
        context = super(PlanView, self).get_context_data(**kwargs)
        orderitems = {}
        if self.request.user.id is not None:
            customer = self.request.user.customer
            id = self.request.user.customer.Customer_Id
            try:
                cursor = connection.cursor()
                cursor.callproc('GetPlanListByCustomerId', [id])
                plans = cursor.fetchall()
                context['plans'] = plans
            except ObjectDoesNotExist:
                order = {}
        return context


# This function display the customer's full order details based on the order number. Fpr that selected order number,
# whether the payment was done in Full or instalment, it will display the details accordingly.
# On the site it will be display under: My Account/My ProLongevity / My Plans / Details.
@login_required(login_url='Login')
def planDetail(request, id):
    try:
        customer = request.user.customer
        order = Order.objects.get(Customer=customer, Order_Id=id)
        orderitems = order.orderdetails_set.all()
        userid = request.user.id
        address = Address.objects.filter(User_Id=userid)
        totalinstalments = InstallmentDue.objects.filter(Order_id=id)

    except ConnectionError as e:
        print('ERROR in PlanDetail function: ')
        print(format(e))

    return render(request, "webecommerce/myaccount/plandetail.html", {'totalinstalment': totalinstalments,
                                                                      'orderitems': orderitems,
                                                                      'order': order,
                                                                      'address': address})


# This function will display the number of instalments under that order number.
# On the site it will be display under: My Account/My ProLongevity / My Plans / Details / Instalment Details.
@login_required(login_url='Login')
def paymentInstalment(request, id):
    try:
        totalinstalments = InstallmentDue.objects.filter(Installment_Due_Id=id)

    except ConnectionError as e:
        print('ERROR in paymentInstalment function: ')
        print(format(e))

    return render(request, "webecommerce/myaccount/myplanpayment.html", {'totalinstalment': totalinstalments})


# This function implement the connection with the Stripe and takes the instalment payments.
def payInstalmentDue(request):
    transId = datetime.datetime.now().timestamp()
    # result = callback(request)
    data = json.loads(request.body)
    total = float(data['total'])
    orderid = int(data['orderid'])
    instalmentid = int(data['instalmentid'])
    instalmentNum = int(data['instalmentNum'])
    try:

        token = data['token']  # request.POST.get("stripeToken")
        paymentDescription = 'Payment Done by ' + request.user.username
        charge = stripe.Charge.create(
            amount=int(total * 100),
            currency="gbp",
            source=token,
            description=paymentDescription
        )
        message = ""

        datenow = datetime.date.today()
        # Update Payment Table
        payment = Payment.objects.create(Order_id=orderid)
        payment.Payment_Type = 'Card'
        payment.Amount = total
        payment.Date = datenow
        payment.Is_Invoice_Sent = 1
        payment.Stripe_Payment_Id = charge.stripe_id
        payment.save()

        # Update InstalmentDue table
        instalmentdue = InstallmentDue.objects.get(Installment_Due_Id=instalmentid)
        instalmentdue.PaymentRefId = payment.Payment_Id
        instalmentdue.IsInstalmentPaid = 1
        instalmentdue.save()

        product = instalmentdue.OrderDetail.Product.Name

        # Send an email along with invoice
        subject = 'Invoice for your order.'
        fromEmail = settings.EMAIL_HOST_USER
        to_list = [request.user.email]
        html_content = render_to_string("emailpaymentInvoice/InstalmentPaymentInvoice.html", {'username': request.user.username})
        text_content = strip_tags(html_content)
        emailsend = EmailMultiAlternatives(
            subject,
            text_content,
            fromEmail,
            to_list
        )
        address = Address.objects.get(User_Id=request.user.id)
        data = {
            'amount': total,
            'instalmentNum': instalmentNum,
            'username': request.user.username,
            'address': address,
            'product': product,
            'date': datenow,
            'email': request.user.email
        }
        pdf = render_to_pdf('pdffiles/instalmentpaymentinvoice.html', data)

        emailsend.attach('invoice.pdf', pdf, 'file/pdf')

        emailsend.send()

        print('email sent')

    except stripe.error.CardError as e:
        # Since it's a decline, stripe.error.CardError will be caught
        print('Status is: %s' % e.http_status)
        print('Code is: %s' % e.code)
        # param is '' in this case
        print('Param is: %s' % e.param)
        print('Message is: %s' % e.user_message)
        body = e.json_body
        err = body.get('error', {})
        messages.error(request, err.get('message'))
        print('error in payInstalmentDue/CardError', err.get('message'))
        message = err.get('message')
        return JsonResponse({'status': 'false', 'message': message}, safe=False)
    except stripe.error.RateLimitError as e:
        # Too many requests made to the API too quickly
        messages.error(request, "RateLimitError")
        print('Error in payInstalmentDue/ RateLimitError:', str(e))
        message = str(e)
        return JsonResponse({'status': 'false', 'message': message}, safe=False)
    except stripe.error.InvalidRequestError as e:
        # Invalid parameters were supplied to Stripe's API
        messages.error(request, "InvalidRequestError")
        print('Error in payInstalmentDue/InvalidRequestError:', str(e))
        message = str(e)
        print(message)
        return JsonResponse({"status": 'false', "message": message}, safe=False)
        print('after json')
    except stripe.error.AuthenticationError as e:
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
        messages.error(request, "AuthenticationError")
        print('Error in payInstalmentDue/AuthenticationError:', str(e))
        message = str(e)
        return JsonResponse({'status': 'false', 'message': message}, safe=False)
    except stripe.error.APIConnectionError as e:
        # Network communication with Stripe failed
        messages.error(request, "APIConnectionError")
        print('Error in payInstalmentDue/APIConnectionError:', str(e))
        message = str(e)
        return JsonResponse({'status': 'false', 'message': message}, safe=False)
    except stripe.error.StripeError as e:
        # Display a very generic error to the user, and maybe send
        # yourself an email
        messages.error("StripeError")
        print('Error in payInstalmentDue/StripeError:', str(e))
        message = str(e)
        return JsonResponse({'status': 'false', 'message': message}, safe=False)
    except Exception as e:
        print('Error in payInstalmentDue function:', str(e))
        # messages.error(request, "There is some issue while processing order")
    finally:
        connection.close()

    message = 'Payment Completed...!'
    return JsonResponse({'status': 'true', 'message': message}, safe=False)
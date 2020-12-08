from django.contrib import messages
from django.http import JsonResponse
from django.shortcuts import render
from django.template.loader import render_to_string
from django.views.generic import ListView, DetailView, View
import datetime
from django.conf import settings
from django.core.exceptions import ObjectDoesNotExist
from ManorPharmacy.forms import CheckoutForm
from ManorPharmacy.util import *
from adminpanel.models import *
import stripe

stripe.api_key = settings.STRIPE_SECRET_KEY


class Test(ListView):
    model = Product
    template_name = 'webecommerce/test.html'


def index(request):
    context = {}
    return render(request, 'webecommerce/index.html', context)


class IndexView(ListView):
    model = Product
    template_name = 'webecommerce/index.html'

    def get_context_data(self, **kwargs):
        context = super(IndexView, self).get_context_data(**kwargs)
        products = Product.objects.filter(IsProduct=1)
        services = Product.objects.filter(IsProduct=0)
        context['products'] = products
        context['services'] = services
        # FETCH image of dashboard/index page
        context['DashboardImage'] = Configuration.objects.filter(ConfigurationName__icontains='DASHBOARD')
        # Fetch values for Announcement/promotoion/Post.
        context['AnnouncementPost'] = AnnouncementPost.objects.filter(IsActive=1)
        # Fetch Cart Details for customers to display on cart hover.
        orderitems = {}
        if self.request.user.id is not None:
            customer = self.request.user.customer
            try:
                order = Order.objects.get(Customer=customer, IsOrderCompleted=False)
                orderitems = order.orderdetails_set.all()
            except ObjectDoesNotExist:
                order = {}
        context['orderitems'] = orderitems

        return context


def shop(request):
    context = {}
    return render(request, 'webecommerce/shop.html', context)


class ShopView(ListView):
    model = Product
    template_name = 'webecommerce/shop.html'

    def get_context_data(self, **kwargs):
        context = super(ShopView, self).get_context_data(**kwargs)
        allProducts = []
        products = Product.objects.filter(IsProduct=1)
        allProducts.append(products)
        services = Product.objects.filter(IsProduct=0)
        allProducts.append(services)
        context['allProducts'] = allProducts
        # Fetch Cart Details for customers to display on cart hover.
        customer = self.request.user.customer
        try:
            order = Order.objects.get(Customer=customer, IsOrderCompleted=False)
            orderitems = order.orderdetails_set.all()
        except ObjectDoesNotExist:
            order = {}
            orderitems = {}

        context['orderitems'] = orderitems
        # And so on for more models
        return context


def shopByCategory(request):
    # cart items is for displaying the total no of items in the cart (icon).

    allProducts = []
    category = request.POST.get("category")
    if category == "1":
        products = Product.objects.filter(IsProduct=1)
        allProducts.append(products)
    elif category == "2":
        products = Product.objects.filter(IsProduct=0)
        allProducts.append(products)
    else:
        products = Product.objects.filter(IsProduct=1)
        allProducts.append(products)
        services = Product.objects.filter(IsProduct=0)
        allProducts.append(services)
    context = {'allProducts': allProducts}
    html = render_to_string('webecommerce/searchbycategory.html', context)
    return JsonResponse(html, safe=False)


class DetailView(DetailView):
    model = Product
    template_name = 'webecommerce/detail.html'


# Cart view.
def cart(request):
    data = cartData(request)
    cartItems = data['cartItems']
    items = data['items']
    order = data['order']
    discountAmountForFullPayment = getFullPaymentDiscount(order, 'Fulltime Payment')
    totalAmountWithDiscount = order.get_TotalForAllProductPriceAndInitialSetupCharge_WithFullPayment - discountAmountForFullPayment

    context = {'items': items, 'order': order, 'cartItems': cartItems, 'itemCount': len(items),
               'discountAmountForFullPayment': discountAmountForFullPayment,
               'totalAmountWithDiscount': totalAmountWithDiscount}
    return render(request, 'webecommerce/cart.html', context)


def checkout(request):
    STRIPE_PUBLISHABLE_KEY = settings.STRIPE_PUBLISHABLE_KEY

    form = CheckoutForm()
    isPayByInstallment = request.GET.get('data')
    data = cartData(request)
    cartItems = data['cartItems']
    items = data['items']
    order = data['order']
    customerdetail = data['customerdetail']
    currentDate = datetime.datetime.now()
    yearLimit = currentDate.year + 21
    yearList = []
    totalwithDiscount = 0

    # discountAmount = getDiscount(order, 'Fulltime Payment')
    discountAmountForFullPayment = getFullPaymentDiscount(order, 'Fulltime Payment')

    totalAmountWithDiscount = order.get_TotalForAllProductPriceAndInitialSetupCharge_WithFullPayment - discountAmountForFullPayment
    sameHouseHoldCustomerId = customerdetail[11]
    referralCustomerId = customerdetail[12]

    otherReferralDiscount = 0
    sameHouseHoldReferralDiscount = 0
    IsServiceExists = False
    IsProductExists = False
    discountOnProduct = 0
    discountPercentageOnProduct = 0

    for item in items:
        if item.Product.IsDiscountable and item.Product.IsProduct:
            discountPercentageOnProduct += item.Product.DiscountPercentage
        if item.Product.IsProduct:
            IsProductExists = True
        if not item.Product.IsProduct:
            IsServiceExists = True

        # TO DO: Get the discount of Product and calculate it.
        if order.get_CartTotalPriceForAllDiscountableProduct_WithFullPayment > 0:
            discountOnProduct = \
                (order.get_CartTotalPriceForAllDiscountableProduct_WithFullPayment * discountPercentageOnProduct) / 100

        fullDiscountAmount = 0
        if isPayByInstallment == 'no':
            fullDiscountAmount = getFullPaymentDiscount(order, 'Fulltime Payment')
            totalwithDiscount = order.get_TotalForAllProductPriceAndInitialSetupCharge_WithFullPayment - fullDiscountAmount - discountOnProduct
        else:
            totalwithDiscount = order.get_TotalPrice_WithInstallmentPayment - discountOnProduct

    # Customer Personal Discount
    customerPersonalDiscount = customerdetail[14]
    customerPersonalDiscountAmount = 0

    # if customerPersonalDiscount > 0:
    #     customerPersonalDiscountAmount = (totalwithDiscount * customerPersonalDiscount) / 100
    #     print('personal disc', customerPersonalDiscountAmount)
    #     totalwithDiscount = totalwithDiscount - customerPersonalDiscountAmount

    for i in range(currentDate.year, yearLimit):
        yearList.append(i)

    context = {'items': items, 'order': order, 'cartItems': cartItems, 'customerdetail': customerdetail,
               'yearLimit': yearList, 'totalwithDiscount': totalwithDiscount, 'isPayByInstallment': isPayByInstallment,
               'discountOnProduct': discountOnProduct,
               'discountAmountForFullPayment': fullDiscountAmount,
               'customerPersonalDiscountAmount': customerPersonalDiscountAmount,
               'IsServiceExists': IsServiceExists,
               'IsProductExists': IsProductExists,
               'form': form,
               'STRIPE_PUBLISHABLE_KEY': STRIPE_PUBLISHABLE_KEY
               }

    return render(request, 'webecommerce/checkout.html', context)


def placeOrder(request):
    transId = datetime.datetime.now().timestamp()
    # result = callback(request)

    data = json.loads(request.body)
    cookiedata = cartData(request)
    items = cookiedata['items']
    orderFromCookie = cookiedata['order']
    address = data['Shipping']
    paymentInInstalment = data['paymentInInstalment']
    serviceDiscount = data['serviceDiscount']
    serviceDiscountPercentage = data['serviceDiscountPercentage']
    serviceDiscountId = data['serviceDiscountId']

    customer = request.user.customer
    if request.user.is_authenticated:
        order, created = Order.objects.get_or_create(Customer=customer, IsOrderCompleted=False)
        payment, created = Payment.objects.get_or_create(Order=order)
    else:
        customer, order, payment = guestOrder(request, data)
    try:

        total = float(data['User']['total'])
        print('total amt to pay', total)
        print('Actual amt to pay', orderFromCookie.get_CartTotalPriceForInitialSetupAndProduct)
        payment.Amount = total
        payment.Payment_Type = data['paymentType']
        order.Transaction_Id = transId
        order.ActualAmountToPay = orderFromCookie.get_CartTotalPriceForInitialSetupAndProduct
        payment.save()  #
        order.save()  #
        print('order and payment saved.')
        # if data['IsInstallment']:
        #   total = float(order.get_cart_total())

        serviceInstalmentMonth = 0
        if paymentInInstalment == 'yes':
            print('in paymentInInstalment')
            for item in items:
                if not item.Product.IsProduct:
                    if item.TotalNoOfPerson == 1:
                        serviceInstalmentMonth = item.Product.NoOfInstallmentMonths
                        price = item.Product.Price * item.Quantity
                        print('serviceInstalmentMonth', serviceInstalmentMonth)
                        print('price', price)
                        days = 28
                        # Create SP to insert values in database
                        if int(float(serviceDiscount)) > 0:
                            discountAmount = price * int(float(serviceDiscountPercentage)) / 100
                            price = price - discountAmount
                        for i in range(1, serviceInstalmentMonth + 1):
                            if i == 1:
                                days = 14
                            else:
                                days += 28
                            todaysdate = datetime.timedelta(days=days)
                            duedate = datetime.date.today() + todaysdate
                            installment_due = InstallmentDue.objects.create(Order=order)
                            installment_due.Due_Installments = i
                            installment_due.Amount_Due = price
                            installment_due.InstalmentDueDate = duedate
                            installment_due.Customer_Id = customer.Customer_Id
                            installment_due.User_Id = request.user.id
                            installment_due.PaymentRefId = payment.Payment_Id
                            installment_due.save()  #
                            if i == 1:
                                days = 0
                    else:
                        serviceInstalmentMonth = item.Product.NoOfInstallmentMonths
                        price = (item.Product.Price + item.Product.AdditionalMemberPrice) * item.Quantity
                        if int(float(serviceDiscount)) > 0:
                            discountAmount = price * int(float(serviceDiscountPercentage)) / 100
                            price = price - discountAmount
                        for i in range(1, serviceInstalmentMonth + 1):
                            if i == 1:
                                days = 14
                            else:
                                days += 28

                            todaysdate = datetime.timedelta(days=days)
                            duedate = datetime.date.today() + todaysdate
                            installment_due, created = InstallmentDue.objects.get_or_create(Order=order)
                            installment_due.Due_Installments = i
                            installment_due.Amount_Due = price
                            installment_due.InstalmentDueDate = duedate
                            installment_due.Customer_Id = customer.Customer_Id
                            installment_due.User_Id = request.user.id
                            installment_due.PaymentRefId = payment.Payment_Id
                            installment_due.save()  #
                            if i == 1:
                                days = 0
                    if int(float(serviceDiscount)) > 0:
                        order.ServiceDiscountAmount = serviceDiscount
                        order.ServiceDiscountCode = serviceDiscountId
        else:
            fullDiscountAmount = getFullPaymentDiscount(order, 'Fulltime Payment')
            order.FullPaymentDiscountAmount = fullDiscountAmount

        try:
            # Payment Integration
            token = data['token']  # request.POST.get("stripeToken")
            paymentDescription = 'Payment Done by ' + data['User']['name']
            charge = stripe.Charge.create(
                amount=int(total * 100),
                currency="gbp",
                source=token,
                description=paymentDescription
            )
            print('create customer')
            message = ""

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
            print('error1', err.get('message'))
            message = err.get('message')
            return JsonResponse({'status': 'false', 'message': message}, safe=False)
        except stripe.error.RateLimitError as e:
            # Too many requests made to the API too quickly
            messages.error(request, "RateLimitError")
            print('error2')
            print('Error Is:', str(e))
            message = str(e)
            return JsonResponse({'status': 'false', 'message': message}, safe=False)
        except stripe.error.InvalidRequestError as e:
            # Invalid parameters were supplied to Stripe's API
            messages.error(request, "InvalidRequestError")
            print('error3')
            print('Error Is:', str(e))
            message = str(e)
            print(message)
            return JsonResponse({"status": 'false', "message": message}, safe=False)
            print('after json')
        except stripe.error.AuthenticationError as e:
            # Authentication with Stripe's API failed
            # (maybe you changed API keys recently)
            messages.error(request, "AuthenticationError")
            print('error4')
            print('Error Is:', str(e))
            message = str(e)
            return JsonResponse({'status': 'false', 'message': message}, safe=False)
        except stripe.error.APIConnectionError as e:
            # Network communication with Stripe failed
            messages.error(request, "APIConnectionError")
            print('error5')
            print('Error Is:', str(e))
            message = str(e)
            return JsonResponse({'status': 'false', 'message': message}, safe=False)
        except stripe.error.StripeError as e:
            # Display a very generic error to the user, and maybe send
            # yourself an email
            messages.error("StripeError")
            print('error6')
            print('Error Is:', str(e))
            message = str(e)
            return JsonResponse({'status': 'false', 'message': message}, safe=False)
        except Exception as e:
            # Something else happened, completely unrelated to Stripe
            messages.error(request, "Error in Code")
            print('error7')
            print('Error Is:', str(e))
            message = str(e)
            return JsonResponse({'status': 'false', 'message': message}, safe=False)

        print('Change the quantity')
        # Deduct the quantity of the product after purchasing.
        for item in items:
            if item.Product.IsProduct:
                print('qty b4 deduction', item.Product.StockLevel)
                qty = item.Product.StockLevel - item.Quantity
                print('qty after deduction', qty)
                print('product id is', item.Product.Product_Id)
                product = Product.objects.get(Product_Id=item.Product.Product_Id)
                print(product)
                product.StockLevel = qty
                product.save()  #

        # store details in OrderDiscount Table

        if int(float(serviceDiscount)) > 0:
            order_discount, created = OrderDiscount.objects.get_or_create(Order=order)
            order_discount.DiscountType_Id = serviceDiscountId
            order_discount.save()  #
            print('order discount saved')
            # store details in CustomerDiscount Table
            print('serviceDiscountId', serviceDiscountId)

            orderdiscount = OrderDiscount.objects.filter(DiscountType_Id=serviceDiscountId)

            # if order discount is not null then count the customer with the orderid in order table.
            # set the initial customer discount eligibility as below
            customerDiscountApplicableLimit = serviceInstalmentMonth
            # Based on the count update the  customerDiscountApplicableLimit value.
            customer_discount, created = \
                CustomerDiscountEligibility.objects.get_or_create(Customer=customer,
                                                                  Customer_id=customer.Customer_Id,
                                                                  DiscountType_Id=serviceDiscountId)
            customer_discount.DiscountType_Id = serviceDiscountId
            customer_discount.DiscountApplicableLimit = customerDiscountApplicableLimit
            customer_discount.IsUsed = 1
            # if the count from the above is == DiscountApplicableLimit then update the IsUsed flag.
            customer_discount.save()  #
            print('Customer discount saved')

        print('save order table')
        order.IsOrderCompleted = True
        # Set current date for order completion date
        order.OrderStatus_id = 1
        order.save()

        # subject = 'Invoice for your order.'
        #  fromEmail = settings.EMAIL_HOST_USER
        # to_list = [data['User']['email']]
        # try:
        #     html_content = render_to_string("emailInvoice/InvoiceContent.html", {'username': data['User']['name']})
        #     text_content = strip_tags(html_content)
        #     emailsend = EmailMultiAlternatives(
        #         subject,
        #         text_content,
        #         fromEmail,
        #         to_list
        #     )
        #     data = {
        #         'items': items,
        #         'order': order,
        #         'username': data['User']['name'],
        #         'address': address,
        #         'email': data['User']['email']
        #     }
        #     # emailsend.attach_alternative(html_content, "text/html")
        #     # pdf = render_to_pdf('pdf/invoice.html', data)
        #     # emailsend.attach('invoice.pdf', pdf, 'file/pdf')
        #     # emailsend.send()
        #
        #     print('email sent')
        # except Exception as e:
        #     print('in catch for email send')
        #     print('Error Is:', str(e))
        #     messages.error(request, "There is some issue while generating pdf")
        payment.Is_Invoice_Sent = True
        payment.save()
        print('Invoice sent')
    except Exception as e:
        print('Error Is:', str(e))
        # messages.error(request, "There is some issue while processing order")
    finally:
        connection.close()
    print('completed')
    # return redirect('manor')
    message = 'Payment Completed...!'
    return JsonResponse({'status': 'true', 'message': message}, safe=False)
    # return HttpResponse('Payment Completed...!', mimetype='text/json')


class ThankYouView(ListView):
    model = Product
    template_name = 'webecommerce/thankyou.html'

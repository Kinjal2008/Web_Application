from math import ceil

from django.contrib.sites.models import Site
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.contrib import messages
import datetime
from django.db.models.functions import Concat
from gateway.tphelperdev import getVars, getHashDigest, generateHashDigest
from gateway.viewsdev import callback, callbackForPayment
from .filters import ProductFilter
from .util import *
from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.views.generic import DetailView
from functools import reduce
from django.db.models import Q


def manorpharmacy(request):
    # cart items is for displaying the total no of items in the cart (icon).
    data = cartData(request)
    cartItems = data['cartItems']

    allProducts = []
    catProducts = Product.objects.values('Category_id')

    category = {item['Category_id'] for item in catProducts}

    for cat in category:
        prod = Product.objects.filter(Category_id=cat)
        n = len(prod)
        nslides = n // 3 + ceil((n / 3) - (n // 3))
        allProducts.append([prod, range(1, nslides), nslides])

    context = {'cartItems': cartItems,
               'allProds': allProducts}

    return render(request, 'manorpharmacy/manor.html', context)


def productByCategory(request):
    # cart items is for displaying the total no of items in the cart (icon).
    print('Product by cat')
    data = cartData(request)
    cartItems = data['cartItems']
    products = Product.objects.all()
    category = request.POST.get("category")
    if category == "1":
        products = Product.objects.filter(IsProduct=1)
    elif category == "2":
        products = Product.objects.filter(IsProduct=0)
    context = {'products': products, 'cartItems': cartItems}
    html = render_to_string('manorpharmacy/search.html', context)
    return JsonResponse(html, safe=False)


def search(request):
    print('in search')
    data = cartData(request)
    cartItems = data['cartItems']
    str = request.POST.get("search")
    if str is None:
        str = ''
    allProducts = []
    catProducts = Product.objects.values('Category_id')
    category = {item['Category_id'] for item in catProducts}
    for cat in category:
        print('before for')
        prod = Product.objects.filter(Category_id=cat).filter(Name__icontains=str)
        print(prod)
        print('after for')
        n = len(prod)
        print(n)
        nslides = n // 3 + ceil((n / 3) - (n // 3))
        if nslides == 0:
            nslides = 1
        allProducts.append([prod, range(1, nslides), nslides])
    print(allProducts)
    context = {'cartItems': cartItems,
               'allProds': allProducts}

    filteredProd = Product.objects.filter(Name__icontains=str)
    # context = {'products': filteredProd, 'cartItems': cartItems}
    return render(request, 'manorpharmacy/search.html', context)


# Cart view.
def cart(request):
    data = cartData(request)
    cartItems = data['cartItems']
    items = data['items']
    order = data['order']
    print('items', order)
    print(order.get_CartTotalPriceForInitialSetupAndProduct)
    print(len(items))
    context = {'items': items, 'order': order, 'cartItems': cartItems, 'itemCount': len(items)}
    return render(request, 'manorpharmacy/cart.html', context)


# Checkout view.
def checkout(request):
    data = cartData(request)
    cartItems = data['cartItems']
    items = data['items']
    order = data['order']
    customerdetail = data['customerdetail']

    # discountAmount = getDiscount(order, 'Fulltime Payment')
    discountAmountForFullPayment = getFullPaymentDiscount(order, 'Fulltime Payment')
    print(discountAmountForFullPayment)
    totalAmountWithDiscount = order.get_TotalForAllProductPriceAndInitialSetupCharge_WithFullPayment - discountAmountForFullPayment
    sameHouseHoldCustomerId = customerdetail[11]
    referralCustomerId = customerdetail[12]

    otherReferralDiscount = 0
    sameHouseHoldReferralDiscount = 0
    # Remove this code
    # if sameHouseHoldCustomerId is not None:
    #     print('in same house')
    #     sameHouseHoldReferralDiscount = getDiscount(order, 'Within Family', id)
    # if referralCustomerId is not None:
    #     otherReferralDiscount = getDiscount(order, 'Other Client', id)

    context = {'items': items, 'order': order, 'cartItems': cartItems, 'customerdetail': customerdetail,
               'sameHouseHoldReferralDiscount': sameHouseHoldReferralDiscount,
               'otherReferralDiscount': otherReferralDiscount,
               'discountAmountForFullPayment': discountAmountForFullPayment,
               'totalAmountWithDiscount': totalAmountWithDiscount}
    return render(request, 'manorpharmacy/checkout.html', context)


def payment(request):
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

    # For Payment gateway default values.
    index_context = getVars()
    index_context.update({'merch_hashdigest': getHashDigest(index_context)})
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
        discountOnProduct = (order.get_CartTotalPriceForAllDiscountableProduct_WithFullPayment * discountPercentageOnProduct) / 100

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

    print('final amount after all disc', totalwithDiscount)

    for i in range(currentDate.year, yearLimit):
        yearList.append(i)

    context = {'items': items, 'order': order, 'cartItems': cartItems, 'customerdetail': customerdetail,
               'yearLimit': yearList, 'totalwithDiscount': totalwithDiscount, 'isPayByInstallment': isPayByInstallment,
               'discountOnProduct': discountOnProduct,
               'discountAmountForFullPayment': fullDiscountAmount,
               'customerPersonalDiscountAmount': customerPersonalDiscountAmount,
               'IsServiceExists': IsServiceExists,
               'IsProductExists': IsProductExists,
               'index_context': index_context
               }
    return render(request, 'manorpharmacy/ordersummary.html', context)


def updateCartItem(request):
    data = json.loads(request.body)
    productId = data['ProductId']
    action = data['action']
    noofuser = data['noofuser']
    print('in updateCartItem')
    customer = request.user.customer

    product = Product.objects.get(Product_Id=productId)
    order, created = Order.objects.get_or_create(Customer=customer, IsOrderCompleted=False)
    orderdetail, created = OrderDetails.objects.get_or_create(Order=order, Product=product)
    print('noofuser', noofuser)

    if int(noofuser) > 0:
        orderdetail.TotalNoOfPerson = noofuser

    if action == 'add':
        orderdetail.Quantity = (orderdetail.Quantity + 1)
    elif action == 'remove':
        orderdetail.Quantity = (orderdetail.Quantity - 1)

    orderdetail.save()

    if orderdetail.Quantity <= 0:
        orderdetail.delete()

    return JsonResponse('Item was added.', safe=False)


def processOrder(request):
    print('in Process order')
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
    print('serviceDiscountId')
    print(serviceDiscountId)
    print('serviceDiscount', serviceDiscount)
    print('serviceDiscountPercentage', serviceDiscountPercentage)
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

        # if data['IsInstallment']:
        # total = float(order.get_cart_total())
        payment.save()

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
                            print('in discount> 0')
                            discountAmount = price * int(float(serviceDiscountPercentage)) / 100
                            print('discountAmount', discountAmount)
                            price = price - discountAmount
                            print('direct discount amount', price)
                        for i in range(1, serviceInstalmentMonth + 1):
                            if i == 1:
                                days = 14
                            else:
                                days += 28
                            print('after if condition days', days)
                            todaysdate = datetime.timedelta(days=days)
                            duedate = datetime.date.today() + todaysdate
                            print(duedate)
                            print('userid', request.user.id)
                            installment_due = InstallmentDue.objects.create(Order=order)
                            installment_due.Due_Installments = i
                            installment_due.Amount_Due = price
                            installment_due.InstalmentDueDate = duedate
                            installment_due.Customer_Id = customer.Customer_Id
                            installment_due.User_Id = request.user.id
                            installment_due.PaymentRefId = payment.Payment_Id
                            installment_due.save()
                            if i == 1:
                                days = 0
                    else:
                        serviceInstalmentMonth = item.Product.NoOfInstallmentMonths
                        price = (item.Product.Price + item.Product.AdditionalMemberPrice) * item.Quantity
                        if int(float(serviceDiscount)) > 0:
                            discountAmount = price * int(float(serviceDiscountPercentage))  / 100
                            price = price - discountAmount
                        for i in range(1, serviceInstalmentMonth + 1):
                            print(i)
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
                            installment_due.save()
                            if i == 1:
                                days = 0
                    if int(float(serviceDiscount)) > 0:
                        order.ServiceDiscountAmount = serviceDiscount
                        order.ServiceDiscountCode = serviceDiscountId
        else:
            fullDiscountAmount = getFullPaymentDiscount(order, 'Fulltime Payment')
            order.FullPaymentDiscountAmount = fullDiscountAmount

        # store details in OrderDiscount Table

        if int(float(serviceDiscount)) > 0:

            order_discount, created = OrderDiscount.objects.get_or_create(Order=order)
            order_discount.DiscountType_Id = serviceDiscountId
            order_discount.save()
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
            customer_discount.save()
            print('Customer discount saved')

        print('save order table')
        order.IsOrderCompleted = True
        order.save()
        payment.Is_Invoice_Sent = True
        payment.save()
        print('after remaining amount')

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

    except Exception as e:
        print('Error Is:', str(e))
        messages.error(request, "There is some issue while processing order")
    finally:
        connection.close()
    print('completed')
    # return redirect('manor')

    return JsonResponse('Payment Completed...!', safe=False)
    # return HttpResponse('Payment Completed...!', mimetype='text/json')


def updateTotal(request):
    print('in update total')
    data = cartData(request)
    customer = request.user.customer
    order = data['order']
    total = order.get_cart_fullpayment_total
    print(total)

    data1 = json.loads(request.body)
    installment_type = data1['InstallmentType']
    print(installment_type)

    return JsonResponse('Total changed.', safe=False)


def applyDiscount(request):
    cookiedata = cartData(request)
    order = cookiedata['order']
    print('in apply discount')
    cursor = connection.cursor()
    customerId = request.user.customer.Customer_Id

    str = request.POST.get("discountCode")
    id = request.user.customer.Customer_Id
    print('customerid')
    print(id)
    print(str)
    amountToPay = request.POST.get("totalAmount")
    cursor.callproc('GetDiscountByName', [str, id])
    discountTYpe = cursor.fetchone()
    print('amountToPay', amountToPay)
    print(discountTYpe)
    discountCodeAmout = (float(amountToPay) * discountTYpe[2]) / 100
    amountAfterDiscount = float(amountToPay) - discountCodeAmout
    print('Amount to pay', amountAfterDiscount)
    return JsonResponse({"discountCodeAmout": discountCodeAmout, "amountAfterDiscount": amountAfterDiscount,
                         "discountPercentage": discountTYpe[2], 'id': discountTYpe[0]}, safe=False)


def applyDiscountOnProduct(request):
    print('apply discount on product')
    cookiedata = cartData(request)
    order = cookiedata['order']
    str = request.POST.get("discountCode")
    id = request.user.customer.Customer_Id
    print('customerid')
    print(id)
    amountToPay = request.POST.get("totalAmount")
    productTotalAmount = request.POST.get("totalProductAmount")
    print('str', str)
    print('amountToPay', amountToPay)
    print('productTotalAmount', productTotalAmount)
    cursor = connection.cursor()
    cursor.callproc('GetDiscountByName', [str, id])
    discountTYpe = cursor.fetchone()
    print('amountToPay', amountToPay)
    print(discountTYpe[2])
    discountCodeAmout = (float(productTotalAmount) * discountTYpe[2]) / 100
    amountAfterDiscount = float(amountToPay) - discountCodeAmout
    print('Amount to pay', amountAfterDiscount)
    return JsonResponse({"discountCodeAmout": discountCodeAmout, "amountAfterDiscount": amountAfterDiscount,
                         "discountPercentage": discountTYpe[2]}, safe=False)


def sendReferralEmail(request):
    print('in send email')
    subject = 'Reference Code'
    fromEmail = settings.EMAIL_HOST_USER
    to_list = [request.POST.get("email")]
    referral_name = request.POST.get("name")
    cursor = connection.cursor()
    cursor.callproc('GetReferralDiscountCode')
    discount = cursor.fetchone()
    discountCode = discount[1]
    current_site = Site.objects.get_current()

    site = str(current_site) + 'register/' + '?id=' + str(request.user.id)
    print(site)
    html_content = render_to_string("emailInvoice/customerReferenceTemplate.html", {'username': request.user,
                                                                                    'discountCode': discountCode,
                                                                                    'site': site,
                                                                                    'referralname': referral_name})
    text_content = strip_tags(html_content)
    email_send = EmailMultiAlternatives(
        subject,
        text_content,
        fromEmail,
        to_list
    )
    message = ""
    email_send.attach_alternative(html_content, "text/html")
    try:
        print('in TRY for email sent')
        email_send.send()
        message = "Success"
    except Exception as e:
        print('Error Is:', str(e))
        message = "Failed"
    print('email sent')

    return JsonResponse(message, safe=False)

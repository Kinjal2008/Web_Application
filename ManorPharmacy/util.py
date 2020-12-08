from django.template import Context

from adminpanel.models import *
from django.db import connection
import json
from django.template.loader import get_template, render_to_string
from io import BytesIO, StringIO
from django.http import HttpResponse
from xhtml2pdf import pisa


def getCookieForCart(request):
    print('IN GET COOKIE FROM CART')
    try:
        print('in TRY')
        cart = json.loads(request.COOKIES['cart'])
        print(cart)
    except:
        cart = {}

    print('Cart from cookie: ', cart)
    items = []
    order = {'get_cart_fullpayment_total': 0, 'get_TotalCartItems': 0}
    cartItems = order['get_TotalCartItems']

    for i in cart:
        try:
            cartItems += cart[i]["Quantity"]

            product = Product.objects.get(Product_Id=i)
            total = (product.Price * cart[i]["Quantity"])

            order['get_cart_fullpayment_total'] += total
            order['get_TotalCartItems'] += cart[i]["Quantity"]
            print('Products is')
            print(product)
            print('Order is')
            print(order)
            item = {
                'Product': {
                    'Product_Id': product.Product_Id,
                    'Name': product.Name,
                    'Code': product.Code,
                    'Description': product.Description,
                    'Price': product.Price,
                    'Image': product.Image
                },
                'Quantity': cart[i]["Quantity"],
                'get_total': total
            }
            items.append(item)
            print(item)
        except:
            pass
    return {'items': items, 'order': order, 'cartItems': cartItems}


def cartData(request):

    if request.user.is_authenticated:
        customer = request.user.customer
        order, created = Order.objects.get_or_create(Customer=customer, IsOrderCompleted=False)
        items = order.orderdetails_set.all()
        cartItems = order.get_TotalCartItems
        cursor = connection.cursor()
        cursor.callproc('GetCustomerDetailsByUserId', [request.user.id])
        customerdetail = cursor.fetchone()
    else:
        cookieData = getCookieForCart(request)
        cartItems = cookieData['cartItems']
        items = cookieData['items']
        order = cookieData['order']
        customerdetail = {}

    return {'items': items, 'order': order, 'cartItems': cartItems,
            'customerdetail': customerdetail}


def getFullPaymentDiscount(order, str):

    cursor = connection.cursor()
    cursor.callproc('GetDiscountByName', [str, 0])
    discountTYpe = cursor.fetchone()

    items = order.orderdetails_set.all()

    discountAmout = (order.get_PercentageAmount_WithFullPayment * discountTYpe[2]) / 100
    return discountAmout


def getDiscount(order, str, id):

    cursor = connection.cursor()

    cursor.callproc('GetDiscountByName', [str, id])
    discountTYpe = cursor.fetchone()
    items = order.orderdetails_set.all()

    discountAmout = (order.get_TotalForAllProductPriceAndInitialSetupCharge_WithFullPayment * discountTYpe[2]) / 100
    return discountAmout


def guestOrder(request, data):
    print('User is not logged in')
    print('COOKIES')
    name = data['User']['Name']
    email = data['User']['Email']

    cookieData = getCookieForCart(request)
    items = cookieData['items']

    customer, created = Customer.objects.get_or_create(email=email)
    customer.First_Name = name
    customer.save()

    order = Order.objectc.create(
        Customer=customer,
        IsOrderComplated=False
    )

    for item in items:
        product = Product.objects.get(Product_Id=item['Product']['Product_Id'])
        orderDetail = OrderDetails.objects.create(
            Product=product,
            Order=order,
            Quantity=item['Quantity']
        )

    return customer, order


def render_to_pdf(template_src, context_dict={}):
    template = get_template(template_src)
    html = template.render(context_dict)
    result = BytesIO()
    pdf = pisa.pisaDocument(BytesIO(html.encode("ISO-8859-1")), result)
    if not pdf.err:
        return result.getvalue()
        # return HttpResponse(result.getvalue(), content_type='application/pdf')
    return None



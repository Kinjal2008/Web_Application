from django.contrib.auth.decorators import login_required
from django.http import JsonResponse

from adminpanel.CustomUserDecorator import CustomDecorator
from django.db import connection
from django.shortcuts import render, redirect
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage

from adminpanel.models import *


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['admin', 'superadmin'])
def OrderSummary(request):
    print('in order summary')
    cursor = connection.cursor()
    cursor.callproc('GetPaymentOrderSummary')
    results = cursor.fetchall()
    page = request.GET.get('page', 1)
    paginator = Paginator(results, 10)
    try:
        orderDetails = paginator.page(page)
    except PageNotAnInteger:
        orderDetails = paginator.page(1)
    except EmptyPage:
        orderDetails = paginator.page(paginator.num_pages)
    print(orderDetails)
    context = {"paymentorder": orderDetails}
    return render(request, "adminpanel/reports/OrderSummaryReport.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['admin', 'superadmin'])
def OrderDetails(request):
    print('in order details')
    cursor = connection.cursor()
    cursor.callproc('GetOrderDetailsReportResult')
    results = cursor.fetchall()
    print(results)
    page = request.GET.get('page', 1)
    paginator = Paginator(results, 10)
    try:
        orderDetails = paginator.page(page)
    except PageNotAnInteger:
        orderDetails = paginator.page(1)
    except EmptyPage:
        orderDetails = paginator.page(paginator.num_pages)
    print(orderDetails)
    context = {"paymentorder": orderDetails}
    return render(request, "adminpanel/reports/OrderDetailsReport.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['admin', 'superadmin'])
def searchOrderDetails(request):
    print('in order details')
    cursor = connection.cursor()
    fromDate = request.POST.get("dateFrom")
    toDate = request.POST.get("dateTo")
    print('fromDate', fromDate)
    print('toDate', toDate)
    cursor.callproc('GetOrderDetailsSearchResult', [fromDate, toDate])
    results = cursor.fetchall()
    print(results)

    context = {"paymentorder": results}
    return render(request, "adminpanel/reports/OrderDetailsSearch.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['admin', 'superadmin'])
def ReportByClient(request):
    cursor = connection.cursor()
    cursor.callproc('GetOrderDetailsReportResult')
    results = cursor.fetchall()
    page = request.GET.get('page', 1)
    paginator = Paginator(results, 10)
    try:
        orderDetails = paginator.page(page)
    except PageNotAnInteger:
        orderDetails = paginator.page(1)
    except EmptyPage:
        orderDetails = paginator.page(paginator.num_pages)

    context = {"paymentorder": orderDetails}
    return render(request, "adminpanel/reports/OrderDetailReportByClient.html", context)


def searchClientOrders(request):
    print('IN searchClientOrders')
    cursor = connection.cursor()
    clientName = request.POST.get("txtSearchByClientName")
    print(str(clientName))
    cursor.callproc('GetOrderDetailsReportByClientResult', [clientName])
    orderDetails = cursor.fetchall()

    print(orderDetails)
    context = {"paymentorder": orderDetails}
    return render(request, 'adminpanel/reports/OrderDetailsByClientSearch.html', context)
    # return JsonResponse({"result": orderDetails}, safe=False)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['admin', 'superadmin'])
def ReportByProduct(request):
    print('in order details')
    cursor = connection.cursor()
    cursor.callproc('GetPaymentOrderSummary')
    results = cursor.fetchall()
    print(results)
    products = Product.objects.filter(IsProduct=1)
    services = Product.objects.filter(IsProduct=0)
    page = request.GET.get('page', 1)
    paginator = Paginator(results, 10)
    try:
        orderDetails = paginator.page(page)
    except PageNotAnInteger:
        orderDetails = paginator.page(1)
    except EmptyPage:
        orderDetails = paginator.page(paginator.num_pages)
    print(orderDetails)
    context = {"paymentorder": orderDetails, "products": products, "services": services}
    return render(request, "adminpanel/reports/OrderDetailReportByProduct.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['admin', 'superadmin'])
def searchProductOrders(request):
    print('IN searchProductOrders')
    cursor = connection.cursor()
    productId = int(request.POST.get("searchByProduct"))

    print(productId)
    cursor.callproc('GetOrderDetailsReportByProductResult', [productId])
    orderDetails = cursor.fetchall()
    print(orderDetails)

    context = {"paymentorder": orderDetails}
    return render(request, 'adminpanel/reports/OrderDetailsByProductSearch.html', context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['admin', 'superadmin'])
def orderDetails_Viewdetails(request, id):
    try:
        order = Order.objects.get(Order_Id=id)
        orderitems = order.orderdetails_set.all()
        userid = request.user.id
        address = Address.objects.filter(User_Id=userid)
        totalinstalments = InstallmentDue.objects.filter(Order_id=id)

    except ConnectionError as e:
        print('ERROR in orderDetails_Viewdetails function: ')
        print(format(e))

    return render(request, "adminpanel/reports/OrderDetailReport_Details.html", {'totalinstalment': totalinstalments,
                                                                      'orderitems': orderitems,
                                                                      'order': order,
                                                                      'address': address})


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['admin', 'superadmin'])
def searchForOrderDetails(request):
    print('IN SEARCH')
    cursor = connection.cursor()
    clientName = request.POST.get("clientName")
    productId = int(request.POST.get("productId"))
    serviceId = int(request.POST.get("serviceId"))
    print(clientName)
    print(productId)
    print(serviceId)

    cursor.callproc('GetOrderDetailsReportResult', [clientName, productId, serviceId])
    results = cursor.fetchall()
    print(results)
    page = request.GET.get('page', 1)
    paginator = Paginator(results, 10)
    try:
        orderDetails = paginator.page(page)
    except PageNotAnInteger:
        orderDetails = paginator.page(1)
    except EmptyPage:
        orderDetails = paginator.page(paginator.num_pages)
    print(orderDetails)
    context = {"paymentorder": orderDetails}
    return JsonResponse({"result": context}, safe=False)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['admin', 'superadmin'])
def ShippedOrders(request):
    print('in ShippedOrders')
    cursor = connection.cursor()
    cursor.callproc('GetShippedOrders')
    results = cursor.fetchall()
    print(results)
    page = request.GET.get('page', 1)
    paginator = Paginator(results, 10)
    try:
        shippedOrders = paginator.page(page)
    except PageNotAnInteger:
        shippedOrders = paginator.page(1)
    except EmptyPage:
        shippedOrders = paginator.page(paginator.num_pages)
    print(shippedOrders)
    context = {"shippedOrders": shippedOrders}
    return render(request, "adminpanel/reports/ShippedOrders.html", context)

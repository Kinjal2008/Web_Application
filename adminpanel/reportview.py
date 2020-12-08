from django.contrib.auth.decorators import login_required
from adminpanel.CustomUserDecorator import CustomDecorator
from django.db import connection
from django.shortcuts import render, redirect


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['admin'])
def OrderSummary(request):
    print('in order summary')
    cursor = connection.cursor()
    cursor.callproc('GetPaymentOrderSummary')
    results = cursor.fetchall()
    print(results)
    context = {"paymentorder": results}
    return render(request, "adminpanel/reports/OrderSummaryReport.html", context)

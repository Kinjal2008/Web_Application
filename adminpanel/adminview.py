from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.shortcuts import render, redirect
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from django.views.generic import ListView

from adminpanel.adminform import *
from adminpanel.models import *
from django.db import connection
from django.db.utils import OperationalError

from django.contrib.auth.decorators import login_required
from adminpanel.CustomUserDecorator import CustomDecorator
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
import json


@login_required(login_url='Login')
def home(request):
    group_name = None
    print('in  adminview home')
    if request.user.groups.values_list('name', flat=True).exists():
        group_name = request.user.groups.all()[0].name
    if group_name.lower() == 'client':
        return redirect('index')
    return render(request, "adminpanel/home_content.html")


@login_required(login_url='Login')
# @CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
@CustomDecorator.admin_only
def dashboard(request):
    # context = {"customer_list": Customer.objects.all()}
    print('IN DASHBOARD')
    return render(request, "admin/index.html")


@login_required(login_url='Login')
def DashboardHome(request):

    cursor = connection.cursor()
    cursor.execute("call GetProductStockDetails()")
    products = cursor.fetchall()
    print('Product Qty WIse', products)

    cursor.execute("call GetLatestOrders()")
    latestOrder = cursor.fetchall()

    context = {"products": products, 'latestOrder': latestOrder}
    return render(request, "adminpanel/dashboardhome.html", context)


@login_required(login_url='Login')
def customer_list(request):
    # context = {"customer_list": Customer.objects.all()}

    cursor = connection.cursor()
    cursor.execute("call GetCustomerList()")
    results = cursor.fetchall()
    context = {"customer_list": results}
    return render(request, "adminpanel/customer/customerlist.html", context)


@login_required(login_url='Login')
def customer_operation_sp(request, id=0):
    if request.method == "GET":
        if id == 0:
            customer = CustomerForm()
        else:
            try:
                cursor = connection.cursor()
                cursor.callproc('GetCustomerDetailsById', [id])
                customer = cursor.fetchone()
                print(customer)
                # Customer output = ('John', 'Peter', 'john@gmail.com', '1234567898', 'Male')
            except ConnectionError as e:
                print('ERROR IS: ')
                print(format(e))
            finally:
                cursor.close()
        return render(request, "adminpanel/customer/customeroperation.html", {'form': customer})
    else:
        if id == 0:
            print('ID = 0')
            form = CustomerForm(request.POST)
        else:
            print('POST REQ')
            customer = Customer.objects.get(pk=id)
            form = CustomerForm(request.POST, instance=customer)
        if form.is_valid():
            form.save()
        else:
            print('There is an error')
        return redirect('/Customer')


@login_required(login_url='Login')
def customer_operation(request, id=0):
    if request.method == "GET":
        if id == 0:
            form = CustomerForm()
        else:
            customer = Customer.objects.get(pk=id)
            form = CustomerForm(instance=customer)
        return render(request, "adminpanel/customer/customeroperation.html", {'form': form})
    else:
        if id == 0:
            form = CustomerForm(request.POST)
        else:
            customer = Customer.objects.get(pk=id)
            form = CustomerForm(request.POST, instance=customer)
        if form.is_valid():
            form.save()
        return redirect('/Customer')


@login_required(login_url='Login')
def customer_delete(request, id):
    customer = Customer.objects.get(pk=id)
    customer.delete()
    return redirect('/Customer')


@login_required(login_url='Login')
def customerOrder(request, id=0):
    cursor = connection.cursor()
    print('customer order')
    print('Orders', id)
    cursor.callproc('GetPlanListByCustomerId', [id])
    results = cursor.fetchall()
    print(results)
    context = {"plans": results}
    return render(request, "adminpanel/customer/customerorders.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def discount_list(request):
    cursor = connection.cursor()
    cursor.execute("call GetDiscountTypeList()")
    results = cursor.fetchall()
    context = {"discount_list": results}
    return render(request, "adminpanel/discount/discountlist.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def discount_operation(request, id=0):
    if request.method == "GET":
        if id == 0:
            discount = DiscountTypeForm()
        else:
            # disc = DiscountType.objects.get(pk=id)
            # form = DiscountTypeForm(instance=disc)
            try:
                cursor = connection.cursor()
                cursor.callproc('GetDiscountTypeById', [id])
                discount = cursor.fetchone()
            except ConnectionError as e:
                print('ERROR IS: ')
                print(format(e))
            finally:
                cursor.close()
        return render(request, "adminpanel/discount/discountoperation.html", {'form': discount})
    else:
        if id == 0:
            form = DiscountTypeForm(request.POST)
        else:
            disc = DiscountType.objects.get(pk=id)
            form = DiscountTypeForm(request.POST, instance=disc)
        try:
            if form.is_valid():
                form.save()
            else:
                print(form.errors)
        except OperationalError as e:
            print(format(e))
        return redirect('/Discount')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def discount_delete(request, id):
    disc = DiscountType.objects.get(pk=id)
    disc.delete()
    return redirect('/Discount')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def product_list(request):
    cursor = connection.cursor()
    cursor.execute("call GetProductDetails()")
    results = cursor.fetchall()
    page = request.GET.get('page', 1)
    paginator = Paginator(results, 5)
    print('results', results)
    print(page)
    print(paginator)
    try:
        products = paginator.page(page)
    except PageNotAnInteger:
        products = paginator.page(1)
    except EmptyPage:
        products = paginator.page(paginator.num_pages)
    print('product result', products)
    context = {"product_list": products}
    return render(request, "adminpanel/product/productlist.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def product_operation(request, id=0):
    categories = Category.objects.all()
    if request.method == "GET":
        if id == 0:
            product = ProductTypeForm()
        else:
            try:
                cursor = connection.cursor()
                cursor.callproc('GetProductById', [id])
                product = cursor.fetchone()
            except ConnectionError as e:
                print('ERROR IS: ')
                print(format(e))
            finally:
                cursor.close()
        return render(request, "adminpanel/product/productoperation.html", {'form': product, 'categories': categories})
    else:
        if id == 0:
            form = ProductTypeForm(request.POST, request.FILES)
        else:
            prod = Product.objects.get(pk=id)
            IsProduct = request.POST.get("IsProduct")
            form = ProductTypeForm(request.POST, request.FILES, instance=prod)
        if form.is_valid():
            prod = form.save()
            prod.IsProduct = 1
            prod.save()
        else:
            print('Issue with Saving Product.')
        return redirect('/Product')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin'])
def product_delete(request, id):
    prod = Product.objects.get(pk=id)
    prod.delete()
    return redirect('/Product')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def service_list(request):
    cursor = connection.cursor()
    cursor.execute("call GetServiceDetails()")
    results = cursor.fetchall()
    context = {"service_list": results}
    return render(request, "adminpanel/service/servicelist.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def service_operation(request, id=0):
    categories = Category.objects.all()
    if request.method == "GET":
        if id == 0:
            service = ServiceTypeForm()
        else:
            try:
                cursor = connection.cursor()
                cursor.callproc('GetProductById', [id])
                service = cursor.fetchone()
            except ConnectionError as e:
                print('ERROR IS: ')
                print(format(e))
            finally:
                cursor.close()
        return render(request, "adminpanel/service/serviceoperation.html", {'form': service, 'categories': categories})
    else:
        if id == 0:
            print('id = 0')
            form = ServiceTypeForm(request.POST, request.FILES)
            print('form is', form)
        else:
            service = Product.objects.get(pk=id)
            form = ServiceTypeForm(request.POST, request.FILES, instance=service)
        if form.is_valid():
            print('form is valid')
            Service = form.save()
            Service.IsProduct = 0
            Service.save()
        else:
            print('Issue with Saving Service.')
        return redirect('/Service')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin'])
def service_delete(request, id):
    service = Product.objects.get(pk=id)
    service.delete()
    return redirect('/Service')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def installment_list(request):
    # context = {"installment_list": InstallmentType.objects.all().order_by('-Installment_Type')}
    cursor = connection.cursor()
    cursor.execute("call GetInstallmentType()")
    results = cursor.fetchall()
    context = {"installment_list": results}
    return render(request, "adminpanel/installment/installmentlist.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def installment_operation(request, id=0):
    if request.method == "GET":
        if id == 0:
            installmenttype = InstallmentTypeForm()
        else:
            # installment_type = InstallmentType.objects.get(pk=id)
            # form = InstallmentTypeForm(instance=installment_type)
            try:
                cursor = connection.cursor()
                cursor.callproc('GetInstallmentTypeById', [id])
                installmenttype = cursor.fetchone()
                print(installmenttype)
                # Customer output = ('John', 'Peter', 'john@gmail.com', '1234567898', 'Male')
            except ConnectionError as e:
                print('ERROR IS: ')
                print(format(e))
            finally:
                cursor.close()
        return render(request, "adminpanel/installment/installmentoperation.html", {'form': installmenttype})
    else:
        if id == 0:
            form = InstallmentTypeForm(request.POST)
        else:
            installment_type = InstallmentType.objects.get(pk=id)
            form = InstallmentTypeForm(request.POST, instance=installment_type)
        if form.is_valid():
            form.save()
        return redirect('/Installment')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def installment_delete(request, id):
    disc = InstallmentType.objects.get(pk=id)
    disc.delete()
    return redirect('/Installment')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def usertype_list(request):
    cursor = connection.cursor()
    cursor.execute("call GetUserType()")
    results = cursor.fetchall()
    context = {"usertype_list": results}
    return render(request, "adminpanel/Usertype/usertypelist.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def usertype_operation(request, id=0):
    if request.method == "GET":
        if id == 0:
            usertype = UserTypeForm()
        else:
            try:
                cursor = connection.cursor()
                cursor.callproc('GetUserTypeById', [id])
                usertype = cursor.fetchone()
                print(usertype)
            except ConnectionError as e:
                print('ERROR IS: ')
                print(format(e))
            finally:
                cursor.close()
        return render(request, "adminpanel/Usertype/usertypeoperation.html", {'form': usertype})
    else:
        if id == 0:
            form = UserTypeForm(request.POST)
        else:
            usertype = UserType.objects.get(pk=id)
            form = UserTypeForm(request.POST, instance=usertype)
        if form.is_valid():
            form.save()
        return redirect('/Usertype')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def usertype_delete(request, id):
    usertype = UserType.objects.get(pk=id)
    usertype.delete()
    return redirect('/Usertype')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def invoice_generation(request):
    context = {"product_list": Product.objects.all()}
    return render(request, "adminpanel/invoicetemplate.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def post_list(request):
    cursor = connection.cursor()
    cursor.execute("call GetAnnouncementList()")
    results = cursor.fetchall()
    context = {"post_list": results}
    code = request.POST.get('DiscountCode')
    print('code', code)
    return render(request, "adminpanel/post/postlist.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def post_operation(request, id=0):
    cursor = connection.cursor()
    if request.method == "GET":
        if id == 0:
            posts = PostTypeForm()
        else:
            try:
                cursor.callproc('GetAnnouncementPostById', [id])
                posts = cursor.fetchone()
                print('posts', posts)
            except ConnectionError as e:
                print('ERROR IS: ')
                print(format(e))
            finally:
                cursor.close()

        return render(request, "adminpanel/post/postoperation.html", {'form': posts})
    else:
        userid = int(request.user.id)
        Title1 = request.POST.get("Title1")
        Title2 = request.POST.get("Title2")
        Description = request.POST.get("Description")

        if id == 0:
            form = PostTypeForm(request.POST)
            data = {"Announcement_Id": "0", "Title1": Title1, "Title2": Title2, "Description": Description}
            dataInString = json.dumps(data)
            cursor.callproc('InsertUpdateActivityLog', [dataInString, 1, userid])
        else:
            posts = AnnouncementPost.objects.get(pk=id)
            form = PostTypeForm(request.POST, instance=posts)
            data = {"Announcement_Id": id, "Title1": Title1, "Title2": Title2, "Description": Description}
            dataInString = json.dumps(data)
            cursor.callproc('InsertUpdateActivityLog', [dataInString, 2, userid])
        if form.is_valid():
            form.save()
        return redirect('/Post')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def post_delete(request, id):
    cursor = connection.cursor()
    userid = int(request.user.id)
    Title1 = request.POST.get("Title1")
    Title2 = request.POST.get("Title2")
    Description = request.POST.get("Description")
    data = {"Announcement_Id": id, "Title1": Title1, "Title2": Title2, "Description": Description}
    dataInString = json.dumps(data)
    posts = AnnouncementPost.objects.get(pk=id)
    cursor.callproc('InsertUpdateActivityLog', [dataInString, 2, userid])
    posts.delete()
    return redirect('/Post')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def activitylog_list(request):
    cursor = connection.cursor()
    cursor.execute("call GetActivityLogList()")
    results = cursor.fetchall()
    print('in activity log list')
    print(results)
    context = {"activitylog_list": results}
    return render(request, "adminpanel/activitylog/activityloglist.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def discount_operation(request, id=0):
    if request.method == "GET":
        if id == 0:
            discount = DiscountTypeForm()
        else:
            # disc = DiscountType.objects.get(pk=id)
            # form = DiscountTypeForm(instance=disc)
            try:
                cursor = connection.cursor()
                cursor.callproc('GetDiscountTypeById', [id])
                discount = cursor.fetchone()
            except ConnectionError as e:
                print('ERROR IS: ')
                print(format(e))
            finally:
                cursor.close()
        return render(request, "adminpanel/discount/discountoperation.html", {'form': discount})
    else:
        if id == 0:
            form = DiscountTypeForm(request.POST)
            # log(user=request.user, action="Add Discount", extra={"DiscountCode":})
        else:
            disc = DiscountType.objects.get(pk=id)
            form = DiscountTypeForm(request.POST, instance=disc)
        try:
            if form.is_valid():
                form.save()
            else:
                print(form.errors)
        except OperationalError as e:
            print(format(e))
        return redirect('/Discount')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def discount_delete(request, id):
    disc = DiscountType.objects.get(pk=id)
    disc.delete()
    return redirect('/Discount')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def config_list(request):
    cursor = connection.cursor()
    cursor.execute("call GetConfigurationList()")
    results = cursor.fetchall()
    context = {"config_list": results}
    return render(request, "adminpanel/configuration/configurationlist.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def config_operation(request, id=0):
    if request.method == "GET":
        if id == 0:
            config = ConfigurationForm()
        else:
            try:
                cursor = connection.cursor()
                cursor.callproc('GetConfigurationById', [id])
                config = cursor.fetchone()
            except ConnectionError as e:
                print('ERROR IS: ')
                print(format(e))
            finally:
                cursor.close()
        return render(request, "adminpanel/configuration/configurationoperation.html", {'form': config})
    else:
        if id == 0:
            form = ConfigurationForm(request.POST, request.FILES)
        else:
            config = Configuration.objects.get(pk=id)
            form = ConfigurationForm(request.POST, request.FILES, instance=config)
        try:
            if form.is_valid():
                form.save()
            else:
                print(form.errors)
        except OperationalError as e:
            print(format(e))
        return redirect('/Configuration')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def manageCurrentOrderDetailsList(request):
    searchCriteriaValue = request.POST.get("txtSearchForManageOrder")
    category = request.POST.get("searchManageOrder")
    print('searchCriteriaValue', searchCriteriaValue)
    print('category', category)
    cursor = connection.cursor()
    cursor.execute("call GetCurrentPlacedAndProcessedOrders()")
    results = cursor.fetchall()
    page = request.GET.get('page', 1)
    paginator = Paginator(results, 10)
    try:
        orderDetails = paginator.page(page)
    except PageNotAnInteger:
        orderDetails = paginator.page(1)
    except EmptyPage:
        orderDetails = paginator.page(paginator.num_pages)

    context = {"currentOrders": orderDetails}
    return render(request, "adminpanel/adminmanagement/manageCurrentOrder.html", context)


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def manageCurrentOrderShip(request, id):
    order = Order.objects.get(Order_Id=id)
    customer = Customer.objects.get(Customer_Id=order.Customer_id)
    order.OrderStatus_id = 3
    order.save()

    subject = 'Order Shipped for Order# ' + str(id)
    fromEmail = settings.EMAIL_HOST_USER
    to_list = [customer.Email]
    customerName = customer.First_Name + ' ' + customer.Last_Name
    html_content = render_to_string("sendemail/OrderShipment.html", {'customerName': customerName})
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
        email_send.send()
        message = "Success"
    except Exception as e:
        print('Error Is:', str(e))
        message = "Failed"
    print('email sent from adminpanel/adminview/manageCurrentOrderShip')

    return redirect('/ManageOrder')


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin', 'admin'])
def manageCurrentOrderProcess(request, id):
    order = Order.objects.get(Order_Id=id)
    order.OrderStatus_id = 2
    order.save()
    return redirect('/ManageOrder')
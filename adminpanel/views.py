from django.contrib.auth.hashers import make_password
from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from adminpanel.CustomUserDecorator import CustomDecorator
from django.contrib.auth import login, logout
from django.contrib import messages
from adminpanel.adminform import *
from django.conf import settings
from django.core.mail import send_mail, EmailMultiAlternatives
from django.db import connection
from django.template.loader import render_to_string, get_template
from django.utils.html import strip_tags
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse


def login_user(request):
    if request.user.is_authenticated:
        return redirect('/home')
    else:
        return render(request, 'login.html')


@CustomDecorator.unauthenticated_user
def registration(request):
    form = CreateUserForm()
    referralid = request.GET.get('id')

    if request.method == 'POST':
        form = CreateUserForm(request.POST)
        try:
            if form.is_valid():
                # Write logic here to implement SP to insert records in USER and Customer table

                str = 0
                cursor = connection.cursor()
                username = form.cleaned_data.get("username")
                firstname = request.POST.get("first_name")
                lastname = request.POST.get("last_name")
                email = form.cleaned_data.get("email")
                password1 = request.POST.get("password1")
                password = make_password(password1)

                if referralid is None:
                    referralid = 0
                else:
                    type(referralid)
                    # referralid = int(referralid)

                str = referralid
                cursor.callproc('GetCustomerDetailsByUserId', [str])
                refereeDetails = cursor.fetchone()

                referralCustomerId = refereeDetails[0]
                cursor.callproc('InsertUserCustomerRegistrationDetails',
                                [firstname, username, lastname, password, email, referralCustomerId])
                username = form.cleaned_data.get("username")

                # group = Group.objects.get(name='customer')
                # new_user.groups.add(group)

                subject = 'Thank you for your registration.'
                fromEmail = settings.EMAIL_HOST_USER
                to_list = [form.cleaned_data.get("email")]
                try:
                    html_content = render_to_string("message.html", {'username': username})
                    text_content = strip_tags(html_content)

                    emailsend = EmailMultiAlternatives(
                        subject,
                        text_content,
                        fromEmail,
                        to_list
                    )
                    emailsend.attach_alternative(html_content, "text/html")
                    emailsend.send()

                    # Email sent to Referree
                    if int(referralid) > 0:

                        # Fetch Referee emailid from the UserId:

                        refereename = refereeDetails[1]
                        refereeId = refereeDetails[3]
                        subjectForReferee = 'Referral Code'
                        fromEmail = settings.EMAIL_HOST_USER
                        to_list = [refereeId]
                        try:
                            html_content = render_to_string("sendemail/ReferralAcknowledgement.html",
                                                            {'refereename': refereename, 'username': username})
                            text_content = strip_tags(html_content)

                            emailsendForReferee = EmailMultiAlternatives(
                                subjectForReferee,
                                text_content,
                                fromEmail,
                                to_list
                            )
                            emailsendForReferee.attach_alternative(html_content, "text/html")
                            emailsendForReferee.send()
                        except Exception as e:
                            print('Error in sending email to referee', str(e))
                            messages.error(request, "There is some issue while creating account for " + username)
                except Exception as e:
                    print('Error in sending email while registration', str(e))
                    messages.error(request, "There is some issue while creating account for " + username)
                messages.success(request, "Account created for" + username)
                return redirect('Login')
            else:
                print('error')
                print(form.errors)
                print(form.error_messages)
        except Exception as e:
            print('Error Is:', str(e))
    context = {'form': form}
    return render(request, 'registration.html', context)


@CustomDecorator.unauthenticated_user
def dologin(request):
    if request.method != "POST":
        return HttpResponse("<h2>Login not allowed</h2>")
    else:
        user = CustomDecorator.authenticate(request, username=request.POST.get("email"),
                                            password=request.POST.get("password"))
        if user is not None:
            login(request, user)
            return HttpResponseRedirect("/home")
        else:
            messages.error(request, "Invalid Login Details")
            return HttpResponseRedirect("/")


def get_user_details(request):
    if request.user is not None:
        return HttpResponse("User: " + request.user.email + " and it is " + request.user.user_type)
    else:
        return HttpResponse("Please login first")


def logout_user(request):
    logout(request)
    return HttpResponseRedirect("/")


@login_required(login_url='Login')
@CustomDecorator.allowed_users(allowed_roles=['superadmin'])
def changeViewBySuperAdmin(request):

    groupview = request.POST.get("groupview")

    if request.user.groups.values_list('name', flat=True).exists():
        group_name = request.user.groups.all()[0].name.replace(" ", "").lower()

    print('GROUP NAME IS')
    print(group_name)
    url = '/home'
    if (group_name == 'superadmin' and groupview.lower() == 'superadmin') \
            or (group_name == 'superadmin' and groupview.lower() == 'admin'):
        print('redirected to admin / super admin landing page.')
        url = '/home'

    if group_name == 'superadmin' and groupview.lower() == 'client':
        print('redirected to client landing page.')
        url = '/index'

    if group_name == 'physician':
        print('redirected to physician landing page.')
        url = '/home'

    return JsonResponse({"url": url}, safe=False)

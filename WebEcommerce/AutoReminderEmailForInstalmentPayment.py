import datetime
from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.forms import DateField
from django.template.loader import render_to_string
from django.utils.html import strip_tags
from adminpanel.models import *
from django.utils import formats
import os


def SendEmail():
    filename = 'log.txt'
    if os.path.exists(filename):
        append_write = 'a'  # append if already exists
    else:
        append_write = 'w'  # make a new file if not

    logfile = open(filename, append_write)

    todaysdate = datetime.timedelta(days=settings.EMAIL_REMINDER_DAYS)
    instalmentReminderDate = datetime.date.today() + todaysdate
    instalmentDueDetails = InstallmentDue.objects.filter(IsInstalmentPaid=0, InstalmentDueDate=instalmentReminderDate)
    for dues in instalmentDueDetails:
        customer_id = dues.Customer_Id
        customer = Customer.objects.get(Customer_Id=customer_id)
        customer_name = customer.First_Name + ' ' + customer.Last_Name
        customer_email = customer.Email
        orderid = dues.Order_id
        duedate = formats.date_format(dues.InstalmentDueDate, "SHORT_DATETIME_FORMAT")
        print('duedate', duedate)
        current_site = 'http://127.0.0.1:8000/'  # Site.objects.get_current()
        url = str(current_site) + 'plandetail/' + str(orderid)
        subject = 'Reminder for Instalment Due'
        fromEmail = settings.EMAIL_HOST_USER
        to_list = [customer_email]

        try:
            html_content = render_to_string("emailpaymentInvoice/InstalmentDueReminderTemplate.html",
                                            {'username': customer_name,
                                             'orderNumber': orderid,
                                             'duedate': duedate,
                                             'site': url})
            text_content = strip_tags(html_content)

            emailsend = EmailMultiAlternatives(
                subject,
                text_content,
                fromEmail,
                to_list
            )
            emailsend.attach_alternative(html_content, "text/html")
            emailsend.send()
            print('email sent')
            logfile.write("Sent reminder email to : " + customer_name + " at " + str(datetime.date.today()) + '\n')
            print('Done..!')
        except Exception as e:
            print('in catch for email send')
            print('Error Is:', str(e))
            logfile.write(
                "Error occurred while sending reminder to : " + customer_name + " at " + str(datetime.date.today()) + '\n')
            logfile.write(
                "And the error is: " + str(e) + '\n')
            print('Error..!!')
    logfile.close()

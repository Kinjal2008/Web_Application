from django.core.exceptions import ObjectDoesNotExist
from django.db import connection
from django.views.generic import ListView
from adminpanel.models import *


class PlanView(ListView):
    model = Product
    template_name = 'webecommerce/myaccount/planlist.html'

    def get_context_data(self, **kwargs):
        context = super(PlanView, self).get_context_data(**kwargs)
        orderitems = {}
        if self.request.user.id is not None:
            customer = self.request.user.customer
            id = self.request.user.customer.Customer_Id
            print('customer id', id)
            try:
                order = Order.objects.get(Customer=customer, IsOrderCompleted=False)
                orderitems = order.orderdetails_set.all()
                cursor = connection.cursor()
                cursor.callproc('GetPlanDetailsByCustomerId', [id])
                plans = cursor.fetchall()
                print('plan details')
                print(plans)
                context['plans'] = plans
            except ObjectDoesNotExist:
                order = {}
        context['orderitems'] = orderitems

        return context
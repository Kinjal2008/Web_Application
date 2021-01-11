from django import template
from adminpanel.models import Order, OrderDetails

register = template.Library()


@register.filter
def cart_item_count(user):
    print('cart item')
    if user.is_authenticated:
        hasCustomer = hasattr(user, 'customer')
        if hasCustomer:
            customer = user.customer
            order = Order.objects.filter(Customer=customer, IsOrderCompleted=False)
            if len(order) > 0:
                orderitems = OrderDetails.objects.filter(Order_id=order[0])
                total = sum([item.Quantity for item in orderitems])
                return total
    return 0


@register.simple_tag
def setvar(val=None):
    return val

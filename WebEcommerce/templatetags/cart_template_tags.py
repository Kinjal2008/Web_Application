from django import template
from adminpanel.models import Order, OrderDetails

register = template.Library()


@register.filter
def cart_item_count(user):
    print('cart item')
    if user.is_authenticated:
        customer = user.customer
        order = Order.objects.filter(Customer=customer, IsOrderCompleted=False)
        print(order)
        if len(order) > 0:
            orderitems = OrderDetails.objects.filter(Order_id=order[0])
            total = sum([item.Quantity for item in orderitems])
            print(total)
            return total

    return 0


@register.simple_tag
def setvar(val=None):
    return val

from django import template
from adminpanel.models import Order, OrderDetails

register = template.Library()


@register.filter
def cart_item_count(user):
    if user.is_authenticated:
        customer = user.customer
        order = Order.objects.filter(Customer=customer, IsOrderCompleted=False)
        orderitems = OrderDetails.objects.filter(Order_id=order[0])
        total = sum([item.Quantity for item in orderitems])
        return total

    return 0

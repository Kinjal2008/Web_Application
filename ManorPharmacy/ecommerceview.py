from math import ceil

from django.core.exceptions import ObjectDoesNotExist
from django.shortcuts import render, redirect
from django.views.generic import ListView, DetailView, View
from adminpanel.models import *
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
import datetime
from .forms import CheckoutForm
from .util import *


def homepage(request):
    context = {
    }
    return render(request, "manorpharmacy/home.html", context)


class HomeView(ListView):
    model = Product
    template_name = 'manorpharmacy/home.html'

    def get_context_data(self, **kwargs):
        context = super(HomeView, self).get_context_data(**kwargs)
        context['AnnouncementPost'] = AnnouncementPost.objects.all()

        allProducts = []
        catProducts = Product.objects.values('Category_id')

        category = {item['Category_id'] for item in catProducts}
        categoryList = Category.objects.all()
        for cat in category:
            prod = Product.objects.filter(Category_id=cat)
            n = len(prod)
            nslides = n // 3 + ceil((n / 3) - (n // 3))
            allProducts.append([prod, range(1, nslides), nslides])
            print(allProducts)

        context['allProds'] = allProducts
        context['category'] = categoryList
        print(categoryList)
        # And so on for more models
        return context


class CategoryListView(ListView):
    model = Product
    template_name = 'manorpharmacy/categorylist.html'

    def get_queryset(self):
        category = self.kwargs.get('category')
        return Product.objects.filter(Category_id=category)

    def get_context_data(self, **kwargs):
        context = super(CategoryListView, self).get_context_data(**kwargs)

        allProducts = []
        category = self.kwargs.get('category')
        print('category is')
        print(category)

        prod = Product.objects.filter(Category_id=category)
        print('prod')
        print(prod)
        n = len(prod)
        nslides = n // 3 + ceil((n / 3) - (n // 3))
        allProducts.append([prod, range(1, nslides), nslides])
        print(allProducts)

        context['allProds'] = allProducts

        # And so on for more models
        return context


class OrderSummaryView(LoginRequiredMixin, View):
    def get(self, *args, **kwargs):
        try:
            customer = self.request.user.customer
            order = Order.objects.get(Customer=customer, IsOrderCompleted=False)
            orderitems = order.orderdetails_set.all()
            context = {
                'order': order,
                'orderitems': orderitems
            }

            return render(self.request, "manorpharmacy/order-summary.html", context)
        except ObjectDoesNotExist:
            messages.warning(self.request, "You do not have an active order")
            return redirect("/")


class CheckoutView(LoginRequiredMixin, View):
    def get(self, *args, **kwargs):
        try:
            form = CheckoutForm()
            customer = self.request.user.customer
            order = Order.objects.get(Customer=customer, IsOrderCompleted=False)
            orderitems = order.orderdetails_set.all()
            IsMorethanOnePerson = False
            for item in orderitems:
                if item.TotalNoOfPerson > 1:
                    IsMorethanOnePerson = True
            print('IsMorethanOnePerson')
            print(IsMorethanOnePerson)
            discountAmountForFullPayment = getFullPaymentDiscount(order, 'Fulltime Payment')
            totalAmountWithDiscount = order.get_TotalForAllProductPriceAndInitialSetupCharge_WithFullPayment - discountAmountForFullPayment
            context = {
                'order': order,
                'form': form,
                'orderitems': orderitems,
                'DISPLAY_COUPON_FORM': True,
                'IsMorethanOnePerson': IsMorethanOnePerson,
                'discountAmountForFullPayment': discountAmountForFullPayment,
                'totalAmountWithDiscount': totalAmountWithDiscount
            }

            shipping_address_qs = Address.objects.filter(
                User_Id=self.request.user.id,
                Address_Type='S',
                default=True
            )

            if shipping_address_qs.exists():
                context.update(
                    {'default_shipping_address': shipping_address_qs[0]})

            billing_address_qs = Address.objects.filter(
                User_Id=self.request.user.id,
                Address_Type='B',
                default=True
            )
            if billing_address_qs.exists():
                context.update(
                    {'default_billing_address': billing_address_qs[0]})
            return render(self.request, 'manorpharmacy/checkout-page.html', context)

        except ObjectDoesNotExist:
            messages.info(self.request, "you don not have an active order")
            return redirect("check-out")

    def post(self, *args, **kwargs):
        form = CheckoutForm(self.request.POST or None)
        try:
            order = Order.objects.get(user=self.request.user, ordered=False)
            if form.is_valid():

                use_default_shipping = form.cleaned_data.get(
                    'use_default_shipping')
                if use_default_shipping:
                    print("Using the defualt shipping address")
                    address_qs = Address.objects.filter(
                        user=self.request.user,
                        address_type='S',
                        default=True
                    )
                    if address_qs.exists():
                        shipping_address = address_qs[0]
                        order.shipping_address = shipping_address
                        order.save()
                    else:
                        messages.info(
                            self.request, "No default shipping address available")
                        return redirect('check-out')
                else:
                    print("User is entering a new shipping address")
                    shipping_address1 = form.cleaned_data.get(
                        'shipping_address')
                    shipping_address2 = form.cleaned_data.get(
                        'shipping_address2')
                    shipping_country = form.cleaned_data.get(
                        'shipping_country')
                    shipping_zip = form.cleaned_data.get('shipping_zip')

                    if is_valid_form([shipping_address1, shipping_country, shipping_zip]):
                        shipping_address = Address(
                            user=self.request.user,
                            street_address=shipping_address1,
                            apartment_address=shipping_address2,
                            country=shipping_country,
                            zip=shipping_zip,
                            address_type='S'
                        )
                        shipping_address.save()

                        order.shipping_address = shipping_address
                        order.save()

                        set_default_shipping = form.cleaned_data.get(
                            'set_default_shipping')
                        if set_default_shipping:
                            shipping_address.default = True
                            shipping_address.save()

                    else:
                        messages.info(
                            self.request, "Please fill in the required shipping address fields")

                use_default_billing = form.cleaned_data.get(
                    'use_default_billing')
                same_billing_address = form.cleaned_data.get(
                    'same_billing_address')

                if same_billing_address:
                    billing_address = shipping_address
                    billing_address.pk = None
                    billing_address.save()
                    billing_address.address_type = 'B'
                    billing_address.save()
                    order.billing_address = billing_address
                    order.save()

                elif use_default_billing:
                    print("Using the defualt billing address")
                    address_qs = Address.objects.filter(
                        user=self.request.user,
                        address_type='B',
                        default=True
                    )
                    if address_qs.exists():
                        billing_address = address_qs[0]
                        order.billing_address = billing_address
                        order.save()
                    else:
                        messages.info(
                            self.request, "No default billing address available")
                        return redirect('check-out')
                else:
                    print("User is entering a new billing address")
                    billing_address1 = form.cleaned_data.get(
                        'billing_address')
                    billing_address2 = form.cleaned_data.get(
                        'billing_address2')
                    billing_country = form.cleaned_data.get(
                        'billing_country')
                    billing_zip = form.cleaned_data.get('billing_zip')

                    if is_valid_form([billing_address1, billing_country, billing_zip]):
                        billing_address = Address(
                            user=self.request.user,
                            street_address=billing_address1,
                            apartment_address=billing_address2,
                            country=billing_country,
                            zip=billing_zip,
                            address_type='B'
                        )
                        billing_address.save()

                        order.billing_address = billing_address
                        order.save()

                        set_default_billing = form.cleaned_data.get(
                            'set_default_billing')
                        if set_default_billing:
                            billing_address.default = True
                            billing_address.save()

                    else:
                        messages.info(
                            self.request, "Please fill in the required billing address fields")

                payment_option = form.cleaned_data.get('payment_option')

                if payment_option == 'S':
                    return redirect('payment', payment_option='stripe')
                elif payment_option == 'P':
                    return redirect('payment', payment_option='paypal')
                else:
                    messages.warning(
                        self.request, "Invalid payment option selected")
                    return redirect('check-out')
        except ObjectDoesNotExist:
            messages.warning(self.request, "You do not have an active order")
            return redirect("order-summary")


def payment(request):
    isPayByInstallment = request.GET.get('data')
    print('in Payment ecommerce view')
    print(isPayByInstallment)
    data = cartData(request)

    cartItems = data['cartItems']
    items = data['items']
    order = data['order']
    customerdetail = data['customerdetail']

    currentDate = datetime.datetime.now()
    yearLimit = currentDate.year + 21
    yearList = []
    totalwithDiscount = 0

    print('ACTUAL AMOUNT TO PAY')
    print(order.get_CartTotalPriceForInitialSetupAndProduct)

    # For Payment gateway default values.
    # index_context = getVars()
    # index_context.update({'merch_hashdigest': getHashDigest(index_context)})
    IsServiceExists = False
    IsProductExists = False
    discountOnProduct = 0
    discountPercentageOnProduct = 0
    for item in items:
        if item.Product.IsDiscountable and item.Product.IsProduct:
            discountPercentageOnProduct += item.Product.DiscountPercentage
        if item.Product.IsProduct:
            IsProductExists = True
        if not item.Product.IsProduct:
            IsServiceExists = True

    # TO DO: Get the discount of Product and calculate it.
    if order.get_CartTotalPriceForAllDiscountableProduct_WithFullPayment > 0:
        discountOnProduct = (order.get_CartTotalPriceForAllDiscountableProduct_WithFullPayment * discountPercentageOnProduct) / 100

    fullDiscountAmount = 0
    if isPayByInstallment == 'no':
        fullDiscountAmount = getFullPaymentDiscount(order, 'Fulltime Payment')
        totalwithDiscount = order.get_TotalForAllProductPriceAndInitialSetupCharge_WithFullPayment - fullDiscountAmount - discountOnProduct
    else:
        totalwithDiscount = order.get_TotalPrice_WithInstallmentPayment - discountOnProduct


    # Customer Personal Discount
    customerPersonalDiscount = customerdetail[14]
    customerPersonalDiscountAmount = 0

    # if customerPersonalDiscount > 0:
    #     customerPersonalDiscountAmount = (totalwithDiscount * customerPersonalDiscount) / 100
    #     print('personal disc', customerPersonalDiscountAmount)
    #     totalwithDiscount = totalwithDiscount - customerPersonalDiscountAmount

    print('final amount after all disc', totalwithDiscount)

    for i in range(currentDate.year, yearLimit):
        yearList.append(i)

    context = {'orderitems': items, 'order': order, 'cartItems': cartItems, 'customerdetail': customerdetail,
               'yearLimit': yearList, 'totalwithDiscount': totalwithDiscount, 'isPayByInstallment': isPayByInstallment,
               'discountOnProduct': discountOnProduct,
               'discountAmountForFullPayment': fullDiscountAmount,
               'customerPersonalDiscountAmount': customerPersonalDiscountAmount,
               'IsServiceExists': IsServiceExists,
               'IsProductExists': IsProductExists,
               }
    return render(request, 'manorpharmacy/payment.html', context)
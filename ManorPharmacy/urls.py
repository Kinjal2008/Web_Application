from django.urls import path
from . import views
from . import ecommerceview

urlpatterns = [
    path('home/', ecommerceview.HomeView.as_view(), name="homepage"),
    path('category/<category>', ecommerceview.CategoryListView.as_view(), name='category-list'),
    path('order-summary/', ecommerceview.OrderSummaryView.as_view(), name='order-summary'),
    path('check-out/', ecommerceview.CheckoutView.as_view(), name='check-out'),
    path('payment-page/', ecommerceview.payment, name='payment-page'),
    # path('', views.manorpharmacy, name="manor"),
    path('search/', views.search, name="search"),
    path('cart/', views.cart, name="cart"),
    path('updateItem/', views.updateCartItem, name="updateItem"),
    path('checkout/', views.checkout, name="checkout"),
    path('processOrder/', views.processOrder, name="processOrder"),
    path('updateTotal/', views.updateTotal, name="updateTotal"),
    path('payment/', views.payment, name="payment"),
    path('applyDiscount/', views.applyDiscount, name="applyDiscount"),
    path('applyDiscountOnProduct/', views.applyDiscountOnProduct, name="applyDiscountOnProduct"),
    path('sendReferralEmail/', views.sendReferralEmail, name="sendReferralEmail"),
    path('productByCategory/', views.productByCategory, name="productByCategory"),

]

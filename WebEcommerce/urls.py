from django.urls import path
from . import views, myaccountview

urlpatterns = [
    path('', views.IndexView.as_view(), name="index"),
    path('shop/', views.ShopView.as_view(), name="shop"),
    path('shopByCategory/', views.shopByCategory, name="shopByCategory"),
    path('<slug:slug>[-\w]/', views.DetailView.as_view(), name="detail"),
    path('shoppingcart/', views.cart, name="cart"),
    path('shoppingcheckout/', views.checkout, name="cartcheckout"),
    path('Thankyou/', views.ThankYouView.as_view(), name="Thankyou"),
    path('placeOrder/', views.placeOrder, name="placeOrder"),
    path('test/', views.Test.as_view(), name="test"),
    path('plan/', myaccountview.PlanView.as_view(), name="plan"),

    ]

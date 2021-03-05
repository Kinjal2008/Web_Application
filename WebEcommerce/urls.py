from django.urls import path
from . import views, myaccountview, AutoReminderEmailForInstalmentPayment

urlpatterns = [
    path('', views.IndexView.as_view(), name="index"),
    path('index/', views.IndexView.as_view(), name="index"),
    path('shop/', views.ShopView.as_view(), name="shop"),
    path('shopByCategory/', views.shopByCategory, name="shopByCategory"),
    path('<slug:slug>[-\w]/', views.DetailView.as_view(), name="detail"),
    path('shoppingcart/', views.cart, name="cart"),
    path('shoppingcheckout/', views.checkout, name="cartcheckout"),
    path('updateCartItem/', views.updateCartItem, name="updateCartItem"),
    path('Thankyou/', views.ThankYouView.as_view(), name="Thankyou"),
    path('placeOrder/', views.placeOrder, name="placeOrder"),
    path('plan/', myaccountview.PlanView.as_view(), name="plan"),
    path('plandetail/<int:id>/', myaccountview.planDetail, name="plandetail"),
    path('payment/<int:id>/', myaccountview.paymentInstalment, name="payment"),
    path('payInstalmentDue/', myaccountview.payInstalmentDue, name="payInstalmentDue"),
    path('purchaseHistory/', myaccountview.PurchaseHistoryView.as_view(), name="Purchase_History"),
    path('purchaseHistory/trackOrderStatus/<int:id>', myaccountview.trackOrderStatus, name="trackOrderStatus"),
    path('applyDiscountOnService/', views.applyDiscountOnService, name="applyDiscountOnService"),
    path('applyDiscountOnProduct/', views.applyDiscountOnProduct, name="applyDiscountOnProduct"),
    path('sendReferralEmail/', views.sendReferralEmail, name="sendReferralEmail"),
    ]

from django.conf import settings


def stripeSettingValues(request):
    return {
        'STRIPE_PUBLISHABLE_KEY': settings.STRIPE_SECRET_KEY,
        'STRIPE_SECRET_KEY': settings.STRIPE_SECRET_KEY
            }

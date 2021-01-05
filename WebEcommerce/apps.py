from django.apps import AppConfig


class WebecommerceConfig(AppConfig):
    name = 'WebEcommerce'

    def ready(self):
        from WebEcommerce import Reminder
        Reminder.start()

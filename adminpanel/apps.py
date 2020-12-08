from django.apps import AppConfig
from django.conf import settings
from django.contrib.auth.apps import AuthConfig
from django.db.models.signals import post_migrate
from django.core.exceptions import ObjectDoesNotExist


class AdminConfig(AppConfig):
    name = 'adminpanel'

    def ready(self):
        post_migrate.connect(createSuperUser)


USERNAME = "admin"
PASSWORD = "admin"
EMAIL = "admin@gmail.com"


def createSuperUser(sender, **kwargs):
    if not settings.DEBUG:
        return
    if not isinstance(sender, AuthConfig):
        return

    from .models import User
    manager = User.objects
    try:
        manager.get(username=USERNAME)
    except ObjectDoesNotExist:
        manager.create_superuser(USERNAME, EMAIL, PASSWORD)

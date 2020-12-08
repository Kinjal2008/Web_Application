from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import *
# Register your models here.


class UserModel(UserAdmin):
    model = User
    fieldsets = (
        (None, {'fields': ('email', 'password', 'first_name', 'last_name', 'user_type')}),
        ('Permissions', {'fields': ('is_staff', 'is_active', 'is_superuser', 'groups')}),
    )


admin.site.register(User, UserModel)

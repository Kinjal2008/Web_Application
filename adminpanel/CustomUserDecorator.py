from django.contrib.auth.backends import ModelBackend
from django.contrib.auth import get_user_model
from django.http import HttpResponse
from django.shortcuts import redirect
from django.contrib.auth import logout


class CustomDecorator(ModelBackend):

    def authenticate(self, username=None, password=None, **kwargs):
        user_model = get_user_model()
        try:
            user = user_model.objects.get(email=username)
        except user_model.DoesNotExist:
            return None
        else:
            if user.check_password(password):
                return user
            return None

    def unauthenticated_user(view_func):
        def wrapper_func(request, *args, **kwargs):
            if request.user.is_authenticated:
                print('user authenticated')
                return redirect('/index')
            else:
                return view_func(request, *args, **kwargs)

        return wrapper_func

    def allowed_users(allowed_roles=[]):
        def decorator(view_func):
            def wrapper_func(request, *args, **kwargs):
                print('IS USER in allowed user')
                print(request.user)
                group = None
                if request.user.groups.values_list('name', flat=True).exists():
                    group = request.user.groups.all()[0].name.replace(" ", "").lower()
                    print(group)
                if group in allowed_roles:
                    return view_func(request, *args, **kwargs)
                else:
                    if group == 'physician':
                        return redirect('/home')
                    logout(request)
                    return HttpResponse("You are not authorized.!")
            return wrapper_func
        return decorator

    def admin_only(view_func):
        def wrapper_func(request, *args, **kwargs):
            group_name = None

            if request.user.groups.values_list('name', flat=True).exists():
                print('EXISTED')
                group_name = request.user.groups.all()[0].name.replace(" ", "").lower()

            print('GROUP NAME IS')
            print(group_name)
            if group_name.lower() == 'superadmin' or group_name.lower() == 'admin':
                return view_func(request, *args, **kwargs)

            if group_name == 'customer':
                return redirect('index')

            if group_name == 'physician':
                return redirect('/home')

        return wrapper_func


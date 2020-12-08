from django import forms
from adminpanel.models import *
from django.contrib.auth.forms import UserCreationForm


class CreateUserForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']


class CustomerForm(forms.ModelForm):
    class Meta:
        model = Customer
        fields = ('First_Name', 'Last_Name', 'Email', 'Phone_No', 'Gender')
        # display all fields like "__all__"
        labels = {
            "First_Name"  "firstName",
            "Last_Name"  "lastName"
            "Email"  "email"
            "Phone_No"  "phone",
            "Gender"  "gender"
        }


class UserTypeForm(forms.ModelForm):
    class Meta:
        model = UserType
        fields = "__all__"


class DiscountTypeForm(forms.ModelForm):
    class Meta:
        model = DiscountType
        fields = "__all__"


class ProductTypeForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = "__all__"


class ServiceTypeForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = "__all__"


class InstallmentTypeForm(forms.ModelForm):
    class Meta:
        model = InstallmentType
        # ordering = ['-Installment_Type_Id']
        fields = "__all__"


class ConfigurationForm(forms.ModelForm):
    class Meta:
        model = Configuration
        fields = "__all__"

    # def get_queryset(self, request):
    #     queryset = super(InstallmentTypeForm, self).get_queryset(request)
    #     queryset = queryset.order_by('Installment_Type')
    #     return queryset

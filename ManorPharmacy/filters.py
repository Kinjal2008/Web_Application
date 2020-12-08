from adminpanel.models import *
import django_filters


class ProductFilter(django_filters.FilterSet):
    Description = django_filters.CharFilter(lookup_expr='icontains')

    class Meta:
        model = Product
        fields = ['Name', 'Description']

# Generated by Django 3.0.8 on 2020-10-02 17:01

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0014_customer_personaldiscount'),
    ]

    operations = [
        migrations.AddField(
            model_name='discounttype',
            name='IsReferralDiscount',
            field=models.BooleanField(blank=True, default=False, null=True),
        ),
        migrations.AlterField(
            model_name='customer',
            name='PersonalDiscount',
            field=models.FloatField(blank=True, default=0, null=True, validators=[django.core.validators.MinValueValidator(0), django.core.validators.MaxValueValidator(100)]),
        ),
        migrations.AlterField(
            model_name='discounttype',
            name='Percentage',
            field=models.FloatField(blank=True, null=True, validators=[django.core.validators.MinValueValidator(0), django.core.validators.MaxValueValidator(100)]),
        ),
        migrations.AlterField(
            model_name='product',
            name='DiscountPercentage',
            field=models.FloatField(blank=True, default=0, null=True, validators=[django.core.validators.MinValueValidator(0), django.core.validators.MaxValueValidator(100)]),
        ),
    ]

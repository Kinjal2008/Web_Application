# Generated by Django 3.0.8 on 2020-10-29 19:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0031_order_fullpaymentdiscountamount'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customerdiscounteligibility',
            name='DiscountType',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='order',
            name='ProductDiscountCode',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='order',
            name='ServiceDiscountCode',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]

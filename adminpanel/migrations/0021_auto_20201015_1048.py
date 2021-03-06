# Generated by Django 3.0.8 on 2020-10-15 10:48

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0020_auto_20201014_1707'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='address',
            name='Customer_Id',
        ),
        migrations.AddField(
            model_name='address',
            name='Address_Type',
            field=models.CharField(choices=[('B', 'Billing'), ('S', 'Shipping')], default='B', max_length=1),
        ),
        migrations.AddField(
            model_name='address',
            name='User_Id',
            field=models.ForeignKey(blank=True, db_column='User_Id', null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='address',
            name='default',
            field=models.BooleanField(default=False),
        ),
    ]

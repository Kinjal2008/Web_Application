# Generated by Django 2.2.14 on 2021-03-05 16:24

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0051_order_ordernotes'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='order',
            name='OrderNotes',
        ),
    ]
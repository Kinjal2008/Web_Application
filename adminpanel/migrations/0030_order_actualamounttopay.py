# Generated by Django 3.0.8 on 2020-10-29 18:05

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0029_auto_20201029_1657'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='ActualAmountToPay',
            field=models.FloatField(blank=True, null=True),
        ),
    ]
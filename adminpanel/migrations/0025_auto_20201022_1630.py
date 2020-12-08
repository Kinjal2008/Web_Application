# Generated by Django 3.0.8 on 2020-10-22 16:30

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0024_auto_20201022_1030'),
    ]

    operations = [
        migrations.AddField(
            model_name='customerdiscounteligibility',
            name='IsUsed',
            field=models.BooleanField(blank=True, default=False, null=True),
        ),
        migrations.AddField(
            model_name='orderdiscount',
            name='DiscountType',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='adminpanel.DiscountType'),
        ),
    ]
# Generated by Django 3.0.8 on 2020-09-16 14:43

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0004_product_noofinstallmentmonths'),
    ]

    operations = [
        migrations.AddField(
            model_name='discounttype',
            name='DiscountNameUnchanged',
            field=models.CharField(blank=True, max_length=50, null=True),
        ),
        migrations.AddField(
            model_name='installmenttype',
            name='Installment_TypeUnchanged',
            field=models.CharField(blank=True, max_length=50, null=True),
        ),
        migrations.AddField(
            model_name='usertype',
            name='UserTypeUnchanged',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='installmentdue',
            name='Due_Installments',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='installmentdue',
            name='Installment_Type_Id',
            field=models.ForeignKey(blank=True, db_column='Installment_Type_Id', null=True, on_delete=django.db.models.deletion.CASCADE, to='adminpanel.InstallmentType'),
        ),
        migrations.AlterField(
            model_name='product',
            name='InitialSetupCharge',
            field=models.FloatField(blank=True, default=0, null=True),
        ),
        migrations.AlterField(
            model_name='product',
            name='NoOfInstallmentMonths',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
    ]
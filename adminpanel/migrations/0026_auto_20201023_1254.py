# Generated by Django 3.0.8 on 2020-10-23 12:54

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0025_auto_20201022_1630'),
    ]

    operations = [
        migrations.CreateModel(
            name='Configuration',
            fields=[
                ('ConfigurationId', models.AutoField(primary_key=True, serialize=False)),
                ('ConfigurationName', models.CharField(blank=True, max_length=2000, null=True)),
                ('ConfigurationValue', models.CharField(blank=True, max_length=2000, null=True)),
            ],
        ),
        migrations.AddField(
            model_name='order',
            name='ConditionalVAT',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='order',
            name='GeneralVAT',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='order',
            name='ProductDiscountCode',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='Discount_On_Product', to='adminpanel.DiscountType'),
        ),
        migrations.AddField(
            model_name='order',
            name='ProductTotalAmount',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='order',
            name='ServiceDiscountAmount',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='order',
            name='ServiceDiscountCode',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='Discount_On_Service', to='adminpanel.DiscountType'),
        ),
        migrations.AddField(
            model_name='order',
            name='ServiceTotalAmount',
            field=models.FloatField(blank=True, null=True),
        ),
    ]
# Generated by Django 3.0.8 on 2020-11-20 09:49

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0037_announcementpost_isactive'),
    ]

    operations = [
        migrations.CreateModel(
            name='OrderStatus',
            fields=[
                ('OrderStatusId', models.AutoField(primary_key=True, serialize=False)),
                ('OrderStatusType', models.CharField(blank=True, max_length=100, null=True)),
            ],
        ),
        migrations.AddField(
            model_name='order',
            name='OrderStatus',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='adminpanel.OrderStatus'),
        ),
    ]

# Generated by Django 3.0.8 on 2020-11-18 10:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('adminpanel', '0036_configuration_image'),
    ]

    operations = [
        migrations.AddField(
            model_name='announcementpost',
            name='IsActive',
            field=models.BooleanField(blank=True, default=True, null=True),
        ),
    ]

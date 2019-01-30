# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0085_auto_20160413_1121'),
    ]

    operations = [
        migrations.CreateModel(
            name='Reason',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('text_reason', models.CharField(max_length=255)),
                ('date_reason', models.DateField(default='0')),
                ('unsubscriber', models.ForeignKey(to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]

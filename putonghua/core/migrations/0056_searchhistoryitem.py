# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0055_auto_20151101_0854'),
    ]

    operations = [
        migrations.CreateModel(
            name='SearchHistoryItem',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, primary_key=True, auto_created=True)),
                ('querytext', models.CharField(max_length=255)),
                ('datetime', models.DateTimeField(auto_now=True)),
            ],
        ),
    ]

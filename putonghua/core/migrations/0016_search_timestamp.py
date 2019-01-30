# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0015_search'),
    ]

    operations = [
        migrations.AddField(
            model_name='search',
            name='timestamp',
            field=models.DateTimeField(auto_now_add=True, default=datetime.datetime(2015, 5, 20, 22, 2, 55, 778500)),
            preserve_default=False,
        ),
    ]

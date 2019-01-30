# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0008_auto_20150510_1053'),
    ]

    operations = [
        migrations.AddField(
            model_name='word',
            name='ok',
            field=models.BooleanField(default=True),
        ),
    ]

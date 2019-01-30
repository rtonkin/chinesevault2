# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0004_auto_20150506_1620'),
    ]

    operations = [
        migrations.AddField(
            model_name='word',
            name='frequency',
            field=models.FloatField(db_index=True, default=0),
        ),
    ]

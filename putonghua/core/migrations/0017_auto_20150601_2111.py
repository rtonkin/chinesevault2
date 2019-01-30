# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0016_search_timestamp'),
    ]

    operations = [
        migrations.AlterField(
            model_name='country',
            name='code',
            field=models.CharField(unique=True, max_length=2, blank=True, db_index=True),
        ),
    ]

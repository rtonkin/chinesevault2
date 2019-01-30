# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0017_auto_20150601_2111'),
    ]

    operations = [
        migrations.AlterField(
            model_name='country',
            name='code',
            field=models.CharField(max_length=2, unique=True, db_index=True, blank=True, null=True),
        ),
    ]

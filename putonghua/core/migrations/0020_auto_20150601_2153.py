# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0019_auto_20150601_2149'),
    ]

    operations = [
        migrations.AlterField(
            model_name='country',
            name='code',
            field=models.CharField(db_index=True, max_length=2, unique=True),
        ),
        migrations.AlterField(
            model_name='country',
            name='name',
            field=models.CharField(db_index=True, max_length=128, unique=True),
        ),
    ]

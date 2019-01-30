# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0018_auto_20150601_2149'),
    ]

    operations = [
        migrations.AlterField(
            model_name='country',
            name='code',
            field=models.CharField(null=True, db_index=True, blank=True, max_length=2),
        ),
        migrations.AlterField(
            model_name='country',
            name='name',
            field=models.CharField(db_index=True, max_length=50),
        ),
    ]

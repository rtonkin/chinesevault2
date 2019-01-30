# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0003_word'),
    ]

    operations = [
        migrations.AlterField(
            model_name='word',
            name='pinyin',
            field=models.CharField(db_index=True, max_length=128),
        ),
        migrations.AlterField(
            model_name='word',
            name='simplified',
            field=models.CharField(db_index=True, max_length=255),
        ),
        migrations.AlterField(
            model_name='word',
            name='taiwanese_pinyin',
            field=models.CharField(db_index=True, null=True, blank=True, max_length=128),
        ),
        migrations.AlterField(
            model_name='word',
            name='traditional',
            field=models.CharField(db_index=True, max_length=255),
        ),
    ]

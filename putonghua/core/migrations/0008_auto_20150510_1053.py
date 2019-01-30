# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0007_auto_20150508_0547'),
    ]

    operations = [
        migrations.AddField(
            model_name='word',
            name='pinyin_neutral',
            field=models.CharField(default='', max_length=128, db_index=True),
        ),
        migrations.AddField(
            model_name='word',
            name='taiwanese_pinyin_neutral',
            field=models.CharField(default='', blank=True, max_length=128, db_index=True),
        ),
        migrations.AlterField(
            model_name='word',
            name='pinyin',
            field=models.CharField(default='', max_length=128, db_index=True),
        ),
        migrations.AlterField(
            model_name='word',
            name='taiwanese_pinyin',
            field=models.CharField(default='', blank=True, max_length=128, db_index=True),
        ),
    ]

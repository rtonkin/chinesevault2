# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.contrib.postgres.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0062_auto_20151111_0715'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='examplesentence',
            name='chinese_simple_jieba',
        ),
        migrations.RemoveField(
            model_name='examplesentence',
            name='chinese_simple_words',
        ),
        migrations.AddField(
            model_name='examplesentence',
            name='chinese_simple_words',
            field=django.contrib.postgres.fields.ArrayField(size=None, default=[], base_field=models.CharField(blank=True, max_length=10), editable=False),
            preserve_default=False,
        ),
    ]

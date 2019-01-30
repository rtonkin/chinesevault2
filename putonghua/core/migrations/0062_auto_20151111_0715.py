# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import sortedm2m.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0061_auto_20151110_1807'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='examplesentence',
            name='chinese_traditional_jieba',
        ),
        migrations.AddField(
            model_name='examplesentence',
            name='chinese_simple_words',
            field=sortedm2m.fields.SortedManyToManyField(help_text=None, to='core.Word'),
        ),
    ]

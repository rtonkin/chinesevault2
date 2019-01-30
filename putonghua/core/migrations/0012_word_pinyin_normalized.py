# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0011_word_meanings_references'),
    ]

    operations = [
        migrations.AddField(
            model_name='word',
            name='pinyin_normalized',
            field=models.CharField(db_index=True, default='', max_length=128),
        ),
    ]

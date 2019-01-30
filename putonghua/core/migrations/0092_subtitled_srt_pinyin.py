# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0091_studycontent_description'),
    ]

    operations = [
        migrations.AddField(
            model_name='subtitled',
            name='srt_pinyin',
            field=models.TextField(default='', blank=True),
        ),
    ]

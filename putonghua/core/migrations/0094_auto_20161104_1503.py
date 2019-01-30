# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0093_subtitled_srt_pinyin_number'),
    ]

    operations = [
        migrations.AddField(
            model_name='subtitled',
            name='keywords',
            field=models.TextField(blank=True, default=''),
        ),
        migrations.AddField(
            model_name='subtitled',
            name='keywords_description',
            field=models.TextField(blank=True, default=''),
        ),
        migrations.AddField(
            model_name='subtitled',
            name='keywords_pinyin',
            field=models.TextField(blank=True, default=''),
        ),
    ]

# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0092_subtitled_srt_pinyin'),
    ]

    operations = [
        migrations.AddField(
            model_name='subtitled',
            name='srt_pinyin_number',
            field=models.TextField(blank=True, default=''),
        ),
    ]

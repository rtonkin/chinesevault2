# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0058_studycontent_number'),
    ]

    operations = [
        migrations.AddField(
            model_name='studycontent',
            name='source_url',
            field=models.URLField(blank=True, verbose_name='Link to the source'),
        ),
        migrations.AlterField(
            model_name='studycontent',
            name='chinese_artist',
            field=models.CharField(blank=True, verbose_name='Chinese artist (author)', default='', max_length=255),
        ),
        migrations.AlterField(
            model_name='studycontent',
            name='chinese_name',
            field=models.CharField(max_length=255, verbose_name='Chinese name'),
        ),
        migrations.AlterField(
            model_name='studycontent',
            name='english_artist',
            field=models.CharField(blank=True, verbose_name='English artist (author)', default='', max_length=255),
        ),
        migrations.AlterField(
            model_name='studycontent',
            name='english_name',
            field=models.CharField(max_length=255, verbose_name='English name'),
        ),
    ]

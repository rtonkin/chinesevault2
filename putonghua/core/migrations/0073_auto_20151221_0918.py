# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0072_auto_20151221_0917'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examplesentence',
            name='chinese_simple',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='chinese_traditional',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='english_1',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='english_2',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='english_3',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='pinyin',
            field=models.CharField(max_length=1024, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='sound_file',
            field=models.FileField(upload_to='tts/sentences/', null=True),
        ),
    ]

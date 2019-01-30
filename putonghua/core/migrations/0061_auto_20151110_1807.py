# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0060_examplesentence'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examplesentence',
            name='chinese_simple',
            field=models.CharField(max_length=1024, null=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='chinese_traditional',
            field=models.CharField(max_length=1024, null=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='english_1',
            field=models.CharField(max_length=1024, null=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='english_2',
            field=models.CharField(max_length=1024, null=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='english_3',
            field=models.CharField(max_length=1024, null=True),
        ),
        migrations.AlterField(
            model_name='examplesentence',
            name='pinyin',
            field=models.CharField(max_length=1024, null=True),
        ),
    ]

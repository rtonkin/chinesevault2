# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0059_auto_20151109_1847'),
    ]

    operations = [
        migrations.CreateModel(
            name='ExampleSentence',
            fields=[
                ('id', models.AutoField(primary_key=True, verbose_name='ID', auto_created=True, serialize=False)),
                ('chinese_simple', models.CharField(max_length=255, null=True)),
                ('chinese_traditional', models.CharField(max_length=255, null=True)),
                ('pinyin', models.CharField(max_length=255, null=True)),
                ('english_1', models.CharField(max_length=255, null=True)),
                ('english_2', models.CharField(max_length=255, null=True)),
                ('english_3', models.CharField(max_length=255, null=True)),
                ('chinese_simple_jieba', models.TextField(editable=False, null=True)),
                ('chinese_traditional_jieba', models.TextField(editable=False, null=True)),
            ],
        ),
    ]

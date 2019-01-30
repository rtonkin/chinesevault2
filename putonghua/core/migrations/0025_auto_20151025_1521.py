# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0024_auto_20150812_1309'),
    ]

    operations = [
        migrations.CreateModel(
            name='Lesson',
            fields=[
                ('id', models.AutoField(serialize=False, primary_key=True, auto_created=True, verbose_name='ID')),
                ('number', models.IntegerField(unique=True)),
                ('name', models.CharField(max_length=255, unique=True)),
                ('description', models.CharField(max_length=511)),
                ('word_usage', models.TextField(max_length=10000)),
                ('example_sentences', models.TextField(max_length=10000)),
                ('new_words', models.ManyToManyField(to='core.Word')),
            ],
        ),
        migrations.AddField(
            model_name='userprofile',
            name='lessons_finished',
            field=models.ManyToManyField(to='core.Lesson'),
        ),
    ]

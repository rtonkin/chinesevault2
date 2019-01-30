# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0012_word_pinyin_normalized'),
    ]

    operations = [
        migrations.CreateModel(
            name='CardList',
            fields=[
                ('id', models.AutoField(serialize=False, verbose_name='ID', auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=128, db_index=True)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='UserCard',
            fields=[
                ('id', models.AutoField(serialize=False, verbose_name='ID', auto_created=True, primary_key=True)),
                ('score', models.FloatField(default=0, db_index=True)),
                ('times_tested', models.IntegerField(default=0, db_index=True)),
                ('owner', models.ForeignKey(to=settings.AUTH_USER_MODEL)),
                ('word', models.ForeignKey(to='core.Word')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.AddField(
            model_name='cardlist',
            name='cards',
            field=models.ManyToManyField(to='core.UserCard'),
        ),
        migrations.AddField(
            model_name='cardlist',
            name='owner',
            field=models.ForeignKey(to=settings.AUTH_USER_MODEL),
        ),
    ]

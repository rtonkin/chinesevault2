# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0066_auto_20151115_1546'),
    ]

    operations = [
        migrations.CreateModel(
            name='PubSentenceCard',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('sentence', models.ForeignKey(to='core.ExampleSentence')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='SentenceCardList',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(db_index=True, max_length=128)),
                ('last_practiced', models.DateTimeField(null=True)),
            ],
        ),
        migrations.CreateModel(
            name='UserSentenceCard',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('score', models.FloatField(default=0, db_index=True)),
                ('times_tested', models.IntegerField(default=0, db_index=True)),
                ('last_practiced', models.DateTimeField(null=True)),
                ('owner', models.ForeignKey(to=settings.AUTH_USER_MODEL)),
                ('sentence', models.ForeignKey(to='core.ExampleSentence')),
            ],
        ),
        migrations.AddField(
            model_name='sentencecardlist',
            name='cards',
            field=models.ManyToManyField(to='core.UserSentenceCard'),
        ),
        migrations.AddField(
            model_name='sentencecardlist',
            name='owner',
            field=models.ForeignKey(to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterUniqueTogether(
            name='usersentencecard',
            unique_together=set([('sentence', 'owner')]),
        ),
        migrations.AlterUniqueTogether(
            name='sentencecardlist',
            unique_together=set([('name', 'owner')]),
        ),
    ]

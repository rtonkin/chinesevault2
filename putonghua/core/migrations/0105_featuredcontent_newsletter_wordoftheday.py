# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import tinymce.models
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0104_subtitled_themes'),
    ]

    operations = [
        migrations.CreateModel(
            name='FeaturedContent',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, primary_key=True, verbose_name='ID')),
                ('title', models.CharField(max_length=255)),
                ('description', models.TextField()),
                ('feature_image', models.ImageField(upload_to='staticfiles/images/featured-content/')),
                ('creation_date', models.DateField(auto_now_add=True)),
                ('modification_date', models.DateTimeField(auto_now=True)),
                ('content', models.ForeignKey(to='core.AudioStudyItem')),
            ],
        ),
        migrations.CreateModel(
            name='NewsLetter',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, primary_key=True, verbose_name='ID')),
                ('email', models.EmailField(default='', max_length=70)),
            ],
        ),
        migrations.CreateModel(
            name='WordOfTheDay',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, primary_key=True, verbose_name='ID')),
                ('title', models.CharField(max_length=255)),
                ('creation_date', models.DateField(default=datetime.date(2018, 2, 26), null=True, unique=True)),
                ('modification_date', models.DateTimeField(auto_now=True)),
                ('description', tinymce.models.HTMLField()),
            ],
        ),
    ]

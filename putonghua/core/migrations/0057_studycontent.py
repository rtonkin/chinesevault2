# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import tinymce.models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0056_searchhistoryitem'),
    ]

    operations = [
        migrations.CreateModel(
            name='StudyContent',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, primary_key=True, verbose_name='ID')),
                ('content_type', models.IntegerField(choices=[(1, 'Article'), (2, 'Poem'), (3, 'Song')], default=1)),
                ('chinese_name', models.CharField(max_length=255)),
                ('english_name', models.CharField(max_length=255)),
                ('chinese_artist', models.CharField(blank=True, max_length=255, default='')),
                ('english_artist', models.CharField(blank=True, max_length=255, default='')),
                ('text', models.TextField(editable=False)),
                ('text_orig', tinymce.models.HTMLField()),
            ],
        ),
    ]

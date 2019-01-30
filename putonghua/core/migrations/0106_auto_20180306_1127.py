# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0105_featuredcontent_newsletter_wordoftheday'),
    ]

    operations = [
        migrations.AddField(
            model_name='wordoftheday',
            name='pinyin',
            field=models.CharField(default='', null=True, max_length=1024),
        ),
        migrations.AlterField(
            model_name='wordoftheday',
            name='creation_date',
            field=models.DateField(default=datetime.date(2018, 3, 6), null=True, unique=True),
        ),
    ]

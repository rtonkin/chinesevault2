# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0096_auto_20161205_0938'),
    ]

    operations = [
        migrations.CreateModel(
            name='SuggestWord',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, verbose_name='ID', serialize=False)),
                ('chinese', models.TextField()),
                ('english', models.TextField()),
                ('pinyin', models.TextField()),
            ],
        ),
    ]

# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0094_auto_20161104_1503'),
    ]

    operations = [
        migrations.CreateModel(
            name='ChineseNames',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, verbose_name='ID', primary_key=True)),
                ('english', models.CharField(max_length=50)),
                ('sex', models.PositiveIntegerField(default=1, choices=[(1, 'Male'), (2, 'Female')])),
                ('chinese', models.CharField(max_length=50)),
                ('pinyin', models.CharField(max_length=50, blank=True)),
            ],
        ),
    ]

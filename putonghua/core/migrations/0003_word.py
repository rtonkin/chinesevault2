# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import jsonfield.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_auto_20150506_0956'),
    ]

    operations = [
        migrations.CreateModel(
            name='Word',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, primary_key=True, verbose_name='ID')),
                ('simplified', models.CharField(max_length=60, db_index=True)),
                ('traditional', models.CharField(max_length=60, db_index=True)),
                ('pinyin', models.CharField(max_length=60, db_index=True)),
                ('taiwanese_pinyin', models.CharField(max_length=60, db_index=True, null=True, blank=True)),
                ('meanings', jsonfield.fields.JSONField()),
            ],
            options={
                'abstract': False,
            },
        ),
    ]

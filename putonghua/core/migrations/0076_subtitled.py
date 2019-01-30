# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0075_auto_20151221_0924'),
    ]

    operations = [
        migrations.CreateModel(
            name='Subtitled',
            fields=[
                ('id', models.AutoField(primary_key=True, auto_created=True, verbose_name='ID', serialize=False)),
                ('name', models.CharField(max_length=128)),
                ('srt', models.TextField(default='')),
                ('filename', models.FileField(upload_to='sub/')),
            ],
        ),
    ]

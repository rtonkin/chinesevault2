# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Country',
            fields=[
                ('id', models.AutoField(auto_created=True, verbose_name='ID', serialize=False, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=50, db_index=True)),
                ('code', models.CharField(blank=True, max_length=3, unique=True, null=True, db_index=True)),
            ],
        ),
        migrations.AddField(
            model_name='user',
            name='chinese_level',
            field=models.CharField(max_length=20, default='Beginner', null=True, blank=True),
        ),
        migrations.AddField(
            model_name='user',
            name='location',
            field=models.ForeignKey(blank=True, to='core.Country', null=True),
        ),
    ]

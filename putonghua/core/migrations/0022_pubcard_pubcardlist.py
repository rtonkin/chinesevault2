# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0021_auto_20150730_1446'),
    ]

    operations = [
        migrations.CreateModel(
            name='PubCard',
            fields=[
                ('id', models.AutoField(serialize=False, primary_key=True, auto_created=True, verbose_name='ID')),
                ('word', models.ForeignKey(to='core.Word')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='PubCardList',
            fields=[
                ('id', models.AutoField(serialize=False, primary_key=True, auto_created=True, verbose_name='ID')),
                ('name', models.CharField(max_length=128, db_index=True)),
                ('cards', models.ManyToManyField(to='core.UserCard')),
            ],
            options={
                'abstract': False,
            },
        ),
    ]

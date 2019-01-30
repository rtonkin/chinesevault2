# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0009_word_ok'),
    ]

    operations = [
        migrations.CreateModel(
            name='WordReference',
            fields=[
                ('id', models.AutoField(serialize=False, verbose_name='ID', primary_key=True, auto_created=True)),
                ('order', models.IntegerField()),
                ('referenced', models.ForeignKey(related_name='to_word', to='core.Word')),
                ('word', models.ForeignKey(related_name='from_word', to='core.Word')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.AddField(
            model_name='word',
            name='references',
            field=models.ManyToManyField(to='core.Word', related_name='referenced_by', through='core.WordReference'),
        ),
    ]

# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0038_auto_20151027_1402'),
    ]

    operations = [
        migrations.CreateModel(
            name='WordDefinition',
            fields=[
                ('id', models.AutoField(serialize=False, auto_created=True, verbose_name='ID', primary_key=True)),
                ('definition', models.CharField(max_length=255)),
                ('word', models.ForeignKey(to='core.Word')),
            ],
        ),
        migrations.AddField(
            model_name='lesson',
            name='new_words',
            field=models.ManyToManyField(to='core.WordDefinition'),
        ),
    ]

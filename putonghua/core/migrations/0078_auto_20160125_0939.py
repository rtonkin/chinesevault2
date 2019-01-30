# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0077_auto_20160107_1710'),
    ]

    operations = [
        migrations.CreateModel(
            name='AudioStudyItem',
            fields=[
                ('subtitled_ptr', models.OneToOneField(serialize=False, primary_key=True, parent_link=True, auto_created=True, to='core.Subtitled')),
            ],
            bases=('core.subtitled',),
        ),
        migrations.CreateModel(
            name='VideoStudyItem',
            fields=[
                ('subtitled_ptr', models.OneToOneField(serialize=False, primary_key=True, parent_link=True, auto_created=True, to='core.Subtitled')),
            ],
            bases=('core.subtitled',),
        ),
        migrations.AlterModelOptions(
            name='subtitled',
            options={},
        ),
        migrations.RemoveField(
            model_name='subtitled',
            name='filename',
        ),
        migrations.RemoveField(
            model_name='subtitled',
            name='name',
        ),
        migrations.RemoveField(
            model_name='subtitled',
            name='srt',
        ),
    ]

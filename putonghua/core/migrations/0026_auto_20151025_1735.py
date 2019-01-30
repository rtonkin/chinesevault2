# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0025_auto_20151025_1521'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='userprofile',
            name='lessons_finished',
        ),
        migrations.AddField(
            model_name='user',
            name='lessons_completed',
            field=models.ManyToManyField(to='core.Lesson'),
        ),
    ]

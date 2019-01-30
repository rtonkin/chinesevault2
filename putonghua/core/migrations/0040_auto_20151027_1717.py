# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0039_auto_20151027_1658'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='lesson',
            name='new_words',
        ),
        migrations.AddField(
            model_name='worddefinition',
            name='lesson',
            field=models.ForeignKey(default='', to='core.Lesson'),
            preserve_default=False,
        ),
    ]

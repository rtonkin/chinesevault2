# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0036_auto_20151027_1357'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='lesson',
            name='example_sentences',
        ),
        migrations.RemoveField(
            model_name='lesson',
            name='word_usage',
        ),
    ]

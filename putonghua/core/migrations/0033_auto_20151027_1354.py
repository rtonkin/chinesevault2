# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0032_auto_20151026_1851'),
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

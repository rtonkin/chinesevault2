# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0030_auto_20151026_1827'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='lesson',
            name='_example_sentences_rendered',
        ),
        migrations.RemoveField(
            model_name='lesson',
            name='_word_usage_rendered',
        ),
        migrations.RemoveField(
            model_name='lesson',
            name='example_sentences',
        ),
        migrations.RemoveField(
            model_name='lesson',
            name='example_sentences_markup_type',
        ),
        migrations.RemoveField(
            model_name='lesson',
            name='word_usage',
        ),
        migrations.RemoveField(
            model_name='lesson',
            name='word_usage_markup_type',
        ),
    ]

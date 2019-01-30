# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import jsonfield.fields
import tinymce.models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0054_lesson_new_words_converted'),
    ]

    operations = [
        migrations.AlterField(
            model_name='lesson',
            name='example_sentences_orig',
            field=tinymce.models.HTMLField(),
        ),
        migrations.AlterField(
            model_name='lesson',
            name='new_words_converted',
            field=jsonfield.fields.JSONField(editable=False),
        ),
        migrations.AlterField(
            model_name='lesson',
            name='word_usage_orig',
            field=tinymce.models.HTMLField(),
        ),
    ]

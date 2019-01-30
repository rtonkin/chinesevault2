# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import markupfield.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0029_auto_20151026_1714'),
    ]

    operations = [
        migrations.AddField(
            model_name='lesson',
            name='example_sentences_orig',
            field=models.TextField(default=' '),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='lesson',
            name='word_usage_orig',
            field=models.TextField(default=' '),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='lesson',
            name='example_sentences',
            field=markupfield.fields.MarkupField(editable=False, rendered_field=True),
        ),
        migrations.AlterField(
            model_name='lesson',
            name='word_usage',
            field=markupfield.fields.MarkupField(editable=False, rendered_field=True),
        ),
    ]

# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import markupfield.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0028_auto_20151026_1709'),
    ]

    operations = [
        migrations.AddField(
            model_name='lesson',
            name='_example_sentences_rendered',
            field=models.TextField(editable=False, default=' '),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='lesson',
            name='_word_usage_rendered',
            field=models.TextField(editable=False, default=' '),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='lesson',
            name='example_sentences',
            field=markupfield.fields.MarkupField(rendered_field=True, default=' '),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='lesson',
            name='example_sentences_markup_type',
            field=models.CharField(editable=False, max_length=30, choices=[('', '--'), ('html', 'HTML'), ('plain', 'Plain'), ('restructuredtext', 'Restructured Text')], default='restructuredtext'),
        ),
        migrations.AddField(
            model_name='lesson',
            name='word_usage',
            field=markupfield.fields.MarkupField(rendered_field=True, default=' '),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='lesson',
            name='word_usage_markup_type',
            field=models.CharField(editable=False, max_length=30, choices=[('', '--'), ('html', 'HTML'), ('plain', 'Plain'), ('restructuredtext', 'Restructured Text')], default='restructuredtext'),
        ),
    ]

# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0026_auto_20151025_1735'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='lesson',
            name='new_words',
        ),
        migrations.AddField(
            model_name='lesson',
            name='example_sentences_html',
            field=models.TextField(editable=False, default=''),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='lesson',
            name='word_usage_html',
            field=models.TextField(editable=False, default=''),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='lesson',
            name='example_sentences',
            field=models.TextField(),
        ),
        migrations.AlterField(
            model_name='lesson',
            name='word_usage',
            field=models.TextField(),
        ),
    ]

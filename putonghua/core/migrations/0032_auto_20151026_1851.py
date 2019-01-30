# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0031_auto_20151026_1850'),
    ]

    operations = [
        migrations.AddField(
            model_name='lesson',
            name='example_sentences',
            field=models.TextField(editable=False, default=' '),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='lesson',
            name='word_usage',
            field=models.TextField(editable=False, default=' '),
            preserve_default=False,
        ),
    ]

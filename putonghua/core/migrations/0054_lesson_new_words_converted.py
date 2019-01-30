# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import jsonfield.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0053_lesson_new_words'),
    ]

    operations = [
        migrations.AddField(
            model_name='lesson',
            name='new_words_converted',
            field=jsonfield.fields.JSONField(default=[]),
            preserve_default=False,
        ),
    ]

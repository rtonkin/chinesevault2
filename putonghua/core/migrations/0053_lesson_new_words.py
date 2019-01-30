# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django_hstore.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0052_remove_lesson_new_words'),
    ]

    operations = [
        migrations.AddField(
            model_name='lesson',
            name='new_words',
            field=django_hstore.fields.DictionaryField(default={}),
            preserve_default=False,
        ),
    ]

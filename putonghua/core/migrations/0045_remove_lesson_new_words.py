# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0044_lesson_new_words'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='lesson',
            name='new_words',
        ),
    ]

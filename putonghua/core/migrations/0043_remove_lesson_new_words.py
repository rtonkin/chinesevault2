# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0042_auto_20151027_1723'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='lesson',
            name='new_words',
        ),
    ]

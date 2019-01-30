# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0074_auto_20151221_0918'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='examplesentence',
            options={'verbose_name': 'Sentence', 'verbose_name_plural': 'Sentences'},
        ),
    ]

# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0006_word_classifier'),
    ]

    operations = [
        migrations.AlterField(
            model_name='word',
            name='classifier',
            field=models.CharField(null=True, blank=True, max_length=128),
        ),
    ]

# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0005_word_frequency'),
    ]

    operations = [
        migrations.AddField(
            model_name='word',
            name='classifier',
            field=models.CharField(max_length=40, blank=True, null=True),
        ),
    ]

# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.contrib.postgres.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0063_auto_20151111_0731'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examplesentence',
            name='chinese_simple_words',
            field=django.contrib.postgres.fields.ArrayField(null=True, editable=False, base_field=models.CharField(null=True, max_length=10, blank=True), size=None),
        ),
    ]

# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0040_auto_20151027_1717'),
    ]

    operations = [
        migrations.AddField(
            model_name='lesson',
            name='new_words',
            field=models.ManyToManyField(to='core.Word', through='core.WordDefinition'),
        ),
    ]

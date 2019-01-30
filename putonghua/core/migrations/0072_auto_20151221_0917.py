# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0071_auto_20151213_2016'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examplesentence',
            name='sound_file',
            field=models.FileField(upload_to='tts/sentences/', null=True, blank=True),
        ),
    ]

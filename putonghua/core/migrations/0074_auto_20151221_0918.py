# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0073_auto_20151221_0918'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examplesentence',
            name='sound_file',
            field=models.FileField(null=True, upload_to='tts/sentences/', blank=True),
        ),
    ]

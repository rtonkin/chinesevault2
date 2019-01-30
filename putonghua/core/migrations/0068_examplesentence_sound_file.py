# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0067_auto_20151205_1021'),
    ]

    operations = [
        migrations.AddField(
            model_name='examplesentence',
            name='sound_file',
            field=models.FileField(upload_to='tts/sentences/', null=True),
        ),
    ]

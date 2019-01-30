# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0069_word_hsk_level'),
    ]

    operations = [
        migrations.AlterField(
            model_name='word',
            name='sound_file',
            field=models.FileField(blank=True, null=True, upload_to='tts/'),
        ),
    ]

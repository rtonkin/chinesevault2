# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0064_auto_20151111_0732'),
    ]

    operations = [
        migrations.AddField(
            model_name='word',
            name='sound_file',
            field=models.FileField(null=True, upload_to='tts/'),
        ),
    ]

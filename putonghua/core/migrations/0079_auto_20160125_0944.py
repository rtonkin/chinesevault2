# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import putonghua.core.models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0078_auto_20160125_0939'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='subtitled',
            options={'verbose_name': 'Subtitled object', 'verbose_name_plural': 'Subtitled objects'},
        ),
        migrations.AddField(
            model_name='subtitled',
            name='filename',
            field=models.FileField(validators=[putonghua.core.models.Subtitled.validate_file_extension], default='', upload_to='content/sub/'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='subtitled',
            name='name',
            field=models.CharField(max_length=128, default=''),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='subtitled',
            name='srt',
            field=models.TextField(default=''),
        ),
    ]

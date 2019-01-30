# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0081_subtitled_description'),
    ]

    operations = [
        migrations.AddField(
            model_name='videostudyitem',
            name='thumbnail',
            field=models.ImageField(default='', upload_to='content/study/video/sub/thumbnails'),
            preserve_default=False,
        ),
    ]

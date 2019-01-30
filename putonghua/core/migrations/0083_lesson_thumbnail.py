# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0082_videostudyitem_thumbnail'),
    ]

    operations = [
        migrations.AddField(
            model_name='lesson',
            name='thumbnail',
            field=models.ImageField(upload_to='content/study/lessons/thumbnails', blank=True),
        ),
    ]

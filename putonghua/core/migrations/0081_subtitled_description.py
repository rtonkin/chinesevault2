# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0080_auto_20160125_1021'),
    ]

    operations = [
        migrations.AddField(
            model_name='subtitled',
            name='description',
            field=models.TextField(blank=True),
        ),
    ]

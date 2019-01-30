# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0020_auto_20150601_2153'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='country',
            options={'ordering': ['name']},
        ),
    ]

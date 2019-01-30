# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0076_subtitled'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='subtitled',
            options={'verbose_name_plural': 'Subtitled objects', 'verbose_name': 'Subtitled object'},
        ),
    ]

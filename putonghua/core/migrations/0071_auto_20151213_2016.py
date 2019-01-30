# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0070_auto_20151211_1740'),
    ]

    operations = [
        migrations.AlterField(
            model_name='word',
            name='hsk_level',
            field=models.IntegerField(blank=True, choices=[(1, 'HSK 1'), (2, 'HSK 2'), (3, 'HSK 3'), (4, 'HSK 4'), (5, 'HSK 5'), (6, 'HSK 6')], null=True),
        ),
    ]

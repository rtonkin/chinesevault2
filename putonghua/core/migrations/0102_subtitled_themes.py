# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0101_auto_20170306_1411'),
    ]

    operations = [
        migrations.AddField(
            model_name='subtitled',
            name='themes',
            field=models.IntegerField(default='1', choices=[(1, 'Education'), (2, 'Hobbies'), (3, 'People'), (4, 'Society'), (5, 'Technology')]),
            preserve_default=False,
        ),
    ]

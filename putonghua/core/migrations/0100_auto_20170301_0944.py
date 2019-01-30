# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0099_auto_20170301_0935'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='pubcard',
            name='word',
        ),
        migrations.DeleteModel(
            name='PubCard',
        ),
    ]

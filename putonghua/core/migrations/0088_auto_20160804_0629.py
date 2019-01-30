# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0087_tones_for_practice'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Tones_for_practice',
            new_name='TonesForPractice',
        ),
    ]

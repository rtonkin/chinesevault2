# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0084_auto_20160404_1337'),
    ]

    operations = [
        migrations.AlterField(
            model_name='studycontent',
            name='study_level',
            field=models.IntegerField(choices=[(10, 'Beginner'), (20, 'Intermediate'), (30, 'Advanced')]),
        ),
        migrations.AlterField(
            model_name='subtitled',
            name='study_level',
            field=models.IntegerField(choices=[(10, 'Beginner'), (20, 'Intermediate'), (30, 'Advanced')]),
        ),
    ]

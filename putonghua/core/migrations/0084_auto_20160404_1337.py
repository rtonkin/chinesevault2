# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0083_lesson_thumbnail'),
    ]

    operations = [
        migrations.AddField(
            model_name='studycontent',
            name='study_level',
            field=models.IntegerField(choices=[('10', 'Beginner'), ('20', 'Intermediate'), ('30', 'Advanced')], default=10),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='subtitled',
            name='study_level',
            field=models.IntegerField(choices=[('10', 'Beginner'), ('20', 'Intermediate'), ('30', 'Advanced')], default=10),
            preserve_default=False,
        ),
    ]

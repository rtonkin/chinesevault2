# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0086_reason'),
    ]

    operations = [
        migrations.CreateModel(
            name='Tones_for_practice',
            fields=[
                ('id', models.AutoField(primary_key=True, auto_created=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255, null=True, blank=True, verbose_name='Name_of_tone', default='undefined')),
                ('tone_file', models.FileField(upload_to='voices_for_practice/')),
            ],
        ),
    ]

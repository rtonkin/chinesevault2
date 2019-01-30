# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0088_auto_20160804_0629'),
    ]

    operations = [
        migrations.AlterField(
            model_name='tonesforpractice',
            name='name',
            field=models.CharField(null=True, max_length=255, default='undefined', verbose_name='NameOfTone', blank=True),
        ),
    ]

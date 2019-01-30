# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0089_auto_20160804_0631'),
    ]

    operations = [
        migrations.AddField(
            model_name='tonesforpractice',
            name='pinyin_normalized',
            field=models.CharField(max_length=128, blank=True, null=True, default='undefined'),
        ),
    ]

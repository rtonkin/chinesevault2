# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0090_tonesforpractice_pinyin_normalized'),
    ]

    operations = [
        migrations.AddField(
            model_name='studycontent',
            name='description',
            field=models.CharField(default='default description', max_length=511),
        ),
    ]

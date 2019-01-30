# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0023_auto_20150812_1305'),
    ]

    operations = [
        migrations.AlterField(
            model_name='pubcardlist',
            name='cards',
            field=models.ManyToManyField(to='core.Word'),
        ),
    ]

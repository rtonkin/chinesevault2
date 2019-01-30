# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0079_auto_20160125_0944'),
    ]

    operations = [
        migrations.AlterField(
            model_name='subtitled',
            name='filename',
            field=models.FileField(upload_to='content/sub/'),
        ),
    ]

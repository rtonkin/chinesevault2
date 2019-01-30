# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0097_suggestword'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='unsubscribe_status',
            field=models.BooleanField(default=False),
        ),
    ]

# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import jsonfield.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0010_auto_20150511_0250'),
    ]

    operations = [
        migrations.AddField(
            model_name='word',
            name='meanings_references',
            field=jsonfield.fields.JSONField(default=''),
        ),
    ]

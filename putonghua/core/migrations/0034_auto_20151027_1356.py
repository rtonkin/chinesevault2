# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import jsonfield.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0033_auto_20151027_1354'),
    ]

    operations = [
        migrations.AddField(
            model_name='lesson',
            name='example_sentences',
            field=jsonfield.fields.JSONField(default=' ', editable=False),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='lesson',
            name='word_usage',
            field=jsonfield.fields.JSONField(default=' ', editable=False),
            preserve_default=False,
        ),
    ]

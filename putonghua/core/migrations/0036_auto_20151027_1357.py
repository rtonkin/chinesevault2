# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import jsonfield.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0035_auto_20151027_1357'),
    ]

    operations = [
        migrations.AddField(
            model_name='lesson',
            name='example_sentences',
            field=jsonfield.fields.JSONField(editable=False, default=' '),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='lesson',
            name='word_usage',
            field=jsonfield.fields.JSONField(editable=False, default=' '),
            preserve_default=False,
        ),
    ]

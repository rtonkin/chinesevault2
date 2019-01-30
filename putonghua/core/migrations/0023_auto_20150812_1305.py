# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0022_pubcard_pubcardlist'),
    ]

    operations = [
        migrations.AlterField(
            model_name='pubcardlist',
            name='cards',
            field=models.ManyToManyField(to='core.PubCard'),
        ),
    ]

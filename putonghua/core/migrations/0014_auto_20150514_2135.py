# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0013_auto_20150514_2040'),
    ]

    operations = [
        migrations.AddField(
            model_name='cardlist',
            name='last_practiced',
            field=models.DateTimeField(null=True),
        ),
        migrations.AddField(
            model_name='usercard',
            name='last_practiced',
            field=models.DateTimeField(null=True),
        ),
        migrations.AlterUniqueTogether(
            name='cardlist',
            unique_together=set([('name', 'owner')]),
        ),
        migrations.AlterUniqueTogether(
            name='usercard',
            unique_together=set([('word', 'owner')]),
        ),
    ]

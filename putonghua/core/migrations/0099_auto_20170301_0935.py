# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0098_user_unsubscribe_status'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userprofile',
            name='privacy',
            field=models.CharField(choices=[('open', 'Open'), ('registered', 'Registered'), ('closed', 'Closed')], help_text='Designates who can view your profile.', verbose_name='privacy', default='open', max_length=15),
        ),
    ]

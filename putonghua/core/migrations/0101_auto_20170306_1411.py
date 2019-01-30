# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0100_auto_20170301_0944'),
    ]

    operations = [
        migrations.CreateModel(
            name='PubCard',
            fields=[
                ('id', models.AutoField(serialize=False, primary_key=True, auto_created=True, verbose_name='ID')),
                ('word', models.ForeignKey(to='core.Word')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='privacy',
            field=models.CharField(max_length=15, default='registered', choices=[('open', 'Open'), ('registered', 'Registered'), ('closed', 'Closed')], help_text='Designates who can view your profile.', verbose_name='privacy'),
        ),
    ]

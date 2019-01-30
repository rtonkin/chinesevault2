# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import sortedm2m.fields

from  sortedm2m.operations import AlterSortedManyToManyField

class Migration(migrations.Migration):

    dependencies = [
        ('core', '0065_word_sound_file'),
    ]

    operations = [
        AlterSortedManyToManyField(
            model_name='pubcardlist',
            name='cards',
            field=sortedm2m.fields.SortedManyToManyField(to='core.Word', help_text=None),
        ),
    ]

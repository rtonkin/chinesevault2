#!/usr/bin/env python
#coding: utf-8

import os
from django.core.management.base import BaseCommand, CommandError
from putonghua.core.models import Word

FN = 'FINAL Output  HSK Official 2012 L'
EXT = '.txt'
DIR = 'resources/hsk/'
OUTDIR = 'resources/hsk/output/'

class Command(BaseCommand):
    help = 'Import HSK data to DATABASE'

    def handle(self, *args, **options):
        print('Clearing old hsk values')
        for word in Word.objects.filter(hsk_level__isnull=False):
            print(word)
            word.hsk_level = None
            word.save()
        counter = 0
        nfw_counter = 0
        nf_list = []
        for level in range(1,7):
            filename = FN + str(level) + EXT
            print('Processing %s' % filename)
            with open(os.path.join(DIR, filename)) as f:
                for n, line in enumerate(f):
                    counter += 1
                    lw = line.strip().replace('\ufeff', '')
                    split = lw.split(' : ')
                    symbols = split[0]
                    w_id_ok = True
                    try:
                        word_id = int(split[1])
                    except ValueError:
                        word_id = split[1]
                        w_id_ok = False
                        word = None
                    if w_id_ok:
                        try:
                            word = Word.objects.get(id=word_id)
                        except Word.DoesNotExist:
                            word = None
                    if word and word.simplified == symbols:
                        pass
                        word.hsk_level = level
                        word.save()
                    else:
                        print('L%s : Word %s %s not found' % (level, symbols, word_id))
                        nfw_counter += 1
                        nf_list.append((level, symbols, word_id))
        print('Processed %s words, not found %s (%s)' % (
            counter,
            nfw_counter,
            str(nf_list)
            ))






#!/usr/bin/env python
#coding: utf-8

import os
from django.core.management.base import BaseCommand, CommandError
from putonghua.core.models import Word

FL = ['HSK Official 2012 L1.txt',
      'HSK Official 2012 L2.txt',
      'HSK Official 2012 L3.txt',
      'HSK Official 2012 L4.txt',
      'HSK Official 2012 L5.txt',
      'HSK Official 2012 L6.txt',
]

PREFIX = 'Output '
DIR = 'resources/hsk/'
OUTDIR = 'resources/hsk/output/'

class Command(BaseCommand):
    help = 'Process HSK files line by line (searching for word ids)'

    def handle(self, *args, **options):
        counter = 0
        nfw_counter = 0
        nf_list = []
        for filename in FL:
            with open(os.path.join(DIR, filename)) as f:
                with open(
                    os.path.join(OUTDIR, '%s %s' % (PREFIX, filename)), 'w'
                    ) as output:
                    for n, line in enumerate(f):
                        counter += 1
                        lw = line.strip().replace('\ufeff', '')
                        words = Word.objects.filter(simplified=lw)
                        if words:
                            s = ' '.join([str(w.id) for w in words])
                            print('%s : %s' % (lw, s), file=output)
                        else:
                            print('%s : Word not found' % (lw), file=output)
                            nfw_counter += 1
                            nf_list.append(lw)
        print('Processed %s words, not found %s (%s)' % (
            counter,
            nfw_counter,
            str(nf_list)
            ))






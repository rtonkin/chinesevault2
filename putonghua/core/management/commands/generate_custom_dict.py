import os
from django.core.management.base import BaseCommand, CommandError
from putonghua.core.models import Word
from django.conf import settings as s

fn = os.path.join(s.BASE_DIR, '../resources/dict.txt.big.txt')
result_fn = os.path.join(s.BASE_DIR, '../resources/generated_dict.txt')
class Command(BaseCommand):
    help = 'Generate custom dictionary'


    def handle(self, *args, **options):
        frequencies = {}
        result = {}
        with open(fn, 'r') as f:
            for line in f:
                splitted = line.split(' ')
                # save freq and type to dict
                frequencies[splitted[0]] = (splitted[1], splitted[2])
        c = 0
        for i, word in enumerate(Word.objects.all()):
            if i % 100 == 0:
                print(i)
            entry = frequencies.get(word.traditional, None)
            if entry:
                result[word.traditional] = (entry[0], entry[1])
            else:
                result[word.traditional] = (1, 'empty\n')
            entry = frequencies.get(word.simplified, None)
            if entry:
                result[word.simplified] = (entry[0], entry[1])
            else:
                result[word.traditional] = (1, 'empty\n')
                c += 1
        with open(result_fn, 'w') as f:
            for k in result.keys():
                if ' ' in k:
                    print('wrong word (%s)' % k)
                else:
                    try:
                        f.write('%s %s %s' % (k, result[k][0], result[k][1]))
                    except IndexError as e:
                        print(k, result[k])
        print('words without data: ', c)


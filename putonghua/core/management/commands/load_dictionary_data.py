import os
from django.core.management.base import BaseCommand, CommandError
from putonghua.core.models import Word


class Command(BaseCommand):
    help = 'Load dictionary entries from file'

    def add_arguments(self, parser):
        # Positional arguments
        parser.add_argument('file', type=str)

        # Optional (named) arguments
        parser.add_argument('--test',
            action='store_true',
            dest='test',
            default=False,
            help='Only parse for entries and report errors without modifying the database')

        parser.add_argument('--verbose',
            action='store_true',
            dest='verbose',
            default=False,
            help='Output more data')

    def handle(self, *args, **options):
        fname = options.get('file')
        test = options.get('test')
        verbose = options.get('verbose')

        if not os.path.exists(fname):
            self.stdout.write("File {0} not found".format(fname))
            return

        entries = []
        error_count = 0
        with open(fname) as datafile:
            for linenum, line in enumerate(datafile.readlines()):
                entry_data = Word.parse_dict_entry(line.strip())
                if entry_data:
                    entry_data['pinyin'] = entry_data['pinyin'].replace(' ', '')
                    entry_data['taiwanese_pinyin'] = entry_data.get('taiwanese_pinyin', '').replace(' ', '') if entry_data.get('taiwanese_pinyin', '') else ''
                    entry = Word(**entry_data)
                    entries.append(entry)
                else:
                    error_count += 1
                    if verbose:
                        self.stdout.write("Can't parse entry (line {0}): {1}".format(linenum, line))

        if not test:
            Word.objects.bulk_create(entries)

        self.stdout.write("{0} entries loaded, {1} errors".format(len(entries), error_count))

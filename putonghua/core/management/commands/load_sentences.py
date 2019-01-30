import os
import csv
from django.core.management.base import BaseCommand, CommandError
from putonghua.core.models import ExampleSentence
from django.db import transaction


class Command(BaseCommand):
    help = 'Load example sentences from file'

    def add_arguments(self, parser):
        # Positional arguments
        parser.add_argument('file', type=str)

        # Optional (named) arguments
        parser.add_argument('--test',
            action='store_true',
            dest='test',
            default=False,
            help='Only parse sentences and report errors without modifying the database')

        parser.add_argument('--verbose',
            action='store_true',
            dest='verbose',
            default=False,
            help='Output more data')

    @transaction.atomic
    def lot_of_saves(self, queryset):
        for i,item in enumerate(queryset):
            if i % 1000 == 0:
                self.stdout.write("%s" % i)
            item.save()

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
            reader = csv.DictReader(datafile)
            for i, row in enumerate(reader):
                if row['English_1'] or row['English_2'] or row['English_3']:
                    try:
                        entry_data = {}
                        entry_data['chinese_simple'] = row['zh-Hans']
                        entry_data['chinese_traditional'] = row['zh-Hant']
                        entry_data['pinyin'] = row['zh-Latn']
                        entry_data['english_1'] = row['English_1']
                        entry_data['english_2'] = row['English_2']
                        entry_data['english_3'] = row['English_3']
                        entry = ExampleSentence(**entry_data)
                        entries.append(entry)
                    except KeyError:
                        error_count += 1
                        if verbose:
                            self.stdout.write("Can't parse entry (line {0}): {1}".format(i, row))
            if not test:
                ExampleSentence.objects.all().delete()
                if verbose:
                    self.stdout.write("Creating objects")
                ExampleSentence.objects.bulk_create(entries)
                if verbose:
                    self.stdout.write("Converting chinese text")
                self.lot_of_saves(ExampleSentence.objects.all())

        self.stdout.write("{0} entries loaded, {1} errors".format(len(entries), error_count))

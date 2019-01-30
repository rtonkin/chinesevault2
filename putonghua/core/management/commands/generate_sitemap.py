import os
from django.core.management.base import BaseCommand, CommandError
from putonghua.core.models import Word
from django.conf import settings as s

DOMAIN = 'http://chinesevault.com/'
PREFIX = '{}app/'.format(DOMAIN)
PATH = os.path.join(s.BASE_DIR, '../frontend/src/')
NAME = 'sitemap'
EXT = '.xml'
SITEMAP_SIZE = 49900

class Command(BaseCommand):
    help = 'Generate sitemap.xml'



    def handle(self, *args, **options):
        def url(u):
            return '<url><loc>{}</loc></url>'.format(u)
        def sitemapurl(u):
            return '<sitemap><loc>{}</loc></sitemap>'.format(u)
        static_written = False
        header_written = False
        output = []
        sitemaps = {}
        counter = 0
        i = 0
        for word in Word.objects.all():
            i += 1
            if not header_written:
                output.append('<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">')
                header_written = True
            if not static_written:
                output.append(url(PREFIX))
                output.append(url(PREFIX+'dictionary'))
                output.append(url(PREFIX+'about'))
                output.append(url(PREFIX+'terms-of-use'))
                output.append(url(PREFIX+'privacy-policy'))
                output.append(url(PREFIX+'contact'))
                output.append(url(PREFIX+'word_chart'))
                output.append(url(PREFIX+'word_freq'))
                output.append(url(PREFIX+'char_freq'))
                output.append(url(PREFIX+'pinyin_chart'))
                static_written = True
            output.append(url(PREFIX+'word/{}'.format(word.id)))
            if i >= SITEMAP_SIZE:
                i = 0
                counter += 1
                output.append('</urlset>')
                sitemaps[counter] = output
                output = []
                header_written = False
        counter += 1
        output.append('</urlset>')
        sitemaps[counter] = output
        output = []
        output.append('<?xml version="1.0" encoding="UTF-8"?><sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">')
        for sitemap in sitemaps.keys():
            output.append(sitemapurl(DOMAIN+NAME+str(sitemap)+EXT))
        output.append('</sitemapindex>')
        with open(os.path.join(PATH, NAME+EXT), 'w') as mainsitemap:
            for line in output:
                mainsitemap.write(line)
        output = []
        for k in sitemaps.keys():
            fn = os.path.join(PATH, NAME+str(k)+EXT)
            with open(fn, 'w') as f:
                for line in sitemaps[k]:
                    f.write(line)

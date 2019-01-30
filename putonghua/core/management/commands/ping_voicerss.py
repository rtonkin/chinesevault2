import datetime
from django.core.management.base import BaseCommand, CommandError
from putonghua.core.models import Word, ExampleSentence

from django.db.models import Q


class Command(BaseCommand):
    help = 'Search for the random word without sound_file and download it'


    def _proceed_object(self, obj, left, tp):
        with open('voicerss.log', 'a') as f:
            current_time = datetime.datetime.now().time()
            t = current_time.isoformat().split('.')[0]
            s = '%s\tfetching sound for a %s id: %s\t%s objects left\n' % (t, tp, obj.id, left)
            f.write(s)
            self.stdout.write(s)
        obj.get_sound_url()


    def handle(self, *args, **options):
        words = Word.objects.filter(Q(sound_file='')|Q(sound_file=None)).order_by('?')
        sentences = ExampleSentence.objects.filter(Q(sound_file='')|Q(sound_file=None)).order_by('?')
        words_count=words.count()
        sentences_count=sentences.count()
        self.stdout.write('Proceeding request to VoiceRSS')
        count = 2
        for word in words:
            if count <= 0:
                break
            self._proceed_object(word, words_count, 'word')
            words_count -= 1
            count -= 1
        count = 2
        for s in sentences:
            if count <= 0:
                break
            self._proceed_object(s, sentences_count, 'sentnece')
            sentences_count -= 1
            count -= 1



# encoding: utf-8
import re
import collections
from urllib import parse as urlparse
from urllib.parse import quote
from urllib import request
import os.path
import json
import sys
from jsonfield import JSONField
from django.db import models
from django.conf import settings
from django.db import transaction
from django.db.models import signals
from django.dispatch.dispatcher import receiver
from django.contrib.auth.models import AbstractUser
from django.contrib.auth.models import User
from userena.models import UserenaBaseProfile
from django.utils.functional import cached_property
from django.forms import ValidationError
from django.core.files import File
import zhongguolib
from zhongguolib.validators import is_hanzi

from .helpers import jiebasplit, highlight_chinese
from django_hstore import hstore
from tinymce.models import HTMLField

from sortedm2m.fields import SortedManyToManyField
import hanzidentifier
from django.contrib.postgres.fields import ArrayField
from djstripe.utils import subscriber_has_active_subscription
from .models_abstract import (Levelable,
                              BaseCard,
                              BaseCardList,
                              BaseSentenceCard,
                              Descriptable,
                              Nameable,
                              PutonghuaAbstractModel)


from django.db.models.signals import pre_save
from django.dispatch import receiver

from jianfan import ftoj, jtof
from django.utils.safestring import mark_safe
from datetime import date

class User(AbstractUser):
    location = models.ForeignKey('Country', null=True, blank=True)
    unsubscribe_status = models.BooleanField(blank=True, default=False)
    chinese_level = models.CharField(max_length=20, null=True, blank=True,
                                     default='Beginner')
    lessons_completed = models.ManyToManyField('Lesson')

    def __str__(self):
        return self.username

    def create_card_list(self, name):
        return CardList.objects.get_or_create(name=name, owner=self)

    @cached_property
    def has_active_subscription(self):
        """Checks if a user has an active subscription."""
        return subscriber_has_active_subscription(self)
        # status = subscriber_has_active_subscription(self)
        # if(not status):
        #     self.unsubscribe_status = False
        #     self.save()
        # if (status and not self.unsubscribe_status):
        #     return True
        # else:
        #     return False



# connected to user's post_save signal
def create_user_default_list(**kwargs):
    if kwargs['created']:
        cardlist, _ = CardList.objects.get_or_create(owner=kwargs['instance'],
                                                     name=CardList.DEFAULT_LIST_NAME)
        sentencecardlist, _ = SentenceCardList.objects.get_or_create(owner=kwargs['instance'],
                                                                     name=SentenceCardList.DEFAULT_LIST_NAME)


class UserProfile(UserenaBaseProfile):
    user = models.OneToOneField(User, unique=True, related_name='profile')


class Country(models.Model):
    name = models.CharField(max_length=128, unique=True, db_index=True)
    code = models.CharField(max_length=2, null=False, blank=False, unique=True,
                            db_index=True)

    class Meta:
        ordering = ['name']

    def __str__(self):
        return "{0} ({1})".format(self.name, self.code)


class Search(models.Model):
    text = models.CharField(max_length=255)
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.text

    def save(self, *args, **kwargs):
        """
            Checking for previous searches - to remove search results: like su sup supe super

        """
        last_saved_objects = Search.objects.all().order_by('-timestamp')[:7]
        for obj in last_saved_objects:
            if self.text.startswith(obj.text):  # same
                obj.delete()
        return super().save(*args, **kwargs)


class PubSentenceCard(BaseSentenceCard):
    pass


class PubCard(BaseCard):
    pass


class UserSentenceCard(BaseSentenceCard):
    owner = models.ForeignKey(settings.AUTH_USER_MODEL)
    score = models.FloatField(default=0, db_index=True)
    times_tested = models.IntegerField(default=0, db_index=True)
    last_practiced = models.DateTimeField(null=True)

    class Meta:
        unique_together = ('sentence', 'owner')

    def __str__(self):
        return "{0} [{1}] ({2})".format(self.sentence.chinese_simple,
                                        self.sentence.pinyin,
                                        self.sentence.english_1)


class UserCard(BaseCard):
    owner = models.ForeignKey(settings.AUTH_USER_MODEL)
    score = models.FloatField(default=0, db_index=True)
    times_tested = models.IntegerField(default=0, db_index=True)
    last_practiced = models.DateTimeField(null=True)

    class Meta:
        unique_together = ('word', 'owner')

    def __str__(self):
        return "{0} [{1}] ({2})".format(self.word.simplified,
                                        self.word.pinyin_normalized,
                                        self.owner.username)


class PubCardList(BaseCardList):
    cards = SortedManyToManyField('Word')

    @property
    def words(self):
        return '   '.join([c.simplified for c in self.cards.all()])

    def copy_to(self, words, destination_list):
        cards = [UserCard.objects.get_or_create(owner=destination_list.owner, word=word)[0] for word in words]
        destination_list.cards.add(*cards)
        return cards

    def convert_to_private(self, newowner):
        cards = [UserCard.objects.get_or_create(owner=newowner, word=word)[0] for word in self.cards.all()]
        newcardlist = CardList.objects.get_or_create(name=self.name, owner=newowner)[0]
        newcardlist.cards.add(*cards)
        return newcardlist


class StudyContent(Levelable):
    ARTICLE_CONTENT_TYPE = 1
    POEM_CONTENT_TYPE = 2
    SONG_CONTENT_TYPE = 3
    CONTENT_CHOICES = (
        (ARTICLE_CONTENT_TYPE, 'Article'),
        (POEM_CONTENT_TYPE, 'Poem'),
        (SONG_CONTENT_TYPE, 'Song'),
    )
    number = models.IntegerField(unique=True, null=False, blank=False)
    content_type = models.IntegerField(choices=CONTENT_CHOICES, default=ARTICLE_CONTENT_TYPE)
    description = models.CharField(max_length=511, default='default description')
    chinese_name = models.CharField("Chinese name", blank=False, null=False, max_length=255)
    english_name = models.CharField("English name", blank=False, null=False, max_length=255)
    chinese_artist = models.CharField("Chinese artist (author)", blank=True, default='', max_length=255)
    english_artist = models.CharField("English artist (author)", blank=True, default='', max_length=255)
    source_url = models.URLField("Link to the source", blank=True)
    text = models.TextField(editable=False)
    text_orig = HTMLField()

    def __str__(self):
        return self.chinese_name

    def save(self, *args, **kwargs):
        self.text = highlight_chinese(self.text_orig)
        super().save(*args, **kwargs)


class CardList(BaseCardList):
    cards = models.ManyToManyField('UserCard')
    owner = models.ForeignKey(settings.AUTH_USER_MODEL)
    last_practiced = models.DateTimeField(null=True)

    DEFAULT_LIST_NAME = 'Default'
    DEFAULT_COPY_SUFFIX = 'Copy'

    class Meta:
        unique_together = ('name', 'owner')

    def delete(self, force_delete=False, *args, **kwargs):
        # Default list can't be deleted
        if self.name != self.DEFAULT_LIST_NAME or force_delete:
            return super().delete(*args, **kwargs)

    @transaction.atomic
    def copy(self,user):
    
        cardlist = CardList(owner=user, name="{0} {1}".format(self.name,
                                                                    self.DEFAULT_COPY_SUFFIX))
        cardlist.save()

        self.owner = user
        
        cardlist.cards.add(*CardList.objects.get(
            owner=user, 
            name=self.name
            )
            .cards.all().values_list('id', flat=True))

        return cardlist

    def add_word(self, word):
        """
        Accept either Word instance or a word id
        """
        filters = {'owner': self.owner}
        if isinstance(word, int):
            filters.update({'word_id': word})
        else:
            filters.update({'word': word})

        card, _ = UserCard.objects.get_or_create(**filters)
        self.cards.add(card)

    def add_words(self, words):
        cards = [UserCard(owner=self.owner, word=word) for word in words]
        self.cards.add(*cards)

    def remove_word(self, word):
        cards = UserCard.objects.filter(owner=self.owner, word=word)
        if cards:
            cards[0].delete()

    def remove_words(self, words):
        self.cards.remove(*[card for card in
                            UserCard.objects.filter(owner=self.owner,
                                                    word__in=words)])

    def add_card(self, card):
        self.cards.add(card)

    def add_cards(self, cards):
        self.cards.add(*cards)

    def remove_card(self, card):
        self.cards.remove(card)

    def remove_cards(self, cards):
        self.cards.remove(*cards)

    def copy_to(self, cards, destination_list):
        if self.owner == destination_list.owner:
            destination_list.cards.add(*cards)
            return cards

    @transaction.atomic
    def move_to(self, cards, destination_list):
        if self.owner == destination_list.owner:
            destination_list.cards.add(*cards)
            self.cards.remove(*cards)
            return cards


class SentenceCardList(BaseCardList):
    cards = models.ManyToManyField('UserSentenceCard')
    owner = models.ForeignKey(settings.AUTH_USER_MODEL)
    last_practiced = models.DateTimeField(null=True)

    DEFAULT_LIST_NAME = 'Default'
    DEFAULT_COPY_SUFFIX = 'Copy'

    class Meta:
        unique_together = ('name', 'owner')

    def delete(self, force_delete=False, *args, **kwargs):
        # Default list can't be deleted
        if self.name != self.DEFAULT_LIST_NAME or force_delete:
            return super().delete(*args, **kwargs)

    @transaction.atomic
    def copy(self, user):
        cardlist = SentenceCardList(owner=user, name="{0} {1}".format(self.name,
                                                                    self.DEFAULT_COPY_SUFFIX))
        cardlist.save()

        self.owner = user
        
        cardlist.cards.add(*SentenceCardList.objects.get(
            owner=user, 
            name=self.name
            )
            .cards.all().values_list('id', flat=True))

        return cardlist

    def add_sentence(self, sentence):
        """
        Accept either Sentence instance or a word id
        """
        filters = {'owner': self.owner}
        if isinstance(sentence, int):
            filters.update({'sentence_id': sentence})
        else:
            filters.update({'sentence': sentence})

        card, _ = UserSentenceCard.objects.get_or_create(**filters)
        self.cards.add(card)

    def add_sentences(self, sentences):
        cards = [UserSentenceCard(owner=self.owner, sentence=sentence) for sentence in sentences]
        self.cards.add(*cards)

    def remove_sentence(self, sentence):
        cards = UserSentenceCard.objects.filter(owner=self.owner, sentence=sentence)
        if cards:
            cards[0].delete()

    def remove_sentences(self, sentences):
        self.cards.remove(*[card for card in
                            UserSentenceCard.objects.filter(owner=self.owner,
                                                            sentence__in=sentences)])

    def add_card(self, card):
        self.cards.add(card)

    def add_cards(self, cards):
        self.cards.add(*cards)

    def remove_card(self, card):
        self.cards.remove(card)

    def remove_cards(self, cards):
        self.cards.remove(*cards)

    def copy_to(self, cards, destination_list):
        if self.owner == destination_list.owner:
            destination_list.cards.add(*cards)
            return cards

    @transaction.atomic
    def move_to(self, cards, destination_list):
        if self.owner == destination_list.owner:
            destination_list.cards.add(*cards)
            self.cards.remove(*cards)
            return cards


class WordReference(PutonghuaAbstractModel):
    word = models.ForeignKey('Word', related_name='from_word')
    referenced = models.ForeignKey('Word', related_name='to_word')
    order = models.IntegerField()

    def __str__(self):
        return "{0} - {1} [{2}]".format(self.word.simplified,
                                        self.referenced.simplified, self.order)


class Word(PutonghuaAbstractModel):
    """
    Represent a single dictionary entry of CC-CEDICT (http://cc-cedict.org).
    See http://cc-cedict.org/wiki/format:syntax for a reference to the format
    of a dictionary entry in CC-CEDICT.

    Pinyin representation of the word is saved in numerical format,
    i.e. zhong1guo2,
    instead of zhōngguó.
    """
    CHINESE_UNICODE_START = int('4E00', 16)
    HSK_CHOICES = ((1, 'HSK 1'),
                   (2, 'HSK 2'),
                   (3, 'HSK 3'),
                   (4, 'HSK 4'),
                   (5, 'HSK 5'),
                   (6, 'HSK 6'),
                   )

    simplified = models.CharField(max_length=255, db_index=True)
    traditional = models.CharField(max_length=255, db_index=True)
    pinyin = models.CharField(max_length=128, db_index=True, default='')
    pinyin_neutral = models.CharField(max_length=128, db_index=True,
                                      default='')
    pinyin_normalized = models.CharField(max_length=128, db_index=True,
                                         default='')
    taiwanese_pinyin = models.CharField(max_length=128, db_index=True,
                                        blank=True, default='')
    taiwanese_pinyin_neutral = models.CharField(max_length=128, db_index=True,
                                                blank=True, default='')
    meanings = JSONField(
        load_kwargs={'object_pairs_hook': collections.OrderedDict})
    meanings_references = JSONField(
        load_kwargs={'object_pairs_hook': collections.OrderedDict}, default='')
    frequency = models.FloatField(default=0, db_index=True)
    classifier = models.CharField(max_length=128, null=True, blank=True)
    ok = models.BooleanField(blank=True, default=True)
    references = models.ManyToManyField('self', through='WordReference',
                                        symmetrical=False,
                                        related_name='referenced_by')

    sound_file = models.FileField(upload_to='tts/', null=True, blank=True)
    hsk_level = models.IntegerField(choices=HSK_CHOICES, null=True, blank=True)

    def __str__(self):
        return "{0} [{1}]".format(self.simplified, self.pinyin)

    def get_sound_url(self):
        def _get_sound_url():
            path = str(self.sound_file)
            if os.path.exists(os.path.join(settings.MEDIA_ROOT, path)):
                return urlparse.urljoin(settings.MEDIA_URL, path)
            else:
                raise Exception('File {0} not found'.format(path))

        if self.sound_file:
            """
               file was already fetched
            """
            return _get_sound_url()
        else:
            """
                trying to fetch file from API
            """

            if not settings.VOICERSS_API_KEY:
                raise Exception('You should provide VOICERSS_API_KEY in settings')
            api_url = 'https://api.voicerss.org/?key={0}&src={1}&hl=zh-cn&r=-5&f=48khz_16bit_stereo'.format(
                settings.VOICERSS_API_KEY, quote(self.simplified))
            r = request.urlopen(api_url)
            response = r.read()
            err = False
            try:
                err = response.decode('utf-8').startswith('ERROR')
            except UnicodeDecodeError:
                err = False
            if response and (not err):  # voice rss gives us
                fn = '{0}.mp3'.format(self.id)
                with open('tmp_sound.mp3', 'wb') as f:
                    f.write(response)

                with open('tmp_sound.mp3', 'rb') as f:
                    self.sound_file.save(fn, File(f), True)
                os.remove('tmp_sound.mp3')
                return _get_sound_url()
            else:
                raise Exception('voicerss.org error: {0}'.format(response))

    def compiled_meanings(self, join=True):
        """
        !!  This method is meant to only be used with a special
        prefetch_related query
            which prefetches the references and 'attaches' to them the
            WordReference.order field
        """
        pattern = '\{ref-(\d+?)\}'

        def __repl(match):
            reference = None
            index = int(match.group(1))
            # find the relevant reference for the current position based on
            # it's order field value
            references = self.references.all()

            if not references:
                return self.meanings_references

            reference = references[index]

            return \
                '<a href="#/word/{0}">{1}</a>'.format(
                    reference.id, reference.simplified
                )
            """
            if reference.traditional == reference.simplified:
                # return '<a href="/dictionary/#/word/{0}/">{1}</a>[{
                # 2}]'.format(reference.id, reference.simplified,
                # reference.pinyin_normalized)
                return '<a href="#/word/{0}"><strong lang="zh">{1}</strong></a> [{2}]'.format(
                    reference.id, reference.simplified,
                    reference.pinyin_normalized)
            else:
                # return '<a href="/dictionary/#/word/{0}/">{1}|{2}</a>[{
                # 3}]'.format(reference.id, reference.traditional,
                # reference.simplified,
                # zhongguolib.utils.syllabize_numbered_pinyin(
                # reference.pinyin))
                return '<a href="#/word/{0}"><strong lang="zh-Hans">{1}</strong> | <strong lang="zh-Hant">{2}</strong></a> [{3}]'.format(
                    reference.id, reference.simplified, reference.traditional,
                    zhongguolib.utils.syllabize_numbered_pinyin(
                        reference.pinyin))
            """

        meanings = [re.sub(pattern, __repl, meaning_references)
                    for meaning_references in
                    self.meanings_references.split('/')]

        if join:
            meanings = '/'.join(meanings)

        return meanings

    def parse_references(self, save=False):
        references = []
        pattern = '(?: ((\w+)\|(\w+)\[(.*?)\]))|(?: ((\w+)\[(.*?)\]))|(?: ((' \
                  '\w+)\|(\w+)))'
        matches = re.findall(pattern, self.meanings)

        for index, match in enumerate(matches):
            # remove empty strings:
            # ('', '', '', '榜眼', 'bang3 yan3') to ('榜眼', 'bang3 yan3')
            match = list(filter(lambda x: bool(x), match))

            # reference is either of the form 韭[jiu3] or 古文運動|古文运动
            if len(match) == 3:
                # assume reference is of the form 韭[jiu3]
                whole, simplified, pinyin = match
                traditional = simplified

                # reference is given without pinyin, like 古文運動|古文运动,
                # i.e., pinyin[0] is chinese character
                if ord(pinyin[0]) >= self.CHINESE_UNICODE_START:
                    whole, traditional, simplified = match
                    pinyin = ""

            # reference is of the form 韓非子|韩非子[Han2 Fei1 zi3]
            elif len(match) == 4:
                whole, traditional, simplified, pinyin = match

            referenced = Word.objects.filter(simplified=simplified)
            if referenced:
                references.append(
                    WordReference(word=self, referenced=referenced[0],
                                  order=index))

                meanings_references = self.meanings_references.replace(whole,
                                                                       ' {{'
                                                                       'ref-{0}}}'.format(
                                                                           index))
                self.meanings_references = meanings_references

            else:
                # reference not found in the database, so only
                # normalize/prettify the pinyin
                normalized_pinyin = \
                    zhongguolib.utils.syllabize_numbered_pinyin(
                        pinyin.lower())
                normalized = whole.replace(pinyin, normalized_pinyin)
                meanings_references = self.meanings_references.replace(whole,
                                                                       normalized)
                self.meanings_references = meanings_references

        if not self.meanings_references:
            self.meanings_references = self.meanings

        if save:
            WordReference.objects.bulk_create(references)
            self.save()

        return references

    def determine_frequency(self, update=False):
        """
        Calculate average frequency of the word based on the characters it
        is composed of
        """
        characters = Word.objects.filter(
            simplified__in=[c for c in self.simplified if is_hanzi(c)])

        frequency = sum([c.frequency for c in characters]) / len(characters)

        if update:
            self.frequency = frequency
            self.save()

        return frequency

    @classmethod
    def convert_lowercase(cls, queryset=[], save=False):
        words = []
        queryset = queryset or Word.objects.all()

        for word in queryset:
            try:
                word.pinyin = word.pinyin.lower()
                word.pinyin_neutral = word.pinyin_neutral.lower()
                word.taiwanese_pinyin = word.taiwanese_pinyin.lower()
                word.taiwanese_pinyin_neutral = \
                    word.taiwanese_pinyin_neutral.lower()

            except zhongguolib.validators.InvalidSyllable as e:
                word.ok = False
                print("Error: ", word.id, word.simplified, word.pinyin,
                      word.taiwanese_pinyin)

            if save:
                word.save()
            words.append(word)

        return words

        return words

    @classmethod
    def convert_umlaut(cls, queryset=[], save=False):
        words = []
        queryset = queryset or Word.objects.all()

        for word in queryset:
            try:
                word.pinyin = word.pinyin.replace('u:', 'ü')
                word.pinyin_neutral = word.pinyin_neutral.replace('u:', 'ü')
                word.taiwanese_pinyin = word.taiwanese_pinyin.replace('u:',
                                                                      'ü')
                word.taiwanese_pinyin_neutral = \
                    word.taiwanese_pinyin_neutral.replace(
                        'u:', 'ü')

            except zhongguolib.validators.InvalidSyllable as e:
                word.ok = False
                print("Error: ", word.id, word.simplified, word.pinyin,
                      word.taiwanese_pinyin)

            if save:
                word.save()
            words.append(word)

        return words

    @classmethod
    def add_pinyin_neutral(cls, queryset=[], save=False):
        words = []
        errors = []

        if queryset is None:
            # handle the case when queryset is not provided in arguments
            # (to distinct from the case where empty queryset is supplied!s)
            queryset or Word.objects.all()
        elif not queryset:
            # handle the case when queryset is empty (but not None!)
            return

        MIDDLE_DOT_PINYIN = zhongguolib.constants.MIDDLE_DOT_PINYIN

        for word in queryset:
            try:
                # Splits and joins by MIDDLE_DOT_PINYIN is used so that
                # pinyins like this [ya4dang1·si1mi4] are handled also

                # handle common pinyin
                neutrals = []
                pinyins = word.pinyin.split(MIDDLE_DOT_PINYIN)
                for pinyin in pinyins:
                    separator = '' if MIDDLE_DOT_PINYIN not in word.pinyin \
                        else MIDDLE_DOT_PINYIN
                    neutrals.append(separator.join(
                        [zhongguolib.utils.detone_syllable(syllable)
                         for syllable in
                         zhongguolib.utils.decouple_syllables(pinyin)]))
                word.pinyin_neutral = ''.join(neutrals)

                # handle taiwanese pinyin
                taiwanese_neutrals = []
                taiwanese_pinyins = word.taiwanese_pinyin.split(
                    MIDDLE_DOT_PINYIN)
                for taiwanese_pinyin in taiwanese_pinyins:
                    separator = '' if MIDDLE_DOT_PINYIN not in word.taiwanese_pinyin else MIDDLE_DOT_PINYIN
                    taiwanese_neutrals.append(separator.join(
                        [zhongguolib.utils.detone_syllable(syllable)
                         for syllable in zhongguolib.utils.decouple_syllables(
                            taiwanese_pinyin)]))
                word.taiwanese_pinyin_neutral = ''.join(taiwanese_neutrals)

            except zhongguolib.validators.InvalidSyllable as e:
                word.ok = False
                errors.append(word)
                print("Error: ", word.id, word.simplified, word.pinyin,
                      word.taiwanese_pinyin)

            else:
                if save:
                    word.save()
                words.append(word)

        return (words, errors)

    @classmethod
    def add_pinyin_normalized(cls, queryset=None, save=False):
        words = []
        errors = []

        if queryset is None:
            # handle the case when queryset is not provided in arguments
            # (to distinct from the case where empty queryset is supplied!s)
            queryset or Word.objects.all()
        elif not queryset:
            # handle the case when queryset is empty (but not None!)
            return

        MIDDLE_DOT_PINYIN = zhongguolib.constants.MIDDLE_DOT_PINYIN
        for word in queryset:
            try:
                # Splits and joins by MIDDLE_DOT_PINYIN is used so that
                # pinyins like this [ya4dang1·si1mi4] are handled also

                parts = []
                pinyins = word.pinyin.split(MIDDLE_DOT_PINYIN)
                for pinyin in pinyins:
                    separator = '' if MIDDLE_DOT_PINYIN not in word.pinyin else MIDDLE_DOT_PINYIN
                    parts.append(
                        zhongguolib.utils.syllabize_numbered_pinyin(pinyin))
                word.pinyin_normalized = separator.join(parts)

            except zhongguolib.validators.InvalidSyllable as e:
                # don't change the pinyin
                word.pinyin_normalized = word.pinyin
                word.ok = False
                errors.append(word)
                print("Error: ", word.id, word.simplified, word.pinyin,
                      word.taiwanese_pinyin)

            else:
                if save:
                    word.save()
                words.append(word)

        return (words, errors)

    @classmethod
    def parse_dict_entry(cls, line):
        """
        Parse a single line of text for a CC-CEDICT entry
        """
        patterns = [
            '(?P<traditional>[\w・]+) (?P<simplified>[\w・]+) \[(?P<pinyin>.*)\] (?:/(?P<meanings>.*)/)+$',
            '(?P<traditional>[\w・]+ , [\w・]+) (?P<simplified>[\w・]+ , [\w・]+) \[(?P<pinyin>.*? , .*?)\] (?:/(?P<meanings>.*)/)+$'
        ]

        for pattern in patterns:
            match = re.match(pattern, line)
            if match:
                data = match.groupdict()
                submatch = re.match(
                    '(?P<meanings>.*)/(?:Taiwan pr\. \[(?P<taiwanese_pinyin>.*?)\])',
                    data['meanings'])
                data['taiwanese_pinyin'] = ''
                if submatch:
                    subdata = submatch.groupdict()
                    data['meanings'] = subdata['meanings'].strip('/')
                    data['taiwanese_pinyin'] = subdata.get('taiwanese_pinyin',
                                                           '')
                return data

        print(line)  # see what line could not be parsed to an entry
        return ""


class WordDefinition(models.Model):
    word = models.ForeignKey(Word)
    definition = models.CharField(max_length=255)

    def __str__(self):
        return '%s - %s' % (self.word.simplified, self.definition)


class SearchHistoryItem(models.Model):
    querytext = models.CharField(max_length=255)
    datetime = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.querytext


class Lesson(models.Model):
    number = models.IntegerField(unique=True, null=False, blank=False)
    name = models.CharField(max_length=255, unique=True)
    description = models.CharField(max_length=511)
    
    new_words = hstore.DictionaryField()

    new_words_converted = JSONField(editable=False)
    word_usage = models.TextField(editable=False)
    example_sentences = models.TextField(editable=False)

    word_usage_orig = HTMLField()
    example_sentences_orig = HTMLField()

    thumbnail = models.ImageField(upload_to='content/study/lessons/thumbnails', blank=True)

    objects = hstore.HStoreManager()

    def __str__(self):
        if not self.number:
            self.number = 0
        if not self.name:
            self.name = ""
        return 'Lesson %d. %s' % (self.number, self.name)

    def save(self, *args, **kwargs):
        def convert_word(word):
            try:
                word_id, descr = word
                from django.core import serializers
                data = json.loads(serializers.serialize("json", Word.objects.filter(id=word_id)))[0]
                data = data['fields']
                data['selected_description'] = descr
                data['id'] = int(word_id)
                return data
            except:
                raise Exception

        try:
            self.new_words_converted = json.dumps([convert_word(w) for w in self.new_words.items()])
        except:
            return None
        self.word_usage = highlight_chinese(self.word_usage_orig)
        self.example_sentences = highlight_chinese(self.example_sentences_orig)
        super().save(*args, **kwargs)

    @property
    def new_words_count(self):
        return self.new_words.count()


class ExampleSentenceManager(models.Manager):
    def search_simple(self, word, offset=0):
        return super().get_queryset().filter(chinese_simple_words__contains=[word])[int(offset):int(offset)+20]




class ExampleSentence(models.Model):
    chinese_simple = models.CharField(max_length=1024, null=True, blank=True)
    chinese_traditional = models.CharField(max_length=1024, null=True, blank=True)
    pinyin = models.CharField(max_length=1024, null=True, blank=True)
    english_1 = models.CharField(max_length=1024, null=True, blank=True)
    english_2 = models.CharField(max_length=1024, null=True, blank=True)
    english_3 = models.CharField(max_length=1024, null=True, blank=True)
    chinese_simple_words = ArrayField(models.CharField(max_length=10,
                                                       blank=True,
                                                       null=True),
                                      null=True, editable=False)
    sound_file = models.FileField(upload_to='tts/sentences/', null=True, blank=True)

    objects = ExampleSentenceManager()

    # chinese_traditional_jieba = models.TextField(null=True, editable=False)
    # chinese_simple_words = SortedManyToManyField(Word)
    # chinese_traditional_words = SortedManyToManyField(Word)

    class Meta:
        verbose_name = 'Sentence'
        verbose_name_plural = 'Sentences'

    def get_dictionary(self, word):
        tmp = []
        for w in list(self.chinese_simple_words):
            if w == word:
                tmp.append('<span class="hglt_red"><chinese>%s</chinese></span>' % w)
            else:
                tmp.append('<chinese>%s</chinese>' % w)
        return {'id': self.id,
                'simple': "".join(tmp),
                'pinyin': self.pinyin,
                'english': self.english_1}

    def get_sound_url(self):
        def _get_sound_url():
            path = str(self.sound_file)
            if os.path.exists(os.path.join(settings.MEDIA_ROOT, path)):
                return urlparse.urljoin(settings.MEDIA_URL, path)
            else:
                raise Exception('File {0} not found'.format(path))

        if self.sound_file:
            """
               file was already fetched
            """
            return _get_sound_url()
        else:
            """
                trying to fetch file from API
            """

            if not settings.VOICERSS_API_KEY:
                raise Exception('You should provide VOICERSS_API_KEY in settings')
            api_url = 'https://api.voicerss.org/?key={0}&src={1}&hl=zh-cn&r=-5&f=48khz_16bit_stereo'.format(
                settings.VOICERSS_API_KEY, quote(self.chinese_simple))
            r = request.urlopen(api_url)
            response = r.read()
            err = False
            try:
                err = response.decode('utf-8').startswith('ERROR')
            except UnicodeDecodeError:
                err = False
            if response and (not err):  # voice rss gives us
                fn = '{0}.mp3'.format(self.id)
                with open('tmp_sound.mp3', 'wb') as f:
                    f.write(response)

                with open('tmp_sound.mp3', 'rb') as f:
                    self.sound_file.save(fn, File(f), True)
                os.remove('tmp_sound.mp3')
                return _get_sound_url()
            else:
                raise Exception('voicerss.org error: {0}'.format(response))

    def save(self, *args, **kwargs):
        simple_split = jiebasplit(self.chinese_simple)
        self.chinese_simple_words = simple_split
        super().save(*args, **kwargs)
        # self.chinese_traditional_jieba = jiebasplit(self.chinese_traditional)

    def __str__(self):
        return '%s' % (self.chinese_simple)


class Subtitled(Nameable, Descriptable, Levelable):
    """docstring for Subtitled"""

    def validate_file_extension():
        pass

    upload_to = 'content/sub/'
    extensions = []
    srt = models.TextField(default='')
    srt_pinyin = models.TextField(default='', blank=True)
    srt_pinyin_number = models.TextField(default='', blank=True)
    keywords = models.TextField(default='', blank=True)
    keywords_pinyin = models.TextField(default='', blank=True)
    keywords_description = models.TextField(default='', blank=True)
    filename = models.FileField(upload_to=upload_to)
    THEMES_CHOICES = ((1, 'Education'), (2, 'Hobbies'), (3, 'People'),(4, 'Society'), (5, 'Technology'))
    themes = models.IntegerField(choices=THEMES_CHOICES)

    class Meta:
        verbose_name = 'Subtitled object'
        verbose_name_plural = 'Subtitled objects'

# @receiver(pre_save, sender=Subtitled)
# def my_callback(sender, instance, *args, **kwargs):
#     from xpinyin import Pinyin
#     from .helpers import jiebasplit, pinyin, pin1yin1
#     p = Pinyin()
#     instance.srt_pinyin = p.get_pinyin(instance.srt, ' ', show_tone_marks=True).replace('\n ', '\n')
#     instance.srt_pinyin_number = pin1yin1(instance.srt_pinyin).replace(' \\n ', '')


class VideoStudyItem(Subtitled):
    extensions = ['.mp4']
    upload_to = 'content/study/video/sub/'
    thumbnail = models.ImageField(upload_to='content/study/video/sub/thumbnails')


class AudioStudyItem(Subtitled):
    extensions = ['.mp3']
    upload_to = 'content/study/audio/sub/'


class Reason(models.Model):
    unsubscriber = models.ForeignKey(User, blank=False,null=False)
    text_reason = models.CharField(max_length=255)
    date_reason = models.DateField(default='0')

class TonesForPractice(models.Model):
    name = models.CharField(
        'NameOfTone',
        blank=True,
        null=True,
        max_length=255,
        default='undefined'
     )

    pinyin_normalized = models.CharField(
        max_length=128, 
        blank=True,
        null=True,
        default='undefined'
    )

    tone_file = models.FileField(
        upload_to='voices_for_practice/',
        null=False, 
        blank=False
    )
    
    def __str__(self):
        return self.name

    def save(self,*args, **kwargs):
        if 'mp3' in str(self.tone_file).split('.'):
            nameFile = str(self.tone_file).split('.mp3')[0]
            for name in TonesForPractice.objects.all():
                if nameFile == name.name:
                    raise ValidationError('This mp3 filename already exist.')
            
            if self.name == 'undefined':
                try:
                    nameFile = nameFile.split('/')[1].split('_')[0]
                    self.name = nameFile
                except:
                    self.name = nameFile
            
            if self.pinyin_normalized == 'undefined':
                try:
                    pinyin_normalized = zhongguolib.utils.syllabize_numbered_pinyin(
                        self.name.lower())
                    self.pinyin_normalized = pinyin_normalized
                except:
                    print(sys.exc_info())
                    raise ValidationError('Ale garazh.')
            super().save(*args, **kwargs)
        else:
            raise ValidationError('You can upload only mp3 files. Try again please.')

# SIGNALS #

signals.post_save.connect(create_user_default_list,
                          sender=settings.AUTH_USER_MODEL,
                          dispatch_uid="unique_identifier")


# Receive the pre_delete signal and delete the file associated with the model instance.


@receiver(signals.pre_delete, sender=Subtitled)
def subtitled_delete(sender, instance, **kwargs):
    # Pass false so FileField doesn't save the model.
    instance.filename.delete(False)


@receiver(signals.pre_delete, sender=VideoStudyItem)
def thumbnail_delete(sender, instance, **kwargs):
    # Pass false so FileField doesn't save the model.
    instance.thumbnail.delete(False)


class ChineseName(models.Model):
    SexChoises = (
        (1, 'Male'),
        (2, 'Female')
    )

    english = models.CharField(max_length=50)
    sex = models.PositiveIntegerField(choices=SexChoises, default=1)
    chinese = models.CharField(max_length=50)
    pinyin = models.CharField(max_length=50, blank=True)


class SuggestWord(models.Model):
    chinese = models.TextField()
    english = models.TextField()
    pinyin = models.TextField()

    def user_check(self, *args, **kwargs):
        print("CHECK")


@receiver(pre_save, sender=SuggestWord)
def my_callback(sender, instance, *args, **kwargs):
    from xpinyin import Pinyin
    p = Pinyin()

    if not instance.pinyin:
        instance.pinyin = p.get_pinyin(instance.chinese, ' ', show_tone_marks=True)
    else:
        user_pinyin = p.get_pinyin(instance.chinese, ' ', show_tone_marks=True)
        if not instance.pinyin == user_pinyin:
            instance.pinyin = user_pinyin
			
class WordOfTheDay(models.Model):
    def clean(self):
        if self.creation_date > date.today():
            raise ValidationError('Future Dates Not Allowed')

    title = models.CharField(max_length=255)
    description = models.TextField()
    creation_date = models.DateField(unique=True, default=date.today(), null=True)
    modification_date = models.DateTimeField(auto_now=True)
    pinyin = models.CharField(max_length=1024, null=True, default='')
    description = HTMLField()

class NewsLetter(models.Model):
    email = models.EmailField(max_length=70, default='')

class FeaturedContent(models.Model):
    upload_to = 'staticfiles/images/featured-content/'
    title = models.CharField(max_length=255)
    description = models.TextField()
    feature_image = models.ImageField(upload_to=upload_to)
    creation_date = models.DateField(auto_now_add=True)
    modification_date = models.DateTimeField(auto_now=True)		
    content = models.ForeignKey('AudioStudyItem', blank=False, null=False)

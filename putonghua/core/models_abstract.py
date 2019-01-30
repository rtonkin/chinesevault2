from django.db import models


class Levelable(models.Model):
    LEVEL_CHOICES = ((10, 'Beginner'),
                     (20, 'Intermediate'),
                     (30, 'Advanced'),
                     )
    study_level = models.IntegerField(choices=LEVEL_CHOICES)

    class Meta:
        abstract = True


class PutonghuaAbstractModel(models.Model):
    class Meta:
        abstract = True


class BaseSentenceCard(PutonghuaAbstractModel):
    sentence = models.ForeignKey('ExampleSentence')

    def __str__(self):
        return "{0} [{1}] ({2})".format(self.sentence.chinese_simple,
                                        self.sentence.pinyin,
                                        self.sentence.english_1)

    class Meta:
        abstract = True


class BaseCard(PutonghuaAbstractModel):
    word = models.ForeignKey('Word')

    def __str__(self):
        return "{0} [{1}] ({2})".format(self.word.simplified,
                                        self.word.pinyin_normalized)

    class Meta:
        abstract = True


class BaseCardList(PutonghuaAbstractModel):
    name = models.CharField(max_length=128, db_index=True)

    def __str__(self):
        return self.name

    class Meta:
        abstract = True


class Nameable(models.Model):
    name = models.CharField(max_length=128)

    def __str__(self):
        return self.name

    class Meta:
        abstract = True


class Descriptable(models.Model):
    description = models.TextField(blank=True)

    class Meta:
        abstract = True
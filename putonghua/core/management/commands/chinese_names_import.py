from putonghua.core.models import ChineseName
import xlrd

PATH_TO_XLSX = "/home/incode51/PycharmProjects/Phua/ChineseEnglishNames.xlsx"

from django.core.management.base import BaseCommand

class Command(BaseCommand):
    def handle(self, *args, **kwargs):
        PATH_TO_XLSX = "/home/incode51/PycharmProjects/Phua/ChineseEnglishNames.xlsx"

        book = xlrd.open_workbook(PATH_TO_XLSX, encoding_override="utf-8")
        english1 = book.sheet_by_index(0).col(0)
        chinese1 = book.sheet_by_index(0).col(1)
        pinyin1 = book.sheet_by_index(0).col(2)
        en1 = [i for i in english1 if i.value != '']
        pi1 = [i for i in pinyin1 if i.value != '']
        chi1 = [i for i in chinese1 if i.value != '']
        col1 = zip(en1, chi1, pi1)

        english2 = book.sheet_by_index(0).col(5)
        chinese2 = book.sheet_by_index(0).col(6)
        pinyin2 = book.sheet_by_index(0).col(7)
        en2 = [i for i in english2 if i.value != '']
        chi2 = [i for i in chinese2 if i.value != '']
        pi2 = [i for i in pinyin2 if i.value != '']
        col2 = zip(en2, chi2, pi2)

        for e,c,p in col1:
            updated = ChineseName.objects.filter(english=e)
            if updated:
                updated[0].pinyin = p.value
                updated[0].chinese = c.value
                updated[0].save()
            else:
                ChineseName(english=e.value, chinese=c.value, pinyin=p.value).save()

        for e,c,p in col2:
            updated = ChineseName.objects.filter(english=e)
            if updated:
                updated[0].pinyin = p.value
                updated[0].chinese = c.value
                updated[0].save()
            else:
                ChineseName(english=e.value, chinese=c.value, pinyin=p.value).save()



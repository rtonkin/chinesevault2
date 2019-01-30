from django.db.models import Q, get_model

from .pinyin_helpers import PINYIN, CONV

import jieba
import hanzidentifier
jieba.initialize(dictionary='resources/generated_dict.txt')

exist_words_cache = set()

def jiebasplit(data):
    seg_list = jieba.cut(data, cut_all=False)
    result = []
    Word = get_model('core.Word') # lazy loading model, otherwise ImportError
    for w in seg_list:
        if (w in exist_words_cache) or Word.objects.filter(Q(simplified=w) | Q(traditional=w)).exists():
            result.append(w)
            exist_words_cache.add(w)
        else:
            result += list(w)
    return result

def highlight_chinese(text):
    data = jiebasplit(text)
    for i, _ in enumerate(data):
        if hanzidentifier.has_chinese(_):
            data[i] = '''<chinese>%s</chinese>''' % _
    return ''.join(data)



def lastvowel(s):
    '''Find the index of the last pinyin vowel (aeiouv) in string s.'''
    return max(map(s.rfind, 'aeiouv'))

## Pinyin text conversion #####################################################

def syllable_to_pinyin(syl):
    """Returns proper unicode string for one pinyin syllable + tone number (e.g. 'yi1')"""
    if syl.isdigit():
        return syl
    try:
        syl, tone = syl[:-1], int(syl[-1])
    except ValueError:
        #converting tone number to int failed, probably not a pinyin syllable
        return syl
    except IndexError:
        #converting tone number to int failed, probably not a pinyin syllable
        return syl
    syl = syl.replace("u:", "v")
    if "a" in syl or "e" in syl:
        syl = syl.replace("a", PINYIN["a" + repr(tone)])
        syl = syl.replace("e", PINYIN["e" + repr(tone)])
    elif "ou" in syl:
        syl = syl.replace("o", PINYIN["o" + repr(tone)])
    else:
        try:
            vowel = syl[lastvowel(syl.lower())] #get the last vowel
        except IndexError:
            # error here
            return syl
        try:
            pinyin_unicode = PINYIN[vowel+repr(tone)]
            syl = syl.replace(vowel, pinyin_unicode)
        except KeyError:
            #couldn't find vowel+tone combination, probably not a pinyin syllable
            return syl+repr(tone) #return the original input

    if "v" in syl.lower():
        syl = syl.replace("v", PINYIN["v0"]).replace("V", PINYIN["V0"])
    return syl

def pinyin_to_syllable(syl):
    for k,v in PINYIN.items():
        if v in syl:
            return syl.replace(v, k)
    return syl

def pinyin(pinyin_text):
    """Convert a numeric pinyin string (e.g. 'pin1yin1') to the proper Unicode characters"""
    pinyin_text = pinyin_text.replace('\n',' \\n ')
    syls = pinyin_text.strip().replace('1','1 ').replace('2','2 ').replace('3','3 ').replace('4','4 ').split()
    for syl in syls:
        newsyl = syllable_to_pinyin(syl)
        if syl == newsyl:
            #this isn't pinyin, don't do anything with it
            pass
        else:
            pinyin_text = pinyin_text.replace(syl, newsyl)
    return pinyin_text



def pin1yin1(text):
    """Convert a pinyin string with tone marks to the numeric string"""
    text = text.replace('\n',' \\n ')
    syls = text.strip()
    syls = syls.replace("āng", "ang1");
    syls = syls.replace("áng", "ang2");
    syls = syls.replace("ǎng", "ang3");
    syls = syls.replace("àng", "ang4");
    syls = syls.replace("ēng", "eng1");
    syls = syls.replace("éng", "eng2");
    syls = syls.replace("ěng", "eng3");
    syls = syls.replace("èng", "eng4");
    syls = syls.replace("īng", "ing1");
    syls = syls.replace("íng", "ing2");
    syls = syls.replace("ǐng", "ing3");
    syls = syls.replace("ìng", "ing4");
    syls = syls.replace("ōng", "ong1");
    syls = syls.replace("óng", "ong2");
    syls = syls.replace("ǒng", "ong3");
    syls = syls.replace("òng", "ong4");
    syls = syls.replace("ān", "an1");
    syls = syls.replace("án", "an2");
    syls = syls.replace("ǎn", "an3");
    syls = syls.replace("àn", "an4");
    syls = syls.replace("ēn", "en1");
    syls = syls.replace("én", "en2");
    syls = syls.replace("ěn", "en3");
    syls = syls.replace("èn", "en4");
    syls = syls.replace("īn", "in1");
    syls = syls.replace("ín", "in2");
    syls = syls.replace("ǐn", "in3");
    syls = syls.replace("ìn", "in4");
    syls = syls.replace("ūn", "un1");
    syls = syls.replace("ún", "un2");
    syls = syls.replace("ǔn", "un3");
    syls = syls.replace("ùn", "un4");
    syls = syls.replace("ér", "er2");
    syls = syls.replace("ěr", "er3");
    syls = syls.replace("èr", "er4");
    syls = syls.replace("āo", "aō");
    syls = syls.replace("áo", "aó");
    syls = syls.replace("ǎo", "aǒ");
    syls = syls.replace("ào", "aò");
    syls = syls.replace("ōu", "oū");
    syls = syls.replace("óu", "oú");
    syls = syls.replace("ǒu", "oǔ");
    syls = syls.replace("òu", "où");
    syls = syls.replace("āi", "aī");
    syls = syls.replace("ái", "aí");
    syls = syls.replace("ǎi", "aǐ");
    syls = syls.replace("ài", "aì");
    syls = syls.replace("ēi", "eī");
    syls = syls.replace("éi", "eí");
    syls = syls.replace("ěi", "eǐ");
    syls = syls.replace("èi", "eì");
    syls = syls.replace("ā", "a1");
    syls = syls.replace("á", "a2");
    syls = syls.replace("ǎ", "a3");
    syls = syls.replace("à", "a4");
    syls = syls.replace("ē", "e1");
    syls = syls.replace("é", "e2");
    syls = syls.replace("ě", "e3");
    syls = syls.replace("è", "e4");
    syls = syls.replace("ī", "i1");
    syls = syls.replace("í", "i2");
    syls = syls.replace("ǐ", "i3");
    syls = syls.replace("ì", "i4");
    syls = syls.replace("ō", "o1");
    syls = syls.replace("ó", "o2");
    syls = syls.replace("ǒ", "o3");
    syls = syls.replace("ò", "o4");
    syls = syls.replace("ū", "u1");
    syls = syls.replace("ú", "u2");
    syls = syls.replace("ǔ", "u3");
    syls = syls.replace("ù", "u4");
    syls = syls.replace("ǖ", "ü1");
    syls = syls.replace("ǘ", "ü2");
    syls = syls.replace("ǚ", "ü3");
    syls = syls.replace("ǜ", "ü4");

    syls = syls.replace("ng1a", "n1ga");
    syls = syls.replace("ng2a", "n2ga");
    syls = syls.replace("ng3a", "n3ga");
    syls = syls.replace("ng4a", "n4ga");
    syls = syls.replace("ng1e", "n1ge");
    syls = syls.replace("ng2e", "n2ge");
    syls = syls.replace("ng3e", "n3ge");
    syls = syls.replace("ng4e", "n4ge");
    syls = syls.replace("ng1o", "n1go");
    syls = syls.replace("ng2o", "n2go");
    syls = syls.replace("ng3o", "n3go");
    syls = syls.replace("ng4o", "n4go");
    syls = syls.replace("ng1u", "n1gu");
    syls = syls.replace("ng2u", "n2gu");
    syls = syls.replace("ng3u", "n3gu");
    syls = syls.replace("ng4u", "n4gu");

    syls = syls.replace("n1ang", "1nang");
    syls = syls.replace("n2ang", "2nang");
    syls = syls.replace("n3ang", "3nang");
    syls = syls.replace("n4ang", "4nang");
    syls = syls.replace("n1eng", "1neng");
    syls = syls.replace("n2eng", "2neng");
    syls = syls.replace("n3eng", "3neng");
    syls = syls.replace("n4eng", "4neng");
    syls = syls.replace("n1ing", "1ning");
    syls = syls.replace("n2ing", "2ning");
    syls = syls.replace("n3ing", "3ning");
    syls = syls.replace("n4ing", "4ning");
    syls = syls.replace("n1ong", "1nong");
    syls = syls.replace("n2ong", "2nong");
    syls = syls.replace("n3ong", "3nong");
    syls = syls.replace("n4ong", "4nong");

    syls = syls.replace("hen2an2", "he2nan2");
    syls = syls.replace("hun2an2", "hu2nan2");
    syls = syls.replace("zhun2an2", "zhu2nan2");
    syls = syls.replace("hun3an2", "hu3nan2");
    syls = syls.replace("lin3an2", "li3nan2");
    syls = syls.replace("zhin3an2", "zhi3nan2");
    syls = syls.replace("bun4an2", "bu4nan2");
    syls = syls.replace("chin4an2", "chi4nan2");
    syls = syls.replace("shin4an2", "shi4nan2");
    syls = syls.replace("man3an3", "ma3nan3");
    syls = syls.replace("ban1en4", "ba1nen4");
    syls = syls.replace("jin2an4", "ji2nan4");
    syls = syls.replace("yin2an4 ", "yi2nan4");
    syls = syls.replace("hen2an4", "he2nan4");
    syls = syls.replace("lin2an4", "li2nan4");
    syls = syls.replace("zen2an4", "ze2nan4");
    syls = syls.replace("kun3an4", "ku3nan4");
    syls = syls.replace("sin3an4", "si3nan4");
    syls = syls.replace("yun4an4", "yu4nan4");
    syls = syls.replace("qun4ian2", "qu4nian2");

    syls = syls.replace("ner4en3", "ne4ren3");
    syls = syls.replace("er4an2", "e4ran2");
    syls = syls.replace("ger4en2", "ge4ren2");
    syls = syls.replace("her2en2", "he2ren2");
    syls = syls.replace("zher2en2", "zhe2ren2");
    syls = syls.replace("zer2en2", "ze2ren2");
    syls = syls.replace("zer2en4", "ze2ren4");
    syls = syls.replace("der2en2", "de2ren2");
    syls = syls.replace("ker4en2", "ke4ren2");
    syls = syls.replace("ser4en2", "se4ren2");
    syls = syls.replace("ker4an2", "ke4ran2");

    return syls

# -*- coding: utf8 -*-
import re
from zhongguolib.constants import *
from zhongguolib.decorators import strip_whitespaces
from zhongguolib.validators import InvalidSyllable, is_pinyin, is_character

@strip_whitespaces
def inifinal(syllable):
    '''
    Decouple the INITIAL and FINAL components of a syllable
    '''
    if syllable[0] in INITIALS:
        if syllable in SYLLABLES[syllable[0]]:
            return (syllable[0], syllable[1:])
        elif syllable[0] + detone_final(syllable[1:]) in SYLLABLES[syllable[0]]:
            return (syllable[0], syllable[1:])

    if syllable[:2] in INITIALS:
        if syllable in SYLLABLES[syllable[:2]]:
            return (syllable[:2], syllable[2:])
        elif syllable[:2] + detone_final(syllable[2:]) in SYLLABLES[syllable[:2]]:
            return (syllable[:2], syllable[2:])

    if detone_final(syllable) in SYLLABLES[NO_INITIAL]:
        return (NO_INITIAL, syllable)

    if syllable == 'r':
        return ('', 'r')

    raise InvalidSyllable('Invalid syllable: %s' % syllable)

def validate_syllable(syllable):
    '''
    Validate if syllable is a valid combination of INITIAL and FINAL
    '''
    return bool(inifinal(syllable))

@strip_whitespaces
def tone_final(final, tone):
    '''
    Apply tone to a syllable (vowel)
    Example:

    toned_final could be given as argument. In this case,
    it is assumed that the caller want to change the tone.
    '''
    final = detone_final(final)
    if tone not in CHINESE_TONES:
        return final

    # support the cases where NEUTRAL_TONE is 5 instead of 0
    tone = 0 if tone == 5 else tone

    toned_final = FINALS_TONES[final][tone]
    return toned_final


@strip_whitespaces
def detone_final(final):
    '''
    Remove tone from a syllable (vowel)
    Example:

    '''
    for detoned_final, toned_finals in FINALS_TONES.items():
        for toned_final in toned_finals:
            if final == toned_final:
                return detoned_final
    return final

@strip_whitespaces
def is_final_toned(final):
    for detoned_final, toned_finals in FINALS_TONES.items():
        for tone, toned_final in enumerate(toned_finals):
            if final == toned_final and tone > NEUTRAL_TONE:
                return True
    return False

@strip_whitespaces
def is_syllable_toned(syllable):
    initial, final = inifinal(syllable)
    return is_final_toned(final)

def tone_syllable(syllable, tone=NEUTRAL_TONE):
    initial, final = inifinal(syllable)
    return ''.join((initial, tone_final(final, tone)))

def detone_syllable(syllable):
    # assume normalized (unnumbered) pinyin
    if syllable.isalpha():
        initial, final = inifinal(syllable)
        return ''.join((initial, detone_final(final)))
    # assume numbered syllable, tone is always 1 number at the end,
    # so we can just remove it
    else:
        return syllable[:-1]

@strip_whitespaces
def normalize_syllable(syllable):
    last_char = syllable[-1]
    if last_char.isdigit():
        tone = int(last_char)
        if tone not in CHINESE_TONES:
            # return syllable without the number at the end
            return syllable[:-1]
        return tone_syllable(syllable[:-1], tone)
    else:
        return syllable

def syllabize_numbered_pinyin(text):
    parts = re.findall('(?:([üa-zA-Z]+\d{1}))', text)
    syllables = []
    for syllable in parts:
        syllables.append(normalize_syllable(syllable))
    return ''.join(syllables) or text

def number_syllabized_pinyin(syllable, dont_number_neutral=False):
    detoned_syllable = detone_syllable(syllable)
    initial, final = inifinal(syllable)

    for base_final, toned_finals in FINALS_TONES.items():
        for idx, toned_final in enumerate(toned_finals):
            if final == toned_final:
                tone = idx

    # for backwards compatibility where NEUTRAL_TONE was 0 instead of 5
    if tone == NEUTRAL_TONE or tone == ALTERNATIVE_NEUTRAL_TONE:
        if dont_number_neutral:
            tone = ""
        else:
            tone = NEUTRAL_TONE

    numbered = "{0}{1}".format(detoned_syllable, tone)
    return numbered

def syllabize_pinyin(text):
    normalized = []
    syllables = decouple_syllables(text)
    for syllable in syllables:
        normalized.append(normalize_syllable(syllable))
    return ''.join(normalized) or text

all_syllables = []
for tone in CHINESE_TONES:
    for item in ALL_SYLLABLES_SORTED:
        all_syllables.append(tone_syllable(item, tone))
all_syllables = sorted(all_syllables, key=lambda x: len(x), reverse=True)

def decouple_syllables(text):
    pattern = '(%s\d{0,1})' % '\d{0,1}|'.join(all_syllables)
    if not re.match(pattern, text):
        return [text]
    matched = re.findall(pattern, text)
    valid = []
    t = text
    for m in matched:
        if t.find(m) == 0:
            valid.append(m)
            t = t.replace(m, '', 1)
    return valid or [text]

def is_word(text):
    if is_character(text[0]):
        return len(text) > 1
    if is_pinyin(text[0]):
        return len(decouple_syllables(text)) > 1

def validate_pinyin(pinyin):
    # Check if pinyin can be broke into syllables (if no exception is thrown)
    # len() is called because decouple_syllables yields only valid syllables
    # and leave the invalid but doesn't raise an exception
    try:
        syllables = decouple_syllables(pinyin)
    except InvalidSyllable as e:
        return False
    else:
        if len(pinyin) != len(''.join(syllables)):
            return False

        # decouple_syllables() will return only one 'syllable' (the input string)
        # if the argument is not valid pinyin at all
        if len(syllables) == 1 and normalize_syllable(syllables[0]) not in all_syllables:
            return False

    return True

# def decouple_syllables(text):
#     valid_syllables = []
#     current_final = []
#     current_syllable = []
#
#     for c in text:
#         if c in INITIALS:
#             if valid_final(current_final):
#                 if current_syllable:
#                     valid_syllables.append(''.join(current_syllable))
#                 current_syllable = []
#                 current_final = []
#                 current_syllable.append(c)
#             else:
#                 current_syllable.append(c)
#         else:
#             if not valid_final(current_final):
#                 current_syllable.append(c)
#     if current_syllable:
#         valid_syllables.append(''.join(current_syllable))
#     return valid_syllables

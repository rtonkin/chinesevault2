from zhongguolib.constants import *

class InvalidSyllable(Exception):
    pass

def is_character(character):
    ordinal = ord(character)
    if (ordinal in CJK or
           ordinal in CJK_A or
           ordinal in CJK_B or
           ordinal in CJK_C or
           ordinal in CJK_D):
        return True
    return False

def is_hanzi(character):
    return is_character(character)

def is_pinyin(char):
    if (char in LATIN_ALPHABET or
        char in ALLOWED_PININ_CHARACTERS):
        return True
    return False

def is_cylliric(char):
    if char in CYLLIRIC_ALPHABET:
        return True
    return False

def validate_characters(characters):
    if not characters:
        return False
    for character in characters:
        # hanzis can be separated by middle dotss
        if (not is_character(character)
                and not character in (MIDDLE_DOT_CHARACTERS, MIDDLE_DOT_PINYIN)):
            return False
    return True

def validate_hanzis(characters):
    return validate_characters(characters)

def validate_pinyin_characters(pinyin):
    if not pinyin:
        return False
    for char in pinyin:
        if not is_pinyin(char):
            return False
    return True

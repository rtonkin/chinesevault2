#coding: utf-8
import stripe
from django.conf import settings
from django.core.mail import EmailMessage
from django.http import HttpResponseRedirect
from django.template.context_processors import csrf
from djstripe.models import Customer
from stripe import Subscription
from django.views.decorators.csrf import csrf_exempt
from putonghua.core.forms import ContactForm
from django.http import (JsonResponse, HttpResponseForbidden, HttpResponseBadRequest, HttpResponse)
from django.shortcuts import render_to_response
from django.core.mail import send_mail
import json
from django.core.files import File

from putonghua.settings.base import DJSTRIPE_PLANS
from .helpers import jiebasplit, pinyin, pin1yin1
from .models import Reason, TonesForPractice, Lesson, VideoStudyItem, AudioStudyItem, StudyContent, Word, SuggestWord, ChineseName, NewsLetter
from datetime import datetime
import sys, os
import urllib.request
import re
from .models import User
from io import BytesIO
import random

def test_sentry(request):
    int('this is error')
    return JsonResponse({
        'success': False,
    })

def index(request):
    context = {}
    if not request.COOKIES.get('csrftoken'):
        context.update(csrf(request))
    context['user'] = request.user
    context['username_pattern'] = settings.USERNAME_VALIDATION_PATTERN
    # upload tones sound from TonesFileToUpload
    
    # try:
    if 'TonesFileToUpload' not in os.getcwd():
        os.chdir("TonesFileToUpload/")
        folder=os.listdir(os.getcwd())
        ext3 = ['.mp3']
        existing_files = []
        for exist_file in TonesForPractice.objects.all():
            existing_files.append(exist_file.name)

        for file in folder:
            file_path = os.getcwd() + '/' + file
            if str(file)[-4:] in ext3:
                with open(file_path, "rb") as f:
                    if file.split('.mp3')[0] not in existing_files:
                        print(file)
                        tone = TonesForPractice()
                        tone.tone_file.save(
                            file,
                            File(
                                BytesIO(f.read())
                                )
                            )
        os.chdir("../")
        # os.chdir("../")
    # except:
    #     os.chdir("../")
    #     index(request)

    description = ''
    keywords = ''
    title = ''
    path = request.get_full_path()

    if path == '/app':
        description = "With a free Chinese / English dictionary, Chinese lessons, flashcards, video and audio study content, as well as text analysis tools, we have everything you need to master the Chinese language."
        keywords = "free chinese dictionary, free chinese lessons, chinese flashcards, chinese studycontent, chinese tools"
        title = "ChineseVault.com – Free Chinese Dictionary, Flashcards, Lessons and more"
    
    elif path == '/app/flashcards':
        description = "Free online flashcard app to help to learn mandarin Chinese. Existing flashcard lists including HSK are ready to study now. Don’t forget what you learn!"
        keywords = "chinese flashcards, memorize chinese, chinese practice, online flashcards, practice characters, free chinese flashcards"
        title = "Chinese Flashcards – ChineseVault.com"
    
    elif path == '/app/dictionary':
        description = "Completely free Chinese / English dictionary with over 100,000 entries and full audio. Search in Chinese, English or Pinyin, and see example sentences."
        keywords = "chinese english dictionary, free chinese dictionary, online dictionary, chinese definitions, chinese characters"
        title = "Free Chinese / English Dictionary - ChineseVault.com"
    
    elif path == '/app/texttool':
        description = "Learn to read and understand Chinese with our Text Tool. Click on any Chinese word for a full definition, instantly add Pinyin to Chinese text, or convert from simplified to traditional characters."
        keywords = "analyze chinese, add pinyin, convert pinyin, simplified to traditional, chinese text tools"
        title = "Chinese Text Reader – ChineseVault.com"
    
    elif path == '/app/lesson':
        description = "A series of over 30 completely free Chinese lessons for beginners. Learn the basic vocabulary and sentence structures to get you speaking basic Chinese in no time."
        keywords = "free chinese lessons, online chinese lessons, free chinese, mandarin lessons, free mandarin lessons, learn chinese"
        title = "Free Chinese Lessons – ChineseVault.com"
    
    elif path == '/app/studycontent':
        description = "Learn Chinese with real study content. Find Text, Audio and Video for listening and reading practice and teach yourself with our advanced learning tools."
        keywords = "chinese study content, learn chinese, chinese videos, chinese audio, chinese text, learn to read chinese"
        title = "Chinese Study Content – ChineseVault.com"
    
    elif path == '/app/studycontent/video':
        description = "Learn Chinese with real video study content. Improve your listening and reading skills by watching real Chinese videos, with a complete transcript to help you learn."
        keywords = "chinese video study content, learn chinese with videos, learn chinese free, chinese videos"
        title = "Chinese Video Study Content – ChineseVault.com"
    
    elif path == '/app/studycontent/audio':
        description = "Learn Chinese with real audio study content. Improve your listening and reading skills by listening to real Chinese audio, with a complete transcript to help you learn."
        keywords = "chinese audio study content, learn chinese with audio, learn chinese free, chinese audio"
        title = "Chinese Audio Study Content – ChineseVault.com"
    
    elif path == '/app/studycontent/text':
        description = "Learn Chinese with real text study content. Improve your reading skills by reading real Chinese stories, news, songs and poems, with a completetranscript to help you learn."
        keywords = "chinese text study content, learn chinese by reading, learn chinese free, chinese text, chinese poems, chinese news, chinese songs"
        title = "Chinese Text Study Content – ChineseVault.com"
    
    elif path == '/app/pinyin_chart':
        description = "Free Chinese Pinyin chart containing all 1,300+ pinyin sounds, with audio for every sound. Practice your pronunciation today."
        keywords = "free pinyin chart, chinese pinyin chart, pinyin audio, pinyin chart with audio, pinyin explanation"
        title = "Free Pinyin Chart with Audio – ChineseVault.com"
    
    elif path == '/app/char_freq':
        description = "Chart containing the most common 5,000 characters sorted by frequency. Test your character knowledge and find new characters to learn."
        keywords = "chinese character frequency, chinese character frequency chart"
        title = "Simplified Chinese Character Frequency List – ChineseVault.com"
    
    elif path == '/app/word_freq':
        description = "Chart containing the most common 20,000 Chinese words sorted by frequency. Test your word knowledge and find new words to learn."
        keywords = "chinese word frequency, chinese word frequency chart"
        title = "Chinese Word Frequency List – ChineseVault.com"
    
    elif path == '/app/measure_word_chart':
        description = "List containing hundreds of Chinese Measure words sorted from beginner to expert. Brush up on your measure words today."
        keywords = "chinese measure words, chinese measure word chart, chinese counter words, chinese counter words chart"
        title = "Chinese Measure Word List – ChineseVault.com"
    
    elif 'word' in path.split('/'):
        try:
            myWord = Word.objects.get(pk=path.split('/')[-1])
            meanings = ''
            i=1

            for meaning in myWord.meanings_references.split('/')[:4]:
                meanings += str(i) + '.' + meaning + ' '
                i+=1

            description = myWord.simplified + ' – ' + myWord.pinyin_normalized + ' – ' + meanings
            keywords = "chinese definitions, English chinese dictionary, chinese example sentences, chinese audio"
            title = "Definitions of " + myWord.simplified + ' – ' + myWord.pinyin_normalized + " – Free Chinese / English Dictionary – ChineseVault.com"
        except:
            pass
    
    elif 'lesson' in path.split('/') and len(path.split('/')) > 2:
        try:
            mylesson = Lesson.objects.get(number=path.split('/')[-1])
            description = mylesson.description
            keywords = "free chinese lessons, online chinese lessons, free chinese, mandarin lessons, free mandarin lessons, learn chinese"
            title = mylesson.name + " - Free Chinese Lessons – ChineseVault.com"
        except:
            pass
    
    elif 'video' in path.split('/') and len(path.split('/')) > 3:
        try:
            myVideo = VideoStudyItem.objects.get(pk=path.split('/'))
            description = myVideo.description
            keywords = "chinese video study content, learn chinese with videos, learn chinese free, chinese videos"
            title = myVideo.name + " - Chinese Video Content – ChineseVault.com"
        except:
            pass
    
    elif 'audio' in path.split('/') and len(path.split('/')) > 3:
        try:
            myAudio = AudioStudyItem.objects.get(pk=path.split('/')[-1])
            description = myAudio.description
            keywords = "chinese audio study content, learn chinese with audio, learn chinese free, chinese audio"
            title = myAudio.name + " - Chinese Audio Content – ChineseVault.com"
        except:
            pass
    
    elif 'text' in path.split('/') and len(path.split('/')) > 3:
        try:
            myStudyContent = StudyContent.objects.get(pk=path.split('/')[-1])
            description = myStudyContent.description
            keywords = "chinese text study content, learn chinese by reading, learn chinese free, chinese text, chinese poems, chinese news, chinese songs"
            title = myStudyContent.name + " - Chinese Text Content – ChineseVault.com"
        except:
            pass

    context['description'] = description
    context['keywords'] = keywords
    context['title'] = title

    return render_to_response('index.html', context)

def contact(request):
    if request.method == 'POST':
        #form = ContactForm(request.POST, request.FILES)
        #response = {}
        form_data = request.body.decode('utf-8').split("&")
        print(form_data)
        form_data_dict={}
        for item in form_data:
            form_data_dict[item[0:item.find('=')]] = urllib.request.unquote(item[item.find('=')+1:].replace("%2B",'71217')).replace("+"," ").replace("71217","+")

        # send_mail(
        #     form_data_dict['subject'],
        #     form_data_dict['message'],
        #     form_data_dict['email'],
        #     ['admin@chinesevault.com',]
        # )

        email = EmailMessage(form_data_dict['subject'], form_data_dict['message'] + "\n\n---message from--- " + form_data_dict['email'], 'admin@chinesevault.com', ['admin@chinesevault.com',])
        email.send()

        return JsonResponse({
            'success': True,
        })
    else:
        return HttpResponseForbidden("Forbidden!")

def text_tool(request):
    if request.method == 'POST':
        data = json.loads(request.body.decode('utf-8')).get('text')
        if data:
            return JsonResponse({
                'success': True,
                'words': jiebasplit(data),
            })
        else:
            return JsonResponse({
                'success': False,
                'errors': "Some errors"
            })
    else:
        return HttpResponseForbidden("Forbidden!")

def hanzi2pinyin(request):
    if request.method == 'POST':
        from xpinyin import Pinyin
        p = Pinyin()
        data = json.loads(request.body.decode('utf-8')).get('text')
        if data:
            result = p.get_pinyin(data, ' ', show_tone_marks=True)
            return JsonResponse({
                'success': True,
                'result': result,
            })
        else:
            return JsonResponse({
                'success': False,
                'errors': "Some errors"
            })
    else:
        return HttpResponseForbidden("Forbidden!")

def simpl2trad(request):
    if request.method == 'POST':
        from jianfan import jtof
        data = json.loads(request.body.decode('utf-8')).get('text')
        if data:
            result = jtof(data)
            return JsonResponse({
                'success': True,
                'result': result,
            })
        else:
            return JsonResponse({
                'success': False,
                'errors': "Some errors"
            })
    else:
        return HttpResponseForbidden("Forbidden!")

def trad2simpl(request):
    if request.method == 'POST':
        from jianfan import ftoj
        data = json.loads(request.body.decode('utf-8')).get('text')
        if data:
            result = ftoj(data)
            return JsonResponse({
                'success': True,
                'result': result,
            })
        else:
            return JsonResponse({
                'success': False,
                'errors': "Some errors"
            })
    else:
        return HttpResponseForbidden("Forbidden!")

def p1y12pinyin(request):
    if request.method == 'POST':
        data = json.loads(request.body.decode('utf-8')).get('text')
        if data:
            result = pinyin(data)
            return JsonResponse({
                'success': True,
                'result': result,
            })
        else:
            return JsonResponse({
                'success': False,
                'errors': "Some errors"
            })
    else:
        return HttpResponseForbidden("Forbidden!")

def pinyin2p1y1(request):
    if request.method == 'POST':
        data = json.loads(request.body.decode('utf-8')).get('text')
        if data:
            result = pin1yin1(data)
            return JsonResponse({
                'success': True,
                'result': result,
            })
        else:
            return JsonResponse({
                'success': False,
                'errors': "Some errors"
            })
    else:
        return HttpResponseForbidden("Forbidden!")

def reason(request):
    if request.method=='POST' and request.user.is_authenticated():
        try:
            users_reason = json.loads(request.body.decode('utf-8')).get('reason')             #get reason data from frontend

            reason_obj = Reason(                                                #create Reason object for save in database
                unsubscriber=request.user,
                text_reason=users_reason,
                date_reason= datetime.now()
            )
            reason_obj.save()
        except:
            return JsonResponse({
                'success': False,
            })

    return JsonResponse({
        'success': True,
    })

def get_tones_for_practice(request):

    if request.method == 'POST' and request.user.is_authenticated():
        number = json.loads(request.body.decode('utf-8')).get('count')

        # tones_for_random = []
        # for tone in TonesForPractice.objects.all():
        #     tones_for_random.append(tone)
        #
        # random.shuffle(tones_for_random)
        tones_for_random = []
        all_tones_ids = TonesForPractice.objects.values_list('id', flat=True)

        for i in random.sample(list(all_tones_ids), int(number)):
            tones_for_random.append(TonesForPractice.objects.get(id=i))

        json_data = {}
        tones = []
        varicks = []
        for tone in tones_for_random:
            for each_tone in TonesForPractice.objects.filter(name__contains=tone.name[:-1]):
                if tone.name[:-1] == each_tone.name[:-1]:
                    varicks.append(each_tone.name[-1])
            tones.append(
                {
                    'name': tone.name,
                    'pinyin_normalized' : tone.pinyin_normalized,
                    'url': tone.tone_file.url,
                    'varicks': varicks.copy()
                }
            )
            varicks.clear()
            
        json_data['tones'] = json.dumps(tones)
        return JsonResponse(json_data)
    return HttpResponseBadRequest()

def get_tones_for_chart(request):
    if request.method == 'POST':
        try:
            received_tone = json.loads(request.body.decode('utf-8')).get('tone')
            QueryDictOfTones = TonesForPractice.objects.filter(name__contains=received_tone)
            tones = []
            for tone in QueryDictOfTones:
                if len(received_tone) == len(tone.pinyin_normalized):
                    tones.append(
                        {
                            'pinyin_normalized' : tone.pinyin_normalized,
                            'url': tone.tone_file.url
                        }
                    )
                    
            
            return JsonResponse(
                {
                    'tones': tones
                }
            )
        except:
            print(sys.exc_info())
            return HttpResponseBadRequest()        
    return HttpResponseBadRequest()

def get_incorrect_tone(request, tone):
    if request.method == 'GET':
        try:
            tone = TonesForPractice.objects.get(name=tone)


            return JsonResponse(
                {
                    'pinyin_normalized': tone.pinyin_normalized,
                    'url': tone.tone_file.url
                }
            )
        except TonesForPractice.DoesNotExist:
            return JsonResponse(
                {
                    'message' : 'This Tone Does not exist.'
                }
            )
    return HttpResponseBadRequest()

def password_reset(request):
    if request.method == 'POST':
        try:
            user = User.objects.get(
                email=json.loads(request.body.decode('utf-8')).get('email')
                )
            password = User.objects.make_random_password()
            user.set_password(password)

            mail_message = 'Your username: ' + user.username + '\nYour password: ' + password
            send_mail(
                'Your account details',
                    mail_message,
                        'admin@chinesevault.com',
                        [user.email]
                )
            return JsonResponse(
                {
                    'success': True
                })
        except:
            print(sys.exc_info())
            return HttpResponseBadRequest()

    return HttpResponseBadRequest()

def add_suggest_words(request, suggest_id):
    if request.method == 'GET':
        from jianfan import ftoj

        s = SuggestWord.objects.get(id=suggest_id)
        if not Word.objects.filter(traditional = s.chinese):
            n = Word(traditional=s.chinese, pinyin=s.pinyin, simplified=ftoj(s.chinese), meanings=s.english)
            n.save()
        s.delete()
        return HttpResponseRedirect('/admin/core/suggestword/')

    return HttpResponseBadRequest()

import xlrd
import os.path
def load_from_exel_chinecenames(request):
    if request.method == 'GET':
        if not request.user.is_superuser:
            return JsonResponse(
                {
                    'success': False
                })
        scriptpath = os.path.dirname(__file__)
        filename = os.path.join(scriptpath, 'ChineseEnglishNames.xls')
        # source_filename = "ChineseEnglishNames.xls"
        source_filename = filename
        read_book = xlrd.open_workbook(source_filename, formatting_info=True)
        rs = read_book.sheet_by_name('Sheet1')
        new_names = list()
        for name in ChineseName.objects.all():
            name.delete()
        for row_num in range(0, rs.nrows):
            name = rs.row_values(row_num)[0]
            ch_name = rs.row_values(row_num)[1]
            if name:
                ChineseName.objects.create(english=name, chinese=ch_name, sex=1)
                new_names.append({'english': name, 'chinese': ch_name, 'sex': 1})

        for row_num in range(0, rs.nrows):
            name = rs.row_values(row_num)[5]
            ch_name = rs.row_values(row_num)[6]
            if name:
                ChineseName.objects.create(english=name, chinese=ch_name, sex=2)
                new_names.append({'english': name, 'chinese': ch_name, 'sex': 2})
        return JsonResponse(
            {
                'success': True
            })


# def retrivew_subsciption(user_id, customer_id, subsciption_id, name_of_plan):
#     from putonghua.settings.base import STRIPE_SECRET_KEY
#     try:
#         user = User.objects.get(id=user_id)
#         user.unsubscribe_status = False
#         user.save()
#
#         stripe.api_key = STRIPE_SECRET_KEY
#         c = stripe.Customer.retrieve(customer_id)
#         q = c.subscriptions.retrieve(subsciption_id)
#         q.plan = name_of_plan
#         q.save()
#         return True
#     except Exception as e:
#         print(e)
#         return False


def change_plan(request):
    import stripe
    if request.method == 'POST':
        customer_object = Customer.objects.get(subscriber=request.user)
        customer_stripe_id = customer_object.stripe_id
        customer_id = stripe.Customer.retrieve(customer_stripe_id)
        subsciption_id = customer_id.subscriptions.data[0].id

        subs = customer_id.subscriptions.retrieve(subsciption_id)
        subs.plan = DJSTRIPE_PLANS["monthly"]["stripe_plan_id"]
        subs.save()

        request.user.unsubscribe_status = False
        request.user.save()
        return HttpResponse("OK")
    else:
        return HttpResponseBadRequest("Incorrect request type")
		
def newsletteradd(request):
    if request.method == 'POST':
        form_data = request.body.decode('utf-8').split("=")[1]
        value     = form_data.replace('%40', '@')
        #print("something",value)
        created = NewsLetter.objects.get_or_create(email=value)
        return JsonResponse({
              'success':  True,
              'message': "subscribed successfully",
        })
    else:
        return JsonResponse({
            'success': False,
            'message': 'Incorrect Method',
          })		
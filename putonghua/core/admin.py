from sortedm2m.fields import SortedManyToManyField
from django.db import models
from django.contrib import admin
from custom_django_select2.forms import ModelSelect2Widget, ModelSelect2TagWidget
from .models import PubCardList,\
                    CardList, \
                    Word,\
                    Lesson,\
                    WordDefinition,\
                    User,\
                    SearchHistoryItem,\
                    StudyContent,\
                    ExampleSentence,\
                    VideoStudyItem, \
                    AudioStudyItem, \
                    Subtitled, \
                    Reason, \
                    TonesForPractice, \
                    ChineseName,\
                    SuggestWord,\
					WordOfTheDay,\
                     NewsLetter,\
                     FeaturedContent

from django import forms

from guardian.admin import GuardedModelAdmin
from django.contrib.auth.admin import UserAdmin as OldUserAdmin
from userena.models import UserenaSignup
from django.utils.safestring import mark_safe

class UserenaSignupInline(admin.StackedInline):
    model = UserenaSignup
    max_num = 1

class UserAdmin(OldUserAdmin, GuardedModelAdmin):
    inlines = [UserenaSignupInline, ]
    list_display = ('username', 'email', 'location', 'chinese_level',
                    'is_staff', 'is_active', 'date_joined')
    list_filter = ('is_staff', 'is_superuser', 'is_active')

class SearchHistoryItemAdmin(admin.ModelAdmin):
    list_display = ('querytext', 'datetime')
    list_filter = ('datetime',)

class MyModelSelect2Widget(ModelSelect2Widget):
    pass

class MyModelSelect2TagWidget(ModelSelect2TagWidget):
    pass

class WordAdmin(admin.ModelAdmin):
    list_display = ('id', 'simplified', 'traditional', 'pinyin', 'meanings')
    search_fields = ('simplified', )

class PubCardListAdmin(admin.ModelAdmin):
    readonly_fields = ('words',)
    formfield_overrides = {
        SortedManyToManyField: {'widget': MyModelSelect2TagWidget},
    }
    class Media:
        css = {
             'all': ('css/admin.css',)
        }
        js = (
            '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js',
        )

class CardListAdmin(admin.ModelAdmin):
    pass


class LessonAdminForm(forms.ModelForm):
    class Meta:
        model = Lesson
        exclude = ('new_words_converted', 'word_usage', 'example_sentences')


class LessonAdmin(admin.ModelAdmin):
    form = LessonAdminForm

class StudyContentAdmin(admin.ModelAdmin):
    pass

class WordDefinitionAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.ForeignKey: {'widget': MyModelSelect2Widget},
    }
    class Media:
        js = (
            '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js',
        )

class ExampleSentenceAdmin(admin.ModelAdmin):
    list_display = ('id', 'chinese_simple', 'pinyin', 'english_1')
    search_fields = ('chinese_simple', 'english_1')


class SubtitledAdmin(admin.ModelAdmin):
    change_form_template = 'admin/subtitle_change_form.html'
    search_fields = ('srt',)

class VideoStudyItemAdmin(SubtitledAdmin):
    change_form_template = 'admin/subtitle_change_form.html'
    search_fields = ('srt',)

class AudioStudyItemAdmin(SubtitledAdmin):
    change_form_template = 'admin/subtitle_change_form.html'
    search_fields = ('srt',)

class ReasonAdmin(admin.ModelAdmin):                                       #   extending Admin model for display in admin panel
    list_display = ('unsubscriber', 'date_reason', 'text_reason')
    list_filter = ('date_reason',)                                          # creating date filter for reason search

class TonesForPracticeAdmin(admin.ModelAdmin):
    list_display = ('name', 'pinyin_normalized', 'tone_file')
    search_fields = ('name',)

class ChineseNameAdmin(admin.ModelAdmin):
    list_display = ('english', 'sex', 'chinese', 'pinyin')

class SuggestWordAdmin(admin.ModelAdmin):
    def my_action_link(self, obj):
        print("PUSH11111")
        return '<a href="/add_suggest_words/%d/" style="padding:5px 7px; background:#c0392b; width:100px; margin-left: 10px; color:#fff; border-radius: 3px">Add</a>' % obj.id

    my_action_link.short_description = 'Add to Words'
    my_action_link.allow_tags = True

    actions = [my_action_link]
    list_display = ('english', 'chinese', 'pinyin', 'my_action_link')
	
class WordOfTheDayAdmin(admin.ModelAdmin):
    list_display = ('title', 'pinyin', 'description', 'creation_date')
    search_fields = ('title', 'description')

class FeaturedContentAdmin(admin.ModelAdmin):
    def feature_image_tag(self, obj):
        return mark_safe('<img src="/media/%s" width="60px" height="70px"/>'%(obj.feature_image))  
    feature_image_tag.short_description = 'Featured Image'
    feature_image_tag.allow_tags = True
    list_display = ('title', 'description', 'feature_image_tag')
    search_fields = ('title', 'description')

class NewsLetterAdmin(admin.ModelAdmin):
    list_display_links = None
    def has_add_permission(self, request):
        return False
    list_display = ('id', 'email')
    search_fields = ['email']	

admin.site.register(WordDefinition, WordDefinitionAdmin)
admin.site.register(Word, WordAdmin)
admin.site.register(PubCardList, PubCardListAdmin)
admin.site.register(CardList, CardListAdmin)
admin.site.register(Lesson, LessonAdmin)
admin.site.register(User, UserAdmin)
admin.site.register(SearchHistoryItem, SearchHistoryItemAdmin)
admin.site.register(StudyContent, StudyContentAdmin)
admin.site.register(ExampleSentence, ExampleSentenceAdmin)
admin.site.register(Subtitled, SubtitledAdmin)
admin.site.register(VideoStudyItem, VideoStudyItemAdmin)
admin.site.register(AudioStudyItem, AudioStudyItemAdmin)
admin.site.register(Reason, ReasonAdmin)                                    # register reason admin model in admin panel
admin.site.register(TonesForPractice, TonesForPracticeAdmin)
admin.site.register(ChineseName, ChineseNameAdmin)
admin.site.register(SuggestWord, SuggestWordAdmin)
admin.site.register(WordOfTheDay, WordOfTheDayAdmin)
admin.site.register(FeaturedContent, FeaturedContentAdmin)
admin.site.register(NewsLetter, NewsLetterAdmin)
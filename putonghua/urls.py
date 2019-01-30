from django.conf.urls import include, url
from django.contrib import admin
from django.conf import settings
from django.http import HttpResponse,HttpResponseRedirect
# from djrill import DjrillAdminSite
from userena import views as userena_views

from putonghua.core.views import *
from putonghua.api import api
from django.views.generic.base import RedirectView
# admin.site = DjrillAdminSite()


urlpatterns = [
    url(r'^$', lambda r: HttpResponseRedirect('/app/')),
    url(r'^robots.txt$', lambda r: HttpResponse("User-agent: *\nDisallow: /", content_type="text/plain")),
    url(r'^test_sentry/$', test_sentry, name="test_sentry"),
    url(r'^grappelli/', include('grappelli.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^api/1.0/texttool/hanzi2pinyin/$', hanzi2pinyin, name="hanzi2pinyin"),
    url(r'^api/1.0/texttool/simpl2trad/$', simpl2trad, name="simpl2trad"),
    url(r'^api/1.0/texttool/trad2simpl/$', trad2simpl, name="trad2simpl"),
    url(r'^api/1.0/texttool/pinyin2p1y1/$', pinyin2p1y1, name="pinyin2p1y1"),
    url(r'^api/1.0/texttool/p1y12pinyin/$', p1y12pinyin, name="p1y12pinyin"),
    url(r'^api/1.0/texttool/$', text_tool, name="text_tool"),
    url(r'^api/1.0/reason/', reason),                               # register url for get reason text
    url(r'^api/1.0/voices/(\w+)/$', get_incorrect_tone),
    url(r'^api/1.0/tones/$', get_tones_for_chart),
    url(r'^api/1.0/voices/$', get_tones_for_practice),
    url(r'^api/1.0/accounts/password/reset/', password_reset),      # register url for reset password
    url(r'^api/1.0/retrivew_subsciption/', change_plan),
    url(r'^api/', include(api.urls)),
    url(r'^accounts/activate/(?P<activation_key>\w+)/$', userena_views.activate, {'success_url': '/'}, name='userena_activate'),
    url(r'^accounts/', include('userena.urls')),
    url(r'^contact/', contact, name="contact"),
    url(r'^pages/', include('django.contrib.flatpages.urls')), #http://www.geoland.org/2007/01/adsense-in-iframe/
    url(r'^select2/', include('custom_django_select2.urls')),
    url(r'^tinymce/', include('tinymce.urls')),
    url(r'^payments/', include('djstripe.urls', namespace="djstripe")),
    url(r'^app/', index, name="home"),
    url(r'^add_suggest_words/(\d+)/$', add_suggest_words),
    url(r'^load_chinese_names/', load_from_exel_chinecenames),
	url(r'^newsletteradd/', newsletteradd, name="newsletteradd"),
]


if settings.DEBUG:
    from django.contrib.staticfiles.urls import staticfiles_urlpatterns
    from django.conf.urls.static import static
    urlpatterns = staticfiles_urlpatterns() + urlpatterns
    urlpatterns = static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) + urlpatterns



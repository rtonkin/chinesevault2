from django.http import HttpResponse

from putonghua.settings.base import *
import raven
from django.core.cache import cache



BANNED_TIME = 30
USERENA_USE_HTTPS = True

class PageNotFoundBannedMiddleware(object):
    """
    Banned users for BANNED_TIME seconds when server return 404 status
    """
    @staticmethod
    def get_client_ip(request):
        x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
        if x_forwarded_for:
            ip = x_forwarded_for.split(',')[0]
        else:
            ip = request.META.get('REMOTE_ADDR')
        return ip


    @staticmethod
    def process_response(request, response):
        ip = PageNotFoundBannedMiddleware.get_client_ip(request)
        banned_ip = cache.get(str(ip))
        if response.status_code == 404:
            if banned_ip is None:
                cache.set(str(ip), 'banned', BANNED_TIME)
                return response
            else:
                response = HttpResponse('<html><body><pre>{}'
                                        '</pre></body></html>'.format("BANNED"), status=403)
                return response
        else:
            return response


ADMINS = (
    ('Robert Tonkin', 'robertjtonkin@hotmail.com'),
    ('Stanislav Fateev', 'fateevstas+phua@yandex.ru'),
)

EMAIL_BACKEND = 'django_mailgun.MailgunBackend'
MAILGUN_ACCESS_KEY = 'key-67f0d2fdd6775028a4b7808f23a4bd1b'
MAILGUN_SERVER_NAME = 'chinesevault.com'

USERENA_ACTIVATION_REQUIRED = True
STATIC_ROOT = os.path.abspath(os.path.join(BASE_DIR, '../staticfiles/'))
STATICFILES_DIRS = ()

VOICERSS_API_KEY = '45e9302eefad43f3b918493d1c0ac66a'

import raven
from raven.transport.requests import RequestsHTTPTransport

RAVEN_CONFIG = {
    'dsn': 'http://2d631ed6ab8e4ac6a81d5253308cbf6a:bdd01eeb5d384afd96015c669300d410@sentry.io/166052',
    # If you are using git, you can also automatically configure the
    # release based on the git info.
    'release': raven.fetch_git_sha(os.path.dirname(os.pardir)),
    'transport': RequestsHTTPTransport
}


TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        # 'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'DIRS': [os.path.abspath(os.path.join(BASE_DIR, '../staticfiles/'))],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]


DEBUG = False
ALLOWED_HOSTS = ['chinesevault.com', 'www.chinesevault.com']

#INSTALLED_APPS += (
    #'raven.contrib.django',
#'raven.contrib.django.raven_compat'
 #   )

LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'root': {
        'level': 'WARNING',
        'handlers': ['sentry'],
    },
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s '
                      '%(process)d %(thread)d %(message)s'
        },
    },
    'handlers': {
        'sentry': {
            'level': 'ERROR',
            'class': 'raven.contrib.django.raven_compat.handlers.SentryHandler',
            'tags': {'custom-tag': 'x'},
        },
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'verbose'
        }
    },
    'loggers': {
        'django.db.backends': {
            'level': 'WARNING',
            'handlers': ['console'],
            'propagate': False,
        },
        'raven': {
            'level': 'DEBUG',
            'handlers': ['console'],
            'propagate': False,
        },
        'sentry.errors': {
            'level': 'DEBUG',
            'handlers': ['console'],
            'propagate': False,
        },
    },
}

MIDDLEWARE_CLASSES = (
    'raven.contrib.django.raven_compat.middleware.Sentry404CatchMiddleware',
    'putonghua.settings.production.PageNotFoundBannedMiddleware',
    'django_seo_js.middleware.EscapedFragmentMiddleware',
    'django_seo_js.middleware.UserAgentMiddleware',
) + MIDDLEWARE_CLASSES

INSTALLED_APPS += ('django_seo_js',)
SEO_JS_PRERENDER_TOKEN = "wVrezWyuRVDoSdflFG2A"

STRIPE_PUBLIC_KEY = os.environ.get("STRIPE_PUBLIC_KEY", "pk_live_jePyfu0lZshJHQPUhwxvYLEG")
STRIPE_SECRET_KEY = os.environ.get("STRIPE_SECRET_KEY", "sk_live_4ItdAXbtpjCqfRY6tg4Ka93p")


import json
from django.http import HttpResponse
from putonghua.settings.base import *

INSTALLED_APPS += (
     'debug_toolbar',
)

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
USERENA_ACTIVATION_REQUIRED = True
DATABASES = {
'default': dj_database_url.config(env='PUTONGHUA_DATABASE_URL'),
  #'default': {
  #    'ENGINE': 'django.db.backends.postgresql_psycopg2', # Add 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
  #    'NAME': 'phua',                      # Or path to database file if using sqlite3.
  #    'USER': 'phua',                      # Not used with sqlite3.
  #    'PASSWORD': 'phua',                  # Not used with sqlite3.
  #    'HOST':'localhost',
  # }
}

DATABASES = {
  'default': {
      'ENGINE': 'django.db.backends.postgresql_psycopg2', # Add 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
      'NAME': 'phua',                      # Or path to database file if using sqlite3.
      'USER': 'phua_user',                      # Not used with sqlite3.
      'PASSWORD': 'qwerty',                  # Not used with sqlite3.
      'HOST':'localhost',
   }
}



STATIC_ROOT = '/fake/'
#STATIC_ROOT = 'staticfiles'
STATICFILES_DIRS = (os.path.abspath(os.path.join(BASE_DIR, '../frontend/dist/')),)

STATIC_URL = '/static/'

import raven

RAVEN_CONFIG = {
    'dsn': 'https://8a5ca3e03c5844adb247e4c90ec0eb95:b82613d880644c478d270b4024424825@sentry.io/154618',
    # If you are using git, you can also automatically configure the
    # release based on the git info.
    'release': raven.fetch_git_sha(os.path.dirname(os.pardir)),
}
ADMINS = (
    ('Robert Tonkin', 'robertjtonkin@hotmail.com'),
)

ALLOWED_HOSTS = ['*']
DEBUG = True
LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(process)d %(module)s %(message)s'
        },
        'simple': {
            'format': '%(levelname)s %(message)s'
        },
    },
    'handlers': {
        'file': {
            'level': 'DEBUG',
            'class': 'logging.FileHandler',
            'filename':  os.path.join(BASE_DIR, 'django.log'),
            'formatter': 'verbose',
        },
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'verbose',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['file'],
            'propagate': True,
            'level': 'WARN',
        },
        'django.request': {
            'handlers': ['file'],
            'level': 'ERROR',
            'propagate': True,
        },
        'django.db.backends': {
            'handlers': ['console'],
            'level': 'WARNING',
        },
        'apps': {
            'handlers': ['file', 'console'],
            'level': 'DEBUG',
        },
    },
}

VOICERSS_API_KEY = 'ae67adc4fc8b4493a11c618f4f8e952c'



class NonHtmlDebugToolbarMiddleware(object):
    """
    The Django Debug Toolbar usually only works for views that return HTML.
    This middleware wraps any non-HTML response in HTML if the request
    has a 'debug' query parameter (e.g. http://localhost/foo?debug)
    Special handling for json (pretty printing) and
    binary data (only show data length)
    """

    @staticmethod
    def process_response(request, response):
        if request.GET.get('debug') == '':
            if response['Content-Type'] == 'application/octet-stream':
                new_content = '<html><body>Binary Data, ' \
                    'Length: {}</body></html>'.format(len(response.content))
                response = HttpResponse(new_content)
            elif response['Content-Type'] != 'text/html':
                content = response.content
                try:
                    json_ = json.loads(content.decode('utf-8'))
                    content = json.dumps(json_, sort_keys=True, indent=2)
                except ValueError:
                    pass
                response = HttpResponse('<html><body><pre>{}'
                                        '</pre></body></html>'.format(content))

        return response

MIDDLEWARE_CLASSES += (
    'debug_toolbar.middleware.DebugToolbarMiddleware',
    'putonghua.settings.local.NonHtmlDebugToolbarMiddleware',
)

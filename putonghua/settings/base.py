"""
Django settings for putonghua project.

Generated by 'django-admin startproject' using Django 1.8.1.

For more information on this file, see
https://docs.djangoproject.com/en/1.8/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.8/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
import dj_database_url

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

SITE_ID = 1
# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.8/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '##sY;|W5[a wZb4VCrSd/j1X.ZSN,pelXm@}G+; GZWIomL_4c,2$,+r|_{MOA>m'


DEFAULT_FROM_EMAIL = 'admin@chinesevault.com'
# Application definition

DJANGO_APPS = (
    'grappelli',
    'tinymce',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    'django.contrib.flatpages',
'raven.contrib.django.raven_compat'
)

THIRDPARTY_APPS = (
    'userena',
    'guardian',
    'easy_thumbnails',
    'django_extensions',
    'tastypie',
    'bootstrap3',
    'djrill',
    'djangular',
    'custom_django_select2',
    'django_hstore',
    'sortedm2m',
    "djstripe",
)

LOCAL_APPS = (
    'putonghua.core',
    'putonghua.api',
)

INSTALLED_APPS = DJANGO_APPS + THIRDPARTY_APPS + LOCAL_APPS

AUTHENTICATION_BACKENDS = (
    'userena.backends.UserenaAuthenticationBackend',
    'guardian.backends.ObjectPermissionBackend',
    'django.contrib.auth.backends.ModelBackend',
)


MIDDLEWARE_CLASSES = (

    'djangular.middleware.DjangularUrlMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.auth.middleware.SessionAuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.flatpages.middleware.FlatpageFallbackMiddleware',
)

DJSTRIPE_SUBSCRIPTION_REQUIRED_EXCEPTION_URLS = (
)

ROOT_URLCONF = 'putonghua.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        # 'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'DIRS': [os.path.abspath(os.path.join(BASE_DIR, '../frontend/dist/'))],
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

WSGI_APPLICATION = 'putonghua.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.8/ref/settings/#databases

DATABASES = {
    'default': dj_database_url.config()
}


# Internationalization
# https://docs.djangoproject.com/en/1.8/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.8/howto/static-files/
STATIC_ROOT = 'staticfiles'
#STATIC_ROOT = os.path.abspath(os.path.join(BASE_DIR, '../frontend/src'))

STATIC_URL = '/static/'


MEDIA_ROOT = os.path.abspath(os.path.join(BASE_DIR, '../media'))
MEDIA_URL = '/media/'

# STATICFILES_DIRS = (
#     os.path.join(BASE_DIR, '../frontend/src'),
# )

AUTH_USER_MODEL = 'core.User'

# USERENA SETTINGS #####################################

AUTH_PROFILE_MODULE = 'core.UserProfile'
ANONYMOUS_USER_ID = -1
USERENA_SIGNIN_REDIRECT_URL = '/'
LOGIN_URL = '/app/login'
LOGOUT_URL = '/app/logout'
USERENA_REDIRECT_ON_SIGNOUT = '/'
USERENA_FORBIDDEN_USERNAMES = (
    'signup', 'signout', 'signin', 'activate', 'me', 'password', 'login', 'logout', 'admin', 'root',
    'administrator', 'url'
)
USERENA_REGISTER_PROFILE = False
USERENA_REGISTER_USER = False
# END USERENA SETTINGS #####################################


# GRAPPELLI SETTINGS #####################################
GRAPPELLI_ADMIN_TITLE = 'Chinesevault Admin'
# END GRAPPELLI SETTINGS #####################################


TASTYPIE_DEFAULT_FORMATS = ['json']

USERNAME_VALIDATION_PATTERN = r'^(?!.*?([_\.-]{2,}|[_\.-]$))(?=^.{4,64}$)[A-Za-z][\w\-\.]+$'

# TINYMCE SETTINGS ##################################################
TINYMCE_DEFAULT_CONFIG = {
    # your other configuration
    'theme_advanced_buttons3_add': 'code',
}
# END TINYMCE SETTINGS

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.filebased.FileBasedCache',
        'LOCATION': '/tmp/chinesevault_cache',
        'TIMEOUT': 60,
    }
}

# STRIPE SETTINGS #######################################################

STRIPE_PUBLIC_KEY = os.environ.get("STRIPE_PUBLIC_KEY", "pk_live_jePyfu0lZshJHQPUhwxvYLEG")
STRIPE_SECRET_KEY = os.environ.get("STRIPE_SECRET_KEY", "sk_live_4ItdAXbtpjCqfRY6tg4Ka93p")

DJSTRIPE_PLANS = {
    "monthly": {
        "stripe_plan_id": "7",
        "name": "Regular Plan",
        "description": "CHINESE VAULT",
        "price": 700,  # $25.00
        "currency": "usd",
        "trial_period": 30,
        "interval": "month"
    },
}

CANCELLATION_AT_PERIOD_END = True
# END STRIPE SETTINGS
"""
WSGI config for putonghua project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.8/howto/deployment/wsgi/
"""

import os


try:
    from raven.contrib.django.raven_compat.middleware.wsgi import Sentry
except ImportError:
    RAVEN_INSTALLED = False
else:
    RAVEN_INSTALLED = True
from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "putonghua.settings.production")

application = get_wsgi_application()
if RAVEN_INSTALLED:
    application = Sentry(get_wsgi_application())

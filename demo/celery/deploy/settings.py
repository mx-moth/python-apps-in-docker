import os

from dj_database_url import parse
from mywebapp.settings import *  # noqa

SECRET_KEY = os.environ['DJANGO_SECRET_KEY']
DEBUG = bool(int(os.environ['DJANGO_DEBUG']))

ALLOWED_HOSTS = [os.environ['DJANGO_HOSTNAME']]

DATABASES = {'default': parse(os.environ['DATABASE_URL'])}

ADMINS = ['errors@timheap.me']

STATIC_ROOT = os.environ['DJANGO_STATIC_ROOT']

CELERY_BROKER_URL = os.environ['CELERY_BROKER_URL']

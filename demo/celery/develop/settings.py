import os

from dj_database_url import parse
from mywebapp.settings import *

SECRET_KEY = 'super secret shhhhh'
DEBUG = True

ALLOWED_HOSTS = ['localhost', '*']

DATABASES = {'default': parse(os.environ['DATABASE_URL'])}

DATA_ROOT = '/opt/my-web-app/data/'
MEDIA_ROOT = DATA_ROOT + 'media/'

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'mail'
EMAIL_PORT = 25

CELERY_BROKER_URL = os.environ['CELERY_BROKER_URL']

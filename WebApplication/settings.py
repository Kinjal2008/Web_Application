"""
Django settings for WebApplication project.

Generated by 'django-admin startproject' using Django 3.0.8.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.0/ref/settings/
"""

import os

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '_z2j+4p393p-my12*-*he=d!=nxos%03an8(+7j%^4iist1=q$'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []

# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    'adminpanel.apps.AdminConfig',
    'crispy_forms',
    'django_countries',
    'WebEcommerce.apps.WebecommerceConfig',
    'stripe'
]

SITE_ID = 1

CRISPY_TEMPLATE_PACK = 'bootstrap4'

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'WebApplication.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'adminpanel/templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'WebEcommerce.context_processors.stripeSettingValues',
            ],
        },
    },
]

WSGI_APPLICATION = 'WebApplication.wsgi.application'

# Database
# https://docs.djangoproject.com/en/3.0/ref/settings/#databases

DATABASES = {
    'default': {
        # 'ENGINE': 'django.db.backends.sqlite3',
        # 'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'prolongevity',
        'USER': 'root',
        'PASSWORD': 'admin',
        'HOST': 'localhost',
        'PORT': '3306',
        'OPTIONS': {
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'"
        }
    }
}

# Password validation
# https://docs.djangoproject.com/en/3.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

# Internationalization
# https://docs.djangoproject.com/en/3.0/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = False

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.0/howto/static-files/

STATIC_URL = '/static/'

STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static')
]

AUTH_USER_MODEL = 'adminpanel.User'
AUTHENTICATION_BACKENDS = [
    'adminpanel.CustomUserDecorator.CustomDecorator'
]

# Set the number of days prior to which we need to send Automatic email reminder to client.
# It will be used in AutoReminderEmailForInstalmentPayment.py file.

EMAIL_REMINDER_DAYS = 5

DATE_INPUT_FORMATS = ('%d-%m-%Y', '%Y-%m-%d')

# SMTP Configuration
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_ROOT = 587
EMAIL_USE_TLS = True
EMAIL_HOST_USER = 'prolongevity123@gmail.com'
EMAIL_HOST_PASSWORD = 'zaq1ZAQ!'

if os.getcwd() == '/app':
    SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
    SECURE_SSL_REDIRECT = True
    DEBUG = False

MEDIA_URL = '/productimages/'

MEDIA_ROOT = os.path.join(BASE_DIR, 'static/productimages')

PDF_URL = '/invoicepdf/'
PDF_ROOT = os.path.join(BASE_DIR, 'static/invoicepdf')

PaymentProcessorDomain = 'paymentprocessor.net'

PaymentProcessorPort = '4430'

STRIPE_PUBLISHABLE_KEY = 'pk_test_CfCShTwexDCdPO3cuj9KyIVr'
# 'pk_test_CfCShTwexDCdPO3cuj9KyIVr'
STRIPE_SECRET_KEY = 'sk_test_2307FN7S7CCZCZGdCMhjqhTV00jO5nN1jQ'
# 'sk_test_2307FN7S7CCZCZGdCMhjqhTV00jO5nN1jQ'

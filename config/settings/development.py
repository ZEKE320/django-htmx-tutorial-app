from .base import *

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "HOST": "host.docker.internal",
        "PORT": "15432",
        "NAME": "airline_tickets",
        "USER": "airline_tickets",
        "PASSWORD": "password",
    }
}

ALLOWED_HOSTS = ["localhost", "desktop.k-tamura.me"]

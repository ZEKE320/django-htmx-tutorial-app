from . import base
from .base import *  # noqa: F403

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

STATICFILES_DIRS = [base.BASE_DIR / ".." / "app" / "airline_tickets" / "static"]

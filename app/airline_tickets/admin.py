from django.apps import apps
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .models import CustomerAccount

# Register your models here.


admin.site.register(CustomerAccount, UserAdmin)

models = apps.get_app_config("airline_tickets").get_models()
for model in models:
    if model.__name__ == "CustomerAccount":
        continue
    admin.site.register(model)

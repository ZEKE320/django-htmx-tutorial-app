from airline_tickets.forms import RegisterAccountForm
from airline_tickets.models import CustomerAccount
from django.db import transaction


@transaction.atomic
def register_account_data(form: RegisterAccountForm):
    if not form.is_valid():
        raise RuntimeError(f"Error: {str(form.errors)}")

    username = form.cleaned_data["reg_username"]
    password = form.cleaned_data["reg_password"]
    password_again = form.cleaned_data["reg_password_again"]

    if len(CustomerAccount.objects.filter(username=username)) > 0:
        raise RuntimeError(f"A user with the name {username} already exists.")

    if password != password_again:
        raise RuntimeError("Passwords do not match.")

    CustomerAccount.objects.create_user(username=username, password=password)
    return username, password

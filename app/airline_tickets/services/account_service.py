from airline_tickets.forms.account_form import RegisterAccountForm
from airline_tickets.models import CustomerAccount
from django.db import transaction


@transaction.atomic
def register_account_data(form: RegisterAccountForm):
    username = form.cleaned_data["reg_username"]
    password = form.cleaned_data["reg_password"]
    password_again = form.cleaned_data["reg_password_again"]

    if password != password_again:
        raise RuntimeError("Passwords do not match.")

    customer_accounts = CustomerAccount.objects.filter(username=username)

    if customer_accounts.exists():
        raise RuntimeError(f"The user with the name '{username}' already exists.")

    CustomerAccount.objects.create_user(username=username, password=password)
    return username, password

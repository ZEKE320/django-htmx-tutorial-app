from django import forms


class RegisterAccountForm(forms.Form):
    reg_username = forms.CharField(
        label="Username", initial="", min_length=2, max_length=150, required=True
    )
    reg_password = forms.CharField(
        label="Password", initial="", min_length=8, max_length=128, required=True
    )
    reg_password_again = forms.CharField(
        label="Type password again",
        initial="",
        min_length=8,
        max_length=128,
        required=True,
    )


class LoginForm(forms.Form):
    username = forms.CharField(
        label="Username", initial="", max_length=150, required=True
    )
    password = forms.CharField(
        label="Password", initial="", max_length=128, required=True
    )

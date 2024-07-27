from django import forms


class RegisterAccountForm(forms.Form):
    reg_username = forms.CharField(max_length=150, required=True)
    reg_password = forms.CharField(min_length=8, max_length=128, required=True)
    reg_password_again = forms.CharField(min_length=8, max_length=128, required=True)


class LoginForm(forms.Form):
    username = forms.CharField(max_length=150, required=True)
    password = forms.CharField(max_length=128, required=True)

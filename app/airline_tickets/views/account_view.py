from airline_tickets.forms.account_form import LoginForm, RegisterAccountForm
from airline_tickets.services.account_service import register_account_data
from django.contrib.auth import authenticate, login, logout
from django.http import HttpRequest, HttpResponse
from django.shortcuts import redirect, render


def register_account_page(
    request: HttpRequest,
    registered_ok: bool = False,
    error_msg: str | None = None,
    register_form: RegisterAccountForm = RegisterAccountForm(),
) -> HttpResponse:
    if not (
        "login" in request.META.get("HTTP_REFERER")
        or "register_account" in request.META.get("HTTP_REFERER")
    ):
        request.session["next_url"] = request.META.get("HTTP_REFERER")

    next_url = request.session.get("next_url", "/")

    if request.user.is_authenticated:
        return redirect(next_url, permanent=True)

    if request.method == "POST":
        return do_register_account(request)

    return render(
        request,
        "register_account.html",
        {
            "registered_ok": registered_ok,
            "error_msg": error_msg,
            "form": register_form,
        },
    )


def do_register_account(request: HttpRequest) -> HttpResponse:
    next_url = request.session.get("next_url", "/")

    form = RegisterAccountForm(request.POST)

    try:
        if not form.is_valid():
            raise RuntimeError(f"Error: {str(form.errors)}")

        username, password = register_account_data(form)
        user = authenticate(request, username=username, password=password)
        if user is None:
            raise RuntimeError("Failed to create user.")

    except RuntimeError as e:
        request.method = "GET"
        return register_account_page(
            request=request,
            registered_ok=e is None,
            error_msg=str(e),
            register_form=form,
        )

    login(request, user)

    return redirect(next_url, permanent=True)


def login_page(
    request: HttpRequest,
    error_msg: str | None = None,
    login_form: LoginForm = LoginForm(),
) -> HttpResponse:
    if not (
        "login" in request.META.get("HTTP_REFERER")
        or "register_account" in request.META.get("HTTP_REFERER")
    ):
        request.session["next_url"] = request.META.get("HTTP_REFERER")

    next_url = request.session.get("next_url", "/")

    if request.user.is_authenticated:
        return redirect(next_url, permanent=True)

    if request.method == "POST":
        return do_login(request)

    return render(
        request,
        "login.html",
        {"error_msg": error_msg, "form": login_form},
    )


def do_login(request: HttpRequest) -> HttpResponse:
    next_url = request.session.get("next_url", "/")

    form = LoginForm(request.POST)
    try:
        if not form.is_valid():
            raise RuntimeError()

        username = form.cleaned_data["username"]
        password = form.cleaned_data["password"]
        user = authenticate(request, username=username, password=password)

        if user is None:
            raise RuntimeError()

    except RuntimeError:
        error = "Invalid username or password."
        request.method = "GET"
        return login_page(request, error, form)

    login(request, user)

    return redirect(next_url, permanent=True)


def do_logout(request: HttpRequest):
    logout(request)
    return redirect("login", permanent=True)

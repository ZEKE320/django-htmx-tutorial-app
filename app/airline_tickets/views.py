from airline_tickets.dto.flight_search_dto import AirportDto
from airline_tickets.forms import LoginForm, RegisterAccountForm
from airline_tickets.models import Airport
from airline_tickets.services.account_service import register_account_data
from django.contrib.auth import authenticate, login, logout
from django.http import HttpRequest, HttpResponse
from django.shortcuts import redirect, render

# Create your views here.


def top(request: HttpRequest) -> HttpResponse:
    available_airports = Airport.objects.all()
    airport_list = [
        AirportDto(
            name=airport.name,
            country=airport.address.city.prefecture.country.name,
            prefecture=airport.address.city.prefecture.name,
            iata_code=airport.iata_code,
        )
        for airport in available_airports
    ]

    username = request.user.get_username() if request.user.is_authenticated else ""

    return render(
        request,
        "top.html",
        {
            "available_airports": airport_list,
            "username": username,
        },
    )


def search(request: HttpRequest) -> HttpResponse:
    return HttpResponse("Search page")


def register_account_page(
    request: HttpRequest,
    registered_ok: bool = False,
    error_msg: str = "",
    register_form: RegisterAccountForm = RegisterAccountForm(),
) -> HttpResponse:
    if request.user.is_authenticated:
        return redirect("top", permanent=True)

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
    form = RegisterAccountForm(request.POST)

    try:
        username, password = register_account_data(form)
        user = authenticate(request, username=username, password=password)
        if user is None:
            raise RuntimeError("Failed to create user.")

    except RuntimeError as e:
        request.method = "GET"
        return register_account_page(request, e is None, str(e), register_form=form)

    login(request, user)
    return redirect("top", permanent=True)


def login_page(
    request: HttpRequest,
    error_msg: str = "",
    login_form: LoginForm = LoginForm(),
) -> HttpResponse:
    if request.user.is_authenticated:
        return redirect("top", permanent=True)

    if request.method == "POST":
        return do_login(request)

    return render(
        request,
        "login.html",
        {
            "error_msg": error_msg,
            "form": login_form,
        },
    )


def do_login(request: HttpRequest) -> HttpResponse:
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
    return redirect("top", permanent=True)


def do_logout(request: HttpRequest):
    logout(request)
    return redirect("login", permanent=True)

from airline_tickets.dto.flight_search_dto import AirportDto
from airline_tickets.models import Airport
from django.http import HttpResponse
from django.shortcuts import render

# Create your views here.


def index(request):
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

    login = request.session.get("authorized_user_login", None)

    context = {"available_airports": airport_list, "user_login": login}

    return render(request, "index.html", context)


def search(request):
    return HttpResponse("Search page")


def register_account_page(request):
    return HttpResponse("Register account page")


def register_account(request):
    return HttpResponse("Register account")


def login_page(request):
    return render(request, "login.html", {})


def login(request):
    return HttpResponse("Login")

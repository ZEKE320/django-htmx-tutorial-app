from airline_tickets.dto.flight_dto import (
    FlightDetailDto,
)
from airline_tickets.forms.app_form import FlightReserveForm, FlightSearchForm
from airline_tickets.models import (
    Flight,
)
from airline_tickets.services.app_service import (
    get_available_airports,
    get_customer_tickets_dto,
    get_flight_seat_availability_by_type,
    reserve_flight_data,
    search_flights,
)
from django.contrib.auth.decorators import login_required
from django.http import HttpRequest, HttpResponse
from django.shortcuts import redirect, render


def top_page(request: HttpRequest) -> HttpResponse:
    if request.user.is_authenticated:
        customer_tickets_dto = get_customer_tickets_dto(request.user)
    else:
        customer_tickets_dto = []

    return render(
        request,
        "top.html",
        {
            "available_airports": get_available_airports(),
            "flight_search_form": FlightSearchForm(),
            "tickets": customer_tickets_dto,
        },
    )


def search_page(
    request: HttpRequest,
    error_msg: str | None = None,
) -> HttpResponse:
    form = FlightSearchForm(request.GET) if request.GET else FlightSearchForm()

    flight_search_result = search_flights(form) if form.is_valid() else []

    return render(
        request,
        "search.html",
        {
            "error_msg": error_msg,
            "available_airports": get_available_airports(),
            "flight_search_form": form,
            "flights": flight_search_result,
        },
    )


def flight_page(
    request: HttpRequest,
    id: str,
    form: FlightReserveForm = FlightReserveForm(),
    error_msg: str | None = None,
) -> HttpResponse:
    flight = Flight.objects.get(id=id)
    seat_status_by_type = get_flight_seat_availability_by_type(flight)

    flight_detail_dto = FlightDetailDto(
        flight_id=flight.id,
        name=flight.name,
        company_name=flight.airline_company.name,
        economy_class_status=seat_status_by_type["Economy class"],
        business_class_status=seat_status_by_type["Business class"],
        first_class_status=seat_status_by_type["First class"],
        departure_airport=flight.airline.flight_route.departure_airport.name,
        arrival_airport=flight.airline.flight_route.arrival_airport.name,
        departure_date=flight.departure_time.strftime("%Y/%m/%d"),
        departure_time=flight.departure_time.strftime("%H:%M"),
        arrival_date=flight.arrival_time.strftime("%Y/%m/%d"),
        arrival_time=flight.arrival_time.strftime("%H:%M"),
    )

    return render(
        request,
        "flight.html",
        {
            "flight": flight_detail_dto,
            "form": form,
            "error_msg": error_msg,
        },
    )


@login_required(login_url="login")
def reserve_flight(
    request: HttpRequest,
    flight_id: str,
) -> HttpResponse:
    if request.method != "POST":
        return redirect(f"/flight/{flight_id}", permanent=True)

    form = FlightReserveForm(request.POST)

    if not form.is_valid():
        return flight_page(request, flight_id, form, "Please select a seat.")

    customer_account = request.user
    reserve_flight_data(form, customer_account)

    return redirect("reserved_ticket", permanent=True)


@login_required(login_url="login")
def reserved_ticket_page(request: HttpRequest) -> HttpResponse:
    customer_tickets_dto = get_customer_tickets_dto(request.user)

    return render(request, "reserved_ticket.html", {"tickets": customer_tickets_dto})

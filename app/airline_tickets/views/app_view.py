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
        get_customer_tickets_dto(request.user)
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

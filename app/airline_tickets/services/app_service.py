from datetime import date, datetime

from airline_tickets.dto.flight_dto import (
    AirportDto,
    CustomerTicketDto,
    FlightSearchResultDto,
    FlightSeatDto,
    FlightSeatStatusDto,
)
from airline_tickets.forms.app_form import FlightReserveForm, FlightSearchForm
from airline_tickets.models import (
    AircraftSeatType,
    AirlineTicket,
    Airport,
    CustomerAccount,
    CustomerTicket,
    Flight,
    FlightRoute,
    FlightSeat,
)
from django.db import transaction
from django.db.models import Q
from django.db.models.manager import BaseManager


def search_flights(form: FlightSearchForm) -> list[FlightSearchResultDto]:
    departure_airport_label: str | None = form.cleaned_data.get("departure_airport")
    arrival_airport_label: str | None = form.cleaned_data.get("arrival_airport")
    date_from: date | None = form.cleaned_data.get("date_from")
    date_to: date | None = form.cleaned_data.get("date_to")

    flight_routes = filter_flight_routes(departure_airport_label, arrival_airport_label)
    if not flight_routes.exists():
        return []

    flights = filter_flights(date_from, date_to, flight_routes)

    flight_search_result = get_flight_search_results_dto(flights)
    return flight_search_result


def filter_flight_routes(
    departure_airport_label: str | None, arrival_airport_label: str | None
) -> BaseManager[FlightRoute]:
    flight_route_query = Q()
    if departure_airport_label:
        departure_airport_iata_code = departure_airport_label.split("-")[-1].strip()
        flight_route_query &= Q(
            departure_airport__iata_code=departure_airport_iata_code
        )
    if arrival_airport_label:
        arrival_airport_iata_code = arrival_airport_label.split("-")[-1].strip()
        flight_route_query &= Q(arrival_airport__iata_code=arrival_airport_iata_code)

    flight_routes = FlightRoute.objects.filter(flight_route_query)
    return flight_routes


def filter_flights(
    date_from: date | None,
    date_to: date | None,
    flight_routes: BaseManager[FlightRoute],
) -> BaseManager[Flight]:
    flight_query = Q(airline__flight_route__in=flight_routes)
    date_query = Q()
    if date_from:
        date_query &= Q(departure_time__gte=date_from)
    if date_to:
        date_query &= Q(arrival_time__lte=date_to)
    flight_query &= date_query

    flights = Flight.objects.filter(flight_query)
    return flights


def get_flight_search_results_dto(
    flights: BaseManager[Flight],
) -> list[FlightSearchResultDto]:
    flight_search_results = sorted(
        [get_single_flight_search_result_dto(f) for f in flights],
        key=lambda fsrd: (fsrd.departure_date, fsrd.departure_time),
    )

    return flight_search_results


def get_single_flight_search_result_dto(flight: Flight) -> FlightSearchResultDto:
    seat_status_by_type = get_flight_seat_availability_by_type(flight)

    return FlightSearchResultDto(
        flight_id=flight.id,
        name=flight.name,
        company_name=flight.airline_company.name,
        economy_class_seats_available=seat_status_by_type["Economy class"].available,
        economy_class_seats_total=seat_status_by_type["Economy class"].total,
        business_class_seats_available=seat_status_by_type["Business class"].available,
        business_class_seats_total=seat_status_by_type["Business class"].total,
        first_class_seats_available=seat_status_by_type["First class"].available,
        first_class_seats_total=seat_status_by_type["First class"].total,
        departure_airport=flight.airline.flight_route.departure_airport.name,
        arrival_airport=flight.airline.flight_route.arrival_airport.name,
        departure_date=flight.departure_time.strftime("%Y/%m/%d"),
        departure_time=flight.departure_time.strftime("%H:%M"),
        arrival_date=flight.arrival_time.strftime("%Y/%m/%d"),
        arrival_time=flight.arrival_time.strftime("%H:%M"),
    )


def get_flight_seat_availability_by_type(
    flight: Flight,
) -> dict[str, FlightSeatStatusDto]:
    flight_seats: BaseManager[FlightSeat] = flight.flightseat_set.all()
    aircraft_seat_types: BaseManager[AircraftSeatType] = AircraftSeatType.objects.all()
    seat_status_by_type = {}

    for type in aircraft_seat_types:
        total_seats = flight_seats.filter(aircraft_seat__aircraft_seat_type=type)

        q1 = Q(customerticket=None)

        available_seats = total_seats.filter(q1)
        airline_ticket = AirlineTicket.objects.get(
            flight=flight, aircraft_seat_type=type
        )

        available_seats_dto = [
            FlightSeatDto(
                id=seat.id,
                name=seat.aircraft_seat.name,
            )
            for seat in available_seats
        ]

        seat_status_by_type[type.name] = FlightSeatStatusDto(
            airline_ticket_id=airline_ticket.id,
            total=len(total_seats),
            available=len(available_seats),
            available_seats=available_seats_dto,
        )

    return seat_status_by_type


def get_available_airports():
    available_airports = Airport.objects.all()
    airport_list = sorted(
        [
            AirportDto(
                id=airport.id,
                name=airport.name,
                country=airport.address.city.prefecture.country.name,
                prefecture=airport.address.city.prefecture.name,
                iata_code=airport.iata_code,
            )
            for airport in available_airports
        ],
        key=lambda a: a.iata_code,
    )

    return airport_list


@transaction.atomic
def reserve_flight_data(
    form: FlightReserveForm, customer_account: CustomerAccount
) -> None:
    airline_ticket = AirlineTicket.objects.get(
        id=form.cleaned_data["airline_ticket_id"]
    )
    flight_seat = FlightSeat.objects.get(id=form.cleaned_data["seat_id"])
    purchase_date = datetime.now()

    CustomerTicket.objects.create(
        customer_account=customer_account,
        airline_ticket=airline_ticket,
        flight_seat=flight_seat,
        purchase_date=purchase_date,
    )

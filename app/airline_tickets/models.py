from uuid import uuid4

from django.contrib.auth.models import AbstractUser
from django.db import models

# # Create your models here.


class CustomerAccount(AbstractUser):
    id = models.UUIDField(primary_key=True, editable=False, default=uuid4)

    REQUIRED_FIELDS = []


class BaseModel(models.Model):
    id = models.UUIDField(primary_key=True, editable=False, default=uuid4)

    class Meta:
        abstract = True


class Customer(BaseModel):
    customer_account = models.ForeignKey(CustomerAccount, on_delete=models.PROTECT)
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


class AirlineCompany(BaseModel):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


class AircraftModel(BaseModel):
    name = models.CharField(max_length=50)
    num_economy_seats = models.PositiveIntegerField()
    num_business_seats = models.PositiveIntegerField()
    num_first_class_seats = models.PositiveIntegerField()

    def __str__(self):
        return self.name


class AircraftSeatType(BaseModel):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


class AircraftSeat(BaseModel):
    aircraft_model = models.ForeignKey(AircraftModel, on_delete=models.PROTECT)
    aircraft_seat_type = models.ForeignKey(AircraftSeatType, on_delete=models.PROTECT)
    name = models.CharField(max_length=10)

    def __str__(self):
        return f"{self.aircraft_model} {self.name} ({self.aircraft_seat_type})"


class Aircraft(BaseModel):
    aircraft_model = models.ForeignKey(AircraftModel, on_delete=models.PROTECT)
    aircraft_company = models.ForeignKey(AirlineCompany, on_delete=models.PROTECT)
    name = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.name} ({self.aircraft_company})"


class Country(BaseModel):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


class Prefecture(BaseModel):
    name = models.CharField(max_length=50)
    country = models.ForeignKey(Country, on_delete=models.PROTECT)

    def __str__(self):
        return f"{self.name}, {self.country}"


class City(BaseModel):
    name = models.CharField(max_length=50)
    prefecture = models.ForeignKey(Prefecture, on_delete=models.PROTECT)

    def __str__(self):
        return f"{self.name}, {self.prefecture}"


class Address(BaseModel):
    city = models.ForeignKey(City, on_delete=models.PROTECT)
    address_line_1 = models.CharField(max_length=50)
    address_line_2 = models.CharField(max_length=50, blank=True)
    postal_code = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.postal_code}, {self.address_line_1}, {self.city}"


class Airport(BaseModel):
    address = models.ForeignKey(Address, on_delete=models.PROTECT)
    iata_code = models.CharField(
        max_length=3,
        unique=True,
    )
    icao_code = models.CharField(
        max_length=4,
        unique=True,
    )
    name = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.name}"


class FlightRoute(BaseModel):
    departure_airport = models.ForeignKey(
        Airport, on_delete=models.PROTECT, related_name="departure_airport"
    )
    waypoints = models.ManyToManyField(
        Airport,
        through="Waypoint",
        through_fields=("flight_route", "airport"),
        related_name="waypoint_airports",
        blank=True,
    )
    arrival_airport = models.ForeignKey(
        Airport, on_delete=models.PROTECT, related_name="arrival_airport"
    )

    def __str__(self):
        airports = [
            self.departure_airport,
            *self.waypoints.all(),
            self.arrival_airport,
        ]
        return " -> ".join([airport.name for airport in airports])


class Waypoint(BaseModel):
    airport = models.ForeignKey(Airport, on_delete=models.PROTECT)
    flight_route = models.ForeignKey(FlightRoute, on_delete=models.PROTECT)
    order = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.airport} ({self.flight_route})"


class Airline(BaseModel):
    name = models.CharField(max_length=50)
    flight_route = models.ForeignKey(FlightRoute, on_delete=models.PROTECT)

    def __str__(self):
        return f"{self.name} ({self.flight_route})"


class Flight(BaseModel):
    airline_company = models.ForeignKey(AirlineCompany, on_delete=models.PROTECT)
    aircraft = models.ForeignKey(Aircraft, on_delete=models.PROTECT)
    airline = models.ForeignKey(Airline, on_delete=models.PROTECT)
    name = models.CharField(max_length=50)
    publish_date = models.DateTimeField()
    departure_time = models.DateTimeField()
    arrival_time = models.DateTimeField()

    def __str__(self):
        return self.name


class FlightSeat(BaseModel):
    flight = models.ForeignKey(Flight, on_delete=models.PROTECT)
    aircraft_seat = models.ForeignKey(AircraftSeat, on_delete=models.PROTECT)

    def __str__(self):
        return f"{self.aircraft_seat} ({self.flight})"

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=["flight", "aircraft_seat"], name="unique_flight_aircraft_seat"
            )
        ]


class AirlineTicketType(BaseModel):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


class AirlineTicket(BaseModel):
    flight = models.ForeignKey(Flight, on_delete=models.PROTECT)
    airline_company = models.ForeignKey(AirlineCompany, on_delete=models.PROTECT)
    aircraft_seat_type = models.ForeignKey(AircraftSeatType, on_delete=models.PROTECT)
    name = models.CharField(max_length=50)
    price = models.PositiveIntegerField()

    def __str__(self):
        return self.name


class CustomerTicket(BaseModel):
    customer_account = models.ForeignKey(CustomerAccount, on_delete=models.PROTECT)
    airline_ticket = models.ForeignKey(AirlineTicket, on_delete=models.PROTECT)
    aircraft_seat = models.ForeignKey(AircraftSeat, on_delete=models.PROTECT)
    purchase_date = models.DateTimeField()
    canceled = models.BooleanField()

    def __str__(self):
        return f"{self.airline_ticket} ({self.customer_account})"

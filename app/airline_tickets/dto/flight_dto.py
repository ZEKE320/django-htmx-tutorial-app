from pydantic import UUID4, BaseModel


class AirportDto(BaseModel):
    id: UUID4
    name: str
    country: str
    prefecture: str
    iata_code: str


class FlightSearchResultDto(BaseModel):
    flight_id: UUID4
    name: str
    company_name: str
    economy_class_seats_available: int
    economy_class_seats_total: int
    business_class_seats_available: int
    business_class_seats_total: int
    first_class_seats_available: int
    first_class_seats_total: int
    departure_airport: str
    arrival_airport: str
    departure_date: str
    departure_time: str
    arrival_date: str
    arrival_time: str


class FlightDetailDto(BaseModel):
    flight_id: UUID4
    name: str
    company_name: str
    economy_class_status: "FlightSeatStatusDto"
    business_class_status: "FlightSeatStatusDto"
    first_class_status: "FlightSeatStatusDto"
    departure_airport: str
    arrival_airport: str
    departure_date: str
    departure_time: str
    arrival_date: str
    arrival_time: str


class FlightSeatStatusDto(BaseModel):
    airline_ticket_id: UUID4
    total: int
    available: int
    available_seats: list["FlightSeatDto"]


class FlightSeatDto(BaseModel):
    id: UUID4
    name: str


class CustomerTicketDto(BaseModel):
    ticket_id: UUID4
    flight_id: UUID4
    name: str
    company_name: str
    seat_type: str
    seat_name: str
    reserved_date: str
    departure_airport: str
    arrival_airport: str
    departure_date: str
    departure_time: str
    arrival_date: str
    arrival_time: str
    canceled: str

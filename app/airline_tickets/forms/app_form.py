import datetime

from django import forms


class FlightSearchForm(forms.Form):
    departure_airport = forms.CharField(
        label="Departure airport 🛫", initial="", required=False
    )
    arrival_airport = forms.CharField(
        label="Arrival airport 🛬", initial="", required=False
    )
    date_from = forms.DateField(
        label="Date from", initial=datetime.date.today().strftime("%Y-%m-%d")
    )
    date_to = forms.DateField(
        label="Date to",
        initial=(datetime.date.today() + datetime.timedelta(weeks=2)).strftime(
            "%Y-%m-%d"
        ),
    )


class FlightReserveForm(forms.Form):
    airline_ticket_id = forms.UUIDField()
    seat_id = forms.UUIDField()

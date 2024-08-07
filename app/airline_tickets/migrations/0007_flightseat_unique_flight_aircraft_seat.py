# Generated by Django 5.0.7 on 2024-07-28 14:24

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("airline_tickets", "0006_flightseat_reserved"),
    ]

    operations = [
        migrations.AddConstraint(
            model_name="flightseat",
            constraint=models.UniqueConstraint(
                fields=("flight", "aircraft_seat"), name="unique_flight_aircraft_seat"
            ),
        ),
    ]

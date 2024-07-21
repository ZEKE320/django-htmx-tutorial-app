# Generated by Django 5.0.6 on 2024-07-21 07:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("airline_tickets", "0002_aircraft_name_airline_name_airlineticket_name"),
    ]

    operations = [
        migrations.AlterField(
            model_name="flightroute",
            name="waypoints",
            field=models.ManyToManyField(
                blank=True,
                related_name="waypoint_airports",
                through="airline_tickets.Waypoint",
                to="airline_tickets.airport",
            ),
        ),
    ]

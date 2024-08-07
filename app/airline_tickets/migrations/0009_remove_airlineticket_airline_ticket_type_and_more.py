# Generated by Django 5.0.7 on 2024-07-30 01:54

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("airline_tickets", "0008_remove_flightseat_reserved"),
    ]

    operations = [
        migrations.RemoveField(
            model_name="airlineticket",
            name="airline_ticket_type",
        ),
        migrations.AddField(
            model_name="airlineticket",
            name="aircraft_seat_type",
            field=models.ForeignKey(
                null=True,
                on_delete=django.db.models.deletion.PROTECT,
                to="airline_tickets.aircraftseattype",
            ),
        ),
    ]

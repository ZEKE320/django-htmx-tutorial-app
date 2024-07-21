# Generated by Django 5.0.6 on 2024-07-21 07:58

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("airline_tickets", "0005_airlinetickettype_airlineticket_airline_ticket_type"),
    ]

    operations = [
        migrations.AlterField(
            model_name="airlineticket",
            name="airline_ticket_type",
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.PROTECT,
                to="airline_tickets.airlinetickettype",
            ),
        ),
    ]

# Generated by Django 5.0.7 on 2024-07-28 13:50

from django.db import migrations


class Migration(migrations.Migration):
    dependencies = [
        ("airline_tickets", "0003_flight_company"),
    ]

    operations = [
        migrations.RenameField(
            model_name="flight",
            old_name="company",
            new_name="airline_company",
        ),
    ]

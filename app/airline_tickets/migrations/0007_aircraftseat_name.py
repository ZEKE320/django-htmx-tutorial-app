# Generated by Django 5.0.6 on 2024-07-21 08:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("airline_tickets", "0006_alter_airlineticket_airline_ticket_type"),
    ]

    operations = [
        migrations.AddField(
            model_name="aircraftseat",
            name="name",
            field=models.CharField(default="A1", max_length=10),
            preserve_default=False,
        ),
    ]
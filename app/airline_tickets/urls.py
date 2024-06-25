from django.urls import path

from app.airline_tickets import views

urlpatterns = [path("", views.top, name="top")]

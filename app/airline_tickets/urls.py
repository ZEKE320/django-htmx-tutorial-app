from django.urls import path

from app.airline_tickets import views

urlpatterns = [
    path("", views.index, name="index"),
    path("login", views.login_page, name="login_page"),
]

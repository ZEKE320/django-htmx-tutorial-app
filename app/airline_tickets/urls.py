from django.urls import path

from app.airline_tickets import views

urlpatterns = [
    path("", views.top, name="top"),
    path("login", views.login_page, name="login"),
    path("register_account", views.register_account_page, name="register_account"),
    path("logout", views.do_logout, name="logout"),
]

from airline_tickets.views import account_view, app_view
from django.urls import path

urlpatterns = [
    path(
        "",
        app_view.top_page,
        name="top",
    ),
    path(
        "login",
        account_view.login_page,
        name="login",
    ),
    path(
        "register_account",
        account_view.register_account_page,
        name="register_account",
    ),
    path(
        "logout",
        account_view.do_logout,
        name="logout",
    ),
    path(
        "search",
        app_view.search_page,
        name="search",
    ),
    path(
        "flight/<str:id>",
        app_view.flight_page,
        name="flight",
    ),
    path(
        "flight/<str:flight_id>/reserve",
        app_view.reserve_flight,
        name="reserve_flight",
    ),
    path(
        "reserved_ticket",
        app_view.reserved_ticket_page,
        name="reserved_ticket",
    ),
]

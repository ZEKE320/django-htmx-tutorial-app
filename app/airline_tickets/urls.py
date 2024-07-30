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
]

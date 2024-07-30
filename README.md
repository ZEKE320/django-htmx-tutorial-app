# Airline Tickets

## Overview

The proposed web application allows the user to book flights. The user can:

1. Select the pair of cities (from, to) from the predefined list.
2. Choose the desired date in the calendar and the type of the ticket (economy / business).
3. From the list of matches returned by the system, choose the available airline.
4. For the flight, choose the seats using the seat map.
5. Type own name and confirm own choice with OK button. (The system should notify that the reservation is completed successfully.)
6. Additionally, the user can register in the system, so that the app will not have to ask the user name during the next booking.
7. (Optional) Keep the list of booked flights for the user currently logged in.

Notes:

1. There are N (≈5) cities in the list and M (≈4) airline companies.
2. There are several (0-5) flights a day between two cities performed by different airlines.
3. We assume that the flights are the same every day.
4. Reservation can be done for the next 14 days.
5. We assume that all planes are the same, and the number of seats is not large (≈20). The first K (≈3) rows are reserved for business class seats, the rest are economy class seats.

Suggestions for the user interface:

1. After the cities, the date and the type of the ticket are chosen, only the airlines that have free seats for this route are shown. If no matches are found, the system notifies the user.
2. The user selects the seats using a seat map (vacant seats should be highlighted).
3. After confirming the booking, the system displays the details (date, flight route, airline name, and the seat number).
4. Registration requires entering a unique combination of login/password.
5. If a certain user is logged in, there is no need to ask for a user name anymore.

## Japanese Overview

提案するウェブアプリケーションは、ユーザーがフライトを予約することを可能にします。ユーザーは以下のことができる：

1. 事前に定義されたリストから都市のペア（出発地、目的地）を選択する。
2. カレンダーから希望の日付と航空券の種類（エコノミー／ビジネス）を選択する。
3. システムから返された一致リストから、利用可能な航空会社を選択します。
4. フライトの座席をシートマップでお選びください。
5. 自分の名前を入力し、OK ボタンで確定します。(予約完了のお知らせが表示されます。）
6. さらに、ユーザーはシステムに登録することができ、次回の予約時にアプリがユーザー名を尋ねる必要がなくなります。
7. (オプション) 現在ログインしているユーザーの予約済みフライトリストを保持します。

注意事項

1. リストには N（≒5）都市、M（≒4）航空会社があります。
2. 異なる航空会社による 2 都市間のフライトが 1 日に数便（0 ～ 5 便）あります。
3. フライトは毎日同じであると仮定する。
4. 予約は 14 日先まで可能である。
5. 飛行機はすべて同じで、座席数は多くない（≒20）と仮定する。最初の K 列（≒3 列）はビジネスクラス席、残りはエコノミークラス席とする。

ユーザー・インターフェースに関する提案

1. 都市、日付、航空券の種類が選択された後、この路線の自由席がある航空会社のみが表示される。該当する航空会社がない場合は、ユーザーに通知されます。
2. シートマップを使って座席を選択します（空席はハイライト表示されます）。
3. 予約を確定すると、詳細（日付、フライトルート、航空会社名、座席番号）が表示されます。
4. 登録にはログインとパスワードの入力が必要です。
5. 特定のユーザーがログインしている場合、ユーザー名を入力する必要はありません。

## Database Structure

```mermaid
erDiagram
  CUSTOMER_ACCOUNT {
    uuid id PK
    string username
    string password
  }

  CUSTOMER {
    uuid id PK
    uuid customer_account_id FK
    string name
  }
  CUSTOMER 1 -- 1 CUSTOMER_ACCOUNT : has_a
  CUSTOMER 1 -- 0+ CUSTOMER_TICKET : has

  CUSTOMER_TICKET {
    uuid id PK
    uuid customer_id FK
    uuid ticket_id FK
    uuid aircraft_seat_id FK
    datetime purchase_date
    boolean canceled
  }
  CUSTOMER_TICKET 0+ -- 1 AIRCRAFT_SEAT: has

  AIRCRAFT_SEAT {
    uuid id PK
    uuid aircraft_model_id FK
    uuid aircraft_seat_type_id FK
    string name
  }
  AIRCRAFT_SEAT 0+ -- 1 AIRCRAFT_SEAT_TYPE: has

  AIRCRAFT_SEAT_TYPE {
    uuid id PK
    string name
  }

  AIRCRAFT_MODEL {
    uuid id PK
    string name
    integer num_economy_seats
    integer num_business_seats
    integer num_first_class_seats
  }
  AIRCRAFT_MODEL 1 -- 0+ AIRCRAFT_SEAT: has
  AIRCRAFT_MODEL 1 -- 0+ AIRCRAFT: has

  AIRCRAFT {
    uuid id PK
    uuid aircraft_model_id FK
    uuid aircraft_company_id FK
    string name
  }

  AIRLINE_COMPANY {
    uuid id PK
    string name
  }
  AIRLINE_COMPANY 0+ -- 0+ AIRCRAFT: has
  AIRLINE_COMPANY 1 -- 0+ AIRLINE_TICKET: has

  FLIGHT {
    uuid id PK
    uuid aircraft_id FK
    uuid airline_id FK
    string name
    date date
    datetime departure_time
    datetime arrival_time
  }
  FLIGHT 0+ -- 1 AIRLINE: has

  FLIGHT_SEAT_TYPE {
    uuid id PK
    string name
  }
  FLIGHT_SEAT_TYPE 1 -- 0+ AIRLINE_TICKET: has

  AIRLINE_TICKET {
    uuid id PK
    uuid flight_id FK
    uuid airline_seat_type_id FK
    uuid airline_company_id FK
    integer price
  }
  AIRLINE_TICKET 0+ -- 1+ FLIGHT : has
  AIRLINE_TICKET 1 -- 0+ CUSTOMER_TICKET: has

  AIRLINE {
    uuid id PK
    uuid flight_route_id FK
  }
  AIRLINE 0+ -- 1 FLIGHT_ROUTE: has

  FLIGHT_ROUTE {
    uuid id PK
    uuid departure_airport FK
    uuid[] waypoints FK
    uuid destination_airport FK
  }
  FLIGHT_ROUTE 0+ -- 1 AIRPORT: departure
  FLIGHT_ROUTE 0+ -- 1 AIRPORT: destination
  FLIGHT_ROUTE 0+ -- 0+ AIRPORT: waypoints

  AIRPORT {
    uuid id PK
    uuid address_id FK
    string name
  }
  AIRPORT 0+ -- 1 ADDRESS: in

  ADDRESS {
    uuid id PK
    uuid country_id FK
    uuid city_id FK
    string address_line_1
    string address_line_2
    string postal_code
  }
  ADDRESS 0+ -- 1 COUNTRY: in
  ADDRESS 0+ -- 1 CITY: in
```

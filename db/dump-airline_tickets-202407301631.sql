--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-30 16:31:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 82040)
-- Name: public; Type: SCHEMA; Schema: -; Owner: airline_tickets
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO airline_tickets;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 82103)
-- Name: airline_tickets_address; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_address (
    id uuid NOT NULL,
    address_line_1 character varying(50) NOT NULL,
    address_line_2 character varying(50) NOT NULL,
    postal_code character varying(50) NOT NULL,
    city_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_address OWNER TO airline_tickets;

--
-- TOC entry 239 (class 1259 OID 82172)
-- Name: airline_tickets_aircraft; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_aircraft (
    id uuid NOT NULL,
    name character varying(50) NOT NULL,
    aircraft_model_id uuid NOT NULL,
    aircraft_company_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_aircraft OWNER TO airline_tickets;

--
-- TOC entry 226 (class 1259 OID 82108)
-- Name: airline_tickets_aircraftmodel; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_aircraftmodel (
    id uuid NOT NULL,
    name character varying(50) NOT NULL,
    num_economy_seats integer NOT NULL,
    num_business_seats integer NOT NULL,
    num_first_class_seats integer NOT NULL,
    CONSTRAINT airline_tickets_aircraftmodel_num_business_seats_check CHECK ((num_business_seats >= 0)),
    CONSTRAINT airline_tickets_aircraftmodel_num_economy_seats_check CHECK ((num_economy_seats >= 0)),
    CONSTRAINT airline_tickets_aircraftmodel_num_first_class_seats_check CHECK ((num_first_class_seats >= 0))
);


ALTER TABLE public.airline_tickets_aircraftmodel OWNER TO airline_tickets;

--
-- TOC entry 238 (class 1259 OID 82167)
-- Name: airline_tickets_aircraftseat; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_aircraftseat (
    id uuid NOT NULL,
    name character varying(10) NOT NULL,
    aircraft_model_id uuid NOT NULL,
    aircraft_seat_type_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_aircraftseat OWNER TO airline_tickets;

--
-- TOC entry 227 (class 1259 OID 82116)
-- Name: airline_tickets_aircraftseattype; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_aircraftseattype (
    id uuid NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.airline_tickets_aircraftseattype OWNER TO airline_tickets;

--
-- TOC entry 228 (class 1259 OID 82121)
-- Name: airline_tickets_airline; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_airline (
    id uuid NOT NULL,
    name character varying(50) NOT NULL,
    flight_route_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_airline OWNER TO airline_tickets;

--
-- TOC entry 229 (class 1259 OID 82126)
-- Name: airline_tickets_airlinecompany; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_airlinecompany (
    id uuid NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.airline_tickets_airlinecompany OWNER TO airline_tickets;

--
-- TOC entry 240 (class 1259 OID 82177)
-- Name: airline_tickets_airlineticket; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_airlineticket (
    id uuid NOT NULL,
    name character varying(50) NOT NULL,
    price integer NOT NULL,
    airline_company_id uuid NOT NULL,
    flight_id uuid NOT NULL,
    aircraft_seat_type_id uuid NOT NULL,
    CONSTRAINT airline_tickets_airlineticket_price_check CHECK ((price >= 0))
);


ALTER TABLE public.airline_tickets_airlineticket OWNER TO airline_tickets;

--
-- TOC entry 230 (class 1259 OID 82131)
-- Name: airline_tickets_airlinetickettype; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_airlinetickettype (
    id uuid NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.airline_tickets_airlinetickettype OWNER TO airline_tickets;

--
-- TOC entry 241 (class 1259 OID 82183)
-- Name: airline_tickets_airport; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_airport (
    id uuid NOT NULL,
    iata_code character varying(3) NOT NULL,
    icao_code character varying(4) NOT NULL,
    name character varying(50) NOT NULL,
    address_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_airport OWNER TO airline_tickets;

--
-- TOC entry 231 (class 1259 OID 82136)
-- Name: airline_tickets_city; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_city (
    id uuid NOT NULL,
    name character varying(50) NOT NULL,
    prefecture_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_city OWNER TO airline_tickets;

--
-- TOC entry 232 (class 1259 OID 82141)
-- Name: airline_tickets_country; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_country (
    id uuid NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.airline_tickets_country OWNER TO airline_tickets;

--
-- TOC entry 242 (class 1259 OID 82197)
-- Name: airline_tickets_customer; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_customer (
    id uuid NOT NULL,
    name character varying(50) NOT NULL,
    customer_account_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_customer OWNER TO airline_tickets;

--
-- TOC entry 233 (class 1259 OID 82146)
-- Name: airline_tickets_customeraccount; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_customeraccount (
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_customeraccount OWNER TO airline_tickets;

--
-- TOC entry 235 (class 1259 OID 82156)
-- Name: airline_tickets_customeraccount_groups; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_customeraccount_groups (
    id bigint NOT NULL,
    customeraccount_id uuid NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.airline_tickets_customeraccount_groups OWNER TO airline_tickets;

--
-- TOC entry 234 (class 1259 OID 82155)
-- Name: airline_tickets_customeraccount_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: airline_tickets
--

ALTER TABLE public.airline_tickets_customeraccount_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.airline_tickets_customeraccount_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 237 (class 1259 OID 82162)
-- Name: airline_tickets_customeraccount_user_permissions; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_customeraccount_user_permissions (
    id bigint NOT NULL,
    customeraccount_id uuid NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.airline_tickets_customeraccount_user_permissions OWNER TO airline_tickets;

--
-- TOC entry 236 (class 1259 OID 82161)
-- Name: airline_tickets_customeraccount_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: airline_tickets
--

ALTER TABLE public.airline_tickets_customeraccount_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.airline_tickets_customeraccount_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 243 (class 1259 OID 82202)
-- Name: airline_tickets_customerticket; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_customerticket (
    id uuid NOT NULL,
    purchase_date timestamp with time zone NOT NULL,
    canceled boolean NOT NULL,
    airline_ticket_id uuid NOT NULL,
    customer_account_id uuid NOT NULL,
    flight_seat_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_customerticket OWNER TO airline_tickets;

--
-- TOC entry 244 (class 1259 OID 82207)
-- Name: airline_tickets_flight; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_flight (
    id uuid NOT NULL,
    name character varying(50) NOT NULL,
    publish_date timestamp with time zone NOT NULL,
    departure_time timestamp with time zone NOT NULL,
    arrival_time timestamp with time zone NOT NULL,
    aircraft_id uuid NOT NULL,
    airline_id uuid NOT NULL,
    airline_company_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_flight OWNER TO airline_tickets;

--
-- TOC entry 245 (class 1259 OID 82217)
-- Name: airline_tickets_flightroute; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_flightroute (
    id uuid NOT NULL,
    arrival_airport_id uuid NOT NULL,
    departure_airport_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_flightroute OWNER TO airline_tickets;

--
-- TOC entry 251 (class 1259 OID 90236)
-- Name: airline_tickets_flightseat; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_flightseat (
    id uuid NOT NULL,
    aircraft_seat_id uuid NOT NULL,
    flight_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_flightseat OWNER TO airline_tickets;

--
-- TOC entry 246 (class 1259 OID 82227)
-- Name: airline_tickets_prefecture; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_prefecture (
    id uuid NOT NULL,
    name character varying(50) NOT NULL,
    country_id uuid NOT NULL
);


ALTER TABLE public.airline_tickets_prefecture OWNER TO airline_tickets;

--
-- TOC entry 247 (class 1259 OID 82237)
-- Name: airline_tickets_waypoint; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.airline_tickets_waypoint (
    id uuid NOT NULL,
    "order" integer NOT NULL,
    airport_id uuid NOT NULL,
    flight_route_id uuid NOT NULL,
    CONSTRAINT airline_tickets_waypoint_order_check CHECK (("order" >= 0))
);


ALTER TABLE public.airline_tickets_waypoint OWNER TO airline_tickets;

--
-- TOC entry 222 (class 1259 OID 82064)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO airline_tickets;

--
-- TOC entry 221 (class 1259 OID 82063)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: airline_tickets
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 82072)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO airline_tickets;

--
-- TOC entry 223 (class 1259 OID 82071)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: airline_tickets
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 82058)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO airline_tickets;

--
-- TOC entry 219 (class 1259 OID 82057)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: airline_tickets
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 249 (class 1259 OID 82387)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id uuid NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO airline_tickets;

--
-- TOC entry 248 (class 1259 OID 82386)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: airline_tickets
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 82050)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO airline_tickets;

--
-- TOC entry 217 (class 1259 OID 82049)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: airline_tickets
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 82042)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO airline_tickets;

--
-- TOC entry 215 (class 1259 OID 82041)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: airline_tickets
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 250 (class 1259 OID 82407)
-- Name: django_session; Type: TABLE; Schema: public; Owner: airline_tickets
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO airline_tickets;

--
-- TOC entry 3633 (class 0 OID 82103)
-- Dependencies: 225
-- Data for Name: airline_tickets_address; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_address VALUES ('94ec7b2d-27ca-4cb4-b14a-59e765637d31', 'Hotarugaike', 'Nishimachi 3 Chome-555', '560-0036', '17082e12-8ea9-4239-8a42-ee25cc805e97');
INSERT INTO public.airline_tickets_address VALUES ('9975aabe-1026-47c0-9bde-4b84635c07bd', 'Hanedakuko', '', '144-0041', 'b2c7b800-0a31-4048-ac91-52c6a73831a6');


--
-- TOC entry 3647 (class 0 OID 82172)
-- Dependencies: 239
-- Data for Name: airline_tickets_aircraft; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_aircraft VALUES ('1e2ea637-0fee-4613-ae50-dc28719074dd', 'JA809A', 'b22024a6-8265-4036-b245-ea6336c3c247', '1efc6741-532a-4531-9f90-000932de5b1a');


--
-- TOC entry 3634 (class 0 OID 82108)
-- Dependencies: 226
-- Data for Name: airline_tickets_aircraftmodel; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_aircraftmodel VALUES ('0b659786-1c12-4522-83dc-8777cd1d17e9', 'Airbus A320', 138, 0, 8);
INSERT INTO public.airline_tickets_aircraftmodel VALUES ('b2a157a2-7252-42f7-accb-f5be6f5a7eb9', 'Boeing 777-300ER', 140, 64, 8);
INSERT INTO public.airline_tickets_aircraftmodel VALUES ('b22024a6-8265-4036-b245-ea6336c3c247', 'Boeing 787-8', 198, 42, 0);


--
-- TOC entry 3646 (class 0 OID 82167)
-- Dependencies: 238
-- Data for Name: airline_tickets_aircraftseat; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_aircraftseat VALUES ('1268d979-4bf7-4f98-b726-366ce08d26ac', 'H4', 'b22024a6-8265-4036-b245-ea6336c3c247', '4adf6cb1-2a74-495f-93b7-cf0de48ad5ba');
INSERT INTO public.airline_tickets_aircraftseat VALUES ('7a5d6fe7-bd1c-4b4d-aaf8-7eaec60308e3', 'D14', 'b22024a6-8265-4036-b245-ea6336c3c247', 'aef62949-e7aa-49b6-93a6-845010719279');
INSERT INTO public.airline_tickets_aircraftseat VALUES ('c9288fa8-0ba7-4bc3-bb3e-d0b6e34b0a50', 'D16', 'b22024a6-8265-4036-b245-ea6336c3c247', 'aef62949-e7aa-49b6-93a6-845010719279');
INSERT INTO public.airline_tickets_aircraftseat VALUES ('5b1e6b95-47ab-4c4d-8af3-1278287d250b', 'E20', 'b22024a6-8265-4036-b245-ea6336c3c247', 'aef62949-e7aa-49b6-93a6-845010719279');
INSERT INTO public.airline_tickets_aircraftseat VALUES ('a6caacda-04e0-4739-b0ad-a938e28a7236', 'B7', 'b22024a6-8265-4036-b245-ea6336c3c247', 'dfbe7f58-7208-4755-b961-d86e498b8dd1');
INSERT INTO public.airline_tickets_aircraftseat VALUES ('d5ea91b6-31c4-465a-946f-98697099edc2', 'D9', 'b22024a6-8265-4036-b245-ea6336c3c247', 'dfbe7f58-7208-4755-b961-d86e498b8dd1');


--
-- TOC entry 3635 (class 0 OID 82116)
-- Dependencies: 227
-- Data for Name: airline_tickets_aircraftseattype; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_aircraftseattype VALUES ('4adf6cb1-2a74-495f-93b7-cf0de48ad5ba', 'First class');
INSERT INTO public.airline_tickets_aircraftseattype VALUES ('dfbe7f58-7208-4755-b961-d86e498b8dd1', 'Business class');
INSERT INTO public.airline_tickets_aircraftseattype VALUES ('aef62949-e7aa-49b6-93a6-845010719279', 'Economy class');


--
-- TOC entry 3636 (class 0 OID 82121)
-- Dependencies: 228
-- Data for Name: airline_tickets_airline; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_airline VALUES ('df6d250c-a3b3-48e8-acb0-fad3d1907cff', 'NH41', '722a78fb-a0ce-4d86-bc32-730037530413');
INSERT INTO public.airline_tickets_airline VALUES ('83a0e703-bf54-4e0e-89e0-0555b77f9742', 'NH14', '4435bb23-3915-43ff-8614-fabf743547d7');


--
-- TOC entry 3637 (class 0 OID 82126)
-- Dependencies: 229
-- Data for Name: airline_tickets_airlinecompany; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_airlinecompany VALUES ('1efc6741-532a-4531-9f90-000932de5b1a', 'All Nippon Airways');


--
-- TOC entry 3648 (class 0 OID 82177)
-- Dependencies: 240
-- Data for Name: airline_tickets_airlineticket; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_airlineticket VALUES ('b58d87a4-5ced-4dde-8dad-989a9429f8be', 'Tokyo - Osaka First', 69140, '1efc6741-532a-4531-9f90-000932de5b1a', 'a9b3f104-d3c3-40d7-8315-2cb58b8033d4', '4adf6cb1-2a74-495f-93b7-cf0de48ad5ba');
INSERT INTO public.airline_tickets_airlineticket VALUES ('6fbf021b-c4f7-4430-b82b-4303c3b50bac', 'Tokyo - Osaka Business', 39140, '1efc6741-532a-4531-9f90-000932de5b1a', 'a9b3f104-d3c3-40d7-8315-2cb58b8033d4', 'dfbe7f58-7208-4755-b961-d86e498b8dd1');
INSERT INTO public.airline_tickets_airlineticket VALUES ('2ce2d8ad-f7d2-4382-ab65-960d06260573', 'Tokyo - Osaka Economy', 29140, '1efc6741-532a-4531-9f90-000932de5b1a', 'a9b3f104-d3c3-40d7-8315-2cb58b8033d4', 'aef62949-e7aa-49b6-93a6-845010719279');
INSERT INTO public.airline_tickets_airlineticket VALUES ('f7558696-3875-4cbb-b9b9-ff2daff3d3d1', 'Osaka - Tokyo (First class)', 50000, '1efc6741-532a-4531-9f90-000932de5b1a', '530ea122-25c3-49fc-97e1-2516cb73d8c1', '4adf6cb1-2a74-495f-93b7-cf0de48ad5ba');
INSERT INTO public.airline_tickets_airlineticket VALUES ('5e473aac-b2e0-4975-a5c1-38716cea51b2', 'Osaka -Tokyo (Business class)', 30000, '1efc6741-532a-4531-9f90-000932de5b1a', '530ea122-25c3-49fc-97e1-2516cb73d8c1', 'dfbe7f58-7208-4755-b961-d86e498b8dd1');
INSERT INTO public.airline_tickets_airlineticket VALUES ('1ecab3fa-55f1-4161-9316-909f7634c71f', 'Osaka -Tokyo (Economy class)', 20000, '1efc6741-532a-4531-9f90-000932de5b1a', '530ea122-25c3-49fc-97e1-2516cb73d8c1', 'aef62949-e7aa-49b6-93a6-845010719279');


--
-- TOC entry 3638 (class 0 OID 82131)
-- Dependencies: 230
-- Data for Name: airline_tickets_airlinetickettype; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_airlinetickettype VALUES ('9f1095d9-f9f8-4d2e-870b-2067e297dee5', 'First class ticket');
INSERT INTO public.airline_tickets_airlinetickettype VALUES ('434ba732-d4ab-489c-b006-8244f6e048db', 'Business class ticket');
INSERT INTO public.airline_tickets_airlinetickettype VALUES ('f64bc013-dab9-4bb5-9750-3ad49b983e1e', 'Economy class ticket');


--
-- TOC entry 3649 (class 0 OID 82183)
-- Dependencies: 241
-- Data for Name: airline_tickets_airport; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_airport VALUES ('61bfb0d2-ab65-415c-9291-9de5b2d0836b', 'HND', 'RJTT', 'Haneda Airport', '9975aabe-1026-47c0-9bde-4b84635c07bd');
INSERT INTO public.airline_tickets_airport VALUES ('7f4488d8-fceb-40c3-84d0-3114f01ca867', 'ITM', 'RJOO', 'Osaka International Airport (Itami Airport)', '94ec7b2d-27ca-4cb4-b14a-59e765637d31');


--
-- TOC entry 3639 (class 0 OID 82136)
-- Dependencies: 231
-- Data for Name: airline_tickets_city; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_city VALUES ('b2c7b800-0a31-4048-ac91-52c6a73831a6', 'Toyonaka', '5cb484bb-5c92-4ec4-927c-17279a9dbab2');
INSERT INTO public.airline_tickets_city VALUES ('17082e12-8ea9-4239-8a42-ee25cc805e97', 'Toyonaka', '739fe426-7cfb-44d9-b22c-6c42e40be4de');


--
-- TOC entry 3640 (class 0 OID 82141)
-- Dependencies: 232
-- Data for Name: airline_tickets_country; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_country VALUES ('9c558096-fba6-4227-a655-2ee290a3c9ef', 'Japan');


--
-- TOC entry 3650 (class 0 OID 82197)
-- Dependencies: 242
-- Data for Name: airline_tickets_customer; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--



--
-- TOC entry 3641 (class 0 OID 82146)
-- Dependencies: 233
-- Data for Name: airline_tickets_customeraccount; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_customeraccount VALUES ('pbkdf2_sha256$720000$TrNpYQn6NYf6eZQJK2xoJq$dRTfvD4GWjFlZfRUmXaEotU3nS2Uu6FYUNXFnYO9Pi8=', '2024-07-30 06:02:18.738291+00', false, 'test_presentation', '', '', '', false, true, '2024-07-30 05:07:52.632089+00', '02399a50-6979-4cfd-8d6e-d6cb1d1a8376');
INSERT INTO public.airline_tickets_customeraccount VALUES ('pbkdf2_sha256$720000$GsgKfglMu9WAc8wi7gfWm9$ZQ4xAHLn9lMVN4A7+5mZRRI6J4Wa+aPBHO3C/B8VtKs=', '2024-07-28 07:24:03.966927+00', false, 'user', '', '', '', false, true, '2024-07-28 07:24:03.633353+00', 'e4aa2677-0470-42a9-82eb-781fa1b74c44');
INSERT INTO public.airline_tickets_customeraccount VALUES ('pbkdf2_sha256$720000$fqDcbs4yfAucWcdkFbxH3f$wfK53X9hXWFxcBwlffH0zFNbu3uNDz/Jaj/+8zbBIk4=', '2024-07-30 06:54:33+00', true, 'admin', '', '', '', true, true, '2024-07-27 14:38:49+00', 'b196b295-cb69-46e2-813a-40a1b206f9dc');
INSERT INTO public.airline_tickets_customeraccount VALUES ('pbkdf2_sha256$720000$0E2RJ2amdkw8ph7zyjhJ2l$20OtNxJktGPCp2LwzqH6BC01rU+TgKRcYOGszEOIaF8=', '2024-07-28 07:28:50.815129+00', false, 'username', '', '', '', false, true, '2024-07-28 07:28:50.450174+00', '875f910a-6957-4c3a-8807-9484f24d2c0e');
INSERT INTO public.airline_tickets_customeraccount VALUES ('pbkdf2_sha256$720000$7I75HuIvpSBo6X1AXqBLIx$zJO2JPvVGApiQzNXAHUI644SCt7BhxRMBQdWlnfS/q0=', '2024-07-30 02:25:36.218247+00', false, 'test100', '', '', '', false, true, '2024-07-30 02:25:35.857499+00', 'b30f61f9-2752-4bc3-9112-997146482e1b');


--
-- TOC entry 3643 (class 0 OID 82156)
-- Dependencies: 235
-- Data for Name: airline_tickets_customeraccount_groups; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--



--
-- TOC entry 3645 (class 0 OID 82162)
-- Dependencies: 237
-- Data for Name: airline_tickets_customeraccount_user_permissions; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--



--
-- TOC entry 3651 (class 0 OID 82202)
-- Dependencies: 243
-- Data for Name: airline_tickets_customerticket; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_customerticket VALUES ('91ac91e6-f1f1-485e-8e3f-3ca94ac21048', '2024-07-30 06:51:51.779237+00', false, '1ecab3fa-55f1-4161-9316-909f7634c71f', 'b196b295-cb69-46e2-813a-40a1b206f9dc', '8259e4f9-9db1-461e-99da-ca7aeea6bd29');
INSERT INTO public.airline_tickets_customerticket VALUES ('783949d8-3354-4156-bc61-92482608182e', '2024-07-30 06:54:39.942047+00', false, '2ce2d8ad-f7d2-4382-ab65-960d06260573', 'b196b295-cb69-46e2-813a-40a1b206f9dc', '7915867d-752d-44c3-a094-91c1ae950ca6');


--
-- TOC entry 3652 (class 0 OID 82207)
-- Dependencies: 244
-- Data for Name: airline_tickets_flight; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_flight VALUES ('a9b3f104-d3c3-40d7-8315-2cb58b8033d4', 'Tokyo (Haneda) to Osaka (Itami) 2024-07-20', '2024-06-08 19:15:00+00', '2024-07-20 19:15:00+00', '2024-07-20 20:35:00+00', '1e2ea637-0fee-4613-ae50-dc28719074dd', 'df6d250c-a3b3-48e8-acb0-fad3d1907cff', '1efc6741-532a-4531-9f90-000932de5b1a');
INSERT INTO public.airline_tickets_flight VALUES ('530ea122-25c3-49fc-97e1-2516cb73d8c1', 'Osaka - Tokyo 2024-08-12', '2024-07-30 00:00:00+00', '2024-08-12 10:41:00+00', '2024-08-12 11:22:00+00', '1e2ea637-0fee-4613-ae50-dc28719074dd', '83a0e703-bf54-4e0e-89e0-0555b77f9742', '1efc6741-532a-4531-9f90-000932de5b1a');


--
-- TOC entry 3653 (class 0 OID 82217)
-- Dependencies: 245
-- Data for Name: airline_tickets_flightroute; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_flightroute VALUES ('722a78fb-a0ce-4d86-bc32-730037530413', '7f4488d8-fceb-40c3-84d0-3114f01ca867', '61bfb0d2-ab65-415c-9291-9de5b2d0836b');
INSERT INTO public.airline_tickets_flightroute VALUES ('4435bb23-3915-43ff-8614-fabf743547d7', '61bfb0d2-ab65-415c-9291-9de5b2d0836b', '7f4488d8-fceb-40c3-84d0-3114f01ca867');


--
-- TOC entry 3659 (class 0 OID 90236)
-- Dependencies: 251
-- Data for Name: airline_tickets_flightseat; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_flightseat VALUES ('775022da-3ade-45b5-afd1-f35284ccccf7', '1268d979-4bf7-4f98-b726-366ce08d26ac', 'a9b3f104-d3c3-40d7-8315-2cb58b8033d4');
INSERT INTO public.airline_tickets_flightseat VALUES ('b206b4d1-cca4-4dae-80b7-c7452d69b3d9', '7a5d6fe7-bd1c-4b4d-aaf8-7eaec60308e3', 'a9b3f104-d3c3-40d7-8315-2cb58b8033d4');
INSERT INTO public.airline_tickets_flightseat VALUES ('7915867d-752d-44c3-a094-91c1ae950ca6', '5b1e6b95-47ab-4c4d-8af3-1278287d250b', 'a9b3f104-d3c3-40d7-8315-2cb58b8033d4');
INSERT INTO public.airline_tickets_flightseat VALUES ('6340d9af-a842-4a31-89dd-597aabba4bb0', 'c9288fa8-0ba7-4bc3-bb3e-d0b6e34b0a50', 'a9b3f104-d3c3-40d7-8315-2cb58b8033d4');
INSERT INTO public.airline_tickets_flightseat VALUES ('8f2aa3be-cd1d-4f5a-b8e8-5f7b718c140a', '5b1e6b95-47ab-4c4d-8af3-1278287d250b', '530ea122-25c3-49fc-97e1-2516cb73d8c1');
INSERT INTO public.airline_tickets_flightseat VALUES ('8259e4f9-9db1-461e-99da-ca7aeea6bd29', 'c9288fa8-0ba7-4bc3-bb3e-d0b6e34b0a50', '530ea122-25c3-49fc-97e1-2516cb73d8c1');
INSERT INTO public.airline_tickets_flightseat VALUES ('68d71a9c-c19b-491b-8947-3e26cbc3a3f8', '1268d979-4bf7-4f98-b726-366ce08d26ac', '530ea122-25c3-49fc-97e1-2516cb73d8c1');
INSERT INTO public.airline_tickets_flightseat VALUES ('31ed1f14-0316-43ec-baf2-f4ead79cd290', 'a6caacda-04e0-4739-b0ad-a938e28a7236', '530ea122-25c3-49fc-97e1-2516cb73d8c1');
INSERT INTO public.airline_tickets_flightseat VALUES ('e4964bcd-11ac-45d1-9f8f-afdd01725f10', 'd5ea91b6-31c4-465a-946f-98697099edc2', 'a9b3f104-d3c3-40d7-8315-2cb58b8033d4');


--
-- TOC entry 3654 (class 0 OID 82227)
-- Dependencies: 246
-- Data for Name: airline_tickets_prefecture; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.airline_tickets_prefecture VALUES ('5cb484bb-5c92-4ec4-927c-17279a9dbab2', 'Tokyo', '9c558096-fba6-4227-a655-2ee290a3c9ef');
INSERT INTO public.airline_tickets_prefecture VALUES ('739fe426-7cfb-44d9-b22c-6c42e40be4de', 'Osaka', '9c558096-fba6-4227-a655-2ee290a3c9ef');


--
-- TOC entry 3655 (class 0 OID 82237)
-- Dependencies: 247
-- Data for Name: airline_tickets_waypoint; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--



--
-- TOC entry 3630 (class 0 OID 82064)
-- Dependencies: 222
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--



--
-- TOC entry 3632 (class 0 OID 82072)
-- Dependencies: 224
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--



--
-- TOC entry 3628 (class 0 OID 82058)
-- Dependencies: 220
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.auth_permission VALUES (1, 'Can add address', 1, 'add_address');
INSERT INTO public.auth_permission VALUES (2, 'Can change address', 1, 'change_address');
INSERT INTO public.auth_permission VALUES (3, 'Can delete address', 1, 'delete_address');
INSERT INTO public.auth_permission VALUES (4, 'Can view address', 1, 'view_address');
INSERT INTO public.auth_permission VALUES (5, 'Can add aircraft model', 2, 'add_aircraftmodel');
INSERT INTO public.auth_permission VALUES (6, 'Can change aircraft model', 2, 'change_aircraftmodel');
INSERT INTO public.auth_permission VALUES (7, 'Can delete aircraft model', 2, 'delete_aircraftmodel');
INSERT INTO public.auth_permission VALUES (8, 'Can view aircraft model', 2, 'view_aircraftmodel');
INSERT INTO public.auth_permission VALUES (9, 'Can add aircraft seat type', 3, 'add_aircraftseattype');
INSERT INTO public.auth_permission VALUES (10, 'Can change aircraft seat type', 3, 'change_aircraftseattype');
INSERT INTO public.auth_permission VALUES (11, 'Can delete aircraft seat type', 3, 'delete_aircraftseattype');
INSERT INTO public.auth_permission VALUES (12, 'Can view aircraft seat type', 3, 'view_aircraftseattype');
INSERT INTO public.auth_permission VALUES (13, 'Can add airline', 4, 'add_airline');
INSERT INTO public.auth_permission VALUES (14, 'Can change airline', 4, 'change_airline');
INSERT INTO public.auth_permission VALUES (15, 'Can delete airline', 4, 'delete_airline');
INSERT INTO public.auth_permission VALUES (16, 'Can view airline', 4, 'view_airline');
INSERT INTO public.auth_permission VALUES (17, 'Can add airline company', 5, 'add_airlinecompany');
INSERT INTO public.auth_permission VALUES (18, 'Can change airline company', 5, 'change_airlinecompany');
INSERT INTO public.auth_permission VALUES (19, 'Can delete airline company', 5, 'delete_airlinecompany');
INSERT INTO public.auth_permission VALUES (20, 'Can view airline company', 5, 'view_airlinecompany');
INSERT INTO public.auth_permission VALUES (21, 'Can add airline ticket type', 6, 'add_airlinetickettype');
INSERT INTO public.auth_permission VALUES (22, 'Can change airline ticket type', 6, 'change_airlinetickettype');
INSERT INTO public.auth_permission VALUES (23, 'Can delete airline ticket type', 6, 'delete_airlinetickettype');
INSERT INTO public.auth_permission VALUES (24, 'Can view airline ticket type', 6, 'view_airlinetickettype');
INSERT INTO public.auth_permission VALUES (25, 'Can add city', 7, 'add_city');
INSERT INTO public.auth_permission VALUES (26, 'Can change city', 7, 'change_city');
INSERT INTO public.auth_permission VALUES (27, 'Can delete city', 7, 'delete_city');
INSERT INTO public.auth_permission VALUES (28, 'Can view city', 7, 'view_city');
INSERT INTO public.auth_permission VALUES (29, 'Can add country', 8, 'add_country');
INSERT INTO public.auth_permission VALUES (30, 'Can change country', 8, 'change_country');
INSERT INTO public.auth_permission VALUES (31, 'Can delete country', 8, 'delete_country');
INSERT INTO public.auth_permission VALUES (32, 'Can view country', 8, 'view_country');
INSERT INTO public.auth_permission VALUES (33, 'Can add user', 9, 'add_customeraccount');
INSERT INTO public.auth_permission VALUES (34, 'Can change user', 9, 'change_customeraccount');
INSERT INTO public.auth_permission VALUES (35, 'Can delete user', 9, 'delete_customeraccount');
INSERT INTO public.auth_permission VALUES (36, 'Can view user', 9, 'view_customeraccount');
INSERT INTO public.auth_permission VALUES (37, 'Can add aircraft seat', 10, 'add_aircraftseat');
INSERT INTO public.auth_permission VALUES (38, 'Can change aircraft seat', 10, 'change_aircraftseat');
INSERT INTO public.auth_permission VALUES (39, 'Can delete aircraft seat', 10, 'delete_aircraftseat');
INSERT INTO public.auth_permission VALUES (40, 'Can view aircraft seat', 10, 'view_aircraftseat');
INSERT INTO public.auth_permission VALUES (41, 'Can add aircraft', 11, 'add_aircraft');
INSERT INTO public.auth_permission VALUES (42, 'Can change aircraft', 11, 'change_aircraft');
INSERT INTO public.auth_permission VALUES (43, 'Can delete aircraft', 11, 'delete_aircraft');
INSERT INTO public.auth_permission VALUES (44, 'Can view aircraft', 11, 'view_aircraft');
INSERT INTO public.auth_permission VALUES (45, 'Can add airline ticket', 12, 'add_airlineticket');
INSERT INTO public.auth_permission VALUES (46, 'Can change airline ticket', 12, 'change_airlineticket');
INSERT INTO public.auth_permission VALUES (47, 'Can delete airline ticket', 12, 'delete_airlineticket');
INSERT INTO public.auth_permission VALUES (48, 'Can view airline ticket', 12, 'view_airlineticket');
INSERT INTO public.auth_permission VALUES (49, 'Can add airport', 13, 'add_airport');
INSERT INTO public.auth_permission VALUES (50, 'Can change airport', 13, 'change_airport');
INSERT INTO public.auth_permission VALUES (51, 'Can delete airport', 13, 'delete_airport');
INSERT INTO public.auth_permission VALUES (52, 'Can view airport', 13, 'view_airport');
INSERT INTO public.auth_permission VALUES (53, 'Can add customer', 14, 'add_customer');
INSERT INTO public.auth_permission VALUES (54, 'Can change customer', 14, 'change_customer');
INSERT INTO public.auth_permission VALUES (55, 'Can delete customer', 14, 'delete_customer');
INSERT INTO public.auth_permission VALUES (56, 'Can view customer', 14, 'view_customer');
INSERT INTO public.auth_permission VALUES (57, 'Can add customer ticket', 15, 'add_customerticket');
INSERT INTO public.auth_permission VALUES (58, 'Can change customer ticket', 15, 'change_customerticket');
INSERT INTO public.auth_permission VALUES (59, 'Can delete customer ticket', 15, 'delete_customerticket');
INSERT INTO public.auth_permission VALUES (60, 'Can view customer ticket', 15, 'view_customerticket');
INSERT INTO public.auth_permission VALUES (61, 'Can add flight', 16, 'add_flight');
INSERT INTO public.auth_permission VALUES (62, 'Can change flight', 16, 'change_flight');
INSERT INTO public.auth_permission VALUES (63, 'Can delete flight', 16, 'delete_flight');
INSERT INTO public.auth_permission VALUES (64, 'Can view flight', 16, 'view_flight');
INSERT INTO public.auth_permission VALUES (65, 'Can add flight route', 17, 'add_flightroute');
INSERT INTO public.auth_permission VALUES (66, 'Can change flight route', 17, 'change_flightroute');
INSERT INTO public.auth_permission VALUES (67, 'Can delete flight route', 17, 'delete_flightroute');
INSERT INTO public.auth_permission VALUES (68, 'Can view flight route', 17, 'view_flightroute');
INSERT INTO public.auth_permission VALUES (69, 'Can add prefecture', 18, 'add_prefecture');
INSERT INTO public.auth_permission VALUES (70, 'Can change prefecture', 18, 'change_prefecture');
INSERT INTO public.auth_permission VALUES (71, 'Can delete prefecture', 18, 'delete_prefecture');
INSERT INTO public.auth_permission VALUES (72, 'Can view prefecture', 18, 'view_prefecture');
INSERT INTO public.auth_permission VALUES (73, 'Can add waypoint', 19, 'add_waypoint');
INSERT INTO public.auth_permission VALUES (74, 'Can change waypoint', 19, 'change_waypoint');
INSERT INTO public.auth_permission VALUES (75, 'Can delete waypoint', 19, 'delete_waypoint');
INSERT INTO public.auth_permission VALUES (76, 'Can view waypoint', 19, 'view_waypoint');
INSERT INTO public.auth_permission VALUES (77, 'Can add log entry', 20, 'add_logentry');
INSERT INTO public.auth_permission VALUES (78, 'Can change log entry', 20, 'change_logentry');
INSERT INTO public.auth_permission VALUES (79, 'Can delete log entry', 20, 'delete_logentry');
INSERT INTO public.auth_permission VALUES (80, 'Can view log entry', 20, 'view_logentry');
INSERT INTO public.auth_permission VALUES (81, 'Can add permission', 21, 'add_permission');
INSERT INTO public.auth_permission VALUES (82, 'Can change permission', 21, 'change_permission');
INSERT INTO public.auth_permission VALUES (83, 'Can delete permission', 21, 'delete_permission');
INSERT INTO public.auth_permission VALUES (84, 'Can view permission', 21, 'view_permission');
INSERT INTO public.auth_permission VALUES (85, 'Can add group', 22, 'add_group');
INSERT INTO public.auth_permission VALUES (86, 'Can change group', 22, 'change_group');
INSERT INTO public.auth_permission VALUES (87, 'Can delete group', 22, 'delete_group');
INSERT INTO public.auth_permission VALUES (88, 'Can view group', 22, 'view_group');
INSERT INTO public.auth_permission VALUES (89, 'Can add content type', 23, 'add_contenttype');
INSERT INTO public.auth_permission VALUES (90, 'Can change content type', 23, 'change_contenttype');
INSERT INTO public.auth_permission VALUES (91, 'Can delete content type', 23, 'delete_contenttype');
INSERT INTO public.auth_permission VALUES (92, 'Can view content type', 23, 'view_contenttype');
INSERT INTO public.auth_permission VALUES (93, 'Can add session', 24, 'add_session');
INSERT INTO public.auth_permission VALUES (94, 'Can change session', 24, 'change_session');
INSERT INTO public.auth_permission VALUES (95, 'Can delete session', 24, 'delete_session');
INSERT INTO public.auth_permission VALUES (96, 'Can view session', 24, 'view_session');
INSERT INTO public.auth_permission VALUES (97, 'Can add flight seat', 25, 'add_flightseat');
INSERT INTO public.auth_permission VALUES (98, 'Can change flight seat', 25, 'change_flightseat');
INSERT INTO public.auth_permission VALUES (99, 'Can delete flight seat', 25, 'delete_flightseat');
INSERT INTO public.auth_permission VALUES (100, 'Can view flight seat', 25, 'view_flightseat');


--
-- TOC entry 3657 (class 0 OID 82387)
-- Dependencies: 249
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--



--
-- TOC entry 3626 (class 0 OID 82050)
-- Dependencies: 218
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.django_content_type VALUES (1, 'airline_tickets', 'address');
INSERT INTO public.django_content_type VALUES (2, 'airline_tickets', 'aircraftmodel');
INSERT INTO public.django_content_type VALUES (3, 'airline_tickets', 'aircraftseattype');
INSERT INTO public.django_content_type VALUES (4, 'airline_tickets', 'airline');
INSERT INTO public.django_content_type VALUES (5, 'airline_tickets', 'airlinecompany');
INSERT INTO public.django_content_type VALUES (6, 'airline_tickets', 'airlinetickettype');
INSERT INTO public.django_content_type VALUES (7, 'airline_tickets', 'city');
INSERT INTO public.django_content_type VALUES (8, 'airline_tickets', 'country');
INSERT INTO public.django_content_type VALUES (9, 'airline_tickets', 'customeraccount');
INSERT INTO public.django_content_type VALUES (10, 'airline_tickets', 'aircraftseat');
INSERT INTO public.django_content_type VALUES (11, 'airline_tickets', 'aircraft');
INSERT INTO public.django_content_type VALUES (12, 'airline_tickets', 'airlineticket');
INSERT INTO public.django_content_type VALUES (13, 'airline_tickets', 'airport');
INSERT INTO public.django_content_type VALUES (14, 'airline_tickets', 'customer');
INSERT INTO public.django_content_type VALUES (15, 'airline_tickets', 'customerticket');
INSERT INTO public.django_content_type VALUES (16, 'airline_tickets', 'flight');
INSERT INTO public.django_content_type VALUES (17, 'airline_tickets', 'flightroute');
INSERT INTO public.django_content_type VALUES (18, 'airline_tickets', 'prefecture');
INSERT INTO public.django_content_type VALUES (19, 'airline_tickets', 'waypoint');
INSERT INTO public.django_content_type VALUES (20, 'admin', 'logentry');
INSERT INTO public.django_content_type VALUES (21, 'auth', 'permission');
INSERT INTO public.django_content_type VALUES (22, 'auth', 'group');
INSERT INTO public.django_content_type VALUES (23, 'contenttypes', 'contenttype');
INSERT INTO public.django_content_type VALUES (24, 'sessions', 'session');
INSERT INTO public.django_content_type VALUES (25, 'airline_tickets', 'flightseat');


--
-- TOC entry 3624 (class 0 OID 82042)
-- Dependencies: 216
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.django_migrations VALUES (1, 'contenttypes', '0001_initial', '2024-07-27 14:37:48.30862+00');
INSERT INTO public.django_migrations VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2024-07-27 14:37:48.319494+00');
INSERT INTO public.django_migrations VALUES (3, 'auth', '0001_initial', '2024-07-27 14:37:48.366954+00');
INSERT INTO public.django_migrations VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2024-07-27 14:37:48.372041+00');
INSERT INTO public.django_migrations VALUES (5, 'auth', '0003_alter_user_email_max_length', '2024-07-27 14:37:48.377655+00');
INSERT INTO public.django_migrations VALUES (6, 'auth', '0004_alter_user_username_opts', '2024-07-27 14:37:48.384062+00');
INSERT INTO public.django_migrations VALUES (7, 'auth', '0005_alter_user_last_login_null', '2024-07-27 14:37:48.390994+00');
INSERT INTO public.django_migrations VALUES (8, 'auth', '0006_require_contenttypes_0002', '2024-07-27 14:37:48.396131+00');
INSERT INTO public.django_migrations VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2024-07-27 14:37:48.403523+00');
INSERT INTO public.django_migrations VALUES (10, 'auth', '0008_alter_user_username_max_length', '2024-07-27 14:37:48.410889+00');
INSERT INTO public.django_migrations VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2024-07-27 14:37:48.41923+00');
INSERT INTO public.django_migrations VALUES (12, 'auth', '0010_alter_group_name_max_length', '2024-07-27 14:37:48.430871+00');
INSERT INTO public.django_migrations VALUES (13, 'auth', '0011_update_proxy_permissions', '2024-07-27 14:37:48.43761+00');
INSERT INTO public.django_migrations VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2024-07-27 14:37:48.448661+00');
INSERT INTO public.django_migrations VALUES (15, 'airline_tickets', '0001_initial', '2024-07-27 14:37:48.718211+00');
INSERT INTO public.django_migrations VALUES (16, 'admin', '0001_initial', '2024-07-27 14:37:48.748366+00');
INSERT INTO public.django_migrations VALUES (17, 'admin', '0002_logentry_remove_auto_add', '2024-07-27 14:37:48.754926+00');
INSERT INTO public.django_migrations VALUES (18, 'admin', '0003_logentry_add_action_flag_choices', '2024-07-27 14:37:48.763141+00');
INSERT INTO public.django_migrations VALUES (19, 'sessions', '0001_initial', '2024-07-27 14:37:48.784155+00');
INSERT INTO public.django_migrations VALUES (20, 'airline_tickets', '0002_remove_customerticket_aircraft_seat_and_more', '2024-07-28 07:35:19.335766+00');
INSERT INTO public.django_migrations VALUES (21, 'airline_tickets', '0003_flight_company', '2024-07-28 13:39:24.075718+00');
INSERT INTO public.django_migrations VALUES (22, 'airline_tickets', '0004_rename_company_flight_airline_company', '2024-07-28 13:51:07.40694+00');
INSERT INTO public.django_migrations VALUES (23, 'airline_tickets', '0005_alter_flight_airline_company', '2024-07-28 13:51:07.436232+00');
INSERT INTO public.django_migrations VALUES (24, 'airline_tickets', '0006_flightseat_reserved', '2024-07-28 14:14:06.741344+00');
INSERT INTO public.django_migrations VALUES (25, 'airline_tickets', '0007_flightseat_unique_flight_aircraft_seat', '2024-07-28 14:24:24.395228+00');
INSERT INTO public.django_migrations VALUES (26, 'airline_tickets', '0008_remove_flightseat_reserved', '2024-07-29 16:16:42.979933+00');
INSERT INTO public.django_migrations VALUES (27, 'airline_tickets', '0009_remove_airlineticket_airline_ticket_type_and_more', '2024-07-30 01:54:35.485756+00');
INSERT INTO public.django_migrations VALUES (28, 'airline_tickets', '0010_alter_airlineticket_aircraft_seat_type', '2024-07-30 01:58:28.352638+00');
INSERT INTO public.django_migrations VALUES (29, 'airline_tickets', '0011_alter_customerticket_canceled', '2024-07-30 03:26:38.026483+00');


--
-- TOC entry 3658 (class 0 OID 82407)
-- Dependencies: 250
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: airline_tickets
--

INSERT INTO public.django_session VALUES ('glacy74kwud1xg7uz01vhmsmnjd6eho5', 'e30:1sXkcx:cocw06yaB0sDEcYsDN8M_NvMjG-yUmFiEaestqEW100', '2024-08-10 16:50:39.090856+00');
INSERT INTO public.django_session VALUES ('il0mquqk0ku0suyh55qllwx1x2r83yqt', 'e30:1sXke5:-cqGqWTUephQmGWOQ1tvMYqIbBybLTJ5bwggVDfPXWk', '2024-08-10 16:51:49.615212+00');
INSERT INTO public.django_session VALUES ('81kzrfswljftd87erj57r87oxzi43hhp', '.eJxVj0FuwyAQRe_CutgDAxi87L5nsJgBglvLrmwsVYpy9zpSNln_957072LNf20690WMorb2O_b9snFc6na00QNAX5b5VlsfA2FRYGRCRmkgDdKjslIzWU8eEJMRH2KKZ6vTeeR9mtPVJBUc6WAlkwvSuKylVxivQFSkwZWQ-F2jyD95fbrpO663reNtbftM3RPpXuvRfW0pL58v9i1Q41EvGz1yhqKJNNtUMjOYwYXgIzpgl9P1ppSBFDqb3JCjtd6AsjYriM5n8fgHxeZYdg:1sYe05:E8CsFJhCSrr-Smb5vxdYEQqpaVzb6PRNOjLg75pLKtA', '2024-08-13 03:58:13.690365+00');
INSERT INTO public.django_session VALUES ('juk8n1gwsw91p0ty3rebko0i9p9t0jlz', '.eJxVzDsOwjAQRdG9uCaWvxObkp41RDPjMQmgRMqnQuwdIqWA-t3zXqrDbe27bZG5G4o6K7IZyOXYMEFuAohrkvXYBIOWnIGaC6vTLyPkh4y7LXccb5PmaVzngfSe6GNd9HUq8rwc7d9Bj0v_1T55FlMdkeNYqjCb0ELOCT0YBinVmlpbsh5igVYwxhSMjVGsQUii3h_i90ER:1sYeYq:hB0Kr9Q3nv98u_evJ5_9RHR4pADv_npVbDI4fWubdyE', '2024-08-13 04:34:08.62188+00');
INSERT INTO public.django_session VALUES ('9qmmb4iplim4fuhazq79ca2gdzdm4lqt', '.eJxVzDsOwjAQRdG9uCaWvxObkp41RDPjMQmgRMqnQuwdIqWA-t3zXqrDbe27bZG5G4o6K7IZyOXYMEFuAohrkvXYBIOWnIGaC6vTLyPkh4y7LXccb5PmaVzngfSe6GNd9HUq8rwc7d9Bj0v_1T55FlMdkeNYqjCb0ELOCT0YBinVmlpbsh5igVYwxhSMjVGsQUii3h_i90ER:1sXlSD:85qE6Y6fWpcLbHc-bCPpDFD3jfldCyTtwFFBpUSFKec', '2024-08-10 17:43:37.349643+00');
INSERT INTO public.django_session VALUES ('434zrcmaoa9rj3uhu7dfwpmvpvjef7rf', '.eJxVzDsOwjAQRdG9uCaWvxObkp41RDPjMQmgRMqnQuwdIqWA-t3zXqrDbe27bZG5G4o6K7IZyOXYMEFuAohrkvXYBIOWnIGaC6vTLyPkh4y7LXccb5PmaVzngfSe6GNd9HUq8rwc7d9Bj0v_1T55FlMdkeNYqjCb0ELOCT0YBinVmlpbsh5igVYwxhSMjVGsQUii3h_i90ER:1sYghH:yHT0Hpx0wEHaotqR7QbJuJmOciA-j0ERs6rWT-oT5uU', '2024-08-13 06:50:59.231359+00');
INSERT INTO public.django_session VALUES ('v1w20zykmfpmsgqxn9mmsc66k5hi6ter', '.eJxVj0FuwyAQRe_CutgDAxi87L5nsJgBglvLrmwsVYpy9zpSNln_957072LNf20690WMorb2O_b9snFc6na00QNAX5b5VlsfA2FRYGRCRmkgDdKjslIzWU8eEJMRH2KKZ6vTeeR9mtPVJBUc6WAlkwvSuKylVxivQFSkwZWQ-F2jyD95fbrpO663reNtbftM3RPpXuvRfW0pL58v9i1Q41EvGz1yhqKJNNtUMjOYwYXgIzpgl9P1ppSBFDqb3JCjtd6AsjYriM5n8fgHxeZYdg:1sYgkj:b8FCHShoPXbEjR_kNlAz3yTPen9vT6rzJ47yB5nEnl0', '2024-08-13 06:54:33.534663+00');
INSERT INTO public.django_session VALUES ('pp6wo430lxopmaui8g8gyy3oarwizb97', 'e30:1sYcgJ:7j9g4lwk0yLnxJdNuzh9oU7H_7MIyrzuEFNs3PJZW-o', '2024-08-13 02:33:43.403532+00');


--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 234
-- Name: airline_tickets_customeraccount_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airline_tickets
--

SELECT pg_catalog.setval('public.airline_tickets_customeraccount_groups_id_seq', 1, false);


--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 236
-- Name: airline_tickets_customeraccount_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airline_tickets
--

SELECT pg_catalog.setval('public.airline_tickets_customeraccount_user_permissions_id_seq', 1, false);


--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 221
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airline_tickets
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 223
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airline_tickets
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 219
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airline_tickets
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 100, true);


--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 248
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airline_tickets
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 78, true);


--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 217
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airline_tickets
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 25, true);


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 215
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: airline_tickets
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 29, true);


--
-- TOC entry 3352 (class 2606 OID 82107)
-- Name: airline_tickets_address airline_tickets_address_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_address
    ADD CONSTRAINT airline_tickets_address_pkey PRIMARY KEY (id);


--
-- TOC entry 3393 (class 2606 OID 82176)
-- Name: airline_tickets_aircraft airline_tickets_aircraft_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_aircraft
    ADD CONSTRAINT airline_tickets_aircraft_pkey PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 82115)
-- Name: airline_tickets_aircraftmodel airline_tickets_aircraftmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_aircraftmodel
    ADD CONSTRAINT airline_tickets_aircraftmodel_pkey PRIMARY KEY (id);


--
-- TOC entry 3389 (class 2606 OID 82171)
-- Name: airline_tickets_aircraftseat airline_tickets_aircraftseat_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_aircraftseat
    ADD CONSTRAINT airline_tickets_aircraftseat_pkey PRIMARY KEY (id);


--
-- TOC entry 3356 (class 2606 OID 82120)
-- Name: airline_tickets_aircraftseattype airline_tickets_aircraftseattype_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_aircraftseattype
    ADD CONSTRAINT airline_tickets_aircraftseattype_pkey PRIMARY KEY (id);


--
-- TOC entry 3359 (class 2606 OID 82125)
-- Name: airline_tickets_airline airline_tickets_airline_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airline
    ADD CONSTRAINT airline_tickets_airline_pkey PRIMARY KEY (id);


--
-- TOC entry 3361 (class 2606 OID 82130)
-- Name: airline_tickets_airlinecompany airline_tickets_airlinecompany_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airlinecompany
    ADD CONSTRAINT airline_tickets_airlinecompany_pkey PRIMARY KEY (id);


--
-- TOC entry 3398 (class 2606 OID 82182)
-- Name: airline_tickets_airlineticket airline_tickets_airlineticket_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airlineticket
    ADD CONSTRAINT airline_tickets_airlineticket_pkey PRIMARY KEY (id);


--
-- TOC entry 3363 (class 2606 OID 82135)
-- Name: airline_tickets_airlinetickettype airline_tickets_airlinetickettype_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airlinetickettype
    ADD CONSTRAINT airline_tickets_airlinetickettype_pkey PRIMARY KEY (id);


--
-- TOC entry 3402 (class 2606 OID 82189)
-- Name: airline_tickets_airport airline_tickets_airport_iata_code_key; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airport
    ADD CONSTRAINT airline_tickets_airport_iata_code_key UNIQUE (iata_code);


--
-- TOC entry 3405 (class 2606 OID 82191)
-- Name: airline_tickets_airport airline_tickets_airport_icao_code_key; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airport
    ADD CONSTRAINT airline_tickets_airport_icao_code_key UNIQUE (icao_code);


--
-- TOC entry 3407 (class 2606 OID 82187)
-- Name: airline_tickets_airport airline_tickets_airport_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airport
    ADD CONSTRAINT airline_tickets_airport_pkey PRIMARY KEY (id);


--
-- TOC entry 3365 (class 2606 OID 82140)
-- Name: airline_tickets_city airline_tickets_city_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_city
    ADD CONSTRAINT airline_tickets_city_pkey PRIMARY KEY (id);


--
-- TOC entry 3368 (class 2606 OID 82145)
-- Name: airline_tickets_country airline_tickets_country_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_country
    ADD CONSTRAINT airline_tickets_country_pkey PRIMARY KEY (id);


--
-- TOC entry 3375 (class 2606 OID 82245)
-- Name: airline_tickets_customeraccount_groups airline_tickets_customer_customeraccount_id_group_7667437e_uniq; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customeraccount_groups
    ADD CONSTRAINT airline_tickets_customer_customeraccount_id_group_7667437e_uniq UNIQUE (customeraccount_id, group_id);


--
-- TOC entry 3381 (class 2606 OID 82259)
-- Name: airline_tickets_customeraccount_user_permissions airline_tickets_customer_customeraccount_id_permi_ad4a0c92_uniq; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customeraccount_user_permissions
    ADD CONSTRAINT airline_tickets_customer_customeraccount_id_permi_ad4a0c92_uniq UNIQUE (customeraccount_id, permission_id);


--
-- TOC entry 3410 (class 2606 OID 82201)
-- Name: airline_tickets_customer airline_tickets_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customer
    ADD CONSTRAINT airline_tickets_customer_pkey PRIMARY KEY (id);


--
-- TOC entry 3379 (class 2606 OID 82160)
-- Name: airline_tickets_customeraccount_groups airline_tickets_customeraccount_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customeraccount_groups
    ADD CONSTRAINT airline_tickets_customeraccount_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2606 OID 82152)
-- Name: airline_tickets_customeraccount airline_tickets_customeraccount_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customeraccount
    ADD CONSTRAINT airline_tickets_customeraccount_pkey PRIMARY KEY (id);


--
-- TOC entry 3385 (class 2606 OID 82166)
-- Name: airline_tickets_customeraccount_user_permissions airline_tickets_customeraccount_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customeraccount_user_permissions
    ADD CONSTRAINT airline_tickets_customeraccount_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3373 (class 2606 OID 82154)
-- Name: airline_tickets_customeraccount airline_tickets_customeraccount_username_key; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customeraccount
    ADD CONSTRAINT airline_tickets_customeraccount_username_key UNIQUE (username);


--
-- TOC entry 3415 (class 2606 OID 82206)
-- Name: airline_tickets_customerticket airline_tickets_customerticket_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customerticket
    ADD CONSTRAINT airline_tickets_customerticket_pkey PRIMARY KEY (id);


--
-- TOC entry 3420 (class 2606 OID 82211)
-- Name: airline_tickets_flight airline_tickets_flight_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flight
    ADD CONSTRAINT airline_tickets_flight_pkey PRIMARY KEY (id);


--
-- TOC entry 3424 (class 2606 OID 82221)
-- Name: airline_tickets_flightroute airline_tickets_flightroute_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flightroute
    ADD CONSTRAINT airline_tickets_flightroute_pkey PRIMARY KEY (id);


--
-- TOC entry 3443 (class 2606 OID 90240)
-- Name: airline_tickets_flightseat airline_tickets_flightseat_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flightseat
    ADD CONSTRAINT airline_tickets_flightseat_pkey PRIMARY KEY (id);


--
-- TOC entry 3427 (class 2606 OID 82231)
-- Name: airline_tickets_prefecture airline_tickets_prefecture_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_prefecture
    ADD CONSTRAINT airline_tickets_prefecture_pkey PRIMARY KEY (id);


--
-- TOC entry 3431 (class 2606 OID 82242)
-- Name: airline_tickets_waypoint airline_tickets_waypoint_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_waypoint
    ADD CONSTRAINT airline_tickets_waypoint_pkey PRIMARY KEY (id);


--
-- TOC entry 3341 (class 2606 OID 82101)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3346 (class 2606 OID 82087)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3349 (class 2606 OID 82076)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3343 (class 2606 OID 82068)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3336 (class 2606 OID 82078)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3338 (class 2606 OID 82062)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3434 (class 2606 OID 82394)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 82056)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3333 (class 2606 OID 82054)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3329 (class 2606 OID 82048)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3438 (class 2606 OID 82413)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 3445 (class 2606 OID 90283)
-- Name: airline_tickets_flightseat unique_flight_aircraft_seat; Type: CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flightseat
    ADD CONSTRAINT unique_flight_aircraft_seat UNIQUE (flight_id, aircraft_seat_id);


--
-- TOC entry 3350 (class 1259 OID 82316)
-- Name: airline_tickets_address_city_id_a51f762c; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_address_city_id_a51f762c ON public.airline_tickets_address USING btree (city_id);


--
-- TOC entry 3390 (class 1259 OID 82295)
-- Name: airline_tickets_aircraft_aircraft_company_id_bee93e07; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_aircraft_aircraft_company_id_bee93e07 ON public.airline_tickets_aircraft USING btree (aircraft_company_id);


--
-- TOC entry 3391 (class 1259 OID 82294)
-- Name: airline_tickets_aircraft_aircraft_model_id_5df60ffb; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_aircraft_aircraft_model_id_5df60ffb ON public.airline_tickets_aircraft USING btree (aircraft_model_id);


--
-- TOC entry 3386 (class 1259 OID 82282)
-- Name: airline_tickets_aircraftseat_aircraft_model_id_e17cdfd1; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_aircraftseat_aircraft_model_id_e17cdfd1 ON public.airline_tickets_aircraftseat USING btree (aircraft_model_id);


--
-- TOC entry 3387 (class 1259 OID 82283)
-- Name: airline_tickets_aircraftseat_aircraft_seat_type_id_07f84657; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_aircraftseat_aircraft_seat_type_id_07f84657 ON public.airline_tickets_aircraftseat USING btree (aircraft_seat_type_id);


--
-- TOC entry 3357 (class 1259 OID 82366)
-- Name: airline_tickets_airline_flight_route_id_fc9841dd; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_airline_flight_route_id_fc9841dd ON public.airline_tickets_airline USING btree (flight_route_id);


--
-- TOC entry 3394 (class 1259 OID 98428)
-- Name: airline_tickets_airlineticket_aircraft_seat_type_id_b3710ee5; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_airlineticket_aircraft_seat_type_id_b3710ee5 ON public.airline_tickets_airlineticket USING btree (aircraft_seat_type_id);


--
-- TOC entry 3395 (class 1259 OID 82306)
-- Name: airline_tickets_airlineticket_airline_company_id_d79e3323; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_airlineticket_airline_company_id_d79e3323 ON public.airline_tickets_airlineticket USING btree (airline_company_id);


--
-- TOC entry 3396 (class 1259 OID 82353)
-- Name: airline_tickets_airlineticket_flight_id_17e18934; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_airlineticket_flight_id_17e18934 ON public.airline_tickets_airlineticket USING btree (flight_id);


--
-- TOC entry 3399 (class 1259 OID 82315)
-- Name: airline_tickets_airport_address_id_f56a0eff; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_airport_address_id_f56a0eff ON public.airline_tickets_airport USING btree (address_id);


--
-- TOC entry 3400 (class 1259 OID 82313)
-- Name: airline_tickets_airport_iata_code_df792967_like; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_airport_iata_code_df792967_like ON public.airline_tickets_airport USING btree (iata_code varchar_pattern_ops);


--
-- TOC entry 3403 (class 1259 OID 82314)
-- Name: airline_tickets_airport_icao_code_75b0ff63_like; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_airport_icao_code_75b0ff63_like ON public.airline_tickets_airport USING btree (icao_code varchar_pattern_ops);


--
-- TOC entry 3366 (class 1259 OID 82373)
-- Name: airline_tickets_city_prefecture_id_25b7ea37; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_city_prefecture_id_25b7ea37 ON public.airline_tickets_city USING btree (prefecture_id);


--
-- TOC entry 3408 (class 1259 OID 82322)
-- Name: airline_tickets_customer_customer_account_id_f5e88d12; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_customer_customer_account_id_f5e88d12 ON public.airline_tickets_customer USING btree (customer_account_id);


--
-- TOC entry 3382 (class 1259 OID 82270)
-- Name: airline_tickets_customerac_customeraccount_id_00b9d49d; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_customerac_customeraccount_id_00b9d49d ON public.airline_tickets_customeraccount_user_permissions USING btree (customeraccount_id);


--
-- TOC entry 3376 (class 1259 OID 82256)
-- Name: airline_tickets_customerac_customeraccount_id_34a52ede; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_customerac_customeraccount_id_34a52ede ON public.airline_tickets_customeraccount_groups USING btree (customeraccount_id);


--
-- TOC entry 3383 (class 1259 OID 82271)
-- Name: airline_tickets_customerac_permission_id_a14b871a; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_customerac_permission_id_a14b871a ON public.airline_tickets_customeraccount_user_permissions USING btree (permission_id);


--
-- TOC entry 3377 (class 1259 OID 82257)
-- Name: airline_tickets_customeraccount_groups_group_id_5a25ae32; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_customeraccount_groups_group_id_5a25ae32 ON public.airline_tickets_customeraccount_groups USING btree (group_id);


--
-- TOC entry 3371 (class 1259 OID 82243)
-- Name: airline_tickets_customeraccount_username_39320e3f_like; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_customeraccount_username_39320e3f_like ON public.airline_tickets_customeraccount USING btree (username varchar_pattern_ops);


--
-- TOC entry 3411 (class 1259 OID 82339)
-- Name: airline_tickets_customerticket_airline_ticket_id_9e970355; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_customerticket_airline_ticket_id_9e970355 ON public.airline_tickets_customerticket USING btree (airline_ticket_id);


--
-- TOC entry 3412 (class 1259 OID 90246)
-- Name: airline_tickets_customerticket_customer_account_id_8a53f417; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_customerticket_customer_account_id_8a53f417 ON public.airline_tickets_customerticket USING btree (customer_account_id);


--
-- TOC entry 3413 (class 1259 OID 90259)
-- Name: airline_tickets_customerticket_flight_seat_id_79ae77ee; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_customerticket_flight_seat_id_79ae77ee ON public.airline_tickets_customerticket USING btree (flight_seat_id);


--
-- TOC entry 3416 (class 1259 OID 82351)
-- Name: airline_tickets_flight_aircraft_id_92db2ffa; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_flight_aircraft_id_92db2ffa ON public.airline_tickets_flight USING btree (aircraft_id);


--
-- TOC entry 3417 (class 1259 OID 82352)
-- Name: airline_tickets_flight_airline_id_82a58a3f; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_flight_airline_id_82a58a3f ON public.airline_tickets_flight USING btree (airline_id);


--
-- TOC entry 3418 (class 1259 OID 90270)
-- Name: airline_tickets_flight_company_id_c3b17d1a; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_flight_company_id_c3b17d1a ON public.airline_tickets_flight USING btree (airline_company_id);


--
-- TOC entry 3421 (class 1259 OID 82364)
-- Name: airline_tickets_flightroute_arrival_airport_id_fc238084; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_flightroute_arrival_airport_id_fc238084 ON public.airline_tickets_flightroute USING btree (arrival_airport_id);


--
-- TOC entry 3422 (class 1259 OID 82365)
-- Name: airline_tickets_flightroute_departure_airport_id_4722766c; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_flightroute_departure_airport_id_4722766c ON public.airline_tickets_flightroute USING btree (departure_airport_id);


--
-- TOC entry 3440 (class 1259 OID 90257)
-- Name: airline_tickets_flightseat_aircraft_seat_id_8c1683b1; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_flightseat_aircraft_seat_id_8c1683b1 ON public.airline_tickets_flightseat USING btree (aircraft_seat_id);


--
-- TOC entry 3441 (class 1259 OID 90258)
-- Name: airline_tickets_flightseat_flight_id_54f1bb18; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_flightseat_flight_id_54f1bb18 ON public.airline_tickets_flightseat USING btree (flight_id);


--
-- TOC entry 3425 (class 1259 OID 82372)
-- Name: airline_tickets_prefecture_country_id_c935315d; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_prefecture_country_id_c935315d ON public.airline_tickets_prefecture USING btree (country_id);


--
-- TOC entry 3428 (class 1259 OID 82384)
-- Name: airline_tickets_waypoint_airport_id_118229c8; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_waypoint_airport_id_118229c8 ON public.airline_tickets_waypoint USING btree (airport_id);


--
-- TOC entry 3429 (class 1259 OID 82385)
-- Name: airline_tickets_waypoint_flight_route_id_d3f7d7d4; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX airline_tickets_waypoint_flight_route_id_d3f7d7d4 ON public.airline_tickets_waypoint USING btree (flight_route_id);


--
-- TOC entry 3339 (class 1259 OID 82102)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3344 (class 1259 OID 82098)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3347 (class 1259 OID 82099)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3334 (class 1259 OID 82084)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3432 (class 1259 OID 82405)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3435 (class 1259 OID 82406)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3436 (class 1259 OID 82415)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 3439 (class 1259 OID 82414)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: airline_tickets
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 3449 (class 2606 OID 82192)
-- Name: airline_tickets_address airline_tickets_addr_city_id_a51f762c_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_address
    ADD CONSTRAINT airline_tickets_addr_city_id_a51f762c_fk_airline_t FOREIGN KEY (city_id) REFERENCES public.airline_tickets_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3458 (class 2606 OID 82289)
-- Name: airline_tickets_aircraft airline_tickets_airc_aircraft_company_id_bee93e07_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_aircraft
    ADD CONSTRAINT airline_tickets_airc_aircraft_company_id_bee93e07_fk_airline_t FOREIGN KEY (aircraft_company_id) REFERENCES public.airline_tickets_airlinecompany(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3459 (class 2606 OID 82284)
-- Name: airline_tickets_aircraft airline_tickets_airc_aircraft_model_id_5df60ffb_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_aircraft
    ADD CONSTRAINT airline_tickets_airc_aircraft_model_id_5df60ffb_fk_airline_t FOREIGN KEY (aircraft_model_id) REFERENCES public.airline_tickets_aircraftmodel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3456 (class 2606 OID 82272)
-- Name: airline_tickets_aircraftseat airline_tickets_airc_aircraft_model_id_e17cdfd1_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_aircraftseat
    ADD CONSTRAINT airline_tickets_airc_aircraft_model_id_e17cdfd1_fk_airline_t FOREIGN KEY (aircraft_model_id) REFERENCES public.airline_tickets_aircraftmodel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3457 (class 2606 OID 82277)
-- Name: airline_tickets_aircraftseat airline_tickets_airc_aircraft_seat_type_i_07f84657_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_aircraftseat
    ADD CONSTRAINT airline_tickets_airc_aircraft_seat_type_i_07f84657_fk_airline_t FOREIGN KEY (aircraft_seat_type_id) REFERENCES public.airline_tickets_aircraftseattype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3460 (class 2606 OID 98429)
-- Name: airline_tickets_airlineticket airline_tickets_airl_aircraft_seat_type_i_b3710ee5_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airlineticket
    ADD CONSTRAINT airline_tickets_airl_aircraft_seat_type_i_b3710ee5_fk_airline_t FOREIGN KEY (aircraft_seat_type_id) REFERENCES public.airline_tickets_aircraftseattype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3461 (class 2606 OID 82296)
-- Name: airline_tickets_airlineticket airline_tickets_airl_airline_company_id_d79e3323_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airlineticket
    ADD CONSTRAINT airline_tickets_airl_airline_company_id_d79e3323_fk_airline_t FOREIGN KEY (airline_company_id) REFERENCES public.airline_tickets_airlinecompany(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3462 (class 2606 OID 82212)
-- Name: airline_tickets_airlineticket airline_tickets_airl_flight_id_17e18934_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airlineticket
    ADD CONSTRAINT airline_tickets_airl_flight_id_17e18934_fk_airline_t FOREIGN KEY (flight_id) REFERENCES public.airline_tickets_flight(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3450 (class 2606 OID 82222)
-- Name: airline_tickets_airline airline_tickets_airl_flight_route_id_fc9841dd_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airline
    ADD CONSTRAINT airline_tickets_airl_flight_route_id_fc9841dd_fk_airline_t FOREIGN KEY (flight_route_id) REFERENCES public.airline_tickets_flightroute(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3463 (class 2606 OID 82308)
-- Name: airline_tickets_airport airline_tickets_airp_address_id_f56a0eff_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_airport
    ADD CONSTRAINT airline_tickets_airp_address_id_f56a0eff_fk_airline_t FOREIGN KEY (address_id) REFERENCES public.airline_tickets_address(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3451 (class 2606 OID 82232)
-- Name: airline_tickets_city airline_tickets_city_prefecture_id_25b7ea37_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_city
    ADD CONSTRAINT airline_tickets_city_prefecture_id_25b7ea37_fk_airline_t FOREIGN KEY (prefecture_id) REFERENCES public.airline_tickets_prefecture(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3465 (class 2606 OID 82328)
-- Name: airline_tickets_customerticket airline_tickets_cust_airline_ticket_id_9e970355_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customerticket
    ADD CONSTRAINT airline_tickets_cust_airline_ticket_id_9e970355_fk_airline_t FOREIGN KEY (airline_ticket_id) REFERENCES public.airline_tickets_airlineticket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3466 (class 2606 OID 90231)
-- Name: airline_tickets_customerticket airline_tickets_cust_customer_account_id_8a53f417_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customerticket
    ADD CONSTRAINT airline_tickets_cust_customer_account_id_8a53f417_fk_airline_t FOREIGN KEY (customer_account_id) REFERENCES public.airline_tickets_customeraccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3464 (class 2606 OID 82317)
-- Name: airline_tickets_customer airline_tickets_cust_customer_account_id_f5e88d12_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customer
    ADD CONSTRAINT airline_tickets_cust_customer_account_id_f5e88d12_fk_airline_t FOREIGN KEY (customer_account_id) REFERENCES public.airline_tickets_customeraccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3454 (class 2606 OID 82260)
-- Name: airline_tickets_customeraccount_user_permissions airline_tickets_cust_customeraccount_id_00b9d49d_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customeraccount_user_permissions
    ADD CONSTRAINT airline_tickets_cust_customeraccount_id_00b9d49d_fk_airline_t FOREIGN KEY (customeraccount_id) REFERENCES public.airline_tickets_customeraccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3452 (class 2606 OID 82246)
-- Name: airline_tickets_customeraccount_groups airline_tickets_cust_customeraccount_id_34a52ede_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customeraccount_groups
    ADD CONSTRAINT airline_tickets_cust_customeraccount_id_34a52ede_fk_airline_t FOREIGN KEY (customeraccount_id) REFERENCES public.airline_tickets_customeraccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3467 (class 2606 OID 90241)
-- Name: airline_tickets_customerticket airline_tickets_cust_flight_seat_id_79ae77ee_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customerticket
    ADD CONSTRAINT airline_tickets_cust_flight_seat_id_79ae77ee_fk_airline_t FOREIGN KEY (flight_seat_id) REFERENCES public.airline_tickets_flightseat(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3453 (class 2606 OID 82251)
-- Name: airline_tickets_customeraccount_groups airline_tickets_cust_group_id_5a25ae32_fk_auth_grou; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customeraccount_groups
    ADD CONSTRAINT airline_tickets_cust_group_id_5a25ae32_fk_auth_grou FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3455 (class 2606 OID 82265)
-- Name: airline_tickets_customeraccount_user_permissions airline_tickets_cust_permission_id_a14b871a_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_customeraccount_user_permissions
    ADD CONSTRAINT airline_tickets_cust_permission_id_a14b871a_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3468 (class 2606 OID 82341)
-- Name: airline_tickets_flight airline_tickets_flig_aircraft_id_92db2ffa_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flight
    ADD CONSTRAINT airline_tickets_flig_aircraft_id_92db2ffa_fk_airline_t FOREIGN KEY (aircraft_id) REFERENCES public.airline_tickets_aircraft(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3478 (class 2606 OID 90247)
-- Name: airline_tickets_flightseat airline_tickets_flig_aircraft_seat_id_8c1683b1_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flightseat
    ADD CONSTRAINT airline_tickets_flig_aircraft_seat_id_8c1683b1_fk_airline_t FOREIGN KEY (aircraft_seat_id) REFERENCES public.airline_tickets_aircraftseat(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3469 (class 2606 OID 90276)
-- Name: airline_tickets_flight airline_tickets_flig_airline_company_id_07569845_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flight
    ADD CONSTRAINT airline_tickets_flig_airline_company_id_07569845_fk_airline_t FOREIGN KEY (airline_company_id) REFERENCES public.airline_tickets_airlinecompany(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3470 (class 2606 OID 82346)
-- Name: airline_tickets_flight airline_tickets_flig_airline_id_82a58a3f_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flight
    ADD CONSTRAINT airline_tickets_flig_airline_id_82a58a3f_fk_airline_t FOREIGN KEY (airline_id) REFERENCES public.airline_tickets_airline(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3471 (class 2606 OID 82354)
-- Name: airline_tickets_flightroute airline_tickets_flig_arrival_airport_id_fc238084_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flightroute
    ADD CONSTRAINT airline_tickets_flig_arrival_airport_id_fc238084_fk_airline_t FOREIGN KEY (arrival_airport_id) REFERENCES public.airline_tickets_airport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3472 (class 2606 OID 82359)
-- Name: airline_tickets_flightroute airline_tickets_flig_departure_airport_id_4722766c_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flightroute
    ADD CONSTRAINT airline_tickets_flig_departure_airport_id_4722766c_fk_airline_t FOREIGN KEY (departure_airport_id) REFERENCES public.airline_tickets_airport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3479 (class 2606 OID 90252)
-- Name: airline_tickets_flightseat airline_tickets_flig_flight_id_54f1bb18_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_flightseat
    ADD CONSTRAINT airline_tickets_flig_flight_id_54f1bb18_fk_airline_t FOREIGN KEY (flight_id) REFERENCES public.airline_tickets_flight(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3473 (class 2606 OID 82367)
-- Name: airline_tickets_prefecture airline_tickets_pref_country_id_c935315d_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_prefecture
    ADD CONSTRAINT airline_tickets_pref_country_id_c935315d_fk_airline_t FOREIGN KEY (country_id) REFERENCES public.airline_tickets_country(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3474 (class 2606 OID 82374)
-- Name: airline_tickets_waypoint airline_tickets_wayp_airport_id_118229c8_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_waypoint
    ADD CONSTRAINT airline_tickets_wayp_airport_id_118229c8_fk_airline_t FOREIGN KEY (airport_id) REFERENCES public.airline_tickets_airport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3475 (class 2606 OID 82379)
-- Name: airline_tickets_waypoint airline_tickets_wayp_flight_route_id_d3f7d7d4_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.airline_tickets_waypoint
    ADD CONSTRAINT airline_tickets_wayp_flight_route_id_d3f7d7d4_fk_airline_t FOREIGN KEY (flight_route_id) REFERENCES public.airline_tickets_flightroute(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3447 (class 2606 OID 82093)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3448 (class 2606 OID 82088)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3446 (class 2606 OID 82079)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3476 (class 2606 OID 82395)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3477 (class 2606 OID 82400)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_airline_t; Type: FK CONSTRAINT; Schema: public; Owner: airline_tickets
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_airline_t FOREIGN KEY (user_id) REFERENCES public.airline_tickets_customeraccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: airline_tickets
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2024-07-30 16:31:16

--
-- PostgreSQL database dump complete
--

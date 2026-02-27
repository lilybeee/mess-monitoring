--
-- PostgreSQL database dump
--

\restrict n8yoUacheTTObVzkxNWHRggvVCxiLHPiNcA63uu6x5MOIAjhE57ZZv3kLfPDhED

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-27 17:08:27

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 17393)
-- Name: day_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.day_type (
    day_type_id integer NOT NULL,
    day_type_name character varying(20) NOT NULL
);


ALTER TABLE public.day_type OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17392)
-- Name: day_type_day_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.day_type_day_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.day_type_day_type_id_seq OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 225
-- Name: day_type_day_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.day_type_day_type_id_seq OWNED BY public.day_type.day_type_id;


--
-- TOC entry 232 (class 1259 OID 17446)
-- Name: live_count; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.live_count (
    live_id integer NOT NULL,
    menu_id integer NOT NULL,
    current_total integer NOT NULL,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT live_count_current_total_check CHECK ((current_total >= 0))
);


ALTER TABLE public.live_count OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17445)
-- Name: live_count_live_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.live_count_live_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.live_count_live_id_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 231
-- Name: live_count_live_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.live_count_live_id_seq OWNED BY public.live_count.live_id;


--
-- TOC entry 224 (class 1259 OID 17382)
-- Name: meal_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meal_type (
    meal_id integer NOT NULL,
    meal_name character varying(20) NOT NULL
);


ALTER TABLE public.meal_type OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17381)
-- Name: meal_type_meal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meal_type_meal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.meal_type_meal_id_seq OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 223
-- Name: meal_type_meal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meal_type_meal_id_seq OWNED BY public.meal_type.meal_id;


--
-- TOC entry 228 (class 1259 OID 17405)
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    menu_id integer NOT NULL,
    week_no integer NOT NULL,
    day_of_week integer NOT NULL,
    meal_id integer NOT NULL,
    description text NOT NULL,
    CONSTRAINT menu_day_of_week_check CHECK (((day_of_week >= 1) AND (day_of_week <= 7))),
    CONSTRAINT menu_week_no_check CHECK ((week_no = ANY (ARRAY[1, 2])))
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17404)
-- Name: menu_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_menu_id_seq OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 227
-- Name: menu_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_menu_id_seq OWNED BY public.menu.menu_id;


--
-- TOC entry 230 (class 1259 OID 17428)
-- Name: people_count; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.people_count (
    count_id integer NOT NULL,
    menu_id integer NOT NULL,
    count_date date NOT NULL,
    count_time time without time zone NOT NULL,
    people_total integer NOT NULL,
    CONSTRAINT people_count_people_total_check CHECK ((people_total >= 0))
);


ALTER TABLE public.people_count OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17427)
-- Name: people_count_count_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.people_count_count_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.people_count_count_id_seq OWNER TO postgres;

--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 229
-- Name: people_count_count_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.people_count_count_id_seq OWNED BY public.people_count.count_id;


--
-- TOC entry 220 (class 1259 OID 17350)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    role_id integer NOT NULL,
    role_name character varying(20) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17349)
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_role_id_seq OWNER TO postgres;

--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 219
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;


--
-- TOC entry 222 (class 1259 OID 17361)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    password_hash text NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17360)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4889 (class 2604 OID 17396)
-- Name: day_type day_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.day_type ALTER COLUMN day_type_id SET DEFAULT nextval('public.day_type_day_type_id_seq'::regclass);


--
-- TOC entry 4892 (class 2604 OID 17449)
-- Name: live_count live_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.live_count ALTER COLUMN live_id SET DEFAULT nextval('public.live_count_live_id_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 17385)
-- Name: meal_type meal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meal_type ALTER COLUMN meal_id SET DEFAULT nextval('public.meal_type_meal_id_seq'::regclass);


--
-- TOC entry 4890 (class 2604 OID 17408)
-- Name: menu menu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu ALTER COLUMN menu_id SET DEFAULT nextval('public.menu_menu_id_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 17431)
-- Name: people_count count_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people_count ALTER COLUMN count_id SET DEFAULT nextval('public.people_count_count_id_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 17353)
-- Name: role role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);


--
-- TOC entry 4887 (class 2604 OID 17364)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 5084 (class 0 OID 17393)
-- Dependencies: 226
-- Data for Name: day_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.day_type (day_type_id, day_type_name) FROM stdin;
1	Normal
2	Exam
3	Feast
4	Holiday
5	Festival
\.


--
-- TOC entry 5090 (class 0 OID 17446)
-- Dependencies: 232
-- Data for Name: live_count; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.live_count (live_id, menu_id, current_total, last_updated) FROM stdin;
\.


--
-- TOC entry 5082 (class 0 OID 17382)
-- Dependencies: 224
-- Data for Name: meal_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meal_type (meal_id, meal_name) FROM stdin;
1	Breakfast
2	Lunch
3	Snacks
4	Dinner
\.


--
-- TOC entry 5086 (class 0 OID 17405)
-- Dependencies: 228
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (menu_id, week_no, day_of_week, meal_id, description) FROM stdin;
1	1	1	1	Aloo Paratha, Ketchup, Curd, Mint & Coriander Chutney
2	1	1	2	Phulka, White Rice, Kerala Rice, Chana Masala, Arhar Dal, Sambar, Chutney, Curd
3	1	1	3	Onion Kachori, Tomato Ketchup, Fried Chilly
4	1	1	4	Fried Rice, Phulka, Dal Tadka, Gobhi Manchurian
5	1	2	1	Masala Dosa, Tomato Chutney, Sambar
6	1	2	2	Puri, Aloo Palak, Sambar, Ridge Gourd Dry, White Rice, Buttermilk, Seasonal Fruit
7	1	2	3	Aloo Bonda, Tomato Ketchup
8	1	2	4	Phulka, Chole Masala, Jeera Rice, Dal, Raita, Icecream
9	1	3	1	Dal Kichdi, Coconut Chutney, Dahi Boondhi, Peanut Butter
10	1	3	2	Chapathi, White Rice, Greenpeas Masala, Rasam, Chana Dal Fry
11	1	3	3	Green Matar Chat
12	1	3	4	Paneer Dish / Chicken Masala, White Rice, Moong Dal, Paratha, Laddu
13	1	4	1	Puri, Chana Masala
14	1	4	2	Chapathi, White Rice, Mix Dal, Malai Kofta, Bottle Gourd Dry, Curd
15	1	4	3	Tikki Chat
16	1	4	4	Special Dal, Sambar, Masala Dosa (Unlimited), White Rice, Chutneys, Payasam, Rasam
17	1	5	1	Fried Idly, Vada, Sambar, Coconut Chutney
18	1	5	2	Phulka, White Rice, Kadai Veg, Sambar, Potato Cabbage Dry, Buttermilk
19	1	5	3	Pungulu with Coconut Chutney
20	1	5	4	Chicken Gravy / Paneer Butter Masala, Pulao, Mix Dal, Chapathi, Badhusha
21	1	7	1	Onion Rava Dosa, Tomato Chutney, Sambar
22	1	7	2	Chicken Dum Biryani / Chilli Paneer, Dum Biryani, Shorba Masala, Onion Raita
23	1	7	3	Vada Pav, Fried Green Chilly, Coriander Chutney
24	1	7	4	Arhar Dal Tadka, Aloo Fry, Kadhi Pakoda, Rice, Chapati, Gulab Jamun
25	1	6	1	Gobi Mix Veg Paratha, Ketchup, Coriander Chutney
26	1	6	2	Chapathi, White Rice, Rajma Masala, Green Vegetable Dry, Ginger Dal, Gongura Chutney
27	1	6	3	Samosa, Tomato Ketchup, Cold Coffee
28	1	6	4	Phulka, Green Peas Masala, White Rice, Banana Poriyal, Rasam, Buttermilk
29	2	1	1	Aloo Paratha, Ketchup, Curd, Seasonal Fruit, Mint & Coriander Chutney
30	2	1	2	Phulka, Ghee Rice, Aloo Chana Masala, Soya Chilly (Semi-Dry), Rasam, Chutney, Buttermilk
31	2	1	3	Macroni
32	2	1	4	Paneer Biryani / Egg Biryani, Raita, Mutter Masala, Chana Dal Tadka, Phulka, Makkan Peda, White Rice
33	2	2	1	Upma, Vada, Coriander Chutney, Curd
34	2	2	2	Chola Bhatura, Toor Dal Fry, Watermelon, Green Mix Vegetables (Dry), Lemon Rice, Curd
35	2	2	3	Dahi Papdi Chat
36	2	2	4	Phulka, White Rice, Methi Dal, Mix Veg (Dry), Sambar, Ice-cream
37	2	3	1	Puttu, Kadal Curry, Peanut Butter
38	2	3	2	Chapathi, Methi Dal, Drumstick Gravy, Dondakaya Dry, Rasam, Buttermilk
39	2	3	3	Mysore Bonda
40	2	3	4	Kadai Chicken / Kadai Paneer, Pulao, Mix Dal, Tawa Butter Naan, Mango Pickle, Lemon
41	2	4	1	Mini Chola Bhatura, Seasonal Fruit
42	2	4	2	Chapathi, Mutter Paneer Masala, Coriander Rice, Kollu Rasam, Potato Chips, Dal Podhi, Curd
43	2	4	3	Cutlet & Tomato Ketchup
44	2	4	4	Arhar Dal Tadka, Aloo Fry, Kadhi Pakoda, White Rice, Chapati, Mysore Pak
45	2	5	1	Podi Dosa, Sambar, Tomato Chutney, Peanut Butter
46	2	5	2	Phulka, Navadhanya Masala, Sambar, Green Mix Veg (Without Aloo), Rasam, Watermelon Juice
47	2	5	3	Pani Puri
48	2	5	4	Chicken Gravy / Paneer Butter Masala, Pulao, Mix Dal, Chapathi, Fruit Vermicelli Sheera
49	2	6	1	Mix Veg Paratha, Mint Chutney, Curd, Ketchup
50	2	6	2	Chapathi, Green Peas Pulao, Spinach Dal, Gobhi Capsicum Dry, Butter Masala, Cabbage Chutney, Masala Buttermilk
51	2	6	3	Samosa, Tomato Ketchup, Cold Coffee
52	2	6	4	Dal Makhani, Aloo Brinjal (Dry), Sambar, Phulka, White Rice, Kheer
53	2	7	1	Andhra Kara Dosa, Peanut Chutney, Sambar
54	2	7	2	Puri, Briyani Rice, Chicken Masala (Spicy) / Paneer Masala (Spicy), Chana Dal Tadka, Raita, Fruit Juice
55	2	7	3	Pav Bhaji
56	2	7	4	Phulka, Baby Aloo Masala, Soya Chilli (Semi Dry), White Rice, Thick Dal, Rasam
\.


--
-- TOC entry 5088 (class 0 OID 17428)
-- Dependencies: 230
-- Data for Name: people_count; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.people_count (count_id, menu_id, count_date, count_time, people_total) FROM stdin;
\.


--
-- TOC entry 5078 (class 0 OID 17350)
-- Dependencies: 220
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (role_id, role_name) FROM stdin;
1	student
2	admin
\.


--
-- TOC entry 5080 (class 0 OID 17361)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, email, password_hash, role_id) FROM stdin;
\.


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 225
-- Name: day_type_day_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.day_type_day_type_id_seq', 5, true);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 231
-- Name: live_count_live_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.live_count_live_id_seq', 1, false);


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 223
-- Name: meal_type_meal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meal_type_meal_id_seq', 4, true);


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 227
-- Name: menu_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_menu_id_seq', 56, true);


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 229
-- Name: people_count_count_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.people_count_count_id_seq', 1, false);


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 219
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_role_id_seq', 2, true);


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


-- Completed on 2026-02-27 17:08:27

--
-- PostgreSQL database dump complete
--

\unrestrict n8yoUacheTTObVzkxNWHRggvVCxiLHPiNcA63uu6x5MOIAjhE57ZZv3kLfPDhED


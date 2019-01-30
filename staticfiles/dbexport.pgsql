--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: maincontent_attraction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maincontent_attraction (
    id integer NOT NULL,
    attname character varying(80) NOT NULL,
    attshortdesc character varying(1000) NOT NULL,
    attfulldesc character varying(1000) NOT NULL,
    atttime character varying(1000) NOT NULL,
    attcostadult integer NOT NULL,
    attcostchild integer NOT NULL,
    attthumbnail_path character varying(100) NOT NULL,
    visible boolean NOT NULL,
    howtogo character varying(1000) NOT NULL,
    howtogovsible boolean NOT NULL,
    slug character varying(50) NOT NULL,
    cityslug character varying(50) NOT NULL,
    attcity_id integer NOT NULL
);


ALTER TABLE public.maincontent_attraction OWNER TO postgres;

--
-- Name: maincontent_attraction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maincontent_attraction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maincontent_attraction_id_seq OWNER TO postgres;

--
-- Name: maincontent_attraction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maincontent_attraction_id_seq OWNED BY public.maincontent_attraction.id;


--
-- Name: maincontent_attractionimages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maincontent_attractionimages (
    id integer NOT NULL,
    imfilename character varying(100) NOT NULL,
    imthumbfilename character varying(100) NOT NULL,
    imcaption character varying(300) NOT NULL,
    imauthor character varying(30) NOT NULL,
    imattname_id integer NOT NULL
);


ALTER TABLE public.maincontent_attractionimages OWNER TO postgres;

--
-- Name: maincontent_attractionimages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maincontent_attractionimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maincontent_attractionimages_id_seq OWNER TO postgres;

--
-- Name: maincontent_attractionimages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maincontent_attractionimages_id_seq OWNED BY public.maincontent_attractionimages.id;


--
-- Name: maincontent_city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maincontent_city (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    chinesename character varying(10) NOT NULL,
    shortdescription character varying(150) NOT NULL,
    thumbnail_path character varying(100) NOT NULL,
    banner_path character varying(100) NOT NULL,
    cityfulldesc text NOT NULL,
    cityfulldesc2 text NOT NULL,
    attsfulldesc text NOT NULL,
    eatsfulldesc text NOT NULL,
    accommodationfulldesc text NOT NULL,
    weatherdesc text NOT NULL,
    qspopulation integer NOT NULL,
    qsno1highlight character varying(30) NOT NULL,
    sortpriority integer NOT NULL,
    visible boolean NOT NULL,
    transportvisible boolean NOT NULL,
    transportoutervisible boolean NOT NULL,
    eatvisible boolean NOT NULL,
    accommodationvisible boolean NOT NULL,
    weathervisible boolean NOT NULL,
    coordinates character varying(30) NOT NULL,
    slug character varying(50) NOT NULL,
    province_id integer NOT NULL,
    qsprovince character varying(30) NOT NULL
);


ALTER TABLE public.maincontent_city OWNER TO postgres;

--
-- Name: maincontent_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maincontent_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maincontent_city_id_seq OWNER TO postgres;

--
-- Name: maincontent_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maincontent_city_id_seq OWNED BY public.maincontent_city.id;


--
-- Name: maincontent_cityimages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maincontent_cityimages (
    id integer NOT NULL,
    imfilename character varying(100) NOT NULL,
    imthumbfilename character varying(100) NOT NULL,
    imcaption character varying(300) NOT NULL,
    imauthor character varying(100) NOT NULL,
    imcityname_id integer NOT NULL
);


ALTER TABLE public.maincontent_cityimages OWNER TO postgres;

--
-- Name: maincontent_cityimages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maincontent_cityimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maincontent_cityimages_id_seq OWNER TO postgres;

--
-- Name: maincontent_cityimages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maincontent_cityimages_id_seq OWNED BY public.maincontent_cityimages.id;


--
-- Name: maincontent_cityweather; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maincontent_cityweather (
    id integer NOT NULL,
    weathermonth integer NOT NULL,
    avghigh numeric(3,1) NOT NULL,
    avglow numeric(3,1) NOT NULL,
    rainmm integer NOT NULL,
    raindays integer NOT NULL,
    humidity integer NOT NULL,
    weathercity_id integer NOT NULL
);


ALTER TABLE public.maincontent_cityweather OWNER TO postgres;

--
-- Name: maincontent_cityweather_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maincontent_cityweather_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maincontent_cityweather_id_seq OWNER TO postgres;

--
-- Name: maincontent_cityweather_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maincontent_cityweather_id_seq OWNED BY public.maincontent_cityweather.id;


--
-- Name: maincontent_eat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maincontent_eat (
    id integer NOT NULL,
    eatname character varying(40) NOT NULL,
    eatshortdesc character varying(1000) NOT NULL,
    eatfulldesc character varying(1000) NOT NULL,
    eattime character varying(1000) NOT NULL,
    eatcost character varying(300) NOT NULL,
    visible boolean NOT NULL,
    eatcity_id integer NOT NULL
);


ALTER TABLE public.maincontent_eat OWNER TO postgres;

--
-- Name: maincontent_eat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maincontent_eat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maincontent_eat_id_seq OWNER TO postgres;

--
-- Name: maincontent_eat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maincontent_eat_id_seq OWNED BY public.maincontent_eat.id;


--
-- Name: maincontent_province; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maincontent_province (
    id integer NOT NULL,
    provname character varying(40) NOT NULL,
    provpopulation integer NOT NULL,
    provfulldesc text NOT NULL,
    provtype character varying(30) NOT NULL,
    slug character varying(50) NOT NULL
);


ALTER TABLE public.maincontent_province OWNER TO postgres;

--
-- Name: maincontent_province_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maincontent_province_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maincontent_province_id_seq OWNER TO postgres;

--
-- Name: maincontent_province_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maincontent_province_id_seq OWNED BY public.maincontent_province.id;


--
-- Name: maincontent_transport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maincontent_transport (
    id integer NOT NULL,
    transporttype character varying(40) NOT NULL,
    transportdetails character varying(3000) NOT NULL,
    transportcity_id integer NOT NULL
);


ALTER TABLE public.maincontent_transport OWNER TO postgres;

--
-- Name: maincontent_transport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maincontent_transport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maincontent_transport_id_seq OWNER TO postgres;

--
-- Name: maincontent_transport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maincontent_transport_id_seq OWNED BY public.maincontent_transport.id;


--
-- Name: maincontent_transportouter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maincontent_transportouter (
    id integer NOT NULL,
    transporttype character varying(40) NOT NULL,
    transportname character varying(80) NOT NULL,
    transportdetails character varying(1000) NOT NULL,
    transportcity_id integer NOT NULL
);


ALTER TABLE public.maincontent_transportouter OWNER TO postgres;

--
-- Name: maincontent_transportouter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maincontent_transportouter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maincontent_transportouter_id_seq OWNER TO postgres;

--
-- Name: maincontent_transportouter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maincontent_transportouter_id_seq OWNED BY public.maincontent_transportouter.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: maincontent_attraction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_attraction ALTER COLUMN id SET DEFAULT nextval('public.maincontent_attraction_id_seq'::regclass);


--
-- Name: maincontent_attractionimages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_attractionimages ALTER COLUMN id SET DEFAULT nextval('public.maincontent_attractionimages_id_seq'::regclass);


--
-- Name: maincontent_city id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_city ALTER COLUMN id SET DEFAULT nextval('public.maincontent_city_id_seq'::regclass);


--
-- Name: maincontent_cityimages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_cityimages ALTER COLUMN id SET DEFAULT nextval('public.maincontent_cityimages_id_seq'::regclass);


--
-- Name: maincontent_cityweather id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_cityweather ALTER COLUMN id SET DEFAULT nextval('public.maincontent_cityweather_id_seq'::regclass);


--
-- Name: maincontent_eat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_eat ALTER COLUMN id SET DEFAULT nextval('public.maincontent_eat_id_seq'::regclass);


--
-- Name: maincontent_province id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_province ALTER COLUMN id SET DEFAULT nextval('public.maincontent_province_id_seq'::regclass);


--
-- Name: maincontent_transport id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_transport ALTER COLUMN id SET DEFAULT nextval('public.maincontent_transport_id_seq'::regclass);


--
-- Name: maincontent_transportouter id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_transportouter ALTER COLUMN id SET DEFAULT nextval('public.maincontent_transportouter_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add city	7	add_city
20	Can change city	7	change_city
21	Can delete city	7	delete_city
22	Can add attraction	8	add_attraction
23	Can change attraction	8	change_attraction
24	Can delete attraction	8	delete_attraction
25	Can add eat	9	add_eat
26	Can change eat	9	change_eat
27	Can delete eat	9	delete_eat
28	Can add EasyMaps Address	10	add_address
29	Can change EasyMaps Address	10	change_address
30	Can delete EasyMaps Address	10	delete_address
31	Can add attraction images	11	add_attractionimages
32	Can change attraction images	11	change_attractionimages
33	Can delete attraction images	11	delete_attractionimages
34	Can add city images	12	add_cityimages
35	Can change city images	12	change_cityimages
36	Can delete city images	12	delete_cityimages
37	Can add transport	13	add_transport
38	Can change transport	13	change_transport
39	Can delete transport	13	delete_transport
40	Can add transport outer	14	add_transportouter
41	Can change transport outer	14	change_transportouter
42	Can delete transport outer	14	delete_transportouter
46	Can add province	16	add_province
47	Can change province	16	change_province
48	Can delete province	16	delete_province
49	Can add city weather	17	add_cityweather
50	Can change city weather	17	change_cityweather
51	Can delete city weather	17	delete_cityweather
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$20000$ufji2WhofoAa$a97shl/4aaMp2iIINS6BkJlNcc5GYuDw3FScWRUFvZY=	2018-05-05 15:05:43.758+08	t	robert			robert@robert.com	t	t	2018-04-05 15:22:12.334+08
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2018-04-05 18:19:37.602+08	8	The Bund	2	Changed attthumbnail_path.	8	1
2	2018-04-06 00:33:09.333+08	1	01.jpg	1		11	1
3	2018-04-06 00:34:01.868+08	2	02.jpg	1		11	1
4	2018-04-06 00:34:26.845+08	3	03.jpg	1		11	1
5	2018-04-06 00:36:01.084+08	4	04.jpg	1		11	1
6	2018-04-06 14:48:35.286+08	1	images/city/shanghai/thebund/01.jpg	2	Changed imfilename.	11	1
7	2018-04-06 14:56:17.061+08	2	images/city/shanghai/thebund/02.jpg	2	Changed imfilename.	11	1
8	2018-04-06 14:56:22.142+08	3	images/city/shanghai/thebund/03.jpg	2	Changed imfilename.	11	1
9	2018-04-06 14:56:26.956+08	4	images/city/shanghai/thebund/04.jpg	2	Changed imfilename.	11	1
10	2018-04-06 17:03:28.654+08	8	The Bund	2	Changed attfulldesc.	8	1
11	2018-04-06 17:06:00.842+08	4	images/city/shanghai/thebund/04.jpg	2	No fields changed.	11	1
12	2018-04-06 17:06:18.82+08	5	images/city/shanghai/thebund/05.jpg	1		11	1
13	2018-04-06 17:06:40.25+08	6	images/city/shanghai/thebund/06.jpg	1		11	1
14	2018-04-06 17:06:58.589+08	7	images/city/shanghai/thebund/07.jpg	1		11	1
15	2018-04-06 17:06:59.1+08	8	images/city/shanghai/thebund/07.jpg	1		11	1
16	2018-04-06 17:07:15.547+08	9	images/city/shanghai/thebund/08.jpg	1		11	1
17	2018-04-06 17:07:36.515+08	10	images/city/shanghai/thebund/09.jpg	1		11	1
18	2018-04-06 17:08:01.141+08	11	images/city/shanghai/thebund/10.jpg	1		11	1
19	2018-04-06 17:08:21.684+08	7	images/city/shanghai/thebund/07.jpg	3		11	1
20	2018-04-06 17:33:54.02+08	1	images/city/shanghai/thebund/01_thumb.jpg	2	Changed imfilename.	11	1
21	2018-04-06 17:34:06.277+08	2	images/city/shanghai/thebund/02_thumb.jpg	2	Changed imfilename.	11	1
22	2018-04-06 17:34:11.93+08	3	images/city/shanghai/thebund/03_thumb.jpg	2	Changed imfilename.	11	1
23	2018-04-06 17:34:19.215+08	4	images/city/shanghai/thebund/04_thumb.jpg	2	Changed imfilename.	11	1
24	2018-04-06 17:34:24.94+08	5	images/city/shanghai/thebund/05_thumb.jpg	2	Changed imfilename.	11	1
25	2018-04-06 17:34:30.719+08	6	images/city/shanghai/thebund/06_thumb.jpg	2	Changed imfilename.	11	1
26	2018-04-06 17:34:36.364+08	8	images/city/shanghai/thebund/07_thumb.jpg	2	Changed imfilename.	11	1
27	2018-04-06 17:34:41.988+08	9	images/city/shanghai/thebund/08_thumb.jpg	2	Changed imfilename.	11	1
28	2018-04-06 17:34:47.79+08	10	images/city/shanghai/thebund/09_thumb.jpg	2	Changed imfilename.	11	1
29	2018-04-06 17:34:54.016+08	11	images/city/shanghai/thebund/10_thumb.jpg	2	Changed imfilename.	11	1
30	2018-04-06 17:55:18.116+08	1	images/city/shanghai/thebund/01_thumb.jpg	2	Changed imthumbfilename.	11	1
31	2018-04-06 17:55:33.034+08	2	images/city/shanghai/thebund/02.jpg	2	Changed imfilename and imthumbfilename.	11	1
32	2018-04-06 17:55:47.158+08	1	images/city/shanghai/thebund/01.jpg	2	Changed imfilename and imthumbfilename.	11	1
33	2018-04-06 17:56:02.621+08	3	images/city/shanghai/thebund/03.jpg	2	Changed imfilename and imthumbfilename.	11	1
34	2018-04-06 17:56:22.952+08	4	images/city/shanghai/thebund/04.jpg	2	Changed imfilename and imthumbfilename.	11	1
35	2018-04-06 17:56:36.901+08	5	images/city/shanghai/thebund/05.jpg	2	Changed imfilename and imthumbfilename.	11	1
36	2018-04-06 17:56:51.038+08	6	images/city/shanghai/thebund/06.jpg	2	Changed imfilename and imthumbfilename.	11	1
37	2018-04-06 17:57:09.282+08	8	images/city/shanghai/thebund/07.jpg	2	Changed imfilename and imthumbfilename.	11	1
38	2018-04-06 17:57:24.305+08	9	images/city/shanghai/thebund/08.jpg	2	Changed imfilename and imthumbfilename.	11	1
39	2018-04-06 17:57:41.395+08	10	images/city/shanghai/thebund/09.jpg	2	Changed imfilename and imthumbfilename.	11	1
40	2018-04-06 17:57:57.38+08	11	images/city/shanghai/thebund/10.jpg	2	Changed imfilename and imthumbfilename.	11	1
41	2018-04-06 18:10:21.14+08	6	Beijing	2	Changed qsno1highlight and sortpriority.	7	1
42	2018-04-06 18:10:40.318+08	64	Shanghai	2	Changed qsno1highlight and sortpriority.	7	1
43	2018-04-06 18:11:04.905+08	69	Shenzhen 	2	Changed thumbnail_path, banner_path, qsno1highlight and sortpriority.	7	1
44	2018-04-06 18:11:14.337+08	26	Guangzhou	2	Changed qsno1highlight and sortpriority.	7	1
45	2018-04-06 18:11:50.045+08	84	Xi'an	2	Changed qspopulation, qsno1highlight and sortpriority.	7	1
46	2018-04-06 18:13:07.244+08	27	Guilin	2	Changed qsno1highlight and sortpriority.	7	1
47	2018-04-06 18:13:58.696+08	69	Shenzhen 	2	Changed thumbnail_path.	7	1
48	2018-04-06 18:14:27.392+08	84	Xi'an	2	Changed thumbnail_path and banner_path.	7	1
49	2018-04-06 18:14:51.361+08	84	Xi'an	2	Changed thumbnail_path.	7	1
50	2018-04-06 18:16:07.421+08	11	Chengdu	2	Changed qsno1highlight and sortpriority.	7	1
51	2018-04-06 18:16:21.629+08	12	Chongqing	2	Changed qsno1highlight and sortpriority.	7	1
52	2018-04-06 18:16:30.415+08	13	Dali	2	Changed qsno1highlight and sortpriority.	7	1
53	2018-04-06 23:06:34.416+08	8	The Bund	2	Changed visible.	8	1
54	2018-04-06 23:17:27.339+08	64	Shanghai	2	Changed visible.	7	1
55	2018-04-06 23:17:36.719+08	6	Beijing	2	Changed visible.	7	1
56	2018-04-06 23:17:46.046+08	69	Shenzhen 	2	Changed visible.	7	1
57	2018-04-06 23:18:07.571+08	26	Guangzhou	2	Changed visible.	7	1
58	2018-04-06 23:18:20.934+08	84	Xi'an	2	Changed visible.	7	1
59	2018-04-06 23:18:28.98+08	27	Guilin	2	Changed visible.	7	1
60	2018-04-06 23:18:41.506+08	11	Chengdu	2	Changed visible.	7	1
61	2018-04-06 23:18:49.013+08	12	Chongqing	2	Changed visible.	7	1
62	2018-04-06 23:18:56.938+08	13	Dali	2	Changed visible.	7	1
63	2018-04-06 23:47:32.812+08	1	images/city/shanghai/01.jpg	1		12	1
64	2018-04-07 00:04:06.788+08	64	Shanghai	2	Changed cityfulldesc and qspopulation.	7	1
65	2018-04-07 00:16:52.574+08	2	images/city/shanghai/02.jpg	1		12	1
66	2018-04-07 00:17:13.866+08	3	images/city/shanghai/03.jpg	1		12	1
67	2018-04-07 00:17:33.955+08	4	images/city/shanghai/04.jpg	1		12	1
68	2018-04-07 00:17:54.902+08	5	images/city/shanghai/05.jpg	1		12	1
69	2018-04-07 00:18:22.14+08	6	images/city/shanghai/06.jpg	1		12	1
70	2018-04-07 00:18:52.673+08	7	images/city/shanghai/07.jpg	1		12	1
71	2018-04-07 00:19:19.588+08	8	images/city/shanghai/08.jpg	1		12	1
72	2018-04-07 00:19:48.02+08	9	images/city/shanghai/09.jpg	1		12	1
73	2018-04-07 00:20:25.346+08	10	images/city/shanghai/10.jpg	1		12	1
74	2018-04-07 00:41:57.281+08	8	The Bund	2	Changed howtogovsible.	8	1
75	2018-04-07 12:25:43.574+08	64	Shanghai	2	Changed cityfulldesc2.	7	1
76	2018-04-07 12:26:50.357+08	64	Shanghai	2	Changed cityfulldesc2.	7	1
77	2018-04-07 12:27:59.715+08	64	Shanghai	2	Changed cityfulldesc2.	7	1
78	2018-04-07 12:31:36.511+08	64	Shanghai	2	Changed cityfulldesc2.	7	1
79	2018-04-07 12:33:42.484+08	64	Shanghai	2	Changed cityfulldesc2.	7	1
80	2018-04-07 12:35:04.347+08	64	Shanghai	2	Changed cityfulldesc2.	7	1
81	2018-04-07 12:36:34.255+08	64	Shanghai	2	Changed cityfulldesc2.	7	1
82	2018-04-07 12:46:34.388+08	64	Shanghai	2	Changed cityfulldesc2.	7	1
83	2018-04-07 17:23:43.182+08	1	Metro	1		13	1
84	2018-04-07 17:24:08.967+08	2	Bus	1		13	1
85	2018-04-07 17:33:33.859+08	1	Hongqiao Railway Station	1		14	1
86	2018-04-07 17:34:26.099+08	2	Shanghai Pudong International Airport	1		14	1
87	2018-04-07 17:37:25.12+08	64	Shanghai	2	Changed transportvisible and transportoutervisible.	7	1
88	2018-04-07 18:21:38.426+08	64	Shanghai	2	Changed eatvisible.	7	1
89	2018-04-07 18:38:32.333+08	64	Shanghai	2	Changed accommodationvisible.	7	1
90	2018-04-07 19:45:33.722+08	64	Shanghai	2	Changed shortdescription.	7	1
91	2018-04-07 19:47:30.166+08	12	Xintiandi	2	Changed attshortdesc and visible.	8	1
92	2018-04-07 20:10:53.713+08	9	Yuyuan (Yu Garden)	2	Changed visible.	8	1
93	2018-04-07 20:11:16.211+08	18	Tianzifang	2	Changed attname and visible.	8	1
94	2018-04-07 20:12:32.568+08	9	Yu Garden	2	Changed attname.	8	1
95	2018-04-07 20:46:01.089+08	1	Metro	2	Changed transportdetails.	13	1
96	2018-04-07 20:47:14.442+08	1	Metro	2	Changed transportdetails.	13	1
97	2018-04-07 20:50:10.607+08	2	Bus	2	Changed transportdetails.	13	1
98	2018-04-07 20:53:22.788+08	3	Maglev Train	1		13	1
99	2018-04-07 21:02:04.618+08	2	Shanghai Pudong International Airport	2	Changed transportdetails.	14	1
100	2018-04-07 21:04:59.406+08	1	Hongqiao Railway Station	2	Changed transportdetails.	14	1
101	2018-04-07 21:17:56.907+08	3	Shanghai Hongqiao International Airport	1		14	1
102	2018-04-07 21:28:51.919+08	4	Taxi	1		13	1
103	2018-04-07 21:37:12.945+08	64	Shanghai	2	Changed eatsfulldesc.	7	1
104	2018-04-15 13:02:06.952+08	11	images/city/beijing/15420575789_2bb1cbd597_h.jpg	1		12	1
105	2018-04-15 15:05:56.324+08	12	images/city/beijing/33371465722_65023f19bd_k.jpg	1		12	1
106	2018-04-15 15:08:12.079+08	13	images/city/beijing/33595662166_f28869a0fd_k.jpg	1		12	1
107	2018-04-15 15:19:09.679+08	14	images/city/beijing/32635852234_085eef892d_k.jpg	1		12	1
108	2018-04-15 15:20:00.13+08	15	images/city/beijing/33375228311_54bbdec1dc_k.jpg	1		12	1
109	2018-04-15 15:21:10.038+08	16	images/city/beijing/33399544191_1c685021c6_k.jpg	1		12	1
110	2018-04-15 15:21:49.862+08	17	images/city/beijing/33399544191_1c685021c6_k.jpg	1		12	1
111	2018-04-15 15:28:18.693+08	17	images/city/beijing/33512289405_206b972b8f_k.jpg	2	Changed imfilename and imthumbfilename.	12	1
112	2018-04-15 15:29:42.95+08	17	images/city/beijing/33512289405_206b972b8f_k.jpg	2	Changed imthumbfilename.	12	1
113	2018-04-15 16:08:28.992+08	18	images/city/beijing/14931633799_966f1e71d2_o.jpg	1		12	1
114	2018-04-15 16:09:31.623+08	19	images/city/beijing/15420575789_845bf3933a_o.jpg	1		12	1
115	2018-04-15 16:10:43.523+08	20	images/city/beijing/15420575789_845bf3933a_o.jpg17644872995_4f1303b253_k	1		12	1
116	2018-04-15 16:11:49.682+08	21	images/city/beijing/25774930174_95a98e5d6f_k.jpg	1		12	1
117	2018-04-15 16:12:20.085+08	20	images/city/beijing/17644872995_4f1303b253_k	2	Changed imfilename.	12	1
118	2018-04-15 16:12:31.133+08	20	images/city/beijing/17644872995_4f1303b253_k.jp	2	Changed imfilename.	12	1
119	2018-04-15 16:12:40.983+08	20	images/city/beijing/17644872995_4f1303b253_k.jpg	2	Changed imfilename.	12	1
120	2018-04-15 16:13:45.57+08	22	images/city/beijing/28099576673_ce3f2cb520_k.jpg	1		12	1
121	2018-04-15 16:15:24.823+08	23	images/city/beijing/33375228311_54bbdec1dc_k.jpg	1		12	1
122	2018-04-15 16:16:41.06+08	24	images/city/beijing/images/city/beijing/34370017420_d603ff1c23_k.jpg	1		12	1
123	2018-04-15 16:16:53.756+08	24	images/city/beijing/34370017420_d603ff1c23_k.jpg	2	Changed imfilename.	12	1
124	2018-04-15 16:17:53.307+08	23	images/city/beijing/33375228311_54bbdec1dc_k.jpg	2	Changed imthumbfilename.	12	1
125	2018-04-15 16:47:06.878+08	25	images/city/guangzhou/3440737305_facc11610d_o.jpg	1		12	1
126	2018-04-15 16:48:26.842+08	26	images/city/guangzhou/5529046923_3b0c06ce71_o.jpg	1		12	1
127	2018-04-15 16:49:32.874+08	27	images/city/guangzhou/9367794533_de15b38358_k.jpg	1		12	1
128	2018-04-15 16:50:51.731+08	28	images/city/guangzhou/15092304688_3433c770d8_k.jpg	1		12	1
129	2018-04-15 16:52:07.892+08	29	images/city/guangzhou/16851733691_27ac452510_k.jpg	1		12	1
130	2018-04-15 16:53:44.887+08	30	images/city/guangzhou/32110218833_f316e6c699_k.jpg	1		12	1
131	2018-04-15 16:55:16.109+08	31	images/city/guangzhou/32205008854_5b4190cc87_k.jpg	1		12	1
132	2018-04-15 16:56:16.217+08	32	images/city/guangzhou/32665863190_1393cd1c51_k.jpg	1		12	1
133	2018-04-15 16:58:03.749+08	33	images/city/guangzhou/32894236042_1509de8cc0_k.jpg	1		12	1
134	2018-04-15 16:59:35.653+08	34	images/city/guangzhou/32925180405_789d0883b0_k.jpg	1		12	1
135	2018-04-15 17:00:51.377+08	35	images/city/guangzhou/33006159766_2cd6a61863_k.jpg	1		12	1
136	2018-04-15 17:02:20.946+08	36	images/city/guangzhou/34506890600_2466226e61_k.jpg	1		12	1
137	2018-04-15 17:03:42.62+08	37	images/city/guangzhou/38498951055_6da2d3db0c_k.jpg	1		12	1
138	2018-04-15 17:06:54.175+08	38	images/city/guangzhou/15092304688_3433c770d8_k.jpg	1		12	1
139	2018-04-15 18:25:22.923+08	39	images/city/guangzhou/856999118_7d376b5664_o.jpg	1		12	1
140	2018-04-15 18:27:02.508+08	40	images/city/guangzhou/2256174318_e9b6c8c596_o.jpg	1		12	1
141	2018-04-15 18:30:08.702+08	41	images/city/guangzhou/4627001880_f249100bc6_o.jpg	1		12	1
142	2018-04-15 18:31:19.332+08	42	images/city/guangzhou/5686674214_216ea10918_o.jpg	1		12	1
143	2018-04-15 18:32:43.524+08	43	images/city/guangzhou/5904040755_bf6cf6520b_b.jpg	1		12	1
144	2018-04-15 18:33:49.699+08	44	images/city/guangzhou/29683571726_5fca5ae466_k.jpg	1		12	1
145	2018-04-15 18:35:14.706+08	45	images/city/guangzhou/35798313502_f05dfae3b9_k.jpg	1		12	1
146	2018-04-15 18:36:18.048+08	46	images/city/guangzhou/35836492551_94d82b50ee_k.jpg	1		12	1
147	2018-04-15 18:37:28.109+08	47	images/city/shenzhen/35969229075_dba862e7fa_k.jpg	1		12	1
148	2018-04-15 18:38:32.228+08	48	images/city/shenzhen/38037387415_a9b16e2b27_k.jpg	1		12	1
149	2018-04-15 18:38:54.255+08	46	images/city/shenzhen/35836492551_94d82b50ee_k.jpg	2	Changed imfilename and imthumbfilename.	12	1
150	2018-04-15 18:39:02.665+08	45	images/city/shenzhen/35798313502_f05dfae3b9_k.jpg	2	Changed imfilename and imthumbfilename.	12	1
151	2018-04-15 18:39:10.385+08	44	images/city/shenzhen/29683571726_5fca5ae466_k.jpg	2	Changed imfilename and imthumbfilename.	12	1
152	2018-04-15 18:39:19.105+08	43	images/city/shenzhen/5904040755_bf6cf6520b_b.jpg	2	Changed imfilename and imthumbfilename.	12	1
153	2018-04-15 18:39:28.563+08	42	images/city/shenzhen/5686674214_216ea10918_o.jpg	2	Changed imfilename and imthumbfilename.	12	1
154	2018-04-15 18:39:43.634+08	41	images/city/shenzhen/4627001880_f249100bc6_o.jpg	2	Changed imfilename and imthumbfilename.	12	1
155	2018-04-15 18:39:53.058+08	40	images/city/shenzhen/2256174318_e9b6c8c596_o.jpg	2	Changed imfilename and imthumbfilename.	12	1
156	2018-04-15 18:40:02.119+08	39	images/city/shenzhen/856999118_7d376b5664_o.jpg	2	Changed imfilename and imthumbfilename.	12	1
157	2018-04-20 23:35:39.907+08	64	Shanghai	2	Changed coordinates.	7	1
158	2018-04-20 23:46:29.992+08	64	Shanghai	2	Changed coordinates.	7	1
159	2018-04-21 18:55:49.979+08	6	Beijing	2	Changed cityfulldesc2, qspopulation, qsno1highlight and coordinates.	7	1
160	2018-04-21 18:58:46.504+08	69	Shenzhen 	2	Changed cityfulldesc2, qspopulation and coordinates.	7	1
161	2018-04-21 18:59:49.176+08	26	Guangzhou	2	Changed cityfulldesc2, qspopulation and coordinates.	7	1
162	2018-04-21 19:00:43.961+08	84	Xi'an	2	Changed cityfulldesc2, qspopulation and coordinates.	7	1
163	2018-04-21 19:01:47.562+08	27	Guilin	2	Changed cityfulldesc2, qspopulation and coordinates.	7	1
164	2018-04-21 19:03:06.685+08	11	Chengdu	2	Changed cityfulldesc2, qspopulation and coordinates.	7	1
165	2018-04-21 19:04:54.866+08	12	Chongqing	2	Changed cityfulldesc2, qspopulation and coordinates.	7	1
166	2018-04-21 19:06:00.379+08	13	Dali	2	Changed cityfulldesc2 and coordinates.	7	1
167	2018-04-22 11:48:36.156+08	55	Nanjing	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
168	2018-04-22 11:48:49.553+08	30	Hangzhou	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
169	2018-04-22 11:48:58.172+08	71	Suzhou	2	Changed cityfulldesc2 and qsno1highlight.	7	1
170	2018-04-22 11:49:10.333+08	71	Suzhou	2	Changed visible.	7	1
171	2018-04-22 11:49:40.737+08	83	Xiamen	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
172	2018-04-22 11:49:50.548+08	60	Qingdao	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
173	2018-04-22 11:50:05.499+08	78	Urumqi	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
174	2018-04-22 11:50:25.29+08	45	Kunming	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
175	2018-04-22 11:50:34.99+08	49	Lijiang	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
176	2018-04-22 11:50:47.923+08	65	Shangri-La	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
177	2018-04-22 11:50:59.319+08	58	Pingyao	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
178	2018-04-22 11:51:08.893+08	90	Yangshuo	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
179	2018-04-22 11:51:20.09+08	16	Datong	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
180	2018-04-22 11:51:30.188+08	14	Dalian	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
181	2018-04-22 11:51:47.675+08	75	Tianjin	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
182	2018-04-22 11:52:31.579+08	80	Wuhan	2	Changed cityfulldesc2, qsno1highlight and visible.	7	1
183	2018-04-22 15:07:29.285+08	64	Shanghai	2	Changed slug.	7	1
184	2018-04-22 15:13:40.078+08	8	The Bund	2	Changed slug.	8	1
185	2018-04-22 15:50:41.197+08	8	The Bund	2	Changed cityslug.	8	1
186	2018-04-22 21:18:13.781+08	6	Beijing	2	Changed slug.	7	1
187	2018-04-22 21:18:54.565+08	69	Shenzhen 	2	Changed slug.	7	1
188	2018-04-22 21:19:15.948+08	26	Guangzhou	2	Changed slug.	7	1
189	2018-04-22 21:20:00.85+08	84	Xi'an	2	Changed slug.	7	1
190	2018-04-22 21:20:38.747+08	27	Guilin	2	Changed slug.	7	1
191	2018-04-22 21:20:53.245+08	11	Chengdu	2	Changed slug.	7	1
192	2018-04-22 21:21:03.875+08	12	Chongqing	2	Changed slug.	7	1
193	2018-04-22 21:21:21.23+08	13	Dali	2	Changed slug.	7	1
194	2018-04-22 21:21:33.746+08	14	Dalian	2	Changed slug.	7	1
195	2018-04-22 21:21:49.934+08	16	Datong	2	Changed slug.	7	1
196	2018-04-22 21:21:59.109+08	30	Hangzhou	2	Changed slug.	7	1
197	2018-04-22 21:22:13.634+08	45	Kunming	2	Changed slug.	7	1
198	2018-04-22 21:22:23.576+08	49	Lijiang	2	Changed slug.	7	1
199	2018-04-22 21:22:35.015+08	55	Nanjing	2	Changed slug.	7	1
200	2018-04-22 21:22:44.829+08	58	Pingyao	2	Changed slug.	7	1
201	2018-04-22 21:23:01.381+08	60	Qingdao	2	Changed slug.	7	1
202	2018-04-22 21:23:28.352+08	65	Shangri-La	2	Changed slug.	7	1
203	2018-04-22 21:23:48.403+08	84	Xi'an	2	No fields changed.	7	1
204	2018-04-22 21:24:06.313+08	71	Suzhou	2	Changed slug.	7	1
205	2018-04-22 21:24:15.847+08	75	Tianjin	2	Changed slug.	7	1
206	2018-04-22 21:24:33.484+08	78	Urumqi	2	Changed slug.	7	1
207	2018-04-22 21:24:45.657+08	80	Wuhan	2	Changed slug.	7	1
208	2018-04-22 21:24:57.866+08	83	Xiamen	2	Changed slug.	7	1
209	2018-04-22 21:25:11.747+08	90	Yangshuo	2	Changed slug.	7	1
210	2018-04-22 22:27:40.95+08	193	Great Wall of China at Badaling	2	Changed visible.	8	1
211	2018-04-22 22:27:54.406+08	195	Forbidden City	2	Changed visible.	8	1
212	2018-04-22 22:28:08.359+08	200	Temple of Heaven	2	Changed visible.	8	1
213	2018-04-22 22:28:26.594+08	199	Summer Palace	2	Changed visible.	8	1
214	2018-04-23 22:26:44.974+08	75	Tianjin	2	Changed cityfulldesc and cityfulldesc2.	7	1
215	2018-04-23 22:29:37.056+08	75	Tianjin	2	Changed attsfulldesc, eatsfulldesc and accommodationfulldesc.	7	1
216	2018-04-23 22:32:13.273+08	75	Tianjin	2	Changed attsfulldesc.	7	1
217	2018-04-23 22:33:31.452+08	75	Tianjin	2	No fields changed.	7	1
218	2018-04-23 22:35:00.623+08	75	Tianjin	2	Changed cityfulldesc.	7	1
219	2018-04-23 22:36:08.59+08	75	Tianjin	2	Changed cityfulldesc.	7	1
220	2018-04-23 22:36:35.994+08	75	Tianjin	2	Changed cityfulldesc.	7	1
221	2018-04-23 22:42:07.782+08	55	Nanjing	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
222	2018-04-23 22:43:35.06+08	14	Dalian	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
223	2018-04-23 22:44:45.572+08	30	Hangzhou	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
224	2018-04-23 22:45:59.481+08	71	Suzhou	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
225	2018-04-23 22:47:20.622+08	80	Wuhan	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
226	2018-04-23 22:48:26.17+08	11	Chengdu	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
227	2018-04-23 22:49:30.169+08	84	Xi'an	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
228	2018-04-23 22:50:39.295+08	12	Chongqing	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
229	2018-04-23 22:52:30.653+08	27	Guilin	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
230	2018-04-23 22:53:51.923+08	83	Xiamen	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
231	2018-04-23 22:55:14.958+08	60	Qingdao	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
232	2018-04-23 22:56:16.205+08	78	Urumqi	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
233	2018-04-23 22:57:53.664+08	13	Dali	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
234	2018-04-23 22:59:00.59+08	45	Kunming	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
235	2018-04-23 23:00:46.541+08	49	Lijiang	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
236	2018-04-23 23:02:00.745+08	65	Shangri-La	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
237	2018-04-23 23:03:13.622+08	58	Pingyao	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
238	2018-04-23 23:04:51.762+08	16	Datong	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
239	2018-04-23 23:05:45.91+08	90	Yangshuo	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatsfulldesc.	7	1
240	2018-04-23 23:07:58.253+08	55	Nanjing	2	Changed coordinates.	7	1
241	2018-04-23 23:09:10.18+08	90	Yangshuo	2	Changed qspopulation and coordinates.	7	1
242	2018-04-23 23:10:32.043+08	83	Xiamen	2	Changed qspopulation and coordinates.	7	1
243	2018-04-23 23:11:34.64+08	80	Wuhan	2	Changed qspopulation and coordinates.	7	1
244	2018-04-23 23:12:55.044+08	78	Urumqi	2	Changed qspopulation and coordinates.	7	1
245	2018-04-23 23:14:17.681+08	75	Tianjin	2	Changed qspopulation and coordinates.	7	1
246	2018-04-23 23:16:47.037+08	71	Suzhou	2	Changed qspopulation and coordinates.	7	1
247	2018-04-23 23:18:08.164+08	65	Shangri-La	2	Changed qspopulation and coordinates.	7	1
248	2018-04-23 23:19:30.079+08	60	Qingdao	2	Changed qspopulation and coordinates.	7	1
249	2018-04-23 23:20:49.664+08	58	Pingyao	2	Changed qspopulation and coordinates.	7	1
250	2018-04-23 23:21:53.529+08	55	Nanjing	2	Changed qspopulation.	7	1
251	2018-04-23 23:22:56.234+08	49	Lijiang	2	Changed qspopulation and coordinates.	7	1
252	2018-04-23 23:24:33.668+08	45	Kunming	2	Changed qspopulation and coordinates.	7	1
253	2018-04-23 23:25:54.844+08	30	Hangzhou	2	Changed qspopulation and coordinates.	7	1
254	2018-04-23 23:27:13.479+08	16	Datong	2	Changed qspopulation and coordinates.	7	1
255	2018-04-23 23:28:19.077+08	14	Dalian	2	Changed qspopulation and coordinates.	7	1
256	2018-04-23 23:29:24.365+08	13	Dali	2	Changed qspopulation.	7	1
257	2018-04-27 23:16:30.276+08	6	Beijing	2	Changed shortdescription.	7	1
258	2018-04-27 23:19:01.718+08	69	Shenzhen 	2	Changed shortdescription.	7	1
259	2018-04-27 23:20:10.752+08	26	Guangzhou	2	Changed shortdescription.	7	1
260	2018-04-27 23:21:24.616+08	84	Xi'an	2	Changed shortdescription.	7	1
261	2018-04-27 23:22:33.664+08	27	Guilin	2	Changed shortdescription.	7	1
262	2018-04-27 23:24:15.311+08	11	Chengdu	2	Changed shortdescription.	7	1
263	2018-04-27 23:26:34.303+08	12	Chongqing	2	Changed shortdescription.	7	1
264	2018-04-27 23:28:16.716+08	13	Dali	2	Changed shortdescription.	7	1
265	2018-04-27 23:57:24.69+08	45	Kunming	2	Changed qsprovince.	7	1
266	2018-04-28 00:01:47.298+08	90	Yangshuo	2	Changed qsprovince.	7	1
267	2018-05-03 20:30:32.009+08	4	Beijing Railway Station	1		14	1
268	2018-05-03 20:30:58.2+08	5	Beijing West Railway Station	1		14	1
269	2018-05-03 20:31:13.234+08	6	Beijing South Railway Station	1		14	1
270	2018-05-03 20:31:31.825+08	7	Beijing Capital International Airport	1		14	1
271	2018-05-03 20:31:51.306+08	8	Beijing Nanyuan Airport	1		14	1
272	2018-05-03 20:32:10.813+08	9	Beijing Daxing International Airport	1		14	1
273	2018-05-03 20:32:39.838+08	10	Shenzhen Railway Station	1		14	1
274	2018-05-03 20:33:00.919+08	11	Shenzhen North Railway Station	1		14	1
275	2018-05-03 20:33:20.404+08	12	Futian Railway Station	1		14	1
276	2018-05-03 20:33:44.116+08	13	Shenzhen Bao'an International Airport	1		14	1
277	2018-05-03 20:34:17.761+08	14	Guangzhou Railway Station	1		14	1
278	2018-05-03 20:34:35.869+08	15	Guangzhou East Station	1		14	1
279	2018-05-03 20:34:59.901+08	16	Guangzhou South Station	1		14	1
280	2018-05-03 20:35:43.009+08	17	Guangzhou North Station	1		14	1
281	2018-05-03 20:35:59.099+08	18	Guangzhou Baiyun International Airport	1		14	1
282	2018-05-03 20:37:16.644+08	6	Beijing	2	Changed transportoutervisible.	7	1
283	2018-05-03 20:37:31.585+08	69	Shenzhen 	2	Changed transportoutervisible.	7	1
284	2018-05-03 20:37:46.691+08	26	Guangzhou	2	Changed transportoutervisible.	7	1
285	2018-05-03 20:42:28.533+08	24	Shanghai Urban Planning Museum	2	Changed visible.	8	1
286	2018-05-03 20:42:34.069+08	24	Shanghai Urban Planning Museum	2	No fields changed.	8	1
287	2018-05-03 20:42:46.418+08	25	Shanghai Science and Technology Museum	2	Changed visible.	8	1
288	2018-05-03 20:43:01.192+08	29	Zhujiajiao	2	Changed visible.	8	1
289	2018-05-03 20:43:07.574+08	29	Zhujiajiao	2	No fields changed.	8	1
290	2018-05-03 20:43:42.585+08	7	People's Square (Shanghai)	2	Changed visible.	8	1
291	2018-05-03 20:44:10.501+08	6	Oriental Pearl TV Tower	2	Changed visible.	8	1
292	2018-05-03 20:44:33.075+08	2	Jin Mao Tower	2	Changed visible.	8	1
293	2018-05-03 20:44:50.293+08	4	Nanjing Road	2	Changed visible.	8	1
294	2018-05-03 20:45:14.019+08	15	Jing'an Temple	2	Changed visible.	8	1
295	2018-05-03 20:45:30.034+08	11	Jade Buddha Temple	2	Changed visible.	8	1
296	2018-05-03 20:45:54.38+08	10	Qibao Old Street (Qibao Ancient Town)	2	Changed visible.	8	1
297	2018-05-03 20:46:43.742+08	134	Garden of the Master of Nets	2	Changed visible.	8	1
298	2018-05-03 20:47:00.707+08	135	Hanshan Temple (Cold Mountain Temple)	2	Changed visible.	8	1
299	2018-05-03 20:47:14.001+08	139	Humble Administrator's Garden	2	Changed visible.	8	1
300	2018-05-03 20:47:31.909+08	145	Jinji Lake (Jinji Hu)	2	Changed visible.	8	1
301	2018-05-03 20:47:46.189+08	150	Temple of Mystery (Xuanmiao Temple)	2	Changed visible.	8	1
302	2018-05-03 20:48:49.823+08	159	Lingyin Temple	2	Changed visible.	8	1
303	2018-05-03 20:49:02.662+08	160	Liuhe Pagoda	2	Changed visible.	8	1
304	2018-05-03 20:49:14.688+08	161	Longjing Tea Plantation	2	Changed visible.	8	1
305	2018-05-03 20:49:28.956+08	167	West Lake (Xi Hu)	2	Changed visible.	8	1
306	2018-05-03 20:49:40.401+08	172	Leifeng Pagoda	2	Changed visible.	8	1
307	2018-05-03 20:49:51.841+08	173	Impression West Lake	2	Changed visible.	8	1
308	2018-05-03 20:50:04.444+08	181	Qiandao Hu (Thousand Island Lake)	2	Changed visible.	8	1
309	2018-05-03 20:50:14.886+08	184	Xixi National Wetland Park	2	Changed visible.	8	1
310	2018-05-03 20:51:06.919+08	201	Tian'anmen Square	2	Changed visible.	8	1
311	2018-05-03 20:51:21.109+08	215	Great Wall of China at Mutianyu	2	Changed visible.	8	1
312	2018-05-03 20:52:17.096+08	291	Tianjin Confucius Temple	2	Changed attname and visible.	8	1
313	2018-05-03 20:52:31.56+08	296	Wudadao (Five Avenues)	2	Changed visible.	8	1
314	2018-05-03 20:52:43.192+08	298	Tianjin Eye	2	Changed visible.	8	1
315	2018-05-03 20:53:03.173+08	327	Golden Temple Park	2	Changed visible.	8	1
316	2018-05-03 20:53:18.465+08	330	Yunnan Stone Forest (Shilin)	2	Changed visible.	8	1
317	2018-05-03 20:53:41.815+08	332	Yunnan Nationalities Village	2	Changed visible.	8	1
318	2018-05-03 20:54:25.911+08	342	Cang Shan	2	Changed visible.	8	1
319	2018-05-03 20:54:37.098+08	343	Erhai Lake	2	Changed visible.	8	1
320	2018-05-03 20:54:50.575+08	344	Three Pagodas	2	Changed visible.	8	1
321	2018-05-03 20:55:03.446+08	347	Zhonghe Temple	2	Changed visible.	8	1
322	2018-05-03 20:55:28.417+08	352	Tiger Leaping Gorge (Hutiao Xia)	2	Changed visible.	8	1
323	2018-05-03 20:55:42.052+08	354	Lijiang Old Town (Dayan)	2	Changed visible.	8	1
324	2018-05-03 20:55:54.656+08	358	Baisha Frescoes	2	Changed visible.	8	1
325	2018-05-03 20:56:07.082+08	360	Shuhe Old Town	2	Changed visible.	8	1
326	2018-05-03 20:56:32.376+08	363	Baimang Snow Mountain	2	Changed visible.	8	1
327	2018-05-03 20:56:47.87+08	365	Mount Meili (Meili Xue Shan)	2	Changed visible.	8	1
328	2018-05-03 20:57:01.278+08	368	Songzanlin Monastery	2	Changed visible.	8	1
329	2018-05-03 20:57:12.935+08	370	Xiagei Hot Springs	2	Changed visible.	8	1
330	2018-05-03 20:57:34.552+08	388	Du Fu's Thatched Cottage	2	Changed visible.	8	1
331	2018-05-03 20:57:46.311+08	390	Giant Panda Breeding Research Base	2	Changed visible.	8	1
332	2018-05-03 20:58:00.65+08	391	Wenshu Monastery	2	Changed visible.	8	1
333	2018-05-03 20:58:14.239+08	403	Luodai Ancient Town	2	Changed visible.	8	1
334	2018-05-03 21:01:17.975+08	485	Nanjing City Wall	2	Changed visible.	8	1
335	2018-05-03 21:01:37.367+08	488	Sun Yat-sen's Mausoleum (Zhongshan Ling)	2	Changed visible.	8	1
336	2018-05-03 21:01:51.568+08	491	Xuanwu Lake	2	Changed visible.	8	1
337	2018-05-03 21:02:01.027+08	493	Memorial Hall of the Nanjing Massacre	2	Changed visible.	8	1
338	2018-05-03 21:02:25.331+08	494	Zijin Shan (Purple Gold Mountain)	2	Changed visible.	8	1
339	2018-05-03 21:03:12.077+08	503	Zifeng Tower (Greenland Financial Center	2	Changed attname and visible.	8	1
340	2018-05-03 21:03:42.61+08	507	Elephant Trunk Hill	2	Changed visible.	8	1
341	2018-05-03 21:03:53.452+08	511	Longji Rice Terraces	2	Changed visible.	8	1
342	2018-05-03 21:04:03.066+08	512	Reed Flute Cave	2	Changed visible.	8	1
343	2018-05-03 21:04:13.117+08	514	Li River Cruise	2	Changed visible.	8	1
344	2018-05-03 21:04:39.405+08	579	Big Wild Goose Pagoda	2	Changed visible.	8	1
345	2018-05-03 21:04:58.896+08	580	Emperor Qin Shihuang's Tomb	2	No fields changed.	8	1
346	2018-05-03 21:05:18.69+08	585	Terracotta Warriors	2	Changed visible.	8	1
347	2018-05-03 21:05:29.543+08	586	Xi'an Bell Tower and Drum Tower	2	Changed visible.	8	1
348	2018-05-03 21:05:40.75+08	587	Xi'an City Wall	2	Changed visible.	8	1
349	2018-05-03 21:05:55.821+08	593	Muslim Street	2	Changed visible.	8	1
350	2018-05-03 21:06:24.42+08	594	Baotong Temple	2	Changed visible.	8	1
351	2018-05-03 21:06:35.525+08	595	East Lake Park	2	Changed visible.	8	1
352	2018-05-03 21:06:49.964+08	598	Yellow Crane Tower	2	Changed visible.	8	1
353	2018-05-03 21:07:04.566+08	604	Longquan Shan Scenic Area	2	Changed visible.	8	1
354	2018-05-03 21:07:43.709+08	609	Tianhou Temple	2	Changed visible.	8	1
355	2018-05-03 21:07:57.955+08	610	Tsingtao Brewery Museum	2	Changed visible.	8	1
356	2018-05-03 21:08:09.981+08	616	Zhan Qiao Pier	2	Changed visible.	8	1
357	2018-05-03 21:08:21.766+08	618	Qingdao TV Tower	2	Changed visible.	8	1
358	2018-05-03 21:08:47.508+08	633	Gulangyu	2	Changed visible.	8	1
359	2018-05-03 21:09:00.937+08	634	Nanputuo Temple	2	Changed visible.	8	1
360	2018-05-03 21:09:11.249+08	638	Piano Museum	2	Changed visible.	8	1
361	2018-05-03 21:09:28.75+08	639	Tianluokeng Hakka Earth Buildings	2	Changed visible.	8	1
362	2018-05-03 21:09:52.012+08	650	West Street (Xi Jie)	2	Changed visible.	8	1
363	2018-05-03 21:10:02.372+08	652	Yueliang Shan (Moon Hill)	2	Changed visible.	8	1
364	2018-05-03 21:10:14.731+08	653	Impression of Liu Sanjie	2	Changed visible.	8	1
365	2018-05-03 21:10:26.814+08	662	Li River (Yangshuo)	2	Changed visible.	8	1
366	2018-05-03 21:10:52.65+08	663	Pingyao City Walls	2	Changed visible.	8	1
367	2018-05-03 21:11:06.54+08	664	Rishengchang Financial Exchange	2	Changed visible.	8	1
368	2018-05-03 21:11:33.022+08	665	Former Residence of Lei Lutai	2	Changed attname and visible.	8	1
369	2018-05-03 21:11:44.57+08	666	Ming-Qing Street	2	Changed visible.	8	1
370	2018-05-03 21:12:25.112+08	724	Baiyun Shan (White Cloud Mountain)	2	Changed visible.	8	1
371	2018-05-03 21:12:34.139+08	725	Qingping Market	2	Changed visible.	8	1
372	2018-05-03 21:12:56.813+08	730	Sun Yat-sen Memorial Hall	2	Changed visible.	8	1
373	2018-05-03 21:13:15.627+08	757	Dazu Rock Carvings	2	Changed visible.	8	1
374	2018-05-03 21:13:27.421+08	758	Red Cliff Village	2	Changed visible.	8	1
375	2018-05-03 21:13:44.97+08	762	Ciqikou Ancient Town	2	Changed visible.	8	1
376	2018-05-03 21:13:55.008+08	764	Jiefangbei Pedestrian Street	2	Changed visible.	8	1
377	2018-05-03 21:16:04.539+08	945	Hunan Provincial Museum	1		8	1
378	2018-05-03 21:16:59.976+08	946	Yuelu Hill Park	1		8	1
379	2018-05-03 21:18:21.413+08	947	Shaoshan	1		8	1
380	2018-05-03 21:19:13.118+08	948	Heng Shan (Hunan)	1		8	1
381	2018-05-03 21:20:31.534+08	949	The Fairy Lake Botanical Gardens	1		8	1
382	2018-05-03 21:21:31.858+08	950	Window of the World	1		8	1
383	2018-05-03 21:22:22.181+08	951	China Folk Culture Village	1		8	1
384	2018-05-03 21:23:09.497+08	952	Dapeng Ancient City	1		8	1
385	2018-05-03 21:25:43.984+08	215	Great Wall of China at Mutianyu	2	Changed slug and cityslug.	8	1
556	2018-05-05 20:32:45.179+08	24	Guizhou	2	Changed slug.	16	1
386	2018-05-03 21:26:38.798+08	201	Tian'anmen Square	2	Changed slug and cityslug.	8	1
387	2018-05-03 21:26:58.447+08	200	Temple of Heaven	2	Changed slug and cityslug.	8	1
388	2018-05-03 21:27:15.017+08	199	Summer Palace	2	Changed slug and cityslug.	8	1
389	2018-05-03 21:27:35.772+08	195	Forbidden City	2	Changed slug and cityslug.	8	1
390	2018-05-03 21:28:01.651+08	193	Great Wall of China at Badaling	2	Changed slug and cityslug.	8	1
391	2018-05-03 21:29:06.81+08	403	Luodai Ancient Town	2	Changed slug and cityslug.	8	1
392	2018-05-03 21:29:24.887+08	391	Wenshu Monastery	2	Changed slug and cityslug.	8	1
393	2018-05-03 21:29:49.35+08	390	Giant Panda Breeding Research Base	2	Changed slug and cityslug.	8	1
394	2018-05-03 21:30:11.529+08	388	Du Fu's Thatched Cottage	2	Changed slug and cityslug.	8	1
395	2018-05-03 21:31:28.516+08	764	Jiefangbei Pedestrian Street	2	Changed slug and cityslug.	8	1
396	2018-05-03 21:31:49.854+08	762	Ciqikou Ancient Town	2	Changed slug and cityslug.	8	1
397	2018-05-03 21:32:09.65+08	758	Red Cliff Village	2	Changed slug and cityslug.	8	1
398	2018-05-03 21:32:29.687+08	757	Dazu Rock Carvings	2	Changed slug and cityslug.	8	1
399	2018-05-03 21:32:50.813+08	347	Zhonghe Temple	2	Changed slug and cityslug.	8	1
400	2018-05-03 21:33:08.1+08	344	Three Pagodas	2	Changed slug and cityslug.	8	1
401	2018-05-03 21:33:26.521+08	343	Erhai Lake	2	Changed slug and cityslug.	8	1
402	2018-05-03 21:33:42.609+08	342	Cang Shan	2	Changed slug and cityslug.	8	1
403	2018-05-03 21:34:13.422+08	730	Sun Yat-sen Memorial Hall	2	Changed slug and cityslug.	8	1
404	2018-05-03 21:34:34.683+08	725	Qingping Market	2	Changed slug and cityslug.	8	1
405	2018-05-03 21:35:01.879+08	724	Baiyun Shan (White Cloud Mountain)	2	Changed slug and cityslug.	8	1
406	2018-05-03 21:35:17.912+08	514	Li River Cruise	2	Changed slug and cityslug.	8	1
407	2018-05-03 21:35:41.502+08	512	Reed Flute Cave	2	Changed slug and cityslug.	8	1
408	2018-05-03 21:36:05.092+08	511	Longji Rice Terraces	2	Changed slug and cityslug.	8	1
409	2018-05-03 21:36:23.511+08	507	Elephant Trunk Hill	2	Changed slug and cityslug.	8	1
410	2018-05-03 21:36:47.358+08	184	Xixi National Wetland Park	2	Changed slug and cityslug.	8	1
411	2018-05-03 21:37:13.923+08	181	Qiandao Hu (Thousand Island Lake)	2	Changed slug and cityslug.	8	1
412	2018-05-03 21:37:35.085+08	173	Impression West Lake	2	Changed slug and cityslug.	8	1
413	2018-05-03 21:38:01.634+08	172	Leifeng Pagoda	2	Changed slug and cityslug.	8	1
414	2018-05-03 21:38:19.327+08	167	West Lake (Xi Hu)	2	Changed slug and cityslug.	8	1
415	2018-05-03 21:38:41.522+08	161	Longjing Tea Plantation	2	Changed slug and cityslug.	8	1
416	2018-05-03 21:39:00.131+08	160	Liuhe Pagoda	2	Changed slug and cityslug.	8	1
417	2018-05-03 21:39:27.148+08	332	Yunnan Nationalities Village	2	Changed slug and cityslug.	8	1
418	2018-05-03 21:39:48.197+08	330	Yunnan Stone Forest (Shilin)	2	Changed slug and cityslug.	8	1
419	2018-05-03 21:40:08.139+08	327	Golden Temple Park	2	Changed slug and cityslug.	8	1
420	2018-05-03 21:40:27.355+08	360	Shuhe Old Town	2	Changed slug and cityslug.	8	1
421	2018-05-03 21:40:44.6+08	358	Baisha Frescoes	2	Changed slug and cityslug.	8	1
422	2018-05-03 21:41:04.455+08	354	Lijiang Old Town (Dayan)	2	Changed slug and cityslug.	8	1
423	2018-05-03 21:41:38.894+08	352	Tiger Leaping Gorge (Hutiao Xia)	2	Changed slug and cityslug.	8	1
424	2018-05-03 21:42:15.397+08	503	Zifeng Tower (Greenland Financial Center	2	Changed slug and cityslug.	8	1
425	2018-05-03 21:42:43.292+08	494	Zijin Shan (Purple Gold Mountain)	2	Changed slug and cityslug.	8	1
426	2018-05-03 21:43:12.642+08	493	Memorial Hall of the Nanjing Massacre	2	Changed slug and cityslug.	8	1
427	2018-05-03 21:43:30.683+08	491	Xuanwu Lake	2	Changed slug and cityslug.	8	1
428	2018-05-03 21:44:12.549+08	488	Sun Yat-sen's Mausoleum (Zhongshan Ling)	2	Changed slug and cityslug.	8	1
429	2018-05-03 21:44:31.72+08	485	Nanjing City Wall	2	Changed slug and cityslug.	8	1
430	2018-05-03 21:44:47.393+08	666	Ming-Qing Street	2	Changed slug and cityslug.	8	1
431	2018-05-03 21:45:14.686+08	665	Former Residence of Lei Lutai	2	Changed slug and cityslug.	8	1
432	2018-05-03 21:45:37.276+08	664	Rishengchang Financial Exchange	2	Changed slug and cityslug.	8	1
433	2018-05-03 21:46:01.255+08	663	Pingyao City Walls	2	Changed slug and cityslug.	8	1
434	2018-05-03 21:46:22.56+08	618	Qingdao TV Tower	2	Changed slug and cityslug.	8	1
435	2018-05-03 21:46:41.624+08	616	Zhan Qiao Pier	2	Changed slug and cityslug.	8	1
436	2018-05-03 21:47:07.119+08	610	Tsingtao Brewery Museum	2	Changed slug and cityslug.	8	1
437	2018-05-03 21:47:22.908+08	609	Tianhou Temple	2	Changed slug and cityslug.	8	1
438	2018-05-03 21:47:43.218+08	29	Zhujiajiao	2	Changed slug and cityslug.	8	1
439	2018-05-03 21:48:04.51+08	25	Shanghai Science and Technology Museum	2	Changed slug and cityslug.	8	1
440	2018-05-03 21:48:27.102+08	24	Shanghai Urban Planning Museum	2	Changed slug and cityslug.	8	1
441	2018-05-03 21:48:41.767+08	18	Tianzifang	2	Changed slug and cityslug.	8	1
442	2018-05-03 21:49:02.486+08	15	Jing'an Temple	2	Changed slug and cityslug.	8	1
443	2018-05-03 21:49:20.584+08	12	Xintiandi	2	Changed slug and cityslug.	8	1
444	2018-05-03 21:49:41.118+08	11	Jade Buddha Temple	2	Changed slug and cityslug.	8	1
445	2018-05-03 21:50:10.057+08	10	Qibao Old Street (Qibao Ancient Town)	2	Changed slug and cityslug.	8	1
446	2018-05-03 21:50:29.724+08	9	Yu Garden	2	Changed slug and cityslug.	8	1
447	2018-05-03 21:50:55.666+08	7	People's Square (Shanghai)	2	Changed slug and cityslug.	8	1
448	2018-05-03 21:51:20.441+08	6	Oriental Pearl TV Tower	2	Changed slug and cityslug.	8	1
449	2018-05-03 21:51:34.866+08	4	Nanjing Road	2	Changed slug and cityslug.	8	1
450	2018-05-03 21:51:50.566+08	2	Jin Mao Tower	2	Changed slug and cityslug.	8	1
451	2018-05-03 21:52:16.943+08	370	Xiagei Hot Springs	2	Changed slug and cityslug.	8	1
452	2018-05-03 21:52:43.709+08	368	Songzanlin Monastery	2	Changed slug and cityslug.	8	1
453	2018-05-03 21:53:09.186+08	365	Mount Meili (Meili Xue Shan)	2	Changed slug and cityslug.	8	1
454	2018-05-03 21:53:32.495+08	363	Baimang Snow Mountain	2	Changed slug and cityslug.	8	1
455	2018-05-03 21:54:06.237+08	150	Temple of Mystery (Xuanmiao Temple)	2	Changed slug and cityslug.	8	1
456	2018-05-03 21:54:26.48+08	145	Jinji Lake (Jinji Hu)	2	Changed slug and cityslug.	8	1
457	2018-05-03 21:54:55.008+08	139	Humble Administrator's Garden	2	Changed slug and cityslug.	8	1
458	2018-05-03 21:55:20.04+08	135	Hanshan Temple (Cold Mountain Temple)	2	Changed slug and cityslug.	8	1
459	2018-05-03 21:55:41.984+08	134	Garden of the Master of Nets	2	Changed slug.	8	1
460	2018-05-03 21:55:58.86+08	298	Tianjin Eye	2	Changed slug and cityslug.	8	1
461	2018-05-03 21:56:22.145+08	296	Wudadao (Five Avenues)	2	Changed slug and cityslug.	8	1
462	2018-05-03 21:56:42.914+08	291	Tianjin Confucius Temple	2	Changed slug and cityslug.	8	1
463	2018-05-03 21:57:08.291+08	604	Longquan Shan Scenic Area	2	Changed slug and cityslug.	8	1
464	2018-05-03 21:57:26.143+08	598	Yellow Crane Tower	2	Changed slug and cityslug.	8	1
465	2018-05-03 21:57:40.759+08	595	East Lake Park	2	Changed slug and cityslug.	8	1
466	2018-05-03 21:58:02.816+08	594	Baotong Temple	2	Changed slug and cityslug.	8	1
467	2018-05-03 21:58:29.859+08	639	Tianluokeng Hakka Earth Buildings	2	Changed slug and cityslug.	8	1
468	2018-05-03 21:58:45.866+08	638	Piano Museum	2	Changed slug and cityslug.	8	1
469	2018-05-03 21:59:11.469+08	634	Nanputuo Temple	2	Changed slug and cityslug.	8	1
470	2018-05-03 21:59:26.184+08	633	Gulangyu	2	Changed slug and cityslug.	8	1
471	2018-05-03 21:59:42.935+08	593	Muslim Street	2	Changed slug and cityslug.	8	1
472	2018-05-03 21:59:58.625+08	587	Xi'an City Wall	2	Changed slug and cityslug.	8	1
473	2018-05-03 22:00:17.26+08	586	Xi'an Bell Tower and Drum Tower	2	Changed slug and cityslug.	8	1
474	2018-05-03 22:00:49.705+08	585	Terracotta Warriors	2	Changed slug and cityslug.	8	1
475	2018-05-03 23:26:46.743+08	1	Province object	1		16	1
476	2018-05-03 23:36:59.572+08	2	Shanghai	1		16	1
477	2018-05-03 23:38:24.631+08	3	Tianjin	1		16	1
478	2018-05-03 23:38:30.679+08	4	Hebei	1		16	1
479	2018-05-03 23:38:35.894+08	5	Shanxi	1		16	1
480	2018-05-03 23:38:45.177+08	6	Inner Mongolia	1		16	1
481	2018-05-03 23:38:51.54+08	7	Liaoning	1		16	1
482	2018-05-03 23:38:56.438+08	8	Jilin	1		16	1
483	2018-05-03 23:39:04.247+08	9	Heilongjiang	1		16	1
484	2018-05-03 23:39:15.809+08	10	Jiangsu	1		16	1
485	2018-05-03 23:39:21.667+08	11	Zhejiang	1		16	1
486	2018-05-03 23:39:26.763+08	12	Anhui	1		16	1
487	2018-05-03 23:39:31.732+08	13	Fujian	1		16	1
488	2018-05-03 23:39:37.72+08	14	Jiangxi	1		16	1
489	2018-05-03 23:39:43.166+08	15	Shandong	1		16	1
490	2018-05-03 23:39:47.713+08	16	Henan	1		16	1
491	2018-05-03 23:39:52.642+08	17	Hubei	1		16	1
492	2018-05-03 23:39:58.223+08	18	Hunan	1		16	1
493	2018-05-03 23:40:12.021+08	19	Guangdong	1		16	1
494	2018-05-03 23:40:20.506+08	20	Guangxi	1		16	1
495	2018-05-03 23:40:27.423+08	21	Hainan	1		16	1
496	2018-05-03 23:40:33.064+08	22	Chongqing	1		16	1
497	2018-05-03 23:40:41.06+08	23	Sichuan	1		16	1
498	2018-05-03 23:40:45.905+08	24	Guizhou	1		16	1
499	2018-05-03 23:40:50.526+08	25	Yunnan	1		16	1
500	2018-05-03 23:40:55.715+08	26	Tibet	1		16	1
501	2018-05-03 23:41:07.911+08	27	Shaanxi	1		16	1
502	2018-05-03 23:41:12.873+08	28	Gansu	1		16	1
503	2018-05-03 23:41:17.831+08	29	Qinghai	1		16	1
504	2018-05-03 23:41:22.994+08	30	Ningxia	1		16	1
505	2018-05-03 23:41:29.185+08	31	Xinjiang	1		16	1
506	2018-05-03 23:41:36.376+08	32	Taiwan	1		16	1
507	2018-05-03 23:41:45.561+08	33	Hong Kong	1		16	1
508	2018-05-03 23:41:50.053+08	34	Macau	1		16	1
509	2018-05-05 15:06:12.178+08	6	Beijing	2	Changed province.	7	1
510	2018-05-05 15:06:42.567+08	90	Yangshuo	2	Changed province.	7	1
511	2018-05-05 15:06:58.821+08	84	Xi'an	2	Changed province.	7	1
512	2018-05-05 15:09:09.219+08	83	Xiamen	2	Changed province.	7	1
513	2018-05-05 15:09:27.387+08	80	Wuhan	2	Changed province.	7	1
514	2018-05-05 15:09:37.303+08	78	Urumqi	2	Changed province.	7	1
515	2018-05-05 15:09:59.425+08	75	Tianjin	2	Changed province.	7	1
516	2018-05-05 15:10:21.421+08	71	Suzhou	2	Changed province.	7	1
517	2018-05-05 15:10:34.502+08	69	Shenzhen 	2	Changed province.	7	1
518	2018-05-05 15:10:47.957+08	65	Shangri-La	2	Changed province.	7	1
519	2018-05-05 15:11:01.021+08	64	Shanghai	2	Changed province.	7	1
520	2018-05-05 15:11:13.444+08	60	Qingdao	2	Changed province.	7	1
521	2018-05-05 15:11:31.627+08	58	Pingyao	2	No fields changed.	7	1
522	2018-05-05 15:11:51.394+08	55	Nanjing	2	Changed province.	7	1
523	2018-05-05 15:12:29.744+08	49	Lijiang	2	Changed province.	7	1
524	2018-05-05 15:12:56.67+08	45	Kunming	2	Changed province.	7	1
525	2018-05-05 15:13:24.296+08	30	Hangzhou	2	Changed province.	7	1
526	2018-05-05 15:14:04.2+08	27	Guilin	2	Changed province.	7	1
527	2018-05-05 15:14:16.881+08	26	Guangzhou	2	Changed province.	7	1
528	2018-05-05 15:16:42.184+08	14	Dalian	2	Changed province.	7	1
529	2018-05-05 15:16:54.856+08	13	Dali	2	Changed province.	7	1
530	2018-05-05 15:17:06.358+08	12	Chongqing	2	Changed province.	7	1
531	2018-05-05 15:17:21.314+08	11	Chengdu	2	Changed province.	7	1
532	2018-05-05 15:17:33.66+08	6	Beijing	2	No fields changed.	7	1
533	2018-05-05 19:03:48.671+08	1	Beijing	2	Changed provslug.	16	1
534	2018-05-05 20:25:00.61+08	2	Shanghai	2	Changed provslug.	16	1
535	2018-05-05 20:29:45.875+08	3	Tianjin	2	Changed slug.	16	1
536	2018-05-05 20:29:52.989+08	4	Hebei	2	Changed slug.	16	1
537	2018-05-05 20:30:02.106+08	5	Shanxi	2	Changed slug.	16	1
538	2018-05-05 20:30:14.209+08	6	Inner Mongolia	2	Changed slug.	16	1
539	2018-05-05 20:30:21.281+08	7	Liaoning	2	Changed slug.	16	1
540	2018-05-05 20:30:28.481+08	8	Jilin	2	Changed slug.	16	1
541	2018-05-05 20:30:36.905+08	9	Heilongjiang	2	Changed slug.	16	1
542	2018-05-05 20:30:43.192+08	10	Jiangsu	2	Changed slug.	16	1
543	2018-05-05 20:30:50.548+08	11	Zhejiang	2	Changed slug.	16	1
544	2018-05-05 20:30:58.693+08	12	Anhui	2	Changed slug.	16	1
545	2018-05-05 20:31:07.518+08	13	Fujian	2	Changed slug.	16	1
546	2018-05-05 20:31:17.145+08	14	Jiangxi	2	Changed slug.	16	1
547	2018-05-05 20:31:34.941+08	15	Shandong	2	Changed slug.	16	1
548	2018-05-05 20:31:43.84+08	16	Henan	2	Changed slug.	16	1
549	2018-05-05 20:31:50.448+08	17	Hubei	2	Changed slug.	16	1
550	2018-05-05 20:31:59.749+08	18	Hunan	2	Changed slug.	16	1
551	2018-05-05 20:32:07.292+08	19	Guangdong	2	Changed slug.	16	1
552	2018-05-05 20:32:17.326+08	20	Guangxi	2	Changed slug.	16	1
553	2018-05-05 20:32:22.206+08	21	Hainan	2	Changed slug.	16	1
554	2018-05-05 20:32:31.908+08	22	Chongqing	2	Changed slug.	16	1
555	2018-05-05 20:32:37.599+08	23	Sichuan	2	Changed slug.	16	1
751	2018-05-06 17:09:12.083+08	66	Bus	1		13	1
557	2018-05-05 20:32:53.111+08	25	Yunnan	2	Changed slug.	16	1
558	2018-05-05 20:32:58.238+08	26	Tibet	2	Changed slug.	16	1
559	2018-05-05 20:33:03.588+08	27	Shaanxi	2	Changed slug.	16	1
560	2018-05-05 20:33:08.563+08	28	Gansu	2	Changed slug.	16	1
561	2018-05-05 20:33:13.765+08	29	Qinghai	2	Changed slug.	16	1
562	2018-05-05 20:33:19.028+08	30	Ningxia	2	Changed slug.	16	1
563	2018-05-05 20:33:24.859+08	31	Xinjiang	2	Changed slug.	16	1
564	2018-05-05 20:33:29.763+08	32	Taiwan	2	Changed slug.	16	1
565	2018-05-05 20:33:36.81+08	33	Hong Kong	2	Changed slug.	16	1
566	2018-05-05 20:33:42.124+08	34	Macau	2	Changed slug.	16	1
567	2018-05-05 21:41:51.276+08	1	Beijing	2	Changed provtype.	16	1
568	2018-05-05 21:42:24.327+08	2	Shanghai	2	Changed provtype.	16	1
569	2018-05-05 21:42:33.18+08	3	Tianjin	2	Changed provtype.	16	1
570	2018-05-05 21:42:38.892+08	22	Chongqing	2	Changed provtype.	16	1
571	2018-05-05 21:43:08.949+08	6	Inner Mongolia	2	Changed provtype.	16	1
572	2018-05-05 21:43:40.496+08	20	Guangxi Autonomous Region	2	Changed provname.	16	1
573	2018-05-05 21:44:10.134+08	26	Tibet	2	Changed provtype.	16	1
574	2018-05-05 21:44:25.478+08	31	Xinjiang	2	Changed provtype.	16	1
575	2018-05-05 21:44:29.468+08	30	Ningxia	2	Changed provtype.	16	1
576	2018-05-05 21:45:06.303+08	33	Hong Kong Special Administrative Region	2	Changed provname.	16	1
577	2018-05-05 21:45:20.685+08	33	Hong Kong	2	Changed provname and provtype.	16	1
578	2018-05-05 21:45:28.408+08	34	Macau	2	Changed provtype.	16	1
579	2018-05-05 21:45:41.234+08	32	Taiwan	2	Changed provtype.	16	1
580	2018-05-05 21:46:23.851+08	1	Beijing	2	Changed provpopulation.	16	1
581	2018-05-05 21:46:42.244+08	2	Shanghai	2	Changed provpopulation.	16	1
582	2018-05-05 21:47:20.827+08	3	Tianjin	2	Changed provpopulation.	16	1
583	2018-05-05 21:47:41.677+08	4	Hebei	2	Changed provpopulation.	16	1
584	2018-05-05 21:48:02.446+08	5	Shanxi	2	Changed provpopulation.	16	1
585	2018-05-05 21:48:20.888+08	6	Inner Mongolia	2	Changed provpopulation.	16	1
586	2018-05-05 21:48:32.393+08	20	Guangxi	2	Changed provname and provtype.	16	1
587	2018-05-05 21:48:45.589+08	7	Liaoning	2	Changed provpopulation.	16	1
588	2018-05-05 21:48:57.695+08	8	Jilin	2	Changed provpopulation.	16	1
589	2018-05-05 21:49:13.265+08	9	Heilongjiang	2	Changed provpopulation.	16	1
590	2018-05-05 21:49:30.861+08	10	Jiangsu	2	Changed provpopulation.	16	1
591	2018-05-05 21:50:13.017+08	11	Zhejiang	2	Changed provpopulation.	16	1
592	2018-05-05 21:50:40.249+08	12	Anhui	2	Changed provpopulation.	16	1
593	2018-05-05 21:54:46.252+08	13	Fujian	2	Changed provpopulation.	16	1
594	2018-05-05 21:55:02.752+08	14	Jiangxi	2	Changed provpopulation.	16	1
595	2018-05-05 21:55:32.312+08	15	Shandong	2	Changed provpopulation.	16	1
596	2018-05-05 21:55:47.516+08	16	Henan	2	Changed provpopulation.	16	1
597	2018-05-05 21:56:06.213+08	17	Hubei	2	Changed provpopulation.	16	1
598	2018-05-05 21:56:26.986+08	18	Hunan	2	Changed provpopulation.	16	1
599	2018-05-05 21:56:42.534+08	19	Guangdong	2	Changed provpopulation.	16	1
600	2018-05-05 21:56:56.777+08	20	Guangxi	2	Changed provpopulation.	16	1
601	2018-05-05 21:57:09.893+08	21	Hainan	2	Changed provpopulation.	16	1
602	2018-05-05 21:57:27.614+08	22	Chongqing	2	Changed provpopulation.	16	1
603	2018-05-05 21:57:41.355+08	23	Sichuan	2	Changed provpopulation.	16	1
604	2018-05-05 21:57:54.425+08	24	Guizhou	2	Changed provpopulation.	16	1
605	2018-05-05 21:58:07.211+08	25	Yunnan	2	Changed provpopulation.	16	1
606	2018-05-05 21:58:20.168+08	26	Tibet	2	Changed provpopulation.	16	1
607	2018-05-05 21:58:34.704+08	27	Shaanxi	2	Changed provpopulation.	16	1
608	2018-05-05 21:58:48.501+08	28	Gansu	2	Changed provpopulation.	16	1
609	2018-05-05 21:59:11.017+08	29	Qinghai	2	Changed provpopulation.	16	1
610	2018-05-05 21:59:26.457+08	30	Ningxia	2	Changed provpopulation.	16	1
611	2018-05-05 21:59:39.028+08	31	Xinjiang	2	Changed provpopulation.	16	1
612	2018-05-05 22:00:12.283+08	33	Hong Kong	2	Changed provpopulation.	16	1
613	2018-05-05 22:00:28.64+08	34	Macau	2	Changed provpopulation.	16	1
614	2018-05-05 22:02:19.172+08	32	Taiwan	2	Changed provtype.	16	1
615	2018-05-06 13:19:05.277+08	32	Hefei	2	Changed cityfulldesc2, province, qsno1highlight, visible and slug.	7	1
616	2018-05-06 13:19:33.939+08	32	Hefei	2	Changed visible.	7	1
617	2018-05-06 14:23:23.109+08	19	Xi'an Railway Station	1		14	1
618	2018-05-06 14:23:56.002+08	20	Xi'an North Railway Station	1		14	1
619	2018-05-06 14:24:03.816+08	20	Xi'an North Railway Station	2	Changed transporttype.	14	1
620	2018-05-06 14:24:43.715+08	21	Xi'an Xianyang International Airport	1		14	1
621	2018-05-06 14:25:26.015+08	22	Guilin Railway Station	1		14	1
622	2018-05-06 14:25:43.081+08	23	Guilin North Railway Station	1		14	1
623	2018-05-06 14:26:08.314+08	24	Guilin Liangjiang International Airport	1		14	1
624	2018-05-06 14:27:08.561+08	25	Nanjing Railway Station	1		14	1
625	2018-05-06 14:27:26.898+08	26	Nanjing South Railway Station	1		14	1
626	2018-05-06 14:27:46.494+08	27	Nanjing Lukou International Airport	1		14	1
627	2018-05-06 14:28:16.266+08	28	Hankou Railway Station	1		14	1
628	2018-05-06 14:28:35.653+08	29	Wuchang Railway Station	1		14	1
629	2018-05-06 14:28:56.472+08	30	Wuhan Railway Station	1		14	1
630	2018-05-06 14:29:20.913+08	31	Wuhan Tianhe International Airport	1		14	1
631	2018-05-06 14:29:44.983+08	32	Tianjin Railway Station	1		14	1
632	2018-05-06 14:30:01.649+08	33	Tianjin West Railway Station	1		14	1
633	2018-05-06 14:30:21.431+08	34	Tianjin North Railway Station	1		14	1
634	2018-05-06 14:30:57.599+08	35	Tianjin Binhai International Airport	1		14	1
635	2018-05-06 14:31:33.196+08	36	Xiamen Railway Station	1		14	1
636	2018-05-06 14:31:51.263+08	37	Xiamen North Railway Station	1		14	1
637	2018-05-06 14:32:12.272+08	38	Xiamen Gaoqi International Airport	1		14	1
638	2018-05-06 14:33:21.174+08	39	Fuzhou (North) Railway Station	1		14	1
639	2018-05-06 14:33:41.133+08	40	Fuzhou South Railway Station	1		14	1
640	2018-05-06 14:34:05.035+08	41	Fuzhou Changle International Airport	1		14	1
641	2018-05-06 14:34:30.503+08	42	Hangzhou Railway Station	1		14	1
642	2018-05-06 14:34:49.441+08	43	Hangzhou East Railway Station	1		14	1
643	2018-05-06 14:35:16.873+08	44	Hangzhou Xiaoshan International Airport	1		14	1
644	2018-05-06 14:35:36.968+08	45	Suzhou Railway Station	1		14	1
645	2018-05-06 14:35:54.211+08	46	Suzhou North Railway Station	1		14	1
646	2018-05-06 14:36:23.483+08	47	Suzhou Shuofang International Airport	1		14	1
647	2018-05-06 14:36:43.122+08	48	Ningbo Railway Station	1		14	1
648	2018-05-06 14:37:02.186+08	49	Ningbo Lishe International Airport	1		14	1
649	2018-05-06 14:37:24.668+08	50	Zhengzhou Railway Station	1		14	1
650	2018-05-06 14:37:44.095+08	51	Zhengzhou East Railway Station	1		14	1
651	2018-05-06 14:38:05.39+08	52	Zhengzhou Xinzheng International Airport	1		14	1
652	2018-05-06 14:38:35.7+08	53	Jinan Railway Station	1		14	1
653	2018-05-06 14:38:53.27+08	54	Jinan West Railway Station	1		14	1
654	2018-05-06 14:39:20.402+08	55	Jinan Yaoqiang International Airport	1		14	1
655	2018-05-06 14:39:44.968+08	56	Taiyuan South Railway Station	1		14	1
656	2018-05-06 14:40:03.595+08	57	Taiyuan Wusu Airport	1		14	1
657	2018-05-06 14:40:23.551+08	58	Dalian Railway Station	1		14	1
658	2018-05-06 14:40:39.552+08	59	Dalian North Railway Station	1		14	1
659	2018-05-06 14:40:56.775+08	60	Dalian Zhoushuizi International Airport	1		14	1
660	2018-05-06 14:41:44.478+08	61	Jilin International Airport	1		14	1
661	2018-05-06 14:42:04.583+08	62	Harbin Railway Station	1		14	1
662	2018-05-06 14:42:23.423+08	63	Harbin West Railway Station	1		14	1
663	2018-05-06 14:42:44.267+08	64	Harbin East Railway Station	1		14	1
664	2018-05-06 14:43:10.471+08	65	Harbin Taiping International Airport	1		14	1
665	2018-05-06 14:43:28.505+08	66	Lanzhou Railway Station	1		14	1
666	2018-05-06 14:43:52.951+08	67	Lanzhou West Railway Station	1		14	1
667	2018-05-06 14:44:06.841+08	68	Lanzhou Airport	1		14	1
668	2018-05-06 14:44:22.544+08	69	Changsha Railway Station	1		14	1
669	2018-05-06 14:44:38.233+08	70	Changsha South Railway Station	1		14	1
670	2018-05-06 14:44:59.426+08	71	Changsha Huanghua International Airport	1		14	1
671	2018-05-06 14:45:27.801+08	72	Hohhot Railway Station	1		14	1
672	2018-05-06 14:45:52.834+08	73	Hohhot Baita International Airport	1		14	1
673	2018-05-06 14:46:26.554+08	74	Nanning Railway Station	1		14	1
674	2018-05-06 14:46:48.171+08	75	Nanning Wuxu International Airport	1		14	1
675	2018-05-06 14:47:52.887+08	76	Nanchang Railway Station	1		14	1
676	2018-05-06 14:48:15.314+08	77	Nanchang Changbei International Airport	1		14	1
677	2018-05-06 14:48:49.043+08	78	Urumqi Railway Station	1		14	1
678	2018-05-06 14:49:18.527+08	79	Urumqi South Railway Station	1		14	1
679	2018-05-06 14:49:50.83+08	80	Urumqi Diwopu International Airport	1		14	1
680	2018-05-06 14:51:04.984+08	81	Kunming Railway Station	1		14	1
681	2018-05-06 14:51:24.547+08	82	Kunming North Railway Station	1		14	1
682	2018-05-06 14:51:57.281+08	83	Kunming South Railway Station	1		14	1
683	2018-05-06 14:52:18.986+08	84	Kunming Changshui International Airport	1		14	1
684	2018-05-06 14:52:38.289+08	85	Dali Railway Station	1		14	1
685	2018-05-06 14:52:57.622+08	86	Dali Airport	1		14	1
686	2018-05-06 14:53:42.464+08	87	Lijiang Railway Station	1		14	1
687	2018-05-06 14:54:00.151+08	88	Lijiang Airport	1		14	1
688	2018-05-06 16:38:23.581+08	5	Metro	1		13	1
689	2018-05-06 16:38:52.037+08	6	Metro	1		13	1
690	2018-05-06 16:39:06.845+08	7	Metro	1		13	1
691	2018-05-06 16:39:19.975+08	8	Metro	1		13	1
692	2018-05-06 16:39:32.359+08	9	Metro	1		13	1
693	2018-05-06 16:39:46.556+08	10	Metro	1		13	1
694	2018-05-06 16:40:06.865+08	11	Metro	1		13	1
695	2018-05-06 16:40:16.182+08	12	Metro	1		13	1
696	2018-05-06 16:40:27.205+08	13	Metro	1		13	1
697	2018-05-06 16:40:35.284+08	14	Metro	1		13	1
698	2018-05-06 16:40:46.672+08	15	Metro	1		13	1
699	2018-05-06 16:40:58.18+08	16	Metro	1		13	1
700	2018-05-06 16:41:10.728+08	17	Metro	1		13	1
701	2018-05-06 16:41:24.208+08	18	Metro	1		13	1
702	2018-05-06 16:41:37.347+08	19	Metro	1		13	1
703	2018-05-06 16:41:49.938+08	20	Metro	1		13	1
704	2018-05-06 16:41:58.19+08	21	Metro	1		13	1
705	2018-05-06 16:42:16.052+08	22	Metro	1		13	1
706	2018-05-06 16:42:34.381+08	23	Metro	1		13	1
707	2018-05-06 16:42:46.82+08	24	Metro	1		13	1
708	2018-05-06 16:42:56.517+08	25	Metro	1		13	1
709	2018-05-06 16:43:06.065+08	26	Metro	1		13	1
710	2018-05-06 16:43:17.388+08	27	Metro	1		13	1
711	2018-05-06 16:43:25.91+08	28	Metro	1		13	1
712	2018-05-06 16:43:47.97+08	29	Metro	1		13	1
713	2018-05-06 16:43:59.355+08	30	Metro	1		13	1
714	2018-05-06 16:44:09.788+08	31	Metro	1		13	1
715	2018-05-06 16:44:23.279+08	32	Metro	1		13	1
716	2018-05-06 16:44:33.787+08	33	Metro	1		13	1
717	2018-05-06 16:44:46.338+08	34	Metro	1		13	1
718	2018-05-06 16:45:04.402+08	35	Metro	1		13	1
719	2018-05-06 16:45:29.625+08	36	Metro	1		13	1
720	2018-05-06 17:01:45.573+08	37	Bus	1		13	1
721	2018-05-06 17:01:53.825+08	38	Taxi	1		13	1
722	2018-05-06 17:02:19.307+08	6	Beijing	2	Changed transportvisible.	7	1
723	2018-05-06 17:03:06.954+08	6	Beijing	2	Changed transportvisible.	7	1
724	2018-05-06 17:03:36.793+08	39	Taxi	1		13	1
725	2018-05-06 17:03:48.272+08	40	Bus	1		13	1
726	2018-05-06 17:04:02.596+08	41	Taxi	1		13	1
727	2018-05-06 17:04:15.002+08	42	Bus	1		13	1
728	2018-05-06 17:04:31.002+08	43	Taxi	1		13	1
729	2018-05-06 17:04:42.776+08	44	Bus	1		13	1
730	2018-05-06 17:04:55.305+08	45	Taxi	1		13	1
731	2018-05-06 17:05:02.747+08	46	Bus	1		13	1
732	2018-05-06 17:05:16.047+08	47	Taxi	1		13	1
733	2018-05-06 17:05:22.5+08	48	Bus	1		13	1
734	2018-05-06 17:05:31.943+08	49	Taxi	1		13	1
735	2018-05-06 17:05:42.517+08	50	Bus	1		13	1
736	2018-05-06 17:05:53.826+08	51	Taxi	1		13	1
737	2018-05-06 17:06:02.935+08	52	Bus	1		13	1
738	2018-05-06 17:06:17.506+08	53	Taxi	1		13	1
739	2018-05-06 17:06:26.105+08	54	Bus	1		13	1
740	2018-05-06 17:06:41.879+08	55	Taxi	1		13	1
741	2018-05-06 17:06:50.308+08	56	Bus	1		13	1
742	2018-05-06 17:07:04.447+08	57	Taxi	1		13	1
743	2018-05-06 17:07:11.543+08	58	Bus	1		13	1
744	2018-05-06 17:07:25.293+08	59	Taxi	1		13	1
745	2018-05-06 17:07:33.204+08	60	Bus	1		13	1
746	2018-05-06 17:07:47.13+08	61	Taxi	1		13	1
747	2018-05-06 17:07:57.54+08	62	Bus	1		13	1
748	2018-05-06 17:08:19.397+08	63	Taxi	1		13	1
749	2018-05-06 17:08:31.981+08	64	Bus	1		13	1
750	2018-05-06 17:08:49.049+08	65	Taxi	1		13	1
752	2018-05-06 17:09:25.399+08	67	Taxi	1		13	1
753	2018-05-06 17:09:33.654+08	68	Bus	1		13	1
754	2018-05-06 17:09:44.733+08	69	Taxi	1		13	1
755	2018-05-06 17:09:51.707+08	70	Bus	1		13	1
756	2018-05-06 17:10:06.384+08	71	Taxi	1		13	1
757	2018-05-06 17:10:15.599+08	72	Bus	1		13	1
758	2018-05-06 17:10:27.228+08	73	Taxi	1		13	1
759	2018-05-06 17:10:37.247+08	74	Bus	1		13	1
760	2018-05-06 17:10:59.116+08	75	Taxi	1		13	1
761	2018-05-06 17:11:07.072+08	76	Bus	1		13	1
762	2018-05-06 17:11:20.05+08	77	Taxi	1		13	1
763	2018-05-06 17:11:30.249+08	78	Bus	1		13	1
764	2018-05-06 17:11:50.75+08	79	Taxi	1		13	1
765	2018-05-06 17:12:11.012+08	80	Bus	1		13	1
766	2018-05-06 17:12:26.002+08	81	Taxi	1		13	1
767	2018-05-06 17:12:38.131+08	82	Bus	1		13	1
768	2018-05-06 17:18:43.401+08	5	Metro	2	Changed transportdetails.	13	1
769	2018-05-06 17:19:49.845+08	6	Metro	2	Changed transportdetails.	13	1
770	2018-05-06 17:21:24.835+08	7	Metro	2	Changed transportdetails.	13	1
771	2018-05-06 17:22:29.834+08	8	Metro	2	Changed transportdetails.	13	1
772	2018-05-06 17:23:35.399+08	9	Metro	2	Changed transportdetails.	13	1
773	2018-05-06 17:24:32.96+08	10	Metro	2	Changed transportdetails.	13	1
774	2018-05-06 17:25:25.664+08	11	Metro	2	Changed transportdetails.	13	1
775	2018-05-06 17:26:48.467+08	12	Metro	2	Changed transportdetails.	13	1
776	2018-05-06 17:28:16.625+08	13	Metro	2	Changed transportdetails.	13	1
777	2018-05-06 17:29:09.947+08	14	Metro	2	Changed transportdetails.	13	1
778	2018-05-06 17:29:59.189+08	15	Metro	2	Changed transportdetails.	13	1
779	2018-05-06 17:30:58.097+08	16	Metro	2	Changed transportdetails.	13	1
780	2018-05-06 17:32:40.074+08	17	Metro	2	Changed transportdetails.	13	1
781	2018-05-06 17:33:38.202+08	18	Metro	2	Changed transportdetails.	13	1
782	2018-05-06 17:34:31.468+08	19	Metro	2	Changed transportdetails.	13	1
783	2018-05-06 17:35:24.365+08	20	Metro	2	Changed transportdetails.	13	1
784	2018-05-06 17:36:13.445+08	21	Metro	2	Changed transportdetails.	13	1
785	2018-05-06 17:37:26+08	22	Metro	2	Changed transportdetails.	13	1
786	2018-05-06 17:38:39.727+08	23	Metro	2	Changed transportdetails.	13	1
787	2018-05-06 17:39:34.161+08	24	Metro	2	Changed transportdetails.	13	1
788	2018-05-06 17:40:35.7+08	25	Metro	2	Changed transportdetails.	13	1
789	2018-05-06 17:41:37.446+08	26	Metro	2	Changed transportdetails.	13	1
790	2018-05-06 17:42:32.412+08	27	Metro	2	Changed transportdetails.	13	1
791	2018-05-06 17:43:20.863+08	28	Metro	2	Changed transportdetails.	13	1
792	2018-05-06 17:44:07.988+08	29	Metro	2	Changed transportdetails.	13	1
793	2018-05-06 17:45:02.055+08	30	Metro	2	Changed transportdetails.	13	1
794	2018-05-06 17:47:18.172+08	31	Metro	2	Changed transportdetails.	13	1
795	2018-05-06 17:47:58.156+08	32	Metro	2	Changed transportdetails.	13	1
796	2018-05-06 17:48:35.303+08	33	Metro	2	Changed transportdetails.	13	1
797	2018-05-06 17:49:11.99+08	34	Metro	2	Changed transportdetails.	13	1
798	2018-05-06 17:50:15.096+08	35	Metro	2	Changed transportdetails.	13	1
799	2018-05-06 17:52:15.455+08	36	Metro	2	Changed transportdetails.	13	1
800	2018-05-06 17:53:02.824+08	69	Shenzhen 	2	Changed transportvisible.	7	1
801	2018-05-06 17:53:49.295+08	7	Metro	3		13	1
802	2018-05-06 17:55:58.77+08	40	Bus	2	Changed transportdetails.	13	1
803	2018-05-06 19:15:01.042+08	37	Bus	2	Changed transportdetails.	13	1
804	2018-05-06 19:16:25.564+08	38	Taxi	2	Changed transportdetails.	13	1
805	2018-05-06 19:18:24.337+08	48	Bus	2	Changed transportdetails.	13	1
806	2018-05-06 19:56:20.961+08	88	Lijiang Sanyi International Airport	2	Changed transportname and transportdetails.	14	1
807	2018-05-06 20:00:25.166+08	87	Lijiang Railway Station	2	Changed transportdetails.	14	1
808	2018-05-06 20:01:46.079+08	87	Lijiang Railway Station	2	Changed transportdetails.	14	1
809	2018-05-06 20:05:15.935+08	86	Dali Airport	2	Changed transportdetails.	14	1
810	2018-05-06 22:21:40.404+08	64	Shanghai	2	Changed accommodationfulldesc.	7	1
811	2018-05-06 22:21:51.711+08	64	Shanghai	2	No fields changed.	7	1
812	2018-05-06 23:01:54.797+08	1	CityWeather object	1		17	1
813	2018-05-06 23:04:40.561+08	2	CityWeather object	1		17	1
814	2018-05-06 23:05:29.722+08	3	CityWeather object	1		17	1
815	2018-05-06 23:06:08.37+08	4	CityWeather object	1		17	1
816	2018-05-06 23:06:35.711+08	5	CityWeather object	1		17	1
817	2018-05-06 23:07:22.051+08	6	CityWeather object	1		17	1
818	2018-05-06 23:07:53.752+08	7	CityWeather object	1		17	1
819	2018-05-06 23:08:27.892+08	8	CityWeather object	1		17	1
820	2018-05-06 23:09:28.015+08	9	CityWeather object	1		17	1
821	2018-05-06 23:10:00.86+08	10	CityWeather object	1		17	1
822	2018-05-06 23:10:31.776+08	11	CityWeather object	1		17	1
823	2018-05-06 23:11:25.568+08	12	CityWeather object	1		17	1
824	2018-05-06 23:12:01.17+08	13	CityWeather object	1		17	1
825	2018-05-07 22:34:43.395+08	13	Dali	2	Changed weathervisible.	7	1
826	2018-05-07 23:15:35.558+08	13	Dali	2	Changed transportoutervisible.	7	1
827	2018-05-07 23:35:01.746+08	13	Dali	2	Changed accommodationfulldesc.	7	1
828	2018-05-07 23:35:42.273+08	6	Beijing	2	Changed transportvisible.	7	1
829	2018-05-07 23:35:53.198+08	26	Guangzhou	2	Changed transportvisible.	7	1
830	2018-05-07 23:36:03.109+08	84	Xi'an	2	Changed transportvisible and transportoutervisible.	7	1
831	2018-05-07 23:37:15.331+08	27	Guilin	2	Changed transportvisible and transportoutervisible.	7	1
832	2018-05-07 23:37:26.447+08	11	Chengdu	2	Changed transportvisible and transportoutervisible.	7	1
833	2018-05-07 23:37:36.329+08	12	Chongqing	2	Changed transportvisible and transportoutervisible.	7	1
834	2018-05-07 23:37:45.989+08	13	Dali	2	Changed transportvisible.	7	1
835	2018-05-07 23:37:56.401+08	90	Yangshuo	2	Changed transportvisible and transportoutervisible.	7	1
836	2018-05-07 23:38:06.384+08	83	Xiamen	2	Changed transportvisible and transportoutervisible.	7	1
837	2018-05-07 23:38:16.72+08	80	Wuhan	2	Changed transportvisible and transportoutervisible.	7	1
838	2018-05-07 23:40:25.956+08	1	CityWeather object	2	Changed avghigh, avglow, rainmm, raindays and humidity.	17	1
839	2018-05-07 23:40:58.878+08	14	CityWeather object	1		17	1
840	2018-05-07 23:46:58.444+08	15	CityWeather object	1		17	1
841	2018-05-07 23:47:22.423+08	16	CityWeather object	1		17	1
842	2018-05-07 23:47:49.443+08	17	CityWeather object	1		17	1
843	2018-05-07 23:48:13.389+08	18	CityWeather object	1		17	1
844	2018-05-07 23:48:38.898+08	19	CityWeather object	1		17	1
845	2018-05-07 23:49:04.376+08	20	CityWeather object	1		17	1
846	2018-05-07 23:49:27.601+08	21	CityWeather object	1		17	1
847	2018-05-07 23:49:59.388+08	22	CityWeather object	1		17	1
848	2018-05-07 23:50:35.765+08	22	CityWeather object	2	Changed avghigh, avglow, rainmm and raindays.	17	1
849	2018-05-07 23:51:02.907+08	23	CityWeather object	1		17	1
850	2018-05-07 23:51:21.448+08	24	CityWeather object	1		17	1
851	2018-05-07 23:53:55.158+08	13	Dali	2	No fields changed.	7	1
852	2018-05-07 23:54:03.412+08	64	Shanghai	2	Changed weathervisible.	7	1
853	2018-05-13 17:06:48.3+08	25	CityWeather object	1		17	1
854	2018-05-13 17:07:13.71+08	26	CityWeather object	1		17	1
855	2018-05-13 17:07:35.029+08	27	CityWeather object	1		17	1
856	2018-05-13 17:07:58.019+08	28	CityWeather object	1		17	1
857	2018-05-13 17:08:15.596+08	29	CityWeather object	1		17	1
858	2018-05-13 17:08:56.077+08	29	CityWeather object	2	No fields changed.	17	1
859	2018-05-13 17:09:22.694+08	30	CityWeather object	1		17	1
860	2018-05-13 17:09:47.698+08	31	CityWeather object	1		17	1
861	2018-05-13 17:10:10.167+08	32	CityWeather object	1		17	1
862	2018-05-13 17:10:28.264+08	33	CityWeather object	1		17	1
863	2018-05-13 17:10:51.042+08	34	CityWeather object	1		17	1
864	2018-05-13 17:11:10.477+08	35	CityWeather object	1		17	1
865	2018-05-13 17:12:08.558+08	36	CityWeather object	1		17	1
866	2018-05-13 17:12:43.011+08	37	CityWeather object	1		17	1
867	2018-05-13 17:13:01.814+08	38	CityWeather object	1		17	1
868	2018-05-13 17:13:26.266+08	39	CityWeather object	1		17	1
869	2018-05-13 17:13:55.54+08	40	CityWeather object	1		17	1
870	2018-05-13 17:14:20.595+08	41	CityWeather object	1		17	1
871	2018-05-13 17:14:53.367+08	42	CityWeather object	1		17	1
872	2018-05-13 17:15:12.912+08	43	CityWeather object	1		17	1
873	2018-05-13 17:15:38.652+08	44	CityWeather object	1		17	1
874	2018-05-13 17:16:01.002+08	45	CityWeather object	1		17	1
875	2018-05-13 17:16:29.215+08	46	CityWeather object	1		17	1
876	2018-05-13 17:16:51.003+08	47	CityWeather object	1		17	1
877	2018-05-13 17:17:11.844+08	48	CityWeather object	1		17	1
878	2018-05-13 17:18:11.662+08	49	CityWeather object	1		17	1
879	2018-05-13 17:18:32.587+08	50	CityWeather object	1		17	1
880	2018-05-13 17:18:52.135+08	51	CityWeather object	1		17	1
881	2018-05-13 17:19:12.542+08	52	CityWeather object	1		17	1
882	2018-05-13 17:19:39.777+08	53	CityWeather object	1		17	1
883	2018-05-13 17:20:15.249+08	54	CityWeather object	1		17	1
884	2018-05-13 17:20:38.949+08	55	CityWeather object	1		17	1
885	2018-05-13 17:21:20.649+08	56	CityWeather object	1		17	1
886	2018-05-13 17:21:44.611+08	57	CityWeather object	1		17	1
887	2018-05-13 17:22:05.475+08	58	CityWeather object	1		17	1
888	2018-05-13 17:22:33.915+08	59	CityWeather object	1		17	1
889	2018-05-13 17:23:01.712+08	60	CityWeather object	1		17	1
890	2018-05-13 17:23:36.203+08	61	CityWeather object	1		17	1
891	2018-05-13 17:24:31.103+08	62	CityWeather object	1		17	1
892	2018-05-13 17:24:47.763+08	63	CityWeather object	1		17	1
893	2018-05-13 17:25:04.111+08	64	CityWeather object	1		17	1
894	2018-05-13 17:25:27.79+08	65	CityWeather object	1		17	1
895	2018-05-13 17:25:57.051+08	66	CityWeather object	1		17	1
896	2018-05-13 17:26:14.606+08	67	CityWeather object	1		17	1
897	2018-05-13 17:26:34.901+08	68	CityWeather object	1		17	1
898	2018-05-13 17:26:55.259+08	69	CityWeather object	1		17	1
899	2018-05-13 17:27:12.259+08	70	CityWeather object	1		17	1
900	2018-05-13 17:27:28.337+08	71	CityWeather object	1		17	1
901	2018-05-13 17:27:47.182+08	72	CityWeather object	1		17	1
902	2018-05-13 17:28:04.207+08	73	CityWeather object	1		17	1
903	2018-05-13 17:28:17.835+08	74	CityWeather object	1		17	1
904	2018-05-13 17:28:38.501+08	75	CityWeather object	1		17	1
905	2018-05-13 17:28:55.275+08	76	CityWeather object	1		17	1
906	2018-05-13 17:29:13.531+08	77	CityWeather object	1		17	1
907	2018-05-13 17:29:31.181+08	78	CityWeather object	1		17	1
908	2018-05-13 17:29:51.718+08	79	CityWeather object	1		17	1
909	2018-05-13 17:30:10.084+08	80	CityWeather object	1		17	1
910	2018-05-13 17:30:27.308+08	81	CityWeather object	1		17	1
911	2018-05-13 17:30:46.493+08	82	CityWeather object	1		17	1
912	2018-05-13 17:31:04.677+08	83	CityWeather object	1		17	1
913	2018-05-13 17:31:30.298+08	84	CityWeather object	1		17	1
914	2018-05-13 17:31:52.471+08	85	CityWeather object	1		17	1
915	2018-05-13 17:32:03.555+08	85	CityWeather object	2	Changed weathercity.	17	1
916	2018-05-13 17:32:22.829+08	86	CityWeather object	1		17	1
917	2018-05-13 17:32:37.108+08	87	CityWeather object	1		17	1
918	2018-05-13 17:33:08.435+08	88	CityWeather object	1		17	1
919	2018-05-13 17:33:29.147+08	89	CityWeather object	1		17	1
920	2018-05-13 17:33:49.801+08	90	CityWeather object	1		17	1
921	2018-05-13 17:34:06.221+08	91	CityWeather object	1		17	1
922	2018-05-13 17:34:27.981+08	92	CityWeather object	1		17	1
923	2018-05-13 17:34:46.655+08	93	CityWeather object	1		17	1
924	2018-05-13 17:34:59.191+08	93	CityWeather object	2	No fields changed.	17	1
925	2018-05-13 17:35:22.018+08	94	CityWeather object	1		17	1
926	2018-05-13 17:35:49.322+08	95	CityWeather object	1		17	1
927	2018-05-13 17:36:10.596+08	96	CityWeather object	1		17	1
928	2018-05-13 17:36:29.826+08	97	CityWeather object	1		17	1
929	2018-05-13 17:36:45.631+08	98	CityWeather object	1		17	1
930	2018-05-13 17:37:01.074+08	99	CityWeather object	1		17	1
931	2018-05-13 17:37:24.055+08	100	CityWeather object	1		17	1
932	2018-05-13 17:37:43.381+08	101	CityWeather object	1		17	1
933	2018-05-13 17:38:02.611+08	102	CityWeather object	1		17	1
934	2018-05-13 17:38:24.511+08	103	CityWeather object	1		17	1
935	2018-05-13 17:38:49.041+08	104	CityWeather object	1		17	1
936	2018-05-13 17:39:11.44+08	105	CityWeather object	1		17	1
937	2018-05-13 17:39:28.165+08	106	CityWeather object	1		17	1
938	2018-05-13 17:39:52.72+08	106	CityWeather object	2	No fields changed.	17	1
939	2018-05-13 17:40:11.048+08	107	CityWeather object	1		17	1
940	2018-05-13 17:40:29.883+08	108	CityWeather object	1		17	1
941	2018-05-13 17:40:48.756+08	6	Beijing	2	Changed weathervisible.	7	1
942	2018-05-13 17:40:59.475+08	69	Shenzhen 	2	Changed weathervisible.	7	1
943	2018-05-13 17:41:19.242+08	26	Guangzhou	2	Changed weathervisible.	7	1
944	2018-05-13 17:41:34.239+08	11	Chengdu	2	Changed weathervisible.	7	1
945	2018-05-13 17:41:49.414+08	12	Chongqing	2	Changed weathervisible.	7	1
946	2018-05-13 17:42:05.924+08	84	Xi'an	2	Changed weathervisible.	7	1
947	2018-05-14 23:23:56.996+08	109	CityWeather object	1		17	1
948	2018-05-14 23:24:11.893+08	110	CityWeather object	1		17	1
949	2018-05-14 23:24:27.197+08	111	CityWeather object	1		17	1
950	2018-05-14 23:24:39.922+08	112	CityWeather object	1		17	1
951	2018-05-14 23:24:56.111+08	113	CityWeather object	1		17	1
952	2018-05-14 23:25:12.813+08	114	CityWeather object	1		17	1
953	2018-05-14 23:25:28.158+08	115	CityWeather object	1		17	1
954	2018-05-14 23:25:51.105+08	116	CityWeather object	1		17	1
955	2018-05-14 23:26:11.203+08	117	CityWeather object	1		17	1
956	2018-05-14 23:26:32.818+08	118	CityWeather object	1		17	1
957	2018-05-14 23:26:47.409+08	119	CityWeather object	1		17	1
958	2018-05-14 23:27:05.36+08	120	CityWeather object	1		17	1
959	2018-05-14 23:27:19.247+08	117	CityWeather object	2	Changed weathercity.	17	1
960	2018-05-14 23:27:53.965+08	121	CityWeather object	1		17	1
961	2018-05-14 23:28:11.865+08	122	CityWeather object	1		17	1
962	2018-05-14 23:28:39.03+08	123	CityWeather object	1		17	1
963	2018-05-14 23:28:55.61+08	124	CityWeather object	1		17	1
964	2018-05-14 23:29:12.363+08	125	CityWeather object	1		17	1
965	2018-05-14 23:29:36.362+08	126	CityWeather object	1		17	1
966	2018-05-14 23:29:53.975+08	127	CityWeather object	1		17	1
967	2018-05-14 23:30:10.337+08	128	CityWeather object	1		17	1
968	2018-05-14 23:30:26.276+08	129	CityWeather object	1		17	1
969	2018-05-14 23:30:42.494+08	130	CityWeather object	1		17	1
970	2018-05-14 23:30:58.792+08	131	CityWeather object	1		17	1
971	2018-05-14 23:31:14.276+08	132	CityWeather object	1		17	1
972	2018-05-14 23:31:40.026+08	133	CityWeather object	1		17	1
973	2018-05-14 23:31:55.196+08	134	CityWeather object	1		17	1
974	2018-05-14 23:32:13.143+08	135	CityWeather object	1		17	1
975	2018-05-14 23:32:31.397+08	136	CityWeather object	1		17	1
976	2018-05-14 23:32:52.313+08	137	CityWeather object	1		17	1
977	2018-05-14 23:33:22.616+08	138	CityWeather object	1		17	1
978	2018-05-14 23:33:38.292+08	139	CityWeather object	1		17	1
979	2018-05-14 23:33:58.278+08	140	CityWeather object	1		17	1
980	2018-05-14 23:34:23.878+08	141	CityWeather object	1		17	1
981	2018-05-14 23:34:40.511+08	142	CityWeather object	1		17	1
982	2018-05-14 23:35:04.94+08	143	CityWeather object	1		17	1
983	2018-05-14 23:35:20.809+08	144	CityWeather object	1		17	1
984	2018-05-14 23:36:07.451+08	30	Hangzhou	2	Changed weathervisible.	7	1
985	2018-05-14 23:36:17.766+08	16	Datong	2	Changed weathervisible.	7	1
986	2018-05-14 23:36:27.231+08	14	Dalian	2	Changed weathervisible.	7	1
987	2018-05-15 22:17:40.288+08	89	Dali Railway Station	1		14	1
988	2018-05-15 22:18:19.792+08	90	Hangzhou Xiaoshan International Airport	1		14	1
989	2018-05-15 22:18:54.102+08	91	Hangzhou Railway Station	1		14	1
990	2018-05-15 22:19:16.061+08	92	Hangzhou East Railway Station	1		14	1
991	2018-05-15 22:19:56.679+08	93	Chengdu Shuangliu International Airport	1		14	1
992	2018-05-15 22:20:13.413+08	94	Chengdu Railway Station	1		14	1
993	2018-05-15 22:20:34.063+08	95	Chengdu East Railway Station	1		14	1
994	2018-05-15 22:20:58.168+08	96	Chongqing Jiangbei International Airport	1		14	1
995	2018-05-15 22:21:20.559+08	97	Chongqing Railway Station	1		14	1
996	2018-05-15 22:21:39.678+08	98	Chongqing North Railway Station	1		14	1
997	2018-05-15 22:21:56.625+08	99	Chongqing West Railway Station	1		14	1
998	2018-05-15 22:22:11.84+08	100	Shapingba Railway Station	1		14	1
999	2018-05-15 22:22:56.332+08	85	Dali Railway Station	3		14	1
1000	2018-05-15 22:22:56.486+08	44	Hangzhou Xiaoshan International Airport	3		14	1
1001	2018-05-15 22:22:56.596+08	43	Hangzhou East Railway Station	3		14	1
1002	2018-05-15 22:22:56.717+08	42	Hangzhou Railway Station	3		14	1
1003	2018-05-15 22:23:32.114+08	30	Hangzhou	2	Changed transportoutervisible.	7	1
1004	2018-05-19 12:33:31.892+08	105	Changchun	1		7	1
1005	2018-05-19 12:33:42.737+08	105	Changchun	2	Changed slug.	7	1
1006	2018-05-19 12:34:43.668+08	105	Changchun	2	Changed visible.	7	1
1007	2018-05-19 12:36:46.338+08	8	Changsha 	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, qsno1highlight, visible, eatvisible and coordinates.	7	1
1008	2018-05-19 12:37:34.814+08	8	Changsha 	2	Changed eatsfulldesc.	7	1
1009	2018-05-19 12:39:40.924+08	20	Dunhuang	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, qsno1highlight, eatvisible and coordinates.	7	1
1010	2018-05-19 12:41:04.801+08	24	Fuzhou	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, qsno1highlight and eatvisible.	7	1
1011	2018-05-19 12:42:37.309+08	28	Guiyang	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, qsno1highlight and eatvisible.	7	1
1012	2018-05-19 12:43:56.112+08	29	Haikou	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, qsno1highlight and eatvisible.	7	1
1013	2018-05-19 12:45:23.282+08	63	Sanya	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, qsno1highlight and eatvisible.	7	1
1014	2018-05-19 12:46:13.67+08	32	Hefei	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc and eatvisible.	7	1
1015	2018-05-19 12:46:58.554+08	32	Hefei	2	Changed eatsfulldesc.	7	1
1016	2018-05-19 12:48:11.182+08	33	Hohhot	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, qsno1highlight and eatvisible.	7	1
1017	2018-05-19 12:50:27.046+08	38	Jinan	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, qsno1highlight and eatvisible.	7	1
1018	2018-05-19 12:52:06.976+08	46	Lanzhou	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, qsno1highlight, eatvisible and coordinates.	7	1
1019	2018-05-19 12:54:53.166+08	48	Lhasa	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, province, qsno1highlight, eatvisible and coordinates.	7	1
1020	2018-05-19 12:57:00.655+08	51	Luoyang	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1021	2018-05-19 12:59:04.05+08	54	Nanchang	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, province, qsno1highlight, eatvisible and coordinates.	7	1
1022	2018-05-19 12:59:16.678+08	54	Nanchang	2	Changed slug.	7	1
1023	2018-05-19 13:01:58.086+08	56	Nanning	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, province, qsno1highlight, eatvisible and slug.	7	1
1024	2018-05-19 13:02:19.652+08	56	Nanning	2	Changed coordinates.	7	1
1025	2018-05-19 13:05:06.079+08	68	Shenyang	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1026	2018-05-19 13:07:53.562+08	74	Taiyuan	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, qsno1highlight, eatvisible and coordinates.	7	1
1027	2018-05-19 13:08:46.036+08	74	Taiyuan	2	Changed slug.	7	1
1028	2018-05-19 13:11:04.055+08	85	Xining	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1029	2018-05-19 13:14:46.763+08	106	Yinchuan	1		7	1
1030	2018-05-19 13:18:08.992+08	98	Zhangjiajie	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, province, qspopulation, qsno1highlight, eatvisible, coordinates and slug.	7	1
1031	2018-05-19 13:21:12.202+08	101	Zhengzhou	2	Changed cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, province, qspopulation, qsno1highlight, eatvisible, coordinates and slug.	7	1
1032	2018-05-19 13:25:29.287+08	104	Zhuhai	2	Changed cityfulldesc2, province, qsno1highlight, coordinates and slug.	7	1
1033	2018-05-19 13:26:16.552+08	103	Zhongshan	2	Changed cityfulldesc2, province, qsno1highlight, coordinates and slug.	7	1
1034	2018-05-19 13:27:09.391+08	102	Zhenjiang	2	Changed cityfulldesc2, province, qsno1highlight, coordinates and slug.	7	1
1035	2018-05-19 13:28:03.425+08	100	Zhaoqing	2	Changed cityfulldesc2, province, qsno1highlight and slug.	7	1
1036	2018-05-19 13:29:13.821+08	99	Zhangjiakou	2	Changed cityfulldesc2, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1037	2018-05-19 13:30:15.848+08	97	Yuxi	2	Changed cityfulldesc2, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1038	2018-05-19 13:32:13.745+08	96	Yulin	2	Changed chinesename, cityfulldesc2, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1039	2018-05-19 13:33:19.963+08	95	Yiwu	2	Changed cityfulldesc2, province, qsno1highlight, eatvisible and coordinates.	7	1
1040	2018-05-19 13:34:14.199+08	94	Yichang	2	Changed cityfulldesc2, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1041	2018-05-19 13:35:03.605+08	93	Yibin	2	Changed cityfulldesc2, province, qsno1highlight, coordinates and slug.	7	1
1042	2018-05-19 13:35:56.571+08	92	Yantai	2	Changed cityfulldesc2, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1043	2018-05-19 13:36:58.633+08	18	Dongguan	2	Changed cityfulldesc2, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1044	2018-05-19 13:37:16.78+08	8	Changsha 	2	Changed province.	7	1
1045	2018-05-19 13:38:23.377+08	57	Ningbo	2	Changed cityfulldesc2, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1046	2018-05-19 13:39:18.355+08	63	Sanya	2	Changed province, coordinates and slug.	7	1
1047	2018-05-19 13:40:38.811+08	34	Hong Kong	2	Changed cityfulldesc2, province, qsno1highlight, coordinates and slug.	7	1
1048	2018-05-19 13:41:56.764+08	9	Changzhou	2	Changed cityfulldesc2, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1049	2018-05-19 13:42:43.547+08	31	Harbin	2	Changed cityfulldesc2, province, qsno1highlight, eatvisible, coordinates and slug.	7	1
1050	2018-05-19 13:43:39.485+08	66	Shaoxing	2	Changed cityfulldesc2, province, qsno1highlight, coordinates and slug.	7	1
1051	2018-05-19 13:44:44.725+08	46	Lanzhou	2	Changed province, qspopulation and slug.	7	1
1052	2018-05-19 13:45:47.728+08	24	Fuzhou	2	Changed province, coordinates and slug.	7	1
1053	2018-05-19 13:46:58.059+08	81	Wuxi	2	Changed cityfulldesc2, province, qspopulation, qsno1highlight, eatvisible, coordinates and slug.	7	1
1054	2018-05-19 13:48:40.504+08	37	Jilin City	2	Changed cityfulldesc2, province, qspopulation, qsno1highlight, eatvisible, coordinates and slug.	7	1
1055	2018-05-19 13:50:32.477+08	28	Guiyang	2	Changed province, qspopulation, coordinates and slug.	7	1
1056	2018-05-19 13:52:42.879+08	23	Foshan	2	Changed cityfulldesc2, province, qspopulation, qsno1highlight, eatvisible, coordinates and slug.	7	1
1057	2018-05-19 13:53:57.542+08	91	Yangzhou	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1058	2018-05-19 13:54:08.407+08	89	Yan'an	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1059	2018-05-19 13:54:17.368+08	88	Ya'an	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1060	2018-05-19 13:54:29.51+08	87	Xuzhou	2	Changed cityfulldesc2, qsno1highlight, eatvisible and slug.	7	1
1061	2018-05-19 13:54:46.53+08	86	Xishuangbanna	2	Changed cityfulldesc2, qsno1highlight, eatvisible and slug.	7	1
1062	2018-05-19 13:55:03.017+08	82	Wuyi Shan	2	Changed cityfulldesc2, qsno1highlight, eatvisible and slug.	7	1
1063	2018-05-19 13:55:28.425+08	79	Wudang Shan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1064	2018-05-19 13:55:42.065+08	77	Turpan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1065	2018-05-19 13:55:52.373+08	76	Tongli	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1066	2018-05-19 13:56:05.479+08	73	Taipei 	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1067	2018-05-19 13:56:13.762+08	72	Tai Shan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1068	2018-05-19 13:56:28.678+08	70	Shunde	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1069	2018-05-19 13:56:52.999+08	67	Shennongjia	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1070	2018-05-19 13:57:03.252+08	62	Qujing	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1071	2018-05-19 13:57:13.611+08	61	Qinhuangdao	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1072	2018-05-19 13:57:25.476+08	59	Putuo Shan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1073	2018-05-19 13:57:34.774+08	53	Mogan Shan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1074	2018-05-19 13:57:47.567+08	52	Macau	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1075	2018-05-19 13:58:12.667+08	50	Lu Shan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1076	2018-05-19 13:58:21.806+08	47	Leshan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1077	2018-05-19 13:58:31.401+08	44	Kashgar	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1078	2018-05-19 13:58:42.88+08	43	Kanas Lake	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1079	2018-05-19 13:58:53.549+08	42	Kaifeng	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1080	2018-05-19 13:59:25.385+08	41	Jiuzhaigou-Huanglong	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1081	2018-05-19 13:59:41.063+08	40	Jiuhua Shan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1082	2018-05-19 13:59:54.142+08	39	Jingdezhen	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1083	2018-05-19 14:00:05.615+08	38	Jinan	2	Changed slug.	7	1
1084	2018-05-19 14:00:19.851+08	36	Huang Shan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1085	2018-05-19 14:00:32.202+08	35	Hua Shan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1086	2018-05-19 14:00:44.08+08	33	Hohhot	2	Changed slug.	7	1
1087	2018-05-19 14:01:00.407+08	29	Haikou	2	Changed slug.	7	1
1088	2018-05-19 14:01:25.295+08	25	Guangyuan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1089	2018-05-19 14:01:37.814+08	22	Enshi	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1090	2018-05-19 14:01:50.099+08	21	Emei Shan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1091	2018-05-19 14:02:06.076+08	20	Dunhuang	2	Changed slug.	7	1
1092	2018-05-19 14:02:22.703+08	19	Dujiangyan	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1093	2018-05-19 14:02:35.732+08	17	Dehong	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1094	2018-05-19 14:02:47.205+08	15	Dandong	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1095	2018-05-19 14:03:19.486+08	10	Chengde	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1096	2018-05-19 14:03:28.874+08	7	Bo'ao 	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1097	2018-05-19 14:03:41.025+08	5	Beihai 	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1098	2018-05-19 14:03:56.495+08	4	Baotou 	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1099	2018-05-19 14:04:06.948+08	3	Baoshan 	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1100	2018-05-19 14:04:17.895+08	2	Anyang 	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1101	2018-05-19 14:04:28.495+08	1	Anshun	2	Changed cityfulldesc2, qsno1highlight and slug.	7	1
1102	2018-05-19 14:04:38.27+08	95	Yiwu	2	Changed slug.	7	1
1103	2018-05-19 14:04:48.415+08	8	Changsha 	2	Changed slug.	7	1
1104	2018-05-19 14:04:57.671+08	48	Lhasa	2	Changed slug.	7	1
1105	2018-05-19 14:06:23.864+08	1	Anshun	2	Changed province.	7	1
1106	2018-05-19 14:06:54.476+08	2	Anyang 	2	Changed province.	7	1
1107	2018-05-19 14:07:18.382+08	3	Baoshan 	2	Changed province.	7	1
1108	2018-05-19 14:07:48.995+08	4	Baotou 	2	Changed province.	7	1
1109	2018-05-19 14:08:14.054+08	5	Beihai 	2	Changed province.	7	1
1110	2018-05-19 14:08:43.877+08	7	Bo'ao 	2	Changed province.	7	1
1111	2018-05-19 14:09:13.462+08	10	Chengde	2	Changed province.	7	1
1112	2018-05-19 14:09:38.986+08	15	Dandong	2	Changed province.	7	1
1113	2018-05-19 14:10:13.194+08	16	Datong	2	No fields changed.	7	1
1114	2018-05-19 14:10:51.64+08	91	Yangzhou	2	Changed province.	7	1
1115	2018-05-19 14:11:17.228+08	89	Yan'an	2	Changed province.	7	1
1116	2018-05-19 14:11:42.355+08	88	Ya'an	2	Changed province.	7	1
1117	2018-05-19 14:12:08.134+08	87	Xuzhou	2	Changed province.	7	1
1118	2018-05-19 14:12:33.067+08	86	Xishuangbanna	2	Changed province.	7	1
1119	2018-05-19 14:12:59.75+08	52	Macau	2	Changed province.	7	1
1120	2018-05-19 14:13:12.788+08	36	Huang Shan	2	Changed province.	7	1
1121	2018-05-19 14:13:25.889+08	33	Hohhot	2	Changed province.	7	1
1122	2018-05-19 14:13:43.247+08	43	Kanas Lake	2	Changed province.	7	1
1123	2018-05-19 14:14:05.329+08	29	Haikou	2	Changed province.	7	1
1124	2018-05-19 14:14:20.48+08	77	Turpan	2	Changed province.	7	1
1125	2018-05-19 14:14:33.722+08	73	Taipei 	2	Changed province.	7	1
1126	2018-05-19 14:14:59.231+08	44	Kashgar	2	Changed province.	7	1
1127	2018-05-19 14:15:53.185+08	82	Wuyi Shan	2	Changed province.	7	1
1128	2018-05-19 14:16:21.714+08	79	Wudang Shan	2	Changed province.	7	1
1129	2018-05-19 14:16:48.626+08	76	Tongli	2	Changed province.	7	1
1130	2018-05-19 14:17:18.374+08	72	Tai Shan	2	Changed province.	7	1
1131	2018-05-19 14:17:47.772+08	70	Shunde	2	Changed province.	7	1
1132	2018-05-19 14:18:16.217+08	67	Shennongjia	2	Changed province.	7	1
1133	2018-05-19 14:18:53.733+08	62	Qujing	2	Changed province.	7	1
1134	2018-05-19 14:19:25.331+08	61	Qinhuangdao	2	Changed province.	7	1
1135	2018-05-19 14:20:15.167+08	59	Putuo Shan	2	Changed province.	7	1
1136	2018-05-19 14:20:35.337+08	53	Mogan Shan	2	Changed province.	7	1
1137	2018-05-19 14:20:57.943+08	50	Lu Shan	2	Changed province.	7	1
1138	2018-05-19 14:21:19.939+08	47	Leshan	2	Changed province.	7	1
1139	2018-05-19 14:21:52.499+08	42	Kaifeng	2	Changed province.	7	1
1140	2018-05-19 14:22:22.947+08	41	Jiuzhaigou-Huanglong	2	Changed province.	7	1
1141	2018-05-19 14:23:11.033+08	39	Jingdezhen	2	Changed province.	7	1
1142	2018-05-19 14:23:33.349+08	40	Jiuhua Shan	2	Changed province.	7	1
1143	2018-05-19 14:25:07.356+08	39	Jingdezhen	2	Changed province.	7	1
1144	2018-05-19 14:26:00.536+08	38	Jinan	2	Changed province.	7	1
1145	2018-05-19 14:26:53.655+08	35	Hua Shan	2	Changed province.	7	1
1146	2018-05-19 14:27:23.368+08	25	Guangyuan	2	Changed province.	7	1
1147	2018-05-19 14:27:56.54+08	22	Enshi	2	Changed province.	7	1
1148	2018-05-19 14:29:08.465+08	21	Emei Shan	2	Changed province.	7	1
1149	2018-05-19 14:29:31.177+08	20	Dunhuang	2	Changed province.	7	1
1150	2018-05-19 14:30:21.935+08	19	Dujiangyan	2	Changed province.	7	1
1151	2018-05-19 14:30:48.883+08	17	Dehong	2	Changed province.	7	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	maincontent	city
8	maincontent	attraction
9	maincontent	eat
10	easy_maps	address
11	maincontent	attractionimages
12	maincontent	cityimages
13	maincontent	transport
14	maincontent	transportouter
16	maincontent	province
17	maincontent	cityweather
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-05-20 13:58:02.541606+08
2	auth	0001_initial	2018-05-20 13:58:04.374327+08
3	admin	0001_initial	2018-05-20 13:58:04.741333+08
4	contenttypes	0002_remove_content_type_name	2018-05-20 13:58:04.888934+08
5	auth	0002_alter_permission_name_max_length	2018-05-20 13:58:04.999336+08
6	auth	0003_alter_user_email_max_length	2018-05-20 13:58:05.047336+08
7	auth	0004_alter_user_username_opts	2018-05-20 13:58:05.092342+08
8	auth	0005_alter_user_last_login_null	2018-05-20 13:58:05.134339+08
9	auth	0006_require_contenttypes_0002	2018-05-20 13:58:05.142222+08
10	maincontent	0001_initial	2018-05-20 13:58:08.284813+08
11	maincontent	0002_city_qsprovince	2018-05-20 13:58:08.751853+08
12	sessions	0001_initial	2018-05-20 13:58:08.998112+08
34	maincontent	0003_auto_20180520_1404	2018-05-20 14:09:16.395504+08
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
lw8vxe0bgdy7woqbt1vpe7o3idgyvqfu	NDA3ZTVhMmRhM2E1YmQwMDU3OGU2OTU2ZWVkYTViYTc1MjJiYjQ3OTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NDBlMGJmNGIwZGM4NmFlYzY0MGVmOTQ0MGU4MWM2ZjkyMjQwNDdlIn0=	2018-04-20 14:51:25.691+08
nyomoldqvdezk82uy5r5xgphwtrkovqg	NDA3ZTVhMmRhM2E1YmQwMDU3OGU2OTU2ZWVkYTViYTc1MjJiYjQ3OTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NDBlMGJmNGIwZGM4NmFlYzY0MGVmOTQ0MGU4MWM2ZjkyMjQwNDdlIn0=	2018-05-04 23:35:00.854+08
pz4dyn24s2pvkijyojstnuowid25nglm	NDA3ZTVhMmRhM2E1YmQwMDU3OGU2OTU2ZWVkYTViYTc1MjJiYjQ3OTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NDBlMGJmNGIwZGM4NmFlYzY0MGVmOTQ0MGU4MWM2ZjkyMjQwNDdlIn0=	2018-05-19 15:05:44.014+08
\.


--
-- Data for Name: maincontent_attraction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maincontent_attraction (id, attname, attshortdesc, attfulldesc, atttime, attcostadult, attcostchild, attthumbnail_path, visible, howtogo, howtogovsible, slug, cityslug, attcity_id) FROM stdin;
1	Longhua Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
2	Jin Mao Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	jin-mao-tower	shanghai	64
3	Cite Bourgogne	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
4	Nanjing Road	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	nanjing-road	shanghai	64
5	Shanghai Chenghuang Miao (City God Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
6	Oriental Pearl TV Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	oriental-pearl-tv-tower	shanghai	64
7	People's Square (Shanghai)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	peoples-square-shanghai	shanghai	64
8	The Bund	Some info about this attraction	The Bund or Waitan (Chinese: 外滩; pinyin: Wàitān, Shanghainese: nga3thae1, literally: "Outer Beach") is a waterfront area in central Shanghai. The area centers on a section of Zhongshan Road (East-1 Zhongshan Road) within the former Shanghai International Settlement, which runs along the western bank of the Huangpu River in the eastern part of Huangpu District. The area along the river faces the modern skyscrapers of Lujiazui in the Pudong District. The Bund usually refers to the buildings and wharves on this section of the road, as well as some adjacent areas. It is one of the most famous tourist destinations in Shanghai. Building heights are restricted in the area.	Time Goes Here	120	15	images/city/Shanghai/The Bund/banner.jpg	t	This is how to get here	t	the-bund	shanghai	64
9	Yu Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	yu-garden-yuyuan	shanghai	64
10	Qibao Old Street (Qibao Ancient Town)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	qibao-old-street-qibao-ancient-town	shanghai	64
11	Jade Buddha Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	jade-buddha-temple	shanghai	64
12	Xintiandi	Rebuild old-style Shanghai houses now housing a lifestyle hub.	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	xintiandi	shanghai	64
13	Shanghai Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
14	Huaihai Lu (Huaihai Road)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
15	Jing'an Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	jingan-temple	shanghai	64
16	Memorial Hall of Artist Zhang Chongren (Qibao)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
17	Lupu Bridge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
18	Tianzifang	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	tianzifang	shanghai	64
19	Moganshan Lu (M50 Galleries)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
20	Lu Xun Park (Hongkou Park)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
21	Shanghai Propaganda Poster Art Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
22	Zendai Museum of Modern Art	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
23	Shanghai Botanical Gardens	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
24	Shanghai Urban Planning Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	shanghai-urban-planning-museum	shanghai	64
25	Shanghai Science and Technology Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	shanghai-science-and-technology-museum	shanghai	64
26	Duolun Museum of Modern Art	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
27	French Concession	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
28	Shanghai Old City	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
29	Zhujiajiao	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	zhujiajiao	shanghai	64
30	Sheshan National Tourism Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
31	Shanghai World Financial Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
32	Yuyintang Livehouse	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
33	Century Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
34	Zhou's Miniature Carving House (Qibao)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
35	Hu Xi Mosque	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
36	Shanghai Friday Muslim Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
37	Shanghai Food Street: Yunnan Nan Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
38	Zhongshan Park (Shanghai)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
39	Dino Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
40	Shanghai Food Street: Wujiang Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
41	Shanghai MOCA (Museum of Contemporary Art)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
42	Shanghai Arts and Crafts Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
43	Madame Tussauds Shanghai	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
44	SMP Skate Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
45	Yinqixing Indoor Ski Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
46	Zhou Enlai Residence	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
47	Qizhong Forest Sports City Arena	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
48	Shanghai Modern Military Sports Club	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
49	Songjiang Square Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
50	Shanghai Grand Theatre	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
51	Fuxing Park (Fuxing Gongyuan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
52	Art Labor Gallery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
53	Shanghai International Convention Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
54	Shanghai Jewish Refugees Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
55	Jinshan Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
56	Shaoxing Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
57	Jinxian Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
58	Dagu Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
59	Fuxing Island	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
60	Daning Lingshi Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
61	Gongqing Forest Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
62	Longhua Cemetery of Revolutionary Martyrs	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
63	Tongchuan Lu Seafood Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
64	Shanghai Wild Insect Kingdom	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
65	Changfeng Ocean World (Aquarium)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
66	Shanghai Ocean Aquarium	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
67	Shanghai Library	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
68	Shanghai Wild Animal Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
69	1933 (Old Slaughterhouse)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
70	Shanghai Postal Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
71	St Ignatius (Xujiahui) Cathedral	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
72	Guangqi Park (Tomb of Paul Guangqi)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
73	Maglev train	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
74	Hongkou Soccer Stadium	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
75	Basilica of Our Lady of Sheshan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
76	Peace Cinema	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
77	Sheshan Astronomical Observatory	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
78	Suzhou Creek	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
79	Waibaidu Bridge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
80	Oriental Arts Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
81	The Cool Docks	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
82	Shanghai Circus World	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
83	Hengshan Moller Villa	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
84	Hengshan Community Church	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
85	Qibao Catholic Church	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
86	South Bund Fabric Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
87	Shouning Lu Snack Food Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
88	Shanghai Exhibition Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
89	Shanghai Oriental Arts Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
90	Disc Kart Indoor Karting	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
91	Shanghai Food Street: Fangbang Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
92	Shanghai Food Street: Shouning Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
93	Shanghai Food Street: Jinxian Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
94	Changfeng Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
95	Shanghai Food Street: Zaoyang Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
96	Shanghai Food Street: Taizhou Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
97	Shanghai Food Street: Huanghe Lu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
98	Qipu Lu Fashion & Accessories Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
99	Dongtai Lu Antiques Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
100	Nanjing Lu Fake Market - Fenshine Fashion & Accesories Plaza	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
101	Modern Electronic City	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
102	Shiliupu Fabric Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
103	Thames Town	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
104	Grand Gateway Shopping Mall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
105	Sinan Mansions	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
106	Zhenru Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
107	Rockbund Art Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
108	Hongqiao New World Pearl Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
109	Pearl & Jewelry Market - First Asia Jewelry Plaza (3rd Floor)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
110	Shanghai Glasses Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
111	Caojiadu Flower Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
112	Yatai Xinyang Fashion and Gift Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
113	Nihong Kids' Clothing Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
114	Yuyuan Bazaar (Yuyuan Market)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
115	Xing Guan Photographic Equipment Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
116	Song Fang Maison de Th‚	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
117	Shanghai International Circuit Formula 1 Race Track	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
118	Shikumen Open House Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
119	Shanghai Culture Square	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
120	Chongming Island	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
121	Moon Boat (Saudi Arabia Expo Pavilion)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
122	China Art Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
123	Commemoration Exhibition of Expo 2010 Shanghai	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
124	Shengsi Island	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
125	Suzhou Creek Sex Toy Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
126	Fengjing Ancient Town	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
127	Farmers Painting Village (Fengjing Ancient Town)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
128	Xuhui Riverside Public Open Space (Shanghai Corniche)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
129	Rico Rico Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
130	Mao Pagoda Lighthouse	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
131	Sun Island	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
132	Power Station of Art	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
133	Russian Orthodox Mission Cathedral	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	64
134	Garden of the Master of Nets	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	garden-of-the-master-of-nets	cityslug	71
135	Hanshan Temple (Cold Mountain Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	hanshan-temple-cold-mountain-temple	suzhou	71
136	Lion Forest Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
137	New Suzhou Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
138	Tiger Hill	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
139	Humble Administrator's Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	humble-administrators-garden	suzhou	71
140	Liu Yuan (Lingering Garden)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
141	Suzhou Silk Factory	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
142	Pan Men (Pan Gate)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
143	Pingjiang Historic Street (Pingjiang Lu)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
144	Shantang Jie (Shantang Street)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
145	Jinji Lake (Jinji Hu)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	jinji-lake	suzhou	71
146	Suzhou Pingtan Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
147	Kunqu Opera Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
148	Blue Wave Pavilion (Great Wave Pavilion)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
149	Couple's Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
150	Temple of Mystery (Xuanmiao Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	temple-of-mystery-xuanmiao-temple	suzhou	71
151	Shajiabang Village (Changshu City)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
152	Yangcheng Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	71
153	Gengle Residence	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	76
154	Garden of Retreat and Reflection	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	76
155	The Three Bridges	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	76
156	China Sex Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	76
157	Nine Creeks and Eighteen Gullies	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
158	Autumn Moon Over the Peaceful Lake Pavilion	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
159	Lingyin Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	attractionslug	cityslug	30
160	Liuhe Pagoda	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	liuhe-pagoda	hangzhou	30
161	Longjing Tea Plantation	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	longjing-tea-plantation	hangzhou	30
162	Mausoleum of General Yue Fei	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
163	Solitary Hill (Gu Shan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
164	Su Causeway	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
165	Tiger Running Dream Spring	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
166	Xiling Seal Society	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
167	West Lake (Xi Hu)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	west-lake-xi-hu	hangzhou	30
168	Guo's Villa	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
169	Feilai Feng	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
170	Red Carp Pond	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
171	Flower Harbor (Hua Gang)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
172	Leifeng Pagoda	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	leifang-pagoda	hangzhou	30
173	Impression West Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	impression-west-lake	hangzhou	30
174	China National Tea Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
175	China National Silk Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
176	Huqingyu Tang Chinese Medicine Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
177	China Academy of Art	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
178	Qiantang River Tidal Bore	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
179	Southern Song Dynasty Guan Kiln Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
180	Cathedral of Our Lady of the Immaculate Conception	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
181	Qiandao Hu (Thousand Island Lake)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	qiandao-hu-thousand-island-lake	hangzhou	30
182	Former Residence of Hu Xueyan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
183	Jade Emperor Hill	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
184	Xixi National Wetland Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	xixi-national-wetland-park	hangzhou	30
185	Baoshi Shan (Baoshi Hill)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
186	Yanguan Ancient Town (Haining)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
187	Folk Customs Exhibition Hall (Yanguan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
188	Zhan'ao Pagoda (Yanguan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
189	Yanguan Chenghuang Miao (City God Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
190	Tide Watching Pavilion (Yanguan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
191	Laodong Lu (Laodong Road)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
192	Three Pools Mirroring the Moon	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	30
193	Great Wall of China at Badaling	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	great-wall-of-china-at-badaling	beijing	6
194	Beihai Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
195	Forbidden City	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	forbidden-city	beijing	6
196	Fragrant Hills Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
197	The Great Bell Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
198	Ming Tombs	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
199	Summer Palace	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	summer-palace	beijing	6
200	Temple of Heaven	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	temple-of-heaven	beijing	6
201	Tian'anmen Square	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	tiananmen-square	beijing	6
202	Old Summer Palace (Yuanming Yuan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
203	Lama Temple (Yonghe Gong)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
204	Great Wall of China at Juyong Guan (Juyong Pass)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
205	Badachu Park (Eight Great Sites Park)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
206	Bailongtan Scenic Area	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
207	Beijing Zoo and Aquarium	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
208	Beijing Ancient Observatory	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
209	Hongluo Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
210	Jingdong Canyon	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
211	Kangxi Grasslands	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
212	Longqing Gorge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
213	Lugou Bridge (Marco Polo Bridge)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
214	Nanshan Ski Resort	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
215	Great Wall of China at Mutianyu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	great-wall-of-china-at-mutianyu	beijing	6
216	Qinglong Gorge Holiday Resort	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
217	Shidu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
218	Shihua Cave	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
219	Beijing World Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
220	Great Wall of China at Simatai	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
221	Tanzhe Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
222	Yanqi Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
223	Yunju Temple and Shijing Mountain	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
224	Panjiayuan Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
225	Sanlitun	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
226	Dongyue Taoist Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
227	Fahai Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
228	Fenghuang Ling Scenic Area (Phoenix Hill Scenic Area)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
229	Prince Gong's Mansion	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
230	Beijing Drum Tower (Gulou)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
231	Huashi Mosque	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
232	Jing Shan Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
233	Longtan Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
234	Milu Park (Elk Park)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
235	Miaofeng Shan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
236	Guangji Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
237	Mei Lanfang Memorial	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
238	White Dagoba (Miaoying Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
239	Ming Dynasty Waxworks Palace	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
240	Niujie Mosque	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
241	Youth Lake Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
242	Shichahai (Houhai)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
243	Shijingshan Amusement Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
244	Capital Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
245	Imperial Ancestral Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
246	Taoranting Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
247	Wofo Shan (Recumbent Buddha Mountain)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
248	Great Wall of China at Jinshanling	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
249	Blue Zoo Aquarium	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
250	Water Cube - National Aquatics Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
251	CCTV Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
252	Bird's Nest - Beijing National Stadium	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
253	Beijing National Centre for the Performing Arts	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
254	Python Mountain National Forest Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
255	Wangfujing	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
256	Olympic Green	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
257	Nan Luo Gu Xiang	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
258	798 Art Zone	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
259	Beijing Workers' Stadium	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
260	Poly Art Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
261	Poly Theatre	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
262	Wofo Si (Temple of the Recumbent Buddha)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
263	Mausoleum of Mao Zedong	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
264	Houhai Hutong	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
265	Beijing Bell Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
266	Beijing Art Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
267	Baihe (White River)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
268	Peking Opera Art Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
269	National Peking Opera Theater	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
270	Green Wall of China	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
271	Great Wall of China at Jiankou	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
272	Great Wall of China at Huanghua	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
273	Great Wall of China at Gubeikou	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
274	Cuandixia	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
275	Traditional Chinese Medicine Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
276	Great Hall of the People	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
277	Monument to the People's Heroes	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
278	Dino Dream Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
279	Water Cube Water Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
280	Chang Ling Ming Tomb	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
281	Ding Ling Ming Tomb	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
282	Great Wall of China at Shixia Guan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
283	Underwater Great Wall at Panjiakou Reservoir	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
284	Huguosi Snack Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	6
285	Bishu Shanzhuang (Imperial Summer Villa)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	10
286	Putuo Zongcheng Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	10
287	Temple for Distant Security (Anyuan Miao)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	10
288	Temple of Universal Happiness (Pule Si)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	10
289	Temple of Universal Peace (Puning Si)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	10
290	Ancient Culture Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	75
291	Tianjin Confucius Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	tianjin-confucious-temple	tianjin	75
292	Grand Mercy Monastery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	75
293	Great Wall of China at Huangya Pass	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	75
294	Pan Shan (Mount Pan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	75
295	Shi Family Courtyard Residence	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	75
296	Wudadao (Five Avenues)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	wudadao-five-avenues	tianjin	75
297	Porcelain House	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	75
298	Tianjin Eye	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	tianjin-eye	tianjin	75
299	Cuiyunshan Ski Resort	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	99
300	Dajing Gate	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	99
301	Sera Monastery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
302	Barkhor	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
303	Ganden Monastery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
304	Norbulingka	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
305	Potala Palace	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
306	Jokhang Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
307	Yumbulagang	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
308	Samye Monastery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
309	Nam-tso (Lake Nam)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
310	Yamdrok-tso (Yamdrok Lake)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
311	Tibetan Medical Factory	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
312	Drepung Monastery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
313	Tibet Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
314	Ani Sangkhung Nunnery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
315	Yangpachen	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
316	Reting Monastery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
317	Drak Yerpa	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
318	Yangpachen Hot Springs	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
319	Karola Glacier	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
320	Manlha Water Conservation Project	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
321	Drolma Lhakhang Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
322	Mount Nojin Kangsang	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	48
323	Bamboo Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
324	Dian Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
325	Dragon Gate	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
326	Expo Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
327	Golden Temple Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	golden-temple-park	kunming	45
328	Grand View Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
329	Jiuxiang	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
330	Yunnan Stone Forest (Shilin)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	yunnan-stone-forest-shilin	kunming	45
331	Western Hills Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
332	Yunnan Nationalities Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	yunnan-nationalities-village	kunming	45
333	Golden Horse and Jade Rooster Archways	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
334	Yuantong Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
335	Green Lake Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
336	Yunnan Museum of Minority Nationalities	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
337	Huating Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
338	Yunnan Ethnic Nationality Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
339	Dongchuan Red Lands	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	45
340	Ancient City of Dali (Dali Old Town)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	13
341	Butterfly Spring	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	13
342	Cang Shan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	cang-shan	dali	13
343	Erhai Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	erhai-lake	dali	13
344	Three Pagodas	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	three-pagodas	dali	13
345	Erhai Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	13
346	Xizhou	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	13
347	Zhonghe Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	zhonghe-temple	dali	13
348	Baoshan Stone Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
349	Yunshan Ping (Spruce Meadow)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
350	Yulong Xue Shan (Jade Dragon Snow Mountain)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
351	Yufeng Lamasery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
352	Tiger Leaping Gorge (Hutiao Xia)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	leaping-tiger-gorge-hutiaoxia	lijiang	49
353	First Bend in the Yangtze River	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
354	Lijiang Old Town (Dayan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	lijiang-old-town-dayan	lijiang	49
355	Mu Residence (Mu Fu)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
356	Jade Spring Park (Black Dragon Pool)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
357	Baishui River	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
358	Baisha Frescoes	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	baisha-frescoes	lijiang	49
359	Impression Lijang	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
360	Shuhe Old Town	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	shuhe-old-town	lijiang	49
361	Dongba Culture Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
362	Lashi Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	49
363	Baimang Snow Mountain	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	baimang-snow-mountain	shangri-la	65
364	Cizhong Cathedral	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	65
365	Mount Meili (Meili Xue Shan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	mount-meili	shangri-la	65
366	Dabao Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	65
367	Napahai Nature Reserve	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	65
368	Songzanlin Monastery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	songzanlin-monastery	shangri-la	65
369	Pudacuo National Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	65
370	Xiagei Hot Springs	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	xiagei-hot-springs	shangri-la	65
371	Xiao Zhongdian	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	65
372	Yading Nature Reserve and Riwa Town	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	65
373	Daocheng	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	65
374	Jingzhen Octagonal Pavilion	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
375	Mandian Waterfall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
376	Mange Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
377	Olive Plains	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
378	Tropical Plant Research Institute	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
379	White Feilong Pagodas	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
380	Wild Elephant Valley	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
381	Jinghong	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
382	Ganlanba (Menghan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
383	Ganlanba Dai Minority Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
384	Tropical Flowers and Plants Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	86
385	Three Gorges of Lubuge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	62
386	Jiulong Waterfall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	62
387	Tiansheng Cave	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	62
388	Du Fu's Thatched Cottage	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	du-fus-thatched-cottage	chengdu	11
389	Wuhou Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
390	Giant Panda Breeding Research Base	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	giant-panda-breeding-research-base	chengdu	11
391	Wenshu Monastery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	wenshu-monastery	chengdu	11
392	Xiling Xueshan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
393	Jinli Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
394	Wangjiang Tower Park and Bamboo Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
395	Sanxingdui Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
396	Jinsha Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
397	People's Park (Chengdu)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
398	Qingyang Temple (Qingyang Gong)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
399	Shu Brocade Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
400	Ya'an City	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
401	Kuan and Zhai Xiangzi (Wide and Narrow Alleys)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
402	Chengdu Teddy Bear Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
403	Luodai Ancient Town	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	luodai-ancient-town	chengdu	11
404	Sichuan Silk Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	11
405	Leshan Giant Buddha (Dafo)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	47
406	Giant Sleeping Buddha	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	47
407	Emei Shan Baoguo Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	21
408	Elephant's Bathing Pool	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	21
409	Golden Peak Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	21
410	Emei Shan Hot Springs	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	21
411	Wan Fo Ding (Ten Thousand Buddha Summit)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	21
412	Wannian Si (Long Life Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	21
413	Dujiangyan Irrigation System	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	19
414	Qingcheng Shan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	19
415	Camoes Garden and Grotto	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
416	A-Ma Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
417	Hac Sa Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
418	Kun Iam Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
419	Lou Lim Loc Gardens	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
420	Macau Jockey Club	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
421	Macau Maritime Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
422	Fortaleza do Monte (Mount Fortress)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
423	Ruins of St. Paul's Cathedral	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
424	San Antonio Church	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
425	Macau Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
426	Venetian Macau Resort and Casino	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
427	Extreme Sports: AJ Hackett Macau Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
428	Orient Golf Macau	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
429	Macau Motor Sports Club	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
430	Macau Horse Riding School	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
431	Fisherman's Wharf	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
432	Senado Square	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
433	Avenida de Almeida Ribeiro	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
434	Casino Lisboa	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
435	Section of the Old City Walls	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
436	Na Tcha Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
437	Macau Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	52
438	Tunxi Old Street (Lao Jie)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
439	Celestial Capital Peak	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
440	Lotus Flower Peak	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
441	Bright Summit Peak	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
442	Huang Shan Hot Springs	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
443	Huang Shan Western Steps	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
444	Huang Shan Eastern Steps	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
445	Huang Shan Summit (Peak Circuit)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
446	Hong Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
447	Hu Kaiwen Ink Factory	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
448	China Huizhou Culture Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	36
449	Baota Hill	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	89
450	Hukou Waterfall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	89
451	Revolutionary History Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	89
452	Yangjialing Revolution Headquarters	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	89
453	Yulin Town	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	89
454	Dadonghai Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
455	Luhuitou Peninsula	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
456	Nanshan Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
457	Tianya Haijiao (The End of Heaven and Edge of the Sea)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
458	Yalong Bay	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
459	Nantian Hot Spring Resort	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
460	Coconut Corridor	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
461	Big and Small Dongtian	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
462	Wuzhizhou Island	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
463	Ancient Yazhou City	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
464	Nanwan Monkey Island	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
465	Yanoda Rainforest	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
466	Xidao (West Island Marine Cultural Tourism Zone)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
467	Yalong Bay Tropical Heaven Forest Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
468	Wuzhi Shan Li Minority Area	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	63
469	Central Avenue	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
470	St. Sophia Cathedral	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
471	Stalin Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
472	Japanese Germ Warfare Experimental Base	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
473	Jile Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
474	Siberian Tiger Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
475	Sun Island Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
476	Yabuli Ski Resort	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
477	Yuquan Hunting Ground	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
478	Zhaolin Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
479	Harbin Ice Festival	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
480	Heilongjiang Provincial Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
481	Jingpo Hu (Mirror Lake)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	31
482	Nanjing Confucius Temple (Nanjing Fuzi Miao)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
483	Nanjing Drum Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
484	Mochou Lake Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
485	Nanjing City Wall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	nanjing-city-wall	nanjing	55
486	Presidential Palace	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
487	Rain Flower Terrace (Yuehua Tai)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
488	Sun Yat-sen's Mausoleum (Zhongshan Ling)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	sun-yat-sens-mausoleum-zhongshan-ling	nanjing	55
489	Tang Shan Hot Springs	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
490	Xiaoling Tomb of the Ming Dynasty (Mingxiao Ling)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
491	Xuanwu Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	xianwu-lake	nanjing	55
492	1912 Bar Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
493	Memorial Hall of the Nanjing Massacre	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	memorial-hall-of-the-nanjing-massacre	nanjing	55
494	Zijin Shan (Purple Gold Mountain)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	zijin-shan-purple-gold-mountain	nanjing	55
495	Nanjing University	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
496	Nanjing Museum of Paleontology	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
497	Zhonghua Gate	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
498	Taicheng City Wall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
499	Jiming Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
500	Zijin Shan Cable Car	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
501	Zijin Shan Plank Way	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
502	Fuzi Miao Pedestrian Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
503	Zifeng Tower (Greenland Financial Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	zifeng-tower-greenland-financial-center	nanjing	55
504	Nanjing Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
505	Taiping Heavenly Kingdom History Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	55
506	Banyan Lake and Fir Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	27
507	Elephant Trunk Hill	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	elephant-trunk-hill	guilin	27
508	Seven Star Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	27
509	Solitary Beauty Peak	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	27
510	Fubo Shan (Wave Subduing Hill)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	27
511	Longji Rice Terraces	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	longji-rice-terraces	guilin	27
512	Reed Flute Cave	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	reed-flute-cave	guilin	27
513	Ling Canal	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	27
514	Li River Cruise	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	li-river-cruise	guilin	27
515	Guilin Merryland	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	27
516	Ping'an Zhuang Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	27
517	Chengyang Wind and Rain Bridge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	27
518	Nanshan Grassland (South Mountain Grassland)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	78
519	People's Park (Urumqi)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	78
520	Red Hill Park (Hongshan Park)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	78
521	Xinjiang Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	78
522	Tian Chi (Xinjiang)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	78
523	Erdaoqiao Bazaar	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	78
524	Tian Shan (Heavenly Mountains)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	78
525	Id Kah Mosque	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	44
526	Tomb of Yusup Hazi Hajup	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	44
527	Kashgar Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	44
528	Kashgar Old Town	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	44
529	Abakh Hoja Tomb	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	44
530	Kashgar Sunday Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	44
531	Yarkand Mausoleum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	44
532	Zhiren Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	44
533	Bezeklik Thousand Buddha Caves	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	77
534	Flaming Mountains	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	77
535	Grape Valley	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	77
536	Jiaohe Ruins	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	77
537	Gaochang	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	77
538	Karez Water System	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	77
539	Astana Graves	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	77
540	Emin Minaret (Su Gong Tower)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	77
541	The Great Wall of China at Yumenguan and Yangguan (Yumen and Yang Passes)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	20
542	Mingsha Shan and Crescent Moon Spring	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	20
543	The Great Wall at Shandan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	20
544	Mogao Caves (Dunhuang Caves)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	20
545	Aberdeen	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
546	Hong Kong Convention and Exhibition Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
547	Kowloon Mosque	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
548	Man Mo Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
549	Ocean Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
550	St. John's Cathedral	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
551	Stanley	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
552	Statue Square	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
553	Victoria Peak	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
554	Wong Tai Sin Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
555	Tian Tan Buddha	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
556	Hong Kong Disneyland	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
557	Lamma Island	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
558	Happy Valley Racecourse	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
559	Hong Kong Beaches	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
560	Star Ferry	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
561	Sai Kung Peninsula & Clear Water Bay	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
562	Cheung Sha Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
563	Ngong Ping 360 Cable Car	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
564	MacLehose Trail	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
565	Madame Tussauds Hong Kong	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
566	Lan Kwai Fong	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
567	Ladies Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
568	Repulse Bay	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
569	Jardine Noonday Gun	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
570	Symphony of Lights	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
571	Shek O Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
572	Big Wave Bay (Shek O)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
573	Deep Water Bay	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
574	Middle Bay and South Bay	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
575	Hong Kong Science Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
576	Po Lin Monastery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
577	Avenue of Stars	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
578	Lei Yue Mun Fishing Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	34
579	Big Wild Goose Pagoda	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	attractionslug	cityslug	84
580	Emperor Qin Shihuang's Tomb	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	84
581	Famen Si (Famen Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	84
582	Forest of Steles Museum (Beilin Museum)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	84
583	Huaqing Pool	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	84
584	Lintong Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	84
585	Terracotta Warriors	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	terracotta-warriors	xian	84
586	Xi'an Bell Tower and Drum Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	xian-bell-tower-and-drum-tower	xian	84
587	Xi'an City Wall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	xian-city-wall	xian	84
588	Li Shan (Mount Li)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	84
589	Banpo Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	84
590	Shaanxi History Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	84
591	Hanyang Mausoleum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	84
592	Great Mosque of Xi'an	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	84
593	Muslim Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	muslim-street	xian	84
594	Baotong Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	baotong-temple	wuhan	80
595	East Lake Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	east-lake-park	wuhan	80
596	Changchun Taoist Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
597	Guiyuan Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
598	Yellow Crane Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	yellow-crane-tower	wuhan	80
599	Qingchuan Pavilion	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
600	Gui Shan (Tortoise Mountain)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
601	Wuhan's First Yangzi River Bridge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
602	Guqin Tai	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
603	Hubei Provincial Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
604	Longquan Shan Scenic Area	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	longquan-shan-scenic-area	wuhan	80
605	Hong Shan Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
606	Mao Zedong Villa	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
607	VOX Bar & Livehouse	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
608	Ximen Night Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	80
609	Tianhou Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	tianhou-temple	qingdao	60
610	Tsingtao Brewery Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	tsingtao-brewery-museum	qingdao	60
611	Lao Shan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
612	Qingdao Zhongshan Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
613	Qingdao Underwater World	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
614	Qingdao Polar Ocean World	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
615	Qingdao International Beer City	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
616	Zhan Qiao Pier	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	zhan-qiao-pier	qingdao	60
617	Xiao Qingdao	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
618	Qingdao TV Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	qingdao-tv-tower	qingdao	60
619	Qingdao Municipal Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
620	Taiqing Palace	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
621	Xiao Yu Shan Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
622	Qingdao Guest House	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
623	Granite Mansion	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
624	Eight Great Passes	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
625	May 4th Square	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
626	Zhanshan Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
627	St. Michael's Cathedral	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
628	Qingdao Beaches	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
629	No. 2 Bathing Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
630	Ocean University of China	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
631	Qingdao Protestant Church	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	60
632	Xiamen University Furong Tunnel	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
633	Gulangyu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	gulangyu	xiamen	83
634	Nanputuo Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	nanputuo-temple	xiamen	83
635	Overseas Chinese Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
636	Zheng Chenggong Memorial Hall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
637	Underwater World Xiamen	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
638	Piano Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	piano-museum	xiamen	83
639	Tianluokeng Hakka Earth Buildings	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	tianluokeng-hakka-earth-buildings	xiamen	83
640	Strange Slope (Guai Po)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
641	Xiamen University	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
642	Huli Shan Fortress	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
643	Shuzhuang Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
644	Yuchanglou Tulou (Hakka houses)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
645	Chuxi Tulou (Hakka houses)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
646	Nanxi Tulou (Hakka houses)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
647	Gaobei Tulou (Hakka houses)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
648	Chengqi Lou Tulou (Hakka houses)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
649	Tulou (Hakka houses)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	83
650	West Street (Xi Jie)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	attractionslug	cityslug	90
651	Yulong River	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	90
652	Yueliang Shan (Moon Hill)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	attractionslug	cityslug	90
653	Impression of Liu Sanjie	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	attractionslug	cityslug	90
654	Yuzi Paradise	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	90
655	Xingping Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	90
656	Liugong Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	90
657	Yangdi Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	90
658	Green Lotus Peak (Bilian Peak)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	90
659	Black Buddha Cave	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	90
660	Assembling Dragon Cave	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	90
661	Big Banyan Tree	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	90
662	Li River (Yangshuo)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	attractionslug	cityslug	90
663	Pingyao City Walls	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	pingyao-city-walls	pingyao	58
664	Rishengchang Financial Exchange	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	rishengchang-financial-exchange	pingyao	58
665	Former Residence of Lei Lutai	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	former-residence-of-lei-lutai	pingyao	58
666	Ming-Qing Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	ming-qing-street	pingyao	58
667	Wang Family Compound	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	58
668	Temple of the Princess of the Rosy Clouds	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	72
669	Jade Emperor Peak	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	72
670	Daizong Archway	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	72
671	Heavenly Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	72
672	Stone Sutra Ravine	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	72
673	Zhongtian Gate	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	72
674	Ningbo Baoguo Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
675	Tianyi Pavilion	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
676	Tianhe Scenic Area	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
677	Nanxi Hot Springs	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
678	Shipu Fishing Harbor	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
679	Moon Lake (Yue Hu)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
680	Tiantong Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
681	Jiangbei Cathedral	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
682	Ningbo Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
683	Tianfeng Pagoda	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
684	King Asoka Temple (Ayuwang Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
685	The Old Bund (Lao Waitan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
686	Seven Pagoda Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
687	Ningbo Mosque (Qingzhen)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
688	Ningbo Drum Tower (Gu Lou)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
689	Fan Residence Antique Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
690	Hemudu Site Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
691	Ningbo Youngor Zoo	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
692	Ningbo Ocean World	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
693	Dongqian Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
694	Ningbo Museum of Art	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
695	Chiang Kai-shek Residence (Fenggao House)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
696	Xikou Town	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
697	Ningbo Chenghuang Miao (City God Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
698	Hangzhou Bay Bridge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
699	Qing'an Guild Hall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
700	Xuedou Shan (Mount Xuedou)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
701	Banking Guild Hall Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	57
702	Shu Bao Ta (Tree-Wrapped Pagoda)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	17
703	Yunyan Pagoda (Yunnan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	17
704	Jiele Great Golden Pagoda	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	17
705	Bianmao Jie / Jade and Gem Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	17
706	Mengbana Naxi Exotic Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	17
707	Jiegao Border Trade Zone	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	17
708	Meilu Villa	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	50
709	Dragon Head Cliff	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	50
710	Lu Shan Botanical Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	50
711	East Grove Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	50
712	Hanyang Peak	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	50
713	Xihui Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	81
714	Plum Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	81
715	Lingshan Buddha	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	81
716	Turtle Head Isle	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	81
717	Three Hills Island (San Shan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	81
718	Wuxi Film Studios	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	81
719	Tai Lake (Tai Hu)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	81
720	Huangshi Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	98
721	Yellow Dragon Cave (Huanglong Cave)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	98
722	Golden Whip Brook	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	98
723	Fenghuang (Phoenix Town)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	98
724	Baiyun Shan (White Cloud Mountain)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	baiyun-shan-white-cloud-mountain	guangzhou	26
725	Qingping Market	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	qingping-market	guangzhou	26
726	Guangzhou Museum of Art	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
727	Yuexiu Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
728	Temple of the Six Banyan Trees (Liurong Si)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
729	Chen Clan Academy (Chen Jia Ci)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
730	Sun Yat-sen Memorial Hall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	sun-yat-sen-memorial-hall	guangzhou	26
731	Xiguan Residences	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
732	Qiangang Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
733	Space Flight Spectacle	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
734	Shamian Island	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
735	Guangzhou Opera House	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
736	Mausoleum of the Nanyue King	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
737	Canton Fair Complex (Guangzhou Exhibition Center)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
738	Whampoa Military Academy (Huangpu Military Academy)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
739	New Guangdong Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
740	Vitamin Creative Space	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
741	Art 64 Gallery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	26
742	One Hundred Step Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	59
743	One Thousand Step Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	59
744	Puji Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	59
745	Nanhai Guanyin	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	59
746	Fayu Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	59
747	Polar Aquarium	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	14
748	Fujiazhuang Beach	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	14
749	Forest & Animal Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	14
750	Sun Asia Ocean World	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	14
751	People's Square (Dalian)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	14
752	Olympic Square	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	14
753	Daheishi	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	14
754	Tiger Beach Ocean Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	14
755	Lushun (Lvshun)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	14
756	Meixi Arches	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	104
757	Dazu Rock Carvings	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	dazu-rock-carvings	chongqing	12
758	Red Cliff Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	red-cliff-village	chongqing	12
759	Northern Hot Springs Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	12
760	Cable Car Trips	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	12
761	River Tours	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	12
762	Ciqikou Ancient Town	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	ciqikou-ancient-town	chongqing	12
763	Arhat Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	12
764	Jiefangbei Pedestrian Street	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	t	This is how to get here	f	jiefangbei-pedestrian-street	chongqing	12
765	Zhiyuan Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	40
766	Tiantai Peak (Tiantai Zheng Peak)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	40
767	Tiantai Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	40
768	Roushen Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	40
769	Huacheng Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	40
770	Baisui Gong (Longevity Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	40
771	Water Curtain Cave	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	82
772	Bingling Thousand Buddha Caves	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	46
773	Gansu Provincial Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	46
774	White Pagoda Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	46
775	Five Springs Park (Wuquan Gongyuan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	46
776	The White Cloud Temple (Baiyun Guan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	46
777	Linxia Hui Autonomous Prefecture	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	46
778	Guangxi Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	56
779	Huangguoshu Falls	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	1
780	Longgong Caves	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	1
781	Tun Bu Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	1
782	Anshun Confucius Temple (Anshun Wenmiao)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	1
783	Zhijin Cave	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	1
784	Hongfu Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	28
785	Jiaxiu Pavilion	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	28
786	Qingyan (Qingyan Guzhen)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	28
787	Baihua Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	28
788	Qianling Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	28
789	Guiyang Forest Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	28
790	Hongfeng Lake (Red Maple Lake)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	28
791	Xiangzhi Valley	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	28
792	Tianhe Pool Scenic Area	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	28
793	Huaxi Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	28
794	Baima Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	51
795	Longmen Grottoes	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	51
796	Wangcheng Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	51
797	Guanlin Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	51
798	Old Dragon's Head	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	61
799	Beidaihe	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	61
800	Yansai Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	61
801	Great Wall of China at Shanhaiguan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	61
802	Mengjiangnu Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	61
803	Tianzhu Peak	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	79
804	Nanyan Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	79
805	Purple Cloud Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	79
806	Taizi Po: the Prince Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	79
807	Wudang Shan City	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	79
808	Xiao Yao Gu: The Carefree Valley	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	79
809	Wulong Gong (Five Dragon Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	79
810	Henan Provincial Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	101
811	Yellow River Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	101
812	Shang City Ruins	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	101
813	Zhengzhou Chenghuang Miao (City God Temple)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	101
814	Shaolin Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	101
815	Slender West Lake (Shouxi Hu)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	91
816	Yangzhou Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	91
817	Daming Monastery (Daming Si)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	91
818	Qin Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	91
819	Tengwang Ge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	54
820	Youmin Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	54
821	August 1st Uprising Musuem	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	54
822	People's Square (Nanchang)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	54
823	Jiangxi Provincial Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	54
824	Qio Shue Square (Qio Shue Guangchang)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	54
825	Bayi Park (Bayi Gongyuan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	54
826	Bada Shanren Meihu Lake Scenic Area	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	54
827	Qing Shan Lake Scenic Area	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	54
828	Bu Xing Pedestrian Street (Bu Xing Jie)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	54
829	Shenyang Imperial Palace (Mukden Palace)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	68
830	Zhao Mausoleum (North Tomb)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	68
831	Fu Mausoleum (East Tomb)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	68
832	North Pagoda (Bei Ta)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	68
833	September 18th History Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	68
834	Qipan Shan Scenic Area	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	68
835	Inner Mongolian Grasslands	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
836	Jiangjun Yashu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
837	Inner Mongolia Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
838	Wusutu Lamasery (Wusutu Zhao)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
839	Inner Mongolia Horse Racing Grounds	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
840	Xilitu Lamasery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
841	Xiwu Qi	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
842	Great Wall of China in Inner Mongolia	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
843	Xilamuren Grasslands	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
844	Gegentala Grasslands	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
845	Huitengxile Grasslands	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
846	Hohhot Five Pagoda Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
847	Hohhot Great Lamasery (Da Zhao)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
848	Hohhot Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
849	Hohhot Great Mosque	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
850	Zhaojun Tomb	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	33
851	Yungang Caves	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	16
852	Nine Dragon Screen	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	16
853	Heng Shan (Shanxi)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	16
854	Hanging Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	16
855	Wooden Pagoda	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	16
856	Twin Pagoda Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	74
857	Chongshan Monastery	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	74
858	Wutai Shan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	74
859	Great Wall of China at Gu Guan (Guguan Pass)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	74
860	Great Wall at Ningwu Guan (Ningwu Pass)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	74
861	Great Wall of China at Yanmen Guan (Yanmen Pass)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	74
862	Great Wall of China at Pian Guan (Pian Pass)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	74
863	Great Wall of China at Niangzi Guan (Niangzi Pass)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	74
864	North Mountain Cliff Temple (Beishan Si)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	85
865	Kumbum Monastery (Ta Er Si)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	85
866	Qinghai Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	85
867	Dongguang Mosque (Qingzhen Dasi)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	85
868	Shuzheng Gully and Stockade	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	41
869	Muni Valley (Muni Gou)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	41
870	Long Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	41
871	Swan Lake	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	41
872	Shuzheng Waterfall (Shuzheng Pubu)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	41
873	Nuorilang Waterfall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	41
874	Rize Valley	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	41
875	Zechawa Valley	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	41
876	Heye Village	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	41
877	Primeval Forest	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	41
878	Jinxian Resort	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	18
879	Opium War Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	18
880	Keyuan Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	18
881	Humen Naval Battle Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	18
882	Humen Bridge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	18
883	China Textile City	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	66
884	Lu Xun's Former Residence (Lu Xun Native Place)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	66
885	Orchid Pavilion (Lan Ting)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	66
886	Mausoleum of Yu the Great	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	66
887	Shaoxing Grand Theatre	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	66
888	East Lake (Dong Hu)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	66
889	Seven Star Crags Park (Qixing Yan Gongyuan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	100
890	Dinghu Shan (Dinghu Mountains)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	100
891	Foshan Ancestral Temple (Foshan Zu Miao)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	23
892	Xiqiao Mountain	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	23
893	Nanfeng Kiln	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	23
894	Liang Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	23
895	Bruce Lee Ancestral Hall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	23
896	Foshan Lotus World	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	23
897	Sunwen Xilu	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	103
898	Beishan Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	37
899	Meteorite Shower Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	37
900	Jilin Confucius Temple (Jilin Wenmiao)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	37
901	Songhua Lake Area	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	37
902	Beidahu Ski Area	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	37
903	Songhua Hu Ski Resort	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	37
904	Tian Chi (Jilin)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	37
905	Iron Pagoda	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	42
906	Longting Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	42
907	Kaifeng Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	42
908	Yanqing Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	42
909	Shanshangan Guild Hall	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	42
910	Fan Pagoda	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	42
911	The Bamboo Sea	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	93
912	Xinwen County Stone Cave Forest	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	93
913	Cuiping Mountain	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	93
914	Xibu Daxiagu Hot Spring	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	93
915	Shibei Village Dinosaur Fossils	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	93
916	Lizhuang Old Town	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	93
917	Anhui Provincial Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	32
918	Mingjiao Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	32
919	Xiaoyaojin Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	32
920	Lord Bao's Tomb and Memorial Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	32
921	Xuzhou Terracotta Warriors	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	87
922	Dajiu Lakes Wetland	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	67
923	Enshi Grand Canyon (Mufu Grand Canyon)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	22
924	Great Wall of China at Tiger Mountain	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	15
925	Dagu Shan (Dagu Mountain)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	15
926	Yalu River Bridge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	15
927	Dandong Korean War Museum	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	15
928	Pheonix Mountain National Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	15
929	Big Deer Island (Da Lu Dao)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	15
930	Baotu Springs Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	38
931	Thousand Buddha Cliff	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	38
932	Four Gates Pagoda	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	38
933	Daming Lake Park	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	38
934	Thousand Buddha Mountain (Qianfo Shan)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	38
935	Great Wall of China at Zhenbei Tower	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	96
936	Red Stone Gorge	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	96
937	Bifengxia Gorge and Panda Breeding Center	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	88
938	Erlang Shan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	88
939	Shangli Old Town (Ya'an)	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	88
940	Mt. Taipingshan and the Baolin Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	70
941	Qinghui Garden	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	70
942	Guangwu Shan	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	25
943	Jianmen Fortress and Shu Road	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	25
944	Huangze Temple	Some info about this attraction	This is the most amazing attraction ever and this is why you shouls see it	Time Goes Here	120	15	100	f	This is how to get here	f	attractionslug	cityslug	25
945	Hunan Provincial Museum	Its a great place	Terrific place	All day	120	50	ddd	t	How to get there	f	hunan-provincial-museum	changsha	8
946	Yuelu Hill Park	Some place	Its a great place	All day 	120	50	100	t	How to get there	f	yuelu-hill-park	changsha	8
947	Shaoshan	A grat place	A new place 	All day	120	50	100	t	How to get there	f	shaoshan	changsha	8
948	Heng Shan (Hunan)	A place to go	It's incredible	All day	120	50	100	t	How to get there	f	heng-shan-hunan	changsha	8
949	The Fairy Lake Botanical Gardens	A great place	Go here	All day 	120	50	100	t	How to get there	f	the-fairy-lake-botanical-gardens	shenzhen	69
950	Window of the World	All the places	In the world	All day 	120	50	100	t	How to get there	f	window-of-the-world	shenzhen	69
951	China Folk Culture Village	All the places	In the world	All day	120	50	100	t	How to get there	f	china-folk-culture-village	shenzhen	69
952	Dapeng Ancient City	All the places	In the world	All day	120	50	100	t	How to get there	f	dapeng-ancient-city	shenzhen	69
\.


--
-- Data for Name: maincontent_attractionimages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maincontent_attractionimages (id, imfilename, imthumbfilename, imcaption, imauthor, imattname_id) FROM stdin;
1	images/city/shanghai/thebund/01.jpg	images/city/shanghai/thebund/01_thumb.jpg	This is the spectacular bund	Myself	8
2	images/city/shanghai/thebund/02.jpg	images/city/shanghai/thebund/02_thumb.jpg	Here is the Bund in all its glory, again.	Some Guy	8
3	images/city/shanghai/thebund/03.jpg	images/city/shanghai/thebund/03_thumb.jpg	Once again, the bund	Nobody	8
4	images/city/shanghai/thebund/04.jpg	images/city/shanghai/thebund/04_thumb.jpg	And here it is in the daytime.	SuperMan	8
5	images/city/shanghai/thebund/05.jpg	images/city/shanghai/thebund/05_thumb.jpg	Something something	Someone	8
6	images/city/shanghai/thebund/06.jpg	images/city/shanghai/thebund/06_thumb.jpg	It's a person names	Poop	8
8	images/city/shanghai/thebund/07.jpg	images/city/shanghai/thebund/07_thumb.jpg	Suppp  Photo	Hite	8
9	images/city/shanghai/thebund/08.jpg	images/city/shanghai/thebund/08_thumb.jpg	Something something	Nonono	8
10	images/city/shanghai/thebund/09.jpg	images/city/shanghai/thebund/09_thumb.jpg	Yeah yeah yeah	The 's	8
11	images/city/shanghai/thebund/10.jpg	images/city/shanghai/thebund/10_thumb.jpg	Be somebody	Hohoho	8
\.


--
-- Data for Name: maincontent_city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maincontent_city (id, name, chinesename, shortdescription, thumbnail_path, banner_path, cityfulldesc, cityfulldesc2, attsfulldesc, eatsfulldesc, accommodationfulldesc, weatherdesc, qspopulation, qsno1highlight, sortpriority, visible, transportvisible, transportoutervisible, eatvisible, accommodationvisible, weathervisible, coordinates, slug, province_id, qsprovince) FROM stdin;
1	Anshun	安顺	Here is an example of a short description	images/city/Anshun/Anshun.jpg	images/city/Anshun/Anshun_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	anshun	24	qsprovince_id
2	Anyang 	安阳	Here is an example of a short description	images/city/Anyang /Anyang .jpg	images/city/Anyang /Anyang _large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	anyang	16	qsprovince_id
3	Baoshan 	保山	Here is an example of a short description	images/city/Baoshan /Baoshan .jpg	images/city/Baoshan /Baoshan _large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	baoshan	25	qsprovince_id
4	Baotou 	包头	Here is an example of a short description	images/city/Baotou /Baotou .jpg	images/city/Baotou /Baotou _large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	baotou	6	qsprovince_id
5	Beihai 	北海市	Here is an example of a short description	images/city/Beihai /Beihai .jpg	images/city/Beihai /Beihai _large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	beihai	20	qsprovince_id
6	Beijing	北京	Full of history and featuring some of the country's biggest landmarks, China's capital is not to be missed	images/city/Beijing/Beijing.jpg	images/city/Beijing/Beijing_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	Indresible	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	24000000	The Great Wall	1	t	t	t	f	f	t	39.916667, 116.383333	beijing	1	qsprovince_id
7	Bo'ao 	博鳌	Here is an example of a short description	images/city/Bo'ao /Bo'ao .jpg	images/city/Bo'ao /Bo'ao _large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	boao	21	qsprovince_id
8	Changsha 	长沙	Here is an example of a short description	images/city/Changsha /Changsha .jpg	images/city/Changsha /Changsha _large.jpg	Changsha, the most populous city and the capital of Hunan Province, is located on the Xiang River south of Dongting Lake. It is a famous historical and cultural city with a history of over 3,000 years. 	Development occurred drastically closer to 3000BC when Changsha developed with the proliferation of Longshan culture, although there is no firm evidence of such linkage. Despite this, pottery and bronze ware have been discovered. During the 1st millennium BCE the area was the centre of the southern part of the Yangtze River valley state of Chu. Under the Qin dynasty (221–207 BCE) it became a staging post for Qin expeditions into Guangdong Province. After the fall of the Tang dynasty (618–907), it became the capital of the independent Chu state (927–951) that subsequently fell to other regional powers until being incorporated into the Song dynasty (960–1279). Between 750 and 1100, as Changsha became an important commercial city, the population of the area increased tenfold. Changsha was opened to foreign trade in 1904. It also became the seat of some Western schools, including a missionary medical college. During the Sino-Japanese War Changsha was the site of three major battles. It was rebuilt after 1949 and became a major port, handling rice, cotton, timer, and livestock.	The city of Changsha has jurisdiction over six districts that are part of the city proper: Furong, Tianxin, Yuelu, Kaifu, Yuhua, and Wangcheng Districts.\r\n\r\nThe attractions in Changsha are quite varied, thanks to its long history and the diversity of events which have happened here. also has a rich collection of Parks and Gardens enjoyed by both visitors and locals. One of the top sights in Changsha is the Hunan Provincial Museum, founded in the early 1950s. The museum boasts abundant collections that feature the cultural relics excavated from the world. Secondly, people can also enjoy a pleasant walk at Mount Yuelu. For some more historical attractions, the Mawangdui Han Tombs and the Kaifu Temple are the must-go places. As the hometown to Mao Zedong, or Chairman Mao, his famous statue is located at the south end of the Orange Isle, an island located at the city center of Changsha that connects the Mount Yuelu in the west and the downtown in the east. 	Xiang Cuisine, which is what Changsha’s cuisine belongs to, is one of the Eight Cuisines in China and has a fine and delicate appearance and a hot & sour taste and the heavy and hot taste is an equal competitor to the spicy food of Sichuan. Street dining and restaurants in the city make every visitor's mouth hot.\r\n\r\nChangsha specialities include dongan chicken, stinking tofu, chili smoked meat and cold rice noodles in a hot and spicy sauce. Honey sauces are favoured for desserts, which include favourites such as water chestnuts or cassia-flower cakes. For those of the non-spicy palate, the city still has an array of cooler dishes, including tasty dumplings, eggs and pickles. Huo Gong Dian is the most famous restaurant for local Hunan cuisine.	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	t	f	f	t	f	f	28.227777, 112.938845	changsha	18	qsprovince_id
9	Changzhou	常州	Here is an example of a short description	images/city/Changzhou/Changzhou.jpg	images/city/Changzhou/Changzhou_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	31.783333, 119.966667	changzhou	10	qsprovince_id
10	Chengde	承德	Here is an example of a short description	images/city/Chengde/Chengde.jpg	images/city/Chengde/Chengde_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	chengde	4	qsprovince_id
11	Chengdu	成都	Panda, pandas and more pandas. Did we mention the pandas?	images/city/Chengdu/Chengdu.jpg	images/city/Chengdu/Chengdu_large.jpg	Chengdu, located on the edge of the fertile plains of the Red Basin, is a sub-provincial city that serves as the capital of China's Sichuan Province. It is one of the three most populous cities in Western China(the other two are Chongqing and Xi'an). The population of Chengdu as of 2014 is 14.43 million. The Funan river bisects the city; although boat traffic was common until the 1960's, it has all vanished today. Chengdu has been a popular destination perennially for its laid-back but modern life. 	Spring and Autumn are the best times to go to Chengdu since midsummer can be sweltering (highs in summer commonly surpass 30 °C), and the winter is wet and cold. Chengdu is also one, if not the, cloudiest city in China with 24% possible sunshine on average every year.\r\n\r\nChéngdū has seen the rise and fall of nearly a dozen independent kingdoms and dynasties since its founding in 316 BCE; agricultural potential and geography were key to its political power. Yet throughout history, it has been equally well known as a cornerstone of culture and commerce. Two walls were constructed during the Qin Dynasty (221–206 BCE) to create two city sections along the north bank of the rushing Jinjiang.	Chengdu is famed for being the home of cute giant pandas. A breeding center for giant pandas called Chengdu Research Base of Giant Panda Breeding was founded in the north suburbs of Chengdu. It is the only one of its kind in the world that's located in a metropolitan area. Mount Qingcheng is amongst the most important centers of Taoism (Daoism) in China. It is situated in the suburbs of Dujiangyan City.\r\n\r\nWithin Chengdu, Kuanzhaixiangzi is a very nice place with lots of tea houses, restaurants, and local snacks. The streets date from late Qing-Dynasty style but are rebuilt recently. Tianfu Square is also worth visiting. It is overlooked by an enormous Chairman Mao statue in the center of the city. Every evening at dusk, as well as at noontime, an elaborate water show, synchronized to music, bursts out from the square's fountains. For the modern spot, the Chunxi Road, a contiguous shopping districts with shopping malls, department stores, boutiques, and street stalls, is the place to go. 	You will find no shortage of delicious and fiery Sichuan food in Chengdu. If you are used to the hottest of authentic Indian or Thai food, the level of spiciness in Sichuan food should be no problem at all. However, Sichuan food also makes heavy use of Sichuan pepper (Huajiao), which looks like but is not a true peppercorn, and causes your mouth to become somewhat numb. Chengdu is famous for its hotpot, arguably the spiciest food in Chengdu. Some of the best hotpot spots are Shujiuxiang Hotpot and Huangcheng Laoma Hotpot. There are also a lot of weird local snack type of food, such as spicy dragon prawns (look like very small crayfish), spicy snails, Chongqing duck neck, Bangbang chicken, spicy rabbit meat.	Here's where you can find all the best hotels in the city.	Here is the weather	14677000	The Bund	7	t	t	t	f	f	t	30.658611, 104.064722	chengdu	23	qsprovince_id
97	Yuxi	玉溪	Here is an example of a short description	images/city/Yuxi/Yuxi.jpg	images/city/Yuxi/Yuxi_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	24.35, 102.533333	yuxi	25	qsprovince_id
12	Chongqing	重庆	A must visit for lovers of all things spicy, home of the hotpot	images/city/Chongqing/Chongqing.jpg	images/city/Chongqing/Chongqing_large.jpg	Chongqing, a major city in southwest China, is set to become the most economically important city in West China despite being far away from the coast. It is one of China’s four direct-controlled municipalities (the others are Beijing, Shanghai, and Tianjin). A July 2012 report by the Economist Intelligence Unit described it as one of China's "30 emerging megacities". Chongqing’s population, as of 2015, is about 30 million. Chongqing also has a significant history and culture.	Chongqing is one of the least sunniest places in China. Winters in Chongqing is chilly, but not cold (the average January temperature is 7.9°C), with very little temperature variations. Summers are hot and very humid. Chongqing is actually one of the hottest and least pleasant places in China during summertime. Temperatures almost never fail to reach 30°C. \r\n\r\nThe original name of Chongqing was Jiangzhou until it was renamed during the Northern and Southern dynasties to Chu Prefecture, then to Yu Prefecture in 581 AD and to Gong Prefecture in 1102. It received its current name in 1189 from Prince Zhao Dun of the Southern Song Dynasty. A peasant Rebellion in 1362 established the Daxia Kingdom in Chongqing for a short time. In 1890, the British Consulate General was opened in Chongqing, making the city the first inland commerce port open to foreigners. From November 1937 to May 1946, it served as the capital of China. 	Chongqing is the largest of the four direct-controlled municipalities of the People's Republic of China. The municipality is divided into 38 subdivisions. The urban area of Chongqing is known as Central Chongqing, including Yuzhong District, Jiangbei District, Shapingba District, Jiulongpo District, Nan’an District, Dadukou District, Banan District, Yubei District, and Beibei District.\r\n\r\nWith its political history comes a number of historic sights which are worth visiting. When Chongqing was the capital of China, Jiang Jieshi established his military headquarters up in the Nanshan mountains, on the east bank of the Yangtze River. Travelers can visit his workroom with his famous motto and his meeting room, where he negotiated with the American advisers. Zhou Enlai, a famous political leader who worked as a member of the Communist Party alongside Mao Zedong, old house has been preserved well and now a museum that is open to the public.\r\n\r\nFor a modern spot, Chongqing Jiefangbei Pedestrian Street is the commercial heart of the city. It is formerly known as the Monument of Victory in the Anti-Japanese War. Today, it contains numerous glassy office skyscrapers, shopping centers, and luxury hotels. \r\n	Chongqing food, being part of Sichuan cuisine, is known for its spicy food. Its food is normally considered numbing because of the use of Sichuan pepper (Huajiao). Different from many other Chinese cuisines, Chongqing dishes are suitable for the solo diner as they are often served in small individual sized portions. Local Specialities here include Chongqing Hotpot, Chongqing noodles, JIangtuan fish, Quanshui Chicken, Huiguorou, and Xiaomian. Some of the best restaurants for hotpot is the Bajiumen Hotpot, Chongqingchao Hotpot, Laozihao Dongting Hotpot, and Tuhuo Chongqing law Hotpot. To try some street food, the Jiefangbei Bayilu Food street is the best place.	Here's where you can find all the best hotels in the city.	Here is the weather	15384000	The Bund	8	t	t	t	f	f	t	29.558333, 106.566667	chongqing	22	qsprovince_id
13	Dali	大理	An old town set on a beautiful lake in the mountains, what more could you want	images/city/Dali/Dali.jpg	images/city/Dali/Dali_large.jpg	Dali City, located in Southern China, is the county-level seat of the Dali Bai Autonomous Prefecture in northwestern Yunnan. Famous for its old town, Dali is one of the most popular spots for travelers who are looking for a place to relax.	Dali, just as what most people know it for, has a long and glorious history. In 738, the Nanzhao Kingdom was established with Dali as its capital and covered a large area of Yunnan and northern Burma and parts of Sichuan and Guizhou. The Kingdom of Dali later emerged. It was established by Duan Siping in 937 and controlled by the Duan clan and survived until conquered by the Mongol in the 12th century. It was one of the major transit points for the introduction of Buddhism throughout the rest of China in the Tang Dynasty. In the late 1800s, Dali was the headquarters of the Panthay Rebellion led by Du Wenxiu. The rebellion was brutally crushed by the Qing and hundreds of thousands of Yunnan Muslims were killed in revenge.\r\n\r\nThe climate is temperate with moderate summers and mild winters, though it can get rather windy in autumn and winter and the tropical latitude means some will need to bring extra sunblock.	Dali is the seat of Dali Prefecture and includes Dali New City and Dali Old Town. When discussing or traveling to Dali, it is important to be clear which one you are talking about.\r\n\r\nOld Town has located about 13 kilometers away from Xiaguan Dali City. With Erhai Lake to the east and Cangshan Mountain to the west, its grand city wall, traditional Bai ethnic minority folk houses, and marvelous scenery have been attracting many visitors. Tang Dynasty Three Pagodas are worth visiting for a beautiful overlook of Dali old Town and Erhai Lake and a peak of Tang’s architecture.\r\n\r\nErhai Lake is another popular attraction of Dali. Its beautiful relaxing view allows travelers to appreciate the nature. You can take a ferry ride, bike around the lake, or go to Erhai Lake Villages when you are there. \r\n\r\nYou should also plan to spend at least a day in the Cangshan Mountains. It is a place of blissful peace, especially if you stay in the Temple. The mountains are a national level Geopark and Nature Reserve. You will find a variety of beautiful plants, spectacular views, and the peaceful temple there. 	Dali is perhaps most well-known for dishes historically cooked by the Bai, one of its ethnic minority groups, and should certainly not be missed by those stopping in the area. Some local dishes and snacks include the Stewed Carp Casserole, Steamed Chicken, Dairy Fans (it is actually a kind of cheese made of local milk, but shaped like fans), Er Kuai, and Xizhou Town Baba.\r\n\r\nHowever, as a popular tourist destination, you can find almost all kinds of food, including Western food in Old Town. Some restaurants recommendations are Baldy’s Beer Garden. Bill’s Place, La Dolce Vita, and LP Cafe.	Most people choose to stay in Dali Old Town on the western side of the lake. The ancient village has a touristy feel and plenty of nightlife, the only thing is it's a few kilometres from the lake. Alternatively you can stay in the main Dali City (Xiaguan) on the southern side of the lake, especially if you are after something more modern. The best Dali experience however has to be staying in one of the boutique inns on Erhai Lake, which range from super cheap to absolute luxury. They're mainly found along the western side of the lake, but there are also quite a few on the hills overlooking the lake near the airport on the eastern side.	Here is the weather	652000	The Bund	9	t	t	t	f	f	t	25.6, 100.266667	dali	25	qsprovince_id
14	Dalian	大连	Here is an example of a short description	images/city/Dalian/Dalian.jpg	images/city/Dalian/Dalian_large.jpg	Located in the south of Liaodong Province, Dalian is a major city and seaport. Being the southernmost city of the Liaodong Peninsula, it is the Province’s second largest city and has sub-provincial administrative status, which means the city is administered independently regarding economy and law. Today, it consists of the formerly independent cities of Dalian and Lushun.  The Shandong Peninsula lies southwest across the Bohai Strait and separates the Bohai Gulf to the west from Korea Bay to the east. Dalian has a population of 6.17 million in the year of 2010. Dalian‘s January mean temperature is about -5 °C and for July is 23 °C. Rainy season is over the summer months.	Lushun is historically known in the West as Port Arthur since it was an important port of entry for southern Manchuria. Before it was captured by the Manchus in 1633 and became the headquarters of a coastal defense unit under the Qing Dynasty, it was used as a staging post in the 2nd century BCE by Chinese colonists of the Han Dynasty and by the Tang Dynasty in campaigns in the 7th century. In the late 19th century and early 20th century, it was also invaded by Japanese in the Sino-Japanese War and the Soviet Union. Under the Japanese, Dalian became a major industrial center, mainly focused on the chemical industry. 	Travelers mainly visit Dalian for its beautiful sea, beaches, museums, and its international ambiance. Dalian has a coastline of 2,906 kilometers. Zhongshan District is the home of Dalian’s financial and commercial center. You can still see the remnants of its history in the district with squares and avenues with grand Russian and Japanese built architecture. The district also contains part of the coastline. There are several beaches and scenic areas such as Binhai Lu, Bangchuidao Beach and Golf Course, and Tiger Beach. You can also climb to the TV Tower on top of a hill south of Labor Park to see the view of Dalian while enjoying food in a restaurant. \r\n\r\nXigang District is the home of the municipal government district and People’s Square. Russian street is one of the places you can have a glimpse of Dalian’s colonial past. People’s Square, where the seat municipal government buildings are housed, may interest those who want to enjoy a picnic while enjoying historic architecture, kite flying, etc. \r\n\r\nShahekou District is mainly a residential area. However, the Xinghai Square and many universities in the district may attract visitors. \r\n	Dalian’s local cuisine is influenced by Dongbei regional style of cooking and the city’s proximity to the sea. Unlike many other local cuisines of China, buns, pancakes, and dumplings are staples rather than rice or noodles. Some of the well-known dishes are Sizzling Grilled Squid, Red Roasted Whole Shrimp, Steamed Lantern Abalone, Multi-colored snowflake Scallops, and Salted Fish Cake. For seafood, Wanbao Seafood Resturant is one of the best places to go. Because of Dalian’s proximity to Korea, you can also try some authentic Korean cuisine at restaurants like Handu Restaurant. 	Here's where you can find all the best hotels in the city.	Here is the weather	4078000	The Bund	100	t	f	f	f	f	t	38.920833, 121.639167	dalian	7	qsprovince_id
15	Dandong	丹东	Here is an example of a short description	images/city/Dandong/Dandong.jpg	images/city/Dandong/Dandong_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	dandong	7	qsprovince_id
16	Datong	大同	Here is an example of a short description	images/city/Datong/Datong.jpg	images/city/Datong/Datong_large.jpg	Datong, located in a basin that borders Inner Mongolia to the north and west and Hebei to the east, is a prefecture-level city in northern Shanxi Province. It has a population of 3.4 million as of 2010.	The area of present-day Datong was close to the Beidi state of Dai, which was conquered by the Zhao clan in 457 BCE. It used to be a frontier land between the agricultural Chinese and Beidi and the nomads of the Eurasian steppe. In 200 BCE, the Han founded a site within Datong following their victory against the Xiongnu nomads at the Battle of Baideng. Pingcheng, which is present-day Datong, blossomed during the period following the Battle of Baideng as a stopping point for camel caravans moving from China into Mongolia and beyond. Pingcheng became the capital of Northern Wei from AD 398-494. The city was renamed Datong in 1048. It was also the western capital of the Jurchen Jin Dynasty prior to being sacked by the Mongols. Despite being partially destroyed, the city wall has been recreated from scratch, enclosing a retinue of renovated sights. \r\n\r\nDatong has rather long, cold, very dry winters and very warm summers. The rainy season is usually from June to September.	There are totally ten districts in Datong. Much of Datong’s old town has been recreated, aiming to restore its ancient grandeur and charm. Much of the construction is now finished. A documentary about the mayor who is behind the project, called the Chinese Mayor, is available created by Chinese filmmaker Hao Zhou. Within the city itself, there are a few surviving sites of historical interest such as the Nine-Dragon Wall, the Huayan Monastery, and the Shanhua Temple. Further afield is the Hanging Temple built into a cliff face near Mount Heng. Most of the historical sites in this region date to the Tang and Ming dynasties, but the Hanging Temple dates to the Northern Wei Dynasty (386–534).\r\n\r\nThe Yungang Grottoes is a 1500-year-old mountainside cave and recesses filled with Buddhist statues. It is listed on the UNESCO World Heritage Site. There are also scenes depicting Buddhist teachings and famous monks. Lodged precariously on a cliff-face, the Hanging Monastery is an interesting attraction for those who are adventurous.	Datong’s local cuisine features various wheaten foods. They tend to be a little salty. The most famous dishes and local flavor snacks are very much worth tasting: instant-boiled lamb, cat ear noodles, pea noodles, naked oats noodles, dried bean curd, yellow cake, crisp soybeans, Yanggao dried apricot, etc. Hotpot is also popular in Datong. A popular hotpot spot is Madaha Hotpot. You can find plenty of delicious snacks, such as meat skewers, Korean spicy rice cakes, and Huntun noodle soup,  in the evening sell by outdoor street stalls and tables. There are also various small restaurants near the restored wall, especially on Danan Street.	Here's where you can find all the best hotels in the city.	Here is the weather	1737000	The Bund	100	t	f	f	f	f	t	40.083333, 113.3	datong	5	qsprovince_id
17	Dehong	德宏	Here is an example of a short description	images/city/Dehong/Dehong.jpg	images/city/Dehong/Dehong_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	dehong	25	qsprovince_id
18	Dongguan	东莞	Here is an example of a short description	images/city/Dongguan/Dongguan.jpg	images/city/Dongguan/Dongguan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	23.033333, 113.716667	dongguan	19	qsprovince_id
19	Dujiangyan	都江堰	Here is an example of a short description	images/city/Dujiangyan/Dujiangyan.jpg	images/city/Dujiangyan/Dujiangyan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	dujiangyan	23	qsprovince_id
20	Dunhuang	敦煌	Here is an example of a short description	images/city/Dunhuang/Dunhuang.jpg	images/city/Dunhuang/Dunhuang_large.jpg	Dunhuang, a country-level city in northwestern Gansu Province, was a city on the old Silk Road. According to the 2000 Chinese census, the city has a population of 187,578. 	In ancient times, Dunhuang was the point at which the two branches of the Silk Road converged. It was first brought under Chinese control in the Han dynasty at the end of the 2nd century BCE. After the decay of Han central power, Dunhuang became semi-independent; in the 4th and 5th centuries CE, it successively formed part of kingdoms centred in Gansu. Throughout this period Dunhuang remained an important caravan town and commercial centre for trade with Central Asia. In the late 5th century the Bei (Northern) Wei dynasty (386–534/535) brought Dunhuang back under Chinese domination. In the 15th century, however, Dunhuang was overrun by the Turfan kingdom and was abandoned. The present-day city of Dunhuang was established east of the ruined old city in 1725. By the early 1970s Dunhuang’s importance as a trading centre had been largely lost, since the highway and railway built across the Uygur Autonomous Region of Xinjiang had bypassed the city to the north at Anxi. However, tourism has grown since the mid-1980s.	Travelers have dozens of things to do in Dunhuang. As a historical city of China as well as an important culture and trade center along the ancient Silk Road, Dunhuang has many magnificent historical sites, including the Mogao Caves, West Thousands of Buddha Caves, Yumenguan Pass, Yangguan Pass, etc. The spectacular geography of gobi and desert creates many wonderful natural landscape, such as the stretching Mingsha Mountain, unique Crescent Lake, Yadang Landform, etc.\r\n\r\nYou can take a Silk Road journey to explore the footprints of ancient trace of Silk Road, riding a camel just like that the ancient travelers did. Also, the Mogao Caves, a UNESCO World Heritage Site, recorded the 1600 years’ development of Chinese arts from ancient time. It is the treasure house of Buddhist arts, also a unique place of cross-culture. The Huyang Forest is also another natural scenery, consisting of a small forest of rare poplar trees (Populus Diversifolia), some of which are more than 600 years old. 	Close to Xinjiang, food in Dunhuang combines features of both Xinjiang cuisine and Lanzhou food. Mutton is very popular local food. Flour foods such as minced noodles are delicious. Those who want spicy food can eat Ma La Tang (a kind of Chinese hotpot) in restaurants along streets.\r\n\r\nSmall but authentic restaurants are very easy to find such as the Daji Lvrou Huangmian Restaurant famous for Yellow Noodles with Donkey Meat. In addition, Shazhou Night Market is a must for tasting local snacks.\r\n\r\nSome traditional dishes include Camel Hoof on Silk Road, Stir-fried Hump with Five Shredding, Three Treasures of Anxi, Niang Pi Zi, and Apricot Peel Water.	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	40.15, 94.666667	dunhuang	28	qsprovince_id
21	Emei Shan	峨眉山	Here is an example of a short description	images/city/Emei Shan/Emei Shan.jpg	images/city/Emei Shan/Emei Shan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	emeishan	23	qsprovince_id
22	Enshi	恩施	Here is an example of a short description	images/city/Enshi/Enshi.jpg	images/city/Enshi/Enshi_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	enshi	17	qsprovince_id
23	Foshan	佛山	Here is an example of a short description	images/city/Foshan/Foshan.jpg	images/city/Foshan/Foshan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	7197000	The Bund	100	f	f	f	t	f	f	23.016667, 113.116667	foshan	19	qsprovince_id
24	Fuzhou	福州	Here is an example of a short description	images/city/Fuzhou/Fuzhou.jpg	images/city/Fuzhou/Fuzhou_large.jpg	Fuzhou, the capital and one of the largest cities in Fujian Province, lies on the north bank of the estuary of Fujian’s largest river, the Min River. As of 2017, the city has a population of 7.64 million. 	Fuzhou was one of the first places in Fujian to be settled. The remains of two Neolithic cultures—the Huqiutou Culture, from around 5000 BC, and the Tanshi Mountain Culture, from around 3000 BC—have been discovered and excavated in the Fuzhou area. At the beginning of the 2nd century BCE, it was called Ye, and it was once the capital of the kingdom of Min-Yue. In 592, after the Sui conquest of southern China (581), it was renamed Min county, and under the Tang dynasty (618–907) it became the seat of Fuzhou prefecture. After the An Lushan rebellion of 755 it became the seat of the civil governor of Fujian. In the 9th and 10th centuries the population of Fujian as a whole rapidly increased. Fuzhou prospered from the 16th to the 19th century, and its prosperity reached its height when it was opened as a treaty port after the first Opium War. With the outbreak of the Sino-Japanese War in 1937, hostilities commenced in Fujian Province. By 1941, the city is recorded as having returned to Nationalist control.	Fuzhou is a city that boasts both natural and manmade sights.\r\n\r\nThere are many famous mountains to hike and have a good view of the city. Some of the most famous one include Gu Mountain, Wuyi Mountain , Baiyun Mountain, Wu Mountain, and Qi Mountain. Famous temples include Yongquan, Xichan, Linyang, Fahai and Yunju etc. Famous tombs like Tomb of Lin Zexu etc. Famous gardens include West Lake etc. Famous towers include the White, Wu and Luoxing etc. Famous bridges include Wanshou and Longjiang etc. Many former residences of celebrated historical figures scatter at Sanfang Qixiang.\r\n\r\nMore attractions are Wuyi Square, a central square with a huge statue of Mao, and Three Lanes and Seven Alleys, a historic district in the heart of the city. At Wuyi Square, you can watch the ceremonial raising or lowering of the flag by highly trained and immaculate soldiers. You may find that there are far too many things to see here in one short trip\r\n	Fuzhou dishes are representative of the Min Cuisine that is very much a feature of Fujian Province and is one of the Eight Major Cuisines of China . Min has its own unique style that has evolved over a very long period of time and each of the various recipes are very precise with an emphasis placed on their savory sauces. These sauces are mild and of a sweet and sour nature and together with meats and vegetables that are cut and prepared in a particular manner, combine into wonderfully appetizing dishes.\r\n\r\nSome of the most famous dishes are Ji Tang Tun Hai Bang, Li Zhi Rou, and Yu Ni. 	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	26.076111, 119.306389	fuzhou	13	qsprovince_id
25	Guangyuan	广元	Here is an example of a short description	images/city/Guangyuan/Guangyuan.jpg	images/city/Guangyuan/Guangyuan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	guangyuan	23	qsprovince_id
26	Guangzhou	广州	The former city of Canton embodies the China of the south	images/city/Guangzhou/Guangzhou.jpg	images/city/Guangzhou/Guangzhou_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	Title	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	19800000	The Bund	4	t	t	t	f	f	t	23.133333, 113.266667	guangzhou	19	qsprovince_id
27	Guilin	桂林	Nestled in the mountains, Guilin is one of the top tourist destinations in the country	images/city/Guilin/Guilin.jpg	images/city/Guilin/Guilin_large.jpg	Guilin, situated on the west bank of the Li River and borders Hunan to the north, is a prefecture-level city in the northeast of China’s Guangxi Zhuang Autonomous Region.	Guangxi and Guilin are home to 12 different ethnic minorities besides the Han Chinese. The literal translation of its name, Guilin, is “Forest of Sweet Osmanthus”, owing to a large number of fragrant sweet osmanthus trees located in the city. It has always been one of the most popular tourist destinations for its natural beauty and historic treasures. It has a population of 4.748 million as of 2010, including 28 ethnic minority nationalities. \r\n\r\nGuilin has short, mild winters, and long, hot, humid summers. Winter begins dry but becomes progressively wetter and cloudier. Spring is often rainy, while summer continues to be rainy though is the sunniest time of year. Autumn is sunny and dry.\r\n\r\nThe first hint of the city was in 314 BCE, a small settlement along the bank of Li River. In 111 BCE, during the reign of Emperor Wu of the Han Dynasty, Shi An County was established, which many people think of as the beginning of the city. Although it remains as a county, Guilin prospered in the Tang and Song dynasties. Guilin was important since it is a nexus between the central government and the southwest border. Armies were placed there to guard the border. In 1921, Guilin became one of the headquarters of the Northern Expeditionary Army led by Sun Yat-sen.	Guilin is a well-developed tourist center with convenient transportation, communication and accommodation facilities. Guilin has a total number of seventeen county-level divisions, including six districts, and nine counties, and two autonomous counties. The landmarks of Guilin are Central Guilin Square, Jingjiang Prince City, and Moon and Sun Pagoda.\r\n\r\nSpeaking of natural beauty scenery, Li River is one of the most popular attractions in Lijiang. The river winds and meanders its way for 170 kilometers, passing through Guilin, Yangshuo to the outlet of Gongchen River in Pingle County. Some other landscapes that are close to the city center include Diecai Mountain ( a collection of peaks built into a park), Fubo Hill, Elephant Trunk Hill, Peach Blossom River, Reed Flute Cave, Solitary Beauty Peak, Yaoshan Hill Park.\r\n\r\nIf you are looking for some places outside of the city center, there are also plenty, The Crown Cave is about 45 minutes away by car, and Gudong Waterfall is close to Crown Cave.	Local food in Guilin is heavily influenced by the food of Canton, Sichuan, Hunan, Zhejiang, Jiangxi, and Fujian. Tourists from around the world are sure to find that your need is met beyond your expectations, from splendid restaurants to local snacks. The most popular local snacks include local rice noodles (mifen), nun noodles, chestnut glutinous rice dumplings (banli zong), stewed duck with gingko, lotus-leaf duck and stewed duck with ginger, and Fengli.\r\n\r\nThere are a few restaurant streets that are worth exploring: Renmin Rd., still water food street, Binjiang Rd., Shangshui Snack Street, Nanhuan Rd., and Guilinren Wangjiao Food Street.	Here's where you can find all the best hotels in the city.	Here is the weather	975000	The Bund	6	t	t	t	f	f	f	25.266667, 110.283333	guilin	20	qsprovince_id
34	Hong Kong	香港	Here is an example of a short description	images/city/Hong Kong/Hong Kong.jpg	images/city/Hong Kong/Hong Kong_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	22.3, 114.2	hong-kong	33	qsprovince_id
35	Hua Shan	花山	Here is an example of a short description	images/city/Hua Shan/Hua Shan.jpg	images/city/Hua Shan/Hua Shan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	huashan	27	qsprovince_id
28	Guiyang	贵阳	Here is an example of a short description	images/city/Guiyang/Guiyang.jpg	images/city/Guiyang/Guiyang_large.jpg	Guiyang, the capital of Guizhou Province, it is located in Southwest China, situating on the east of the Yunnan-Guizhou Plateau and on the north bank of the Nanming River. The city is renowned for its colorful culture, represented by various ethnic groups and its special landform - Karst. Guiyang is home to more than 30 minority ethnic groups including, Miao, Buyi, Dong and Hui. As of 2010, the population of Guizhou is 4,324,561. The climate is often mild and moist, neither extremely hot nor cold. Spring, summer, and autumn are all wonderful seasons for sightseeing.	Guiyang was a 7th-century military outpost under the Sui and Tang, when the area around it was known as Juzhou. It grew into a city named Shunyuan under the Mongolian Yuan dynasty some time between their 1279 southwestern campaigns and 1283. By the time Guizhou became a full Province in 1413, its capital at Guiyang was also known as Guizhou. It became a prefectural seat under the Ming and Qing. Guiyang grew rapidly during the development of the southwest that occurred after the Japanese invasion of China during World War II. It has also grown rapidly since Deng Xiaoping's economic reforms reached it in the 1990s.	The entire Guiyang municipality currently consists of six districts, one county-level city and three counties. The districts are Nanming, Yunyan, Huaxi, Wudang, Baiyun and Guanshanhu. The county-city is Qingzhen and the counties are Kaiyang, Xifeng and Xiuwen.\r\n\r\nGuizhou is abundant in tourism resources. Distinct Karst Landform endows it with grotesque mountains, limpid rivers, and fascinating caves. There is not only beautiful natural scenery, such as the Hongfeng Lake Scenic Area (the Red Maple Lake) and Baihua (Hundred Flower) Lake; but also cultural landscape, such as Qingyan Ancient Town, Xifeng Concentration Camp and Yangming Cave. Besides, the colorful minority customs and festivals add more charm to it.\r\n\r\nSome of the most famous attractions include, Qianling Park, a large city park with local foods and crafts from vendors and wild monkeys; Hebin Park Tianhe Tan, a cave, canal, and waterfall park in Huaxi township; and South River Grand Canyon, a majestic view with waterfall group. \r\n	The local food is spicy, some like the Sichuan Cuisine, or Hunan Cuisine. The Miao people in Guizhou prefer sour flavor; their Fish in Sour Soup is a must-try. Various local snacks are inexpensive but tasty, including the Si Wa Wa (Pancake with Shredded Vegetable), Rice Tofu, and Huaxi Rice Noodles with Beef. The North Ring Road, Erqi Road; and Hequn Road are the most popular night food markets.\r\n\r\nBe sure to try Bean Hotpot (豆米火祸 dōumǐhuǒguō) which is available all around the city. This differ from other hotpots because it is in a soup made of pinto beans, bacon, and onions.\r\n\r\nMinority cuisines are also readily available throughout Guiyang. One of the most common and delicious varieties available is the Miao Minority's Suan Tang Yu. 	Here's where you can find all the best hotels in the city.	Here is the weather	3483000	The Bund	100	f	f	f	t	f	f	26.65, 106.633333	guiyang	24	qsprovince_id
29	Haikou	海口	Here is an example of a short description	images/city/Haikou/Haikou.jpg	images/city/Haikou/Haikou_large.jpg	Haikou, the capital and most populous city of Hainan Province, is situated on the northern coast of Hainan, by the mouth of the Nandu River. The northern part of the city is the district of Haidian Island, which is separated from the main part of Haikou by the Haidian River, a branch of the Nandu.	Haikou originally served as the port for Qiongshan, the ancient administrative capital of Hainan island.  During its early history Haikou was a part of Guangdong Province. In the 13th century it was fortified and became a military post under the Ming dynasty (1368–1644). When Qiongshan was opened to foreign trade under the Treaty of Tianjin in 1858, Haikou started to rival the old administrative city. In 1926, Haikou overtook Qiongshan in population and it was declared a separate administrative city. Haikou was developed as a port during the Sino-Japanese War (1937–45) when the Japanese invaded and occupied Hainan Island from early 1939 to 1945. The city and island of Hainan stayed under the control of the Nationalists until April 1950, when it fell to the Communists during the Landing Operation on Hainan Island. Since 1949, Haikou has maintained its position as Hainan's main port, handling more than half of the island's total trade.	Haikou is divided into four districts: Longhua, Xiuying, Qiongshan, and Meilan districts.\r\n \r\nWith the sea on three sides, Haikou enjoys a long coastline that features excellent bathing beaches and seaside resorts. Holiday Beach is the most popular of these, while Xixiu Beach is where the national sailing and windsurfing teams train and hold competitions. Dongzhai Harbor Mangrove Natural Reserve Area in the northeast of Haikou is a typical tropical jungle and a heaven for birds.\r\n\r\nBesides its natural resources, Haikou has a number of important sites of historical interest. The Temple of Five Lords (Five Official's Temple), the Tomb of Hai Rui, a famous official in the Ming dynasty, and the Xiuying Emplacement each serve as reminders of the historical importance of the city. In addition, Xiuying Battery, a 19th century coastal fort near Evergreen Park, and Qiongtai Academy, established in commemoration of Qiu Jin; it is believed to be the most brilliant scholar in Hainan and a renowned Ming Dynasty scholar. 	It goes without saying that for anyone coming to Haikou, seafood is definitely a must. However, the city is also famous for its other prized dishes. There are four to delight the gourmet and should not be missed. They are Wenchang Chicken, Dongshan Mutton, Jiaji Duck and Hele Crab. The climate means there is an abundance of fresh local fruits such as mangos, pineapples, jackfruits, coconuts and carambola, betel nuts, pawpaw, longan and lychee, loquat, naseberry and passion fruit.\r\n\r\nTourists can go to the Longkun South Road. There they can enjoy all kinds of seafood in Haikou. The seafood is not so expensive and very delicious. Jinlong Road is also one of the most famous food streets. There tourists can taste the delicious foods from all parts of China. For those who want to taste Hainan local snacks, the Boai South Road is the place we strongly recommend. There tourists can taste the real Hainan Rice Noodles and other delicious local snacks.	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	0,0	haikou	21	qsprovince_id
30	Hangzhou	杭州	Here is an example of a short description	images/city/Hangzhou/Hangzhou.jpg	images/city/Hangzhou/Hangzhou_large.jpg	Hangzhou, located in the northern part Zhejiang Province on the north bank of the Qiantang River estuary, acts as a political, economic, and cultural center of Zhejiang Province. Known for its natural scenic beauty and historical and cultural heritage, it is one of the most important tourist cities in China. To the south, it has water communication with the interior of Zhejiang; to the north, it is linked to the network of canals and waterways that cover the Yangtze River delta area. The city also stands at the eastern foot of a scenic range of hills, the Tianmu Mountains, and on the shore of Xi Lake (Xi Hu).	Hangzhou is extremely humid in summertime, from early June to early September. The temperatures in winter usually range from 2°C to 9°C with occasional snowfalls. In the summer, Hangzhou becomes a sauna with lots of rainfall in the form of thunderstorms. Although heat waves are not common, the humidity makes the heat more unbearable than it seems like.\r\n\r\nThe history of Hangzhou dates to the start of the Qin Dynasty (221 BCE). Hangzhou flourished when it was linked with the Grand Canal and became the capital of the Southern Song Dynasty. The Taiping rebels in 1861 besieged and captured the cities until the imperial armies reclaimed it two years later. The campaigns reduced almost the entire city to ashes. Therefore, much of what can be seen in Hangzhou today is fairly recent. 	Hangzhou has nine municipal districts: Gongshu District, Shangcheng District, Xiacheng District, Jianggan District, Xihu District Binjiang District, Xiaoshan District, Yuhang District, Fuyang District, and 3 county-level cities of Jiande, Fuyang, and Lin’an, and the 2 counties of Tonglu and Chun’an. Xihu and Shangcheng Districts house most of the natural and historic and cultural attractions. There are a lot to do in the Xi Lake Scenic area, such as going on a boat ride, visiting the Broken Bridge, the Lesser Yingzhou Isle, Mid-Lake Pavilion, and Lord Ruan’s Mound, etc. The Leifeng Pagoda, built in the year 977 on the shores of the southeast side of the lake, is also worth visiting. Also don’t forget to go to the Lingyin Temple, one of the three oldest and most famous temples in China.\r\n\r\nShangcheng District takes historic & cultural sites as highlights, including Hu Xueyan's former residence, Hu Qingyu Traditional Pharmacy, Hangzhou Drum Temple, Confucius Temple, Wang Song Academies, Song Dynasty Town, etc. \r\n	Hangzhou is one of the premier places to eat in China. Its local cuisine features dishes that have more of pork and seafood than other meat options. Some iconic dishes include Dongpo Rou, an extremely fatty chunks of pork in a syrupy sauce; West Lake Cu Yu, fish in a vinegar sauce; Beggar’s Chicken, stuffed chicken wrapped in clay and slowly baked at low heat; and Lotus Root Pudding. For authentic local cuisine, Lou Wai Lou, Oriental Favorites Restaurant, and Grandma’s Kitchen are some of the best restaurants. If you want more options, you can always find plenty of excellent restaurants featuring Western, Southeast Asian, and Japanese cuisines. 	Here's where you can find all the best hotels in the city.	Here is the weather	10018000	The Bund	100	t	f	t	f	f	t	30.25, 120.166667	hangzhou	11	qsprovince_id
31	Harbin	哈尔滨	Here is an example of a short description	images/city/Harbin/Harbin.jpg	images/city/Harbin/Harbin_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	45.75, 126.633333	harbin	9	qsprovince_id
32	Hefei	合肥	Here is an example of a short description	images/city/Hefei/Hefei.jpg	images/city/Hefei/Hefei_large.jpg	Hefei, the capital and the largest city of Anhui Province, is located in the central portion of the Province, bordering Huainan to the north, Chuzhou to the northeast, and Anqing to the southwest. It is the key tourist city of the whole Province and the best place to know about the brilliant Anhui culture. Hefei has a population of 7.8 million, making it the largest in Anhui Province.	From the 8th to the 6th century BCE, Hefei was the site of the small state of Shu, later a part of the Chu kingdom. The name Hefei was first given to a county set up in the area under the Han dynasty in the 2nd century BCE. During the Sui (581–618) and Tang (618–907) periods, it became the seat of Lu prefecture—a title it kept until the 15th century, when it became a superior prefecture named Luzhou. The present-day city dates from the Song dynasty (960–1279). From 1127 it became a centre of the defenses of the Nan Song dynasty(1127–1279) against the Jin (Juchen) invaders, as well as a flourishing centre of trade between the two states. When the Chinese republic was founded in 1911/12, the superior prefecture was abolished, and the city took the name Hefei.	Hefei is divided into four districts, including Yaohai, Luyang, Shushan, and Baohe districts.\r\n\r\nHefei has many famous historical sites. First of all, Lord Bao Park is one of the famous destinations. Within the Park, there are the Memorial Temple of Lord Bao, Lord Bao’s TOmb and Qingfeng Chamber. He is a renowned officer in the Northern Song Dynasty because of his excellent personality, fair-minded judgments, and strict family education. In addition, Xiaoyaoji Park is a beautiful park with various recreational facilities and an ancient battlefield in the Three Kingdoms period. There are also many other parks like Around the City Park,  Yaohai Park, Hefei Botanical Garden.\r\n\r\nSome other famous attractions include Dashu mountain, Kai Fu Buddhist Temple, Hefei Zoo, Snow Villa, Anhui Hall of Fame. Emerald Lake Scenic Area, Swan Lake, Chao Lake, Bin Hu Wetlands, and Hefei Pedestrian Mall (you can also find Li Hongzhang Residence and Hefei Mingjiao Temple here), and Anhui Provincial Museum.	Due to Hefei's location, it has the cuisine styles of surrounding regions, but it still retains the style of its own cuisine. Visitors to Hefei can have special dishes like Lord Bao Fish, Caocao Chicken, Grape Shape Fish, Stir-Fried Shrimp and Luzhou Roast Duck.\r\n\r\nLuzhou Roast Duck is the first recommended delicacy in the city and it tastes very good. Other special, high quality products will also satisfy your appetite such as Mabing (sesame cake), Honggao (baked cake), Cunjin (sesame cookie) and Baiqie (white sesame slices). These cookies are crispy, sweet, and fragrant. These snacks can be bought in a store called Zhang Shunxin that is one hundred years old. Also, dumpling-making is a delicate and intricate process and, there are various shapes of dumplings that will excite and satisfy your appetite.	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	0,0	hefei	12	qsprovince_id
33	Hohhot	呼和浩特	Here is an example of a short description	images/city/Hohhot/Hohhot.jpg	images/city/Hohhot/Hohhot_large.jpg	Hohhot, the capital of Inner Mongolia, is located in the north of China. The name of the city in Mongolian means "Blue City", associated with the sky, eternity, and purity. Its population was 2,866,615 recorded in the 2010 census.	The original Mongol city Kuku-khoto was founded in the 16th century and was an important religious centre for Tibetan Buddhism.  In the mid-17th century, at the end of the Ming period (1368–1644), the area began to be settled by Chinese, who farmed the fertile plain and named the city Guihua (meaning “Return to Civilization”). Eventually, in the mid-18th century, a new Chinese city, named Suiyuan, was founded north of the old one.  Later the two cities were combined under the name Guisui, and that city became a considerable frontier market with a large Muslim trading community. During the Japanese occupation (1937–45) it became the capital of the pro-Japanese autonomous region of Mengjiang. Before World War II, Hohhot was still primarily a trading centre, although its importance had grown rapidly since the completion in 1922 of the railway linking it to Beijing and Tianjin to the southeast and Baotou to the west. By the early 1970s, however, expansion of cultivation to the north of Hohhot had attracted major tractor and diesel engine factories to the city.	Hohhot is an ideal place to relax away from stress thanks to the magnificent natural beauty of the Gegentala and Xilamuren Grasslands as well as fantastic cultural sites. On the grassland, you could enjoy a wide variety of featured activities including horse riding, visiting the home of a herdsman’s family, roaming over the grassland, and tasting the local cuisine. The hospitality of Mongol in Hohhot, home to 36 ethnic groups, will allow you to learn about and experience their cultures and traditions in unique ways. The Grand Naadam Festival, the biggest festival in Inner Mongolia held in each July or August will have events like wrestling, horse racing, and archery, etc.\r\n\r\nThe top attractions in Hohhot include Dazhao Temple, the oldest and largest temple in Hohhot built in 1580 during Ming Dynasty; Inner Mongolia Museum, a local comprehensive museum; Five-Pagoda Temple, a miniature temple built in Indian style; Zhaozhun Tomb, a large and man-made earthen mound for Han princess; the Great Mosque, the earliest and largest mosque among the eight mosques in Hohhot. \r\nsuch as the Dazhao Temple, Five-Pagoda Temple and the Xilituzhao Palace.	In Hohhot, you will have a taste of typical Mongolian food and drinks, such as milk tea, toasted millet, boiled skim milk, cream, and tender finger mutton. People from Inner Mongolia eat almost every part of the lamb. Roasted lamb chop, fried mutton, parched lamb intestines, steamed lamb heart, mutton stuffed bun, and boiled lamb viscera soup are all authentic dishes worth trying. The most famous dish in town is undoubtedly the Mongolian hotpot, which can be found in most restaurants here. And wine is an essential part of the Mongolian dinner table. Every tourist will enjoy the food here.	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	0,0	hohhot	6	qsprovince_id
36	Huang Shan	黄山	Here is an example of a short description	images/city/Huang Shan/Huang Shan.jpg	images/city/Huang Shan/Huang Shan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	huangshan	12	qsprovince_id
37	Jilin City	吉林	Here is an example of a short description	images/city/Jilin City/Jilin City.jpg	images/city/Jilin City/Jilin City_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1975000	The Bund	100	f	f	f	t	f	f	43.866667, 126.55	jilin	8	qsprovince_id
38	Jinan	济南	Here is an example of a short description	images/city/Jinan/Jinan.jpg	images/city/Jinan/Jinan_large.jpg	Jinan, the capital of Shandong Province, lies in the northern foothills of the Mount Tai massif and south of the Yellow River, which provides the major route along the north side of the Shandong Hills. Jinan carries the nickname City of Springs because of the many artesian wells that bubble up within the city limits.	From the 8th century BCE it was the site of Lixia, a major city of the state of Qi, which flourished in the Zhou period (1046–256 BCE). Later, in the 2nd century BCE, the town became the seat of Licheng county in the commandery of Jinan. Jinan remained an important centre of administration, under various names, during the next two centuries and also became a major religious centre. When the Ming dynasty(1368–1644) created Shandong Province, Jinan became its capital.  Jinan’s modern growth began in 1852, when the Huang He shifted its course to the old riverbed of the Ji, just north of the city. In 1904 Jinan’s growing importance as a transport centre was increased when a German-built railway was completed from Qingdao, which opened the city for foreign trade. When Japanese influence replaced the German presence in Shandong after World War I, a sizable Japanese colony became established in Jinan. In 1928, during the Northern Expedition of the Nationalist Party armies, the Japanese army intervened in what became known as the Jinan Incident.	Jinan is commonly referred to as the “City of Springs” because of the abundance springs, a total of 72 springs, located in the city. Some of the most famous springs are Baotu Springs, which also has several temples and pavilions, Black Tiger Spring, which sounds like the roar of a tiger gurgles, and Five Dragon Pool, a very deep pool of spring water in a tranquil park. \r\n\r\nDaming Lake is also a scenic area that attracts many people. In there, you can find the Confucius Culture Museum, Daming Lake Park, Jinan Old Town, Memorial Temple of Xin Qiji, and Minghu Art Gallery. Furthermore, the Qianfo Mountain is at the southern boundary of the densely urbanized city and contains the ancient 'thousand' Buddha's in their grottoes. You can find Jinan Archaeological Museum, Jinan Battle Memorial Hall, JInan Museum, Qianfo Mountain Scenic Spot, and Shandong Carved-Stone Art Museum there. In Changqing, a large district to the south-west of the city, you can find Five Peak Mountain, Guo Family Ancestral Hall, and Lingyan Temple there.	Jinan cuisine is famous for its scrumptious, aromatic, fresh and pure dishes. The methods of cooking employed in the preparation of these local foods include deep-frying, grilling, frying and stir-frying but the food is non-greasy.\r\n\r\nSome famous local dishes include Tangculiyu (Sweet and Sour Carp), Chinese univor’s mandarin fish, Jinan Roast Duck, and Sauteed chicken cubes with chilli and peanuts. Some famous local snacks are Quancheng Steamed Bun, Wuren Bao, Fried Dumpling, Youxuan, and Spring Roll.\r\n\r\nJinan Food Street, nearby the city’s Sports Center and with dozens of flavored snack bars, gathers thousands of famous snacks and dishes from Jinan as well as from all parts of the country. For some western-style food, you can also find it on Quancheng Road. 	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	0,0	jinan	15	qsprovince_id
39	Jingdezhen	景德镇	Here is an example of a short description	images/city/Jingdezhen/Jingdezhen.jpg	images/city/Jingdezhen/Jingdezhen_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	jingdezhen	14	qsprovince_id
40	Jiuhua Shan	九华山	Here is an example of a short description	images/city/Jiuhua Shan/Jiuhua Shan.jpg	images/city/Jiuhua Shan/Jiuhua Shan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	jiuhuashan	12	qsprovince_id
41	Jiuzhaigou-Huanglong	九寨沟	Here is an example of a short description	images/city/Jiuzhaigou-Huanglong/Jiuzhaigou-Huanglong.jpg	images/city/Jiuzhaigou-Huanglong/Jiuzhaigou-Huanglong_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	jiuzhaigou-huanglong	23	qsprovince_id
42	Kaifeng	开封	Here is an example of a short description	images/city/Kaifeng/Kaifeng.jpg	images/city/Kaifeng/Kaifeng_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	kaifeng	16	qsprovince_id
43	Kanas Lake	喀纳斯	Here is an example of a short description	images/city/Kanas Lake/Kanas Lake.jpg	images/city/Kanas Lake/Kanas Lake_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	kanaslake	31	qsprovince_id
44	Kashgar	喀什	Here is an example of a short description	images/city/Kashgar/Kashgar.jpg	images/city/Kashgar/Kashgar_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	kashgar	31	qsprovince_id
45	Kunming	昆明	Here is an example of a short description	images/city/Kunming/Kunming.jpg	images/city/Kunming/Kunming_large.jpg	Kunming is the capital and largest city of Yunnan Province in southwest China. It is a prefecture-level city and political, economic, communications, and cultural center of the Province. Kunming lies at an almost tropical latitude, which gives it a very temperate and pleasant climate, thus its nickname the ‘City of Eternal Spring. Its economic importance derives from its geographical position. Positioned near the border with Southeastern Asian countries, serving as a transportation hub in Southwest China.	With a history of more than 2,400 years, it was the gateway to the celebrated Silk Road that facilitated trade with Tibet, Sichuan, Myanmar, India and beyond. Around 30000 years ago, ancient tribes inhabited the area around Dian Lake. In 109 BCE, during the reign of the Xi Han emperor Wudi, the Dian kingdom became part of the Han territory. It was then an important traffic center, connecting China’s hinterland with the southern branch of the ancient Silk Road to the west. During the Mongol invasion of the southwest in 1253, it was under the control of the Chinese central government. Two decades later, it formally became Kunming county and the provincial capital of Yunnan. The opening of the Kunming area began in earnest with the completion in 1906–10 of the railway to the Vietnamese city of Haiphong.	Kunming has jurisdiction over 14 subdivision including seven districts, one county-level city, three counties, and three autonomous counties. The City proper includes Panlong District, Wuhua District, Guandu District, and Xishan District. The beautiful natural scenery, glorious historical heritages, and colorful folk customs made Kunming one of the first excellent tourist destination cities in China. \r\n\r\nThe Stone Forest World Geopark is a large comprehensive tourist zone with natural scenery and folk customs. The spiky karst landscape itself is worth the visit. Kunming Municipal Pump House is an interesting place that records thoughts parching Yunnan. There are also many temples in Kunming, such as Yuantong Temple, Qiongzhu Temple, Tanhua Temple.\r\n\r\nThere are also plenty of museums that are worth visiting. Yunnan University Wu Mayao Museum of Anthropology, Kunming Zoology Museum, and Yunnan Military Academy, Yunnan Provincial Museum, and Yunnan Railway Museum are the most popular ones. You should also go to Kunming flower and bird market for cute animals and beautiful flowers. 	In addition to attractive scenic spots, Kunming is also renowned for its many delicious dishes. Due to the multicultural nature of the Province, the city brings together the most representative food of the various nationalities residing in Yunnan, so eating here is an experience not to be missed. Some famous dishes include Over-the-bridge Rice Noodles, Steam Pot Chicken, Yiliang Roasted Duck, Xuanwei ham, Erkuai, Sweet Tonghai Pea Powder Candy, Qujing Pickled Chives Flower, Smoked Stinky TOfu, The Eight Treasures of Yunnan (cake), and Wild Mushroom. Two good restaurants to go to are Guozilou, Shi’ping Huiguan, Makye Ame, and Heavenly Manna.	Here's where you can find all the best hotels in the city.	Here is the weather	3583000	The Bund	100	t	f	f	f	f	f	25.066667, 102.683333	kunming	25	qsprovince_id
67	Shennongjia	神农架	Here is an example of a short description	images/city/Shennongjia/Shennongjia.jpg	images/city/Shennongjia/Shennongjia_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	shennongjia	17	qsprovince_id
46	Lanzhou	兰州	Here is an example of a short description	images/city/Lanzhou/Lanzhou.jpg	images/city/Lanzhou/Lanzhou_large.jpg	Lanzhou, the capital and the largest city of Gansu Province, is located on the banks of the Yellow River. It is a key regional transportation hub, connecting areas further west by rail to the eastern half of the country.	Originally in the territory of the Xi (Western) Qiang peoples, Lanzhou became part of the territory of Qin in the 6th century BCE. The city used to be called the Golden City, and since at least the first millennium BC it was a major link on the ancient Northern Silk Road. In the 4th century it was briefly the capital of the independent state of Qian (Former) Liang. In 763 the area was overrun by the Tibetans, and it was then recovered by the Tang in 843. The city was badly damaged during the rising of Gansu Muslims in 1864–75; in the 1920s and ’30s it became a centre of Soviet influence in northwestern China.During the 1937 Japanese invasion of China, the Guominjun Muslim Generals Ma Hongkui and Ma Bufang protected Lanzhou with their cavalry troops, putting up such resistance that the Japanese never captured Lanzhou.  This highway remained the chief traffic artery of northwestern China until the completion of a railway from Lanzhou to Ürümqi in the Uygur Autonomous Region of Xinjiang.	Lanzhou is is divided into four administrative districts: Chengguan, QIlihe, Xigu, and An’ning Districts. In 2012, Lanzhou New Area was approved as the fifth state-level new special economic development zone. Lanzhou is abundant with tourist attractions as the only provincial capital city with the Yellow RIver flowing through. \r\n\r\nOn the bank of the Yellow River extends the longest riverside road in China, where you can admire the grand River, the First Bridge over the Yellow River, the Watermill Park and the sculpture of the Yellow River Mother, the White Pagoda Park, and the Five-Spring Mountain park. At dusk, standing on the top of Lanshan Mountain, you can have a magnificent view of the Yellow River surrounding the city. The Liujiaxia Hydropower Station and the Bingling Temple in Yongjing County are further away, but the distance will certainly be compensated by the attractions.\r\n\r\nFor some local historical attractions, the Gansu Provincial Museum is also a good choice. For nature-lovers, Yan Tan Park in the east of Lanzhou would be an optimum choice.	The food in Lanzhou is quite unique compared to that of central China, having been influenced by ethnic groups - especially the Hui people. Besides the beef noodles, there are local delicacies that cannot be tasted in other places, as well as Sichuan cuisines, hotpot, and western food.\r\n\r\nLanzhou dishes are also representatives of Gansu cuisine which features the roasting, steaming, and braising of beef and mutton. Local people enjoy many tastes including salty, fresh, tart, and spicy. Typical dishes include Jincheng Baita, Jincheng Babao Melon Carving, Baihe Tao, and albino leeks with chicken and roasted pork. Lanzhou Beef Noodles (Stretched Noodles) is the most famous local dish. It was first created during the reign of Emperor Guangxu, Qing Dynasty and it is now popular all over China.	Here's where you can find all the best hotels in the city.	Here is the weather	2177000	The Bund	100	f	f	f	t	f	f	36.033333, 103.8	lanzhou	28	qsprovince_id
47	Leshan	乐山	Here is an example of a short description	images/city/Leshan/Leshan.jpg	images/city/Leshan/Leshan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	leshan	23	qsprovince_id
48	Lhasa	拉萨	Here is an example of a short description	images/city/Lhasa/Lhasa.jpg	images/city/Lhasa/Lhasa_large.jpg	Lhasa, the capital of the Tibet Autonomous Region in Southwest China, is located at 3650 meters above sea level on the northern slopes of the Himalayas, one of the highest cities in the world. Tibetan Buddhists consider Lhasa a holy land. It is the second most populous city on the Tibetan Plateau after Xining.	Lhasa rose to prominence as an important administrative centre in the 7th century AD, when Songtsen Gampo (c 618–49), a local ruler in the Yarlung Valley, continued the task initiated by his father of unifying Tibet. Lhasa had been designated as the capital of Tibet by the 9th century CE. However, national power became decentralized following the assassination of the Tibetan king in 842, and Lhasa lost its position as the country’s capital. The 5th Dalai Lama unified Tibet and moved the centre of his administration to Lhasa in 1642 with the help of Güshi Khan of the Khoshut. By the end of the 17th century, Lhasa's Barkhor area formed a bustling market for foreign goods. In 1904 a British expedition force led by Francis Younghusband entered Lhasa and forced remaining low-level Tibetan officials to sign the Treaty of Lhasa after the fleeing of Dalai Lama. After Deng Xiaoping's southern tour in 1992, Lhasa was mandated by the government to undergo economic liberalization.	Lhasa is a unique and spiritual city. After a thousand years of vicissitudes, it has managed to retain its ancient palace, thick with religious history, its ancient temples, relics and streets whilst simultaneously keeping pace with modern society.\r\n\r\nSurely every traveler must visit the Potala Palace during their visit. It was established in the 7th century AD when King Songtsen Gyalpo built a fortress for his two foreign wives and was rebuilt by the FIfth Dalai Lama. Another must-see attraction is the Jokhang Temple, the spiritual center of the holy land. On your way there, you may pass through Barkhor Street, a local commercial street with many featured local artworks and souvenirs. The three main monasteries in Lhasa are also not to be missed: Sera, Ganden and Drepung Monasteries, the largest monastery in Tibet. Sera is located on the north of the city, while the other two on the west. \r\n\r\nSome other attractions include Norbulingka Summer Palace, Tibet Museum, and Chakpori HIll. 	Restaurants in Lhasa serve the best food and accommodation in Tibet. The food includes Tibetan cuisine, Sichuan cuisine and western style dishes. The majority of cuisine in Lhasa consists of yak, mutton, and goat meats. Some famous dishes are Gyurma, a type of blood sausage made with yak blood; Thukpa, a noodle soup usually served with mutton meat; Tingmo, a type of steamed bun served along other foods or stuffed with meat or cheese; Tsam-thuk, a soup made with cheeses, tsampa, and yak stock; and Tsampa, made of ground barley flour and is often mixed with butter or yak butter tea.\r\n\r\nSome restaurant recommendations include Crazy Yak Saloon, Snow-Deity Palace, and Tashi. 	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	29.65, 91.116667	lhasa	26	qsprovince_id
49	Lijiang	丽江	Here is an example of a short description	images/city/Lijiang/Lijiang.jpg	images/city/Lijiang/Lijiang_large.jpg	Lijiang, located in the northwest of Yunnan Province, is a prefecture-level city. The city is most famous for its UNESCO Heritage Site, the Old Town of Lijiang. As of 2010, Lijiang has a population of 1,244,769.	The city has a history of at least 800 years, dating back to the Song Dynasty. It replaced the former administrative region of Lijiang Naxi Autonomous Prefecture. During the Ming Dynasty and Qing Dynasty, it was under the rule of the Mu family. The Baisha Old Town was the political, commercial, and cultural center for the local Naxi people and other ethnic groups for 400 years from the year 658 AD to 1107 AD. It was the center of silk embroidery in the southwest of China and the most important place of the Ancient Southern Silk Road, also called the Ancient Tea and Horse Road. A book in the 19th century written by an American commissioner brought the town some fame. Foreigners began to visit the town as China liberalizes its visa policy in the 1980s. In 1996, an earthquake brought domestic and international attention to the town. More and more tourists enter Lijiang after that. The Old Town District was once the center of the city and continues to maintain the original flavor of the local style.\r\n\r\nGenerally speaking, the weather in Lijiang is mild and warm in winter and cool in summer. Winter is also dry and sunny. 	Lijiang city is composed of one district and for counties: Gucheng District, Yongsheng County, Huaping County, Yuong Nakhi Autonomous County, Ninglang Yi Autonomous County. The government of Lijiang is located in Gucheng District.\r\n\r\nLijiang boasts spectacular natural scenery varying from snowy mountains and highland glacial lakes to majestic canyons, making it a great place for outdoor activity lovers. Dayan Old Town is a welcoming place for tourists to see local folks dance and music. At night, there are also many pubs with great singers that perform. Mu Palace is the palace where the Mu Clan of the Naxi people ruled for over 400 years. At the top is a Daoist Temple, with a few Daoists ready to give fortunes to visitors.\r\n\r\nOutside of the Old Town, Jade Dragon Snow Mountain is a mountain massif, one of the icons of Lijiang. The highest peak is Shanzidou at 5,596m. Black Dragon Pool is a place with nice natural scenery with traditional building. 	Because of the tourism popularity, you can generally find many different kinds of food from all backgrounds. Locally, there are mainly three types of restaurants: Naxi, Tibetan, and Sichuan. Local snacks are also offered by street vendors. The common snacks you will see are Baba, Naxi Style Fried White Cheese, Yak’s Milk Yogurt, and Fried Yak meat. Some popular local restaurants include The Bivou cafe (Western or simple Chinese food), Country Sky (vegetarian and traditional options), Lamu (Tibetan and Yunnan food), Qiuyuege Restaurant (Naxi food), and Lijiang Gulou Restaurant (Naxi and Sichuan food).     \r\n\r\nYou should also try some of the local drinks here: Yinjiu and Sulima. They are both modern renditions of ancient beer types of the Naxi and Mosuo people. Lijiang is also famous for their tea.	Here's where you can find all the best hotels in the city.	Here is the weather	155000	The Bund	100	t	f	f	f	f	f	26.883333, 100.233333	lijiang	25	qsprovince_id
50	Lu Shan	庐山	Here is an example of a short description	images/city/Lu Shan/Lu Shan.jpg	images/city/Lu Shan/Lu Shan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	lushan	14	qsprovince_id
51	Luoyang	洛阳	Here is an example of a short description	images/city/Luoyang/Luoyang.jpg	images/city/Luoyang/Luoyang_large.jpg	Luoyang, located in the confluence area of Luo River and Yellow River, is a prefecture-level city Henan Province. As of 2010, Luoyang has a population of 6,549,941 inhabitants. Situated on the central plain of China, Luoyang is one of the cradles of Chinese civilization, and is one of the Four Great Ancient Capitals of China.	Luoyi (present-day Luoyang) was founded in the mid-11th century BCE at the beginning of the Zhou dynasty (1046–256 BCE), near the present-day west town, as the residence of the imperial kings. It became the Zhou capital in 771 BCE and was later moved to a site northeast of the present-day east town. Luoyang did not become the Han capital until the 1st century CE, at the beginning of the Dong Han period, though its economic importance had been recognized earlier. It did not prosper again until 495, when it was revived by the Xiaowendi emperor of the Bei Wei Dynasty. After a rebellion in the mid-8th century, however, Luoyang fell into an economic decline that lasted until the mid-20th century. During the 1950s, with the assistance of the former Soviet Union, several large-scale industrial projects were launched in Luoyang, and it became one of China’s major industrial cities.	Luoyang is consisted of a plethora of tourist attractions, with many of them being a World Heritage site: the Longmen Grottoes, The Grand Canal-Huiluo Barn, and Silk Roads-Han Wei Luoyang City Site, Dingding Gate Site of Sui Tang Luoyang City, Xin’an Hangu Guan Site. Longmen Grottoes, home to tens of thousands of statues of Buddha and more than forty Buddhist pagodas as well as a large number of stone stables, is situated in the southern outskirts of the city. \r\n\r\nLuoyang is also home to many ancient city sites including Erlitou Site of Xia Dynasty, Yashi Shang City Site of Shang Dynasty, Wangcheng Site of Easter Zhou Dynasty, Luoyang City Site of Han and Wei Dynasty, and Luoyang City Site of Sui and Tang Dynasty. \r\n\r\nOther must-go attractions in Luoyang include: Ancient Han Tombs Museum, Baima Temple, Guanlin Temple, Luoyang Museum, and Wnagheng Park, Zhougong Temple, and the Yellow River Xiaolangdi Scenic Area. 	Dining culture has been developed for thousands of years in Luoyang. Luoyang food is characterized with rich soup which means that the most dishes may be cooked in soup and eaten in soup. Some famous dishes are Luoyang Shui Xi, a feast of 24 dishes accompanied by different soups; Luoyang Yan Cai, steamed radish in Nourishing Soup; Liyu Yue Long Men, steamed carp with vegetables; and Changshou Yu, a traditional dish with carp boiled with medlar and other seasonings. There are also famous delicacies such as Jiang Miantiao, noodles boiled in thick bean milk; Tangmian Jiao, steamed dumplings with pork and other condiments, Panjinhe Roast Chicken; and Zhang Family Wonton. \r\n\r\nSome restaurant recommendations include Yaxiangluo Restaurant, Mutton Soup Restaurant, Old Luoyang Noodles Restaurant, and Zhenbutong Restaurant. \r\n	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	34.669722, 112.442222	luoyang	16	qsprovince_id
52	Macau	澳门	Here is an example of a short description	images/city/Macau/Macau.jpg	images/city/Macau/Macau_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	macau	34	qsprovince_id
53	Mogan Shan	莫干山	Here is an example of a short description	images/city/Mogan Shan/Mogan Shan.jpg	images/city/Mogan Shan/Mogan Shan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	moganshan	11	qsprovince_id
91	Yangzhou	扬州	Here is an example of a short description	images/city/Yangzhou/Yangzhou.jpg	images/city/Yangzhou/Yangzhou_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	yangzhou	10	qsprovince_id
54	Nanchang	南昌	Here is an example of a short description	images/city/Nanchang/Nanchang.jpg	images/city/Nanchang/Nanchang_large.jpg	Nanchang, the capital of Jiangxi Province, is situated on the right bank of the Gan River just below its confluence with the Jin River. It is the third largest city in central China with a population of 5,042,565 as of 2010.	The city was founded and first walled in 201 BCE, when the county town was given the name Nanchang. It was also the administrative seat of a commandery, Yuzhang. In 589 this commandery was changed into a prefecture named Hongzhou, and after 763 it became the provincial centre of Jiangxi, which was then beginning the rapid growth that by the 12th century made it the most populous Province in China. At the beginning of the 16th century it was the power base from which Zhu Chenhao, the prince of Ning, launched a rebellion against the Ming regime. In the 1850s it suffered considerably as a result of the Taiping Rebellion, and its importance as a commercial centre declined. On Aug. 1, 1927, it was the site of one of a series of insurrections organized by the Chinese Communist Party. After 1949 Nanchang became extensively industrialized. It is now a large-scale producer of cotton textiles and cotton yarn.	Known as the "City of Heroes," Nanchang has a place in history as birthplace of the 1927 Communist uprising. Today, this provincial capital acts as an excellent base for explorations throughout Jiangxi, all while boasting its own set of attractions. According to a survey, there are altogether 78 cultural sites in the city with the Tengwang Pavilion as the most renowned. Other historic sites include Youmin Temple and 11 Army Headquarter site.\r\n\r\nThere are some excellent attractions in Nanchang suburbs. Wanshou (Longevity) Palace in Xishan Mountain, which is in the southwest of the city proper, is a Taoist temple built for a famous Taoist in Jin Dynasty (265-420). Devotees will go to pray for which come true during the birthday and the day of death in the first and eighth lunar months.\r\n\r\nMeiling and Mingyue Mountain are all national scenic and historic interest areas in Nanchang.\r\n\r\nOther attractions in Nanchang include Lushan National Park, Dragon and Tiger Mountain, Mt. Jinggang, Poyang Lake, and Wugong Mountain. 	Nanchang is also famous for its delicious food. The traditional cuisine is Nanchang Cuisine (Gan Cuisine), which plays a very important role in Chinese food culture. Other cuisines, like Sichuan Cuisine, Guangdong Cuisine, Hunan Cuisine, etc. can also be enjoyed in Nanchang. It features crisp quality, fragrance and modest taste (not too salty or spicy).\r\n\r\nSome famous dishes include Nanchang rice-flour noodles; Lushan San Shi, a dish composing of chicken, fish, and mushroom; Wuyuan Steamed Tofu, steamed tofu with shrimp meat, mushroom, and sliced bamboo shoots; Dongsun Ganshao Rou, braised pork with bamboo shoots; Lihao Chao Larou, Sauteed Pork with Lihao; Mifen Niurou, steamed beef with rice flour; zhangshu Baomian, Zhangshu Wonton; and Huangyuan Miguo, Huangyuan glutinous rice cake. 	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	28.683333, 115.883333	nanchang	14	qsprovince_id
55	Nanjing	南京	Here is an example of a short description	images/city/Nanjing/Nanjing.jpg	images/city/Nanjing/Nanjing_large.jpg	Nanjing, the capital of Jiangsu Province, lies on the south bank of the Yangtze River. Its location makes it an important port and a major industrial and communications center. Known as the capital of many dynasties in the history of ancient China, Nanjing has a nickname of the “City of Emperors”. The city has a population of 8.335 million. \r\n\r\nFour seasons in Nanjing are clearly distinguishable. The hot summer months are from July to September (with an average temperature of 3 °C), and winter lasts from December till March (with an average temperature of 28 °C). Spring and autumn are the best time to visit since they are mild and pleasant. The bulk of rainfall falls between June and August. 	Nanjing boasts a rich and impressive historical heritage. During the Qin Dynasty (221-207 BCE), Nanjing prospered as a major administrative center. However, later in Sui Dynasty comes with the destruction of the city until regaining some prosperity under the long-lived Tang Dynasty. In 1356, Zhu Yuanzhang, a peasant, successfully rebelled against the Mongol Yuan Dynasty. Under Zhu ’s Ming Dynasty, Nanjing became the capital. The fortune of Nanjing then continued to rise and decline as a regional center until the 19th and 20th century. The Opium Wars in the 19th brought the British to Nanjing, after which the first of the ‘unequal treaties’ was signed. In 1937, the Japanese army took the advantage of a weak and underfunded Chinese army, brutally invaded and occupied the city. This is later known as the Nanking Massacre. 	There are many attractions to visit in the central part of the city, which is encircled by hills and rivers. The Nanjing Fuzimiao (Confucian Temple) Nanjing Qinhuai Scenic Belt is one of the most flourishing areas to visit. There are plenty of cultural attractions, arts, shopping, and night markets with delicious local dishes to check out. Beside Fuzimiao, Zhan garden is also a must-go destination. Being famous for its rockery, it is the only well preserved Ming-style architectural complex. Other attractions to see within central Nanjing include Laomendong (Old Gate East), Presidential Palace, and the Museum of Nanjing.\r\n\r\nIn the Eastern suburb, the Zhongshan Scenic District is a place that combines urban, mountain, and water attractions. Purple Mountain, or Zijin Shan, is named after the mysterious purple and golden clouds that often envelope the peak of the mountain. The iconic Sun Yat-sen Mausoleum is situated at the foot of the second peak of Mount Zijin. Other places to visit in the area include Ming Xiaoling Mausoleum. \r\n	It is hard to leave Nanjing without a bloating tummy. Both back-alley stalls and elegant restaurants can give you a taste of authentic traditional Nanjing food. Local classics include small steamed buns stuffed with juicy pork (Tangbao), sesame pancakes cooked with duck oil, and duck blood soup with fried tofu and vermicelli. To try out these Nanjing nibbles, you should go to the Confucius Temple area and Shiziqiao Food Street for the best venues. It is also a must to try out Yanshuiya, duck soaked in brine, and Peking Duck. The Plum Garden Restaurant in Jinling Hotel and Xushuang Xunfu are the restaurants to go for these iconic dishes. 	Here's where you can find all the best hotels in the city.	Here is the weather	8216000	The Bund	100	t	f	f	f	f	f	32.05, 118.766667	nanjing	10	qsprovince_id
56	Nanning	南宁	Here is an example of a short description	images/city/Nanning/Nanning.jpg	images/city/Nanning/Nanning_large.jpg	Nanning, the capital of Guangxi Zhuang Autonomous Region, is located in the south-central part of Guangxi on the north bank of the Yong River and lies below the confluence of the You and Zuo Rivers. As of 2014, it has a population of 6,913,800 inhabitants.  It is known as the "Green City" because of its abundance of lush subtropical foliage.	A county seat, called Jinxing, was first established at the site in 318 CE; it also became the administrative seat of a commandery. Under the Tang dynasty (618–907) the prefecture of Yong was established there; it was garrisoned to control the non-Chinese districts in Guangxi and on the border between Yunnan and Guizhou Provinces. It remained a frontier prefecture throughout the Song dynasty (960–1279), being the scene of a rebellion led by Nong Zhigao in 1052 and thereafter a garrison town. Opened to foreign trade by Qing authorities in 1907, Nanning grew rapidly. From 1912 to 1936 it was the provincial capital of Guangxi, replacing Guilin. During the Sino-Japanese War (1937–45), Nanning was temporarily occupied in 1940 by the Japanese. It subsequently became an important U.S. air base supporting the Chinese armies in Guangxi, but during 1944–45 it was again under Japanese occupation. Beginning in 1949, Nanning’s economy began developing beyond its former role.	Nanning is divided into seven districts: Qingxiu, Xingningm Jiangnan, Xixiangtang, Liangqing, Yongning, and Wuming(suburban) Districts. Nanning is truly a garden city with charming natural subtropical scenery. Green mountains, winding rivers, exquisite lakes as well as a city full of verdant trees and fragrant flowers form a tourist mecca. People of Zhuang and other ethnic groups live here, adding colorful folk cultures to the city's glamour.\r\n\r\nMany natural sceneries are there with magnificent views. The most famous ones include Qingxiu Mountain Scenic Area (the “green lung” of Nanning), Daming Mountain, Detian Waterfall, Yiling Cave, Longhu Mountain natural Reserve, Jiulong Waterfall Forest Park, Nanhu Lake Park, Liangfengjiang National Forest Park, Da Wang Tan Reservoir Scenic Area, and Lake Park Jiahecheng Hot Spring Valley. \r\n\r\nOther attractions also include Guangxi Museum, Guangxi Medical Botanic Garden, People's Park, with the Zhenning Fort, Nanning Zoo, and Nanning Shishan Park, a park with over 30 different buildings representing South-China’s architecture. 	Nanning cuisine shares many similarities with that of Cantonese cuisine. It is particular about the freshness, tenderness and the nourishment of the dishes. Most tourists are much fonder of the special snacks, which are also popular among the locals.\r\n\r\nSome famous dishes include Lao You Fen, rice noodles cooked with chopped garlic, lobster sauce, sour bamboo shoots, and chopped beef; Ba Zhen Fen, meaning Eight Treasures Rice Noodles; Shao Ya, roasted duck; Suan Ye, fermented fruit or vegetable; and Naning Lemon Duck. \r\n\r\nSome restaurant recommendation include Ban Xianju, GanJia JiePai NingMengYa Dian(Yuanhu South Road), Zhongshan Road XiaoChiJie, and SiHaiYiJia. \r\n	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	22.816667, 108.316667	guangxi	20	qsprovince_id
57	Ningbo	宁波	Here is an example of a short description	images/city/Ningbo/Ningbo.jpg	images/city/Ningbo/Ningbo_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	29.866667, 121.55	ningbo	11	qsprovince_id
58	Pingyao	平遥	Here is an example of a short description	images/city/Pingyao/Pingyao.jpg	images/city/Pingyao/Pingyao_large.jpg	Pingyao is a city located in Central Shanxi Province, famed for its importance in Chinese economic history and well-preserved traditional Han Chinese city. The Ancient City of Pingyao is listed on the UNESCO World Heritage List for its well-retained historic form of the county-level cities of the Han people in Central China from the 14th to 20th century.	The history of the settlement in the Pingyao area started under the reign of the Xuan King (r.c. 827 - 782 BCE). In the Spring and Autumn period, the county belonged to the Kingdom of Jin. The Ancient City of Pingyao is deemed to be found officially in the 14th century, covering an area of 225 hectares. Particularly, from the 16th century to the early 20th century, the Ancient City of Pingyao was a financial center for the whole of China. During the entire Qing Empire, there were more than 20 financial institutions within the city, which is more than half of the total in the country.\r\n\r\nThe climate of Pingyao is temperate. The winter is cold with little snow and severe fog.  In the spring, the temperature varies greatly between day and night, with a little rain and some winds. Summertime is often hot, humid and rainy. Autumn days have falling temperatures with little rain and are cool and clear with abundant sunshine.	The property of the Ancient City of Pingyao includes three parts: the entire area within the walls of Pingyao, Shuanglin Temple 6 kilometers southwest of the county seat, and Zhenguo Temple 12 kilometers northeast of the county seat. The main attraction in Pingyao’s walled city is the city itself. Wandering the streets here, you will find every building dates back to the Ming or Qing dynasties. The car-free streets and ancient street plans add to the atmosphere. You can walk on top of the city walls or climb up the historic City tower for a comprehensive view of the city from its center. There are some other attractions include Rishengchang Exchange House, County Government Office, Temple of the City God, Ming-Qing Street, and former residence of Lei Lutai. \r\n\r\nYou can also visit the Shuanglin Temple for their collections of more than 2000 existing painted sculptures made in the Ming and Qing dynasties or Wanfo Shrine, one of China’s earliest and most precious timber structure buildings in existence.	Pingyao's specialty is Pingyao Beef. The specialty consists of cold Beef (looks like slices of prepared ham) with no other dishes than soy sauce. It has an acquired, strong taste, somewhat similar to corned beef. Other local specialties Wantuo, a favorite of the Empress Dowager Cixi, Chenashengyuan Rice Wine, and bean flour Minjian, etc. Petit Resto, located in the middle of the south street, is a great restaurant recognized by the Lonely Planet. Food within the city walls sometimes can be more pricey since it mostly caters to tourists.	Here's where you can find all the best hotels in the city.	Here is the weather	48000	The Bund	100	t	f	f	f	f	f	37.2, 112.15	pingyao	5	qsprovince_id
59	Putuo Shan	普陀山	Here is an example of a short description	images/city/Putuo Shan/Putuo Shan.jpg	images/city/Putuo Shan/Putuo Shan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	putuoshan	11	qsprovince_id
92	Yantai	烟台	Here is an example of a short description	images/city/Yantai/Yantai.jpg	images/city/Yantai/Yantai_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	37.535, 121.389167	yantai	15	qsprovince_id
93	Yibin	宜宾	Here is an example of a short description	images/city/Yibin/Yibin.jpg	images/city/Yibin/Yibin_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	28.766667, 104.616667	yibin	25	qsprovince_id
60	Qingdao	青岛	Here is an example of a short description	images/city/Qingdao/Qingdao.jpg	images/city/Qingdao/Qingdao_large.jpg	Qingdao, located on the south coast of the Shandong Peninsula at the eastern entrance to Jiaozhou Bay, is a port city that belongs to eastern Shandong Province. As the largest city in its Province, Qingdao has jurisdiction over six districts and four county-level cities. Qingdao is a major seaport, naval base, and industrial center.	Qingdao is a city steeped in China’s 20th-century history. Identified by the German authorities as a strategically important port, it was taken as part of the Imperial German COncession of Jiaozhou Bay from the unmodernized and ineffective Qing Empire. Upon gaining control of the area, the Germans outfitted the impoverished fishing village of "Tsingtao" (Qingdao) with wide streets, solid housing areas, government buildings, electrification throughout, a sewer system and a safe drinking water supply, a rarity in large parts of Asia at that time and later. The city reverted to Chinese rule in December 1922. However, Japan still maintained its economic dominance of the railway and the Province. It was not until the Japanese surrender in 1945 Qingdao returned to full control by China.\r\n\r\nGenerally, the city experiences a milder climate than the rest of the Shandong peninsula. Winter in Qingdao is cool to cold and windy, and dry. Summer is humid, but very hot days are rare. 	Qingdao city comprises four main districts: Shinan District, Shibei District, Sifang District, and Licang District. There are also three suburban districts (Laoshan, Chengyang, and Huangdao) and five rural areas. Shinan district is the downtown core that runs along the sea with most of the city’s major hotels, attractions, and beaches. Licang District is home to industrial and commercial areas, but it is also where you can find peach blossom tourism spot.\r\n\r\nThe four landmarks of Qingdao are Zhan Qiao, Catholic Church, Protestant Church, and Zhanshan Temple. Zhanqiao is a famous pier that many people regards as the iconic symbol of Qingdao. The famous pavilion that is the logo of Tsingtao Beer was built in 1931 and now houses a small aquarium just renovated. The Catholic and Protestant Churches are places to see historic marks of foreign influence. Tha Zhanshan Temple boasts a large collection of skillfully carved statues of Buddha and Buddhist scriptures. \r\n\r\nSome other attractions to visit include the Tsingtao Brewery, Qingdao TV Tower and Bada Guan.	Because of its proximity to the ocean, seafood is a typical delicacy of this coastal city. The distinctive cuisine of the area is called Lu Cai, the Shandong regional style. For some authentic Shandong-style seafood, Haidao Seafood Restaurant, YUmatou Seafood REstaurant, and Zijing Shandong Restaurant are the places to start. Shandong cuisine is also famous for its dumplings. Sanheyuan and Daniang Dumplings are the small local dumpling restaurants that allow you to have the most local style dumplings. \r\n\r\nBeing the home to Tsingtao Beer, you should not miss the fresh beer that you can find here. One of the neatest things about Qingdao is the ability to purchase fresh from the factory draft beer almost anywhere. You will often see kegs sitting outside most restaurants and snack stores.	Here's where you can find all the best hotels in the city.	Here is the weather	6188000	The Bund	100	t	f	f	f	f	f	36.066667, 120.383333	qingdao	15	qsprovince_id
61	Qinhuangdao	秦皇岛	Here is an example of a short description	images/city/Qinhuangdao/Qinhuangdao.jpg	images/city/Qinhuangdao/Qinhuangdao_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	qinhuangdao	4	qsprovince_id
62	Qujing	曲靖	Here is an example of a short description	images/city/Qujing/Qujing.jpg	images/city/Qujing/Qujing_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	qujing	25	qsprovince_id
63	Sanya	三亚	Here is an example of a short description	images/city/Sanya/Sanya.jpg	images/city/Sanya/Sanya_large.jpg	Sanya, one of the four prefecture-level cities of Hainan Province, is the southernmost city on Hainan Island located in Southeast China. As of 2010, the population of Sanya is of 685,408 inhabitants. The city is renowned for its tropical climate and has emerged as a popular tourist destination, also serving as the training site of the Chinese national beach volleyball team. With sunshine all year round, temperatures hover around 25*C even in January and 30*C in the summertime.	Sanya's history dates to the Qin Dynasty (221–206 BCE). Due to its remoteness from the political centers during the Imperial China eras on Mainland China. During the Tang dynasty, the Buddhist monk Jianzhen accidentally landed here, using Sanya as a staging post on his missionary journey to Japan. Japan occupied the area during the Second Sino-Japanese War (1941–1945) and renamed Sanya as Samah. The city then became a naval port for the Second Fleet of the Imperial Japanese Navy and the main embarkation point for the Japanese Invasion of Malaya and Thailand. In April 1950, the People's Liberation Army took over Yaxian County and established a People's Government. In October 1954, the administration of the CPC Yaxian Committee relocated from Yacheng to Sanya then in 1958.	Sanya’s districts are usually divided into the following for visitors: Sanya Bay Beach, Sanya City, DadongHai, Serenity Coast, Yalong Bay, and Haitang Bay. For most travelers, Sanya is a noted tourist resort with mountains, rivers and the best seaview. The favorable climate is hot in summer but warm in the three other seasons so attracting large numbers of followers from both home and abroad every year. The whole city is related to the sea.\r\n\r\nSanya Bay, Dadonghai and Yalong Bay all golden seaboards of Sanya, are some of the first choices for visitors to spend their holidays. Instead of a busy and exhausting journey, you can relax totally here by strolling along the beaches and breathing the fresh air. If you are an enthusiast of exciting water activities, Wuzhizhou Island is your place to challenge the mysterious and changing sea.\r\n\r\nThere are also more than 20 ethnic groups inhabiting in this land. In Binglanggu Li & Miao Cultural Heritage Park and Yanoda Rainforest Cultural Tourism Zone, you can fully experience local ethnic customs.	Sanya's abundant, pollution-free seafood resources are attributed to the bounteous South Sea which encircles this city. Resort Golden Palm, Sheraton Resort and the other star-rated restaurants assembled in Yalong Bay each have their own high-class dining-rooms that serve top quality seafood dishes.\r\n\r\nSanya is also home to famous Hainan dishes. The four most famous dishes are Wenchang Chicken, or Hainan Chicken, HeleCrab, Jiaji Duck, and Dongshan Lamb.\r\n\r\nHainan is also well known for its rice noodles, it is a common sight to see street stands and small eateries where a delicious bowl of noodles can be picked up for just a few yuan. There are many local variations of this basic dish – the four most well known are Baoluo Rice Noodles, Hainan Rice Noodles, Hou’an Rice Noodles, Gangmen Rice Noodles and  Lingshui Sour Rice Noodles.	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	18.253333, 109.503611	sanya	21	qsprovince_id
64	Shanghai	上海	East meets West in China's biggest metropolis	images/city/Shanghai/Shanghai.jpg	images/city/Shanghai/Shanghai_large.jpg	Shanghai (Chinese: 上海; Wu Chinese: About this sound Wu pronunciation; Mandarin: [ʂâŋ.xài] (About this sound listen)) is one of the four direct-controlled municipalities of China and the most populous city in the world, with a population of more than 24 million as of 2017.[13][14] It is a global financial centre[15] and transport hub, with the world's busiest container port.[16] Located in the Yangtze River Delta, it sits on the south edge of the estuary of the Yangtze in the middle portion of the East China coast. The municipality borders the provinces of Jiangsu and Zhejiang to the north, south and west, and is bounded to the east by the East China Sea.[17]	Shanghai\\n (Chinese: 上海; Wu <br />Chinese: About this sound\\n\\n Wu pronunciation;<br> Mandarin: [ʂâŋ.xài] (About this sound listen)) is one of the four direct-controlled municipalities of China and the most populous city in the world, with a population of more than 24 million as of 2017.[13][14] It is a global financial centre[15] and transport hub, with the world's busiest container port.[16] Located in the\r\n\r\nYangtze River Delta, it sits on the south edge of the estuary of the Yangtze in the middle portion of the East China coast. The municipality borders the provinces of Jiangsu and Zhejiang to the north, south and west, and is bounded to the east by the East China Sea.[17]Shanghai (Chinese: 上海; Wu Chinese: About this sound Wu pronunciation; Mandarin: [ʂâŋ.xài] (About this sound listen)) is one of the four direct-controlled municipalities of China and the most populous city in the world, with a population of more than 24 million as of 2017.[13][14] It is a global financial centre[15] and transport hub, with the world's busiest container port.[16] Located in the Yangtze River Delta, it sits on the south edge of the estuary of the Yangtze in the middle portion of the East China coast. The municipality borders the provinces of Jiangsu and Zhejiang to the north, south and west, and is bounded to the east by the East China Sea.[17]	Here are the best things to do in this city:	Shanghai is an extremely international city where you find everything from the finest French cuisine, to a bowl of noddles costing less than 10 RMB. Generally speaking though, food costs around the same as in Western countries, and even more in many cases. As with many Asian cities, small restaurants line the street, particularly in suburban areas. Shopping centers, unlike in the West, tend to be full of restaurants. Head down to the basement for the cheap stuff, or head up to top floors for something nicer. The French concession features a large selection of higher-end Western restaurants spotted throughout the area, and anything with a view of the Bund is going to cost you. In terms of Chinese food specifically, Shanghai food is known for being very sweet. However as with all Chinese cities these days, you can find any type of Chinese food throughout the city. Generally speaking, staff in restuarants do not speak English, but the menus almost always have pictures.	When staying in Shanghai, many tourists like to stay on somewhere near Metro Line 2. The reasons are obvious: it runs right through the middle of downtown and it connects with Pudong International Airport at one end, and Hongqiao International Airport and Railway Station at the other end. It also intersect with almost every other mtero line. In addition, many of Shanghai's most famous landmarks including Lujiazui, Nanjing Road East, The Bund and People's Square are all along this metro line, as well as the commercial areas of Jingan Temple and Nanjing West Road. \r\n\r\nIf your're looking to spend quite a bit of money, then the tower's and hotels in the Lujiazui area offer fantastic views of the city. This however is not the place to stay if you're looking for a more traditional Shanghai Experience. \r\n\r\nIf you're travelling on business and will need to access Hongqiao Airport or Railway Station, there are many options near Zhongshan Park and Luoshanguan Road that might be suitable, as well as some new hotels opened in the Hongqiao CBD (right next to the train station).	Here is the weather	24300000	The Bund	2	t	t	t	t	t	t	31.228611, 121.474722	shanghai	2	qsprovince_id
65	Shangri-La	香格里拉	Here is an example of a short description	images/city/Shangri-La/Shangri-La.jpg	images/city/Shangri-La/Shangri-La_large.jpg	Located at the point where Tibet, Sichuan, and Yunnan all meet, Shangri-La is in the northwest of Yunnan Province. The town is split between Tibetan and ethnic Han residents, as well as a fair smattering of Naxi, Bai, Yi, and Lisu, with the surrounding countryside entirely Tibetan. Shangri-la is most famous for its role in the English novelist James Hilton’s novel, the Lost Horizon.	Original named Zhongdian County, Shangri-la was said to be the appanage of Tibet King’s three suns. About three thousands years ago, Tubo ancestors created a distinctive aboriginal culture in the city.The area was under the ruling of many different kingdoms and empires throughout history. In Han Dynasty, Shangri-la was the land of Yark Qiang.\r\n\r\nIn South and North Dynasties, it belonged to Dangxian Tribe. During Sui Dynasty, it was under the administration of Nanningzhou Main Office. In Tang Dynasty China, it was the land of Shenzhou of Tibetan Empire. In Song Dynasty, it was in Dali Kingdom. In Yuan Dynasty, it was named “Da Dan Dang”, and in 1293, it belonged to Luxuanweisi Government. During Qing Dynasty, Shangri-la was given to Dalai Lama by Wu Sangui, and In 1726, it was put under Lijiang Government. After Zhongdian was liberated, it was put under Lijiang Prefecture. And in 2001, Zhongdian County renamed as Shangri-la County. 	Shangri-La is the "Eden in a dream". Since it first appeared in British novelist James Hilton's Lost Horizon in 1939, it has been associated with the mystique of a place which could not possibly exist here on Earth. In Tibetan, Shangri-La means the "sun and moon in heart", an ideal home only found in heaven. Tourists all come here to see the lofty and continuous snowy mountains, endless grasslands, steep and grand gorges, azure lakes, and the bucolic villages. \r\n\r\nThe Old Town of Shangri-la was a destination that is similar to Lijiang’s Old Town. However, a fire in January 2014 destroyed many parts of the old town. Despite the fire, today’s Old Town still have plenty of small charming streets to explore. The Songzanlin Monastery is an impressive structure that was restored in 2005 to reflect its past glories. You can find resident Lama there giving blessings to worshippers. You can also go to Pudacuo National Park, Baiji Temple, and Golden Temple.	Since the majority of the residents of Diqing, the main municipal area of Deqen Tibetan Autonomous Prefecture, are Tibetans, most of the food enjoyed by the residents of Diqing reflect a Tibetan flavor. And of course, there are Sichuan and Yunnan style restaurants in Diqing that serve dishes in the original style, as well as many of the more popular Tibetan specialties. Some of the most popular Tibetan dishes are Zanba, buttered tea, and barley beer. Because many Tibetans raise cattle for livings, the individual herdsman milk and other dairy products are worth trying. Diping Restaurant and Hongmu Tasty Snack are two places for an authentic local meal.	Here's where you can find all the best hotels in the city.	Here is the weather	130000	The Bund	100	t	f	f	f	f	f	27.833333, 99.7	shangri-la	25	qsprovince_id
66	Shaoxing	绍兴	Here is an example of a short description	images/city/Shaoxing/Shaoxing.jpg	images/city/Shaoxing/Shaoxing_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	30, 120.583333	shaoxing	11	qsprovince_id
68	Shenyang	沈阳	Here is an example of a short description	images/city/Shenyang/Shenyang.jpg	images/city/Shenyang/Shenyang_large.jpg	Shenyang, the provincial capital and the largest city of Liaoning Province, is situated in the southern portion of the vast Northeast Plain just north of the Hun river. It is the largest city in Northeast China by urban population. As of 2010, the city’s urban area has 6.3 million inhabitants, while the total population of Shenyang is up to 8.1 million.	Since the time of the Han dynasty (206 BCE–220 CE), the lower Liao River basin has been known as the Chinese Pale. By the 10th century, Shenyang, known as Shenzhou at the time, had become a major frontier settlement of the Khitan kingdom. In 1625, the Manchu leader Nurhaci captured Shenyang and decided to relocate his entire administrative infrastructures to the city. After the fall of the Ming dynasty in 1644,  the Manchus successfully entered the Shanhai Pass to establish the Qing dynasty in China proper, with the capital relocated to Beijing. However, Shenyang retained considerable importance as the secondary capital and the spiritual home of the Qing dynasty through the centuries. In the period of struggle between Russia and Japan for dominance in Manchuria after 1895, Mukden (Shenyang) was inevitably one of the key positions.	One of China's premier tourist cities, Shenyang is well known as a historical city with important links to Chinese culture. Natural and historical attractions combine to provide an enjoyable travel experience.\r\n\r\nThere are three attractions that are listed as a World Heritage site: Shenyang Imperial Palace, Zhaoling Tomb, and Fuling Tomb. \r\n\r\nFor some scenic spots, there are also a lot of options available. Qipanshan Scenic Area, the Strange Slope Scenic Area, Shenyang West Lake, and Meteorite Mountain Park are those with natural scenery. In addition, you can also go to Botanical Garden, Shenyang Glacier Zoological Paradise, and Shenyang Xinglong Indoor Park.\r\n\r\nThere are also many attractions: Xinle Remains, the site of a 7,200-year-old aboriginal society; Taiqing Palace, home to the Shenyang Taoism Association; Ci’en Temple, the most important Buddhist site in Shenyang; Shisheng Temple, the largest Tibetan Buddhism temple in the city; and South Mosque, the most prestigious Islamic mosque in northeastern China.	A long tradition, finely-honed cooking skills and Manchu cuisine basis work together to bring distinctive features to Shenyang dining. Almost every famous traditional dish comes with its own legend and historical background, which enhances its appeal. The Man-Han Banquet is a feast most representative of traditional dishes in Shenyang. According to history, Shenyang was a place governed by the Han nationality and various minor nationalities in turn. Thus, many unique snacks originate here, such as Muslim and Manchu snacks. Some famous local food include Laoshan Ji Haicheng Bing, a type of pie; Xita Lengmian, West Tower Cold Noodle; and Little Potato Pickles.\r\n\r\nSome famous restaurants that are recommended often include Laobian Jiaozi Restarurant, Najia Guan, Majia Shaomai Guan, and Liangui Xunrou Dabing.	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	41.8, 123.4	liaoning	7	qsprovince_id
69	Shenzhen 	深圳	China's most modern city lies just across the Hong Kong border	images/city/Shenzhen/Shenzhen.jpg	images/city/Shenzhen/Shenzhen_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	Title	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	12357000	The Bund	3	t	t	t	f	f	t	22.55, 114.1	shenzhen	19	qsprovince_id
70	Shunde	顺德	Here is an example of a short description	images/city/Shunde/Shunde.jpg	images/city/Shunde/Shunde_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	shunde	19	qsprovince_id
71	Suzhou	苏州	Here is an example of a short description	images/city/Suzhou/Suzhou.jpg	images/city/Suzhou/Suzhou_large.jpg	Suzhou is a city in southern Jiangsu Province known for its traditional Chinese gardens and waterside architecture. It is situated on the southern section of the Grand Canal between the renowned Lake Tai to the west and Shanghai to the east. Since about 42% area of the city is covered by water, it is praised as the “‘Oriental Venice’. The double-chessboard layout of the city, one of the retained unique characteristics of its past, is preserved intact. As of 2015, Suzhou has a total population of 10.66 million.	Suzhou has a mild climate that makes the city a desirable destination all year round. However, the climate is relatively humid in all four seasons: summers are humid, hot and winters are cool, cloudy with occasional snowfall. \r\n\r\nThe founding date of Suzhou is 514 BCE under the ruling of the state of Wu during the Dong Zhou Dynasty (770-476 BCE). The name Suzhou dates from 589 CE when the Sui Dynasty conquered southern China. It became an administrative and commercial center with the building of Grand Canal and continued to flourish through the Ming and early Qing dynasties. It was a powerhouse of the silk industry and embroidery in addition to being a commercial capital and a finance and banking center. It was later occupied by the Taiping Rebellion leader Li Xiucheng from 1860 to 1863 and by the Japanese from 1937 and 1945 during the Sino-Japanese War.	The urban core of Suzhou, the Gusu District, is informally called the “Old Town”. Other districts in Suzhou include Huqiu District, Wuzhong District, Xiangcheng District, and Wujiang District. Suzhou’s exquisite classical gardens attain their high reputation for their vast numbers and their charming natural beauty and harmonious construction. Today, there are more than 60 gardens kept intact in the city, and some of them have been listed in the UNESCO World Heritage List. The Humble Administrator’s Garden and Lingering Garden are among the four most famous classical gardens in China. The Canglang Pavilion, Lion Grove Garden, Humble Administrator's Garden and Lingering Garden, respectively representing the garden styles of the Song, Yuan, Ming, and Qing dynasties, are the four most famous gardens in Suzhou. \r\n\r\nSome other landmarks to see include Ping Jiang Road, a beautiful ancient road paved with hand-but stones over a thousand years old; Ligongdi, the only causeway seated in the Suzhou Jinji Lake; and Suzhou Museum, designed by the designer of the glass pyramid outside the Louvre in Paris, I.M Pei. 	Suzhou’s own unique cuisine is slightly sweet and tends to have very light and delicate flavors. It is one of the subordinates of China’s Four Main Cuisines. Suzhou cuisine has four main characteristics. Firstly, Suzhou cuisine uses fine and fresh seasonal ingredients. Suzhou has four distinct seasons with different seasonal products. There is fresh tasting food in spring, light food in summer, flavors in autumn and nutritious food in winter. Secondly, Suzhou cuisine requires a range of culinary skills, including slicing techniques and heat control. Thirdly, Suzhou cuisine focuses on presentation, flavor, and taste. The combination of decorations, natural coloring, and fragrance result in a fine presentation. Fourthly, Suzhou style is also famous for its variety of cooking methods. Some iconic dishes include Sweet and Sour Mandarin FIsh, Biluo Shrimp, and Ring Oil Eel. Songhelou Restaurant, Deyuelou, Wangsi Restaurant are some of the best places in town for authentic Suzhou cuisine.	Here's where you can find all the best hotels in the city.	Here is the weather	4330000	The Bund	100	t	f	f	f	f	f	31.3, 120.6	suzhou	10	qsprovince_id
72	Tai Shan	泰山	Here is an example of a short description	images/city/Tai Shan/Tai Shan.jpg	images/city/Tai Shan/Tai Shan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	taishan	15	qsprovince_id
73	Taipei 	台北	Here is an example of a short description	images/city/Taipei /Taipei .jpg	images/city/Taipei /Taipei _large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	taipei	32	qsprovince_id
74	Taiyuan	太原	Here is an example of a short description	images/city/Taiyuan/Taiyuan.jpg	images/city/Taiyuan/Taiyuan_large.jpg	Taiyuan, the capital and largest city of Shanxi Province, lies on the Fen RIver in the northern portion of the river’s fertile upper basin. Throughout its long history, Taiyuan was the capital or provisional capital of many dynasties in China, hence the name Lóngchéng.	The city was originally the site of Jinyang, a strategic centre for the ancient states of Jin and Zhao. In the Dong Han period (25–220 CE), it became the capital of the Province of Bing. Later, it was periodically designated as the Tang’s northern capital and grew into a heavily fortified military base. A new city was set up on the banks of the Fen in 982, which became a superior prefecture in 1059 and the administrative capital of Hedong in 1107. In 1907 the importance of Taiyuan was increased by the construction of a rail link to Shijiazhuang. Soon thereafter Taiyuan suffered a serious economic crisis. In the 19th century the merchants and local banks of Shanxi had been of national importance, but the rise of modern banks and the Taiping Rebellion led to the rapid decline of this system. In 1937, Taiyuan was conquered by the Japanese. By 1936 Taiyuan became a gathering point for anti-Japanese intellectuals who had fled. The Japaneses developed Taiyuan’s industries and resources until it fell under the Communist control.	The city has a wealth of attractions and notably among these is the Jinci Temple, a temple compound with ancient halls, pavillons, and towers surrounded by the mountains and ancient trees. This is the city's most attractive temple although the Shuangta Si (Twin-Pagoda Temple) has become a symbol of the city on account of its unique architecture shaping like two pens. CHongshan Temple, a major Buddhist temple is also worth visiting. For more historical site, the Chunyang Palace, built in Song Dynasty, will show you the unique Taoist architecture and the Old Mosque, built in Tang Dynasty, will show you some Islamic architecture.\r\n\r\nAnother major attraction is the Tianlongshan Stone Caves where magnificent sculptures dating from the Tang Dynasty (618-907) may be seen. In addition, Taiyuan has the only national coal museum in Asia, the Coal Museum of China, where you can learn about mining because the city has a unique coal culture. At the central part of Yingze Street in Taiyuan, you will find Yingze Park, a good place to experience the local life.	The city has a wealth of attractions and notably among these is the Jinci Temple, a temple compound with ancient halls, pavillons, and towers surrounded by the mountains and ancient trees. This is the city's most attractive temple although the Shuangta Si (Twin-Pagoda Temple) has become a symbol of the city on account of its unique architecture shaping like two pens. CHongshan Temple, a major Buddhist temple is also worth visiting. For more historical site, the Chunyang Palace, built in Song Dynasty, will show you the unique Taoist architecture and the Old Mosque, built in Tang Dynasty, will show you some Islamic architecture.\r\n \r\nAnother major attraction is the Tianlongshan Stone Caves where magnificent sculptures dating from the Tang Dynasty (618-907) may be seen. In addition, Taiyuan has the only national coal museum in Asia, the Coal Museum of China, where you can learn about mining because the city has a unique coal culture. At the central part of Yingze Street in Taiyuan, you will find Yingze Park, a good place to experience the local life.	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	37.869444, 112.560278	taiyuan	5	qsprovince_id
94	Yichang	宜昌	Here is an example of a short description	images/city/Yichang/Yichang.jpg	images/city/Yichang/Yichang_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	30.716667, 111.283333	yichang	17	qsprovince_id
95	Yiwu	义务	Here is an example of a short description	images/city/Yiwu/Yiwu.jpg	images/city/Yiwu/Yiwu_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	29.306944, 120.075278	yiwu	11	qsprovince_id
75	Tianjin	天津	Here is an example of a short description	images/city/Tianjin/Tianjin.jpg	images/city/Tianjin/Tianjin_large.jpg	Located in northern China and borders Hebei Province and Beijing, Tianjin is one of the five national central cities of China. In addition, it is located along the west coast of the Bohai Gulf, looking out to the Provinces Shandong and Liaoning across those waters.\r\n\r\nLike Beijing and Shanghai, It is governed as a direct-controlled municipality, which means it is under the direct administration of the central government. According to stats in 2015, It has a population of 15.47 million. Despite Tianjin’s proximity to the sea, it has a sharp daily and seasonal temperature fluctuations. Tianjin has four clearly divided seasons, with the hottest month being July (the average temperature can reach 26°C) and the coldest month is January (the average temperature is about -4°C). 	Tianjin has been an important transport and trading center since the Yuan (Mongol) Dynasty since it lies at the intersection of both inland and port navigation routes. During the foreign concession era (between 1895 and 1900), the British, French, Japanese, Germans, Austro-Hungarians, Italian, and Belgians settled in the area; therefore, Tianjin is known as the former foreign concession port. Although this marked an extremely hard period for the municipality, today’s Tianjin is famous for its subtle European-flavored neighborhoods. The historical background gives tourists a laid-back feeling, in contrast with the modern settings of this large, booming municipality.	Tianjin’s most famous attractions are mostly cultural and history related. Once housed thousands of famous historical figures, Tianjin is the place to taste the life of revolution heroes and heroines, ideologists, scientists, etc. \r\n\r\nHeping District, located in the center of Tianjin, is the center of culture, commerce, and finance in Tianjin. The Tianjin CBD, shopping centers, and banks are concentrated in this area. However, the most famous area is Wudadao (Five Great Avenues) -- an area that has European streetscapes, lined with charming historic houses. Other attractions to see include Tianjin Concert Hall, Porcelain House, Catholicism Xikai Head Church, France Building Public Discussion (today’s Juvenile Children Library), Jiefang Bridge, and Jingyuan. \r\n\r\nHexi District is in the south-western corner of downtown Tianjin, bordered by Heping District in the north-west. It contains Tianjin’s one of the most famous attractions, Tianjin Radio and Television Tower, the 8th tallest freestanding tower in the world. The Skydeck allows people to enjoy an overview of the city and the revolving restaurant provides customers both the view and comfort food. Other attractions to see include the Tientsin Country Club and the Tianjin Museum. \r\n\r\nHebei District is located on the northern shore of the Hai River, part of the Grand Canal. Tianjin’s famous Tianjin Eye, a 120-meter tall ferris wheel built over the Yongle Bridge, lies within the district. Other attractions to see in the area include the Italian Fengqing District, Italian Barrack, and Liang Qichao House.	Many Tianjin food comes in the form of street food, with the most famous being Jianbing Guozi, which is a type of Chinese savory crepes. It usually contains cracker, fermented flour source, chives, pepper, and egg. Another famous dish of Tianjin is Guoba Cai, typically comes as street food and breakfast. Guoba is referring a soft tortilla made of green bean and flour. You can usually spot these street foods in any busy areas. The best advice is to go for the one with the longest line. To try some traditional Tianjin dishes, Guiyuan Restaurant, Jincai Diancang, and Yimin Restaurant are the places to go. 	acc	Here is the weather	15500000	The Bund	100	t	f	f	f	f	f	39.133333, 117.183333	tianjin	3	qsprovince_id
76	Tongli	同理	Here is an example of a short description	images/city/Tongli/Tongli.jpg	images/city/Tongli/Tongli_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	tongli	10	qsprovince_id
77	Turpan	吐鲁番	Here is an example of a short description	images/city/Turpan/Turpan.jpg	images/city/Turpan/Turpan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	turpan	31	qsprovince_id
78	Urumqi	乌鲁木齐	Here is an example of a short description	images/city/Urumqi/Urumqi.jpg	images/city/Urumqi/Urumqi_large.jpg	The capital of the Xinjiang Uyghur Autonomous Region, Urumqi (also called Wulumuqi in Chinese) is located in the Tian Shan Mountains in Northwest China. As of 2015, it has an estimated population of 3.5 million. Urumqi is the largest city in China's western interior as well as in Central Asia in terms of population. Determined by the Guinness Book of Records, Ürümqi has earned a place as the most remote city from any sea in the world. The weather is noted for a large difference between summer and winter.	When the Chinese established the protectorate general of Beiting to the east, the area came under full Chinese control for the first time. Urumqi was a major hub on the Silk Road during China's Tang Dynasty. The city later became an important Manchu garrison for northwestern China. When the Muslim Rebellion broke out in the 1860s in Xinjiang, the city was taken by the rebels until it was recaptured in 1876 by Qing forces. It developed its reputation as a leading cultural and commercial center during the Qing Dynasty in the 19th Century. Since 1949, Urumqi has been developed as the regional capital and cultural center of Xinjiang as wells as a major industrial base.	For travelers, Urumqi has a lot to offer and can provide a great introduction to Xinjiang. Urumqi currently comprises eight county-level subdivisions including seven districts (Tianshan, Saybagh, Xinshi, Shuimogou, Toutunhe, Dabancheng, Midong) and one county (Urumqi County). There are plenty to see and experience in the city. Because of its ethnic minority culture, it has a relatively distinctive vibe compared to other big cities in China. The Xinjiang Uygur Regional Museum, located on Xibei Lu, will give you a very good introduction to the history of the region. The Da Bazar is a traditional Islamic Market area. It is definitely worth a visit in the evenings for some food and fun activities. The Liyushan Park displays many old trees from the desert, large stone trees, stones with carving from BCE, and some Przewalski horses, and other animals. Some other places to visit include, People’s Square, Shuimogou Hot Springs, Confucian Temple, Hong Shan, and Urumqi Tatar Mosque.	Food is one of the things for which Xinjiang is famous. Fresh naan, spicy kebabs, yogurt that tastes slightly like soda water but in a good way, steaming pilaf or famous hand stretched noodles — there are a lot of choices and lots of variety. Other common foods in Urumqi are dumplings of mutton and onions, Uyghur fried rice, dumpling soup, meat pies, and Opke Hessip (lungs and stuffed intestines). Qosh Amet is the best place to try Dapan Chicken (a spicy mixture of chicken and potatoes), the best known Hui dish, in town. Some of the other restaurants to try are Korgan, Vegan Yuanqi Vegetarian Restaurant, and Tashkent.	Here's where you can find all the best hotels in the city.	Here is the weather	3029000	The Bund	100	t	f	f	f	f	f	43.825, 87.6	urumqi	31	qsprovince_id
79	Wudang Shan	武当山	Here is an example of a short description	images/city/Wudang Shan/Wudang Shan.jpg	images/city/Wudang Shan/Wudang Shan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	wudangshan	17	qsprovince_id
80	Wuhan	武汉	Here is an example of a short description	images/city/Wuhan/Wuhan.jpg	images/city/Wuhan/Wuhan_large.jpg	Wuhan, the capital of  Hubei Province, it is the most populous city in central China. It lies in the eastern Jianghan Plain on the middle reaches of the Yangtze River at the intersection of the Yangtze and Han rivers. Wuhan has known as 'China's Thoroughfare'; it is a major transportation hub, with dozens of railways, roads, and expressways passing through the city and connecting to other major cities.	Wuhan once consisted of three separate cities: Hanyang, Hankou, and Wuchang Hanyang was a busy port as long as 3000 years ago in the Han Dynasty. Wuchang has been a center of learning for centuries, especially in the field of the arts. It was also once a provincial capital in the Yuan Dynasty. During the Ming and Qing dynasties, Kankou was considered to be one of China’s top four cities. The city is most famous for its pivotal role in the formation of modern China. The Wuchang Uprising and Xinhai Revolution, led by Sun Yat-Sen, resulted in the overthrow of the Qing Dynasty (the last Dynasty). In the ensuing chaos of the Republic of China, Wuchang was the capital of a leftist Guomindang government ruled over by Wang Jingwei in direct opposition to Chiang Kai-shek.\r\n\r\nWinters in the city are cold the average January temperature is 4°C (39°F) and low temperatures around freezing and the high humidity makes it feel much colder. Summers are hot and very humid. The combination of hot daytime temperatures, 32°C (90°F) on average.  Spring and autumn are pleasant transitional seasons. \r\n	The metropolitan area of Wuhan consists of three parts: Wuchang, Hankou, and Hanyang. The parts face each other across the rivers and are linked by bridges, including one of the first modern bridges in China, known as the "First Bridge". Furthermore, The sub-provincial city of Wuhan currently comprises 13 districts.\r\n\r\nIn Wuchang, there are plenty of attractions that you cannot miss. The Yellow Crane Tower existed in 233 AD and was rebuilt multiple times because of destructions. The tower sits atop Snake Hill near the Number One Yangtze River Bridge and affords a commanding view of the Yangtze River as well as the mouth of the Han River where it connects. East Lake, the largest urban lake in China, covers an area of 88 square kilometers. It is known for the variety of flowers that bloom throughout four seasons.\r\n\r\nIn Hanyang, you should also visit the Guishan Mountain, Hanyangzao Art District (situated at the foot of Guishan Mountain), Qing Huang, and Guqintai. Qingchuange and Guqintai and the Yellow Crane Tower are said to be the three most famous attractions of Wuhan.\r\n\r\nIn Hankou, you can also go to Wuhan Art Museum, Gudeshi Temple, Jianghanlu Road, and Hankoujiangtan. 	Wuhan is most famous for its morning Xiaochi (snacks). Hubuxiang （户部巷） in Wuchang is Wuhan's famous breakfast alley where you will find all of Wuhan's famous breakfast dishes. Reganmian (热干面） (literally, "hot dry noodle") is the epitome of Wuhan's breakfast food. It is noodles with peanut sauce, tossed in sesame paste and other seasonings. Other Wuhan breakfast specialties include Mianwo, a type of savory donut; Tangbao, small dumpling-buns filled with pork and soup; Mibaba, a lightly sweetened pancake made with rice flour; and Mijiu Tangyuan, a sweet soup of rice wine (fermented from glutinous rice) with rice flour dumplings stuffed with sesame paste and "doupi", rice fried into a cake with tofu skin and some pickled vegetables.	Here's where you can find all the best hotels in the city.	Here is the weather	10670000	The Bund	100	t	t	t	f	f	f	30.583333, 114.283333	wuhan	17	qsprovince_id
81	Wuxi	无锡	Here is an example of a short description	images/city/Wuxi/Wuxi.jpg	images/city/Wuxi/Wuxi_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	3542000	The Bund	100	f	f	f	t	f	f	31.566667, 120.3	wuxi	10	qsprovince_id
82	Wuyi Shan	武夷山	Here is an example of a short description	images/city/Wuyi Shan/Wuyi Shan.jpg	images/city/Wuyi Shan/Wuyi Shan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	0,0	wuyishan	13	qsprovince_id
96	Yulin	榆林	Here is an example of a short description	images/city/Yulin/Yulin.jpg	images/city/Yulin/Yulin_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	38.283333, 109.733333	yulin	27	qsprovince_id
83	Xiamen	厦门	Here is an example of a short description	images/city/Xiamen/Xiamen.jpg	images/city/Xiamen/Xiamen_large.jpg	Xiamen, a sub-provincial city in southeastern Fujian Province, is a coastal city located beside the Taiwan Strait.It has been an important port for centuries and became one of China's earliest Special Economic Zones in the 1980s. The name Xiamen means "door to the house", referring to the city's centuries-old role as a gateway to China. Xiamen is definitely a vibrant, affluent and modern place.	During the Song (960–1279) and Yuan (1279–1368) dynasties, Xiamen was known as Jiahe Island and formed a part of Tong’an county. It was notable chiefly as a lair of pirates and a center of contraband trade. During the 1650s, the area was under the control of Zheng Chenggong until the forces of the Qing Dynasty made it the headquarters of the Quanzhou naval defense force. Xiamen has been an important port for foreign trade. The Portuguese started to arrive in 1544. After the First Opium War, Xiamen was one of the first five ports opened to foreigners. In the late 19th century, Xiamen was the base from which Taiwan was settled and exploited, and the port retained a close link with the island even after the Japanese conquest of Taiwan in 1895.\r\n\r\nXiamen’s weather is characterized by long, hot, and humid summers and short, mild, and dry winters. The warmest month is usually July, and the coolest is January.	Xiamen is divided into six districts: Huli, Siming, Jimei, Tong’an, Haicang, and Xiang’an. Xiamen and its surrounding countryside are known for its scenery and tree-lined beaches. There are also many hipster places in Xiamen for young people to explore.\r\n\r\nLocated right across the harbor, Gulangyu is a former treaty port enclave. Today, it is a popular island that features Victorian-style building for people who want to have a weekend getaway. Another famous attraction is the Sunlight Rock, facing the TIer Head Hill across the bay on Xiamen Island. The Buddhist Nanputuo Temple dates back to the Tang Dynasty, is worth visiting. Hulishan Fortress was built in 1894 as a relic of the Westernization Movement. You can find gorgeous wall sculpture and water fountain there.\r\n \r\nIf you are looking for something to do at night, you should go to the Zhongshan Road Pedestrian Street for some food and modern spots and Shapowei for some hip cafes and artistic discoveries that only local people know.	Xiamen traditional dishes form a branch of southern Fujianese cuisine, with Taiwanese influence. It is particularly well known within China for its street food and snacks. The staple foods of Xiamen have long been rive, seafood, pork, and sweet potatoes. Some famous local foods are Xiamen Glass Noodles, Oyster omelet, Xiamen Fish Balls, Sea Worm Jelly, Shacha Noodles, Shrimp Noodle Soup, Xiamen GLutinous RIce Wrap, Peanut Soup, Xiamen Pot Stickers, and Crab Porridge. There are many local dishes scattered around Zhongshan Rd (the Pedestrian Shopping district) and LunDu (the harbor to get to Gulangyu islet). If you are looking for some more modern cafes and restaurants, There is a whole strip of cafes and bars along the lake on Xidi Coffee Street next to Marco Polo Hotel.	Here's where you can find all the best hotels in the city.	Here is the weather	3531000	The Bund	100	t	t	t	f	f	f	24.479836, 118.089419	xiamen	13	qsprovince_id
84	Xi'an	西安	If you're even remotely interested in history, Xi'an is not to be missed	images/city/Xian/Xian.jpg	images/city/Xian/Xian_large.jpg	Xi'an, former name is Chang’an (Eternal City), is the capital of Shanxi Province. It is a sub-provincial city located in the center of the Guanzhong Plain in Northwestern China. The profound history of the city makes it one of the greatest tourist destination of China.	One of the oldest cities in China, Xi'an is the oldest of the Four Great Ancient Capitals, having held the position under several of the most important dynasties in Chinese history, including Western Zhou, Qin, Western Han, Sui, and Tang. Xi'an is the starting point of the Silk Road and home to the Terracotta Army of Emperor Qin Shi Huang. It was also the most splendid and extravagant cities in the world during the Tang Dynasty (618-907). Since the 1990s, as part of the economic revival of inland China especially for the central and northwest regions, the city of Xi'an has re-emerged as an important cultural, industrial and educational center of the central-northwest region, with facilities for research and development, national security and China's space exploration program.\r\n\r\nThe weather in Xi’an features hot, humid summers, cold, dry winters, and dry springs and autumns. Dust storms often occur during March and April as the city rapidly warms up. Summer months also experience frequent but short thunderstorms. The number of travelers is often greater during Summer (May-August), although the most pleasant season for visiting Xi'an is Autumn	Tourism of Xi’an is based on the city’s many historical monuments and a plethora of ancient ruins and tombs in the vicinity.\r\n\r\nMany come to Xi’an just for the Mausoleum of Qin Shi Huang and his Terracotta Army, located 40 km to the east of the city center, but there are also several burial mounds, tombs of the Zhou Dynasty kings and some 800 royal mausoleums and tombs from the Han Dynasty. Xi’an also has numerous Tang Dynasty pagodas and is noted for its history museum and its stele forest, which is famous for its numerous historic inscriptions and stoneworks. Another well-known site in Si’an is a well-preserved city wall that was constructed in the 14th century during the Ming Dynasty. The Big Goose Pagoda is spectacular towers that were built more than 1000 years ago. It has some of the most original Buddhist writings protected from the past.\r\n\r\nThe Bell Tower and Drum Tower are some historic attractions located in the city. In addition, the city’s Muslim Quarter, home to the Great Mosque of Xi’an, is located also inside the city. \r\n	Praised as 'the capital of table delicacies', Xian has been rich in delicious local snacks such as the must-try Crumbled Flatbread in Mutton Stew (Yangrou Paomo), Cold Noodles (Liang Pi) and Shaanxi Sandwich (Rou Jia Mo). Travelers can also find delicate Guangdong dishes, popular Sichuan food and various kinds of fashionable foreign delicacies. Street foods are popular options that present a variety of local/regional dishes, ranging from soups, dumplings, hot pot, and so on. Another place to look for restaurants is the Muslim Quarter, a vibrant area with many restaurants spilling out onto the street and mixing with the street sellers. If you're looking for snacks, this area is also full of people selling dried fruit (especially dates) and nuts/seeds (sunflower, melon, pumpkin, etc.)	Here's where you can find all the best hotels in the city.	Here is the weather	8627000	The Bund	5	t	t	t	f	f	t	34.266667, 108.9	xian	27	qsprovince_id
85	Xining	西宁	Here is an example of a short description	images/city/Xining/Xining.jpg	images/city/Xining/Xining_large.jpg	Xining, the capital of Qinghai Province and the largest city on the Tibetan Plateau, is situated in a fertile mountain basin in the valley of Shuang River, a tributary of the Yellow River.	Xining has a history of over 2,100 years and was a chief commercial hub on the Hexi Corridor caravan route to Tibet, handling especially timber, wool and salt in ancient times. The trade along the Hexi Corridor was part of a larger trade corridor along the Northern Silk Road. t was a frontier county under the Sui (581–618) and Tang(618–907) dynasties; during the 7th and early 8th centuries it was a centre of constant warfare with the Tuyuhun and later the Tibetan peoples. In 763 it was overrun by the Tibetans. Recovered by the Song dynasty in 1104, it received the name Xining. With the rise of Tibetan Buddhism (Lamaism), which began in the 7th century CE, Xining became an important religious centre. Xining was subjected to aerial bombardment by Japanese warplanes in 1941 during the Second-Sino Japanese War. The bombing spurred all ethnicities in Qinghai. Industrial development has been steady since the late 1950s.	Xining is also called the Summer Resort Capital of China for its cool summer. The region also provides a number of attractions making a visit to the area well worth considering. The scenery of the Qinghai Lake, provides an escape from fervent cities and allows you to experience beautiful natural sceneries. The lake itself is quite amazing. The Birds Island, situated on the northwest of Qinghai Lake, is waiting to present you with an extensive array of birds. To the city's southwest, is the birthplace of the founder of the Gelugpa Sect. The gem of the Tibetan culture-Ta'er Monastery was built here. To the north of Xining is the Northern Buddhist Temple. Climbing the temple will reward you with a view of the city from the mountaintop. A site not to be missed is the Dongguan Mosque, one of the biggest mosques in northern China. Other mosques that are worth visiting are Northern Ch’an Monastery and Southern Ch’an Monastery.	As the capital of Qinghai Province, Xining almost boasts all varieties of local flavors. Xining's cuisine is distinct from other varieties of Chinese cities using mainly food products native to the area. Food here is substantial, but quite inexpensive.\r\n\r\nIn Xining, some restaurants serve varieties of 'plateau flavor', such as Feng'er Liji (a round lamb tenderloin), Danbai Chongcao Ji (a medicine cuisine made of chicken, Chinese caterpillar fungus and eggs), Jinyu Facai (pork wrapped in flagelliform nostoc and shaped as a goldfish) among others. These dishes are often cooked by the locals at home. There are also many small restaurants offering noodles. Gan Ban is a very common noodle dish. Perhaps Mian Pian, which means "noodle leaves" is the most common noodle plate among the Qinghai people. On the streets, many Muslims sell spicy lamb brochette.	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	36.633333, 101.766667	xining	29	qsprovince_id
86	Xishuangbanna	西双版纳	Here is an example of a short description	images/city/Xishuangbanna/Xishuangbanna.jpg	images/city/Xishuangbanna/Xishuangbanna_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	0,0	xishuangbanna	25	qsprovince_id
87	Xuzhou	徐州	Here is an example of a short description	images/city/Xuzhou/Xuzhou.jpg	images/city/Xuzhou/Xuzhou_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	0,0	xuzhou	10	qsprovince_id
88	Ya'an	雅安	Here is an example of a short description	images/city/Ya'an/Ya'an.jpg	images/city/Ya'an/Ya'an_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	yaan	23	qsprovince_id
89	Yan'an	延安	Here is an example of a short description	images/city/Yan'an/Yan'an.jpg	images/city/Yan'an/Yan'an_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	yanan	27	qsprovince_id
90	Yangshuo	阳朔	Here is an example of a short description	images/city/Yangshuo/Yangshuo.jpg	images/city/Yangshuo/Yangshuo_large.jpg	Yangshuo, a county under the jurisdiction of Guilin City, is located in the northeast of Guangxi Province. It is surrounded by karst peaks and bordered on one side by the Li River. This picturesque city is a popular tourist destination well-known for the stunning natural scenery it offers. Yangshuo has maintained its sense of charm and the quaintness of a small town, which has resulted in a delightful destination that offers fresh air and freedom from the air and noise pollution that is so plentiful in other cities in China.	The city is said to be found in the year 265. In 590, during the Sui Dynasty, the county seat was moved to today’s Yangshuo. During the Tang Dynasty, a section of the county was split. It remained as the Guiyi County until it was reabsorbed in 627. Yangshuo County has for many centuries been under the jurisdiction of the nearby city of Guilin, but in 1949 Yangshuo County was granted liberation and was able to build its own government that comprised of its own local people. In 1981 Yangshuo County was once against placed back into the administrative control of Guilin City.	Yangshuo is popular among tourists for its karst peaks, rivers, caves, and temples, as well as its laid back cafes and bars. The four landmarks of Yangshuo are Li River, Moon Hill, Yulong River, and Silver Cave. The Moon Hill is south of the town. It is a hill with a huge hole in the shape of a moon. The Yangdi-Xingping scenic area, stretching along the Li River, is also worth visiting. You can be on a traditional bamboo rafts that takes you along this streth. The Yulong River Valley is a pretty valley that is said to rival the Yangdi-Xingping stretch. A journey along the river will bring you through many farming villages and several stone bridges such as the Yulong Bridge and Fuli Bridge. Other sceneries include Assembling Dragon Cave, Liugong, Green Lotus Peak, Shuton Hill, and Antenna Hill. At night, many people go to bars on the West Street.	Local specialities include Tianluo Xiang and Pijiu Yu (Beer fish).  The fish with the least bones are Jiangu Yu and the bigger and cheaper ones Maogu Yu. Almost all restaurants have English menus. You can eat cheaply in the markets with the locals or you can try comfort food in many cafes. There is a concentration of cheap & tasty rice noodle places on the Western end of Guihua Rd.\r\n\r\nYou can also find plenty of selections of Western food in many restaurants in Yangshuo. Some recommended ones include Balcony Bar, Minority Cafe, Dosa UK, Luna, Kelly’s Cafe, Nature’s Cup, and Roof Garden.	Here's where you can find all the best hotels in the city.	Here is the weather	300000	The Bund	100	t	t	t	f	f	f	24.783333, 110.5	yangshuo	20	qsprovince_id
98	Zhangjiajie	张家界	Here is an example of a short description	images/city/Zhangjiajie/Zhangjiajie.jpg	images/city/Zhangjiajie/Zhangjiajie_large.jpg	Zhangjiajie, a prefecture-level city in the northwestern part of Hunan Province, is located in central Chinal. The three-character name can be interpreted as follows: "Zhang" is a common surname in China; "jia" can be translated as "family"; and "jie" can be translated as "homeland", giving the completed translation of "Zhang family homeland." Zhangjiajie is famous for its precarious peaks, limpid streams, dense forests, and large karst caves.	There is extensive fog in the park at times, and summers are very humid. Temperatures vary greatly between early morning and late afternoon. Wulingyuan covers 3 natural reserves, and contains over 500 tree species, including dawn redwood, believed extinct until it was re-identified in 1948. There are also giant salamanders, rhesus monkeys, and many bird types.\r\n\r\nThe city itself was previously named Dayong, and has a recorded history dating back to 221 BC. Human settlement in this region dates back 100,000 years, rivaling such famous sites as Xi’an, Beijing and others. In 1986, the Academy of Chinese Social Science discovered Stone Age relics in Cili County, unearthing 108 articles of stoneware; mostly tapered-form, hacked-tamped and plate-shaped works. According to archaeological experts’ textual research, all of these wares were produced about 100,000 years ago.	Zhangjiajie was thrust into foreigner travelers' eyes after the movie Avatar. The Hallelujah Mountains in Avatar were inspired by Heavenly Pillar in Zhangjiajie National Forest Park. Within it is located Wulingyuan Scenic Area which was designated a UNESCO World Heritage Site in 1992 as well as an AAAAA scenic area by the China National Tourism Administration.\r\n\r\nThe three must-see attractions in Zhangjiajie are the National Park, Tianmen Mountain, and Zhangjiajie Grand Canyon Glass Bridge. One of the most interesting things to do here is the experience of drifting on the Maoyan River. The Maoyan River is the upper reach of the Li River in Yongding District. Other attractions include Phoenix Ancient Town, Suoxi Valley, Tianzi Mountain, Yangjiajie Scenic Area, Zhangjiajie Grand Canyon, and Zhangjiajie Glass Bridge, and Zhangjiajie National Forest Park ( China's first national forest park).  The scenic area hosts many natural features including: mountains, forests, caves, lakes and waterfalls and perhaps there are more than three thousand rock ridges and eight hundred ghylls. 	In Zhangjiajie City of Hunan Province the cuisine of the Tujia ethnic minority group has its own flavor but retains the primary characteristic of Hunan cuisine - a tantalizing sour and spicy flavor. Many Chinese know that Hunan cuisine has a most outstanding characteristic - the delightful combination of sourness and spice. The cook can skillfully prepare many dishes with a delicious taste and a beautiful presentation by adding various seasonings and adopting a wide variety of cooking techniques.\r\n\r\nThe sautéed and pickled dishes are very special. The characteristic dishes in Zhangjiajie include Tuannian Dish, Blooded Tofu, Sour Fish, and Gastrodia Tuber with Black-boned Chicken Soup. Local flavored snacks include She Meal, Sangzhi Salted Dried Tofu, Chinese gooseberry juice, and Juhuaxin and Jinxiang Grapefruit.	Here's where you can find all the best hotels in the city.	Here is the weather	1476000	The Bund	100	f	f	f	t	f	f	29.133333, 110.483333	zhangjiajie	18	qsprovince_id
99	Zhangjiakou	张家口	Here is an example of a short description	images/city/Zhangjiakou/Zhangjiakou.jpg	images/city/Zhangjiakou/Zhangjiakou_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	t	f	f	40.766667, 114.883333	zhangjiakouu	4	qsprovince_id
100	Zhaoqing	肇庆	Here is an example of a short description	images/city/Zhaoqing/Zhaoqing.jpg	images/city/Zhaoqing/Zhaoqing_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	0,0	zhaoqing	19	qsprovince_id
101	Zhengzhou	郑州	Here is an example of a short description	images/city/Zhengzhou/Zhengzhou.jpg	images/city/Zhengzhou/Zhengzhou_large.jpg	Zhengzhou, the capital of Henan Province, is situated to the south of the Yellow River, where its valley broadens into the great plain and at the eastern extremity of the Xiong’er Mountains. It is one of the eight National Central Cities, also serving as the political, economic, technological, and educational center of the Province, as well as a major transportation hub in China.	The site is generally identified with the Shang capital of Ao. The Shang, who continually moved their capital, left Ao, perhaps in the 13th century BCE. The site, nevertheless, remained occupied; Zhou tombs have also been discovered. Traditionally it is held that in the Western Zhou period (1111–771 BCE) it became the fief of a family named Guan. he city first became the seat of a prefectural administration in 587 CE, when it was named Guangzhou. In 605 it was first called Zhengzhou—a name by which it has been known virtually ever since. It achieved its greatest importance under the Sui (581–618 CE), Tang (618–907), and early Song (960–1127) dynasties, when it was the terminus of the New Bian Canal, which joined the Huang He to the northwest. In 1903 the Beijing-Hankou railway arrived at Zhengzhou, and in 1909 the first stage of the Longhai Railway gave it an east-west link to Kaifeng and Luoyang.	Zhengzhou is divided into six urban districts, including Jinshui, Erqi, Huiji, Guancheng Hui, and Zhongyuan Districts. A long history has left the city with many cultural and historic sites.\r\n\r\nSome of the landmarks in Zhengzhou include Erqi Memorial Tower, Shang Dynasty Wall, Shaolin Temple, Northern Song Dynasty Imperial Tombs, and Ruyi Lake. At the mention of Shaolin Temple, tourists mostly think of Shaolin Kung Fu.\r\n\r\nThere are also a lot of museums to visit, such as the Henan Provincial Museum, Henan Museum of Science and Technology, and the Yellow River Museum.\r\n\r\nFor some natural sceneries, the Yellow River Scenic Area is the best place to go. There are green lands, clear waters, pavilions, scattered statues with interesting histories, inside the scenic area. Other places also include Zhengzhou Zoo, Renmin Park, Century Park, and Emperor Palace.\r\n\r\nIn downtown, you can visit the Erqi Square, the busiest commercial area in Zhengzhou; Shang Ruins, the largest and the most well-preserved site of the capital city in early Shang Dynasty; and the Henan Museum, a modern historic museum.	With its long history, Henan Province is a cradle of ancient Chinese culture. This has resulted in an abundance of historical sites and a rich culture, one of which is Yu (short for Henan Province) Cuisine. As the capital of Henan Province, Zhengzhou undoubtedly takes Yu Cuisine as its main menu.\r\n\r\nThe top ten must try dishes in Zhengzhou include Luoyang Water Banquet, Chinese Wild Yams, Carp on Noodles, Kaifeng Steamed Stuffed Buns, Jiaohua Ji, Almond Tea Soup, Braised Yellow Carp with Brown Sauce, Donkey Soup, Mashed Sweet Potato, and Fried Jelly.\r\n\r\nSome restaurant recommendation include Four Seasons Tongda Eco Park Restaurant,, Huayu Chuan, and Zhengzhou Roast Duck Restaurant.	Here's where you can find all the best hotels in the city.	Here is the weather	6406000	The Bund	100	f	f	f	t	f	f	34.766667, 113.65	zhengzhou	16	qsprovince_id
102	Zhenjiang	镇江	Here is an example of a short description	images/city/Zhenjiang/Zhenjiang.jpg	images/city/Zhenjiang/Zhenjiang_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	32.2, 119.416667	zhenjiang	10	qsprovince_id
103	Zhongshan	中山	Here is an example of a short description	images/city/Zhongshan/Zhongshan.jpg	images/city/Zhongshan/Zhongshan_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	22.533333, 113.35	zhongshan	19	qsprovince_id
104	Zhuhai	珠海	Here is an example of a short description	images/city/Zhuhai/Zhuhai.jpg	images/city/Zhuhai/Zhuhai_large.jpg	"Here is a longer description with all the information you could possibly want to know about this amazing place"	test	Here are the best things to do in this city:	Here are the best things to eat in this city:	Here's where you can find all the best hotels in the city.	Here is the weather	1	The Bund	100	f	f	f	f	f	f	22.276944, 113.567778	zhuhai	19	qsprovince_id
105	Changchun	长春	A city of the former puppet state of Manchuria	test	test	Changchun, the largest city and the provincial capital of Jilin Province, is located in the center of the Songliao Plain. Known locally as China’s “city of automobiles”, it is one of the most important industrial bases of China with a particular focus on the automotive sector ever since the 1950s.	The area around the city was originally a grazing ground for a Mongol army division. The Mongol duke requested and was granted permission from the Qing court to open this area in the 1790s. Subsequently, it became a small trading post and frontier village during the reign of the Jiaqing Emperor. Changchun moved to today’s location in 1825, shortly after the subprefecture, Changchun, was established. Before the Russo-Japanese War of 1904-1905, the Russian Empire constructed the first railway station of the city, which was transferred to Japanese control. On March 10, 1932 the capital of Manchukuo (later was renamed Hsinking), a Japan-controlled puppet state in Manchuria, was established in Changchun. The city underwent rapid expansion in both its economy and infrastructure. At the end of World War II, the city was heavily damaged by Soviet forces. The Chinese Communist armies gained control of the city in 1948 and turned it into one of the principal sites for industrial expansion in Northeast China.	Changchun has a total of 6 districts, Shuangyang, Chaoyang, Nanguan, Kuancheng, Erdao, and Luyuan Districts with the latter five being the closest to the city center. Changchun is a very compact city planned by the Japanese with a layout of open avenues and public squares (guǎngchǎng). It is pretty easy to travel from one place to another.\r\n\r\nTo begin with, the Puppet Emperor's Palace (Wei Huang Gong), also known as the The Museum of The Imperial Palace of Manchukuo, is the most famous attraction. It was here that Puyi, the last emperor of China was installed as the nominal head of state by the Japanese. The Puppet Emperor's Palace is located in the northeast of Changchun City. Then Changchu Confucian Temple, constructed in 1827, it’s another attraction that is dedicated to Confucius, the most famous and influential educator and thinker in China. For some relatively modern sight, the World Sculpture Park is a modern spot combining natural hill and modern sculptures. 	Delicacy in Changchun absorb the merits of other China’s cuisines such as Sichuan cuisine, Beijing cuisine, Shandong cuisine and so on. Especially, local featured dishes of wild animals are favored by tourists at home and abroad. Some others local snacks are characterized by flavor of northeast China and Korean ethnic group. Some signature dishes include DaGao, Fried Pork in Scoop, Ginseng and Chicken Cooked with Maotai Wine, and the Manchu Eight Dishes.\r\n\r\nThere are a few food streets where you can find the authentic local food and snacks. Chongqing Road and Hongqi Street are the most popular spots in town. 	test	test	3815000	test	100	f	f	f	t	f	f	43.886944, 125.324722	changchun	8	test
106	Yinchuan	银川	The capital of the Ningxia Hui Autonomous Region	test	test	Yinchuan, the capital of the Ningxia Hui Autonomous Region, is located in northern Ningxia in the south-central section of the Helan Mountains, near the western end of the Great Wall of China. The city lies west of the upper course of the Yellow River.	Yinchuan was originally a county under the name of Fuping in the 1st century BCE; its name was changed to Huaiyuan in the 6th century CE. After the fall of the Tang dynasty in 907, it was occupied by the Tangut Western Xia Empire and was made the capital of the empire. After the destruction of the Xi-Xia dynasty by the Mongols in 1227, Yinchuan was mercilessly pillaged by the Mongols with its population totally slaughtered. In 1929, when the Province of Ningxia was formed from parts of Gansu and Inner Mongolia, it became the provincial capital city. During the Dungan revolt (1862-77), Dungan forces massacred 100,000 people in Yinchuan. In the 1950s it had many commercial enterprises, and there were some handicrafts but no modern industry. Beginning in the late 1950s, some of the factories located in the eastern Provinces along the coast were moved to Yinchuan, which initiated the development of a local machine-building industry. In addition, extensive coal deposits were discovered near Shizuishan.	In Yinchuan, there are desert, lakes, rivers and mountains at the same time. The most attractive attraction in Yinchuan is the Sand Lake Scenic Resort (Sha Hu). Here, visitors can enjoy exquisitely beautiful vista views of shimmering sand beaches, azure-blue water, deep green reeds, various waterfowls, gentle water lilies and also snow-covered mountains. An unusual combination of both rivers and desert are available at Shapotou, where the landscape abounds with marvelous contrasts that will certainly delight you.\r\n\r\nIn addition to the natural scenery, many historic sites can be found in Yinchuan City. Reputed to be the 'Oriental Pyramid', the Western Xia Imperial Tombs have an intriguing and mysterious aura that is compelling and fully fascinating. Other historical attractions include the West Pagoda, North Pagoda, Ningxia Great Wall, Haibao Pagoda, Chengtiansi Pagoda, Jade Emperor Pavillion.\r\n\r\nAnd then, there are even more attractions such as the Western Film and TV City, Zhongshan Park, and Drum Tower to name only a few. Yinchuan is a city that offers you a warm welcome.	Yinchuan, as a main cultural center for the Hui people in China, offers a variety of unique Muslim food as well as traditional Chinese fare. Visitors can not only sample authentic Islamic dishes but also taste some of the unique Hui cuisine.\r\n\r\nThe dishes most representative of Yinchuan are Qingzheng Yanggaorou (steamed lamb), Shouzhua Yangrou (mutton eaten with hands), Yangrou Paomo (shredded cake in mutton and beef soup), and Xiangsuji (spiced crisp chicken).\r\n\r\nThe traditional Gaiwancha (a tea beverage), which is said to have originated during the Tang Dynasty (618-907), is also of Hui origin. This tea comes in a variety of flavors due to the different ingredients added sugar, crystal sugar, five-savory (tea leaf, crystal sugar, longan, raisin, and dried apricot), and eight-treasure ( Chinese date, Barbary wolfberry fruit, walnut kernel, longan, gingili, raisin, white sugar and tea leaf).	test	test	1290170	test	100	f	f	f	t	f	f	38.466667, 106.266667	yinchuan	30	test
\.


--
-- Data for Name: maincontent_cityimages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maincontent_cityimages (id, imfilename, imthumbfilename, imcaption, imauthor, imcityname_id) FROM stdin;
1	images/city/shanghai/01.jpg	images/city/shanghai/01_thumb.jpg	This is the hero shot	Your mother	64
2	images/city/shanghai/02.jpg	images/city/shanghai/02_thumb.jpg	Some	One	64
3	images/city/shanghai/03.jpg	images/city/shanghai/03_thumb.jpg	Your	Boss	64
4	images/city/shanghai/04.jpg	images/city/shanghai/04_thumb.jpg	Some	Person	64
5	images/city/shanghai/05.jpg	images/city/shanghai/05_thumb.jpg	Super	Sooper	64
6	images/city/shanghai/06.jpg	images/city/shanghai/06_thumb.jpg	Flying	Eagle	64
7	images/city/shanghai/07.jpg	images/city/shanghai/07_thumb.jpg	ppl are walking	everywhere	64
8	images/city/shanghai/08.jpg	images/city/shanghai/08_thumb.jpg	This aisn't a thumbnail	yo	64
9	images/city/shanghai/09.jpg	images/city/shanghai/09_thumb.jpg	A great mistake	Today	64
10	images/city/shanghai/10.jpg	images/city/shanghai/10_thumb.jpg	Not a great day	Today	64
11	images/city/beijing/15420575789_2bb1cbd597_h.jpg	images/city/beijing/15420575789_2bb1cbd597_h_thumb.jpg	Travis Wise	Travis Wise https://www.flickr	6
12	images/city/beijing/33371465722_65023f19bd_k.jpg	images/city/beijing/33371465722_65023f19bd_k_thumb.jpg	Bikes in a Hutong	Roman Boed https://www.flickr.com/photos/romanboed/	6
13	images/city/beijing/33595662166_f28869a0fd_k.jpg	images/city/beijing/33595662166_f28869a0fd_k_thumb.jpg	Hutong Chef	Roman Boed https://www.flickr.com/photos/romanboed/	6
14	images/city/beijing/32635852234_085eef892d_k.jpg	images/city/beijing/32635852234_085eef892d_k_thumb.jpg	Forbidden City	Roman Boed https://www.flickr.com/photos/romanboed/33399544191/	6
15	images/city/beijing/33375228311_54bbdec1dc_k.jpg	images/city/beijing/32635852234_085eef892d_k33375228311_54bbdec1dc_k_thumb.jpg	Forbidden City	Roman Boed https://www.flickr.com/photos/romanboed/	6
16	images/city/beijing/33399544191_1c685021c6_k.jpg	images/city/beijing/33399544191_1c685021c6_k_thumb.jpg	Hutong Entrance	Roman Boed https://www.flickr.com/photos/romanboed/	6
17	images/city/beijing/33512289405_206b972b8f_k.jpg	images/city/beijing/33512289405_206b972b8f_k_thumb.jpg	Hutong Sitting Area	Roman Boed https://www.flickr.com/photos/romanboed/	6
18	images/city/beijing/14931633799_966f1e71d2_o.jpg	images/city/beijing/14931633799_966f1e71d2_o_thumb.jpg	Forbidden City	Travel Guide	5
19	images/city/beijing/15420575789_845bf3933a_o.jpg	images/city/beijing/15420575789_845bf3933a_o_thumb.jpg	Great Wall	Travis Wise https://www.flickr.com/photos/photographingtravis/	6
20	images/city/beijing/17644872995_4f1303b253_k.jpg	images/city/beijing/17644872995_4f1303b253_k_thumb.jpg	Beijing CBD	Yiannis Theologos Michellis https://www.flickr.com/photos/zoonyzoozoodazoo/	6
21	images/city/beijing/25774930174_95a98e5d6f_k.jpg	images/city/beijing/25774930174_95a98e5d6f_k_thumb.jpg	Forbidden City	Cory Denton https://www.flickr.com/photos/57875964@N08/	6
22	images/city/beijing/28099576673_ce3f2cb520_k.jpg	images/city/beijing/28099576673_ce3f2cb520_k_thumb.jpg	Forbidden City	xiquinhosilva https://www.flickr.com/photos/xiquinho/	6
23	images/city/beijing/33375228311_54bbdec1dc_k.jpg	images/city/beijing/33375228311_54bbdec1dc_k_thumb.jpg	Forbidden City	Roman Boed https://www.flickr.com/photos/romanboed/	6
24	images/city/beijing/34370017420_d603ff1c23_k.jpg	images/city/beijing/34370017420_d603ff1c23_k_thumb.jpg	Summer Palace	Aardwold6886 https://www.flickr.com/photos/132734449@N05/	6
25	images/city/guangzhou/3440737305_facc11610d_o.jpg	images/city/guangzhou/3440737305_facc11610d_o_thumb.jpg	Sun Yat Sen Memorial	xiqinhosilva https://www.flickr.com/photos/xiquinho/	26
26	images/city/guangzhou/5529046923_3b0c06ce71_o.jpg	images/city/guangzhou/5529046923_3b0c06ce71_o_thumb.jpg	Pearl River	Dai Luo https://www.flickr.com/photos/dailuo/	26
27	images/city/guangzhou/9367794533_de15b38358_k.jpg	images/city/guangzhou/9367794533_de15b38358_k_thumb.jpg	Old Charm Of Guangzhou	Kevin Poh https://www.flickr.com/photos/kevinpoh/	26
28	images/city/guangzhou/15092304688_3433c770d8_k.jpg	images/city/guangzhou/15092304688_3433c770d8_k_old.jpg	Guangzhou Tower	Mathias Apitz (München) https://www.flickr.com/photos/abzisse/	26
29	images/city/guangzhou/16851733691_27ac452510_k.jpg	images/city/guangzhou/16851733691_27ac452510_k_thumb.jpg	Tai Chi	llee_wu https://www.flickr.com/photos/13523064@N03/	26
30	images/city/guangzhou/32110218833_f316e6c699_k.jpg	images/city/guangzhou/32110218833_f316e6c699_k_thumb.jpg	Guangzhou Tower	xiquinhosilva https://www.flickr.com/photos/xiquinho/	26
31	images/city/guangzhou/32205008854_5b4190cc87_k.jpg	images/city/guangzhou/32205008854_5b4190cc87_k_thumb.jpg	Guangzhou Skyline	xiquinhosilva https://www.flickr.com/photos/xiquinho/	26
32	images/city/guangzhou/32665863190_1393cd1c51_k.jpg	images/city/guangzhou/32665863190_1393cd1c51_k_thumb.jpg	Guangzhou Skyline	xiquinhosilva https://www.flickr.com/photos/xiquinho/	26
33	images/city/guangzhou/32894236042_1509de8cc0_k.jpg	images/city/guangzhou/32894236042_1509de8cc0_k_thumb.jpg	Guangzhou Skyline	xiquinhosilva https://www.flickr.com/photos/xiquinho/	26
34	images/city/guangzhou/32925180405_789d0883b0_k.jpg	images/city/guangzhou/32925180405_789d0883b0_k_thumb.jpg	Guangzhou Tower	xiquinhosilva https://www.flickr.com/photos/xiquinho/	26
35	images/city/guangzhou/33006159766_2cd6a61863_k.jpg	images/city/guangzhou/33006159766_2cd6a61863_k_thumb.jpg	Guangzhou	xiquinhosilva https://www.flickr.com/photos/xiquinho/	26
36	images/city/guangzhou/34506890600_2466226e61_k.jpg	images/city/guangzhou/34506890600_2466226e61_k_thumb.jpg	Guangzhou Nighttime	Mathias Apitz (München) https://www.flickr.com/photos/abzisse/	26
37	images/city/guangzhou/38498951055_6da2d3db0c_k.jpg	images/city/guangzhou/38498951055_6da2d3db0c_k_thumb.jpg	Guangzhou Tower	Unknown	26
38	images/city/guangzhou/15092304688_3433c770d8_k.jpg	images/city/guangzhou/15092304688_3433c770d8_k_thumb.jpg	Temple Roof	Billy Wu https://www.flickr.com/photos/127135321@N03/	26
39	images/city/shenzhen/856999118_7d376b5664_o.jpg	images/city/shenzhen/856999118_7d376b5664_o_thumb.jpg	Huaqiang Rd	Shuichi Aizawa https://www.flickr.com/photos/shuichi/	69
40	images/city/shenzhen/2256174318_e9b6c8c596_o.jpg	images/city/shenzhen/2256174318_e9b6c8c596_o_thumb.jpg	Shenzhen Architecture	Connie https://www.flickr.com/photos/conbon/	69
41	images/city/shenzhen/4627001880_f249100bc6_o.jpg	images/city/shenzhen/4627001880_f249100bc6_o_thumb.jpg	Busy Road in Shenzhen	Tomislav Domes https://www.flickr.com/photos/tomislavdomes/	69
42	images/city/shenzhen/5686674214_216ea10918_o.jpg	images/city/shenzhen/5686674214_216ea10918_o_thumb.jpg	Busy Road in Shenzhen 2	Shinsuke Ikegame https://www.flickr.com/photos/tequilapartners/	69
43	images/city/shenzhen/5904040755_bf6cf6520b_b.jpg	images/city/shenzhen/5904040755_bf6cf6520b_b_thumb.jpg	Sunset in Shenzhen	Sergey Ivanov https://www.flickr.com/photos/mediumpanda/	69
44	images/city/shenzhen/29683571726_5fca5ae466_k.jpg	images/city/shenzhen/29683571726_5fca5ae466_k_thumb.jpg	Shenzhen Skyline	Alexander Farley https://www.flickr.com/photos/asfarley/	69
45	images/city/shenzhen/35798313502_f05dfae3b9_k.jpg	images/city/shenzhen/35798313502_f05dfae3b9_k_thumb.jpg	Busy Shenzhen	xiquinhosilva https://www.flickr.com/photos/xiquinho/	69
46	images/city/shenzhen/35836492551_94d82b50ee_k.jpg	images/city/shenzhen/35836492551_94d82b50ee_k_thumb.jpg	Shenzhen Background	xiquinhosilva https://www.flickr.com/photos/xiquinho/	69
47	images/city/shenzhen/35969229075_dba862e7fa_k.jpg	images/city/shenzhen/35969229075_dba862e7fa_k_thumb.jpg	Shenzhen Skyline	xiquinhosilva https://www.flickr.com/photos/xiquinho/	69
48	images/city/shenzhen/38037387415_a9b16e2b27_k.jpg	images/city/shenzhen/38037387415_a9b16e2b27_k_thumb.jpg	Shenzhen City View	Kentaro Iemoto https://www.flickr.com/photos/kentaroiemoto/	69
\.


--
-- Data for Name: maincontent_cityweather; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maincontent_cityweather (id, weathermonth, avghigh, avglow, rainmm, raindays, humidity, weathercity_id) FROM stdin;
1	1	7.0	2.1	74	10	74	64
2	1	15.7	2.6	23	4	57	13
3	2	17.1	4.3	31	7	53	13
4	3	20.0	7.2	37	9	51	13
5	4	22.8	10.2	27	10	55	13
6	5	24.6	18.7	84	11	64	13
7	6	25.2	16.6	145	17	76	13
8	7	24.7	16.8	193	20	82	13
9	8	24.7	14.6	210	20	82	13
10	9	23.5	14.6	160	18	83	13
11	10	21.5	12.1	102	13	77	13
12	11	18.5	7.0	30	6	70	13
13	12	16.0	3.2	12	3	66	13
14	2	10.0	6.9	59	9	73	64
15	3	13.8	6.9	94	12	73	64
16	4	19.5	11.9	74	11	72	64
17	5	24.8	17.3	84	10	72	64
18	6	27.8	21.7	182	13	79	64
19	7	32.2	25.8	146	11	77	64
20	8	31.5	25.8	214	12	78	64
21	9	27.9	22.4	87	9	75	64
22	10	22.9	16.8	56	7	72	64
23	11	17.3	10.6	52	8	72	64
24	12	11.0	5.0	44	8	71	64
25	1	1.8	-8.4	3	2	44	6
26	2	5.0	-5.6	5	2	44	6
27	3	11.6	0.4	8	3	46	6
28	4	20.3	7.9	21	4	46	6
29	5	26.0	13.6	34	6	53	6
30	6	39.2	18.8	78	10	61	6
31	7	30.9	22.0	185	14	75	6
32	8	29.7	20.8	160	12	77	6
33	9	25.8	14.8	45	8	68	6
34	10	19.1	7.9	22	5	61	6
35	11	10.1	0.0	7	4	57	6
36	12	3.7	-5.8	3	2	49	6
37	1	19.8	12.5	26	7	72	69
38	2	20.2	13.8	48	10	77	69
39	3	22.7	16.5	70	11	80	69
40	4	26.3	20.3	154	13	81	69
41	5	29.5	23.6	237	16	82	69
42	6	31.1	25.6	347	19	82	69
43	7	32.3	26.3	320	17	81	69
44	8	32.3	26.1	354	18	82	69
45	9	31.3	25.0	254	15	79	69
46	10	29.2	22.5	63	8	72	69
47	11	25.4	18.2	35	6	68	69
48	12	21.5	13.8	27	6	67	69
49	1	18.3	10.3	41	8	72	26
50	2	18.5	11.7	70	11	78	26
51	3	21.6	15.2	85	15	82	26
52	4	25.7	19.5	201	16	84	26
53	5	29.3	22.7	284	18	84	26
54	6	31.5	24.8	276	18	84	26
55	7	32.8	25.5	232	16	82	26
56	8	32.7	25.4	227	17	82	26
57	9	31.5	24.0	166	13	78	26
58	10	28.8	20.8	87	7	72	26
59	11	24.5	15.9	35	6	66	26
60	12	20.6	11.5	32	5	66	26
61	1	9.4	2.9	9	7	85	11
62	2	11.8	5.1	13	9	83	11
63	3	16.3	8.1	22	11	81	11
64	4	21.9	12.7	48	13	80	11
65	5	26.6	17.3	77	15	77	11
66	6	28.1	20.6	114	15	82	11
67	7	29.8	22.2	208	18	86	11
68	8	29.6	21.7	197	16	86	11
69	9	25.8	18.9	111	16	85	11
70	10	20.9	14.8	36	13	85	11
71	11	16.3	9.8	15	8	84	11
72	12	10.7	4.5	6	5	85	11
73	1	10.3	6.2	20	10	84	12
74	2	12.9	8.0	23	10	80	12
75	3	17.7	11.2	43	12	77	12
76	4	23.0	15.4	97	14	77	12
77	5	27.2	19.3	147	16	77	12
78	6	29.4	22.1	194	16	81	12
79	7	33.0	24.8	186	13	76	12
80	8	33.2	24.7	135	11	74	12
81	9	28.3	21.2	106	13	79	12
82	10	21.7	16.5	86	16	85	12
83	11	17.1	12.2	48	12	84	12
84	12	11.5	7.7	24	10	85	12
85	1	5.1	-3.3	7	3	65	84
86	2	8.9	-0.4	10	4	62	84
87	3	14.4	4.1	27	6	64	84
88	4	21.5	10.3	38	8	64	84
89	5	26.6	15.1	55	8	65	84
90	6	31.4	19.9	65	9	61	84
91	7	32.4	22.3	98	10	68	84
92	8	30.3	21.0	79	10	75	84
93	9	25.6	16.5	94	12	77	84
94	10	19.3	10.2	62	10	76	84
95	11	12.4	3.2	22	6	73	84
96	12	6.3	-2.2	7	4	68	84
97	1	11.6	5.7	66	15	73	27
98	2	13.3	7.6	99	16	75	27
99	3	16.9	10.8	137	19	79	27
100	4	23.2	16.1	218	20	80	27
101	5	27.5	20.2	325	19	79	27
102	6	30.5	23.5	395	18	81	27
103	7	32.7	24.9	232	16	79	27
104	8	33.0	24.7	147	15	77	27
105	9	30.6	22.2	82	8	72	27
106	10	25.9	17.7	67	10	68	27
107	11	20.5	12.5	73	9	67	27
108	12	15.1	7.4	47	9	66	27
109	1	-0.4	-6.8	9	3	56	14
110	2	1.4	-5.0	6	3	56	14
111	3	7.2	0.2	12	4	55	14
112	4	14.6	6.6	25	5	56	14
113	5	20.2	12.2	47	7	61	14
114	6	24.2	17.2	83	9	74	14
115	7	26.6	21.0	140	12	84	14
116	8	27.3	21.6	155	9	81	14
117	9	23.9	17.4	65	6	69	14
118	10	17.5	10.6	29	5	62	14
119	11	9.7	2.8	20	5	60	14
120	12	3.1	-3.5	11	3	58	14
121	1	-3.4	-16.6	2	2	50	16
122	2	0.6	-13.0	3	3	46	16
123	3	7.5	-6.0	9	5	44	16
124	4	16.5	1.5	18	4	38	16
125	5	23.3	8.3	30	7	40	16
126	6	27.2	13.4	49	10	49	16
127	7	28.2	16.3	101	14	65	16
128	8	26.4	14.8	83	12	68	16
129	9	21.7	8.5	51	9	61	16
130	10	15.0	1.6	18	5	53	16
131	11	5.8	-6.8	8	3	52	16
132	12	-1.5	-14.0	2	2	51	16
133	1	8.3	1.8	81	12	75	30
134	2	10.3	3.5	88	12	75	30
135	3	14.8	7.0	141	15	75	30
136	4	21.1	12.4	123	15	74	30
137	5	26.3	1.3	129	14	74	30
138	6	29.1	21.4	219	15	80	30
139	7	33.6	25.2	173	12	76	30
140	8	32.8	24.9	162	14	78	30
141	9	28.2	20.9	124	12	79	30
142	10	23.2	15.4	79	9	76	30
143	11	17.3	9.3	72	9	74	30
144	12	11.3	3.7	49	9	73	30
\.


--
-- Data for Name: maincontent_eat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maincontent_eat (id, eatname, eatshortdesc, eatfulldesc, eattime, eatcost, visible, eatcity_id) FROM stdin;
\.


--
-- Data for Name: maincontent_province; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maincontent_province (id, provname, provpopulation, provfulldesc, provtype, slug) FROM stdin;
1	Beijing	19612368	Here is everything great about this province	Municipality	beijing
2	Shanghai	23019148	Here is everything great about this province	Municipality	shanghai
3	Tianjin	12938224	Here is everything great about this province	Municipality	tianjin
4	Hebei	71854202	Here is everything great about this province	Province	hebei
5	Shanxi	35712111	Here is everything great about this province	Province	shanxi
6	Inner Mongolia	24706321	Here is everything great about this province	Autonomous Region	inner-mongolia
7	Liaoning	43746323	Here is everything great about this province	Province	liaoning
8	Jilin	27462297	Here is everything great about this province	Province	jilin
9	Heilongjiang	38312224	Here is everything great about this province	Province	heilongjiang
10	Jiangsu	78659903	Here is everything great about this province	Province	jiangsu
11	Zhejiang	54426891	Here is everything great about this province	Province	zhejiang
12	Anhui	59500510	Here is everything great about this province	Province	anhui
13	Fujian	36894216	Here is everything great about this province	Province	fujian
14	Jiangxi	44567475	Here is everything great about this province	Province	jiangxi
15	Shandong	95793065	Here is everything great about this province	Province	shandong
16	Henan	94023567	Here is everything great about this province	Province	henan
17	Hubei	57237740	Here is everything great about this province	Province	hubei
18	Hunan	65683722	Here is everything great about this province	Province	hunan
19	Guangdong	104303132	Here is everything great about this province	Province	guangdong
20	Guangxi	46026629	Here is everything great about this province	Autonomous Region	guangxi
21	Hainan	9171300	Here is everything great about this province	Province	hainan
22	Chongqing	28846170	Here is everything great about this province	Municipality	chongqing
23	Sichuan	80418200	Here is everything great about this province	Province	sichuan
24	Guizhou	34746468	Here is everything great about this province	Province	guizhou
25	Yunnan	45966239	Here is everything great about this province	Province	yunnan
26	Tibet	3002166	Here is everything great about this province	Autonomous Region	tibet
27	Shaanxi	37327378	Here is everything great about this province	Province	shaanxi
28	Gansu	25575254	Here is everything great about this province	Province	gansu
29	Qinghai	5626722	Here is everything great about this province	Province	qinghai
30	Ningxia	6301350	Here is everything great about this province	Autonomous Region	ningxia
31	Xinjiang	21813334	Here is everything great about this province	Autonomous Region	xinjiang
32	Taiwan	0	Here is everything great about this province	 	taiwan
33	Hong Kong	7061200	Here is everything great about this province	Special Administrative Region	hong-kong
34	Macau	552300	Here is everything great about this province	Special Administrative Region	macau
\.


--
-- Data for Name: maincontent_transport; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maincontent_transport (id, transporttype, transportdetails, transportcity_id) FROM stdin;
1	Metro	Shanghai has one of the world's most developed Metro systems, consisting of 15 different lines and still growing rapidly. Fares start at just 3 RMB, maxing out at 7 RMB if you're taking a much longer journey. You can buy single use tickets at every single station from the machine using coins, while some machines also accept notes. All machines have an option to switch to English. Alternatively you can buy a rechargeable metro card from the counter at each station. The deposit for the card itself is 20 RMB and be returned when you leave to get your money back. Be aware that during peak hours in the morning and evening the trains gets extremely crowded, so try to avoid travelling at peak times if you don't like crowds. Information on all signs and maps is in both English and Chinese, but don't expect that many of the staff will be able to speak English. 	64
2	Bus	Unfortunately, busses in Shanghai are not a particularly tourist-friendly mode of transport, as none of the timetables are in English. Recently though English has been added to the on-board announcements, so if you know where you are going you should be fine. The other confusing thing can be the pricing as it varies depending on the route, however most busses are a flat fee of 2 RMB. Deposit coins in the chute as you enter the bus (there's no ticket), or swipe your metrocard when boarding. 	64
3	Maglev Train	Shanghai is home to one of the fastest trains in the world, known as the Maglev. This magnetically levitating training will whisk you from Pudong International Airport to Longyang Rd in just 8 mins at 430km/h for 50 RMB. The only problem is the Longyang Road is basically in the middle of nowhere. It does however have 3 metro lines to change to (Line 2, Line 7 & Line 16), so there are some options when you get off. The train leaves every 15 minutes.	64
4	Taxi	Hailing a taxi is generally fairly easy during the day, but becomes very difficult during peak hours or in certain areas. Make sure you have your destination written down in Chinese, as driver's can't speak or read English. Credit cards are not accepted, so as a tourist your best option is cash. At the end of your journey the machine in the front will print out an invoice, and it's advisable to hang on to this. Generally speaking, there's no haggling on prices, and the price is calculated on distance plus a base cost. At night, the cost increases by approximately 25%.	64
5	Metro	The Beijing Metro (Beijing Subway) is a urban rail transit system for Beijing, China, and one of the 14 members of the international subway Alliance (CoMET). Its first line was officially opened in January 15, 1971, making Beijing the first city in China to open the subway.  As of December 2017, there were 22 subway lines in Beijing metro line. All of them used the subway system, covering 11 districts in Beijing, with a range of 608 kilometers, 370 stations, second mileage in China and second in the world.  As of December 2017, 17 lines of Beijing Metro were built, a total of 320.8 km. By 2020, the Beijing Metro will form a rail network consisting of 30 lines with a total length of 1177 km.  In 2016, the Beijing Metro had an annual passenger capacity of 3 billion 25 million passengers, with an average daily passenger flow of 8 million 247 thousand passengers, with a maximum daily passenger volume of 10 million 523 thousand and 600 passengers.  From December 23, 2017 onwards, the whole rail network of Beijing rail network purchased tickets online and picked up stations.  Since April 29, 2018, the Beijing rail transit network (excluding the western suburb line) has been able to carry out the two-dimensional code.	6
6	Metro	The Guangzhou subway (Guangzhou Metro) is the third largest city of China, the urban rail transit system in Guangzhou, and one of the 14 members of the international subway Alliance (CoMET). The first line was opened in June 28, 1997, and Guangzhou has also become the fourth city in mainland China to open and operate the subway.  As of April 26, 2018, there were 13 lines in Guangzhou metro, with a total length of 391.6 kilometers, a total of 205 stations, third mileage in China, and five of the world's top five. The daily passenger flow is expected to reach 8 million 200 thousand, and the largest passenger flow in the day is 10 million 25 thousand and 700, of which the passenger flow of the one or two, three and five is over 1 million 200 thousand. In addition, line three (including North Extension) 2 million 440 thousand, four line 508 thousand, six line 1 million 53 thousand, Guangfo line 400 thousand, the above line passenger flow is the highest level in history. The reliability of operation service ranks first, the incidence of station crime is lowest for three consecutive years, and the utilization rate of vehicles and punctuality rate are third.  The Guangzhou Metro is responsible for the operation and management of the Guangzhou metro, and it is also the actual construction and operator of the Guangfo metro, so the service range of the Guangzhou Metro is also extended to Foshan.	26
8	Metro	The Hongkong subway (Mass Transit Railway, MTR) refers to the urban rail transit system serving in Hongkong, China, and one of the 14 members of the international subway Alliance (CoMET). The first line opened in October 1, 1979 and was the third city in China (including Hong Kong, Macao and Taiwan).  By the end of 2017, the opening mileage was the top ten in China, the top twenty of the world, the total length of the Hongkong Metro 264 kilometers. It was composed of Kwun Tong line, Tsuen Wan line, Hong Kong Island line, Nangang island line, Tung Chung Line, Tseung Kwan O line, East railway line, west iron line, Ma'anshan line, Disney line, airport express line, and a total of 154 stations.  In December 16, 2017, the Hongkong subway can use Alipay and WeChat ticket.	34
9	Metro	The Nanjing subway (Nanjing Metro) is a city rail transit for Nanjing and Nanjing metropolitan areas. Its predecessor can be traced back to the Beijing City railway built in 1907 (thirty-three years of Qing Guangxu). Its first line was officially opened in May 15, 2005, making Nanjing the sixth city of China's big land to open the subway. The only profitable urban rail transit in mainland China.  As of December 2017, the Nanjing Metro has opened 9 lines, including line 1, line 2, line 3, line 4, line 10, line S1, line S3, line S8, line S9, 164 stations with a total length of 347 km, and a total line of fourth (second only to Shanghai, Beijing, Guangzhou), and seventh in the world. It forms a subway network covering 11 municipal districts of Nanjing. Nanjing has become the first city in China to open all subway lines.  As of March 2018, the average daily passenger volume of Nanjing Metro was 3 million 100 thousand, with the highest daily passenger volume of 3 million 741 thousand passengers, ranking fifth in China. In 2017, the average daily passenger flow of Nanjing Metro was 2 million 677 thousand, an increase of 409 thousand passengers over 2016, with a growth rate of 18.01%. The total passenger flow was 977 million, an increase of 147 million passengers over 2016.  As of December 2017, the Metro Line 1 is being built in the north, line 5, line 7 and line No. S7; the Metro Line 2, three, 4, two, 6, 9, 10, two, 11, line one, line one, line S6, line S8 and line S8 are in the preparatory stage, which will be from 2018 to 2020. Construction has been started in succession. By 2030, 25 subway lines will be built in Nanjing metro, with a total length of 1011.2 km.	55
10	Metro	The Shenzhen subway (Shenzhen Metro) refers to the urban rail transit service in Shenzhen, Guangdong, China. Its first line was officially opened in December 28, 2004, making Shenzhen the fifth city in the mainland of China with the subway system.  According to the information of the Shenzhen subway official network in June 30, 2017, the Shenzhen subway has opened 8 lines, which are line 1, 2 line, 3 line, 4 line, 5 line, 7 line, 9 line, 11 line, and a total of 199 stations. The total length of the city's metro operation line is 285 kilometers, and the total mileage of the subway is fifth in China, which constitutes the urban rail network covering six municipalities in Luohu District, Futian District, Nanshan District, Baoan District, Longhua area and Longgang District of Shenzhen.  According to the information of the Shenzhen Metro official network in September 2017, there are 13 lines in the construction of Shenzhen metro, including the three (eastern section), the three (south section), the 3 line, the 3 line, the three phase (the east section), the three (North Section) 4, the 5 line two (South), the 6 line, the 8 line one phase (running through the line with the 2 line), and the number line period. (western section), line 9 branch line (running through line 12), line 10, line 11, line 12 and line 20, a total of 189.4 kilometers. By 2020, the Shenzhen Metro will form 16 rail transit networks with a total length of 596.9 km.  In 2016, the Shenzhen Metro had an annual passenger capacity of 1 billion 93 million 100 thousand passengers and an average daily passenger volume of more than 2 million 986 thousand and 600 passengers. In 2015, it had an annual passenger capacity of 930 million 660 thousand passengers and an average daily passenger volume of more than 2 million 549 thousand and 700 passengers. In 2014, it had an annual passenger capacity of 866 million 990 thousand passengers and an average daily passenger volume of more than 2 million 375 thousand and 300 passengers.	69
11	Metro	Wuhan rail transit (Wuhan Metro) is a city rail transit service for Wuhan, Hubei, China. Its first line, Wuhan Rail Transit Line 1, opened and operated in July 28, 2004, making Wuhan the first city in Central China to open rail transit.  As of December 2017, there were 7 lines of rail transit in Wuhan, including line 1, line 2, line 3, No. 4, line 6, line 8, and Yangluo line, with a total of 167 stations with a total length of 237 kilometers, and seventh lines in mainland China.  As of December 2017, there were 16 lines of rail transit in Wuhan, including the south line of line 2, Caidian line, line 5, No. 7 line one, paper workshop line, 8 line two, three of line 8, east section of 11 line, 11 line two, 12 line and front Sichuan line, which were kilometre in construction mileage. By 2020, Wuhan rail transit will form 11 lines, a total of 401 kilometers of rail transit network, basically form the "network of the main city, the new town line" of the rail traffic network system.  As of April 2018, the average daily passenger volume of Wuhan rail transit was 2 million 700 thousand times, the maximum daily passenger volume reached 3 million 514 thousand and 200 times, which was sixth in the country. The passenger flow intensity was 1.5-1.8 ten thousand people per kilometer, accounting for 38% of the bus passenger traffic volume in the city. In 2015, Wuhan rail transit co operated 570 million passengers and 1 million 556 thousand passengers per day, carrying 23.5% of the city's public transport capacity.	80
12	Metro	Chengdu Metro (Chengdu Metro) refers to urban rail transit serving Chengdu and its surrounding areas. Its first line, Chengdu Metro Line 1, was officially opened in September 27, 2010. It is the first subway line in the Midwest, and Chengdu has also made Chengdu a city with tenth rail transit (Metro) in mainland China.  The Chengdu Metro sent passengers 561 million times in 2016, and the average daily passenger flow reached 1 million 532 thousand and 100 times. The punctuality rate of trains was 99.99%, and the share of public transport reached about 35%. In November 2016, the Chengdu plan included 46 lines and more than 2450.04 kilometers of rail transit network, covering all parts of the city, and radiating the surrounding counties and cities.  The single day passenger flow of Chengdu Metro is 3 million 810 thousand and 600 times (April 4, 2018). It is the fifth city rail transit of more than 3 million 500 thousand per day after Beijing, Shanghai, Guangzhou and Shenzhen. As of May 2, 2018, the Chengdu Metro opened a total of 6 lines (1, 2, 3, 4, 7, 10). The total length of the line was about 196 km, and a total of 136 stations were put into operation (the transfer station did not repeat the calculation). At present, the number of Chengdu metro lines has reached 10 lines, 14 projects and 351 kilometers in mileage. It is expected to be all opened before the end of 2020, reaching a subway line with a mileage of 515.72 kilometers.  At the end of 2018, another line is expected to be opened: the two or three phase of Chengdu Metro Line 3. At the same time, Chengdu will advance the preparatory work of the three projects of line three, line 13, No. 13, two, three, two, two, and 33, in advance of the fourth phase of construction planning.	11
13	Metro	Chongqing Rail Transit (CRT) refers to the urban rail transit service in Chongqing metropolitan area of Chongqing. Its first line opened its sightseeing operation in November 6, 2004 and opened its operation formally in June 18, 2005. It is the first urban rail transit line in Western China.  As of December 2017, there were 6 rail transit lines in Chongqing, including 1, 2, 3, 5, 6 and 10 lines (including the national Expo line and the airport line). The line network covered the whole area of the main city of Chongqing. There were 154 stations and 13 transfer stations, with operation mileage of 264.3 km, the length of mileage in Central China sixth, the first Midwest. Among them, the 1, 5, 6 and 10 lines are the subway system, a total of 149 km; the 2 and 3 lines are monorail systems (straddle type monorail), with a total of 115 km.  As of December 2017, there were 8 lines in the construction of Chongqing rail transit, including the first, the No. 5, the No. 6, the No. 6 line, the two, the 9, the two, the loop and the extension (the 1 line tip and the 5 line) and the construction mileage of 201.9 km. By 2020, the estimated operating mileage was nearly 5. 00 kilometres; a total of 18 lines.  In 2016, the average daily passenger traffic volume of Chongqing rail transit was 1 million 899 thousand and 700 times, and the highest daily passenger volume was 2 million 618 thousand and 200 times. In 2015, its annual passenger volume was 630 million times, and the average daily passenger volume was 180 times.  Chongqing Rail Transit Line 2 is the first single Straddle Monorail in China. It is also the first urban rail transit line in the western region of China. Its train is famous throughout the country because of its train in Li Zi dam station.	12
14	Metro	Tianjin Rail Transit refers to the urban rail transit service in Tianjin, Tianjin, including Tianjin metro system and light rail system. Its first line was officially opened in December 28, 1984, making Tianjin the second Metro City in mainland China.  As of December 2016, Tianjin rail transit line has 5 lines, including subway 1, 2, 3, 6 and line 9 (Tianjin Binhai light rail), the line network covers 10 municipal districts, the operation mileage is 166 km, and a total of 112 stations are set up.  As of December 2016, there were 7 lines in Tianjin rail transit, including the East extension line of line 1, the first line of line 4, line 5, the first southern section of the No. 6 line, the first phase of the No. 10 line, the B1 line and the Z4 line, with a total of 180 kilometres. [3-4] by 2020, Tianjin rail transit will form 14 operation lines, a total length of 513 kilometers of rail transit network.  In 2016, the annual passenger volume of Tianjin rail transit was 277 million times, the daily average passenger volume exceeded 700 thousand times, and the maximum daily passenger volume was 1 million 180 thousand times. In 2015, its annual passenger volume was 256 million times, and the average daily passenger volume exceeded 700 thousand times. = =  Since August 16, 2017, the reconstruction of Yingkou Road station has been completed, and the access channels at various entrances and exits and stations have been restored to normal use. Train No. 3 has resumed normal stops.	75
15	Metro	The Dalian Metro is part of the Dalian rail transit system in Liaoning, including the Dalian subway and the Dalian express rail. The operation of 4 lines has been opened.  The idea of the Dalian subway began in 1980s. In 1987, Dalian first proposed the construction of the subway, but it has not been approved. In 2002, Dalian rail transit line 3 opened to trial operation. In 2005, Dalian again proposed the construction of the subway and passed the examination and approval in July 2009. The first phase of Dalian Metro Line 2 began construction in 2010 and opened to traffic in May 22, 2015.  The first phase of the Dalian subway project covers the East harbour square, South to convention and Exhibition Center, West to Hongqi West Road, and north to South Guan Ling. Xi'an road is the transfer station of two subway lines. Nan Guan Ling Railway Station can transfer subway lines and high-speed rail passengers. In addition to the Yao family station as a semi underground station, all other stations are underground stations. The passenger volume of the subway is up to 995 thousand passengers on the day after the subway is built. The Dalian Metro is part of the Dalian rail transit system in Liaoning, including the Dalian subway and the Dalian express rail. The operation of 4 lines has been opened.  The idea of the Dalian subway began in 1980s. In 1987, Dalian first proposed the construction of the subway, but it has not been approved. In 2002, Dalian rail transit line 3 opened to trial operation. In 2005, Dalian again proposed the construction of the subway and passed the examination and approval in July 2009. The first phase of Dalian Metro Line 2 began construction in 2010 and opened to traffic in May 22, 2015.  The first phase of the Dalian subway project covers the East harbour square, South to convention and Exhibition Center, West to Hongqi West Road, and north to South Guan Ling. Xi'an road is the transfer station of two subway lines. Nan Guan Ling Railway Station can transfer subway lines and high-speed rail passengers. In addition to the Yao family station as a semi underground station, all other stations are underground stations. The passenger volume of the subway is up to 995 thousand passengers on the day after the subway is built.	14
16	Metro	Kunming Kunming Rail Transit is an urban rail transit system serving Kunming and Kunming. The system includes the Kunming subway system built and operated by Kunming Rail Transit Co., Ltd., and the urban railway system built by Kunming Railway Co., Ltd.  In June 28, 2012, the first phase of Kunming rail transit line 6 (airport line) was formally opened to traffic. In May 20, 2013, the southern section of the first phase of the Kunming Rail Transit Line 1 was opened for trial operation. In April 30, 2014, the first line of Kunming Rail Transit Line 1 and the first line of line 2 of Kunming rail transit were through. In August 29, 2017, the first phase of Kunming rail transit line 3 and the first phase of line 6 were opened for trial operation. There are 4 lines of operation. [1]  According to the statistics of the China Urban Rail Transit Association, as of August 29, 2017, the Kunming metro operation mileage ranked fifteenth in the 31 cities operating in the country, with a total distance of 88.76 km [2]. The distance network of Kunming urban rail transit has a total length of 562 km, consisting of 14 lines consisting of a radiation common line network and a fast track network.	45
17	Metro	The Hangzhou subway (Hangzhou Metro) refers to the urban rail transit serving in Hangzhou and Hangzhou metropolitan areas. Its first line, Hangzhou Metro Line 1, is officially opened in November 24, 2012, making Hangzhou the fourth city in East China and the first subway in Zhejiang province. The Hangzhou subway line 1 is also the first in Zhejiang. The subway line.  As of January 2018, there were 3 subway lines in Hangzhou, including Hangzhou Metro Line 1, Hangzhou Metro Line 2, and Hangzhou Metro Line 4, with a total of 84 stations and a total of 117.6 kilometers in operation mileage.  As of January 2018, the total mileage of Hangzhou's urban rail transit network was 423.5 km, of which the total mileage of the three phase of the MTR was 387.8 km. Hangzhou Metro has built the subway line 1, line 2 and line 4 and realized network operation. The current mileage is 117.6 kilometers, and the daily average passenger flow of line network has exceeded 1 million 200 thousand people. The construction lines include the three Hangzhou Metro Line 1, the first line of the Hangzhou subway line 5, the first phase of the Hangzhou Metro Line 6, the two phase of the Hangzhou Metro Line 6, the Hangzhou Metro Line 7, the Hangzhou subway 8 line one and the intercity rail transit (Hangzhou to Ling'an Intercity Railway, Hangzhou to Fuyang intercity railway, Hangzhou to Shaoxing intercity railway, Hangzhou to The total mileage of the Haining intercity railway is about 221.9 km. Before the Asian Games in 2022, Hangzhou will form 15 rail transit lines (including Hangzhou Metro Line 1 to line 10, Hangzhou, Hangzhou, Hangzhou, Hangzhou, Hangzhou, Hangzhou, 4 intercity railway lines, 1 Hangzhou airport rail express), and 504 kilometers of rail transit network.  In 2017, the number of subway passengers increased by 340 million, an increase of 26.5%. In 2016, the Hangzhou metro passenger volume reached 269 million passengers, an increase of 20.3% over the previous year. In 2015, its passenger traffic volume reached 223 million passengers, an increase of 53.9% over the previous year. In 2014, its passenger traffic volume reached 145 million passengers, an increase of 57.1% over the previous year.	30
18	Metro	The Qingdao Metro (Qingdao Metro) is a city rail transit service for Qingdao, Shandong, China. Its first line, the line 3 of the Qingdao metro, was opened in December 16, 2015.  As of April 2018, there were 3 lines in the Qingdao metro operation line, that is, the Qingdao Metro Line 3 has a total of 22 stations and a total length of 25.2 km; the east section of Qingdao Metro Line 2, a total of 18 stations, the total length of 20.4 kilometers, and the Qingdao subway 11, a total of 22 stations and 58.4 km.  As of April 2018, there were 6 lines in Qingdao metro, which were line 1, line 2, line one, line 4, No. 7, line one, line 8, line 13, and two. Among them, line 13 is planned to be opened at the end of 2018. It is estimated that by 2021, there will be 8 metro lines with a total length of 332 km.  In 2017, the Qingdao Metro sent 65 million 730 thousand passengers. As of April 2018, the highest daily passenger traffic in Qingdao Metro appeared in April 30, 2018, reaching 674 thousand and 600 passengers.	60
19	Metro	Suzhou Rail Transit (Rail) refers to the urban rail transit service in Suzhou. Its first line, Suzhou Rail Transit Line 1, is separated from trial operation at 11:18 on April 28, 2012. It marks Suzhou becoming the first city in China to build and transport rail transportation.  As of March 2018, there were 3 rail transit lines in Suzhou. They are: Line 1, line 2, line 4 and branch line. The number of stations is 97, of which 5 are bus stops, with a mileage of 121 km.  As of March 2018, there were 2 railway lines under construction in Suzhou. They are line 3 and line 5. 71 stations are built, and the construction mileage is 89.372 kilometers.  As of March 2018, there were 4 rail transit planning lines in Suzhou. They are line 6, line 7, line 8 and S1 line. 108 stations are planned and the planned mileage is 139.85 kilometers.  By 2040, there were 15 rail transit planning routes in Suzhou (9 urban districts and 6 municipal districts), with a total mileage of about 768 km (391.4 km in the urban area and 377 km in the urban area).  In 2017, the total mileage of Suzhou rail transit was 14 million 37 thousand kilometers, and the total passenger volume of the line network was 248 million 426 thousand.	71
20	Metro	The Xi'an subway (Xi'an Metro) refers to the urban rail transit service in Xi'an, Shaanxi, China. Its first line opened in September 16, 2011, making Xi'an the first city to open the subway in the northwest of China.  According to the information of the Xi'an subway official network in October 2017, there are 3 lines in its operation line, which are line 1, 2 and 3. The subway system is used and the length of mileage is 91.35 kilometers. There are 66 stations in the station, of which 3 stations are transferred to the station.  According to the information of the Xi'an subway official network in October 2017, there are 6 lines in the construction line, which are line 1, line two, line 4, No. 5 line one, 6 line one, two of line 6, and one phase of Lintong line (9 line), and 180 km in construction mileage; a total of 18 lines are planned for the long term.  In 2016, the total passenger volume of Xi'an metro line reached 408 million 157 thousand and 500 passengers, with an average daily passenger volume of 1 million 115 thousand and 200 passengers, an increase of 19.32% over the previous year. As of October 2017, the highest daily passenger flow of Xi'an Metro appeared in September 30, 2017, reaching 2 million 233 thousand and 300 passengers.	84
27	Metro	Ningbo Ningbo Rail Transit is an urban rail transit service for Ningbo, Zhejiang, China. Its first line was opened for trial operation in May 30, 2014, making Ningbo the twenty-first city in mainland China to open rail transit lines.  As of October 2017, there were 2 lines in Ningbo rail transit line, which were line 1 and line 2, all of which were subway system, and the length of mileage was 74.5 kilometers, and a total of 51 stations were set up.  As of October 2017, there were 4 lines in Ningbo rail transit, including line 3, line 4, 2 line two and line one, with a total length of about 90 kilometers.  As of December 21st 2017, 209 thousand and 600 trains have been opened in Ningbo rail transit, with a precision rate of 99.99%, 102 million passengers and 305 thousand and 400 passengers per day.	57
21	Metro	Zhengzhou rail transit (ZhengZhou Metro) refers to the urban rail transit service in Zhengzhou, Henan, China. Its first line opened the trial operation in December 28, 2013, making Zhengzhou the eighteenth city in China to open the subway.  According to the information of Zhengzhou rail transit official network in October 2017, there are 3 lines in its operation line, which are line 1, line 2 and suburban line. The subway system is used and the length of mileage is 95.4 kilometers. There are 61 stations in the station, of which 2 are the Zijing mountain station and the South Fourth Ring station.  According to the information of Zhengzhou rail transit official network in November 2017, there are 7 lines in the construction line, which are line 2, line two, No. 3 line one, two phase of line 3, No. 5, 10 line, 11 line and suburb line two. The construction mileage is 182.748 kilometers, and the long term planning altogether 21 lines.  In 2016, the annual passenger traffic volume of Zhengzhou rail transit was 144 million 622 thousand and 700, with an average daily passenger volume of more than 396 thousand and 200. In 2015, its annual passenger traffic volume was 88 million 101 thousand and 500 passengers, with an average daily passenger volume of more than 241 thousand and 400 passengers. In 2014, its annual passenger traffic volume was 67 million 853 thousand and 500 passengers, with an average daily passenger volume of more than 185 thousand and 900 passengers. At present, the maximum daily traffic volume of Zhengzhou metro line is 1 million 92 thousand and 800 passengers (December 31, 2017).	101
22	Metro	Changsha rail transit (Changsha Metro) is an urban rail transit service for Changsha, Hunan, China, including subway system, maglev system and so on. Its first line was opened in April 29, 2014, and its orange Chau Station was the first to set up a subway station on Jiangzhong island for the first time in China. Its maglev express line is the first medium and low speed maglev line with completely independent intellectual property rights opened by China.  As of August 2017, Changsha rail transit line 3 lines: Changsha Metro Line 1, Changsha Metro Line 2, Changsha maglev express line, line network covering the Changsha main city area and Changsha County, a total of 46 stations, transfer stations 1, operation mileage of 68.8 kilometers.  As of August 2017, the total number of rail transit lines under construction in Changsha was 4 (section): Line 3, phase 1, line 4, phase 5, line 1 and line 6. According to the overall urban planning and comprehensive transportation planning of Changsha City, Changsha urban rail transit network (Metro) consists of 12 lines, with a total length of about 456 kilometers and 333 stations, including 45 transfer stations, and a density of 0.6 km / sq km in the central urban area.  In April 28, 2015, Changsha Metro Line 2 opened for 1 years, sending a total of 69 million 477 thousand passengers. In 2016, the annual passenger traffic volume of Changsha rail transit exceeded 160 million passengers, and the average daily passenger volume was 438 thousand and 300 times. In April 29, 2017, the passenger flow of Changsha rail transit single day line reached 957 thousand and 400, and the single day maximum passenger flow record of line 1 and 2 reached 329 thousand and 100 and 628 thousand and 300.	8
23	Metro	The Harbin subway (Harbin Metro) refers to the urban rail transit service in Harbin, Heilongjiang, China. Its first line opened in September 26, 2013, making Harbin the first city in China to build a high cold subway system.  According to the information of the Harbin subway official network in November 2017, there are 2 lines in its operation line, which are line 1 and line 3. The subway system is used and the length of mileage is 23.073 kilometers. A total of 21 stations are set up, of which 1 seats for the bus station are the second hospital station of the Medical University.  According to the information of the Harbin subway official network in November 2017, there are 3 lines in the construction line, which are the three phase of line 1, the first phase of line 2 and the two phase of line 3, with the construction mileage of 69.319 kilometers, and the forward planning for a total of 10 lines.  In the second half of 2014, the Harbin Metro has a total annual passenger volume of about 5049.28225 passengers, with an average daily passenger volume of more than 138 thousand and 300 passengers. In 2015, its annual passenger traffic volume was 57 million 889 thousand passengers, with an average daily passenger volume of more than 158 thousand and 600 passengers. In 2016, its annual passenger traffic volume was 79 million 862 thousand passengers, with an average daily passenger volume of more than 218 thousand and 800 passengers.	31
24	Metro	Hefei Rail Transit is an urban rail transit service to Hefei, Anhui, Hefei. Its first line was officially opened and operated in December 26, 2016, making Hefei the first city in Anhui province and the seventh subway in the Yangtze River Delta.  As of December 2017, Hefei rail transit line has 2 lines: Hefei Rail Transit Line 1, Hefei Rail Transit Line 2, line network covering Hefei Yaohai District, Baohe District, Shushan District, Luyang District, the total length of 52.38 km and the total line of 47 sites.  The soil quality of Hefei is single, which is called "old clay" by construction workers. It is very viscous, but once it is excavated, it is very easy to shape and not to collapse easily. This soil determines that Hefei is one of the most suitable cities for subway construction in China.  As of December 2017, there were 4 sections of the Hefei rail transit line, including line 3, line 1, three, 4 and 5. By 2021, 5 subway lines will be built in Hefei, with a line of about 175.56 kilometers.  As of December 2017, the number of passengers in Hefei Rail Transit Line 1 was 39 million 280 thousand passengers, and the daily passenger flow was 111 thousand and 600 people. The highest daily passenger volume appeared in January 1, 2017, reaching 233 thousand and 539 people. The actual opening trains were 24874 times and the train alignment rate was 99.79%.	32
25	Metro	Nanchang Metro (Nanchang Metro) is the urban rail transit in Nanchang City, Jiangxi province. In December 26, 2015, it opened a passenger trial operation. Nanchang is the twenty-fifth city in the Chinese mainland to put the subway into operation.	54
26	Metro	Nanning Nanning Rail Transit is an urban rail transit service to Nanning, the Guangxi Zhuang Autonomous Region, China. Its first line was opened for trial operation in June 28, 2016, making the Guangxi Zhuang Autonomous Region the first Chinese autonomous region to open the subway.  As of December 2017, there were 2 rail transit operation lines in Nanning (including trial operation), namely, Nanning Rail Transit Line 1 and Nanning Rail Transit Line 2. The length of the mileage is 53.1 kilometers, and a total of 43 stations are set up. As of December 2017, there were 4 lines in Nanning rail transit, including line 2, line 3, line 4, and line 5, with a total length of about 97.5 kilometers.	56
28	Metro	The Shenyang subway (Shenyang Metro) refers to the urban rail transit service in Shenyang, Liaoning, China. The first subway line was opened in September 27, 2010.  According to the information of official website in October 2017, there are 2 lines in Shenyang metro operation line, which are line 1 and line 2, all of which are subway system, mileage length is 59.68 kilometers, and a total of 48 stations are set up.  According to the information of the official website in October 2017, there are 3 lines in Shenyang metro line, line 4, line 9 and line 10, with more than 90 kilometers and 80 stations in the construction mileage.  In 2016, the Shenyang Metro has a mileage of 5 million 959 thousand kilometres and a passenger capacity of 299 million 179 thousand times. In 2015, Shenyang Metro Line 1 and line 2 reached mileage of 5 million 534 thousand kilometers, passenger volume 277 million 720 thousand times, and daily average passenger flow 760 thousand and 900 times.	68
29	Metro	The Wuxi Metro (Wuxi Metro) is a city rail transit service for Wuxi, Jiangsu, China. Its first line was officially opened in July 1, 2014, making Wuxi the fourth non provincial capital city independent of the subway since Shenzhen, Suzhou and Ningbo.  According to the information of the Wuxi subway official network in October 2017, there are 2 subway lines in Wuxi, which are line 1 of Wuxi subway and line 2 of Wuxi subway, which are all used in the subway system, covering the 7 districts of the Lake District, Nanchang District, the Chong an District, Xishan District, the new area, Huishan district and Beitang District, with the operation mileage of 56.22 kilometers. The station is 45.  According to the information of the Wuxi subway official network in October 2017, there are 3 sections of the Wuxi Metro Line in construction, including the construction of the first phase of line 3, the first phase of line 4, and the South extension line of line 1, with a total of more than 56.29 kilometers. By 2020, the Wuxi Metro will form 4 rail transit networks with a total length of 112.6 km.  In 2016, the Wuxi Metro had an annual passenger capacity of 81 million 468 thousand passengers and an average daily passenger volume of more than 223 thousand and 200 passengers. In 2015, it had an annual passenger capacity of 71 million passengers and an average daily passenger volume of more than 195 thousand passengers. In the second half of 2014, its annual passenger traffic volume was 17 million 702 thousand and 500 passengers, with an average daily passenger volume of more than 97 thousand passengers.	81
30	Metro	Dongguan Rail Transit refers to the urban rail transit service in Dongguan, Dongguan, including Dongguan metro system and monorail system. Its first line was officially opened in May 27, 2016, making Dongguan the twenty-seventh Metro City in mainland China.  According to the information of Dongguan rail transit official network in August 2017, there are 1 lines in Dongguan rail transit line, that is, line 2 of Dongguan rail transit, which covers 7 municipal districts, and the operation mileage is 37.8 kilometers. A total of 15 stations are set up and the subway system is adopted.  According to the information of Dongguan rail transit official network in August 2017, there are 3 sections of Dongguan rail transit in the construction line, including the first phase of line 1, the three phase of line 2 and the first phase of line 3, with a full length of 126.9 kilometers. By 2020, Dongguan rail transit will form 6 lines of operation, the total length of urban rail transit line is 307.8 kilometers, and a total of 84 stations will be set up, of which 8 stations in urban rail transit hub stations pass through 32 towns.  In the second half of 2016, the volume of passenger traffic of Dongguan rail transit in the second half of the year was 21 million, with an average daily passenger volume of more than 115 thousand and 400 passengers, with a maximum daily passenger volume of 253 thousand and 200.	18
31	Metro	The Foshan Metro (Foshan Metro) refers to the urban rail transit service in Foshan, Guangdong, China. The first line of Foshan Metro Line 1 (Guangfo line) is officially opened in November 3, 2010. It is the first subway line in the mainland of China.  According to the information of the official website of Foshan Metro in August 2017, there are 1 operation lines of the Foshan subway, that is, Foshan Metro Line 1 (Guangfo line). The line west of Foshan new City East, east to Guangzhou City Yan Gang, the total length of 32.16 kilometers, the whole line of 22 stations. Among them, 21.47 kilometers in Foshan, 15 stations, 11.67 kilometers in Guangzhou, 7 stations.  According to the information of the official website of the Foshan Metro in December 2016, there are 2 sections of the Foshan subway line, including line 2 and line 3, with a total of more than 120 kilometers, and 47 stations are set up. In the future, the Foshan Metro will form 14 rail transit networks with a total length of 572 kilometers.  In 2015, the average daily passenger volume of Foshan Metro was 15.98 people, with the maximum passenger volume of 274 thousand passengers on one day and 5 million 832 thousand and 800 passengers per year. In 2016, the daily average passenger volume of Foshan subway was 258 thousand people, the maximum passenger volume on one day reached 368 thousand, and the annual passenger volume was 94 million 170 thousand.	23
32	Metro	Fuzhou Metro (FUZHOU METRO) is an urban rail transit system serving Fuzhou, Fujian. The twenty-fourth Metro City in mainland China is also the first Metro City in Fujian province.  In January 6, 2017, the Fuzhou Metro Line 1 (phase 1) opened to trial operation, and Fuzhou entered the era of Metro. Line 1, phase two, line 2, line 4, phase 1, line 5, line 6 and Binhai express line are all under construction.	24
33	Metro	The Guiyang Urban Rail Transit, also known as the Guiyang metro, is an urban rail transit system serving Guiyang city of Guizhou province and GUI an New District of Guiyang. Guiyang Metro Line 1 (Guan Shan Lake section) was opened for trial operation in December 28, 2017.  Guiyang rail transit planning consists of 9 lines, with a total length of 467 km and a total investment of 270 billion yuan. According to the definition of rail transit, the urban rail transit system of Guiyang includes subway, ring expressway and GUI Kai inter city passenger dedicated line. What is being built is Guiyang Metro Line 2 (phase 1 and 2) and Guiyang Metro Line S1 (phase 1).	28
34	Metro	Lanzhou LANZHOU RAIL TRANSIT is an urban rail transit system serving Lanzhou, Gansu. It is the first city in Gansu to build a subway.  The first phase of Lanzhou Metro Line 1 was officially launched on 03 2014, with a total construction period of 4 and a half years. At the two staff congress and the 2016 work meeting of the Lanzhou Orbital Corporation, the municipal Party committee and the municipal government put forward a clear requirement. That is, the first phase of the No. 1 project must be rail through the end of 2016 and the comprehensive adjustment is realized. It is planned to be officially opened in 2018.	46
35	Metro	The Urumqi Metro (URUMQI METRO) is a urban rail transit system for Urumqi, which is spoken in three languages in Mandarin, Uygur, and English. Urumqi has become the thirty-second Metro City in mainland China, and the first city in the Xinjiang Uygur Autonomous Region to build a subway.  The Urumqi rail transit network consists of 10 lines, of which 8 lines are planned for the main urban area, with a total of 261.8 kilometers, and 2 city lines (Wuchang line and Nanshan line), with a total of 78.4 kilometers. Metro Line 1, line 2, line 3 and line 4 have been constructed. The preparatory work for construction has been carried out in Wunan maglev project and Wuchang line, rail line 5 and line 6.  The first line subway line 1 (North Section) 16.5km is expected to operate at the end of June 2018. By then, the backbone line operation time is scheduled to be 7:00 every morning (Beijing time) to 1:00 a.m. the next morning (Beijing time).	78
36	Metro	The Xiamen subway (Xiamen Across Mass Transit Railway) is a urban rail transit system for Xiamen, Fujian, China. It is spoken in three languages, in Mandarin, Minnan, and English. Its first line opened for trial operation in [1] in December 31, 2017. Xiamen has become the thirty-first Metro City in mainland China. [2]  The planning of Xiamen urban rail transit network in 2020 is composed of 6 lines, with a total length of about 267 kilometers, with 139 stations and 18 transfer stations.	83
37	Bus	From December 28, 2014 onwards, the new price of public transport: 10 km (inclusive) of 2 yuan, 10 km or more, plus 1 yuan can take 5 km. In 2014, there were 877 lines of electric vehicles in Beijing, 64 more than the end of the year; the length of the operation line was 20347 kilometers, up 659 kilometers from the end of the year; 24083 operating vehicles, up 491 vehicles at the end of the year, and 4 billion 700 million passengers per year, down by 3% over the previous year.	6
38	Taxi	In 2013, the average daily transport capacity of taxi in Beijing was 1 million 900 thousand, accounting for 6.6% of the total travel volume and the mileage utilization rate of about 68%. Since June 10, 2013, the Beijing taxi price standard has been adjusted. The new taxi price is 13 yuan within 3 kilometers, and the basic unit price is 2.3 yuan per kilometer. The fuel surcharge is 1 yuan per operation. Low speed and waiting fee charge 2 kilometre rent (excluding empty driving fee) every 5 minutes, morning and evening peak periods, and additional 1 kilometre rent (excluding empty driving fee) at other periods. The appointment service fee is 6 yuan in advance of 4 hours, and 5 yuan within 4 hours. One way passenger traffic is more than 15 km, part of which is charged by air travel fee, basic unit price plus 50%.	6
39	Taxi	test	69
40	Bus	Shenzhen bus is the name of bus service between Shenzhen city and Shenzhen City, and it is one of the main public transportation tools in Shenzhen. The first line was opened in 1975. As of September 2017, there were 1019 bus lines in Shenzhen, which were operated by the Eastern Bus (Eastern Bus), the Western Bus (Western Bus) and the Shenzhen bus group (Shenzhen Bus Group).	69
41	Taxi	test	26
42	Bus	test	26
43	Taxi	test	84
44	Bus	test	84
45	Taxi	test	27
46	Bus	test	27
47	Taxi	test	11
48	Bus	Chengdu bus is mostly unmanned Chengdu bus Chengdu bus (10) bus (10) air conditioning bus, one way ticket 2 yuan per person; a few bus routes from the main city area to the suburbs for the ticket sales, most of the fare is 2 yuan per person / person ~3 yuan / person. All the buses running in the central urban area and parts from the central city to the suburbs can use the "Tianfu" bus IC card, the number of brushes and electronic purses running in the central urban area, of which the number of brushes is 50 percent off, and the free transfer is three times within 2 hours, but the electronic wallet is only 10 percent off, and it is not enjoyed. Free transfer policy.	11
49	Taxi	test	12
50	Bus	test	12
51	Taxi	test	13
52	Bus	test	13
53	Taxi	test	14
54	Bus	test	14
55	Taxi	test	16
56	Bus	test	16
57	Taxi	test	30
58	Bus	test	30
59	Taxi	test	45
60	Bus	test	45
61	Taxi	test	49
62	Bus	test	49
63	Taxi	test	55
64	Bus	test	55
65	Taxi	test	58
66	Bus	test	58
67	Taxi	test	60
68	Bus	test	60
69	Taxi	test	65
70	Bus	test	65
71	Taxi	test	71
72	Bus	test	71
73	Taxi	test	75
74	Bus	test	75
75	Taxi	test	78
76	Bus	test	78
77	Taxi	test	80
78	Bus	test	80
79	Taxi	test	83
80	Bus	test	83
81	Taxi	test	90
82	Bus	test	90
\.


--
-- Data for Name: maincontent_transportouter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maincontent_transportouter (id, transporttype, transportname, transportdetails, transportcity_id) FROM stdin;
1	Train Station	Hongqiao Railway Station	The main rail hub for high-speed trains in Shanghai, Hongqiao Railway Station is located on the city's west side, right next to Hongqiao International Airport. It is services by Metro Lines 2, 7 and 17, and services high-speed trains only. It can get extremely busy at certain times of the year, but is normally very easy to navigate. From the city center, a day will probably cost you around 70 RMB during the day, or 100 RMB at night.	64
2	Airport	Shanghai Pudong International Airport	The main hub for international flights in and out of Shanghai, Pudong International Airport is located around 45km out of the city center. Besides most international flights, it also caters for some domestic flights. It consists of two Terminals, 1 & 2 which are connected and can be walked between. To get to the airport, a taxi will cost 200+ RMB from downtown, of around 300+ RMB at night. Alternatively Metro Line 2 will take you all the way to the airport (at least 80 mins), of the Maglev can get you from Longyang Road Metro Station to the terminal in just 8 minutes.	64
3	Airport	Shanghai Hongqiao International Airport	Despite the name, Hongqiao International Airport caters mainly for domestic flights, as well as flights to Hong Kong, Macau and Taiwan. There are a limited amount of flights to mainly South-east Asian countries as well. The airport consists of two terminals which are completely separate to each other. The bigger terminal is Terminal 2, and it is located on the west side of the tarmac, right next to Hongqiao Railway Station. It is serviced by Metro Lines 2 and 10. Terminal 1 is located on the east side of the tarmac, and mainly serves budget airline Spring Airlines. It is serviced only by Metro Line 10. From the city center, a taxi to the airport will cost around 70 RMB during the day, or 100 RMB at night.	64
4	Train Station	Beijing Railway Station	Previous Beijing's main railway station, Beijing station is located quite central, just to the south-east of the city center. These days it has largely been replaced by Beijing South and Beijing West Railway stations, although it still sends trains to North east China, as well as non-high speed trains to Shanghai. It is also the terminal for international trains to Russia and North Korea. It is served by Line 2 of the Beijing Metro system.	6
5	Train Station	Beijing West Railway Station	Located to the west of the city center, Beijing West serves both high and low speed trains, and is the terminus for some important routes including Beijing to Guangzhou and Beijing to Kowloon. It can be accessed via metro lines 7 and 9.	6
6	Train Station	Beijing South Railway Station	Located to the south west of the city center, Beijing South serves as the main terminus for high speed trains, although some non-high speed trains also stop here. Major train lines including the 350km/h Beijing-Shanghai line and the Tianjin-Beijing line terminate here. Both Metro lines 4 and Line 14 pass through the station.	6
7	Airport	Beijing Capital International Airport	This is the main airport in Beijing for both International and Domestic flights, and is one of the biggest in the world. It consists of three terminals, with terminal 3 being the biggest. Terminal 1 is only used by Hainan airlines for domestic flights, whereas Terminal 2 and Terminal 3 serves both domestic and international flights. There is an Airport express metro line connecting the airport to the downtown area which takes less than 20 minutes and links with Dongzhimen metro station, where you can change to Line 2 or Line 13.	6
8	Airport	Beijing Nanyuan Airport	A small military/civilian dual use airport located in the southern suburbs of Beijing, this airport is only used by China United Airlines and well as Tianjin Airlines. It does not have a metro link.	6
9	Airport	Beijing Daxing International Airport	Beijing's new under constuction mega airport located to the south of the city center is estimated to open in September 2019. The New Airport Express line is currently under construction. Once open, Beijing Nanyuan Airport will close.	6
10	Train Station	Shenzhen Railway Station	Also known as Luohu Railway Station, this station is located in Shenzhen's central Luohu disctrict, right near the border with Hong Kong. It serves mainly intercity trains for the Guangdong region, as well as some long distance trains to places like Shanghai and Beijing. It is also connected to metro line 1 and Line 9.	69
11	Train Station	Shenzhen North Railway Station	Shenzhen North is a major Railway Station located to the north of the city. It's part of the Hong Kong - Shenzhen - Guangzhou Express Rail Link, and also the Shenzhen - Fuzhou - Hangzhou Railway which follows the coastline. It connect's with Metro Line's 4 and 5, as well as the under construction Line 6.	69
12	Train Station	Futian Railway Station	Located completely underground in central Futian District, this station is a link on the Hong Kong - Shenzhen - Guangzhou Express Rail Link, and is a major interchange between metro Lines 2, 3 and 11.	69
13	Airport	Shenzhen Bao'an International Airport	Bao'an International Airport is located around 32km North-West of the city center, and serves both domestic and international flights from Shenzhen. It is served by Shenzhen Metro Line 11. It also features a ferry with a direct connection to HK international airport, allowing for visa-less transfers.	69
14	Train Station	Guangzhou Railway Station	Guangzhou Railway Station is located in the city's west, and serves trains going to Shenzhen, Beijing and Lhasa (Tibet). Is connects directly with Metro lines 2 and 5.	26
15	Train Station	Guangzhou East Station	The Guangzhou East Railway Station is located fairly centrally, although it is fairly small. It serves trains on the Guangzhou - Shenzhen Railway, and the Guangzhou - Meizou - Shantou Railway. It is connected with Line 1 and Line 3 or Guangzhou Metro.	26
16	Train Station	Guangzhou South Station	Guangzhou's largest railway station is located around 17km south of the city center. It is the terminus for many high speed routes including Guangzhou to Beijing and Guangzhou to Shanghai. Metro Lines 2 and & connect directly to the station, while Lines 18, 20 and FMetro Line 2 are currently under construction.	26
17	Train Station	Guangzhou North Station	This station mainly serves trains on the Guangzhou - Wuhan high speed railway line. It connects with Metro Line 9.	26
18	Airport	Guangzhou Baiyun International Airport	Baiyun International Airport serves both international and domestic flights for the city. It consists of two terminals, with Terminal 2 only opening in April 2018, and serving as the home of China Southern Airlines. It is located around 30 km to the north of the city, and can be access on Metro Line 3.	26
19	Train Station	Xi'an Railway Station	test	84
20	Train Station	Xi'an North Railway Station	test	84
21	Airport	Xi'an Xianyang International Airport	test	84
22	Train Station	Guilin Railway Station	test	27
23	Train Station	Guilin North Railway Station	test	27
24	Train Station	Guilin Liangjiang International Airport	test	27
25	Train Station	Nanjing Railway Station	test	55
26	Train Station	Nanjing South Railway Station	test	55
27	Airport	Nanjing Lukou International Airport	test	55
28	Train Station	Hankou Railway Station	test	80
29	Train Station	Wuchang Railway Station	test	80
30	Train Station	Wuhan Railway Station	test	80
31	Airport	Wuhan Tianhe International Airport	test	80
32	Train Station	Tianjin Railway Station	test	75
33	Train Station	Tianjin West Railway Station	test	75
34	Train Station	Tianjin North Railway Station	test	75
35	Airport	Tianjin Binhai International Airport	test	75
36	Train Station	Xiamen Railway Station	test	83
37	Train Station	Xiamen North Railway Station	test	83
38	Airport	Xiamen Gaoqi International Airport	test	83
39	Train Station	Fuzhou (North) Railway Station	test	24
40	Train Station	Fuzhou South Railway Station	test	24
41	Airport	Fuzhou Changle International Airport	test	24
45	Train Station	Suzhou Railway Station	test	71
46	Train Station	Suzhou North Railway Station	test	71
47	Airport	Suzhou Shuofang International Airport	test	71
48	Train Station	Ningbo Railway Station	test	57
49	Airport	Ningbo Lishe International Airport	test	57
50	Train Station	Zhengzhou Railway Station	test	101
51	Train Station	Zhengzhou East Railway Station	test	101
52	Airport	Zhengzhou Xinzheng International Airport	test	101
53	Train Station	Jinan Railway Station	test	38
54	Train Station	Jinan West Railway Station	test	38
55	Airport	Jinan Yaoqiang International Airport	test	38
56	Train Station	Taiyuan South Railway Station	test	74
57	Airport	Taiyuan Wusu Airport	test	74
58	Train Station	Dalian Railway Station	test	14
59	Train Station	Dalian North Railway Station	test	14
60	Airport	Dalian Zhoushuizi International Airport	test	14
61	Airport	Jilin International Airport	test	37
62	Train Station	Harbin Railway Station	test	31
63	Train Station	Harbin West Railway Station	test	31
64	Train Station	Harbin East Railway Station	test	31
65	Airport	Harbin Taiping International Airport	test	31
66	Train Station	Lanzhou Railway Station	test	46
67	Train Station	Lanzhou West Railway Station	test	46
68	Airport	Lanzhou Airport	test	46
69	Train Station	Changsha Railway Station	test	8
70	Train Station	Changsha South Railway Station	test	8
71	Airport	Changsha Huanghua International Airport	test	8
72	Train Station	Hohhot Railway Station	test	33
73	Airport	Hohhot Baita International Airport	test	33
74	Train Station	Nanning Railway Station	test	56
75	Airport	Nanning Wuxu International Airport	test	56
76	Train Station	Nanchang Railway Station	test	54
77	Airport	Nanchang Changbei International Airport	test	54
78	Train Station	Urumqi Railway Station	test	78
79	Train Station	Urumqi South Railway Station	test	78
80	Airport	Urumqi Diwopu International Airport	test	78
81	Train Station	Kunming Railway Station	test	45
82	Train Station	Kunming North Railway Station	test	45
83	Train Station	Kunming South Railway Station	test	45
84	Airport	Kunming Changshui International Airport	test	45
86	Airport	Dali Airport	Dali has a single airport which is located to the east of the city, and to the east of Erhai Lake. For the airport it is quite a distance if you are staying in Dali Old Town. It services major cities such as Shanghai and Beijing as well as local large cities like Kunming and Chongqing. It will cost about 60RMB to get to Dali by taxi, or 90RMB to the old town.	13
87	Train Station	Lijiang Railway Station	Lijiang's Railway Station is located to the south of the city, and serve's only slow speed trains. Trains are available to Dali and Kunming, as well as several regional destinations.	49
88	Airport	Lijiang Sanyi International Airport	Lijiang's only airport is located around 25km to the south of the city. Despite it's name, it only serves domestic Chinese routes. The main airlines are  China Eastern, Beijing Capital Airlines and Lucky Air.	49
89	Train Station	Dali Railway Station	The one station in the city serves just a few low-speed routes. There is no high speed railway in Dali. Heading south, the railway line connects to Kunming, whereas heading north, it connects to Lijiang.	13
90	Airport	Hangzhou Xiaoshan International Airport	Hangzhou Xiaoshan International Airport is located around 20km to the east of the Hangzhou city center, on the southern side of the river. In the future it can be accessed via Metro Line 1, which also conveniently connects to the two train stations. In serves both domestic flights as well as international flights, mainly to south-east Asia. International and regional flights are served by Terminal A, whereas Terminal B is used for domestic China flights.	30
91	Train Station	Hangzhou Railway Station	Also referred to as City Station (Chengzhan) by the locals, Hanghzou Railway Station is more centrally located than Hangzhou East, and serves both high and low speed trains. Although an older station, it can sometimes be more convenient to travel here due the location. It also connects with Line 1 of Hangzhou Metro.	30
92	Train Station	Hangzhou East Railway Station	One of the biggest high-speed railway stations in China, Hangzhou East is an enormous modern station which is easy to navigate. It operates as a hub for high-speed trains travelling to Pearl River Delta, as Shanghai can be reached in less than 50 minutes. It is connected to Metro Lines 1 & 4. 	30
93	Airport	Chengdu Shuangliu International Airport	Chengdu's main airport is location around 16km to the south-west of the city center, and can easily be reached by Metro Line 10. It's the 5 busiest airport in China, serving more than 40 million passengers ever year. The airport serves both domestic and international flights, and is the second hub for Air China outside of Beijing. Chengud has already begun constructing a much bigger airport to be known as Chengdu Tianfu International Airport, around 50km to the south-east of the city.	11
94	Train Station	Chengdu Railway Station	Chendu Railway Station is located to the north of the city, with many locals referring to it as the North Station in Chinese. The station serves low speed trains, and can be accessed by Metro Lines 1 and 7.	11
95	Train Station	Chengdu East Railway Station	Located around 12km to the east of the city centre, this is the main station for high-speed trains in Chengdu. This modern station is connected via Metro Lines 2 and 7, and serves trains to Chongqing, Chengdu, and many other cities.	11
96	Airport	Chongqing Jiangbei International Airport	Chongqing's main airport is located around 20km north of the city center and serves China domestic flights as well as flights to over 20 international cities. Serving 38 million passengers a year, it's the 9th busiest airport in China. It has convenient metro connections, with a spur of Metro Line 3, as well as Metro Line 10. 	12
97	Train Station	Chongqing Railway Station	Located right in the heart of Chongqing and next to the Yangtze River, Chongqing Railway Station was once the most important railway station in the city. These days it serves mainly long-distance low speed trains. Take the steepest escalator in Asia and you can reach the Metro (Line 1 and Line 3) within a few minutes. This station has now largely been superseded by other stations in the city.	12
98	Train Station	Chongqing North Railway Station	With a total of 26 platforms, this station in the city's northern suburbs handles both high and low speed trains. It's well connected to the city via Metro Lines 3 and 10, and the under-constuction Line 4. Most high speed trains from the east of the country, e.g. Shanghai, will pass through here.	12
99	Train Station	Chongqing West Railway Station	This new high-speed railway station was opened in early 2018, and includes trains on major routes such as Chongqing-Guizhou, Chongqing-Lanzhou, Chongqing-Kunming and Chongqing-Chengdu. Metro Lines 5 and the Loop Route will pass through here once completed.	12
100	Train Station	Shapingba Railway Station	A small train station in the city's western suburbs serving mainly regional trains. It is connected to Metro Line 1, as well as the under-construction Line 9 and the Loop Route. It was completed redeveloped and reopened in 2018.	12
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 51, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1151, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 17, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 34, true);


--
-- Name: maincontent_attraction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maincontent_attraction_id_seq', 952, true);


--
-- Name: maincontent_attractionimages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maincontent_attractionimages_id_seq', 11, true);


--
-- Name: maincontent_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maincontent_city_id_seq', 106, true);


--
-- Name: maincontent_cityimages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maincontent_cityimages_id_seq', 48, true);


--
-- Name: maincontent_cityweather_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maincontent_cityweather_id_seq', 144, true);


--
-- Name: maincontent_eat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maincontent_eat_id_seq', 1, false);


--
-- Name: maincontent_province_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maincontent_province_id_seq', 34, true);


--
-- Name: maincontent_transport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maincontent_transport_id_seq', 82, true);


--
-- Name: maincontent_transportouter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maincontent_transportouter_id_seq', 100, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_41316b9c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_41316b9c_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: maincontent_attraction maincontent_attraction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_attraction
    ADD CONSTRAINT maincontent_attraction_pkey PRIMARY KEY (id);


--
-- Name: maincontent_attractionimages maincontent_attractionimages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_attractionimages
    ADD CONSTRAINT maincontent_attractionimages_pkey PRIMARY KEY (id);


--
-- Name: maincontent_city maincontent_city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_city
    ADD CONSTRAINT maincontent_city_pkey PRIMARY KEY (id);


--
-- Name: maincontent_cityimages maincontent_cityimages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_cityimages
    ADD CONSTRAINT maincontent_cityimages_pkey PRIMARY KEY (id);


--
-- Name: maincontent_cityweather maincontent_cityweather_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_cityweather
    ADD CONSTRAINT maincontent_cityweather_pkey PRIMARY KEY (id);


--
-- Name: maincontent_eat maincontent_eat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_eat
    ADD CONSTRAINT maincontent_eat_pkey PRIMARY KEY (id);


--
-- Name: maincontent_province maincontent_province_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_province
    ADD CONSTRAINT maincontent_province_pkey PRIMARY KEY (id);


--
-- Name: maincontent_transport maincontent_transport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_transport
    ADD CONSTRAINT maincontent_transport_pkey PRIMARY KEY (id);


--
-- Name: maincontent_transportouter maincontent_transportouter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_transportouter
    ADD CONSTRAINT maincontent_transportouter_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_5b3889ad_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_5b3889ad_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_0e939a4f ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_8373b171 ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_417f1b1c ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_0e939a4f ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_e8701ad4 ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_8373b171 ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_4dd11067_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_4dd11067_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_417f1b1c ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_e8701ad4 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_de54fa62 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_2f047009_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_2f047009_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: maincontent_attraction_1cf745df; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_attraction_1cf745df ON public.maincontent_attraction USING btree (attcity_id);


--
-- Name: maincontent_attraction_2dbcba41; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_attraction_2dbcba41 ON public.maincontent_attraction USING btree (slug);


--
-- Name: maincontent_attraction_81084a7b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_attraction_81084a7b ON public.maincontent_attraction USING btree (cityslug);


--
-- Name: maincontent_attraction_cityslug_3de6848f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_attraction_cityslug_3de6848f_like ON public.maincontent_attraction USING btree (cityslug varchar_pattern_ops);


--
-- Name: maincontent_attraction_slug_43c2e274_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_attraction_slug_43c2e274_like ON public.maincontent_attraction USING btree (slug varchar_pattern_ops);


--
-- Name: maincontent_attractionimages_02d53dc7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_attractionimages_02d53dc7 ON public.maincontent_attractionimages USING btree (imattname_id);


--
-- Name: maincontent_city_2dbcba41; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_city_2dbcba41 ON public.maincontent_city USING btree (slug);


--
-- Name: maincontent_city_4a5754ed; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_city_4a5754ed ON public.maincontent_city USING btree (province_id);


--
-- Name: maincontent_city_slug_1c19f159_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_city_slug_1c19f159_like ON public.maincontent_city USING btree (slug varchar_pattern_ops);


--
-- Name: maincontent_cityimages_542b00e8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_cityimages_542b00e8 ON public.maincontent_cityimages USING btree (imcityname_id);


--
-- Name: maincontent_cityweather_6ed20d00; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_cityweather_6ed20d00 ON public.maincontent_cityweather USING btree (weathercity_id);


--
-- Name: maincontent_eat_d80cdd6d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_eat_d80cdd6d ON public.maincontent_eat USING btree (eatcity_id);


--
-- Name: maincontent_province_2dbcba41; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_province_2dbcba41 ON public.maincontent_province USING btree (slug);


--
-- Name: maincontent_province_slug_467ad100_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_province_slug_467ad100_like ON public.maincontent_province USING btree (slug varchar_pattern_ops);


--
-- Name: maincontent_transport_76126084; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_transport_76126084 ON public.maincontent_transport USING btree (transportcity_id);


--
-- Name: maincontent_transportouter_76126084; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX maincontent_transportouter_76126084 ON public.maincontent_transportouter USING btree (transportcity_id);


--
-- Name: auth_group_permissions auth_group_permiss_permission_id_1b66c7df_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_1b66c7df_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_e646a2a_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_e646a2a_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permiss_content_type_id_35381ef3_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_35381ef3_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_ad62c68_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_ad62c68_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_44b5f389_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_44b5f389_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_perm_permission_id_93dcd12_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_perm_permission_id_93dcd12_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_23f6cb2a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_23f6cb2a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_content_type_id_2e135c74_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_2e135c74_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_79c66153_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_79c66153_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maincontent_attractionimages maincontent__imattname_id_173a23c0_fk_maincontent_attraction_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_attractionimages
    ADD CONSTRAINT maincontent__imattname_id_173a23c0_fk_maincontent_attraction_id FOREIGN KEY (imattname_id) REFERENCES public.maincontent_attraction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maincontent_attraction maincontent_attractio_attcity_id_176fddb_fk_maincontent_city_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_attraction
    ADD CONSTRAINT maincontent_attractio_attcity_id_176fddb_fk_maincontent_city_id FOREIGN KEY (attcity_id) REFERENCES public.maincontent_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maincontent_city maincontent_cit_province_id_1299a056_fk_maincontent_province_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_city
    ADD CONSTRAINT maincontent_cit_province_id_1299a056_fk_maincontent_province_id FOREIGN KEY (province_id) REFERENCES public.maincontent_province(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maincontent_cityimages maincontent_cityi_imcityname_id_6c102a3b_fk_maincontent_city_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_cityimages
    ADD CONSTRAINT maincontent_cityi_imcityname_id_6c102a3b_fk_maincontent_city_id FOREIGN KEY (imcityname_id) REFERENCES public.maincontent_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maincontent_cityweather maincontent_cityw_weathercity_id_c12b830_fk_maincontent_city_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_cityweather
    ADD CONSTRAINT maincontent_cityw_weathercity_id_c12b830_fk_maincontent_city_id FOREIGN KEY (weathercity_id) REFERENCES public.maincontent_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maincontent_eat maincontent_eat_eatcity_id_431b7069_fk_maincontent_city_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_eat
    ADD CONSTRAINT maincontent_eat_eatcity_id_431b7069_fk_maincontent_city_id FOREIGN KEY (eatcity_id) REFERENCES public.maincontent_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maincontent_transport maincontent_tr_transportcity_id_2e4ce903_fk_maincontent_city_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_transport
    ADD CONSTRAINT maincontent_tr_transportcity_id_2e4ce903_fk_maincontent_city_id FOREIGN KEY (transportcity_id) REFERENCES public.maincontent_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: maincontent_transportouter maincontent_tr_transportcity_id_5b990f20_fk_maincontent_city_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maincontent_transportouter
    ADD CONSTRAINT maincontent_tr_transportcity_id_5b990f20_fk_maincontent_city_id FOREIGN KEY (transportcity_id) REFERENCES public.maincontent_city(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: expenses; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name text
);


ALTER TABLE categories OWNER TO expenses;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: expenses
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_id_seq OWNER TO expenses;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: expenses
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: expenses; Tablespace: 
--

CREATE TABLE expenses (
    id integer NOT NULL,
    user_id integer,
    category_id integer,
    year integer,
    month integer,
    week integer,
    day integer,
    amount integer,
    note text
);


ALTER TABLE expenses OWNER TO expenses;

--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: expenses
--

CREATE SEQUENCE expenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE expenses_id_seq OWNER TO expenses;

--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: expenses
--

ALTER SEQUENCE expenses_id_seq OWNED BY expenses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: expenses; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    firstname text,
    lastname text
);


ALTER TABLE users OWNER TO expenses;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: expenses
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO expenses;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: expenses
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: expenses
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: expenses
--

ALTER TABLE ONLY expenses ALTER COLUMN id SET DEFAULT nextval('expenses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: expenses
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: expenses
--

COPY categories (id, name) FROM stdin;
1	Entertainmant
2	Business
3	Food
4	Car
5	Insurance & Taxes
25	Rent
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenses
--

SELECT pg_catalog.setval('categories_id_seq', 25, true);


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: expenses
--

COPY expenses (id, user_id, category_id, year, month, week, day, amount, note) FROM stdin;
2	1	1	2015	11	47	5	5465	Tickets to London
1	1	3	2015	10	46	1	534	Dinner
3	1	2	2015	11	47	7	1300	Online course
4	1	1	2015	11	48	11	4799	Moto G smartphone
5	1	2	2015	11	48	11	1304	Phone bill
6	1	1	2015	11	49	18	999	Internet bill
7	1	1	2015	12	49	2	299	Google Music
9	1	2	2015	12	\N	8	999	A new expense
10	1	2	2015	11	\N	5	1000	Test
21	1	3	2015	11	\N	5	1000	test
22	1	4	2015	11	\N	4	100	Test
26	1	\N	2015	11	\N	13	999	\N
27	1	\N	2015	12	\N	13	888	\N
28	1	1	2015	12	\N	13	14	\N
8	1	\N	2015	12	50	8	14500	Rent
29	1	\N	2015	12	\N	13	9999	\N
30	1	1	2015	12	\N	13	999	Test
31	1	25	2015	12	\N	13	33	\N
32	1	1	2016	1	\N	6	30888	Holidays
\.


--
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenses
--

SELECT pg_catalog.setval('expenses_id_seq', 32, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: expenses
--

COPY users (id, firstname, lastname) FROM stdin;
1	John	Doe
2	Bob	Doe
3	Anna	Doe
4	Franz	Smith
5	Zoe	Smith
6	Mark	Smith
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: expenses
--

SELECT pg_catalog.setval('users_id_seq', 6, true);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: expenses; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: expenses; Tablespace: 
--

ALTER TABLE ONLY expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: expenses; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: categories_id; Type: FK CONSTRAINT; Schema: public; Owner: expenses
--

ALTER TABLE ONLY expenses
    ADD CONSTRAINT categories_id FOREIGN KEY (category_id) REFERENCES categories(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: user_id; Type: FK CONSTRAINT; Schema: public; Owner: expenses
--

ALTER TABLE ONLY expenses
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: elijen
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM elijen;
GRANT ALL ON SCHEMA public TO elijen;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


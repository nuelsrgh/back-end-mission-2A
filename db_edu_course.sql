--
-- PostgreSQL database dump
--

-- Dumped from database version 13.15
-- Dumped by pg_dump version 13.15

-- Started on 2026-02-24 13:45:15

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 4015835)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 4015833)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 200
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- TOC entry 207 (class 1259 OID 4015910)
-- Name: classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classes (
    id bigint NOT NULL,
    category_id bigint NOT NULL,
    tutor_id bigint NOT NULL,
    title character varying(150) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    level character varying(20),
    thumbnail character varying(255),
    status character varying(20) DEFAULT 'draft'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT classes_level_check CHECK (((level)::text = ANY ((ARRAY['beginner'::character varying, 'intermediate'::character varying, 'advanced'::character varying])::text[]))),
    CONSTRAINT classes_status_check CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'published'::character varying, 'archived'::character varying])::text[])))
);


ALTER TABLE public.classes OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 4015908)
-- Name: classes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.classes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classes_id_seq OWNER TO postgres;

--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 206
-- Name: classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classes_id_seq OWNED BY public.classes.id;


--
-- TOC entry 205 (class 1259 OID 4015893)
-- Name: tutors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tutors (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    bio text,
    expertise character varying(150),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tutors OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 4015891)
-- Name: tutors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tutors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tutors_id_seq OWNER TO postgres;

--
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 204
-- Name: tutors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tutors_id_seq OWNED BY public.tutors.id;


--
-- TOC entry 203 (class 1259 OID 4015880)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(20) DEFAULT 'student'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    fullname character varying,
    username character varying,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['student'::character varying, 'tutor'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 4015878)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 202
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 2872 (class 2604 OID 4015838)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 2880 (class 2604 OID 4015913)
-- Name: classes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes ALTER COLUMN id SET DEFAULT nextval('public.classes_id_seq'::regclass);


--
-- TOC entry 2878 (class 2604 OID 4015896)
-- Name: tutors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tutors ALTER COLUMN id SET DEFAULT nextval('public.tutors_id_seq'::regclass);


--
-- TOC entry 2874 (class 2604 OID 4015883)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3030 (class 0 OID 4015835)
-- Dependencies: 201
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories VALUES (1, 'Programming', 'Kelas pemrograman', '2026-02-07 16:29:55.187541');
INSERT INTO public.categories VALUES (2, 'Design', 'Kelas desain', '2026-02-07 16:29:55.187541');
INSERT INTO public.categories VALUES (3, 'Finance', 'Kelas keuangan', '2026-02-07 16:29:55.187541');
INSERT INTO public.categories VALUES (4, 'Web Development', 'Kategori kelas pemrograman web', '2026-02-07 16:36:28.250175');
INSERT INTO public.categories VALUES (5, 'UI/UX Design', 'Kategori kelas desain UI/UX', '2026-02-07 16:36:28.250175');


--
-- TOC entry 3036 (class 0 OID 4015910)
-- Dependencies: 207
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.classes VALUES (4, 4, 1, 'JavaScript Dasar untuk Pemula', 'Belajar dasar JavaScript mulai dari variabel, function, hingga DOM.', 399000.00, 'beginner', 'js-basic.png', 'published', '2026-02-07 16:39:30.62457', '2026-02-07 16:39:30.62457');
INSERT INTO public.classes VALUES (5, 4, 1, 'Backend Development dengan Node.js', 'Membangun REST API menggunakan Node.js dan Express.', 699000.00, 'intermediate', 'nodejs-backend.png', 'published', '2026-02-07 16:39:30.62457', '2026-02-07 16:39:30.62457');
INSERT INTO public.classes VALUES (6, 4, 1, 'Fullstack Web Project', 'Studi kasus membangun aplikasi web end-to-end.', 999000.00, 'advanced', 'fullstack-project.png', 'draft', '2026-02-07 16:39:30.62457', '2026-02-07 16:39:30.62457');
INSERT INTO public.classes VALUES (7, 5, 2, 'Wireframing & Prototyping', 'Belajar membuat wireframe dan prototype menggunakan Figma.', 449000.00, 'beginner', 'wireframe-figma.png', 'published', '2026-02-07 16:39:30.62457', '2026-02-07 16:39:30.62457');
INSERT INTO public.classes VALUES (8, 5, 2, 'UX Research & User Testing', 'Teknik riset pengguna dan usability testing.', 649000.00, 'intermediate', 'ux-research.png', 'published', '2026-02-07 16:39:30.62457', '2026-02-07 16:39:30.62457');
INSERT INTO public.classes VALUES (10, 2, 1, 'Belajar Node.js', 'Full backend course', 200000.00, 'beginner', NULL, 'draft', '2026-02-07 22:37:25.023626', '2026-02-07 22:37:25.023626');
INSERT INTO public.classes VALUES (11, 1, 1, 'Belajar PostgreSQL', 'Dasar sampai mahir', 200000.00, 'beginner', NULL, 'draft', '2026-02-08 00:13:09.018618', '2026-02-08 00:13:09.018618');


--
-- TOC entry 3034 (class 0 OID 4015893)
-- Dependencies: 205
-- Data for Name: tutors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tutors VALUES (1, 3, 'Tutor dengan pengalaman 5 tahun mengajar pemrograman.', 'Web Development', '2026-02-07 16:35:18.525489');
INSERT INTO public.tutors VALUES (2, 4, 'Spesialis desain UI/UX dan frontend.', 'UI/UX Design', '2026-02-07 16:35:18.525489');


--
-- TOC entry 3032 (class 0 OID 4015880)
-- Dependencies: 203
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (3, 'Citra Lestari', 'citra@tutor.com', 'password123', 'tutor', '2026-02-07 16:34:33.050156', NULL, NULL);
INSERT INTO public.users VALUES (4, 'Dewi Anggraini', 'dewi@tutor.com', 'password123', 'tutor', '2026-02-07 16:34:33.050156', NULL, NULL);
INSERT INTO public.users VALUES (5, 'Admin System', 'admin@system.com', 'admin123', 'admin', '2026-02-07 16:34:33.050156', NULL, NULL);


--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 200
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 5, true);


--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 206
-- Name: classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classes_id_seq', 11, true);


--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 204
-- Name: tutors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tutors_id_seq', 2, true);


--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 202
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- TOC entry 2887 (class 2606 OID 4015844)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2895 (class 2606 OID 4015923)
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- TOC entry 2893 (class 2606 OID 4015902)
-- Name: tutors tutors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tutors
    ADD CONSTRAINT tutors_pkey PRIMARY KEY (id);


--
-- TOC entry 2889 (class 2606 OID 4015890)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 2891 (class 2606 OID 4015888)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2897 (class 2606 OID 4015924)
-- Name: classes fk_classes_category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT fk_classes_category FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- TOC entry 2898 (class 2606 OID 4015929)
-- Name: classes fk_classes_tutor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT fk_classes_tutor FOREIGN KEY (tutor_id) REFERENCES public.tutors(id);


--
-- TOC entry 2896 (class 2606 OID 4015903)
-- Name: tutors fk_tutors_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tutors
    ADD CONSTRAINT fk_tutors_user FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2026-02-24 13:45:16

--
-- PostgreSQL database dump complete
--


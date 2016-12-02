--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: calle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE calle (
    idcalle integer NOT NULL,
    nomcalle character varying(50) NOT NULL,
    idloc integer NOT NULL
);


ALTER TABLE calle OWNER TO postgres;

--
-- Name: calle_idcalle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE calle_idcalle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE calle_idcalle_seq OWNER TO postgres;

--
-- Name: calle_idcalle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE calle_idcalle_seq OWNED BY calle.idcalle;


--
-- Name: caso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE caso (
    idcaso integer NOT NULL,
    descripcion text,
    fecha_ingreso date NOT NULL,
    fecha_suceso date NOT NULL,
    hora_suceso time without time zone,
    tipo smallint DEFAULT 0,
    oficialprincipaldni bigint NOT NULL,
    id_ubicacion integer NOT NULL,
    id_categoria integer NOT NULL
);


ALTER TABLE caso OWNER TO postgres;

--
-- Name: COLUMN caso.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN caso.tipo IS 'Pendiente=0, Congelado=1, Descartado=2, Resuelto=3';


--
-- Name: caso_congelado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE caso_congelado (
    idcaso integer NOT NULL,
    comentario text,
    fecha_congelacion date NOT NULL
);


ALTER TABLE caso_congelado OWNER TO postgres;

--
-- Name: caso_descartado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE caso_descartado (
    idcaso integer NOT NULL,
    fecha_descarte date NOT NULL,
    motivacion text
);


ALTER TABLE caso_descartado OWNER TO postgres;

--
-- Name: caso_idcaso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE caso_idcaso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE caso_idcaso_seq OWNER TO postgres;

--
-- Name: caso_idcaso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE caso_idcaso_seq OWNED BY caso.idcaso;


--
-- Name: caso_resuelto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE caso_resuelto (
    idcaso integer NOT NULL,
    desc_resolucion text,
    fecha_resolucion date NOT NULL,
    oficialresueltodni integer NOT NULL
);


ALTER TABLE caso_resuelto OWNER TO postgres;

--
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoria (
    idcat integer NOT NULL,
    nombre_cat text NOT NULL
);


ALTER TABLE categoria OWNER TO postgres;

--
-- Name: categoria_idcat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categoria_idcat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categoria_idcat_seq OWNER TO postgres;

--
-- Name: categoria_idcat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categoria_idcat_seq OWNED BY categoria.idcat;


--
-- Name: culpable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE culpable (
    idcaso integer NOT NULL,
    personadni bigint NOT NULL
);


ALTER TABLE culpable OWNER TO postgres;

--
-- Name: custodia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE custodia (
    idcustodia integer NOT NULL,
    idevidencia integer NOT NULL,
    oficialdni bigint NOT NULL,
    id_ubicacion integer NOT NULL,
    comentario text,
    fecha_custodia date NOT NULL,
    hora_custodia time without time zone
);


ALTER TABLE custodia OWNER TO postgres;

--
-- Name: custodia_idcustodia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE custodia_idcustodia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE custodia_idcustodia_seq OWNER TO postgres;

--
-- Name: custodia_idcustodia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE custodia_idcustodia_seq OWNED BY custodia.idcustodia;


--
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE departamento (
    iddepto integer NOT NULL,
    nombre_depto character varying(50) NOT NULL,
    supervisor integer,
    id_ubicacion integer NOT NULL
);


ALTER TABLE departamento OWNER TO postgres;

--
-- Name: departamento_iddepto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE departamento_iddepto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE departamento_iddepto_seq OWNER TO postgres;

--
-- Name: departamento_iddepto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE departamento_iddepto_seq OWNED BY departamento.iddepto;


--
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE evento (
    idcaso integer NOT NULL,
    personadni bigint NOT NULL,
    descripcion text NOT NULL,
    hora_evento time without time zone NOT NULL,
    fecha_evento date NOT NULL,
    idevento integer NOT NULL
);


ALTER TABLE evento OWNER TO postgres;

--
-- Name: evento_idevento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE evento_idevento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evento_idevento_seq OWNER TO postgres;

--
-- Name: evento_idevento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE evento_idevento_seq OWNED BY evento.idevento;


--
-- Name: evidencia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE evidencia (
    idevidencia integer NOT NULL,
    idcaso integer NOT NULL,
    fecha_sellado date,
    hora_sellado time without time zone,
    descripcion text,
    fecha_ingreso date NOT NULL,
    fecha_hallazgo date NOT NULL,
    hora_hallazgo time without time zone
);


ALTER TABLE evidencia OWNER TO postgres;

--
-- Name: evidencia_idevidencia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE evidencia_idevidencia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE evidencia_idevidencia_seq OWNER TO postgres;

--
-- Name: evidencia_idevidencia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE evidencia_idevidencia_seq OWNED BY evidencia.idevidencia;


--
-- Name: involucra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE involucra (
    idcaso integer NOT NULL,
    personadni bigint NOT NULL,
    idrol integer NOT NULL
);


ALTER TABLE involucra OWNER TO postgres;

--
-- Name: localidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE localidad (
    idloc integer NOT NULL,
    nom_loc character varying(50) NOT NULL,
    idprov integer NOT NULL
);


ALTER TABLE localidad OWNER TO postgres;

--
-- Name: localidad_idloc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE localidad_idloc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE localidad_idloc_seq OWNER TO postgres;

--
-- Name: localidad_idloc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE localidad_idloc_seq OWNED BY localidad.idloc;


--
-- Name: oficial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE oficial (
    dni bigint NOT NULL,
    idservicio integer NOT NULL,
    iddepto integer NOT NULL,
    idrango integer NOT NULL,
    fecha_ingreso date NOT NULL,
    nroplaca integer NOT NULL,
    nro_escritorio integer
);


ALTER TABLE oficial OWNER TO postgres;

--
-- Name: participa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE participa (
    idcaso integer NOT NULL,
    personadni bigint NOT NULL
);


ALTER TABLE participa OWNER TO postgres;

--
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persona (
    dni bigint NOT NULL,
    fecha_nac date NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    tipo smallint DEFAULT 0 NOT NULL,
    id_ubicacion integer NOT NULL
);


ALTER TABLE persona OWNER TO postgres;

--
-- Name: COLUMN persona.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persona.tipo IS 'Persona=0, Oficial=1';


--
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE provincia (
    idprov integer NOT NULL,
    nom_prov character varying(50) NOT NULL
);


ALTER TABLE provincia OWNER TO postgres;

--
-- Name: provincia_idprov_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE provincia_idprov_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE provincia_idprov_seq OWNER TO postgres;

--
-- Name: provincia_idprov_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE provincia_idprov_seq OWNED BY provincia.idprov;


--
-- Name: rango; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE rango (
    idrango integer NOT NULL,
    nombre_rango character varying(50) NOT NULL
);


ALTER TABLE rango OWNER TO postgres;

--
-- Name: rango_idrango_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rango_idrango_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rango_idrango_seq OWNER TO postgres;

--
-- Name: rango_idrango_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rango_idrango_seq OWNED BY rango.idrango;


--
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE rol (
    idrol integer NOT NULL,
    nombre_rol character varying(50) NOT NULL
);


ALTER TABLE rol OWNER TO postgres;

--
-- Name: rol_idrol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rol_idrol_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rol_idrol_seq OWNER TO postgres;

--
-- Name: rol_idrol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rol_idrol_seq OWNED BY rol.idrol;


--
-- Name: servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE servicio (
    idservicio integer NOT NULL,
    nombre_servicio text NOT NULL
);


ALTER TABLE servicio OWNER TO postgres;

--
-- Name: servicio_idservicio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE servicio_idservicio_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE servicio_idservicio_seq OWNER TO postgres;

--
-- Name: servicio_idservicio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE servicio_idservicio_seq OWNED BY servicio.idservicio;


--
-- Name: telefono; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE telefono (
    nro bigint NOT NULL,
    tipo smallint DEFAULT 0 NOT NULL
);


ALTER TABLE telefono OWNER TO postgres;

--
-- Name: COLUMN telefono.tipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN telefono.tipo IS '0 personal
1 departamental';


--
-- Name: telefono_departamental; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE telefono_departamental (
    nro bigint NOT NULL,
    iddepto integer NOT NULL
);


ALTER TABLE telefono_departamental OWNER TO postgres;

--
-- Name: telefono_personal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE telefono_personal (
    nro bigint NOT NULL,
    personadni bigint NOT NULL
);


ALTER TABLE telefono_personal OWNER TO postgres;

--
-- Name: testimonio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE testimonio (
    idtest integer NOT NULL,
    personadni bigint NOT NULL,
    idcaso integer NOT NULL,
    oficialdni bigint NOT NULL,
    texto character varying(250) NOT NULL,
    hora_test time without time zone,
    fecha_test date NOT NULL
);


ALTER TABLE testimonio OWNER TO postgres;

--
-- Name: testimonio_idtest_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE testimonio_idtest_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE testimonio_idtest_seq OWNER TO postgres;

--
-- Name: testimonio_idtest_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE testimonio_idtest_seq OWNED BY testimonio.idtest;


--
-- Name: ubicacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ubicacion (
    id_lugar integer NOT NULL,
    idcalle integer NOT NULL,
    nro_calle integer NOT NULL,
    idloc integer NOT NULL,
    idprov integer NOT NULL
);


ALTER TABLE ubicacion OWNER TO postgres;

--
-- Name: ubicacion_id_lugar_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ubicacion_id_lugar_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ubicacion_id_lugar_seq OWNER TO postgres;

--
-- Name: ubicacion_id_lugar_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ubicacion_id_lugar_seq OWNED BY ubicacion.id_lugar;


--
-- Name: calle idcalle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY calle ALTER COLUMN idcalle SET DEFAULT nextval('calle_idcalle_seq'::regclass);


--
-- Name: caso idcaso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso ALTER COLUMN idcaso SET DEFAULT nextval('caso_idcaso_seq'::regclass);


--
-- Name: categoria idcat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria ALTER COLUMN idcat SET DEFAULT nextval('categoria_idcat_seq'::regclass);


--
-- Name: custodia idcustodia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custodia ALTER COLUMN idcustodia SET DEFAULT nextval('custodia_idcustodia_seq'::regclass);


--
-- Name: departamento iddepto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departamento ALTER COLUMN iddepto SET DEFAULT nextval('departamento_iddepto_seq'::regclass);


--
-- Name: evento idevento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento ALTER COLUMN idevento SET DEFAULT nextval('evento_idevento_seq'::regclass);


--
-- Name: evidencia idevidencia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evidencia ALTER COLUMN idevidencia SET DEFAULT nextval('evidencia_idevidencia_seq'::regclass);


--
-- Name: localidad idloc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidad ALTER COLUMN idloc SET DEFAULT nextval('localidad_idloc_seq'::regclass);


--
-- Name: provincia idprov; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia ALTER COLUMN idprov SET DEFAULT nextval('provincia_idprov_seq'::regclass);


--
-- Name: rango idrango; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rango ALTER COLUMN idrango SET DEFAULT nextval('rango_idrango_seq'::regclass);


--
-- Name: rol idrol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rol ALTER COLUMN idrol SET DEFAULT nextval('rol_idrol_seq'::regclass);


--
-- Name: servicio idservicio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY servicio ALTER COLUMN idservicio SET DEFAULT nextval('servicio_idservicio_seq'::regclass);


--
-- Name: testimonio idtest; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testimonio ALTER COLUMN idtest SET DEFAULT nextval('testimonio_idtest_seq'::regclass);


--
-- Name: ubicacion id_lugar; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ubicacion ALTER COLUMN id_lugar SET DEFAULT nextval('ubicacion_id_lugar_seq'::regclass);


--
-- Data for Name: calle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY calle (idcalle, nomcalle, idloc) FROM stdin;
503	Acceso	1160
1	Avenida 27 de Febrero	2065
2	Avenida 9 de Julio	1846
3	Avenida Achával Rodríguez	1645
4	Avenida Acoyte	149
6	Avenida Alberdi, Juan Bautista	2200
13	Avenida Alcorta, Amancio	1252
7	Avenida Alem, Leandro N.	143
8	Avenida Almafuerte	665
10	Avenida Álvarez Jonte	1378
11	Avenida Álvarez Thomas	1511
9	Avenida Álvarez, Teniente General Donato	1568
12	Avenida Alvear	1720
14	Avenida Antártida Argentina	1744
15	Avenida Aranguren, Juan Felipe	144
16	Avenida Argentina	968
17	Avenida Asamblea	1
18	Avenida Asturias	145
19	Avenida Avellaneda	2
20	Avenida Bacacay	337
21	Avenida Balbín, Ricardo	587
23	Avenida Beiró, Francisco	1078
22	Avenida Belgrano	3
24	Avenida Berro, Adolfo	4
25	Avenida Bilbao, Francisco	1670
26	Avenida Boedo	2199
27	Avenida Bonorino, Coronel Esteban	1542
28	Avenida Boyacá	1839
29	Avenida Brasil	1280
30	Avenida Cabildo	1281
31	Avenida Calabria	1282
32	Avenida Callao	1342
33	Avenida Campos, Luis María	146
5	Avenida Cantilo	1840
35	Avenida Carabobo	2273
36	Avenida Carrasco	485
37	Avenida Carril, Salvador María del	330
38	Avenida Casares	486
39	Avenida Caseros	1343
40	Avenida Castañares	147
41	Avenida Castillo, Ramón	282
42	Avenida Castro, Emilio	487
43	Avenida Chiclana	2274
44	Avenida Chile	1596
45	Avenida Chorroarín	1597
46	Avenida Cobo	1539
47	Avenida Colombia	1841
48	Avenida Congreso	1671
49	Avenida Córdoba	1283
50	Avenida Coronel Roca	5
51	Avenida Corrientes	2275
52	Avenida Crámer	1344
53	Avenida Crisólogo Larralde	981
54	Avenida Cruz, Osvaldo	1461
55	Avenida Curapaligüe	1732
56	Avenida Daract	1842
57	Avenida de la Rábida	6
58	Avenida de los Constituyentes	982
59	Avenida de los Incas	983
60	Avenida de los Inmigrantes	984
61	Avenida de los Italianos	488
62	Avenida de Mayo	1843
63	Avenida del Campo	1844
34	Avenida del Corro, Canónigo Miguel	994
64	Avenida del Fomentista	439
65	Avenida del Libertador	985
66	Avenida Derqui	440
68	Avenida Díaz Vélez	986
67	Avenida Díaz, Coronel	987
69	Avenida Directorio	441
70	Avenida Dorrego	988
71	Avenida Edison, Tomás Alva	989
72	Avenida Elcano	990
73	Avenida Entre Ríos	991
74	Avenida Escalada	992
75	Avenida España	128
76	Avenida Estado de Israel	993
77	Avenida Eva Perón	128
78	Avenida Fernández de la Cruz, General Francisco	995
79	Avenida Figueroa Alcorta	996
80	Avenida Forest	489
83	Avenida Gallardo, Ángel	997
81	Avenida Gaona	998
86	Avenida Garay, Juan de	999
82	Avenida García del Río	1000
84	Avenida Garmendia	2276
85	Avenida Gendarmería Nacional	148
87	Avenida Goyena, Pedro	1845
88	Avenida Goyeneche, Roberto	490
89	Avenida Griveo	491
90	Avenida Guzmán	1345
91	Avenida Huergo, Ingeniero	492
92	Avenida Independencia	1598
93	Avenida Infanta Isabel	493
94	Avenida Intendente Bullrich	1462
95	Avenida Intendente Cantilo	283
96	Avenida Intendente Francisco Rabanal	494
97	Avenida Intendente Güiraldes	1346
98	Avenida Intendente Noel	2277
99	Avenida Iraola	495
100	Avenida Jujuy	1347
101	Avenida Juramento	1001
102	Avenida Justo, Juan B.	496
103	Avenida Kennedy	497
104	Avenida La Plata	1752
105	Avenida Lacarra	1753
106	Avenida Lacroze, Federico	442
107	Avenida Lafuente	2278
108	Avenida Larrazábal	498
109	Avenida Las Heras, General	1540
110	Avenida Lastra	915
111	Avenida Lillo	2279
112	Avenida Lisandro de la Torre	2280
113	Avenida Lope de Vega	499
114	Avenida Madero, Eduardo	1847
115	Avenida Medrano	500
116	Avenida Melian	1848
117	Avenida Monroe	501
118	Avenida Montes de Oca	2281
119	Avenida Montt, Pedro	331
122	Avenida Moreau de Justo, Alicia	1754
121	Avenida Moreno, José María	1541
120	Avenida Moreno, Perito	332
123	Avenida Mosconi, General	1849
124	Avenida Nazca	1733
125	Avenida Obligado, Rafael	1672
126	Avenida Olivera	1850
127	Avenida Ortiz de Ocampo	1348
128	Avenida Paseo Colón	1673
129	Avenida Patricias Argentinas	502
130	Avenida Piedra Buena	1002
131	Avenida Prefectura Naval Argentina	333
132	Avenida Pueyrredón	1003
133	Avenida Pueyrredón, Dr. Honorio	1463
134	Avenida Punta Arenas	1004
135	Avenida Py, Comodoro	1349
137	Avenida Quartino, Ingeniero	1420
136	Avenida Quintana	2282
138	Avenida Ramallo	1851
139	Avenida Ramos Mejía	503
140	Avenida Rawson de Dellepiane, Elvira	504
141	Avenida Remedios	1464
142	Avenida Reservistas Argentinos	1755
143	Avenida Riestra	1852
144	Avenida Rivadavia	1853
145	Avenida Rivadavia, Comodoro Martín	1854
146	Avenida Roca, Presidente Julio Argentino	1284
147	Avenida Roldán, Belisario	7
148	Avenida Rosales	505
149	Avenida Ruiz Huidobro	1855
150	Avenida Sáenz	506
151	Avenida Sáenz Peña, Presidente Roque	1005
152	Avenida San Isidro Labrador	1006
153	Avenida San Juan	507
154	Avenida San Martín	1856
155	Avenida San Pedrito	1007
156	Avenida Sánchez de Loria	1008
157	Avenida Santa Fe	1599
158	Avenida Santiago de Compostela	1009
159	Avenida Sarmiento	1465
160	Avenida Sarmiento, General	1857
161	Avenida Scalabrini Ortiz	1600
162	Avenida Segurola	508
163	Avenida Suárez	1010
164	Avenida Triunvirato	1011
165	Avenida Udaondo	1858
166	Avenida Uruguay	1859
167	Avenida Varela	1860
168	Avenida Vélez Sársfield	509
169	Avenida Virrey Vértiz	510
170	Avenida Warnes	2283
171	Avenida White	1861
173	Calle 11 de Septiembre	1350
174	Calle 14 de Julio	1862
172	Calle 3 de Febrero	511
175	Calle Acevedo	150
178	Calle Agüero	512
176	Calle Aguilar	1863
177	Calle Aguirre	369
179	Calle Aizpurúa	8
180	Calle Alsina, Adolfo	1466
181	Calle Álvarez Jonte	9
182	Calle Ambrosetti, Juan B.	516
183	Calle Amenabar	1756
184	Calle Ancaste	10
185	Calle Aranguren, Dr. F.	1543
186	Calle Arce	11
187	Calle Arcos	1757
188	Calle Arevalo	513
189	Calle Arias	514
190	Calle Arribeños	515
191	Calle Arroyo	284
192	Calle Ascabusi	2284
193	Calle Austria	2201
194	Calle Azurduy, Juana	2202
195	Calle Baez	1012
196	Calle Balbastro	151
197	Calle Balcarce	12
198	Calle Batalla del Pari	1601
199	Calle Besares	285
200	Calle Blanco Encalada	1544
201	Calle Bogado	1864
202	Calle Bogotá	370
203	Calle Bolaños	152
204	Calle Bolivar	153
205	Calle Bolivia	1285
206	Calle Bollini	371
207	Calle Bolonia	1013
208	Calle Bonpland	1758
209	Calle Boulougne Sur Mer	1865
210	Calle Brandsen	1467
211	Calle Bulgaria	1759
212	Calle Bulnes	154
213	Calle Butteler	334
214	Calle Butty, Ingeniero E.	286
215	Calle Cabrera, José A.	517
216	Calle Camargo	1866
217	Calle Campos Salles	155
218	Calle Cantilo, José Luis	916
219	Calle Carapachay	2285
220	Calle Castillo	2203
221	Calle Cespedes	518
222	Calle Charcas	13
223	Calle Chuttro, Profesor Pedro	519
224	Calle Ciudad de la Paz	917
225	Calle Colpayo	1867
226	Calle Conde	156
227	Calle Conesa	14
228	Calle Coni, Dr. Emilio R.	1868
229	Calle Cooke, John W.	157
230	Calle Correa	158
231	Calle Cosquín	1869
232	Calle Costa Rica	1351
233	Calle Cuba	1352
234	Calle Cucha Cucha	520
235	Calle Cuenca	1014
236	Calle Darregueyra	521
237	Calle Defensa	1870
238	Calle Deheza	159
239	Calle Delgado	287
240	Calle Dragones	288
241	Calle Echeverria	15
242	Calle Ecuador	1871
243	Calle El Salvador	918
244	Calle Esparza	1468
245	Calle Espinosa	160
246	Calle Esquiú	1872
247	Calle Estados Unidos	522
249	Calle Esteves Sagui	1015
248	Calle Estomba	16
250	Calle Falcón, Ramón Lorenzo	17
251	Calle Ferreyra, Andres	2204
252	Calle Florida	523
253	Calle Fraga	524
254	Calle Frías, Teniente General Eustaquio	443
255	Calle Galván	1760
256	Calle Gana	1245
257	Calle Gandara	2286
258	Calle Gandhi, Mahatma	525
261	Calle García Grande de Zequeira, Severo	2287
260	Calle García Lorca, Federico	161
259	Calle García, Juan Agustín	1873
262	Calle García, Teodoro	1545
263	Calle Gascón	919
264	Calle Gordillo, Timoteo	1469
265	Calle Gorostiaga	1819
266	Calle Gorriti	1880
267	Calle Guatemala	533
268	Calle Guayra	534
269	Calle Güemes	535
270	Calle Guzmán	536
271	Calle Habana	1881
272	Calle Heredia	1882
273	Calle Honduras	1883
274	Calle Husares	19
275	Calle Ibáñez	1874
277	Calle Iberá	526
276	Calle Ituzaingo	289
278	Calle Jacarandá	1674
280	Calle Jachal	1875
279	Calle Jacques, Amadeo	1675
281	Calle Janer, Ana María	1876
282	Calle Jantin, Juan Bautista	1286
283	Calle Jaramillo	1817
284	Calle Jaures, Jean	527
285	Calle Jauretche, Arturo	1877
286	Calle Jenner, Dr. Eduardo	528
288	Calle Jerez, Pedro de	529
289	Calle Jorge	1818
290	Calle Jovellanos, Gaspar Melchor de	1353
291	Calle Juana de Arco	1287
292	Calle Juárez, Benito	1734
293	Calle Jufre	530
294	Calle Juncal	1602
295	Calle Junín	444
296	Calle Juramento	531
299	Calle La Pampa	532
297	Calle Laferrere, Gregorio de	18
298	Calle Lafinur	1878
300	Calle Lanín	2205
301	Calle Las Acacias	1470
302	Calle Lascano	1603
303	Calle Lavalle	372
304	Calle Lavalleja	1879
305	Calle Le Breton, Tomas	1676
306	Calle Lerma	1471
307	Calle Libertad	1677
308	Calle Luján, Pedro de	1472
309	Calle Luna	537
310	Calle Magnaud, Juez	1473
311	Calle Manzanares	1761
312	Calle Mataco	538
313	Calle Matienzo, Teniente Benjamin	1884
314	Calle Maure	1288
315	Calle Medrano	335
316	Calle Mendoza	539
317	Calle Mercader, Emir	540
318	Calle México	541
319	Calle Mitre, Bartolomé	542
320	Calle Moldes	20
321	Calle Morris, William C.	1474
322	Calle Muñecas	1886
323	Calle Naciones Unidas	2288
324	Calle Nahuel Huapi	21
325	Calle Namuncurá	374
350	Calle Ñandutí	336
326	Calle Naon, Juan José	373
327	Calle Naon, Romulo S.	543
328	Calle Nápoles	920
329	Calle Natal	1421
330	Calle Navarro	1438
331	Calle Navarro Viola, Miguel	1546
332	Calle Nazarre	1678
333	Calle Nazca	1735
334	Calle Necochea	1762
335	Calle Nepper	1885
336	Calle Neumann, Padre Juan B.	2206
337	Calle Neuquén	544
338	Calle Nevada	1887
339	Calle Newbery, Jorge	1475
340	Calle Newton	22
341	Calle Nicaragua	162
342	Calle Niza	1888
343	Calle Nogoyá	23
344	Calle Noruega	24
345	Calle Nueva York	25
346	Calle Nueva Zelandia	1889
347	Calle Numancia	26
348	Calle Núñez	1890
349	Calle Núñez, Obrero Roberto	27
351	Calle Oorman	28
352	Calle Olazábal	1891
353	Calle Olleros	545
354	Calle Orma	1763
355	Calle Ortega y Gasset	1764
356	Calle Palpa	445
357	Calle Paraguay	1892
358	Calle Paroissien	546
359	Calle Pasco	1893
360	Calle Pasteur, Luis	1354
361	Calle Pedraza, Manuela	547
362	Calle Perú	1894
363	Calle Pico	1895
365	Calle Piedras	163
364	Calle Pinto	1016
366	Calle Plumerillo	1896
367	Calle Posadas	1289
368	Calle Posta	164
369	Calle Quesada	1897
370	Calle Ramallo	1898
371	Calle Reconquista	29
372	Calle Repetto, Nicolás	1422
373	Calle Riglos	1604
374	Calle Rivera, Dr. Pedro I.	1355
375	Calle Rodríguez, General M. A.	1290
376	Calle Rohde, Coronel	1736
377	Calle Rojas	548
378	Calle Roosevelt, Franklin Delano	1547
379	Calle Rosario	1899
380	Calle Russel	1900
381	Calle Saavedra	1476
382	Calle Saenz Peña, Presidente Luis	1356
383	Calle Saladillo	1017
384	Calle Sanabria	1548
385	Calle Serrano	1901
386	Calle Soldado de la Independencia	1902
388	Calle Soler	1903
387	Calle Solís	1679
389	Calle Suárez, José León	1018
390	Calle Sucre	1477
391	Calle Superí	549
392	Calle Taborda, Diógenes	1478
393	Calle Tacuara	1605
394	Calle Talcahuano	1606
395	Calle Thames	2289
396	Calle Torres y Tenorio, Presidente Camilo	1905
397	Calle Traful	552
398	Calle Tronador	1904
399	Calle Ucacha	30
400	Calle Ugarte, Manual	290
401	Calle Ugarteche	1357
402	Calle Ukrania	1439
403	Calle Unamuno, Miguel de	550
404	Calle Unanue	1019
405	Calle Unquera, Baltasar de	551
406	Calle Urdaneta	1423
407	Calle Urdininea	553
408	Calle Uriarte	1906
409	Calle Uriburu	375
410	Calle Uriburu, General Napoleón	376
411	Calle Uriburu, Presidente José Evaristo	554
412	Calle Urien	555
413	Calle Urquiza, General	31
414	Calle Urtubey, Comodoro Clodomiro	921
415	Calle Uruguay	556
416	Calle Urunday	1607
417	Calle Uspallata	1680
418	Calle Uzal, Francisco de	2207
419	Calle Valdenegro	1020
420	Calle Valderrama	1424
421	Calle Valdivia, Pedro de	557
422	Calle Valencia	1737
423	Calle Valencia, Tomás	1608
425	Calle Valle	1609
427	Calle Valle Iberlucea, Enrique del	1610
426	Calle Valle, Aristóbulo del	32
428	Calle Valle, General Div. Juan José	1611
429	Calle Valle, María Remedios del	446
430	Calle Vallejos	2290
431	Calle Vallese, Felipe	377
424	Calle Valparaíso	1549
432	Calle Varas, José	1550
433	Calle Varela	1907
434	Calle Varela, Jacobo Adrián	2208
435	Calle Varela, José Pedro	1908
436	Calle Varsovia	559
437	Calle Vaz Ferreira, Doctor Carlos	560
438	Calle Vedia	558
439	Calle Vedia, Agustín de	561
440	Calle Vedia, Enrique de	165
441	Calle Vega Belgrano, Carlos	562
442	Calle Vega, Coronel Niceto	1291
443	Calle Vega, Ventura de la	378
444	Calle Velarde, Pedro	1612
445	Calle Velázquez	563
446	Calle Vélez, Dr. Bernardo	1551
447	Calle Venecia	1613
448	Calle Venezuela	2291
449	Calle Venialvo	166
450	Calle Ventana	167
451	Calle Vera	168
452	Calle Vera Peñaloza, Rosario	1909
453	Calle Veracruz	169
454	Calle Verdaguer, Jacinto	1614
455	Calle Verdi, José	2209
456	Calle Vespucio	1021
457	Calle Vespucio, Liberto Antonio	1246
458	Calle Viale, Luis	1910
459	Calle Viamonte	1911
460	Calle Victorica, Benjamín	1912
461	Calle Victorica, Miguel Carlos	379
462	Calle Vidal	1913
463	Calle Vidal, Emeric E.	447
464	Calle Videla Castillo	291
465	Calle Videla, Nicolás E.	1479
466	Calle Vidt	1914
467	Calle Viedma, Francisco de	1022
468	Calle Viejo Bueno	564
469	Calle Viel	2210
470	Calle Viena	1915
471	Calle Vieyra	565
472	Calle Vieytes	1480
473	Calle Vigo	1023
474	Calle Vila, Nicolás	1024
475	Calle Vilardebo, Teodoro	1025
476	Calle Vilela	1358
477	Calle Villa de Masnou	566
481	Calle Villa Juncal	1026
478	Calle Villafañe, Benjamín	1916
479	Calle Villafañe, Wenceslao	380
480	Calle Villaflor, Azucena	1917
482	Calle Villanueva	1918
483	Calle Villarino	567
484	Calle Villaroel	1919
485	Calle Villegas, General Conrado	568
486	Calle Vinchina	922
487	Calle Vintter, General Lorenzo	569
488	Calle Virasoro	1027
489	Calle Virasoro, Valentín	1920
490	Calle Virgilio	1028
492	Calle Virrey Arredondo	1921
493	Calle Virrey del Pino	1029
494	Calle Virrey Liniers	1030
495	Calle Virrey Loreto	1481
491	Calle Virreyes	1922
496	Calle Vittoria, Francisco de	2211
497	Calle Volta	1923
498	Calle Voltaire	1924
499	Calle Vucetich, Juan	2212
500	Calle Vuelta de Obligado	1031
501	Calle Wagner	381
502	Calle Washington	1032
505	Calle Yapeyú	1033
506	Calle Yatay	570
507	Calle Yerbal	571
508	Calle Yeruá	1925
510	Calle Yrigoyen, Hipólito	1034
509	Calle Yrupé	572
511	Calle Yrurtia, Rogelio	573
512	Calle Yugoslavia	923
513	Calle Zabala	924
514	Calle Zabala, Joaquín Dr.	1926
515	Calle Zado	574
516	Calle Záldivar, Pedro F.	1927
517	Calle Zamudio	1035
519	Calle Zañartu	1037
518	Calle Zanni, Comodoro Pedro	1038
520	Calle Zapala	1036
521	Calle Zapata	1039
522	Calle Zapiola	1247
523	Calle Zárate	1482
524	Calle Zarraga	382
525	Calle Zavaleta	575
526	Calle Zavalia	1928
527	Calle Zeballos, Estanislao S.	1040
528	Calle Zelada	1929
529	Calle Zelarrayán	576
530	Calle Zelaya	1930
531	Calle Zenteno	577
532	Calle Zepita	1359
533	Calle Zinny	925
534	Calle Zola, Emilio	1681
535	Calle Zolezzi, Antonio L.	578
536	Calle Zonza Briano, Pedro	1041
537	Calle Zuberbühler, Carlos Evaristo	579
538	Calle Zurich	1483
539	Calle Zuviría	580
540	Pasaje Achira	581
541	Pasaje Alfarero	1042
542	Pasaje Amalia	582
543	Pasaje Ampere	1484
544	Pasaje Aromo	33
545	Pasaje Asia	1043
546	Pasaje Bialet Massé	1615
547	Pasaje Bueras	2292
548	Pasaje Burgos	448
549	Pasaje Caballito	583
550	Pasaje Caminito	292
551	Pasaje Carabelas	2293
552	Pasaje Chirimay	383
553	Pasaje Cisne	1616
554	Pasaje Coronda	1820
555	Pasaje Costa	584
556	Pasaje Cura Brochero	1617
557	Pasaje de la Industria	449
558	Pasaje El Alfabeto	1618
559	Pasaje Ezeiza, Gabino	1765
560	Pasaje Fabre	384
561	Pasaje Facundo	926
562	Pasaje Faraday	2294
563	Pasaje Flor de Aire	1485
564	Pasaje Florencio Balcarce	1044
565	Pasaje Fraternidad	1045
566	Pasaje Igualdad	1360
567	Pasaje King	585
568	Pasaje Logroño	1046
569	Pasaje Marcoartu	1931
570	Pasaje Ortega	293
571	Pasaje Osaka	586
572	Pasaje Plus Ultra	1292
573	Pasaje Quebracho	450
574	Pasaje Río Piedras	1932
575	Pasaje Rivarola, Dr. Rodolfo	588
576	Pasaje Saenz Valiente, Juan Pablo	1619
577	Pasaje Santos Vega	34
578	Pasaje Ushuaia	1425
579	Pasaje Valle	1361
580	Pasaje Videla Castillo	589
581	Pasaje Wilde, Eduardo	1682
582	Pasaje Williams, Alberto	35
\.


--
-- Name: calle_idcalle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('calle_idcalle_seq', 1, false);


--
-- Data for Name: caso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY caso (idcaso, descripcion, fecha_ingreso, fecha_suceso, hora_suceso, tipo, oficialprincipaldni, id_ubicacion, id_categoria) FROM stdin;
1	Robo en el Departamento de Computacion de la Facultad de Ciencias Exactas y Naturales de la Universidad de Buenos Aires.	2016-09-17	2016-09-17	\N	0	261325	933	55
2	Amenaza del ISIS en Ciudad Universitaria, Universidad de Buenos Aires.	2016-09-17	2016-09-17	\N	3	284146	933	121
3	Consumo de drogas ilegales.	2016-09-17	2016-09-17	\N	1	261325	310	66
4	Asesinato	2016-09-17	2016-09-17	\N	2	284146	1083	66
5	Mama corto toda la loz.	2016-10-17	2016-10-16	\N	0	383290	342	12
6	Puso un cutucuchillo y se quedo letrificada.	2016-02-17	2015-03-17	\N	0	284146	645	1
7	De algo hay que morir.	2002-02-17	2000-12-17	\N	0	261325	231	3
8	No te lo po creer	2015-01-17	2001-03-17	\N	0	383290	687	32
9	Proc 10 test1	2015-01-17	2001-03-17	\N	0	261325	500	1
10	Proc 10 test2	2015-01-17	2001-03-17	\N	0	261325	501	2
\.


--
-- Data for Name: caso_congelado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY caso_congelado (idcaso, comentario, fecha_congelacion) FROM stdin;
3	AAAAA NO LLEGAMOS	2016-09-17
\.


--
-- Data for Name: caso_descartado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY caso_descartado (idcaso, fecha_descarte, motivacion) FROM stdin;
4	2016-09-17	No valia la pena
\.


--
-- Name: caso_idcaso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('caso_idcaso_seq', 1, false);


--
-- Data for Name: caso_resuelto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY caso_resuelto (idcaso, desc_resolucion, fecha_resolucion, oficialresueltodni) FROM stdin;
2	ISIS WACHINN	2016-09-17	383290
8	Habia metido un cutucuchillo	2016-10-17	284146
7	No habia muerto	2016-11-17	284146
\.


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categoria (idcat, nombre_cat) FROM stdin;
12	Aborto
91	Abuso de autoridad
18	Abuso sexual
77	Adulterio
40	Allanamiento de morada o violación de domicilio
41	Alzamiento de bienes
121	Amenaza Terrorista
28	Amenazas
114	Apartheid
82	Apología del delito o instigación a la comisión de delitos
81	Apología del terrorismo
42	Apropiación indebida
80	Asociación ilícita
19	Atentado contra el pudor
92	Atentado contra la autoridad
84	Atentados al orden constitucional y a la vida democrática
2	Auxilio al suicidio
78	Bigamia
65	Bioterrorismo
15	Calumnia
69	Caza de especies protegidas
70	Caza fuera de temporada
71	Caza furtiva
93	Cohecho
43	Concusión
88	Conducción bajo los efectos del alcohol y drogas
89	Conducción sin licencia
66	Consumo de drogas ilegales
44	Contrabando
72	Contrabando de especies en peligro de extinción
20	Corrupción de menores
116	Crimen contra la humanidad o de lesa humanidad
118	Crimen de agresión
117	Crimen de exterminio
115	Crimen de guerra
73	Daño al medio ambiente
45	Daños
51	Delito de incendio
74	Delito ecológico
29	Desaparición forzada
46	Desfalco
16	Difamación
35	Discriminación
3	Duelo
30	Esclavitud
38	Espionaje
47	Estafa
63	Estrago
21	Estupro
13	Eutanasia
95	Evasión fiscal
96	Exacciones ilegales
90	Exceso de velocidad
48	Expolio arqueológico y artístico
49	Extorsión
104	Falsa denuncia
111	Falsificación de documentos
109	Falsificación de moneda, billetes de banco, títulos al portador y documentos de crédito
110	Falsificación de sellos, timbres y marcas
103	Falso testimonio
4	Feminicidio
112	Fraudes al comercio y a la industria
5	Genocidio
113	Giro fraudulento de cheques
1	Homicidio
50	Hurto
6	Infanticidio
52	Infracción de derechos de autor
17	Injuria
7	Lesiones
8	Magnicidio
97	Malversación de caudales públicos
53	Manipulación del mercado
9	Matricidio
67	Narcotráfico
68	Negligencia médica
98	Negociaciones incompatibles con el ejercicio de funciones públicas
107	Obstrucción a la justicia
10	Parricidio
54	Peculado
106	Perjurio
64	Persecución de vehículos
75	Pesca de especies protegidas
120	Piratería
61	Piratería aérea
62	Piratería marítima
79	Poligamia
22	Pornografía infantil
108	Prevaricación
23	Prostitución infantil
24	Proxenetismo
36	Racismo
25	Rapto
85	Rebelión
99	Resistencia contra la autoridad
55	Robo
31	Secuestro
86	Sedición
105	Simulación de delito
14	Suicidio
32	Sustracción de menores
76	Tala de árboles protegidos
83	Tenencia ilícita, tráfico y depósito de armas, municiones o explosivos
34	Tortura
100	Trabajo irregular
26	Tráfico de niños
33	Tráfico de personas esclavizadas
87	Traición
56	Tutela penal de la propiedad industrial
57	Tutela penal del derecho de autor
59	Usura
58	Usurpación
101	Usurpación de autoridad, títulos u honores
11	Uxoricidio
60	Vandalismo
27	Violación
39	Violación de correspondencia
37	Xenofobia
\.


--
-- Name: categoria_idcat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categoria_idcat_seq', 1, false);


--
-- Data for Name: culpable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY culpable (idcaso, personadni) FROM stdin;
2	238767
\.


--
-- Data for Name: custodia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY custodia (idcustodia, idevidencia, oficialdni, id_ubicacion, comentario, fecha_custodia, hora_custodia) FROM stdin;
1	1	261325	1073		2016-09-17	\N
2	3	383290	1428		2016-09-17	\N
3	2	284146	87	sdas	2016-09-17	\N
5	1	383290	119	Anne is walking. Anne is walking. 	2018-11-25	\N
12	3	261325	1752	Anne bought new car. Tony is walking. Tony bought new car. John bought new car. 	2005-07-22	\N
14	3	261325	1176	John bought new car. Anne has free time. Tony is walking. 	2015-03-14	\N
30	3	284146	996	Anne bought new car. Anne is walking. Tony has free time. Tony has free time. John has free time. 	2019-11-23	\N
38	1	261325	656	Anne bought new car. Anne bought new car. 	2011-11-14	\N
44	1	261325	777	John is walking. Anne has free time. John bought new car. 	2000-10-20	\N
58	1	383290	107	John is shopping. Anne is shopping. John has free time. John bought new car. Anne bought new car. 	2013-11-05	\N
59	1	261325	1910	Anne bought new car. Anne bought new car. Tony bought new car. Tony has free time. 	2012-07-11	\N
60	2	383290	1797	Tony has free time. Tony has free time. John is shopping. Tony has free time. 	2004-01-19	\N
71	1	383290	120	Anne has free time. Anne is shopping. Tony is shopping. Tony has free time. 	2019-04-23	\N
\.


--
-- Name: custodia_idcustodia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('custodia_idcustodia_seq', 1, false);


--
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY departamento (iddepto, nombre_depto, supervisor, id_ubicacion) FROM stdin;
1	LINDA	\N	59
2	BARBARA	\N	75
3	RICHARD	\N	11
4	THOMAS	\N	42
5	ROBERT	\N	31
6	JOHN	\N	68
7	MICHAEL	\N	6
8	CHRISTOPHER	\N	34
9	DANIEL	\N	33
10	CHARLES	\N	41
11	DAVID	\N	16
12	PATRICIA	\N	87
13	JAMES	\N	54
14	JOSEPH	\N	47
15	WILLIAM	\N	45
16	MARY	\N	72
\.


--
-- Name: departamento_iddepto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('departamento_iddepto_seq', 1, false);


--
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY evento (idcaso, personadni, descripcion, hora_evento, fecha_evento, idevento) FROM stdin;
1	29709907	No se ha encontrado ningún tipo de evidencia en las cámaras de la universidad.	02:09:06	2016-09-17	61
2	1728642	No sucedió ningún atentado terrorista en Ciudad Universitaria.	02:06:52	2016-09-17	62
5	350881	Metio un cutucuchillo.	02:07:52	2016-09-17	63
5	350881	Corto toda la loz.	02:05:00	2016-09-16	64
5	1728642	Abundan los opinologos.	02:06:00	2016-09-16	65
\.


--
-- Name: evento_idevento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('evento_idevento_seq', 65, true);


--
-- Data for Name: evidencia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY evidencia (idevidencia, idcaso, fecha_sellado, hora_sellado, descripcion, fecha_ingreso, fecha_hallazgo, hora_hallazgo) FROM stdin;
1	2	\N	\N	Liquid Paper	2016-09-17	2016-09-17	01:56:51
2	3	\N	\N	Faso	2016-09-17	2016-09-17	01:57:06
3	2	\N	\N	Bomba	2016-09-17	2016-09-17	01:57:23
\.


--
-- Name: evidencia_idevidencia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('evidencia_idevidencia_seq', 1, false);


--
-- Data for Name: involucra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY involucra (idcaso, personadni, idrol) FROM stdin;
4	383290	1
1	29709907	4
2	1728642	4
3	1728642	4
1	284146	8
2	261325	8
3	261325	8
4	261325	8
5	350881	5
6	385023	5
5	1728642	5
9	396245	4
10	396245	4
9	284146	8
10	284146	8
\.


--
-- Data for Name: localidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY localidad (idloc, nom_loc, idprov) FROM stdin;
1160	�ancay	9
2065	�anducita	22
1846	�lvarez	22
1645	�orquinco	17
149	�rea Reserva Cintur�n Ecol�gico	2
2200	�rraga	23
1252	10	10
143	11 de Septiembre	2
665	12	7
1378	12	12
1511	15	15
1568	16	16
1720	18	18
1744	19	19
144	20 de Junio	2
968	20 del Palmar	8
1	25 de Mayo	1
145	25 de Mayo	2
2	3 de febrero	1
337	4	4
587	7	7
1078	9	9
3	A. Alsina	1
4	A. Gonz�les Ch�ves	1
1670	A. Saravia	18
2199	A�atuya	23
1542	A�elo	16
1839	Aar�n Castellanos	22
1280	Abdon Castro Tolay	11
1281	Abra Pampa	11
1282	Abralaite	11
1342	Abramo	12
146	Acassuso	2
1840	Acebal	22
2273	Acheral	25
485	Achiras	7
330	Aconquija	4
486	Adelia Maria	7
1343	Adolfo Van Praet	12
147	Adrogu�	2
282	Agronom�a	3
487	Agua de Oro	7
2274	Agua Dulce	25
1596	Aguada Cecilio	17
1597	Aguada de Guerra	17
1539	Aguada San Roque	16
1841	Aguar� Grande	22
1671	Aguaray	18
1283	Aguas Calientes	11
5	Aguas Verdes	1
2275	Aguilares	25
1344	Agustoni	12
981	Alarc�n	9
1461	Alba Posse	15
1732	Albard�n	19
1842	Albarellos	22
6	Alberti	1
982	Alcaraz	9
983	Alcaraz N.	9
984	Alcaraz S.	9
488	Alcira Gigena	7
1843	Alcorta	22
1844	Aldao	22
994	Aldea 19	9
439	Aldea Apeleg	6
985	Aldea Asunci�n	9
440	Aldea Beleiro	6
986	Aldea Brasilera	9
987	Aldea Elgenfeld	9
441	Aldea Epulef	6
988	Aldea Grapschental	9
989	Aldea Ma. Luisa	9
990	Aldea Protestante	9
991	Aldea Salto	9
992	Aldea San Antonio (G)	9
993	Aldea San Antonio (P)	9
995	Aldea San Miguel	9
996	Aldea San Rafael	9
489	Aldea Santa Maria	7
997	Aldea Spatzenkutter	9
998	Aldea Sta. Mar�a	9
999	Aldea Sta. Rosa	9
1000	Aldea Valle Mar�a	9
2276	Alderetes	25
148	Aldo Bonzi	2
1845	Alejandra	22
490	Alejandro Roca	7
491	Alejo Ledesma	7
1345	Algarrobo del Aguila	12
492	Alicia	7
1598	All�n	17
493	Almafuerte	7
1462	Almafuerte	15
283	Almagro	3
494	Alpa Corral	7
1346	Alpachiri	12
2277	Alpachiri	25
495	Alta Gracia	7
1347	Alta Italia	12
1001	Altamirano Sur	9
496	Alto Alegre	7
497	Alto de Los Quebrachos	7
1752	Alto Pelado	20
1753	Alto Pencoso	20
442	Alto R�o Sengerr	6
2278	Alto Verde	25
498	Altos de Chipion	7
1540	Alumin�	16
915	Alvear	8
2279	Amaicha del Valle	25
2280	Amberes	25
499	Amboy	7
1847	Ambrosetti	22
500	Ambul	7
1848	Amen�bar	22
501	Ana Zumaran	7
2281	Ancajuli	25
331	Ancasti	4
1754	Anchorena	20
1541	Andacollo	16
332	Andalgal�	4
1849	Ang�lica	22
1733	Angaco	19
1672	Angastaco	18
1850	Angeloni	22
1348	Anguil	12
1673	Animan�	18
502	Anisacate	7
1002	Antelo	9
333	Antofagasta	4
1003	Antonio Tom�s	9
1463	Ap�stoles	15
1004	Aranguren	9
1349	Arata	12
1420	Arauco	13
2282	Arcadia	25
1851	Arequito	22
503	Arguello	7
504	Arias	7
1464	Arist�bulo Del Valle	15
1755	Arizona	20
1852	Arminda	22
1853	Armstrong	22
1854	Arocena	22
1284	Arrayanal	11
7	Arrecifes	1
505	Arroyito	7
1855	Arroyo Aguiar	22
506	Arroyo Algodon	7
1005	Arroyo Bar�	9
1006	Arroyo Burgos	9
507	Arroyo Cabral	7
1856	Arroyo Ceibal	22
1007	Arroyo Cl�	9
1008	Arroyo Corralito	9
1599	Arroyo de La Ventana	17
1009	Arroyo del Medio	9
1465	Arroyo Del Medio	15
1857	Arroyo Leyes	22
1600	Arroyo Los Berros	17
508	Arroyo Los Patos	7
1010	Arroyo Maturrango	9
1011	Arroyo Palo Seco	9
1858	Arroyo Seco	22
1859	Arruf�	22
1860	Arteaga	22
509	Assunta	7
510	Atahona	7
2283	Atahona	25
1861	Ataliva	22
1350	Ataliva Roca	12
1862	Aurelia	22
511	Ausonia	7
150	Avellaneda	2
512	Avellaneda	7
1863	Avellaneda	22
369	Avi� Tera�	5
8	Ayacucho	1
1466	Azara	15
9	Azul	1
516	Ba�ado de Soto	7
1756	Bagual	20
10	Bah�a Blanca	1
1543	Bajada del Agrio	16
11	Balcarce	1
1757	Balde	20
513	Ballesteros	7
514	Ballesteros Sud	7
515	Balnearia	7
284	Balvanera	3
2284	Banda del R�o Sali	25
2201	Bandera	23
2202	Bandera Bajada	23
1012	Banderas	9
151	Banfield	2
12	Baradero	1
1601	Bariloche	17
285	Barracas	3
1544	Barrancas	16
1864	Barrancas	22
370	Barranqueras	5
152	Barrio Parque	2
153	Barrio Santa Teresita	2
1285	Barrios	11
371	Basail	5
1013	Basavilbaso	9
1758	Batavia	20
1865	Bauer Y Sigel	22
1467	Bdo. De Irigoyen	15
1759	Beazley	20
154	Beccar	2
334	Bel�n	4
286	Belgrano	3
517	Bell Ville	7
1866	Bella Italia	22
155	Bella Vista	2
916	Bella Vista	8
2285	Bella Vista	25
2203	Beltr�n	23
518	Bengolea	7
13	Benito Ju�rez	1
519	Benjamin Gould	7
917	Ber�n de Astrada	8
1867	Berabev�	22
156	Berazategui	2
14	Berisso	1
1868	Berna	22
157	Bernal Este	2
158	Bernal Oeste	2
1869	Bernardo de Irigoyen	22
1351	Bernardo Larroude	12
1352	Bernasconi	12
520	Berrotaran	7
1014	Betbeder	9
521	Bialet Masse	7
1870	Bigand	22
159	Billinghurst	2
287	Boca	3
288	Boedo	3
15	Bol�var	1
1871	Bombal	22
918	Bonpland	8
1468	Bonpland	15
160	Boulogne	2
1872	Bouquet	22
522	Bouwer	7
1015	Bovril	9
16	Bragado	1
17	Brandsen	1
2204	Brea Pozo	23
523	Brinkmann	7
524	Buchardo	7
443	Buen Pasto	6
1760	Buena Esperanza	20
1245	Buena Vista	10
2286	Buena Vista	25
525	Bulnes	7
2287	Burruyac�	25
161	Burzaco	2
1873	Bustinza	22
1545	Buta Ranquil	16
919	Ca� Cati	8
1469	Ca� Yari	15
1819	Ca�ad�n Seco	21
1880	Ca�ada de G�mez	22
533	Ca�ada de Luque	7
534	Ca�ada de Machado	7
535	Ca�ada de Rio Pinto	7
536	Ca�ada del Sauce	7
1881	Ca�ada del Ucle	22
1882	Ca�ada Rica	22
1883	Ca�ada Rosqu�n	22
19	Ca�uelas	1
1874	Cabal	22
526	Cabalango	7
289	Caballito	3
1674	Cachi	18
1875	Cacique Ariacaiquin	22
1675	Cafayate	18
1876	Cafferata	22
1286	Caimancito	11
1817	Calafate	21
527	Calamuchita	7
1877	Calchaqu�	22
528	Calchin	7
529	Calchin Oeste	7
1818	Caleta Olivia	21
1353	Caleuf�	12
1287	Calilegua	11
1734	Calingasta	19
530	Calmayo	7
1602	Calte. Cordero	17
444	Camarones	6
531	Camilo Aldao	7
532	Caminiaga	7
18	Campana	1
1878	Campo Andino	22
2205	Campo Gallo	23
1470	Campo Grande	15
1603	Campo Grande	17
372	Campo Largo	5
1879	Campo Piaggio	22
1676	Campo Quijano	18
1471	Campo Ram�n	15
1677	Campo Santo	18
1472	Campo Viera	15
537	Canals	7
1473	Candelaria	15
1761	Candelaria	20
538	Candelaria Sud	7
1884	Candioti	22
1288	Cangrejillos	11
335	Capay�n	4
539	Capilla de Remedios	7
540	Capilla de Siton	7
541	Capilla del Carmen	7
542	Capilla del Monte	7
20	Capilla del Se�or	1
1474	Capiov�	15
1886	Capit�n Berm�dez	22
2288	Capit�n C�ceres	25
21	Capit�n Sarmiento	1
374	Capit�n Solari	5
336	Capital	4
373	Capital	5
543	Capital	7
920	Capital	8
1421	Capital	13
1438	Capital	14
1546	Capital	16
1678	Capital	18
1735	Capital	19
1762	Capital	20
1885	Capital	22
2206	Capital	23
544	Capitan Gral B. O�Higgins	7
1887	Capivara	22
1475	Caraguatay	15
22	Carapachay	1
162	Carapachay	2
1888	Carcara��	22
23	Carhue	1
24	Caril�	1
25	Carlos Casares	1
1889	Carlos Pellegrini	22
26	Carlos Tejedor	1
1890	Carmen	22
27	Carmen de Areco	1
28	Carmen de Patagones	1
1891	Carmen Del Sauce	22
545	Carnerillo	7
1763	Carolina	20
1764	Carpinter�a	20
445	Carrenleuf�	6
1892	Carreras	22
546	Carrilobo	7
1893	Carrizales	22
1354	Carro Quemado	12
547	Casa Grande	7
1894	Casalegno	22
1895	Casas	22
163	Caseros	2
1016	Caseros	9
1896	Casilda	22
1289	Caspala	11
164	Castelar	2
1897	Castelar	22
1898	Castellanos	22
29	Castelli	1
1422	Castro Barros	13
1604	Catriel	17
1355	Catril�	12
1290	Catu�	11
1736	Caucete	19
548	Cavanagh	7
1547	Caviahu�	16
1899	Cayast�	22
1900	Cayastacito	22
1476	Cdte. Guacurar�	15
1356	Ceballos	12
1017	Ceibas	9
1548	Centenario	16
1901	Centeno	22
1902	Cepeda	22
1903	Ceres	22
1679	Cerrillos	18
1018	Cerrito	9
1477	Cerro Azul	15
549	Cerro Colorado	7
1478	Cerro Cor�	15
1605	Cerro Polic�a	17
1606	Cervantes	17
2289	Cevil Redondo	25
1905	Cha�ar Ladeado	22
552	Cha�ar Viejo	7
1904	Chab�s	22
30	Chacabuco	1
290	Chacarita	3
1357	Chacharramendi	12
1439	Chacras de Coria	14
550	Chaj�n	7
1019	Chajar�	9
551	Chalacea	7
1423	Chamical	13
553	Chancan�	7
1906	Chapuy	22
375	Charadai	5
376	Charata	5
554	Charbonier	7
555	Charras	7
31	Chascom�s	1
921	Chavarr�a	8
556	Chaz�n	7
1607	Chelforo	17
1680	Chicoana	18
2207	Chilca Juliana	23
1020	Chilcas	9
1424	Chilecito	13
557	Chilibroste	7
1737	Chimbas	19
1608	Chimpay	17
1609	Chinchinales	17
1610	Chipauquil	17
32	Chivilcoy	1
1611	Choele Choel	17
446	Cholila	6
2290	Choromoro	25
377	Chorotis	5
1549	Chorriaca	16
1550	Chos Malal	16
1907	Chovet	22
2208	Choya	23
1908	Christophersen	22
559	Chu�a	7
560	Chu�a Huasi	7
558	Chucul	7
561	Churqui Ca�ada	7
165	Churruca	2
562	Cienaga Del Coro	7
1291	Cieneguillas	11
378	Ciervo Petiso	5
1612	Cinco Saltos	17
563	Cintra	7
1551	Cipolletti	16
1613	Cipolletti	17
2291	Ciudacita	25
166	Ciudad Evita	2
167	Ciudad Madero	2
168	Ciudadela	2
1909	Classon	22
169	Claypole	2
1614	Clemente Onelli	17
2209	Clodomira	23
1021	Clodomiro Ledesma	9
1246	Clorinda	10
1910	Cnel. Arnold	22
1911	Cnel. Bogado	22
1912	Cnel. Dominguez	22
379	Cnel. Du Graty	5
1913	Cnel. Fraga	22
447	Co. Centinela	6
291	Coghlan	3
1479	Col. Alberdi	15
1914	Col. Aldao	22
1022	Col. Alemana	9
564	Col. Almada	7
2210	Col. Alpina	23
1915	Col. Ana	22
565	Col. Anita	7
1480	Col. Aurora	15
1023	Col. Avellaneda	9
1024	Col. Avigdor	9
1025	Col. Ayu�	9
1358	Col. Bar�n	12
566	Col. Barge	7
1026	Col. Baylina	9
1916	Col. Belgrano	22
380	Col. Ben�tez	5
1917	Col. Bicha	22
1918	Col. Bigand	22
567	Col. Bismark	7
1919	Col. Bossi	22
568	Col. Bremen	7
922	Col. C. Pellegrini	8
569	Col. Caroya	7
1027	Col. Carrasco	9
1920	Col. Cavour	22
1028	Col. Celina	9
1921	Col. Cello	22
1029	Col. Cerrito	9
1030	Col. Crespo	9
1481	Col. Delicia	15
1922	Col. Dolores	22
2211	Col. Dora	23
1923	Col. Dos Rosas	22
1924	Col. Dur�n	22
2212	Col. El Simbolar Robles	23
1031	Col. Elia	9
381	Col. Elisa	5
1032	Col. Ensayo	9
1033	Col. Gral. Roca	9
570	Col. Italiana	7
571	Col. Iturraspe	7
1925	Col. Iturraspe	22
1034	Col. La Argentina	9
572	Col. Las Cuatro Esquinas	7
573	Col. Las Pichanas	7
923	Col. Libertad	8
924	Col. Liebig	8
1926	Col. Margarita	22
574	Col. Marina	7
1927	Col. Mascias	22
1035	Col. Merou	9
1037	Col. Oficial N�13	9
1038	Col. Oficial N�14	9
1036	Col. Oficial N�3	9
1039	Col. Oficial N�5	9
1247	Col. Pastoril	10
1482	Col. Polana	15
382	Col. Popular	5
575	Col. Prosperidad	7
1928	Col. Raquel	22
1040	Col. Reffino	9
1929	Col. Rosa	22
576	Col. San Bartolome	7
1930	Col. San Jos�	22
577	Col. San Pedro	7
1359	Col. Santa Mar�a	12
925	Col. Sta Rosa	8
1681	Col. Sta. Rosa	18
578	Col. Tirolesa	7
1041	Col. Tunas	9
579	Col. Vicente Aguero	7
1483	Col. Victoria	15
580	Col. Videla	7
581	Col. Vignaud	7
1042	Col. Virar�	9
582	Col. Waltelina	7
1484	Col. Wanda	15
33	Col�n	1
1043	Col�n	9
1615	Col�n Conhue	17
2292	Colalao del Valle	25
448	Colan Conhu�	6
583	Colazo	7
292	Colegiales	3
2293	Colombres	25
383	Colonias Unidas	5
1616	Comallo	17
1820	Comandante Piedrabuena	21
584	Comechingones	7
1617	Comic�	17
449	Comodoro Rivadavia	6
1618	Cona Niyeu	17
1765	Concar�n	20
384	Concepci�n	5
926	Concepci�n	8
2294	Concepci�n	25
1485	Concepci�n De La Sierra	15
1044	Concepci�n del Uruguay	9
1045	Concordia	9
1360	Conhelo	12
585	Conlara	7
1046	Conscripto Bernardi	9
1931	Constanza	22
293	Constituci�n	3
586	Copacabana	7
1292	Coranzulli	11
450	Corcovado	6
1932	Coronda	22
588	Coronel Baigorria	7
1619	Coronel Belisle	17
34	Coronel Dorrego	1
1425	Coronel F. Varela	13
1361	Coronel Hilario Lagos	12
589	Coronel Moldes	7
1682	Coronel Moldes	18
35	Coronel Pringles	1
36	Coronel Rosales	1
37	Coronel Suarez	1
1486	Corpus	15
590	Corral de Bustos	7
338	Corral Quemado	4
591	Corralito	7
1933	Correa	22
1766	Cortaderas	20
385	Corzuela	5
592	Cosqu�n	7
38	Costa Azul	1
39	Costa Chica	1
40	Costa del Este	1
41	Costa Esmeralda	1
1047	Costa Grande	9
593	Costa Sacate	7
1048	Costa San Antonio	9
1049	Costa Uruguay N.	9
1050	Costa Uruguay S.	9
386	Cote Lai	5
1552	Covunco Abajo	16
1553	Coyuco Cochico	16
1051	Crespo	9
1934	Crispi	22
170	Crucecita	2
1052	Crucecitas 3�	9
1053	Crucecitas 7�	9
1054	Crucecitas 8�	9
594	Cruz Alta	7
595	Cruz de Ca�a	7
927	Cruz de Los Milagros	8
596	Cruz del Eje	7
1248	Cte. Fontana	10
1620	Cubanea	17
1055	Cuchilla Redonda	9
1362	Cuchillo-C�	12
597	Cuesta Blanca	7
1935	Culul�	22
1056	Curtiembre	9
1936	Curupayti	22
928	Curuz�-Cuati�	8
451	Cushamen	6
1293	Cusi-Cusi	11
1554	Cutral C�	16
42	Daireaux	1
43	Darregueira	1
1621	Darwin	17
598	Dean Funes	7
599	Del Campillo	7
44	Del Viso	1
2295	Delf�n Gallo	25
600	Despe�aderos	7
1937	Desvio Arij�n	22
601	Devoto	7
1057	Diamante	9
1938	Diaz	22
1939	Diego de Alvear	22
602	Diego de Rojas	7
1622	Dina Huapi	17
603	Dique Chico	7
452	Dique F. Ameghino	6
1058	Distrito 6�	9
1059	Distrito Cha�ar	9
1060	Distrito Chiqueros	9
1061	Distrito Cuarto	9
1062	Distrito Diego L�pez	9
1063	Distrito Pajonal	9
1064	Distrito Sauce	9
1065	Distrito Tala	9
1066	Distrito Talitas	9
1363	Doblas	12
171	Dock Sud	2
453	Dolav�n	6
45	Dolores	1
172	Don Bosco	2
1067	Don Crist�bal 1� Secci�n	9
1068	Don Crist�bal 2� Secci�n	9
173	Don Orione	2
46	Don Torcuato	1
1364	Dorila	12
1440	Dorrego	14
1487	Dos Arroyos	15
1488	Dos de Mayo	15
454	Dr. R. Rojas	6
1069	Durazno	9
1365	Eduardo Castex	12
1940	Egusquiza	22
1294	El Aguilar	11
1489	El Alc�zar	15
339	El Alto	4
604	El Ara�ado	7
1941	El Araz�	22
2213	El Bobadal	23
1623	El Bols�n	17
1683	El Bordo	18
2296	El Bracho	25
605	El Brete	7
1296	El C�ndor	11
1624	El Ca�n	17
2297	El Cadillal	25
1821	El Calafate	21
1295	El Carmen	11
1684	El Carril	18
2298	El Cercado	25
2299	El Cha�ar	25
606	El Chacho	7
1822	El Chalt�n	21
2214	El Charco	23
1555	El Cholar	16
1070	El Cimarr�n	9
1249	El Colorado	10
607	El Crisp�n	7
1490	El Dorado	15
1250	El Espinillo	10
608	El Fort�n	7
1297	El Fuerte	11
1685	El Galp�n	18
1071	El Gramillal	9
455	El Hoyo	6
1556	El Huec�	16
174	El Jag�el	2
1686	El Jard�n	18
175	El Libertador	2
456	El Mait�n	6
2300	El Manantial	25
1625	El Manso	17
609	El Manzano	7
2215	El Moj�n	23
2301	El Moj�n	25
2302	El Mollar	25
1767	El Morro	20
2303	El Naranjito	25
2304	El Naranjo	25
1072	El Palenque	9
176	El Palomar	2
1073	El Pingo	9
1298	El Piquete	11
2305	El Polear	25
1687	El Potrero	18
2306	El Puestito	25
1688	El Quebrachal	18
1074	El Quebracho	9
1942	El Rab�n	22
610	El Rastreador	7
1075	El Redom�n	9
340	El Rodeo	4
611	El Rodeo	7
2307	El Sacrificio	25
1557	El Sauce	16
387	El Sauzalito	5
1491	El Soberbio	15
1076	El Solar	9
1943	El Sombrerito	22
612	El T�o	7
177	El Tala	2
1689	El Tala	18
1299	El Talar	11
2308	El Timb�	25
178	El Tr�bol	2
1944	El Tr�bol	22
1768	El Trapiche	20
1769	El Volc�n	20
613	Elena	7
1945	Elisa	22
1946	Elortondo	22
1366	Embajador Martini	12
614	Embalse	7
1690	Embarcaci�n	18
1947	Emilia	22
1948	Empalme San Carlos	22
1949	Empalme Villa Constitucion	22
929	Empedrado	8
1077	Enrique Carbo	9
388	Enrique Urien	5
47	Ensenada	1
457	Epuy�n	6
2309	Escaba	25
48	Escobar	1
1950	Esmeralda	22
1492	Esperanza	15
1951	Esperanza	22
1079	Espinillo N.	9
458	Esquel	6
615	Esquina	7
930	Esquina	8
2310	Esquina	25
1952	Estaci�n Alvear	22
2311	Estaci�n Ar�oz	25
2216	Estaci�n Atamisqui	23
1080	Estaci�n Campos	9
1081	Estaci�n Escri�a	9
616	Estaci�n Gral. Paz	7
617	Estaci�n Ju�rez Celman	7
1082	Estaci�n Lazo	9
1083	Estaci�n Ra�ces	9
2217	Estaci�n Simbolar	23
931	Estaci�n Torrent	8
1084	Estaci�n Yer�a	9
1953	Estacion Clucellas	22
618	Estancia de Guadalupe	7
1085	Estancia Grande	9
1086	Estancia L�baros	9
1087	Estancia Racedo	9
1088	Estancia Sol�	9
619	Estancia Vieja	7
1089	Estancia Yuquer�	9
1251	Estanislao Del Campo	10
1090	Estaquitas	9
1954	Esteban Rams	22
1955	Esther	22
1956	Esustolia	22
620	Etruria	7
621	Eufrasio Loza	7
1957	Eusebia	22
49	Exaltaci�n de la Cruz	1
179	Ezeiza	2
180	Ezpeleta	2
1493	F. Ameghino	15
341	F.Mamerto Esqui�	4
1494	Fachinal	15
459	Facundo	6
622	Falda del Carmen	7
1367	Falucho	12
2312	Famaill�	25
1426	Famatina	13
1091	Faustino M. Parera	9
1092	Febre	9
1093	Federaci�n	9
1094	Federal	9
1958	Felicia	22
932	Felipe Yofr�	8
2218	Fern�ndez	23
342	Fiambal�	4
1959	Fidela	22
1960	Fighiera	22
1961	Firmat	22
1962	Florencia	22
181	Florencio Varela	2
50	Florentino Ameghino	1
294	Flores	3
295	Floresta	3
182	Florida	2
389	Fontana	5
1770	Fort�n El Patria	20
2219	Fort�n Inca	23
1253	Fort�n Lugones	10
1963	Fort�n Olmos	22
1771	Fortuna	20
2220	Fr�as	23
1772	Fraga	20
1300	Fraile Pintado	11
183	Francisco �lvarez	2
1964	Franck	22
1965	Fray Luis Beltr�n	22
623	Freyre	7
1966	Frontera	22
390	Fte. Esperanza	5
1967	Fuentes	22
1968	Funes	22
1985	G�deken	22
1971	G�lvez	22
1969	Gaboto	22
460	Gaim�n	6
1970	Galisteo	22
461	Gan Gan	6
391	Gancedo	5
51	Gar�n	1
1972	Garabalto	22
1973	Garibaldi	22
933	Garruchos	8
1495	Garuhap�	15
1496	Garup�	15
2221	Garza	23
2313	Gastone	25
462	Gastre	6
1974	Gato Colorado	22
934	Gdor. Agr�nomo	8
463	Gdor. Costa	6
1975	Gdor. Crespo	22
1095	Gdor. Echag�e	9
2314	Gdor. Garmendia	25
1823	Gdor. Gregores	21
1497	Gdor. L�pez	15
1096	Gdor. Mansilla	9
935	Gdor. Mart�nez	8
2315	Gdor. Piedrabuena	25
1498	Gdor. Roca	15
184	Gerli	2
1976	Gessler	22
1097	Gilbert	9
185	Glew	2
1441	Gllen	14
1977	Godoy	22
1442	Godoy Cruz	14
1978	Golondrina	22
1098	Gonz�lez Calder�n	9
186	Gonz�lez Cat�n	2
936	Goya	8
1427	Gral. A.V.Pe�aloza	13
1368	Gral. Acha	12
1099	Gral. Almada	9
52	Gral. Alvarado	1
53	Gral. Alvear	1
1100	Gral. Alvear	9
1443	Gral. Alvear	14
1499	Gral. Alvear	15
54	Gral. Arenales	1
624	Gral. Baldissera	7
1691	Gral. Ballivian	18
55	Gral. Belgrano	1
1428	Gral. Belgrano	13
625	Gral. Cabrera	7
1101	Gral. Campos	9
392	Gral. Capdevila	5
1626	Gral. Conesa	17
626	Gral. Deheza	7
1627	Gral. Enrique Godoy	17
1628	Gral. Fernandez Oro	17
627	Gral. Fotheringham	7
1692	Gral. G�emes	18
1102	Gral. Galarza	9
1979	Gral. Gelly	22
56	Gral. Guido	1
1429	Gral. J.F. Quiroga	13
1980	Gral. Lagos	22
57	Gral. Lamadrid	1
187	Gral. Lamadrid	2
1430	Gral. Lamadrid	13
58	Gral. Las Heras	1
59	Gral. Lavalle	1
628	Gral. Levalle	7
1254	Gral. Lucio V. Mansilla	10
60	Gral. Madariaga	1
1255	Gral. Manuel Belgrano	10
1369	Gral. Manuel Campos	12
1256	Gral. Mosconi	10
1693	Gral. Mosconi	18
1431	Gral. Ocampo	13
61	Gral. Pacheco	1
62	Gral. Paz	1
1370	Gral. Pico	12
393	Gral. Pinero	5
63	Gral. Pinto	1
1694	Gral. Pizarro	18
64	Gral. Pueyrred�n	1
1103	Gral. Ram�rez	9
629	Gral. Roca	7
1629	Gral. Roca	17
65	Gral. Rodr�guez	1
394	Gral. San Mart�n	5
1432	Gral. San Mart�n	13
1500	Gral. Urquiza	15
395	Gral. Vedia	5
66	Gral. Viamonte	1
67	Gral. Villegas	1
2222	Gramilla	23
1257	Gran Guardia	10
1981	Granadero Baigorria	22
188	Grand Bourg	2
2316	Graneros	25
1982	Gregoria Perez De Denis	22
189	Gregorio de Laferrere	2
1983	Grutly	22
1558	Gua�acos	16
1695	Guachipas	18
1984	Guadalupe N.	22
1104	Gualeguay	9
1105	Gualeguaych�	9
1106	Gualeguaycito	9
464	Gualjaina	6
68	Guamin�	1
630	Guanaco Muerto	7
1501	Guaran�	15
1107	Guardamonte	9
2223	Guardia Escolta	23
1630	Guardia Mitre	17
631	Guasapampa	7
632	Guatimozin	7
1371	Guatrach�	12
937	Guaviravi	8
1444	Guaymall�n	14
69	Guernica	1
190	Guillermo Enrique Hudson	2
633	Gutenberg	7
1502	H. Yrigoyen	15
191	Haedo	2
1108	Hambis	9
1109	Hasenkamp	9
1986	Helvecia	22
938	Herlitzka	8
396	Hermoso Campo	5
1111	Hern�ndez	9
1110	Hernandarias	9
634	Hernando	7
1258	Herradura	10
1112	Herrera	9
2224	Herrera	23
1987	Hersilia	22
1113	Hinojal	9
70	Hip�lito Yrigoyen	1
1301	Hip�lito Yrigoyen	11
1696	Hip�lito Yrigoyen	18
1824	Hip�lito Yrigoyen	21
1988	Hipat�a	22
1114	Hocker	9
1302	Huacalera	11
343	Hualf�n	4
635	Huanchillas	7
1989	Huanqueros	22
2317	Huasa Pampa	25
636	Huerta Grande	7
1990	Hugentobler	22
1991	Hughes	22
344	Huillapima	4
637	Huinca Renanco	7
1559	Huinganco	16
1303	Humahuaca	11
1992	Humberto 1�	22
1993	Humboldt	22
192	Hurlingham	2
397	I. del Cerrito	5
1994	Ibarlucea	22
1259	Ibarreta	10
345	Ica�o	4
2225	Ica�o	23
638	Idiazabal	7
1738	Iglesia	19
1503	Iguaz�	15
639	Impira	7
1433	Independencia	13
1995	Ing. Chanourdie	22
2226	Ing. Forres	23
1631	Ing. Huergo	17
1632	Ing. Jacobacci	17
1260	Ing. Ju�rez	10
1372	Ing. Luiggi	12
71	Ing. Maschwitz	1
1115	Ing. Sajaroff	9
193	Ing. Sourdeaux	2
640	Inriville	7
1373	Intendente Alvear	12
1996	Intiyaco	22
1116	Irazusta	9
1697	Iruy�	18
194	Isidro Casanova	2
1698	Isla De Ca�as	18
641	Isla Verde	7
1117	Isletas	9
939	Ita-Ibate	8
1504	Itacaruar�	15
642	Ital�	7
940	Itat�	8
195	Ituzaing�	2
941	Ituzaing�	8
1997	Ituzaing�	22
2318	J. B. Alberdi	25
465	J. de San Mart�n	6
1699	J. V. Gonzalez	18
1118	J.J De Urquiza	9
398	J.J. Castelli	5
1739	Jachal	19
1374	Jacinto Arauz	12
1998	Jacinto L. Ar�uz	22
643	James Craik	7
1825	Jaramillo	21
1505	Jard�n Am�rica	15
644	Jes�s Mar�a	7
196	Jos� C. Paz	2
197	Jos� Ingenieros	2
198	Jos� Marmol	2
942	Jos� Rafael G�mez	8
1999	Josefina	22
645	Jovita	7
2000	Juan B. Molina	22
2001	Juan de Garay	22
1773	Juan Jorba	20
1774	Juan Llerena	20
943	Juan Pujol	8
1775	Juana Koslay	20
1119	Jubileo	9
72	Jun�n	1
1445	Jun�n	14
2002	Juncal	22
646	Justiniano Posse	7
1776	Justo Daract	20
647	Km 658	7
1826	Koluel Kaike	21
648	L. V. Mansilla	7
2035	L�pez	22
1375	La Adela	12
2227	La Banda	23
649	La Batea	7
2003	La Brava	22
2228	La Ca�ada	23
2004	La Cabral	22
1700	La Caldera	18
650	La Calera	7
1777	La Calera	20
2005	La Camila	22
1701	La Candelaria	18
651	La Carlota	7
652	La Carolina	7
653	La Cautiva	7
654	La Cesira	7
2006	La Chispa	22
2007	La Clara	22
1120	La Clarita	9
399	La Clotilde	5
2319	La Cocha	25
1121	La Criolla	9
2008	La Criolla	22
655	La Cruz	7
944	La Cruz	8
656	La Cumbre	7
657	La Cumbrecita	7
400	La Eduvigis	5
401	La Escondida	5
1122	La Esmeralda	9
1304	La Esperanza	11
2320	La Esperanza	25
658	La Falda	7
1123	La Florida	9
1778	La Florida	20
2321	La Florida	25
659	La Francia	7
1124	La Fraternidad	9
2009	La Gallareta	22
660	La Granja	7
1125	La Hierra	9
661	La Higuera	7
1376	La Humada	12
662	La Laguna	7
402	La Leonesa	5
199	La Lucila	2
2010	La Lucila	22
1377	La Maruja	12
1305	La Mendieta	11
1702	La Merced	18
1126	La Ollita	9
663	La Paisanita	7
664	La Palestina	7
666	La Paquita	7
667	La Para	7
296	La Paternal	3
668	La Paz	7
1127	La Paz	9
1446	La Paz	14
2011	La Pelada	22
2012	La Penca	22
1128	La Picada	9
73	La Plata	1
669	La Playa	7
670	La Playosa	7
671	La Poblaci�n	7
1703	La Poma	18
672	La Posta	7
1129	La Providencia	9
346	La Puerta	4
673	La Puerta	7
1779	La Punilla	20
1306	La Quiaca	11
674	La Quinta	7
2322	La Ramada	25
675	La Rancherita	7
1379	La Reforma	12
200	La Reja	2
676	La Rinconada	7
2013	La Rubia	22
2014	La Sarita	22
677	La Serranita	7
201	La Tablada	2
403	La Tigra	5
1780	La Toma	20
678	La Tordilla	7
2323	La Trinidad	25
2015	La Vanguardia	22
1130	La Verbena	9
404	La Verde	5
1704	La Vi�a	18
679	Laborde	7
2016	Labordeboy	22
680	Laboulaye	7
1781	Lafinur	20
466	Lago Blanco	6
467	Lago Puelo	6
1131	Laguna Ben�tez	9
405	Laguna Blanca	5
1261	Laguna Blanca	10
1633	Laguna Blanca	17
681	Laguna Larga	7
406	Laguna Limpia	5
1262	Laguna Naick Neck	10
2017	Laguna Paiva	22
1263	Laguna Yema	10
468	Lagunita Salada	6
2324	Lamadrid	25
1634	Lamarque	17
202	Lan�s	2
2018	Landeta	22
2019	Lanteri	22
407	Lapachito	5
74	Laprida	1
2229	Laprida	23
2020	Larrechea	22
1132	Larroque	9
682	Las Acequias	7
1782	Las Aguadas	20
683	Las Albahacas	7
684	Las Arrias	7
2021	Las Avispas	22
685	Las Bajadas	7
2022	Las Bandurrias	22
408	Las Bre�as	5
688	Las Ca�adas	7
686	Las Caleras	7
687	Las Calles	7
2325	Las Cejas	25
1783	Las Chacras	20
1560	Las Coloradas	16
1133	Las Cuevas	9
75	Las Flores	1
409	Las Garcitas	5
1134	Las Garzas	9
2023	Las Garzas	22
689	Las Gramillas	7
1635	Las Grutas	17
1135	Las Guachas	9
1447	Las Heras	14
1827	Las Heras	21
690	Las Higueras	7
691	Las Isletillas	7
347	Las Juntas	4
692	Las Junturas	7
1784	Las Lagunas	20
1561	Las Lajas	16
1705	Las Lajitas	18
1264	Las Lomitas	10
1136	Las Mercedes	9
1137	Las Moscas	9
1138	Las Mulitas	9
1562	Las Ovejas	16
410	Las Palmas	5
693	Las Palmas	7
2024	Las Palmeras	22
2025	Las Parejas	22
694	Las Pe�as	7
695	Las Pe�as Sud	7
696	Las Perdices	7
2026	Las Petacas	22
697	Las Playas	7
469	Las Plumas	6
698	Las Rabonas	7
2027	Las Rosas	22
699	Las Saladas	7
2326	Las Talas	25
2327	Las Talitas	25
700	Las Tapias	7
76	Las Toninas	1
1139	Las Toscas	9
2028	Las Toscas	22
2029	Las Tunas	22
701	Las Varas	7
702	Las Varillas	7
703	Las Vertientes	7
1785	Las Vertientes	20
1140	Laurencena	9
1786	Lavaisse	20
945	Lavalle	8
1448	Lavalle	14
2230	Lavalle	23
2030	Lazzarino	22
77	Leandro N. Alem	1
1506	Leandro N. Alem	15
1787	Leandro N. Alem	20
1307	Ledesma	11
704	Leguizam�n	7
2031	Lehmann	22
705	Leones	7
1507	Libertad	15
1308	Libertador Gral. San Martin	11
1141	Libertador San Mart�n	9
1380	Limay Mahuida	12
78	Lincoln	1
297	Liniers	3
2032	Llambi Campbell	22
203	Llavallol	2
79	Loberia	1
80	Lobos	1
2033	Logro�o	22
2034	Loma Alta	22
204	Loma Hermosa	2
1142	Loma Limpia	9
946	Lomas de Vallejos	8
205	Lomas de Zamora	2
206	Lomas del Mill�n	2
207	Lomas del Mirador	2
1563	Loncopu�	16
348	Londres	4
208	Longchamps	2
1381	Lonquimay	12
947	Loreto	8
1508	Loreto	15
2231	Loreto	23
470	Los Altares	6
349	Los Altos	4
2036	Los Amores	22
1828	Los Antiguos	21
2328	Los Bulacio	25
712	Los C�ndores	7
81	Los Cardales	1
2037	Los Cardos	22
1564	Los Catutos	16
706	Los Cedros	7
1143	Los Ceibos	9
707	Los Cerrillos	7
708	Los Cha�aritos (C.E)	7
709	Los Chanaritos (R.S)	7
1144	Los Charruas	9
1565	Los Chihuidos	16
1265	Los Chiriguanos	10
710	Los Cisnes	7
711	Los Cocos	7
1145	Los Conquistadores	9
411	Los Frentones	5
2329	Los G�mez	25
1509	Los Helechos	15
713	Los Hornillos	7
714	Los Hoyos	7
2232	Los Jur�es	23
2038	Los Laureles	22
1636	Los Menucos	17
1566	Los Miches	16
715	Los Mistoles	7
716	Los Molinos	7
2039	Los Molinos	22
1788	Los Molles	20
2233	Los N��ez	23
2330	Los Nogales	25
2332	Los P�rez	25
2331	Los Pereyra	25
2234	Los Pirpintos	23
209	Los Polvorines	2
717	Los Pozos	7
2333	Los Puestos	25
2235	Los Quiroga	23
2040	Los Quirquinchos	22
2334	Los Ralos	25
718	Los Reartes	7
2335	Los Sarmientos	25
2336	Los Sosa	25
719	Los Surgentes	7
720	Los Talares	7
2236	Los Telares	23
82	Los Toldos	1
1706	Los Toldos	18
350	Los Varela	4
721	Los Zorros	7
1382	Loventuel	12
722	Lozada	7
1383	Luan Toro	12
723	Luca	7
1146	Lucas Gonz�lez	9
1147	Lucas N.	9
1148	Lucas S. 1�	9
1149	Lucas S. 2�	9
83	Lucila del Mar	1
2041	Lucio V. Lopez	22
2237	Lugones	23
1637	Luis Beltr�n	17
210	Luis Guill�n	2
2042	Luis Palacios	22
84	Luj�n	1
1449	Luj�n	14
1789	Luj�n	20
1450	Luj�n De Cuyo	14
2337	Lules	25
724	Luque	7
725	Luyaba	7
2338	M. Garc�a Fern�ndez	25
1153	M�danos	9
1510	M�rtires	15
2054	M�ximo Paz	22
2043	Ma. Juana	22
2044	Ma. Luisa	22
2045	Ma. Susana	22
2046	Ma. Teresa	22
1384	Macach�n	12
412	Machagai	5
1150	Maci�	9
2047	Maciel	22
85	Magdalena	1
2048	Maggiolo	22
1309	Maimara	11
1638	Mainqu�	17
86	Maip�	1
1451	Maip�	14
1385	Maisonnave	12
413	Makall�	5
2049	Malabrigo	22
726	Malague�o	7
1452	Malarg�e	14
2238	Malbr�n	23
727	Malena	7
211	Malvinas Argentinas	2
728	Malvinas Argentinas	7
1639	Mamuel Choique	17
729	Manfredi	7
2339	Manuela Pedraza	25
1567	Manzano Amargo	16
1640	Maquinchao	17
730	Maquinista Gallini	7
87	Mar Chiquita	1
88	Mar de Aj�	1
89	Mar de las Pampas	1
90	Mar del Plata	1
91	Mar del Tuy�	1
1151	Mar�a Grande	9
1152	Mar�a Grande 2�	9
2050	Marcelino Escalada	22
731	Marcos Ju�rez	7
92	Marcos Paz	1
2051	Margarita	22
414	Margarita Bel�n	5
948	Mariano I. Loza	8
212	Mart�n Coronado	2
213	Mart�nez	2
732	Marull	7
298	Mataderos	3
2239	Matara	23
2052	Matilde	22
733	Matorrales	7
734	Mattaldi	7
2053	Mau�	22
1386	Mauricio Mayer	12
1266	Mayor V. Villafa�e	10
735	Mayu Sumaj	7
949	Mburucuy�	8
2240	Medell�n	23
736	Media Naranja	7
2340	Medinas	25
2055	Melincu�	22
737	Melo	7
1641	Mencu�	17
738	Mendiolaza	7
93	Mercedes	1
950	Mercedes	8
1790	Mercedes	20
214	Merlo	2
1791	Merlo	20
1707	Met�n	18
1387	Metileo	12
739	Mi Granja	7
1388	Miguel Can�	12
1389	Miguel Riglos	12
2056	Miguel Torres	22
740	Mina Clavero	7
1310	Mina Pirquitas	11
215	Ministro Rivadavia	2
415	Miraflores	5
94	Miramar	1
741	Miramar	7
416	Misi�n N. Pompeya	5
1267	Misi�n San Fco.	10
951	Mocoret�	8
2057	Mois�s Ville	22
1512	Moj�n Grande	15
1154	Mojones N.	9
1155	Mojones S.	9
1156	Molino Doll	9
1708	Molinos	18
2058	Monigotes	22
2059	Monje	22
299	Monserrat	3
95	Monte	1
2341	Monte Bello	25
300	Monte Castro	3
216	Monte Chingolo	2
217	Monte Grande	2
96	Monte Hermoso	1
1390	Monte Nievas	12
2060	Monte Obscuridad	22
2241	Monte Quemado	23
1157	Monte Redondo	9
2061	Monte Vera	22
2342	Monteagudo	25
1513	Montecarlo	15
2062	Montefiore	22
2343	Monteros	25
1311	Monterrico	11
2063	Montes de Oca	22
1158	Montoya	9
219	Mor�n	2
218	Moreno	2
742	Morrison	7
743	Morteros	7
744	Mte. Buey	7
952	Mte. Caseros	8
745	Mte. Cristo	7
746	Mte. De Los Gauchos	7
747	Mte. Le�a	7
748	Mte. Ma�z	7
749	Mte. Ralo	7
1642	Mtro. Ramos Mexia	17
220	Mu�iz	2
1159	Mulas Grandes	9
97	Munro	1
2064	Murphy	22
351	Mutqu�n	4
302	N��ez	3
1643	Nahuel Niyeu	17
417	Napenay	5
2066	Nar�	22
1792	Naschel	20
1644	Naupa Huen	17
98	Navarro	1
1793	Navia	20
1709	Nazareno	18
99	Necochea	1
2067	Nelson	22
2068	Nicanor E. Molinas	22
750	Nicol�s Bruzone	7
751	Noetinger	7
1794	Nogol�	20
1161	Nogoy�	9
752	Nono	7
753	Nueva 7	7
1162	Nueva Escocia	9
2242	Nueva Esperanza	23
2243	Nueva Francia	23
1795	Nueva Galia	20
301	Nueva Pompeya	3
1163	Nueva Vizcaya	9
953	Nueve de Julio	8
1514	Nueve de Julio	15
1740	Nueve de Julio	19
2069	Nuevo Torino	22
1515	Ober�	15
754	Obispo Trejo	7
1569	Octavio Pico	16
1646	Ojos de Agua	17
755	Olaeta	7
100	Olavarr�a	1
1516	Olegario V. Andrade	15
756	Oliva	7
757	Olivares San Nicol�s	7
2070	Oliveros	22
221	Olivos	2
1164	Omb�	9
758	Onagolty	7
759	Oncativo	7
1710	Or�n	18
760	Ordo�ez	7
1165	Oro Verde	9
2075	P�rez	22
222	Pablo Nogu�s	2
223	Pablo Podest�	2
761	Pacheco De Melo	7
352	Pacl�n	4
2344	Padre Monti	25
2071	Palacios	22
303	Palermo	3
1312	Palma Sola	11
954	Palmar Grande	8
2244	Palo Negro	23
1268	Palo Santo	10
1313	Palpal�	11
418	Pampa Almir�n	5
1314	Pampa Blanca	11
2245	Pampa de Los Guanacos	23
419	Pampa del Indio	5
420	Pampa del Infierno	5
2345	Pampa Mayo	25
762	Pampayasta N.	7
763	Pampayasta S.	7
1315	Pampichuela	11
764	Panaholma	7
1517	Panamb�	15
1796	Papagayos	20
955	Parada Pucheta	8
1166	Paran�	9
1391	Parera	12
304	Parque Avellaneda	3
305	Parque Chacabuco	3
306	Parque Chas	3
307	Parque Patricios	3
101	Partido de la Costa	1
1167	Pasaje Guayaquil	9
1168	Pasaje Las Tunas	9
765	Pascanas	7
766	Pasco	7
1570	Paso Aguerre	16
1647	Paso de Agua	17
1169	Paso de La Arena	9
1170	Paso de La Laguna	9
956	Paso de La Patria	8
1171	Paso de Las Piedras	9
471	Paso de los Indios	6
957	Paso de Los Libres	8
767	Paso del Durazno	7
224	Paso del Rey	2
472	Paso del Sapo	6
1172	Paso Duarte	9
1648	Paso Flores	17
1797	Paso Grande	20
768	Paso Viejo	7
1173	Pastor Britos	9
2072	Pav�n	22
2073	Pav�n Arriba	22
1711	Payogasta	18
421	Pdcia. de La Plaza	5
422	Pdcia. Roca	5
423	Pdcia. Roque S�enz Pe�a	5
1649	Pe�as Blancas	17
1174	Pedernal	9
2074	Pedro G�mez Cello	22
958	Pedro R. Fernandez	8
102	Pehuaj�	1
103	Pellegrini	1
1392	Per�	12
1175	Perdices	9
225	Pereyra	2
104	Pergamino	1
1316	Perico	11
1829	Perito Moreno	21
959	Perugorr�a	8
2076	Peyrano	22
226	Pi�eiro	2
2079	Pi�ero	22
2077	Piamonte	22
1571	Pic�n Leuf�	16
1176	Picada Ber�n	9
1712	Pichanal	18
1650	Pichi Mahuida	17
1393	Pichi-Huinca	12
1830	Pico Truncado	21
1572	Piedra del Aguila	16
1177	Piedras Blancas	9
105	Pig��	1
106	Pila	1
107	Pilar	1
769	Pilar	7
2078	Pilar	22
1651	Pilcaniyeu	17
1573	Pilo Lil	16
108	Pinamar	1
109	Pinar del Sol	1
770	Pinc�n	7
2246	Pinto	23
771	Piquill�n	7
1269	Piran�	10
227	Pl�tanos	2
2080	Plaza Clucellas	22
772	Plaza de Mercedes	7
1574	Plaza Huincul	16
773	Plaza Luxardo	7
1575	Plottier	16
1741	Pocito	19
110	Polvorines	1
353	Poman	4
1652	Pomona	17
228	Pontevedra	2
774	Porte�a	7
2081	Portugalete	22
1518	Posadas	15
775	Potrero de Garay	7
1798	Potrero de Los Funes	20
2082	Pozo Borrado	22
354	Pozo de La Piedra	4
1270	Pozo del Maza	10
776	Pozo del Molle	7
2247	Pozo Hondo	23
777	Pozo Nuevo	7
1653	Prahuaniyeu	17
1178	Primer Distrito Cuchilla	9
1179	Primero de Mayo	9
1713	Prof. S. Mazza	18
1519	Profundidad	15
2083	Progreso	22
1180	Pronunciamiento	9
2084	Providencia	22
111	Pte. Per�n	1
2085	Pte. Roca	22
1833	Pto. 21	21
1181	Pto. Algarrobo	9
424	Pto. Bermejo	5
1831	Pto. Deseado	21
425	Pto. Eva Per�n	5
1182	Pto. Ibicuy	9
1520	Pto. Iguaz�	15
1521	Pto. Leoni	15
473	Pto. Madryn	6
474	Pto. Pir�mides	6
1522	Pto. Piray	15
1523	Pto. Rico	15
1832	Pto. San Juli�n	21
112	Pu�n	1
2086	Pueblo Andino	22
1183	Pueblo Brugo	9
1184	Pueblo Cazes	9
2087	Pueblo Esther	22
1185	Pueblo Gral. Belgrano	9
2088	Pueblo Gral. San Mart�n	22
2089	Pueblo Irigoyen	22
778	Pueblo Italiano	7
960	Pueblo Libertador	8
1186	Pueblo Liebig	9
2090	Pueblo Marini	22
2091	Pueblo Mu�oz	22
2092	Pueblo Uranga	22
1395	Puel�n	12
1394	Puelches	12
426	Puero Tirol	5
355	Puerta de Corral	4
356	Puerta San Jos�	4
308	Puerto Madero	3
427	Puerto Vilelas	5
1187	Puerto Yeru�	9
779	Puesto de Castro	7
1317	Puesto del Marqu�s	11
1318	Puesto Viejo	11
2093	Pujato	22
2094	Pujato N.	22
1319	Pumahuasi	11
780	Punta del Agua	7
1188	Punta del Monte	9
113	Punta Indio	1
1320	Purmamarca	11
1189	Quebracho	9
781	Quebracho Herrado	7
1396	Quehue	12
1397	Quem� Quem�	12
1398	Quetrequ�n	12
1576	Quili Malal	16
782	Quilino	7
229	Quilmes	2
2346	Quilmes	25
2248	Quimil�	23
1799	Quines	20
1190	Quinto Distrito	9
428	Quitilipi	5
788	R�o Bamba	7
789	R�o Ceballos	7
1655	R�o Chico	17
2349	R�o Chico	25
1656	R�o Colorado	17
2350	R�o Colorado	25
790	R�o Cuarto	7
1834	R�o Cuarto	21
791	R�o de Los Sauces	7
1835	R�o Gallegos	21
2270	R�o Grande	24
477	R�o Mayo	6
478	R�o Pico	6
1714	R�o Piedras	18
792	R�o Primero	7
2351	R�o Seco	25
793	R�o Segundo	7
794	R�o Tercero	7
1836	R�o Turbio	21
2347	Raco	25
475	Rada Tilly	6
230	Rafael Calzada	2
231	Rafael Castillo	2
783	Rafael Garc�a	7
2095	Rafaela	22
1191	Raices Oeste	9
1577	Ram�n Castro	16
961	Ramada Paso	8
114	Ramallo	1
2096	Ramay�n	22
2097	Ramona	22
232	Ramos Mej�a	2
2348	Ranchillos	25
1399	Rancul	12
233	Ranelagh	2
784	Ranqueles	7
115	Rauch	1
476	Rawson	6
1742	Rawson	19
785	Rayo Cortado	7
2249	Real Sayana	23
1400	Realic�	12
309	Recoleta	3
2098	Reconquista	22
357	Recreo	4
2099	Recreo	22
786	Reducci�n	7
1401	Relmo	12
234	Remedios de Escalada	2
1800	Renca	20
429	Resistencia	5
310	Retiro	3
1271	Riacho He-He	10
962	Riachuelo	8
2100	Ricardone	22
787	Rinc�n	7
1578	Rinc�n de Los Sauces	16
1192	Rinc�n de Nogoy�	9
1193	Rinc�n del Cinto	9
1194	Rinc�n del Doll	9
1195	Rinc�n del Gato	9
1654	Rinc�n Treneta	17
1321	Rinconada	11
116	Rivadavia	1
1453	Rivadavia	14
1743	Rivadavia	19
2101	Rivadavia	22
1715	Rivadavia Banda Norte	18
1716	Rivadavia Banda Sur	18
1657	Roca	17
1196	Rocamora	9
1322	Rodeitos	11
117	Rojas	1
1402	Rol�n	12
2102	Rold�n	22
2103	Romang	22
118	Roque P�rez	1
795	Rosales	7
2104	Rosario	22
1717	Rosario de La Frontera	18
1718	Rosario de Lerma	18
1323	Rosario de R�o Grande	11
796	Rosario del Saladillo	7
1197	Rosario del Tala	9
1434	Rosario Penaloza	13
1403	Rucanelo	12
2105	Rueda	22
2106	Rufino	22
1524	Ruiz de Montoya	15
2352	Rumi Punco	25
358	S.F.V de 4	4
235	S�enz Pe�a	2
430	S�enz Pe�a	5
2107	Sa Pereira	22
119	Saavedra	1
311	Saavedra	3
797	Sacanta	7
2250	Sachayoj	23
1719	Saclant�s	18
798	Sagrada Familia	7
2108	Saguier	22
799	Saira	7
963	Saladas	8
2109	Saladero M. Cabal	22
120	Saladillo	1
800	Saladillo	7
1801	Saladillo	20
801	Sald�n	7
121	Salliquel�	1
802	Salsacate	7
803	Salsipuedes	7
122	Salto	1
2110	Salto Grande	22
804	Sampacho	7
431	Samuh�	5
805	San Agust�n	7
2111	San Agust�n	22
2353	San Andr�s	25
123	San Andr�s de Giles	1
964	San Antonio	8
1324	San Antonio	11
1525	San Antonio	15
1721	San Antonio	18
124	San Antonio de Areco	1
806	San Antonio de Arredondo	7
807	San Antonio de Lit�n	7
2112	San Antonio de Obligado	22
125	San Antonio de Padua	1
236	San Antonio de Padua	2
1658	San Antonio Oeste	17
808	San Basilio	7
1198	San Benito	9
126	San Bernardo	1
432	San Bernardo	5
2113	San Bernardo (N.J.)	22
2114	San Bernardo (S.J.)	22
1435	San Blas de Los Sauces	13
965	San Carlos	8
1454	San Carlos	14
1722	San Carlos	18
2115	San Carlos Centro	22
809	San Carlos Minas	7
2116	San Carlos N.	22
2117	San Carlos S.	22
127	San Cayetano	1
1199	San Cipriano	9
810	San Clemente	7
128	San Clemente del Tuy�	1
966	San Cosme	8
312	San Crist�bal	3
2118	San Crist�bal	22
2119	San Eduardo	22
1200	San Ernesto	9
811	San Esteban	7
2120	San Eugenio	22
2121	San Fabi�n	22
2122	San Fco. de Santa F�	22
2354	San Felipe	25
237	San Fernando	2
359	San Fernando	4
360	San Fernando del Valle	4
812	San Francisco	7
1325	San Francisco	11
1802	San Francisco	20
238	San Francisco Solano	2
2123	San Genaro	22
2124	San Genaro N.	22
1803	San Ger�nimo	20
2125	San Gregorio	22
2126	San Guillermo	22
1201	San Gustavo	9
1272	San Hilario	10
813	San Ignacio	7
1526	San Ignacio	15
2355	San Ignacio	25
239	San Isidro	2
1202	San Jaime	9
814	San Javier	7
1527	San Javier	15
1659	San Javier	17
2127	San Javier	22
2356	San Javier	25
815	San Jer�nimo	7
2128	San Jer�nimo del Sauce	22
2129	San Jer�nimo N.	22
2130	San Jer�nimo S.	22
816	San Joaqu�n	7
2131	San Jorge	22
240	San Jos�	2
361	San Jos�	4
1203	San Jos�	9
1528	San Jos�	15
2357	San Jos�	25
1204	San Jos� de Feliciano	9
817	San Jos� de La Dormida	7
2132	San Jos� de La Esquina	22
818	San Jos� de Las Salinas	7
1723	San Jos� De Met�n	18
2133	San Jos� del Rinc�n	22
241	San Justo	2
1205	San Justo	9
2134	San Justo	22
819	San Lorenzo	7
967	San Lorenzo	8
2135	San Lorenzo	22
1206	San Marcial	9
820	San Marcos Sierras	7
821	San Marcos Sud	7
2136	San Mariano	22
242	San Mart�n	2
1455	San Mart�n	14
1529	San Mart�n	15
1745	San Mart�n	19
1804	San Mart�n	20
2137	San Mart�n de Las Escobas	22
1579	San Mart�n de Los Andes	16
1273	San Mart�n II	10
2138	San Mart�n N.	22
243	San Miguel	2
969	San Miguel	8
2358	San Miguel de 25	25
129	San Nicol�s	1
313	San Nicol�s	3
1805	San Pablo	20
1580	San Patricio del Cha�ar	16
130	San Pedro	1
822	San Pedro	7
1207	San Pedro	9
1326	San Pedro	11
1530	San Pedro	15
2359	San Pedro	25
2360	San Pedro de Colalao	25
2251	San Pedro de Guasay�n	23
823	San Pedro N.	7
1327	San Rafael	11
1456	San Rafael	14
1209	San Ram�n	9
1724	San Ram�n	18
1208	San Ram�rez	9
824	San Roque	7
970	San Roque	8
1210	San Roque	9
1211	San Salvador	9
1328	San Salvador	11
314	San Telmo	3
1212	San V�ctor	9
131	San Vicente	1
825	San Vicente	7
1531	San Vicente	15
2139	San Vicente	22
1436	Sanagasta	13
2140	Sancti Spititu	22
2141	Sanford	22
971	Santa Ana	8
1213	Santa Ana	9
1329	Santa Ana	11
1214	Santa Anita	9
826	Santa Catalina	7
1330	Santa Catalina	11
1331	Santa Clara	11
827	Santa Elena	7
1215	Santa Elena	9
828	Santa Eufemia	7
972	Santa Luc�a	8
1216	Santa Luc�a	9
1746	Santa Luc�a	19
1217	Santa Luisa	9
362	Santa Mar�a	4
829	Santa Maria	7
363	Santa Rosa	4
1806	Santa Rosa de Conlara	20
2361	Santa Rosa de Leales	25
433	Santa Sylvina	5
132	Santa Teresita	1
1725	Santa Victoria E.	18
1726	Santa Victoria O.	18
1532	Santiago De Liniers	15
2142	Santo Domingo	22
1533	Santo Pipo	15
973	Santo Tom�	8
2143	Santo Tom�	22
1581	Santo Tom�s	16
244	Santos Lugares	2
2144	Santurce	22
1404	Sarah	12
245	Sarand�	2
2145	Sargento Cabral	22
479	Sarmiento	6
830	Sarmiento	7
1747	Sarmiento	19
2146	Sarmiento	22
2147	Sastre	22
831	Saturnino M.Laspiur	7
974	Sauce	8
832	Sauce Arriba	7
1218	Sauce de Luna	9
1219	Sauce Montrull	9
1220	Sauce Pinto	9
1221	Sauce Sur	9
2148	Sauce Viejo	22
364	Saujil	4
1582	Sauzal Bonito	16
833	Sebasti�n Elcano	7
834	Seeber	7
1222	Segu�	9
835	Segunda Usina	7
2252	Selva	23
1583	Senillosa	16
2149	Serodino	22
836	Serrano	7
837	Serrezuela	7
838	Sgo. Temple	7
2362	Sgto. Moya	25
1660	Sierra Colorada	17
1661	Sierra Grande	17
1662	Sierra Pailem�n	17
2363	Siete de Abril	25
1274	Siete Palmas	10
2150	Silva	22
839	Silvio Pellico	7
840	Simbolar	7
2364	Simoca	25
841	Sinsacate	7
1223	Sir Leonard	9
2253	Sol de Julio	23
2365	Soldado Maldonado	25
2151	Soldini	22
2152	Soledad	22
1224	Sosa	9
246	Sourigues	2
2153	Soutomayor	22
1405	Speluzzi	12
1534	Sta. Ana	15
2366	Sta. Ana	25
2154	Sta. Clara de Buena Vista	22
2155	Sta. Clara de Saguier	22
2367	Sta. Cruz	25
1406	Sta. Isabel	12
2156	Sta. Isabel	22
2368	Sta. Luc�a	25
1535	Sta. Mar�a	15
2159	Sta. Mar�a N.	22
2157	Sta. Margarita	22
2158	Sta. Maria Centro	22
1407	Sta. Rosa	12
1457	Sta. Rosa	14
2160	Sta. Rosa	22
842	Sta. Rosa de Calamuchita	7
843	Sta. Rosa de R�o Primero	7
1408	Sta. Teresa	12
2161	Sta. Teresa	22
2162	Suardi	22
1275	Subteniente Per�n	10
844	Suco	7
133	Suipacha	1
2254	Sumampa	23
2163	Sunchales	22
2255	Suncho Corral	23
2164	Susana	22
1332	Susques	11
852	T�o Pujio	7
975	Tabay	8
2256	Taboada	23
1225	Tabossi	9
434	Taco Pozo	5
2369	Taco Ralo	25
2165	Tacuarend�	22
2166	Tacural	22
2370	Taf� del Valle	25
2371	Taf� Viejo	25
845	Tala Ca�ada	7
846	Tala Huasi	7
847	Talaini	7
1807	Talita	20
848	Tancacha	7
134	Tandil	1
849	Tanti	7
135	Tapalqu�	1
976	Tapebicu�	8
2372	Tapia	25
247	Tapiales	2
365	Tapso	4
2257	Tapso	23
1584	Taquimil�n	16
1727	Tartagal	18
2167	Tartagal	22
977	Tatacua	8
480	Tecka	6
1409	Tel�n	12
481	Telsen	6
248	Temperley	2
2373	Teniente Berdina	25
2168	Teodelina	22
2258	Termas de Rio Hondo	23
1226	Tezanos Pinto	9
2169	Theobald	22
850	Ticino	7
249	Tigre	2
1333	Tilcara	11
1808	Tilisarao	20
2170	Timb�es	22
851	Tinoco	7
366	Tinogasta	4
2259	Tintina	23
1410	Toay	12
2171	Toba	22
1728	Tolar Grande	18
853	Toledo	7
2271	Tolhuin	24
1411	Tomas M. de Anchorena	12
2260	Tomas Young	23
136	Tordillo	1
137	Tornquist	1
854	Toro Pujio	7
2172	Tortugas	22
250	Tortuguitas	2
855	Tosno	7
856	Tosquita	7
2173	Tostado	22
2174	Totoras	22
857	Tr�nsito	7
2175	Traill	22
2374	Trancas	25
482	Trelew	6
1412	Trenel	12
138	Trenque Lauquen	1
1536	Tres Capones	15
1334	Tres Cruces	11
435	Tres Isletas	5
1837	Tres Lagos	21
1276	Tres Lagunas	10
139	Tres Lomas	1
483	Trevelin	6
1585	Tricao Malal	16
251	Trist�n Su�rez	2
252	Trujui	2
858	Tuclame	7
1335	Tumbaya	11
1458	Tunuy�n	14
1459	Tupungato	14
253	Turdera	2
859	Tutti	7
1227	Ubajay	9
860	Ucacha	7
1748	Ullum	19
1413	Unanue	12
1809	Uni�n	20
861	Unquillo	7
1228	Urdinarrain	9
1414	Uriburu	12
1729	Urundel	18
2272	Ushuaia	24
315	V�lez S�rsfield	3
864	V�lez Sarfield	7
1663	Valcheta	17
254	Valent�n Alsina	2
1664	Valle Azul	17
862	Valle de Anisacate	7
1749	Valle F�rtil	19
1336	Valle Grande	11
863	Valle Hermoso	7
367	Valle Viejo	4
1730	Vaqueros	18
1586	Varvarco	16
1229	Veinte de Septiembre	9
1415	Veinticinco de Mayo	12
1537	Veinticinco de Mayo	15
1750	Veinticinco de Mayo	19
484	Veintiocho de Julio	6
1838	Veintiocho De Noviembre	21
2176	Venado Tuerto	22
2177	Vera	22
2178	Vera y Pintado	22
316	Versalles	3
1416	Vertiz	12
1230	Viale	9
865	Viamonte	7
255	Vicente L�pez	2
1231	Victoria	9
1417	Victorica	12
866	Vicu�a Mackenna	7
2179	Videla	22
1665	Viedma	17
2180	Vila	22
2261	Vilelas	23
436	Villa �ngela	5
906	Villa 21	7
256	Villa Adelina	2
867	Villa Allende	7
868	Villa Amancay	7
2181	Villa Amelia	22
2182	Villa Ana	22
869	Villa Ascasubi	7
2262	Villa Atamisqui	23
257	Villa Ballester	2
2375	Villa Belgrano	25
2376	Villa Benjam�n Araoz	25
437	Villa Berthet	5
258	Villa Bosch	2
2183	Villa Ca�as	22
870	Villa Candelaria N.	7
259	Villa Caraza	2
871	Villa Carlos Paz	7
260	Villa Celina	2
261	Villa Centenario	2
872	Villa Cerro Azul	7
2377	Villa Chiligasta	25
873	Villa Ciudad de Am�rica	7
874	Villa Ciudad Pque Los Reartes	7
1232	Villa Clara	9
875	Villa Concepci�n del T�o	7
2184	Villa Constituci�n	22
317	Villa Crespo	3
1587	Villa Cur� Leuvu	16
876	Villa Cura Brochero	7
1810	Villa de La Quebrada	20
877	Villa de Las Rosas	7
2378	Villa de Leales	25
878	Villa de Mar�a	7
262	Villa de Mayo	2
879	Villa de Pocho	7
1811	Villa de Praga	20
880	Villa de Soto	7
1812	Villa del Carmen	20
881	Villa del Dique	7
1588	Villa del Nahueve	16
318	Villa del Parque	3
882	Villa del Prado	7
1589	Villa del Puente Pic�n Leuv�	16
883	Villa del Rosario	7
1233	Villa del Rosario	9
884	Villa del Totoral	7
319	Villa Devoto	3
263	Villa Diamante	2
885	Villa Dolores	7
1234	Villa Dom�nguez	9
264	Villa Dom�nico	2
1277	Villa Dos Trece	10
886	Villa El Chancay	7
1590	Villa El Choc�n	16
887	Villa Elisa	7
1235	Villa Elisa	9
2185	Villa Elo�sa	22
1278	Villa Escolar	10
265	Villa Espa�a	2
266	Villa Fiorito	2
888	Villa Flor Serrana	7
889	Villa Fontana	7
1236	Villa Fontana	9
1237	Villa Gdor. Etchevehere	9
2186	Villa Gdor. G�lvez	22
140	Villa Gesell	1
890	Villa Giardino	7
891	Villa Gral. Belgrano	7
1279	Villa Gral. G�emes	10
320	Villa Gral. Mitre	3
1813	Villa Gral. Roca	20
267	Villa Guillermina	2
2187	Villa Guillermina	22
892	Villa Gutierrez	7
893	Villa Huidobro	7
268	Villa Insuperable	2
269	Villa Jos� Le�n Su�rez	2
1591	Villa La Angostura	16
894	Villa La Bolsa	7
270	Villa La Florida	2
2263	Villa La Punta	23
1814	Villa Larca	20
1666	Villa Llanqu�n	17
895	Villa Los Aromos	7
896	Villa Los Patos	7
321	Villa Lugano	3
322	Villa Luro	3
271	Villa Luzuriaga	2
1238	Villa Mantero	9
897	Villa Mar�a	7
272	Villa Martelli	2
1667	Villa Mascardi	17
1815	Villa Mercedes	20
2188	Villa Minetti	22
1418	Villa Mirasol	12
2189	Villa Mugueta	22
898	Villa Nueva	7
1460	Villa Nueva	14
273	Villa Obrera	2
2190	Villa Ocampo	22
2264	Villa Ojo de Agua	23
323	Villa Ort�zar	3
1239	Villa Paranacito	9
1592	Villa Pehuenia	16
899	Villa Pque. Santa Ana	7
900	Villa Pque. Siquiman	7
274	Villa Progreso	2
324	Villa Pueyrred�n	3
901	Villa Quillinzo	7
2379	Villa Quinteros	25
438	Villa R. Bermejito	5
2265	Villa R�o Hondo	23
275	Villa Raffo	2
325	Villa Real	3
1668	Villa Regina	17
326	Villa Riachuelo	3
902	Villa Rossi	7
903	Villa Rumipal	7
2266	Villa Salavina	23
904	Villa San Esteban	7
905	Villa San Isidro	7
2191	Villa San Jos�	22
1731	Villa San Lorenzo	18
327	Villa Santa Rita	3
2192	Villa Saralegui	22
276	Villa Sarmiento	2
907	Villa Sarmiento (G.R)	7
908	Villa Sarmiento (S.A)	7
328	Villa Soldati	3
277	Villa Tesei	2
1593	Villa Traful	16
2193	Villa Trinidad	22
909	Villa Tulumba	7
278	Villa Udaondo	2
2267	Villa Uni�n	23
329	Villa Urquiza	3
1240	Villa Urquiza	9
910	Villa Valeria	7
368	Villa Vil	4
911	Villa Yacanto	7
2194	Villada	22
1241	Villaguay	9
141	Villarino	1
2268	Vilmer	23
1337	Vinalito	11
1437	Vinchina	13
978	Virasoro	8
2195	Virginia	22
279	Virrey del Pino	2
1594	Vista Alegre	16
1338	Volc�n	11
1242	Walter Moss	9
1538	Wanda	15
912	Washington	7
2269	Weisburd	23
913	Wenceslao Escalante	7
2196	Wheelwright	22
280	Wilde	2
281	William Morris	2
1419	Winifreda	12
2380	Y�nima	25
1243	Yacar�	9
1339	Yala	11
1669	Yaminu�	17
979	Yapey�	8
980	Yatait� Calle	8
1340	Yav�	11
914	Ycho Cruz Sierras	7
2381	Yerba Buena	25
2382	Yerba Buena (S)	25
1244	Yeso Oeste	9
1341	Yuto	11
142	Z�rate	1
1816	Zanjitas	20
1595	Zapala	16
2197	Zavalla	22
2198	Zen�n Pereira	22
1751	Zonda	19
\.


--
-- Name: localidad_idloc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('localidad_idloc_seq', 1, false);


--
-- Data for Name: oficial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY oficial (dni, idservicio, iddepto, idrango, fecha_ingreso, nroplaca, nro_escritorio) FROM stdin;
261325	2	3	2	1990-08-24	84	2
284146	1	2	1	1990-08-24	110	1
383290	3	4	3	1990-08-24	69	3
\.


--
-- Data for Name: participa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY participa (idcaso, personadni) FROM stdin;
4	383290
1	29709907
2	1728642
3	1728642
1	284146
2	261325
3	261325
4	261325
5	350881
6	385023
5	1728642
\.


--
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY persona (dni, fecha_nac, nombre, apellido, tipo, id_ubicacion) FROM stdin;
228099	1990-08-24	JAMES	LINDA	0	94
238767	1980-10-10	JOHN	BARBARA	0	48
261325	1930-01-01	MARY	ROBERT	1	84
284146	1999-12-05	MICHAEL	THOMAS	1	110
320560	1999-12-05	ROBERT	RICHARD	0	3
350881	1999-12-05	DAVID	MICHAEL	0	72
383290	1987-01-26	WILLIAM	JOHN	1	69
385023	1987-01-26	RICHARD	CHRISTOPHER	0	72
396245	1987-01-26	CHARLES	DANIEL	0	8
1728642	1965-03-19	JULIO CESAR	GERVASIONI	0	1696
29709907	1965-07-10	CECILIA	RUZ	0	767
\.


--
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY provincia (idprov, nom_prov) FROM stdin;
1	Buenos Aires
2	Buenos Aires-GBA
3	Capital Federal
4	Catamarca
5	Chaco
6	Chubut
7	Córdoba
8	Corrientes
9	Entre Ríos
10	Formosa
11	Jujuy
12	La Pampa
13	La Rioja
14	Mendoza
15	Misiones
16	Neuquén
17	Río Negro
18	Salta
19	San Juan
20	San Luis
21	Santa Cruz
22	Santa Fe
23	Santiago del Estero
24	Tierra del Fuego
25	Tucumán
\.


--
-- Name: provincia_idprov_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('provincia_idprov_seq', 1, false);


--
-- Data for Name: rango; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rango (idrango, nombre_rango) FROM stdin;
10	Agente
1	Ayudante
11	Cabo
12	Cabo 1ª
6	Comisario
9	Comisario General
7	Comisario Inspector
8	Comisario Mayor
3	Inspector
4	Principal
13	Sargento
14	Sargento 1ª
5	Subcomisario
2	Subinspector
16	Suboficial Auxiliar
15	Suboficial Escribiente
17	Suboficial Mayor
\.


--
-- Name: rango_idrango_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rango_idrango_seq', 1, false);


--
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rol (idrol, nombre_rol) FROM stdin;
1	Autor
2	Cómplice
3	Encubridor
8	Investigador
6	Perito
5	Sospechoso
4	Testigo
7	Víctima
\.


--
-- Name: rol_idrol_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rol_idrol_seq', 1, false);


--
-- Data for Name: servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY servicio (idservicio, nombre_servicio) FROM stdin;
52	Abogado
78	Actor
103	Administrador De Empresas
134	Adoquinero
91	Agrónomo
104	Albanil
75	Antropólogo
34	Apuntador
74	Arqueólogo
53	Arquitecto
76	Artista
72	Astronauta
60	Astrónomo
114	Azulajero
98	Bailarín De Ballet
96	Barítono
6	Barrendero
7	Basurero
37	Bicicletero
59	Biólogo
33	Boletero
48	Camarera
61	Cardiólogo
1	Carpintero
112	Cerrajero
26	Chofer
4	Cocinero
18	Colchonero
27	Colectivero
11	Confitero
136	Conserje
102	Contador
99	Coreógrafo
40	Corrector
17	Cortinero
42	Costurera
87	Dietista
100	Director De Cine
80	Director De Orquesta
115	Disenador Decorador Alfombrero
121	Electricidad Instalaciones
15	Electricista
23	Encuadernador
77	Escultor
50	Estampadora
58	Farmacéutico
68	Fiscal
73	FíSico
9	Frutero
120	Gas
21	Gasista
71	Geógrafo
90	Geólogo
101	Gerente
89	Gimnasta
12	Guarda
24	Guardavidas
43	Heladero
14	Herrero
32	Hojalatero
30	Iluminador
41	Imprentero
54	Ingeniero
129	Instalador Aire Acondicionado
127	Instalador Gabinetes
124	Instalador Internet
128	Instalador Jacuzi O Tina De Masajes
126	Instalador Seguridad
123	Instalador Sonido
125	Instalador Tv Media
119	Integral Cocinas
133	Irrigador Instalaciones
13	Jardinero
67	Juez
36	Kiosquero
118	Lamparero
22	Lavaplatos
83	Locutor
57	Maestro
28	Maquinista
29	MecáNico
51	Médico
45	Mesero
47	Modista
46	Mucama
122	Mudanzas
117	Mueblero
81	Músico
49	Niñera
88	Nutricionista
85	Oculista
84	Orfebre
86	Otorrinolaringólogo
130	Paisajista Jardinero
2	Panadero
70	Patólogo
66	Pediatra
31	Peluquero
82	Periodista
3	Pescador
93	Pianista
69	Piloto De Avión
110	Pintor
44	Pizzero
20	Plomero
63	Podólogo
39	Portero
56	Profesor
55	Químico
8	Quintero
64	Radiólogo
111	Resanador Yeso
79	Secretaria Ejecutiva
137	Seguridad
138	Servicio Limpieza
97	Soprano
5	Tallador
35	Taquillero
16	Techista
25	Telefonista
95	Tenor
92	Topógrafo
65	Traumatólogo
113	Tubero
19	Vendedor
10	Verdulero
62	Veterinario
38	Viajante
109	Vidriero
94	Violinista
\.


--
-- Name: servicio_idservicio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('servicio_idservicio_seq', 1, false);


--
-- Data for Name: telefono; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY telefono (nro, tipo) FROM stdin;
40856658	1
40862577	1
41182126	1
41468852	0
41687696	0
41850971	0
42296068	0
42395657	1
42473746	0
42524635	0
42585432	1
42614796	1
42948752	1
43039264	0
43069571	1
43189222	1
43260728	0
43772024	1
43782351	0
43816651	0
43920108	0
43951130	1
43995984	0
44112341	0
44123112	0
44182229	1
44742021	0
45367866	1
45390523	1
46246450	1
46252450	1
46265828	0
46444795	0
46599394	0
46902172	0
46938671	1
47063131	0
47117350	1
47161501	1
47167762	0
47186199	0
47431491	1
47534715	1
47638477	1
47754647	1
48091336	1
48241425	1
48299712	0
48433312	0
48498499	1
48719486	1
48860802	0
49218363	1
49248588	0
49287383	0
49956647	1
50070198	0
50205155	0
50401602	0
50587539	0
50673814	1
50958687	0
51411577	1
51732010	0
51732669	1
51737998	1
51884640	0
51891399	1
52192670	0
52294199	0
52672805	0
52705237	1
52712494	0
52985419	1
53231674	0
53277392	0
53415407	1
53722064	0
54285529	0
54326842	1
54836547	0
55238627	1
55445294	1
56024430	0
56708441	1
56857355	0
56869990	1
56892483	0
57336404	1
57522294	1
57585168	0
57622348	1
57855253	1
58414403	1
58789809	1
58941748	1
59149698	1
59927168	0
59952490	0
59992033	1
\.


--
-- Data for Name: telefono_departamental; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY telefono_departamental (nro, iddepto) FROM stdin;
43069571	1
43951130	1
47534715	1
51737998	1
45367866	2
51732669	2
57855253	2
59149698	2
40862577	3
42614796	3
47754647	3
53415407	3
47638477	4
48241425	4
52705237	4
46938671	5
48498499	5
58789809	5
45390523	6
48719486	6
49218363	6
43189222	7
49956647	7
52985419	7
42585432	8
56708441	8
57522294	8
55238627	9
56869990	9
58941748	9
44182229	10
47431491	10
51411577	10
47117350	11
50673814	11
57622348	11
40856658	12
43772024	12
48091336	12
46252450	13
47161501	13
54326842	13
42395657	14
51891399	14
58414403	14
41182126	15
46246450	15
55445294	15
42948752	16
57336404	16
59992033	16
\.


--
-- Data for Name: telefono_personal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY telefono_personal (nro, personadni) FROM stdin;
41468852	238767
41687696	261325
41850971	228099
42296068	396245
42473746	396245
42524635	320560
43039264	238767
43260728	320560
43782351	284146
43816651	320560
43920108	350881
43995984	261325
44112341	385023
44123112	284146
44742021	396245
46265828	261325
46444795	261325
46599394	385023
46902172	261325
47063131	350881
47167762	228099
47186199	284146
48299712	228099
48433312	396245
48860802	350881
49248588	261325
49287383	284146
50070198	228099
50205155	383290
50401602	284146
50587539	383290
50958687	396245
51732010	238767
51884640	350881
52192670	385023
52294199	228099
52672805	238767
52712494	238767
53231674	383290
53277392	385023
53722064	385023
54285529	238767
54836547	320560
56024430	228099
56857355	383290
56892483	350881
57585168	383290
59927168	284146
59952490	320560
\.


--
-- Data for Name: testimonio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY testimonio (idtest, personadni, idcaso, oficialdni, texto, hora_test, fecha_test) FROM stdin;
1	1728642	2	261325	Yo creo que fue Mauro Cherubini el que pinto los slogans del ISIS en el baño del tercer piso de Exactas.	01:57:51	2016-09-17
2	29709907	1	284146	Yo lo vi a Mauro Cherubini robarse los proyectores de los laboratorios de computación de Exactas.	02:02:05	2016-09-17
3	396245	10	284146	No me parece.	05:22:15	2016-03-13
4	396245	9	284146	Que se yo.	02:54:01	2016-01-11
5	396245	9	284146	Que es la mente?.	04:12:45	2016-08-12
\.


--
-- Name: testimonio_idtest_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('testimonio_idtest_seq', 1, false);


--
-- Data for Name: ubicacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ubicacion (id_lugar, idcalle, nro_calle, idloc, idprov) FROM stdin;
310	1	5953	279	1
1587	1	11433	805	2
1694	2	2237	631	5
626	2	3876	2191	4
922	2	5926	664	1
1083	2	7444	1932	4
719	2	8061	1780	6
45	2	13097	1579	1
767	3	4788	1013	6
1259	3	11380	224	1
1807	3	14238	1006	1
126	4	494	1055	2
975	4	626	439	2
573	4	1113	2154	1
144	4	4551	343	4
933	5	3883	582	1
1073	5	5266	1646	1
1127	5	7485	602	2
526	6	5380	22	6
1340	6	11968	770	1
1018	7	228	920	1
330	7	12540	218	2
1266	7	12680	1112	2
1409	8	8269	1465	1
1449	9	7707	1351	7
1741	10	2393	999	6
285	10	6206	1644	1
1594	11	292	2030	1
434	11	2096	1713	1
1428	11	3020	2337	1
1482	11	5678	1932	6
613	11	11030	1500	1
736	11	13025	2219	1
1843	11	13483	913	1
904	12	4206	731	5
1621	12	4308	746	4
249	12	10586	600	1
1906	12	11688	1566	1
1775	12	12833	1500	1
920	13	962	1906	8
797	13	1006	2052	1
738	13	2374	905	1
1031	14	7853	295	1
830	14	8911	58	2
1935	14	10357	1498	8
1046	15	1940	2144	2
67	15	3706	1856	5
1220	15	8950	208	2
48	15	10598	830	1
1534	16	5216	1269	7
1079	16	6312	114	2
264	16	6362	1917	1
1785	16	8662	726	1
1074	16	9256	2337	9
1777	16	9762	453	1
794	16	10033	1010	6
1759	16	13212	920	1
79	16	13212	2288	1
1881	16	13237	1590	1
1176	16	14980	762	8
169	17	774	101	2
1720	17	2730	682	2
1939	17	9947	2164	1
484	17	10607	1434	1
496	17	11405	2093	1
1531	17	12441	823	7
1953	17	13013	383	7
1862	18	1583	665	1
1551	18	4726	901	3
792	18	7770	782	3
1601	18	8389	770	2
539	18	12062	1593	1
232	18	14890	1234	2
351	19	1498	1110	1
200	19	1559	2347	1
489	19	5026	165	1
1712	19	10502	1048	5
1849	19	13031	97	5
1008	20	12598	1610	6
82	21	7650	1208	3
186	22	857	807	2
1350	22	10677	1989	1
943	23	9063	2117	2
203	23	13441	721	1
837	23	14479	2035	8
181	24	557	1325	1
1886	24	2466	785	2
1432	24	7490	246	1
138	24	7533	779	2
395	24	8090	481	7
953	25	3121	149	2
945	25	3929	2230	1
1497	25	5783	2265	2
1630	25	5902	41	6
1940	25	12980	588	2
873	25	14108	2084	1
1608	25	14946	216	1
828	26	570	296	3
361	26	2039	989	1
999	26	6133	77	1
1854	26	6153	1728	4
1399	26	12316	492	2
1667	26	12997	1302	3
762	27	1570	2029	2
647	27	1757	2085	6
1468	27	2136	887	9
237	27	3767	1518	1
1272	27	14238	1465	9
1248	28	5946	2301	1
595	28	14065	1470	1
1696	29	365	206	1
1321	29	2153	2272	2
1718	29	10441	349	4
245	29	10550	664	1
353	29	11966	788	2
537	29	13958	1583	9
1184	30	1650	255	1
1306	30	3527	667	2
523	30	11735	1613	4
44	30	13502	314	2
1383	31	526	1609	1
1599	31	2601	1867	1
293	31	9203	1961	2
950	31	12269	823	1
1286	31	13865	614	5
1	32	5498	753	2
1742	32	9391	2237	1
57	33	2302	855	4
397	33	5995	1530	1
800	34	8511	167	2
1530	35	3858	214	1
1572	35	5857	1519	9
1281	35	10133	1821	9
1098	35	11968	1140	4
757	36	1095	1980	3
896	36	3591	419	1
337	37	397	188	1
1335	37	11749	1490	1
1347	38	571	1568	1
283	38	11680	1506	3
1973	38	13490	1922	8
1988	39	617	1115	3
1690	39	3073	1093	1
160	39	7303	821	1
545	39	7785	2260	5
222	40	146	2309	8
1048	40	2158	380	2
925	40	4369	791	1
764	40	8135	769	6
1754	40	12471	2160	1
1332	40	12576	143	1
557	41	4209	1274	4
431	42	12755	642	1
511	42	14594	380	2
148	43	8848	2199	1
1274	44	1841	207	1
1730	44	5602	1885	2
744	45	2611	1740	1
69	46	288	820	2
1065	46	789	834	1
1329	46	2493	548	8
1378	46	3870	2302	3
729	46	13548	2252	2
1334	47	3011	412	1
1305	47	8850	1532	1
979	47	10604	1232	1
300	47	11106	1787	2
1238	48	2271	1291	7
499	48	6919	1964	2
877	48	14645	457	4
1051	49	7764	973	6
24	49	8508	419	2
103	49	13703	1982	1
42	50	13458	505	9
1964	51	3419	586	6
401	51	10143	1304	1
887	52	7878	2197	1
1113	52	8542	1481	2
201	52	13502	801	7
508	53	2935	1298	5
1514	53	3925	64	9
1273	54	690	1779	1
607	54	1909	469	3
458	54	5249	1730	1
339	54	6060	2328	1
1969	54	8050	506	2
86	56	1389	621	3
29	56	8703	2035	1
37	56	11319	329	2
1475	57	4383	1571	2
1897	57	4749	1689	1
19	57	6411	1138	2
1677	57	11881	1629	2
803	58	12072	440	4
1910	58	14520	1303	1
65	59	1847	1693	1
204	59	2717	975	2
1875	59	8147	915	1
1855	59	10952	1403	9
380	59	11198	263	3
442	59	12637	2171	6
568	59	14132	1317	2
528	59	14187	653	2
560	59	14486	34	2
304	60	2384	949	6
1894	60	4829	2003	1
799	60	7819	1417	2
517	60	7820	273	9
1444	60	11996	1322	8
701	61	534	1403	2
583	61	1951	1142	6
95	61	5427	2204	3
1934	61	6670	1490	4
1901	61	9037	1876	1
1898	61	11727	1847	6
1585	61	12940	300	7
1556	61	14395	1184	1
745	62	502	2087	2
170	62	1541	591	2
592	62	3221	179	8
673	62	12438	1004	1
966	63	3360	1851	7
590	63	3678	463	2
849	63	4975	754	1
1794	63	14386	1864	1
820	64	2051	843	2
1507	64	14394	97	1
370	65	4915	2261	2
1256	65	5080	625	6
1821	65	10296	968	1
1064	65	11343	1900	1
1155	65	14564	185	1
269	66	3197	1826	1
899	66	10483	1673	3
1607	66	11051	555	5
1892	66	12934	2009	4
1024	67	555	2377	2
688	67	2836	1367	1
437	67	10231	712	1
642	67	11381	2173	1
971	67	12697	1350	4
1037	68	11074	2345	9
1926	68	13190	776	9
780	69	6080	369	1
1951	69	6169	254	1
755	70	1186	555	2
1319	70	2615	151	8
89	70	6665	870	6
55	70	6985	1943	9
785	70	12036	92	1
765	70	12364	984	6
1212	71	4755	1762	7
651	71	10992	1540	8
1381	71	13110	646	8
908	72	2009	1403	1
1282	72	4678	282	5
1298	72	11428	164	1
831	72	11515	732	4
121	72	12741	295	7
1549	73	2242	2362	4
657	73	8184	1140	1
1979	73	9244	1401	1
1827	73	14339	1189	3
59	74	5620	691	9
968	74	14999	561	1
1709	76	9849	1331	2
475	76	10977	364	2
872	76	14552	2139	2
692	77	476	1607	9
492	77	4005	519	7
1196	77	4305	526	2
1606	78	14308	2169	1
1739	79	61	720	4
1600	79	1430	58	7
1125	79	2332	2236	2
1876	79	4007	1182	1
1290	79	5281	719	1
1750	79	10828	1978	1
586	79	12909	1119	1
532	79	14116	2004	7
110	80	4275	62	1
1792	80	6935	33	1
1996	80	10719	846	2
650	81	5219	375	1
1355	81	9506	2197	2
216	81	13107	474	1
1471	82	961	546	1
150	82	1266	989	2
474	82	5404	883	3
1687	82	6498	799	1
383	82	13396	2365	1
1221	83	2265	1061	1
911	83	5270	2195	1
231	83	7786	2109	7
835	83	7938	115	1
466	84	4005	737	6
1264	84	13943	2250	1
1314	85	6425	2017	5
1013	85	9144	1821	2
1942	85	11814	1779	2
546	85	12880	1323	8
436	86	3538	941	7
796	87	1266	2006	8
1878	87	5174	862	6
858	87	11181	994	1
40	87	14011	674	3
1386	88	14197	780	6
33	89	10198	159	2
1776	89	11384	188	8
1961	89	12642	1261	3
1199	89	13320	1669	6
391	90	304	1638	2
705	90	4431	27	4
1343	90	4642	710	6
996	90	9848	1670	7
628	90	11764	570	1
1077	91	3998	585	2
1418	91	8953	1709	8
1243	91	12383	719	6
965	91	13552	1334	2
93	92	2416	1129	2
392	92	12178	2307	6
842	92	13409	855	1
1441	93	1393	1612	1
71	93	1770	2033	1
1443	93	3491	2146	1
1016	93	5002	2023	1
3	93	7822	1979	1
1991	93	9610	482	1
1251	93	11999	1301	3
1143	94	581	1197	4
1324	94	2657	541	1
833	94	8425	1387	1
843	95	139	1750	8
1452	95	526	2002	2
1744	95	5729	1721	4
487	95	11147	322	1
389	96	8328	361	1
947	96	12573	407	1
1774	97	4261	686	8
39	97	8784	2255	1
985	98	53	64	2
682	98	1915	743	1
1735	98	13564	650	9
1339	99	1110	127	1
525	99	2669	370	2
1944	99	11075	536	6
344	100	7718	1835	6
1905	101	2484	266	1
155	101	9650	2302	2
303	101	11397	301	1
510	102	703	1026	2
81	102	7407	1598	1
1022	102	9886	464	2
865	103	5930	418	7
1078	103	9801	1785	5
735	103	11099	671	5
30	103	13750	2123	1
1671	104	669	1065	8
346	104	2351	1511	1
108	104	4842	1140	9
720	104	12439	758	2
1511	104	12900	2055	8
1927	104	13024	164	1
202	105	4426	2219	2
1543	105	4511	1058	1
940	105	5850	1310	1
1727	105	6095	1579	1
1278	105	6519	969	1
20	105	7504	531	7
404	105	11599	2037	1
1287	105	13842	2232	1
900	107	5521	514	4
1501	107	8510	303	3
174	107	13940	1595	1
256	108	6486	1284	6
281	109	11898	1530	1
1296	110	3772	300	1
889	110	4905	638	1
564	110	11062	2137	9
444	111	5294	859	1
1571	111	8478	643	5
1039	111	9505	225	2
1280	111	9671	1323	1
77	112	4492	1484	1
1569	112	8808	1857	1
1030	113	2949	1254	2
901	113	7192	838	3
1119	115	949	1831	1
493	115	2237	1844	3
1226	115	7195	639	6
1081	116	2194	1277	1
1435	116	9077	258	1
419	117	1040	1743	1
1615	117	6965	2058	6
894	117	8180	1496	4
725	117	12124	179	2
1498	118	95	427	2
878	118	686	2113	1
1994	118	3546	366	4
1903	118	5945	1294	1
1356	118	14031	1925	4
1249	119	1381	2206	2
164	119	5371	1434	1
594	120	560	2106	3
10	120	8439	2249	1
1834	120	11140	811	2
348	120	11295	1249	4
142	120	14737	1631	1
1167	121	4787	1682	4
1893	121	9708	597	1
120	121	11976	2145	2
1402	122	526	476	1
1930	122	10756	554	1
1721	122	14260	603	1
1110	123	1119	439	7
1476	123	8655	1114	2
1803	123	11720	537	9
1142	123	12342	1396	5
612	123	14324	1536	1
681	124	6291	28	1
668	124	9686	447	2
1767	124	11036	288	2
58	124	12889	1549	1
1322	124	14565	200	8
791	125	4640	2072	1
529	125	4968	509	1
1604	125	9410	1893	6
390	126	1728	114	4
314	126	5842	670	2
1419	126	11703	2155	1
501	127	10347	1863	1
296	127	11415	153	1
1217	128	1583	387	2
928	128	8587	1119	6
394	128	12320	1076	3
839	129	317	387	1
1275	129	2553	1641	2
1487	129	3995	2134	2
1257	129	6619	1700	2
1205	129	9186	502	8
1656	129	13985	2310	1
1936	130	5043	955	2
712	130	9811	1727	2
760	130	10327	737	2
473	131	1156	226	9
937	131	6734	362	1
1000	131	10969	1196	1
697	131	11398	1843	8
1365	131	11950	797	1
1637	132	1223	1802	8
1909	132	4958	1799	1
1766	132	7677	219	5
808	132	7853	2041	1
1526	132	8907	1298	1
1240	132	10515	1242	5
490	133	3475	225	1
608	133	10595	999	2
1805	133	12614	2019	5
1219	133	13097	640	3
8	134	344	1941	1
954	134	6016	2323	6
1666	134	6400	1794	7
1636	134	10650	464	9
759	134	11039	1064	2
241	134	11744	1984	9
143	135	2230	1389	7
1360	135	4750	1115	1
1598	135	14566	221	2
1918	136	1301	970	7
1169	136	9688	760	2
848	138	8822	2167	1
1678	138	11059	80	2
1612	138	14515	1944	2
1111	139	4316	632	4
1366	139	5750	896	8
1535	139	11191	1627	1
993	140	1950	51	7
465	140	6281	146	1
1005	140	7011	1142	1
1490	140	10149	2066	1
958	141	1478	223	9
860	141	1496	1127	1
379	141	5678	1816	1
939	141	11869	1639	1
278	141	13111	497	1
1401	142	924	1465	8
1557	142	2876	696	2
1407	142	3822	1751	1
443	142	9915	291	1
963	142	11516	151	2
1584	143	4754	1032	2
1813	143	13344	629	1
942	144	5826	1551	6
603	144	8360	2358	3
1931	144	9176	279	1
1455	144	9192	1207	1
1279	144	11046	90	2
1899	145	395	307	5
984	145	5633	382	1
680	145	6660	1941	7
1470	145	9438	347	1
2	145	9519	2012	2
1945	145	12370	616	1
944	145	14746	1467	1
252	146	2406	370	5
36	146	3763	957	1
827	146	6828	871	1
1235	146	12145	1154	2
1222	148	8309	984	2
711	148	9046	1660	1
1582	148	11519	1090	3
1326	149	3006	2377	7
786	149	6301	1949	1
1859	149	12597	1943	7
619	149	14114	2261	7
1591	149	14697	158	6
345	150	461	2374	1
596	150	1137	722	4
43	150	2884	373	7
113	150	5776	837	2
1362	150	7184	1167	2
446	150	7294	988	6
1764	150	13189	514	1
78	150	14965	1624	8
921	151	6066	2238	7
631	151	7331	747	1
406	151	8125	422	2
217	151	11323	259	5
1707	152	12981	2320	1
1657	153	3255	2104	1
1186	153	4319	1225	1
1524	153	4709	1062	1
912	153	9877	580	2
165	153	9888	937	2
892	154	704	1804	2
1173	154	6041	62	7
893	154	11999	1416	1
1575	154	13785	996	1
1019	154	14011	61	3
601	155	2458	2090	1
520	155	4251	1215	2
1540	155	6206	1124	1
1136	155	10918	1069	1
382	155	14957	1789	1
687	156	1361	1941	3
277	156	11306	1962	6
1812	157	173	1056	1
1202	157	13486	94	1
1440	158	14965	1477	1
620	159	11973	115	1
1808	159	13911	1308	1
1999	160	10591	347	4
811	161	2484	1253	2
1882	162	630	1381	1
753	162	1630	1839	1
1427	162	6677	599	2
1162	162	8435	297	1
1102	163	101	742	1
163	163	9801	922	2
1639	163	12142	1026	4
225	164	2715	1850	9
481	164	5607	2074	1
273	164	8538	146	1
286	164	10086	55	1
75	164	11650	999	3
1354	165	821	259	1
1203	165	1335	1628	1
275	165	3748	1760	2
211	165	4378	849	2
182	165	8929	2021	2
776	165	9354	2243	1
761	165	12873	1451	5
261	166	1083	876	1
813	166	1532	973	3
627	166	2019	1828	2
9	166	3702	1164	9
1561	166	6518	343	4
480	166	9049	624	1
352	166	13497	586	1
686	167	283	613	9
1472	167	10932	1314	7
784	167	13608	1378	1
805	168	507	933	1
1188	168	6077	735	3
136	168	9872	1389	1
844	168	10679	458	1
1209	168	14021	7	2
1120	169	4012	441	2
1613	169	4788	293	1
1004	169	5440	725	8
1425	169	10310	1356	4
188	170	6339	2351	1
1997	170	9500	893	1
1970	170	12499	1585	1
938	171	40	1817	2
1626	171	8714	2048	1
1020	172	1712	1592	4
1815	172	8872	287	8
1145	172	9102	952	1
1529	173	5160	1132	2
319	174	7856	467	5
1307	175	3112	1942	8
1385	175	6089	373	1
962	176	19	1571	1
561	176	2484	86	2
1233	176	8464	2068	2
1763	177	1525	1639	1
1592	177	3080	65	1
1458	177	4195	968	1
670	177	11902	866	1
1867	177	12523	742	1
1144	177	13994	1088	2
11	177	14202	920	1
1695	178	1798	1148	2
1208	178	3697	855	1
903	178	4158	2002	5
1364	178	5033	2062	1
549	179	239	262	2
1263	179	1328	696	3
1108	179	5499	1109	5
244	179	6193	1594	1
1789	179	7832	1200	2
926	179	11856	2280	9
417	180	2366	1875	1
1692	180	4097	83	9
552	180	11867	997	2
180	180	13519	1021	8
902	181	68	352	2
187	181	1877	1024	2
821	181	4136	1973	4
977	181	12364	1664	2
1675	181	14452	1810	1
1040	182	4234	107	6
1760	182	8393	2306	5
1400	182	9351	2010	9
454	183	5908	2292	1
1055	183	7903	1915	1
14	183	11603	2043	1
737	183	13001	1403	1
1140	184	14536	1464	1
1132	185	4894	228	2
1683	185	11183	1072	7
662	185	13323	579	1
1370	185	13498	947	1
829	186	1075	901	1
506	186	1946	1778	9
1333	186	7008	2351	1
1084	186	13698	2091	1
1924	187	1139	1808	2
1474	187	7317	1719	1
691	188	8658	1844	2
1106	188	14911	1844	1
961	189	12090	108	2
812	189	14112	1799	1
1708	189	14542	2011	4
372	190	2276	1707	6
1921	190	3102	308	7
73	190	5067	2229	1
101	190	7122	1010	5
289	190	11552	1828	1
923	190	11841	2026	1
1797	191	10447	25	1
563	191	11214	1391	1
223	192	601	15	2
381	192	5450	793	2
1937	192	6008	1058	5
1363	193	3736	405	1
1231	193	3826	855	2
429	193	3963	2324	1
941	193	14448	755	2
1001	193	14779	2339	1
1236	193	14864	1706	2
1485	194	3409	1558	1
512	194	4124	33	8
1090	195	6396	2018	1
1580	195	6489	883	1
468	197	2321	801	6
1558	197	3186	546	2
284	197	3688	458	7
282	197	4251	543	1
461	197	9577	21	1
1622	197	11036	741	1
1141	197	13382	83	1
841	198	1076	14	1
1519	198	10811	2275	9
1089	198	12172	1925	1
1150	199	1132	1223	2
1860	199	3876	1905	1
988	199	5547	1343	9
214	199	5892	717	8
505	200	10004	280	1
1374	200	11713	1811	1
806	200	13866	1285	7
427	201	2380	1116	1
507	201	6487	1454	1
402	201	7225	154	1
1439	201	7357	1815	2
1372	201	7514	2104	1
1496	202	7395	786	2
238	202	8195	1213	1
1819	202	11575	1917	4
1105	203	6559	2149	1
622	204	1296	1308	1
306	204	10510	946	7
133	205	99	1744	1
1643	206	1173	132	6
772	206	1436	449	1
1126	206	9236	154	1
547	207	2792	287	1
677	207	5236	817	1
857	207	8285	681	2
1553	208	3815	1877	1
1229	208	4163	2050	1
722	209	6496	1989	1
880	209	7833	1000	9
1879	210	3340	823	1
1929	210	4278	2247	1
410	210	8807	2323	1
724	210	10503	163	1
1258	210	10525	1979	6
1795	211	10688	1889	2
734	213	655	816	6
177	213	1961	1973	2
1737	213	6271	712	1
328	214	968	1650	1
1516	214	5697	220	1
666	214	9775	2028	4
210	214	9946	1940	7
315	215	1098	1630	2
358	215	2030	1129	9
336	215	10985	2209	1
1422	216	8738	9	1
1874	216	11762	2081	1
883	216	14928	505	1
1631	217	2853	1220	1
62	217	2994	2089	1
60	217	8094	416	1
974	217	10913	802	2
1299	217	12821	647	1
884	217	13230	769	1
96	217	13561	50	8
221	217	14049	1653	5
1489	218	472	869	2
387	218	1075	1409	1
702	218	4987	133	3
802	218	7701	1557	2
258	218	13834	456	1
1772	219	3081	1386	8
64	219	6931	1175	1
416	219	8028	389	8
1277	219	8718	446	4
1451	219	9620	2088	9
1509	219	11757	756	1
1617	219	13981	1727	1
565	219	14326	1295	1
710	220	3339	1416	4
542	220	7159	960	7
13	220	11535	816	2
362	220	13703	1673	1
1768	220	14864	2191	5
571	221	11841	2318	1
80	221	14361	1455	1
1602	222	7930	101	4
398	223	9392	1914	1
854	223	12600	884	1
257	224	9094	318	1
959	224	11415	1366	5
1779	224	12368	225	1
1309	225	139	1790	2
1865	225	1164	20	1
1717	225	1265	1412	2
1699	225	11031	2130	1
1858	226	5094	418	1
414	226	7719	506	6
1159	226	11093	2232	7
671	226	11627	2064	1
1288	227	9491	1880	6
1510	228	2096	68	2
1495	228	2359	342	5
569	229	12218	883	3
1982	230	2069	1256	3
1454	230	10669	1288	9
1703	230	14664	537	1
1986	231	3321	1902	1
479	231	7549	2106	2
726	232	1679	1494	1
585	232	3845	1669	9
70	232	12589	209	1
1576	232	14762	1992	8
1241	233	4696	496	3
550	233	6494	244	1
1128	233	7599	473	1
1539	233	8225	1048	2
1710	233	9641	832	1
486	233	10799	98	2
1520	233	13404	485	3
667	233	14685	2117	7
1861	234	2860	919	4
1884	234	8720	453	2
1638	234	10061	1142	1
1974	234	11620	2361	8
1662	234	12586	1953	2
173	235	5839	684	6
168	235	7161	772	5
1541	235	9448	339	8
1224	236	3433	182	1
867	236	4647	552	5
1054	236	5680	1216	1
1038	236	11858	463	5
242	238	812	1366	5
709	238	6380	1615	7
105	238	12966	1430	1
1648	239	1789	1039	1
318	239	8265	1154	1
1732	240	2016	670	1
1954	240	3266	1123	1
448	240	7866	66	9
1787	240	10468	2211	2
656	240	11359	232	1
112	240	13003	717	9
405	240	13961	2304	9
1548	240	14058	1990	1
1247	241	8155	304	1
500	242	1515	1971	6
1387	242	9445	1980	1
313	243	1007	1092	1
935	243	10967	2333	1
292	243	12467	792	9
268	243	13127	1864	2
1134	244	2656	1403	1
1494	244	11388	1618	6
690	244	12526	674	8
1684	245	3547	527	8
758	245	5264	985	2
1303	245	6512	990	9
1163	245	7513	670	2
425	245	8225	325	1
1672	245	8826	1416	1
1702	245	9829	1885	1
1028	246	3091	1725	7
1512	246	4759	124	3
430	246	7015	1313	2
853	246	9843	988	9
1380	246	11667	2002	1
1888	246	12635	929	6
1291	246	13743	1878	8
1609	247	497	1865	1
145	247	8529	778	2
68	247	12606	1044	1
949	247	13886	692	1
26	248	5727	1720	1
645	248	9805	2015	8
700	248	10222	937	1
271	248	10952	1447	1
1012	249	947	68	2
1104	249	11126	2141	1
463	249	12370	1315	4
1852	250	8416	1660	7
1641	250	8819	1486	1
1148	250	8902	261	6
1151	250	13292	239	1
263	251	2331	1417	9
1747	251	6878	1316	1
1338	251	8009	1272	1
1830	251	12573	385	2
1784	252	4655	367	3
845	252	7609	35	3
1095	253	10155	2092	9
1398	253	14156	1973	2
246	254	150	1993	1
1325	254	4206	159	1
1096	254	12383	1013	1
1124	255	796	1465	7
1152	255	2223	1097	2
462	255	7942	1519	7
1640	256	897	1101	2
1147	256	7595	1705	9
305	256	11809	274	6
1183	256	14830	237	1
553	257	1312	1279	2
1581	257	8091	1704	1
774	258	14700	957	1
1565	259	9172	700	2
1063	259	9719	818	8
359	259	9733	2339	5
1469	259	13360	397	1
1661	260	2248	2371	1
516	260	7203	339	1
1620	260	9928	1490	5
728	260	12746	943	1
714	261	9078	1521	2
1053	262	4038	1290	7
782	262	13347	2354	2
1043	263	4907	1471	7
1560	263	7781	1584	2
123	263	12251	462	1
1896	264	749	1081	4
1135	264	3658	466	1
1880	265	3681	1399	1
978	265	4385	1589	1
1337	265	4552	255	8
1200	265	5446	1770	4
1853	266	6114	423	6
6	266	7555	2184	2
1114	266	9609	819	9
814	267	8772	723	2
1137	268	7576	1433	1
635	268	10727	1992	5
472	268	13581	1598	1
491	268	13853	1242	5
1941	269	3127	632	2
1087	269	7093	592	1
576	269	7248	431	9
1688	269	8159	1953	1
708	269	8697	1801	8
1464	269	10069	2354	2
850	269	13553	1393	1
1533	269	13789	2319	1
1085	270	8484	499	1
582	271	894	458	1
992	271	3075	985	1
1129	271	12960	1813	7
456	271	13666	877	1
1115	271	13766	643	6
426	272	3155	1745	1
1629	272	3985	1756	1
1809	272	14377	2091	1
224	273	8248	1832	1
248	274	2603	41	1
1933	274	10150	775	7
970	274	10903	843	1
1157	274	13259	357	9
151	274	13399	1338	1
1983	275	712	1217	1
424	275	2740	71	1
1414	275	8493	1751	6
1738	275	9539	2055	1
538	275	10271	656	1
1076	275	10537	1446	1
1417	277	410	1026	1
825	277	1582	1529	1
1395	277	1808	1340	7
524	277	2237	1712	1
1460	277	4179	1288	1
166	277	13348	1085	1
1312	278	837	2127	6
606	278	6498	1597	7
1740	278	8577	1161	1
1655	278	11267	1091	8
363	278	12536	1899	2
1178	279	652	1164	6
636	279	3004	1204	1
393	279	4110	867	6
403	279	14373	504	1
1006	280	4270	1431	1
885	280	8442	370	2
327	280	10261	2097	5
1179	280	11037	1113	1
1728	280	13023	1132	2
870	282	4503	834	2
1749	282	7115	2129	2
543	283	2550	35	2
307	283	3042	1874	2
1445	283	3340	1688	1
1824	283	9112	780	6
325	283	13809	216	8
777	284	1807	521	3
1820	284	11801	301	2
369	284	13067	1718	2
1590	284	13464	295	5
1680	285	9048	316	5
1276	285	10670	167	1
556	285	12116	589	2
1392	285	12737	1947	1
195	285	14560	533	9
51	286	3087	368	8
114	286	3736	1681	1
1479	286	10782	196	8
689	286	12618	956	1
1563	286	14047	1759	9
1060	288	7637	2269	2
1698	288	12431	442	1
562	288	14353	63	1
1658	289	2338	526	1
1817	289	6091	1176	3
929	290	13040	1068	1
1610	291	7924	624	1
239	292	231	1388	5
1823	292	4802	650	1
1436	292	8187	467	2
1316	294	123	1563	4
1092	294	4214	297	2
916	294	5867	611	1
288	294	14985	95	1
482	295	2264	73	7
570	295	4141	787	1
1094	295	6450	817	1
579	295	10988	1964	2
643	295	11964	1007	1
208	296	3937	1289	7
1550	296	5272	1444	1
433	296	6873	895	1
1413	296	8569	2041	1
790	297	3937	2134	1
197	297	4031	1498	1
1649	297	7459	356	7
661	298	11121	1611	2
1503	299	378	1066	8
1544	299	2523	210	5
1579	299	10763	602	1
713	299	13269	5	1
741	299	14635	957	1
418	300	532	1902	1
1034	300	749	676	1
1866	300	913	611	2
1619	300	6080	245	2
1300	300	7886	405	1
1492	300	12448	2349	2
1522	301	400	2106	5
1088	301	1432	1801	6
698	301	6383	1775	1
1923	301	11511	1057	7
1457	301	12052	1845	2
1856	302	1674	249	7
1871	302	3444	562	3
1904	302	4517	983	1
789	302	8399	1135	1
1806	302	9084	620	1
1872	302	9397	776	2
1804	302	11035	1782	4
1546	302	13224	720	9
1295	303	1682	168	1
35	303	12326	1175	1
342	304	14295	1875	8
1068	305	4070	338	2
609	305	8291	974	2
781	305	10005	2285	1
175	305	11161	1587	1
98	305	12789	1080	1
826	306	4461	1783	7
566	306	10664	1773	1
955	306	11145	1754	1
259	307	8004	340	1
1644	307	10261	1050	1
1992	307	11491	1235	2
234	307	12195	145	1
1907	307	13076	1321	7
1393	307	13376	1356	4
1513	308	1285	1740	1
1139	308	3052	517	5
130	308	10218	348	2
323	308	12402	581	2
1715	308	12638	839	2
1367	308	14125	1689	1
544	309	2010	1575	1
881	309	9417	2217	1
12	309	12888	375	6
1723	309	14712	664	1
693	310	1875	1365	5
1180	310	5244	1079	1
817	310	6415	1243	8
1478	310	7763	355	2
1166	310	8076	653	1
1391	310	11292	108	7
672	310	14732	1679	5
951	311	6837	1961	3
683	311	11816	2004	2
1175	311	14788	816	9
816	312	1524	1821	2
1271	312	2762	2197	2
453	312	3290	1431	1
855	312	3777	2338	1
1798	313	4133	28	2
1624	313	12290	994	4
1297	314	11729	1621	2
267	314	12450	1628	9
331	314	12461	1996	1
674	316	391	1921	1
768	316	2193	604	1
986	316	3485	522	1
1837	316	4921	240	1
1462	316	11098	1384	1
66	317	606	128	1
439	317	2748	1231	2
498	317	3786	1435	1
189	317	10419	1605	7
1762	317	10678	1962	6
1542	318	860	815	1
1841	318	6849	31	3
1213	319	7839	2356	6
1670	320	3333	511	1
253	320	4881	1095	9
1842	321	4809	1010	2
1504	321	6341	867	2
1056	322	3896	826	2
1559	322	6388	1445	7
1059	322	6552	1368	9
386	322	7732	767	8
653	322	9746	1780	1
504	323	12497	830	6
1995	323	13244	1364	2
1269	324	5380	2231	1
1781	324	9196	952	3
46	324	12918	177	1
1062	325	1333	403	2
172	325	2805	941	1
218	325	4666	26	1
554	325	8321	1865	8
1230	325	9462	283	5
116	325	13824	1487	2
97	326	14959	1203	1
540	327	4786	414	5
1705	327	5712	214	1
1984	327	6650	1489	2
1107	327	10151	1777	1
1595	327	11065	899	1
1488	328	1602	1306	2
1693	328	2902	956	4
754	328	5248	386	1
1044	328	10029	1590	9
194	328	11657	2081	6
1980	329	3609	1046	8
4	329	7074	2329	9
1711	329	7270	428	1
1421	329	8940	1703	6
152	329	14322	1057	1
742	330	7534	72	5
485	330	11773	1525	2
1244	331	59	1932	2
356	331	9352	1020	2
906	331	9470	933	1
824	331	13587	504	8
229	332	1506	1416	2
1025	332	7338	2247	1
1116	333	7920	1361	1
1405	334	4146	1445	1
1384	334	4373	986	1
1172	334	8199	1720	2
1267	335	3970	264	4
888	335	8308	1882	2
52	335	9168	1738	2
1289	335	14754	280	1
192	336	522	624	1
770	336	1514	827	1
871	336	4074	590	1
1477	337	1295	877	1
299	337	5583	1405	1
1990	337	5709	2328	1
1746	337	6727	1711	2
1411	337	9848	759	2
1447	337	10615	237	2
452	338	8539	2343	1
1525	338	9447	171	1
1093	338	14087	1054	6
119	339	7564	883	2
983	339	11043	1383	7
1552	339	11701	1533	1
41	340	4429	1889	1
1857	341	2427	2236	2
1191	341	2988	571	1
752	341	3352	2324	9
364	341	9635	295	1
1801	341	9669	1580	9
1729	341	11662	2037	6
1577	341	11937	55	9
1182	341	13412	838	4
1009	341	13956	1250	2
1685	342	7	2113	1
1724	342	8829	836	1
715	343	4558	971	8
1373	343	7356	2260	6
74	343	10023	862	1
696	343	12245	1956	8
739	344	1959	1001	5
987	344	3025	1559	2
1253	344	7091	857	7
1500	344	10508	1164	4
798	345	240	544	1
1027	345	847	1624	6
84	345	6629	358	8
932	345	9820	959	9
875	346	1039	96	4
818	346	2658	920	4
243	346	8546	1951	1
1869	346	8706	444	2
449	346	8926	68	2
322	346	11296	160	1
1790	346	13780	1204	1
909	347	6151	924	1
18	347	8354	1374	6
1430	347	13734	1412	8
1021	348	14260	666	1
851	349	2614	708	3
1957	349	5787	1689	1
637	349	6295	1647	1
1433	350	11441	328	7
1603	350	13034	1500	2
1201	351	870	1346	6
1158	351	6745	632	5
1635	351	14979	359	1
1978	352	1171	2039	8
874	352	11743	13	8
1502	352	11890	1259	2
1376	352	12088	1043	2
1778	352	13481	59	2
898	353	5796	149	2
477	353	8167	2107	1
118	354	1799	879	1
514	355	2966	1999	4
129	355	3285	1958	3
952	355	7677	1639	1
886	355	14683	1557	1
1069	356	107	34	1
1555	356	2610	1597	6
1912	356	8212	272	1
809	356	10310	114	2
866	357	1982	588	4
717	357	13801	278	1
94	358	537	2021	7
684	358	5903	2174	2
727	359	7488	1576	5
63	359	8845	1016	1
1080	359	11865	585	1
1310	360	229	1002	3
1023	360	4140	146	1
54	360	5383	1046	2
838	360	7848	1168	3
1682	360	9108	693	1
21	361	1185	538	1
721	361	3220	1288	6
1216	362	134	885	3
1547	362	1888	1868	1
807	362	6612	1920	1
743	362	9511	112	1
141	363	2965	992	1
1681	363	4768	864	7
1446	363	14542	1576	7
746	364	3560	1319	1
787	364	4270	1178	1
415	364	10084	1007	8
280	364	11049	1531	9
1206	366	3957	1566	7
1416	367	715	906	1
332	367	8552	536	2
788	367	9687	1850	1
1198	367	13122	2144	1
247	367	13933	989	1
1218	367	14572	1992	1
294	368	12170	902	1
1194	368	14756	1121	2
412	369	6281	1643	2
355	369	7547	2012	1
625	369	9300	891	1
1223	369	11907	311	2
1448	371	1390	1060	1
297	371	2446	1864	1
428	371	8000	284	2
1851	371	11921	2242	9
732	373	433	271	4
1049	373	844	813	6
593	374	4600	2285	1
1459	374	9581	421	8
1562	375	9344	1635	1
1911	375	11555	145	6
1674	376	2082	2277	1
589	376	12794	78	1
1596	376	14338	2227	1
1045	377	905	708	1
998	377	4978	918	1
1799	377	11365	205	2
104	377	12844	928	1
1499	378	5266	1143	1
450	378	5510	911	1
641	380	517	338	9
1214	380	6565	729	2
309	380	6961	1531	1
990	381	2631	1228	1
1308	381	2633	876	2
1234	381	6987	954	6
413	381	11131	1813	1
518	381	12154	723	7
936	382	1395	1840	1
1734	382	5660	197	1
763	382	14733	608	1
1047	383	2542	1733	1
1211	383	2986	2247	7
270	383	4970	1708	7
587	383	11985	1028	2
1586	383	13558	844	7
432	384	3007	226	1
1330	384	6483	1602	5
778	384	12167	912	7
1574	385	7004	455	1
1390	385	7314	492	1
1210	386	8938	237	2
840	386	11005	892	4
1371	386	11374	1814	1
652	387	11017	2034	1
1342	387	12806	793	8
1311	388	315	2271	8
109	388	7178	803	9
1453	388	8297	289	6
927	388	12005	1297	1
1958	388	13571	321	9
890	389	2121	1944	1
815	389	4025	2330	1
1845	389	9918	388	2
460	390	1964	2205	3
1007	390	6170	1385	4
1846	390	12787	1878	1
1719	391	5573	2034	2
1919	391	6341	634	1
464	391	7431	64	1
233	392	11146	236	1
1270	393	5373	2114	1
1588	393	7187	1324	1
1651	393	12725	1036	3
1673	394	2877	1870	2
31	394	4726	850	1
551	394	9530	2316	6
384	394	11651	2013	5
251	394	14930	1584	6
117	395	3946	1763	1
158	395	5785	1297	1
1733	396	460	608	3
1527	396	2551	680	9
1914	396	6800	112	1
1394	396	8727	2230	5
659	396	9866	629	2
400	397	2733	773	2
25	398	8089	1023	1
1197	398	9959	508	1
272	398	13845	512	1
1835	399	731	1342	8
509	399	2162	1677	1
1537	399	9772	463	2
1331	399	9876	2016	1
1793	399	10423	1201	8
989	399	14992	571	1
655	400	50	437	2
178	400	1547	1634	1
1828	400	2557	1832	1
440	401	2360	1229	5
1523	401	5738	160	1
530	401	10509	1519	5
1676	402	889	1826	1
266	402	7519	152	4
1010	402	14320	287	5
1847	403	8790	540	4
1989	404	676	1665	3
1361	404	2807	1110	1
1204	405	2564	1753	2
1645	405	5273	718	1
1493	405	8218	102	4
629	405	8450	1450	2
147	406	635	1318	1
527	406	13971	2162	2
1564	407	5810	2192	4
1317	408	1267	1253	6
740	408	1904	1066	4
1261	408	10181	2218	8
1628	408	11596	1743	1
92	408	13408	1278	1
1567	408	14232	1406	1
1424	409	867	1795	1
377	409	2067	806	6
846	409	4988	727	2
5	410	11988	726	1
1185	410	13592	1634	3
1971	411	1463	2342	2
515	411	4079	710	8
205	411	10450	1445	1
555	412	5653	2292	2
1840	412	6395	2311	1
1780	413	4717	1136	2
531	413	6950	1217	1
1396	413	10004	681	4
1771	414	3367	175	1
618	415	2188	2358	1
206	415	3315	653	2
190	415	5568	1435	4
1758	416	2123	2342	6
1976	417	5672	267	1
1369	417	6446	2132	1
1112	417	6821	986	2
236	417	12220	252	1
1346	418	1973	432	5
1943	418	10370	1880	5
980	419	1096	2292	5
167	419	5373	2227	9
23	419	6106	1925	2
254	419	11379	2237	1
1029	419	12506	2103	3
85	420	345	1433	1
521	420	5934	151	8
191	420	14866	956	2
639	421	265	998	1
1566	421	4949	2120	1
605	421	5729	75	1
228	421	9748	1736	9
215	421	10977	550	1
1822	421	11154	212	1
1665	422	831	1178	8
1716	422	6812	144	3
1033	422	11337	2238	4
290	423	4563	1931	9
1890	423	5515	201	8
1130	423	7699	403	7
536	423	9002	2056	9
127	423	9268	1229	1
1349	424	2575	287	1
1946	424	3652	1332	5
1826	424	10964	2148	1
455	424	11082	2149	2
716	424	13765	982	1
822	425	42	321	1
451	425	3944	1327	1
648	426	880	1349	2
948	426	2733	265	1
1118	426	3818	1668	1
1570	427	537	1546	2
1726	427	6226	1197	2
350	427	12847	465	2
1952	428	0	1366	1
634	428	5282	2158	7
1966	428	13445	64	5
756	429	2772	1068	1
1659	429	3002	1803	1
522	429	5265	550	8
131	429	12417	1296	2
1032	430	1660	152	4
1237	430	1703	2319	2
128	430	2221	1479	2
1838	430	2702	2294	1
91	430	4980	1316	2
1195	430	10529	1678	2
1972	430	10882	2000	2
140	431	13741	710	1
137	432	6440	290	1
1100	432	8587	1525	2
1250	432	14531	1730	7
1900	433	4349	1897	2
597	433	7703	202	1
1318	433	8887	1999	2
321	433	11860	566	2
90	433	13751	1072	1
1438	433	14759	2078	5
1916	434	5008	2155	1
354	434	5053	1138	1
1981	434	5665	142	1
1042	434	6964	228	1
747	434	7355	437	1
407	434	11042	2212	8
1985	434	13525	1917	9
678	435	52	1503	7
731	435	7504	1796	1
559	435	9343	144	1
366	435	10491	733	2
76	436	10258	1802	7
882	437	226	916	1
1782	437	1019	1275	7
1515	437	2702	339	3
1811	437	2817	146	5
106	437	10134	289	1
1745	437	14414	633	1
1743	438	3573	637	9
1082	438	4347	1573	2
1153	438	11468	1617	1
1262	438	11954	1122	4
679	439	2242	356	2
343	439	2961	1626	1
1181	439	7321	1951	1
124	439	10033	738	1
38	440	349	1782	1
161	440	4118	1895	1
1836	440	6338	1177	8
775	440	8501	1449	5
1642	440	12981	743	1
1232	440	13744	278	4
1156	441	922	681	7
1389	441	1404	1553	1
1783	441	8887	884	1
1925	441	10214	912	1
964	441	12335	1219	3
1480	441	13247	2164	1
154	442	2069	609	9
1174	442	6269	160	1
324	442	11517	1599	7
1814	442	14997	1807	1
910	443	2157	1019	5
972	443	4181	533	1
793	443	12581	1516	9
1450	444	457	1013	1
1431	444	2174	254	9
1473	444	4949	411	3
1863	444	9137	1470	1
1753	445	13381	1218	2
1011	445	13974	501	5
457	446	2752	2266	1
1791	446	4247	2191	1
1998	446	9268	2072	1
502	446	11376	1994	1
1465	446	11817	493	9
1397	447	380	749	7
1959	447	753	447	8
1420	447	3205	2069	2
445	447	6626	862	9
918	447	7911	475	2
801	447	8080	322	4
1653	447	10028	47	1
335	448	1506	1227	1
1486	448	3164	1510	5
423	448	4944	48	3
230	448	9652	2098	1
378	448	10145	92	2
541	448	13222	1695	4
1960	449	185	491	1
1036	449	2345	1018	1
1434	449	3722	1690	1
15	449	8180	2087	1
1207	449	10399	253	4
1802	449	11465	1393	2
122	451	3632	797	1
1344	451	4801	1580	2
135	451	8874	1888	6
478	451	11833	1864	7
1168	452	388	1399	2
311	452	1676	1406	1
183	452	6103	261	1
1177	452	9262	1673	1
914	452	12252	486	5
1268	453	999	509	2
99	453	6389	1037	9
209	453	7414	1210	1
1844	453	12320	1112	4
1071	453	12677	2182	1
1796	454	253	537	9
598	454	3060	2	5
1769	454	8676	1418	1
1663	454	10395	12	1
1189	454	11270	960	1
981	455	5309	295	1
176	455	11528	405	9
1748	455	12584	881	2
1625	455	14115	1208	1
1057	456	37	1086	2
588	456	1789	552	2
1521	456	9547	1186	7
1483	456	12307	2097	5
658	456	14350	1755	2
1160	458	8909	539	1
240	458	9255	947	1
1818	458	10322	1285	1
1761	459	2699	1842	9
967	459	9876	1964	2
1614	459	12728	478	1
1351	459	12840	1773	1
411	459	13440	2163	1
863	460	1530	305	1
1938	460	3787	1631	2
1035	460	12074	974	2
1067	461	222	1850	2
624	461	3008	71	1
1052	461	4307	752	1
1382	461	9220	659	1
749	461	12180	1682	4
235	461	14404	664	2
1456	461	14882	263	1
1323	461	14963	692	2
1975	462	2560	1367	1
111	462	5119	662	2
1138	462	8407	732	2
1246	462	11429	700	1
1654	463	1502	2133	7
1070	463	1968	2056	1
196	463	12790	1697	3
513	464	3339	1059	2
312	464	7584	1269	1
924	464	11747	799	1
102	465	6407	1971	1
1406	465	8561	1941	1
1017	465	14582	930	4
535	466	3618	2091	4
388	466	6118	633	1
1437	466	7419	1585	8
1917	466	11255	2179	1
861	466	13646	81	2
1467	467	317	877	1
1650	467	803	2200	1
396	467	5447	2281	2
139	467	5921	2042	1
1412	468	6517	2014	4
638	468	14382	1689	9
1121	469	9215	2171	1
1947	470	10988	388	1
32	471	2386	23	2
408	471	5523	521	1
1508	471	5956	2236	3
1099	471	10753	312	2
1328	471	12929	1233	7
1752	472	6217	606	1
1294	472	7768	1717	1
519	472	12100	1678	1
1491	472	13987	1490	1
1528	474	9178	1785	2
695	474	9955	1095	2
385	475	3607	341	1
1193	475	11759	340	5
646	475	12256	518	1
1123	476	9373	2294	1
326	476	13822	1893	2
1260	477	629	892	2
1765	477	11180	1946	4
212	478	9141	1210	1
17	479	6326	1594	9
876	479	10280	493	1
87	480	1778	1308	6
16	480	2471	1360	2
467	480	4972	2245	3
1632	480	11339	1265	1
1691	480	11573	1397	5
1731	481	2033	654	4
834	481	6260	398	3
1353	481	7898	1246	1
669	482	7054	2054	1
1171	483	2422	1560	1
340	483	6896	431	2
660	483	10830	2020	9
375	484	6302	1128	1
1689	484	6703	1518	1
115	484	9226	1945	1
1913	484	10798	654	1
600	484	11147	481	5
1003	484	14325	1600	9
1877	485	8532	770	2
895	485	8966	2333	9
604	486	713	90	6
1700	486	1908	1800	1
915	486	3638	152	1
1968	486	4628	2276	5
1133	486	7941	2362	2
1950	486	10987	10	2
591	487	5342	1983	3
61	487	9651	1533	1
488	488	565	2028	4
1254	488	3703	1486	1
1722	488	10847	1692	3
580	489	312	1610	1
610	489	4764	2203	1
1810	489	4864	1587	2
302	489	6672	1538	2
1751	489	7868	1958	2
1050	489	13126	508	1
438	490	572	1749	3
654	490	6467	830	1
1109	490	7395	1447	1
976	490	11712	1643	2
810	491	3124	1173	2
1977	491	4643	1831	1
1889	491	10159	2130	1
723	491	11787	1959	9
779	491	14615	391	1
171	492	5761	1143	7
7	492	8992	1092	2
308	493	662	2062	2
1097	493	13690	278	2
1618	494	1261	2262	1
1192	494	4700	1460	3
1928	494	10110	703	1
1725	494	10180	342	1
819	495	8815	2289	1
1239	495	10339	1828	8
260	495	10806	259	7
1887	496	2136	1169	9
1962	496	14486	2373	8
471	497	3527	2148	5
665	497	11262	1936	3
1664	497	11697	2271	2
193	497	14566	1685	7
615	498	1725	267	1
1164	498	4211	588	1
1583	498	10258	1004	1
1786	499	911	121	2
1117	499	2355	893	2
567	499	5760	904	2
316	499	14323	1044	8
1265	499	14560	2235	1
334	500	1308	1580	5
1345	500	12728	1651	5
1506	501	793	857	1
1963	501	12655	1820	1
769	503	3484	488	1
1686	503	6376	2365	1
207	503	6468	2086	1
707	503	14418	1373	8
730	505	1958	695	2
1669	505	3001	137	7
198	505	4610	672	8
291	505	5730	1419	1
1902	505	5800	15	8
572	505	5922	168	9
301	505	7195	618	3
495	505	9694	2041	5
1517	505	14618	1252	2
783	505	14745	27	2
771	506	4036	1164	1
262	506	5612	704	6
184	506	7662	913	3
1816	506	8547	544	1
1660	506	10697	1938	7
1283	506	13998	1155	5
83	506	14902	2169	1
1103	506	14916	746	1
832	507	1465	828	8
1800	507	7084	1998	1
991	507	12378	1769	1
1227	508	2088	467	3
1593	508	10822	1475	1
349	509	3248	1218	3
1154	509	5151	1592	7
298	509	5693	230	1
859	509	8248	432	2
159	509	8693	109	1
1041	510	7655	540	9
931	510	9836	434	8
1146	510	11453	676	9
1215	511	125	479	1
1915	511	8777	89	6
1833	511	9688	1209	3
1706	511	12776	1818	2
1864	511	13873	1790	1
1773	512	8623	650	1
602	512	14993	1031	8
1348	513	7133	2083	2
611	513	9814	828	4
1965	513	10647	1364	2
1831	513	12755	1810	1
623	514	10332	619	3
533	515	4909	1161	1
733	515	8771	683	1
1518	515	10229	2336	2
1652	515	11387	1610	1
1301	516	2933	31	1
847	516	5593	593	1
1442	516	7377	1649	1
1829	516	12043	992	1
376	516	13886	161	7
265	517	1502	2022	1
1704	517	5566	963	9
1616	517	5872	1113	2
957	517	8229	1194	5
421	517	9153	1650	1
357	517	11691	878	1
1647	517	12887	495	2
869	517	13052	770	1
1359	518	2911	43	2
1403	518	6838	484	1
973	518	7491	839	2
1568	518	8418	699	4
162	518	8449	269	2
1293	519	1935	871	1
640	519	11229	1855	1
27	519	12766	1924	1
368	519	13478	975	2
1320	520	12627	674	1
630	521	1695	1734	7
1228	521	4938	1992	1
750	521	14313	498	1
1481	522	4656	1248	2
1536	522	7952	2255	1
435	522	11788	533	5
1633	523	2220	2284	3
795	523	4439	1757	9
1379	523	6795	1216	1
1955	523	6845	461	1
1072	524	2097	1480	1
72	524	2173	225	2
34	524	5192	1441	1
836	524	7462	2195	6
1611	524	10905	226	5
1066	524	14034	2300	1
199	525	71	2019	9
1891	525	4128	503	9
1292	525	8477	723	8
250	526	1746	2238	2
621	526	2783	2059	4
1170	526	3044	1693	2
1101	526	7044	156	1
1646	527	2679	103	5
1255	527	8526	2347	6
1697	527	13242	2314	1
1868	527	13935	1118	1
317	527	14545	2234	4
574	528	2946	471	9
497	528	10572	204	4
1949	528	12733	2131	1
1086	528	13202	132	1
664	529	2048	120	5
1091	529	4260	1632	4
483	529	10697	209	1
373	529	11308	650	2
1578	529	12287	545	1
1589	529	13362	281	1
1956	530	2433	9	1
255	530	7879	1276	2
329	530	12045	2209	1
494	530	14909	530	5
575	531	2043	1528	1
1284	531	11714	388	3
868	532	7011	1105	1
1315	532	7231	311	8
47	533	1387	1374	9
864	533	3359	128	1
1713	533	5751	771	2
1377	533	6405	179	3
706	533	6517	1364	2
88	533	7567	441	2
578	534	2904	1280	1
1015	534	3318	936	2
1415	534	12511	1230	9
347	535	207	2011	1
1225	535	4363	1547	1
1429	535	5135	1136	1
1426	535	6125	133	2
274	535	9093	899	1
49	535	10998	1976	5
399	535	12582	2189	1
1701	536	3252	355	2
1410	537	5824	2162	1
676	537	11181	308	1
1026	537	11289	1694	4
862	537	14313	2035	2
852	538	439	231	2
649	538	5000	723	2
1848	538	11613	2091	1
1870	538	11671	2377	1
1122	539	4702	1472	1
220	539	8984	1654	1
185	539	11932	9	8
1061	540	9356	1654	1
1404	540	10868	1612	1
1463	541	2309	2305	5
1161	541	11542	1178	6
420	541	12672	1391	2
1967	542	1042	1872	8
409	542	5985	988	1
704	542	6132	1803	9
1895	542	11486	2186	9
28	542	14378	1232	5
1461	543	118	2334	1
766	543	5370	964	6
995	543	5501	546	6
823	543	9124	1374	2
441	543	9740	1680	6
577	543	12705	1271	1
1597	544	2648	1992	1
1850	545	2036	938	1
56	545	3124	169	1
1873	545	7052	135	1
227	545	7925	1783	1
1920	545	11073	631	2
1932	545	12733	1709	1
930	546	284	1304	1
447	546	2992	1262	1
1352	546	7424	1393	1
1770	547	6331	739	2
503	547	11618	1965	3
663	548	990	787	2
1736	548	8041	2370	8
213	548	11473	989	1
1327	548	13949	147	1
1423	549	3988	2129	9
470	550	1188	514	2
1993	550	8095	1439	1
897	550	9043	967	7
53	550	11267	7	3
1341	551	7308	1592	2
1922	551	12687	1956	1
1466	552	852	2078	1
1757	552	7886	773	8
1131	554	1478	1628	3
694	554	3869	1826	2
675	555	13188	349	6
1825	556	2138	490	1
982	556	9414	646	2
1505	556	12215	792	2
157	557	1464	816	4
134	557	5424	938	7
50	557	8678	268	2
219	557	9175	809	8
459	557	11520	120	1
156	558	2473	778	1
146	558	3140	316	2
617	558	6887	1759	5
1679	558	7830	1962	1
1573	558	10532	408	6
153	558	13023	404	8
956	559	130	1550	2
338	560	8379	1162	6
905	560	9035	168	5
891	560	13792	1879	2
773	561	14644	10	1
1242	562	4721	626	3
226	562	4761	1372	1
1002	562	7499	1580	2
1187	563	104	1213	1
1190	563	1154	858	2
107	563	5811	362	9
149	563	7020	1533	3
1302	563	10831	2155	1
1532	564	9616	292	3
856	564	11424	124	1
374	565	128	1119	6
22	565	6998	1709	1
614	566	4709	166	7
276	566	6236	56	9
1388	566	6869	1247	1
632	566	6954	475	4
1554	566	12475	1653	3
341	566	13944	554	2
132	566	13973	119	1
1285	567	3522	717	1
1313	567	13160	1674	2
371	567	14090	1824	7
1538	568	9575	239	1
997	568	12753	1658	1
367	568	13330	780	2
295	569	13346	95	1
1375	570	339	772	7
879	571	3187	1105	2
1668	571	10619	2190	6
1623	572	1339	509	8
644	572	2535	813	7
1484	572	3395	2167	1
100	572	4892	1564	2
422	572	5907	1006	2
1149	572	6118	1288	2
1336	572	10319	1851	8
1839	572	12474	1905	2
333	573	196	2313	1
1634	573	2667	1878	2
558	573	2788	979	7
1357	573	13799	1536	1
534	574	263	263	2
1714	574	1745	1318	1
1627	574	2477	1625	2
1165	574	5842	1217	1
633	574	6424	398	7
703	574	6563	993	2
1058	574	8749	401	2
287	574	11617	2167	1
599	574	14198	894	1
1408	574	14943	44	9
1358	575	563	436	6
718	575	2139	36	2
1883	575	3550	1695	1
548	575	5234	2303	1
1908	575	10682	328	1
748	575	11178	2179	1
751	576	2024	1614	1
1605	576	3504	245	1
581	576	4627	1099	1
125	576	5099	1494	1
1252	576	12253	1296	3
1788	576	14362	547	3
584	577	4817	2072	1
1304	577	4882	993	4
907	577	5164	583	2
934	578	1293	1772	1
1755	578	2103	1960	1
1885	578	5314	2085	9
279	578	8857	1195	1
960	578	11038	35	1
919	579	382	174	6
1948	579	597	793	9
804	579	1788	585	4
917	579	7372	828	1
1756	580	3644	2015	2
320	580	5682	1702	1
365	580	5994	1595	1
685	580	7626	1634	2
1245	580	11730	1552	8
1987	580	14151	1786	3
969	580	14277	643	6
\.


--
-- Name: ubicacion_id_lugar_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ubicacion_id_lugar_seq', 1, false);


--
-- Name: evento evento_idevento_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT evento_idevento_pk PRIMARY KEY (idevento);


--
-- Name: evento idx_evento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT idx_evento UNIQUE (hora_evento, fecha_evento);


--
-- Name: involucra idx_involucra; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY involucra
    ADD CONSTRAINT idx_involucra PRIMARY KEY (idcaso, personadni, idrol);


--
-- Name: participa idx_participa_0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participa
    ADD CONSTRAINT idx_participa_0 PRIMARY KEY (idcaso, personadni);


--
-- Name: calle pk_calle; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY calle
    ADD CONSTRAINT pk_calle PRIMARY KEY (idcalle);


--
-- Name: caso pk_caso; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso
    ADD CONSTRAINT pk_caso PRIMARY KEY (idcaso);


--
-- Name: caso_congelado pk_caso_congelado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso_congelado
    ADD CONSTRAINT pk_caso_congelado PRIMARY KEY (idcaso);


--
-- Name: caso_descartado pk_caso_descartado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso_descartado
    ADD CONSTRAINT pk_caso_descartado PRIMARY KEY (idcaso);


--
-- Name: caso_resuelto pk_caso_resuelto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso_resuelto
    ADD CONSTRAINT pk_caso_resuelto PRIMARY KEY (idcaso);


--
-- Name: categoria pk_categoria; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT pk_categoria PRIMARY KEY (idcat);


--
-- Name: culpable pk_culpable; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY culpable
    ADD CONSTRAINT pk_culpable PRIMARY KEY (idcaso, personadni);


--
-- Name: custodia pk_custodia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custodia
    ADD CONSTRAINT pk_custodia PRIMARY KEY (idcustodia);


--
-- Name: departamento pk_departamento; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departamento
    ADD CONSTRAINT pk_departamento PRIMARY KEY (iddepto);


--
-- Name: evidencia pk_evidencia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evidencia
    ADD CONSTRAINT pk_evidencia PRIMARY KEY (idevidencia);


--
-- Name: localidad pk_localidad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidad
    ADD CONSTRAINT pk_localidad PRIMARY KEY (idloc);


--
-- Name: oficial pk_oficial; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficial
    ADD CONSTRAINT pk_oficial PRIMARY KEY (dni);


--
-- Name: persona pk_persona; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT pk_persona PRIMARY KEY (dni);


--
-- Name: provincia pk_provincia; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT pk_provincia PRIMARY KEY (idprov);


--
-- Name: rango pk_rango; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rango
    ADD CONSTRAINT pk_rango PRIMARY KEY (idrango);


--
-- Name: rol pk_rol; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rol
    ADD CONSTRAINT pk_rol PRIMARY KEY (idrol);


--
-- Name: servicio pk_servicio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY servicio
    ADD CONSTRAINT pk_servicio PRIMARY KEY (idservicio);


--
-- Name: telefono pk_telefono; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono
    ADD CONSTRAINT pk_telefono PRIMARY KEY (nro);


--
-- Name: telefono_departamental pk_telefono_departamental; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono_departamental
    ADD CONSTRAINT pk_telefono_departamental PRIMARY KEY (nro);


--
-- Name: telefono_personal pk_telefono_personal; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono_personal
    ADD CONSTRAINT pk_telefono_personal PRIMARY KEY (nro);


--
-- Name: testimonio pk_testimonio; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testimonio
    ADD CONSTRAINT pk_testimonio PRIMARY KEY (idtest);


--
-- Name: ubicacion pk_ubicacion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ubicacion
    ADD CONSTRAINT pk_ubicacion PRIMARY KEY (id_lugar);


--
-- Name: idx_caso; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_caso ON caso USING btree (oficialprincipaldni);


--
-- Name: idx_caso_0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_caso_0 ON caso USING btree (id_categoria);


--
-- Name: idx_caso_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_caso_1 ON caso USING btree (id_ubicacion);


--
-- Name: idx_caso_resuelto; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_caso_resuelto ON caso_resuelto USING btree (oficialresueltodni);


--
-- Name: idx_culpable; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_culpable ON culpable USING btree (idcaso);


--
-- Name: idx_culpable_0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_culpable_0 ON culpable USING btree (personadni);


--
-- Name: idx_custodia; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_custodia ON custodia USING btree (idevidencia);


--
-- Name: idx_custodia_0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_custodia_0 ON custodia USING btree (oficialdni);


--
-- Name: idx_custodia_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_custodia_1 ON custodia USING btree (id_ubicacion);


--
-- Name: idx_departamento; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_departamento ON departamento USING btree (supervisor);


--
-- Name: idx_departamento_0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_departamento_0 ON departamento USING btree (id_ubicacion);


--
-- Name: idx_evento_0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_evento_0 ON evento USING btree (idcaso);


--
-- Name: idx_evento_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_evento_1 ON evento USING btree (personadni);


--
-- Name: idx_evidencia; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_evidencia ON evidencia USING btree (idcaso);


--
-- Name: idx_involucra_0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_involucra_0 ON involucra USING btree (idrol);


--
-- Name: idx_involucra_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_involucra_1 ON involucra USING btree (personadni);


--
-- Name: idx_involucra_2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_involucra_2 ON involucra USING btree (idcaso);


--
-- Name: idx_localidad; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_localidad ON localidad USING btree (idprov);


--
-- Name: idx_oficial; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_oficial ON oficial USING btree (idrango);


--
-- Name: idx_oficial_0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_oficial_0 ON oficial USING btree (idservicio);


--
-- Name: idx_oficial_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_oficial_1 ON oficial USING btree (iddepto);


--
-- Name: idx_participa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_participa ON participa USING btree (personadni);


--
-- Name: idx_participa_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_participa_1 ON participa USING btree (idcaso);


--
-- Name: idx_persona; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_persona ON persona USING btree (id_ubicacion);


--
-- Name: idx_telefono_departamental; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_telefono_departamental ON telefono_departamental USING btree (iddepto);


--
-- Name: idx_telefono_personal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_telefono_personal ON telefono_personal USING btree (personadni);


--
-- Name: idx_testimonio_0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_testimonio_0 ON testimonio USING btree (personadni);


--
-- Name: idx_testimonio_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_testimonio_1 ON testimonio USING btree (oficialdni);


--
-- Name: idx_testimonio_2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_testimonio_2 ON testimonio USING btree (idcaso);


--
-- Name: idx_ubicacion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ubicacion ON ubicacion USING btree (idloc);


--
-- Name: idx_ubicacion_0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ubicacion_0 ON ubicacion USING btree (idcalle);


--
-- Name: idx_ubicacion_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ubicacion_1 ON ubicacion USING btree (idprov);


--
-- Name: evento evento_participa_(idcaso, personadni)_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT "evento_participa_(idcaso, personadni)_fk" FOREIGN KEY (idcaso, personadni) REFERENCES participa(idcaso, personadni);


--
-- Name: calle fk_calle_localidad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY calle
    ADD CONSTRAINT fk_calle_localidad FOREIGN KEY (idloc) REFERENCES localidad(idloc) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: caso fk_caso_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso
    ADD CONSTRAINT fk_caso_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(idcat) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: caso_congelado fk_caso_congelado_caso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso_congelado
    ADD CONSTRAINT fk_caso_congelado_caso FOREIGN KEY (idcaso) REFERENCES caso(idcaso) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: caso_descartado fk_caso_descartado_caso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso_descartado
    ADD CONSTRAINT fk_caso_descartado_caso FOREIGN KEY (idcaso) REFERENCES caso(idcaso) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: caso fk_caso_oficial; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso
    ADD CONSTRAINT fk_caso_oficial FOREIGN KEY (oficialprincipaldni) REFERENCES oficial(dni) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: caso_resuelto fk_caso_resuelto_caso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso_resuelto
    ADD CONSTRAINT fk_caso_resuelto_caso FOREIGN KEY (idcaso) REFERENCES caso(idcaso) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: caso_resuelto fk_caso_resuelto_oficial; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso_resuelto
    ADD CONSTRAINT fk_caso_resuelto_oficial FOREIGN KEY (oficialresueltodni) REFERENCES oficial(dni) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: caso fk_caso_ubicacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY caso
    ADD CONSTRAINT fk_caso_ubicacion FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id_lugar) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: culpable fk_culpable_caso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY culpable
    ADD CONSTRAINT fk_culpable_caso FOREIGN KEY (idcaso) REFERENCES caso_resuelto(idcaso) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: culpable fk_culpable_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY culpable
    ADD CONSTRAINT fk_culpable_persona FOREIGN KEY (personadni) REFERENCES persona(dni) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custodia fk_custodia_evidencia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custodia
    ADD CONSTRAINT fk_custodia_evidencia FOREIGN KEY (idevidencia) REFERENCES evidencia(idevidencia) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custodia fk_custodia_oficial; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custodia
    ADD CONSTRAINT fk_custodia_oficial FOREIGN KEY (oficialdni) REFERENCES oficial(dni) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: custodia fk_custodia_ubicacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY custodia
    ADD CONSTRAINT fk_custodia_ubicacion FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id_lugar) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departamento fk_departamento_departamento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departamento
    ADD CONSTRAINT fk_departamento_departamento FOREIGN KEY (supervisor) REFERENCES departamento(iddepto) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departamento fk_departamento_ubicacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departamento
    ADD CONSTRAINT fk_departamento_ubicacion FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id_lugar) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: evidencia fk_evidencia_caso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evidencia
    ADD CONSTRAINT fk_evidencia_caso FOREIGN KEY (idcaso) REFERENCES caso(idcaso) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: involucra fk_involucra_caso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY involucra
    ADD CONSTRAINT fk_involucra_caso FOREIGN KEY (idcaso) REFERENCES caso(idcaso) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: involucra fk_involucra_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY involucra
    ADD CONSTRAINT fk_involucra_persona FOREIGN KEY (personadni) REFERENCES persona(dni) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: involucra fk_involucra_rol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY involucra
    ADD CONSTRAINT fk_involucra_rol FOREIGN KEY (idrol) REFERENCES rol(idrol) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: localidad fk_localidad_provincia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY localidad
    ADD CONSTRAINT fk_localidad_provincia FOREIGN KEY (idprov) REFERENCES provincia(idprov) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oficial fk_oficial_departamento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficial
    ADD CONSTRAINT fk_oficial_departamento FOREIGN KEY (iddepto) REFERENCES departamento(iddepto) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oficial fk_oficial_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficial
    ADD CONSTRAINT fk_oficial_persona FOREIGN KEY (dni) REFERENCES persona(dni) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oficial fk_oficial_rango; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficial
    ADD CONSTRAINT fk_oficial_rango FOREIGN KEY (idrango) REFERENCES rango(idrango) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: oficial fk_oficial_servicio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY oficial
    ADD CONSTRAINT fk_oficial_servicio FOREIGN KEY (idservicio) REFERENCES servicio(idservicio) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: participa fk_participa_caso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participa
    ADD CONSTRAINT fk_participa_caso FOREIGN KEY (idcaso) REFERENCES caso(idcaso) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: participa fk_participa_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participa
    ADD CONSTRAINT fk_participa_persona FOREIGN KEY (personadni) REFERENCES persona(dni) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: persona fk_persona_ubicacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT fk_persona_ubicacion FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(id_lugar) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: telefono_departamental fk_telefono_departamental; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono_departamental
    ADD CONSTRAINT fk_telefono_departamental FOREIGN KEY (nro) REFERENCES telefono(nro) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: telefono_departamental fk_telefono_departamental1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono_departamental
    ADD CONSTRAINT fk_telefono_departamental1 FOREIGN KEY (iddepto) REFERENCES departamento(iddepto) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: telefono_personal fk_telefono_personal_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono_personal
    ADD CONSTRAINT fk_telefono_personal_persona FOREIGN KEY (personadni) REFERENCES persona(dni) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: telefono_personal fk_telefono_personal_telefono; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY telefono_personal
    ADD CONSTRAINT fk_telefono_personal_telefono FOREIGN KEY (nro) REFERENCES telefono(nro) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: testimonio fk_testimonio_caso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testimonio
    ADD CONSTRAINT fk_testimonio_caso FOREIGN KEY (idcaso) REFERENCES caso(idcaso) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: testimonio fk_testimonio_oficial; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testimonio
    ADD CONSTRAINT fk_testimonio_oficial FOREIGN KEY (oficialdni) REFERENCES oficial(dni) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: testimonio fk_testimonio_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY testimonio
    ADD CONSTRAINT fk_testimonio_persona FOREIGN KEY (personadni) REFERENCES persona(dni) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ubicacion fk_ubicacion_calle; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ubicacion
    ADD CONSTRAINT fk_ubicacion_calle FOREIGN KEY (idcalle) REFERENCES calle(idcalle) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ubicacion fk_ubicacion_localidad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ubicacion
    ADD CONSTRAINT fk_ubicacion_localidad FOREIGN KEY (idloc) REFERENCES localidad(idloc) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ubicacion fk_ubicacion_provincia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ubicacion
    ADD CONSTRAINT fk_ubicacion_provincia FOREIGN KEY (idprov) REFERENCES provincia(idprov) ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--


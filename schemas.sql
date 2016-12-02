--1
SELECT
	p.*
FROM involucra i
INNER JOIN persona p
on i.personadni = p.dni
INNER JOIN rol r
on r.idrol = i.idrol
WHERE r.nombre_rol = 'Sospechoso';


--2
SELECT
	*
FROM persona
WHERE id_ubicacion IN (
	SELECT
		b.id_lugar
	FROM
		(
			SELECT DISTINCT
				u.id_lugar,
				i.idcaso
			FROM ubicacion u
			INNER JOIN persona p
			on p.id_ubicacion = u.id_lugar
			INNER JOIN involucra i
			on p.dni = i.personadni
			INNER JOIN rol r
			on i.idrol = r.idrol
			WHERE r.nombre_rol = 'Sospechoso'
			GROUP BY u.id_lugar, i.idcaso
		) as b
	GROUP BY b.id_lugar
	HAVING count(*) > 1
);
--3
SELECT
	*
FROM oficial o
WHERE o.dni IN (
	SELECT
		dni
	FROM oficial o
	INNER JOIN custodia cu
	on cu.oficialdni = o.dni
	INNER JOIN evidencia e
	on e.idevidencia = cu.idevidencia
	INNER JOIN caso c
	on c.idcaso = e.idcaso
	GROUP BY o.dni
	HAVING count(DISTINCT c.idcaso) > 1
);

--4
CREATE OR REPLACE FUNCTION sucesionEventos(inidcaso integer)
RETURNS TABLE( idcaso integer, personadni bigint, descripcion text, hora_evento time, fecha_evento date)
AS
$BODY$
SELECT
	e.idcaso,
	e.personadni,
	e.descripcion,
	e.hora_evento,
	e.fecha_evento
FROM evento e
WHERE e.idcaso = sucesionEventos.inidcaso
ORDER BY e.fecha_evento, e.hora_evento, e.personadni;
$BODY$
LANGUAGE sql;

--5
SELECT
    o.dni
FROM oficial o
INNER JOIN caso_resuelto cr
on cr.oficialresueltodni = o.dni
GROUP BY o.dni
HAVING count(DISTINCT cr.idcaso) IN
(
	SELECT
	    count(DISTINCT cr.idcaso) as CasosResueltos
	FROM oficial o
	INNER JOIN caso_resuelto cr
	on cr.oficialresueltodni = o.dni
	GROUP BY o.dni
	ORDER BY CasosResueltos desc
	LIMIT 1
);

--6
-- Asumimos que la ubicacion que se busca es la actual, quiere decir al ultimo lugar movido
CREATE OR REPLACE FUNCTION ubicacionesEvidencia (inidcaso integer)
RETURNS TABLE(idevidencia integer, id_lugar integer, id_calle integer, nro_calle integer, idloc integer, idprov integer, ultimo_movimiento date)
AS
$BODY$
SELECT
	cu.idevidencia,
	u.*,
	cu.ultimo_movimiento
FROM
	(
		SELECT
			e.idevidencia,
			MAX(c.fecha_custodia) as ultimo_movimiento
		FROM evidencia e
		INNER JOIN custodia c
		on c.idevidencia = e.idevidencia
		WHERE e.idcaso = ubicacionesEvidencia.inidcaso
		GROUP BY e.idevidencia
	) cu
INNER JOIN custodia c
ON cu.idevidencia = c.idevidencia AND cu.ultimo_movimiento = c.fecha_custodia
INNER JOIN ubicacion u
ON c.id_ubicacion = u.id_lugar
$BODY$
LANGUAGE sql;

--7
-- Asumimos que oficial involucrado incluye al que resolvio (si fue resuelto) y al principal
CREATE OR REPLACE FUNCTION oficialesCaso(inidcaso integer)
RETURNS TABLE(dni bigint, idservicio integer, iddepto integer, idrango integer, fecha_ingreso date, nroplaca integer, nro_escritorio integer)
AS
$BODY$
SELECT
	o.*
FROM oficial o
INNER JOIN involucra i
on o.dni = i.personadni
WHERE i.idcaso = oficialesCaso.inidcaso
UNION
SELECT
	o.*
FROM oficial o
INNER JOIN caso_resuelto cr
on o.dni = cr.oficialresueltodni
WHERE cr.idcaso = oficialesCaso.inidcaso
UNION
SELECT
	o.*
FROM oficial o
INNER JOIN caso c
on o.dni = c.oficialprincipaldni
WHERE c.idcaso = oficialesCaso.inidcaso
$BODY$
LANGUAGE sql;

--8
SELECT
	cat.idcat,
	cat.nombre_cat,
	count(c.idcaso) as CantidadCasos
FROM categoria cat
INNER JOIN caso c
on c.id_categoria = cat.idcat
GROUP BY cat.idcat, cat.nombre_cat
ORDER BY CantidadCasos DESC;


--9
CREATE OR REPLACE FUNCTION testimoniosCaso(inidcaso integer)
RETURNS TABLE(idtest integer, personadni bigint, idcaso integer, oficialdni bigint, texto varchar(250), hora_test time, fecha_test date)
AS
$BODY$
SELECT
	*
FROM testimonio t
WHERE t.idcaso = testimoniosCaso.inidcaso;
$BODY$
LANGUAGE sql;


--10a Si quieren todos los testimonios de cada caso
CREATE OR REPLACE FUNCTION testimoniosCategoria(inidcat integer)
RETURNS TABLE(idtest integer, personadni bigint, idcaso integer, oficialdni bigint, texto varchar(250), hora_test time, fecha_test date)
AS
$BODY$
SELECT
	t.*
FROM testimonio t
INNER JOIN caso c
on t.idcaso = c.idcaso
WHERE c.id_categoria = testimoniosCategoria.inidcat
ORDER BY t.idcaso;
$BODY$
LANGUAGE sql;

--10b Si quieren la cantidad de testimonios de cada caso
CREATE OR REPLACE FUNCTION testimoniosCategoriaCant(inidcat integer)
RETURNS TABLE(idcaso integer, cantidad_de_casos bigint)
AS
$BODY$
SELECT
	t.idcaso,
	count(t.idtest) as cantidad_de_casos
FROM testimonio t
INNER JOIN caso c
on t.idcaso = c.idcaso
WHERE c.id_categoria = testimoniosCategoriaCant.inidcat
GROUP BY t.idcaso
ORDER BY count(t.idtest) DESC;
$BODY$
LANGUAGE sql;

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


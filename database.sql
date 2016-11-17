CREATE TABLE calle (
  idcalle              serial  NOT NULL,
  nomcalle             varchar(50)  NOT NULL,
  CONSTRAINT pk_calle PRIMARY KEY ( idcalle )
 ) ;

CREATE TABLE categoria (
  idcat                serial  NOT NULL,
  nombre_cat           text  NOT NULL,
  CONSTRAINT pk_categoria PRIMARY KEY ( idcat )
 ) ;

CREATE TABLE provincia (
  idprov               serial  NOT NULL,
  nom_prov             varchar(50)  NOT NULL,
  CONSTRAINT pk_provincia PRIMARY KEY ( idprov )
 ) ;

CREATE TABLE rango (
  idrango              serial  NOT NULL,
  nombre_rango         varchar(50)  NOT NULL,
  CONSTRAINT pk_rango PRIMARY KEY ( idrango )
 ) ;

CREATE TABLE rol (
  idrol                serial  NOT NULL,
  nombre_rol           varchar(50)  NOT NULL,
  CONSTRAINT pk_rol PRIMARY KEY ( idrol )
 ) ;

CREATE TABLE servicio (
  idservicio           serial  NOT NULL,
  nombre_servicio      text  NOT NULL,
  CONSTRAINT pk_servicio PRIMARY KEY ( idservicio )
 ) ;

CREATE TABLE telefono (
  nro                  bigint  NOT NULL,
  tipo                 smallint DEFAULT 0 NOT NULL,
  CONSTRAINT pk_telefono PRIMARY KEY ( nro )
 ) ;

COMMENT ON COLUMN telefono.tipo IS '0 personal
1 departamental';

CREATE TABLE localidad (
  idloc                serial  NOT NULL,
  nom_loc              varchar(50)  NOT NULL,
  idprov               integer  NOT NULL,
  CONSTRAINT pk_localidad PRIMARY KEY ( idloc )
 ) ;

CREATE INDEX idx_localidad ON localidad ( idprov ) ;

CREATE TABLE ubicacion (
  id_lugar             serial  NOT NULL,
  idcalle              integer  NOT NULL,
  nro_calle            integer  NOT NULL,
  idloc                integer  NOT NULL,
  idprov               integer  NOT NULL,
  CONSTRAINT pk_ubicacion PRIMARY KEY ( id_lugar )
 ) ;

CREATE INDEX idx_ubicacion ON ubicacion ( idloc ) ;

CREATE INDEX idx_ubicacion_0 ON ubicacion ( idcalle ) ;

CREATE INDEX idx_ubicacion_1 ON ubicacion ( idprov ) ;

CREATE TABLE persona (
  dni                  bigint  NOT NULL,
  fecha_nac            date  NOT NULL,
  nombre               varchar(50)  NOT NULL,
  apellido             varchar(50)  NOT NULL,
  tipo                 smallint DEFAULT 0 NOT NULL,
  id_ubicacion         integer  NOT NULL,
  CONSTRAINT pk_persona PRIMARY KEY ( dni )
 ) ;

CREATE INDEX idx_persona ON persona ( id_ubicacion ) ;

COMMENT ON COLUMN persona.tipo IS 'Persona=0, Oficial=1';

CREATE TABLE telefono_personal (
  nro                  bigint  NOT NULL,
  personadni           bigint  NOT NULL,
  CONSTRAINT pk_telefono_personal PRIMARY KEY ( nro )
 ) ;

CREATE INDEX idx_telefono_personal ON telefono_personal ( personadni ) ;

CREATE TABLE caso (
  idcaso               serial  NOT NULL,
  descripcion          text  ,
  fecha_ingreso        date  NOT NULL,
  fecha_suceso         date  NOT NULL,
  hora_suceso          time  ,
  tipo                 smallint DEFAULT 0 ,
  oficialprincipaldni  bigint  NOT NULL,
  id_ubicacion         integer  NOT NULL,
  id_categoria         integer  NOT NULL,
  CONSTRAINT pk_caso PRIMARY KEY ( idcaso )
 ) ;

CREATE INDEX idx_caso ON caso ( oficialprincipaldni ) ;

CREATE INDEX idx_caso_0 ON caso ( id_categoria ) ;

CREATE INDEX idx_caso_1 ON caso ( id_ubicacion ) ;

COMMENT ON COLUMN caso.tipo IS 'Pendiente=0, Congelado=1, Descartado=2, Resuelto=3';

CREATE TABLE caso_congelado (
  idcaso               integer  NOT NULL,
  comentario           text  ,
  fecha_congelacion    date  NOT NULL,
  CONSTRAINT pk_caso_congelado PRIMARY KEY ( idcaso )
 ) ;

CREATE TABLE caso_descartado (
  idcaso               integer  NOT NULL,
  fecha_descarte       date  NOT NULL,
  motivacion           text  ,
  CONSTRAINT pk_caso_descartado PRIMARY KEY ( idcaso )
 ) ;

CREATE TABLE caso_resuelto (
  idcaso               integer  NOT NULL,
  desc_resolucion      text  ,
  fecha_resolucion     date  NOT NULL,
  oficialresueltodni   integer  NOT NULL,
  CONSTRAINT pk_caso_resuelto PRIMARY KEY ( idcaso )
 ) ;

CREATE INDEX idx_caso_resuelto ON caso_resuelto ( oficialresueltodni ) ;

CREATE TABLE culpable (
  idcaso               integer  NOT NULL,
  personadni           bigint  NOT NULL,
  CONSTRAINT pk_culpable PRIMARY KEY ( idcaso, personadni )
 ) ;

CREATE INDEX idx_culpable ON culpable ( idcaso ) ;

CREATE INDEX idx_culpable_0 ON culpable ( personadni ) ;

CREATE TABLE custodia (
  idcustodia           serial  NOT NULL,
  idevidencia          integer  NOT NULL,
  oficialdni           bigint  NOT NULL,
  id_ubicacion         integer  NOT NULL,
  comentario           text  ,
  fecha_custodia       date  NOT NULL,
  hora_custodia        time  ,
  CONSTRAINT pk_custodia PRIMARY KEY ( idcustodia )
 ) ;

CREATE INDEX idx_custodia ON custodia ( idevidencia ) ;

CREATE INDEX idx_custodia_0 ON custodia ( oficialdni ) ;

CREATE INDEX idx_custodia_1 ON custodia ( id_ubicacion ) ;

CREATE TABLE departamento (
  iddepto              serial  NOT NULL,
  nombre_depto         varchar(50)  NOT NULL,
  supervisor           integer  ,
  id_ubicacion         integer  NOT NULL,
  CONSTRAINT pk_departamento PRIMARY KEY ( iddepto )
 ) ;

CREATE INDEX idx_departamento ON departamento ( supervisor ) ;

CREATE INDEX idx_departamento_0 ON departamento ( id_ubicacion ) ;

CREATE TABLE evento (
  idcaso               integer  NOT NULL,
  personadni           bigint  NOT NULL,
  descripcion          text  NOT NULL,
  hora_evento          time  ,
  fecha_evento         date  NOT NULL,
  CONSTRAINT idx_evento PRIMARY KEY ( hora_evento, fecha_evento )
 ) ;

CREATE INDEX idx_evento_0 ON evento ( idcaso ) ;

CREATE INDEX idx_evento_1 ON evento ( personadni ) ;

CREATE TABLE evidencia (
  idevidencia          serial  NOT NULL,
  idcaso               integer  NOT NULL,
  fecha_sellado        date  ,
  hora_sellado         time  ,
  descripcion          text  ,
  fecha_ingreso        date  NOT NULL,
  fecha_hallazgo       date  NOT NULL,
  hora_hallazgo        time  ,
  CONSTRAINT pk_evidencia PRIMARY KEY ( idevidencia )
 ) ;

CREATE INDEX idx_evidencia ON evidencia ( idcaso ) ;

CREATE TABLE involucra (
  idcaso               integer  NOT NULL,
  personadni           bigint  NOT NULL,
  idrol                integer  NOT NULL,
  CONSTRAINT idx_involucra PRIMARY KEY ( idcaso, personadni, idrol )
 ) ;

CREATE INDEX idx_involucra_1 ON involucra ( personadni ) ;

CREATE INDEX idx_involucra_2 ON involucra ( idcaso ) ;

CREATE INDEX idx_involucra_0 ON involucra ( idrol ) ;

CREATE TABLE oficial (
  dni                  bigint  NOT NULL,
  idservicio           integer  NOT NULL,
  iddepto              integer  NOT NULL,
  idrango              integer  NOT NULL,
  fecha_ingreso        date  NOT NULL,
  nroplaca             integer  NOT NULL,
  nro_escritorio       integer  ,
  CONSTRAINT pk_oficial PRIMARY KEY ( dni )
 ) ;

CREATE INDEX idx_oficial ON oficial ( idrango ) ;

CREATE INDEX idx_oficial_0 ON oficial ( idservicio ) ;

CREATE INDEX idx_oficial_1 ON oficial ( iddepto ) ;

CREATE TABLE participa (
  idcaso               integer  NOT NULL,
  personadni           bigint  NOT NULL,
  CONSTRAINT idx_participa_0 PRIMARY KEY ( idcaso, personadni )
 ) ;

CREATE INDEX idx_participa_1 ON participa ( idcaso ) ;

CREATE INDEX idx_participa ON participa ( personadni ) ;

CREATE TABLE telefono_departamental (
  nro                  bigint  NOT NULL,
  iddepto              integer  NOT NULL,
  CONSTRAINT pk_telefono_departamental PRIMARY KEY ( nro )
 ) ;

CREATE INDEX idx_telefono_departamental ON telefono_departamental ( iddepto ) ;

CREATE TABLE testimonio (
  idtest               serial  NOT NULL,
  personadni           bigint  NOT NULL,
  idcaso               integer  NOT NULL,
  oficialdni           bigint  NOT NULL,
  texto                varchar(250)  NOT NULL,
  hora_test            time  ,
  fecha_test           date  NOT NULL,
  CONSTRAINT pk_testimonio PRIMARY KEY ( idtest )
 ) ;

CREATE INDEX idx_testimonio_0 ON testimonio ( personadni ) ;

CREATE INDEX idx_testimonio_1 ON testimonio ( oficialdni ) ;

CREATE INDEX idx_testimonio_2 ON testimonio ( idcaso ) ;

ALTER TABLE caso ADD CONSTRAINT fk_caso_oficial FOREIGN KEY ( oficialprincipaldni ) REFERENCES oficial( dni )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_caso_oficial ON caso IS '';

ALTER TABLE caso ADD CONSTRAINT fk_caso_categoria FOREIGN KEY ( id_categoria ) REFERENCES categoria( idcat )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_caso_categoria ON caso IS '';

ALTER TABLE caso ADD CONSTRAINT fk_caso_ubicacion FOREIGN KEY ( id_ubicacion ) REFERENCES ubicacion( id_lugar )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_caso_ubicacion ON caso IS '';

ALTER TABLE caso_congelado ADD CONSTRAINT fk_caso_congelado_caso FOREIGN KEY ( idcaso ) REFERENCES caso( idcaso )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_caso_congelado_caso ON caso_congelado IS '';

ALTER TABLE caso_descartado ADD CONSTRAINT fk_caso_descartado_caso FOREIGN KEY ( idcaso ) REFERENCES caso( idcaso )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_caso_descartado_caso ON caso_descartado IS '';

ALTER TABLE caso_resuelto ADD CONSTRAINT fk_caso_resuelto_caso FOREIGN KEY ( idcaso ) REFERENCES caso( idcaso )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_caso_resuelto_caso ON caso_resuelto IS '';

ALTER TABLE caso_resuelto ADD CONSTRAINT fk_caso_resuelto_oficial FOREIGN KEY ( oficialresueltodni ) REFERENCES oficial( dni )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_caso_resuelto_oficial ON caso_resuelto IS '';

ALTER TABLE culpable ADD CONSTRAINT fk_culpable_persona FOREIGN KEY ( personadni ) REFERENCES persona( dni )     DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_culpable_persona ON culpable IS '';

ALTER TABLE culpable ADD CONSTRAINT fk_culpable_caso FOREIGN KEY ( idcaso ) REFERENCES caso_resuelto( idcaso )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_culpable_caso ON culpable IS '';

ALTER TABLE custodia ADD CONSTRAINT fk_custodia_evidencia FOREIGN KEY ( idevidencia ) REFERENCES evidencia( idevidencia )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_custodia_evidencia ON custodia IS '';

ALTER TABLE custodia ADD CONSTRAINT fk_custodia_oficial FOREIGN KEY ( oficialdni ) REFERENCES oficial( dni )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_custodia_oficial ON custodia IS '';

ALTER TABLE custodia ADD CONSTRAINT fk_custodia_ubicacion FOREIGN KEY ( id_ubicacion ) REFERENCES ubicacion( id_lugar )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_custodia_ubicacion ON custodia IS '';

ALTER TABLE departamento ADD CONSTRAINT fk_departamento_departamento FOREIGN KEY ( supervisor ) REFERENCES departamento( iddepto )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_departamento_departamento ON departamento IS '';

ALTER TABLE departamento ADD CONSTRAINT fk_departamento_ubicacion FOREIGN KEY ( id_ubicacion ) REFERENCES ubicacion( id_lugar )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_departamento_ubicacion ON departamento IS '';

ALTER TABLE evento ADD CONSTRAINT fk_evento_caso FOREIGN KEY ( idcaso ) REFERENCES caso( idcaso )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_evento_caso ON evento IS '';

ALTER TABLE evento ADD CONSTRAINT fk_evento_persona FOREIGN KEY ( personadni ) REFERENCES persona( dni )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_evento_persona ON evento IS '';

ALTER TABLE evidencia ADD CONSTRAINT fk_evidencia_caso FOREIGN KEY ( idcaso ) REFERENCES caso( idcaso )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_evidencia_caso ON evidencia IS '';

ALTER TABLE involucra ADD CONSTRAINT fk_involucra_persona FOREIGN KEY ( personadni ) REFERENCES persona( dni )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_involucra_persona ON involucra IS '';

ALTER TABLE involucra ADD CONSTRAINT fk_involucra_caso FOREIGN KEY ( idcaso ) REFERENCES caso( idcaso )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_involucra_caso ON involucra IS '';

ALTER TABLE involucra ADD CONSTRAINT fk_involucra_rol FOREIGN KEY ( idrol ) REFERENCES rol( idrol )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_involucra_rol ON involucra IS '';

ALTER TABLE localidad ADD CONSTRAINT fk_localidad_provincia FOREIGN KEY ( idprov ) REFERENCES provincia( idprov )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_localidad_provincia ON localidad IS '';

ALTER TABLE oficial ADD CONSTRAINT fk_oficial_persona FOREIGN KEY ( dni ) REFERENCES persona( dni )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_oficial_persona ON oficial IS '';

ALTER TABLE oficial ADD CONSTRAINT fk_oficial_rango FOREIGN KEY ( idrango ) REFERENCES rango( idrango )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_oficial_rango ON oficial IS '';

ALTER TABLE oficial ADD CONSTRAINT fk_oficial_servicio FOREIGN KEY ( idservicio ) REFERENCES servicio( idservicio )     DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_oficial_servicio ON oficial IS '';

ALTER TABLE oficial ADD CONSTRAINT fk_oficial_departamento FOREIGN KEY ( iddepto ) REFERENCES departamento( iddepto )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_oficial_departamento ON oficial IS '';

ALTER TABLE participa ADD CONSTRAINT fk_participa_caso FOREIGN KEY ( idcaso ) REFERENCES caso( idcaso )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_participa_caso ON participa IS '';

ALTER TABLE participa ADD CONSTRAINT fk_participa_persona FOREIGN KEY ( personadni ) REFERENCES persona( dni )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_participa_persona ON participa IS '';

ALTER TABLE persona ADD CONSTRAINT fk_persona_ubicacion FOREIGN KEY ( id_ubicacion ) REFERENCES ubicacion( id_lugar )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_persona_ubicacion ON persona IS '';

ALTER TABLE telefono_departamental ADD CONSTRAINT fk_telefono_departamental FOREIGN KEY ( nro ) REFERENCES telefono( nro )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_telefono_departamental ON telefono_departamental IS '';

ALTER TABLE telefono_departamental ADD CONSTRAINT fk_telefono_departamental1 FOREIGN KEY ( iddepto ) REFERENCES departamento( iddepto )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_telefono_departamental1 ON telefono_departamental IS '';

ALTER TABLE telefono_personal ADD CONSTRAINT fk_telefono_personal_telefono FOREIGN KEY ( nro ) REFERENCES telefono( nro )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_telefono_personal_telefono ON telefono_personal IS '';

ALTER TABLE telefono_personal ADD CONSTRAINT fk_telefono_personal_persona FOREIGN KEY ( personadni ) REFERENCES persona( dni )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_telefono_personal_persona ON telefono_personal IS '';

ALTER TABLE testimonio ADD CONSTRAINT fk_testimonio_persona FOREIGN KEY ( personadni ) REFERENCES persona( dni )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_testimonio_persona ON testimonio IS '';

ALTER TABLE testimonio ADD CONSTRAINT fk_testimonio_oficial FOREIGN KEY ( oficialdni ) REFERENCES oficial( dni )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_testimonio_oficial ON testimonio IS '';

ALTER TABLE testimonio ADD CONSTRAINT fk_testimonio_caso FOREIGN KEY ( idcaso ) REFERENCES caso( idcaso )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_testimonio_caso ON testimonio IS '';

ALTER TABLE ubicacion ADD CONSTRAINT fk_ubicacion_localidad FOREIGN KEY ( idloc ) REFERENCES localidad( idloc )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_ubicacion_localidad ON ubicacion IS '';

ALTER TABLE ubicacion ADD CONSTRAINT fk_ubicacion_calle FOREIGN KEY ( idcalle ) REFERENCES calle( idcalle )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_ubicacion_calle ON ubicacion IS '';

ALTER TABLE ubicacion ADD CONSTRAINT fk_ubicacion_provincia FOREIGN KEY ( idprov ) REFERENCES provincia( idprov )   ON UPDATE CASCADE DEFERRABLE INITIALLY DEFERRED;

COMMENT ON CONSTRAINT fk_ubicacion_provincia ON ubicacion IS '';

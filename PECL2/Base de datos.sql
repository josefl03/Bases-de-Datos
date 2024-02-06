-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3-beta1
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public."Película" | type: TABLE --
-- DROP TABLE IF EXISTS public."Película" CASCADE;
CREATE TABLE public."Película" (
	titulo char NOT NULL,
	"año" date NOT NULL,
	duracion integer NOT NULL,
	idioma char NOT NULL,
	calificacion char NOT NULL,
	"nombreD_Director" char NOT NULL,
	genero char NOT NULL,
	CONSTRAINT "Película_pk" PRIMARY KEY (titulo,"nombreD_Director")

);
-- ddl-end --
ALTER TABLE public."Película" OWNER TO postgres;
-- ddl-end --

-- object: public."Actor" | type: TABLE --
-- DROP TABLE IF EXISTS public."Actor" CASCADE;
CREATE TABLE public."Actor" (
	"nombreA" char NOT NULL,
	"añoNacimientoA" date NOT NULL,
	"nacionalidadA" char NOT NULL,
	CONSTRAINT "Actor_pk" PRIMARY KEY ("nombreA"),
	CONSTRAINT "Unico_Actor" UNIQUE ("nombreA","añoNacimientoA","nacionalidadA")

);
-- ddl-end --
ALTER TABLE public."Actor" OWNER TO postgres;
-- ddl-end --

-- object: public."Director" | type: TABLE --
-- DROP TABLE IF EXISTS public."Director" CASCADE;
CREATE TABLE public."Director" (
	"nombreD" char NOT NULL,
	"añoNaciminetoD" date NOT NULL,
	"nacionalidadD" char NOT NULL,
	CONSTRAINT "Director_pk" PRIMARY KEY ("nombreD"),
	CONSTRAINT "Unico_Director" UNIQUE ("nombreD","añoNaciminetoD","nacionalidadD")

);
-- ddl-end --
ALTER TABLE public."Director" OWNER TO postgres;
-- ddl-end --

-- object: public."Pag.Web" | type: TABLE --
-- DROP TABLE IF EXISTS public."Pag.Web" CASCADE;
CREATE TABLE public."Pag.Web" (
	"URL" char NOT NULL,
	"tipoPW" char NOT NULL,
	CONSTRAINT "Pag.Web_pk" PRIMARY KEY ("URL"),
	CONSTRAINT "Unico_PW" UNIQUE ("URL","tipoPW")

);
-- ddl-end --
ALTER TABLE public."Pag.Web" OWNER TO postgres;
-- ddl-end --

-- object: "Director_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Película" DROP CONSTRAINT IF EXISTS "Director_fk" CASCADE;
ALTER TABLE public."Película" ADD CONSTRAINT "Director_fk" FOREIGN KEY ("nombreD_Director")
REFERENCES public."Director" ("nombreD") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Actua" | type: TABLE --
-- DROP TABLE IF EXISTS public."Actua" CASCADE;
CREATE TABLE public."Actua" (
	"titulo_Película" char NOT NULL,
	"nombreD_Director_Película" char NOT NULL,
	"nombreA_Actor" char NOT NULL,
	papel char NOT NULL,
	CONSTRAINT "Actua_pk" PRIMARY KEY ("titulo_Película","nombreD_Director_Película","nombreA_Actor")

);
-- ddl-end --

-- object: "Película_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Actua" DROP CONSTRAINT IF EXISTS "Película_fk" CASCADE;
ALTER TABLE public."Actua" ADD CONSTRAINT "Película_fk" FOREIGN KEY ("titulo_Película","nombreD_Director_Película")
REFERENCES public."Película" (titulo,"nombreD_Director") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Actor_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Actua" DROP CONSTRAINT IF EXISTS "Actor_fk" CASCADE;
ALTER TABLE public."Actua" ADD CONSTRAINT "Actor_fk" FOREIGN KEY ("nombreA_Actor")
REFERENCES public."Actor" ("nombreA") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Critica" | type: TABLE --
-- DROP TABLE IF EXISTS public."Critica" CASCADE;
CREATE TABLE public."Critica" (
	critico char(20) NOT NULL,
	puntuacion float NOT NULL,
	texto char(250) NOT NULL,
	"titulo_Película" char NOT NULL,
	"nombreD_Director_Película" char NOT NULL,
	"URL_Pag.Web" char,
	fecha date NOT NULL,
	CONSTRAINT "Critica_pk" PRIMARY KEY (critico,fecha)

);
-- ddl-end --
ALTER TABLE public."Critica" OWNER TO postgres;
-- ddl-end --

-- object: "Película_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Critica" DROP CONSTRAINT IF EXISTS "Película_fk" CASCADE;
ALTER TABLE public."Critica" ADD CONSTRAINT "Película_fk" FOREIGN KEY ("titulo_Película","nombreD_Director_Película")
REFERENCES public."Película" (titulo,"nombreD_Director") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Pag.Web_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Critica" DROP CONSTRAINT IF EXISTS "Pag.Web_fk" CASCADE;
ALTER TABLE public."Critica" ADD CONSTRAINT "Pag.Web_fk" FOREIGN KEY ("URL_Pag.Web")
REFERENCES public."Pag.Web" ("URL") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Caratula" | type: TABLE --
-- DROP TABLE IF EXISTS public."Caratula" CASCADE;
CREATE TABLE public."Caratula" (
	"tamaño_Kb" integer NOT NULL,
	tipo char(20) NOT NULL,
	"URL_Pag.Web" char NOT NULL,
	"titulo_Película" char NOT NULL,
	"nombreD_Director_Película" char NOT NULL,
	CONSTRAINT "Caratula_pk" PRIMARY KEY (tipo,"titulo_Película","nombreD_Director_Película")

);
-- ddl-end --
ALTER TABLE public."Caratula" OWNER TO postgres;
-- ddl-end --

-- object: "Pag.Web_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Caratula" DROP CONSTRAINT IF EXISTS "Pag.Web_fk" CASCADE;
ALTER TABLE public."Caratula" ADD CONSTRAINT "Pag.Web_fk" FOREIGN KEY ("URL_Pag.Web")
REFERENCES public."Pag.Web" ("URL") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Película_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Caratula" DROP CONSTRAINT IF EXISTS "Película_fk" CASCADE;
ALTER TABLE public."Caratula" ADD CONSTRAINT "Película_fk" FOREIGN KEY ("titulo_Película","nombreD_Director_Película")
REFERENCES public."Película" (titulo,"nombreD_Director") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "Unico_Peli" | type: CONSTRAINT --
-- ALTER TABLE public."Película" DROP CONSTRAINT IF EXISTS "Unico_Peli" CASCADE;
ALTER TABLE public."Película" ADD CONSTRAINT "Unico_Peli" UNIQUE (titulo,"año",duracion,idioma,calificacion,"nombreD_Director");
-- ddl-end --

-- object: "Unico_Caratula" | type: CONSTRAINT --
-- ALTER TABLE public."Caratula" DROP CONSTRAINT IF EXISTS "Unico_Caratula" CASCADE;
ALTER TABLE public."Caratula" ADD CONSTRAINT "Unico_Caratula" UNIQUE ("tamaño_Kb",tipo,"URL_Pag.Web","titulo_Película","nombreD_Director_Película");
-- ddl-end --

-- object: "Unico_Critica" | type: CONSTRAINT --
-- ALTER TABLE public."Critica" DROP CONSTRAINT IF EXISTS "Unico_Critica" CASCADE;
ALTER TABLE public."Critica" ADD CONSTRAINT "Unico_Critica" UNIQUE (critico,puntuacion,texto,"titulo_Película","nombreD_Director_Película","URL_Pag.Web",fecha);
-- ddl-end --



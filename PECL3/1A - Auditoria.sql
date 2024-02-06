CREATE TABLE IF NOT EXISTS auditoria(
    tabla TEXT NOT NULL,
    evento TEXT NOT NULL,
    usuario TEXT NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION fn_auditoria() RETURNS TRIGGER AS $fn_auditoria$
DECLARE
BEGIN
    INSERT INTO registro_auditoria VALUES(TG_TABLE_NAME, TG_OP, current_user);
    RETURN NULL;
END;
$fn_auditoria$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tg_auditoria AFTER INSERT OR DELETE OR UPDATE ON peliculas.actor
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_auditoria();

CREATE OR REPLACE TRIGGER tg_auditoria AFTER INSERT OR DELETE OR UPDATE ON peliculas.actua
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_auditoria();

CREATE OR REPLACE TRIGGER tg_auditoria AFTER INSERT OR DELETE OR UPDATE ON peliculas.caratulas
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_auditoria();

CREATE OR REPLACE TRIGGER tg_auditoria AFTER INSERT OR DELETE OR UPDATE ON peliculas.criticas
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_auditoria();

CREATE OR REPLACE TRIGGER tg_auditoria AFTER INSERT OR DELETE OR UPDATE ON peliculas.director
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_auditoria();

CREATE OR REPLACE TRIGGER tg_auditoria AFTER INSERT OR DELETE OR UPDATE ON peliculas.generos
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_auditoria();

CREATE OR REPLACE TRIGGER tg_auditoria AFTER INSERT OR DELETE OR UPDATE ON peliculas.pag_web
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_auditoria();

CREATE OR REPLACE TRIGGER tg_auditoria AFTER INSERT OR DELETE OR UPDATE ON peliculas.peliculas
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_auditoria();

CREATE OR REPLACE TRIGGER tg_auditoria AFTER INSERT OR DELETE OR UPDATE ON peliculas.personal
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_auditoria();
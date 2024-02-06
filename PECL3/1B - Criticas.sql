CREATE OR REPLACE FUNCTION fn_comprobarweb() RETURNS TRIGGER AS $fn_comprobarweb$
DECLARE
BEGIN
    IF (NEW.nombre_pag_web NOT IN (SELECT nombre FROM peliculas.pag_web)) THEN
        INSERT INTO peliculas.pag_web VALUES(NEW.nombre_pag_web, NULL, NULL);
    END IF;
    RETURN NULL;
END;
$fn_comprobarweb$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tg_comprobarweb BEFORE INSERT ON peliculas.criticas
FOR EACH ROW
EXECUTE PROCEDURE fn_comprobarweb();
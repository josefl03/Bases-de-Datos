CREATE TABLE IF NOT EXISTS puntuacion_media(
    puntuacion SMALLINT NOT NULL,
    año_pelicula SMALLINT,
    nombre_pelicula character varying,
    FOREIGN KEY (año_pelicula, nombre_pelicula) REFERENCES peliculas.peliculas(año, titulo)
);

INSERT INTO puntuacion_media
SELECT DISTINCT AVG(puntuacion), año_peliculas, titulo_peliculas
FROM peliculas.criticas
GROUP BY año_peliculas, titulo_peliculas
EXCEPT
SELECT puntuacion, año_pelicula, nombre_pelicula
FROM puntuacion_media;

CREATE OR REPLACE FUNCTION fn_puntuacion() RETURNS TRIGGER AS $fn_puntuacion$
DECLARE
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO puntuacion_media VALUES(AVG(NEW.puntuacion), año_peliculas, titulo_peliculas);
    ELSE
        WITH avg_puntuacion AS (
            SELECT AVG(puntuacion) AS rating, año_peliculas, titulo_peliculas
            FROM peliculas.criticas
            WHERE año_peliculas = NEW.año_peliculas AND titulo_peliculas = NEW.titulo_peliculas
        )
        
        INSERT INTO peliculas.rating_average (rating, año_peliculas, titulo_peliculas)
        SELECT rating, año_peliculas, titulo_peliculas
        FROM avg_puntuacion
        ON CONFLICT (año_peliculas, titulo_peliculas) DO UPDATE
        SET rating = avg_puntuacion.rating;
    END IF;
    RETURN NEW;
END;
$fn_puntuacion$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER tg_puntuacion AFTER INSERT OR UPDATE ON peliculas.criticas
FOR EACH STATEMENT
EXECUTE PROCEDURE fn_puntuacion();
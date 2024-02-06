--Prueba auditoría
INSERT INTO pag_web(url, tipo)
VALUES ('https://www.filmaffinity.com/es/user/rating/6571761/494993.html', NULL);

SELECT * FROM registro_auditoria;

--Prueba críticas
INSERT INTO peliculas.criticas("nombre", 10, "texto", 2022, "The Batman", 'https://www.filmaffinity.com/es/user/rating/6571761/5432334.html', "2022-01-01")
VALUES ('ejemplo.es');

SELECT * FROM peliculas.pag_web;

--Prueba puntuación
INSERT INTO peliculas.criticas("nombre", 5, "texto", 2022, "The Unholy", 'https://www.filmaffinity.com/es/user/rating/6571761/2134235.html', "2022-01-01")
SELECT * FROM puntuacion_media
# PECL3

Esta práctica se divide en 5 partes: Logs de la base de datos, comprobación de página existente, cálculo y registro de medias, administración de permisos y conexión con Python.

`1A - Auditoria.sql` registra eventos de inserción, eliminación o actualización en varias tablas específicas en la base de datos, almacenando detalles sobre la tabla afectada, el tipo de evento y el usuario que realizó la acción.

`1B - Criticas.sql` asegura la coherencia en la base de datos al agregar críticas. Antes de la inserción, verifica la existencia de la página web correspondiente a la crítica.

`1C - Puntuacion.sql` automatiza el cálculo y almacenamiento de la puntuación media de películas cuando se insertan o actualizan críticas en la tabla "criticas".

`2 - Roles.sql` son comandos SQL que establecen los roles y privilegios necesarios para diferentes tipos de usuarios.

`3 - Conexion con Python.py` utiliza la biblioteca psycopg2 para conectarse a la base de datos y realizar un par de consultas.

En el archivo `Ejemplos.sql` hay ejemplos para comprobar el funcionamiento de todas las funcionalidades especificadas.
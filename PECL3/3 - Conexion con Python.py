import psycopg2

def main():

    conn_string = 'host=localhost port=5434 user=admin password=1234 dbname=peliculas'
    conn = psycopg2.connect(conn_string)

    cursor = conn.cursor()

    print("-------------------------------")
    print(" CONSULTA 1")
    print("-------------------------------")

    cursor.execute("SELECT a.nombre_personal\n"
        + "FROM peliculas.actor AS a\n"
        + "INNER JOIN peliculas.director AS d\n"
        + "ON a.nombre_personal = d.nombre_personal")
    for nombre in cursor.fetchall():
        print(nombre)
    
    print("-------------------------------")
    print(" CONSULTA 2")
    print("-------------------------------")

    cursor.execute("SELECT g.genero, count(g.titulo_peliculas)\n"
        + "FROM peliculas.generos AS g\n"
        + "GROUP BY g.genero\n"
        + "ORDER BY count(g.titulo_peliculas) DESC")
    for genero, n in cursor.fetchall():
        print(genero, n)

    cursor.close()
    conn.close()

main()

USE ciclismo;

-- query 1 (random, todas random)
-- Obtener el valor del atributo netapa y la ciudad de salida de aquellas etapas que no tengan puertos de montaña.
SELECT netapa AS "NUMERO DE ETAPA", salida AS "CIUDAD DE SALIDA"
FROM etapa 
WHERE netapa NOT IN (SELECT netapa FROM puerto);

-- Obtener el nombre de cada puerto indicando el número (netapa) y los kilómetros de la etapa en la que se encuentra el puerto.
SELECT p.nompuerto, e.netapa, e.km 
from puerto p inner join etapa e
on p.netapa = e.netapa;

-- Selecciona el nombre de los ciclistas que hayan ganado alguna etapa teniendo 30 o más años.
SELECT DISTINCT C.nombre
FROM ciclista C INNER JOIN etapa E
ON  C.dorsal = E.dorsal
WHERE C.edad > 30;


-- Obtener la edad media de los ciclistas que han ganado alguna etapa
SELECT AVG(edad) AS "MEDIA DE EDAD"
FROM ciclista
WHERE dorsal IN (SELECT dorsal FROM etapa);


-- Selecciona el nombre de las ciudades donde haya llegado alguna etapa y de las que haya salido alguna etapa.

-- SELECT DISTINCT salida FROM etapa INTERSECT SELECT DISTINCT llegada FROM etapa (NO VA LOL)
SELECT llegada AS "ciudad de llegada", salida AS "ciudad de salida"
FROM etapa;





-- QUERY 2
-- ¿Cuántos equipos hay?
SELECT COUNT(*) AS "NUMERO DE EQUIPOS" FROM EQUIPO;

-- Obtener el nombre y el director de los equipos a los que pertenezca algún ciclista mayor de 33 años.
SELECT DISTINCT E.NOMEQ AS "NOMBRE DEL EQUIPO", E.DIRECTOR AS "DIRECTOR DEL EQUIPO" 
FROM EQUIPO E, CICLISTA C 
WHERE E.NOMEQ = C.NOMEQ 
AND C.EDAD > 33;

-- Obtener el nombre de los equipos y la edad media de sus ciclistas de aquellos  equipos que tengan la media de edad máxima de todos los equipos.
SELECT EQ.nomeq AS "NOMBRE DEL EQUIPO", AVG(C.edad) AS "EDAD MEDIA EQUIPO"
FROM ciclista C INNER JOIN equipo EQ
ON C.nomeq = EQ.nomeq
WHERE C.edad IN (SELECT MAX(C1.edad) FROM ciclista C1)
GROUP BY 1;

SELECT C.nomeq, AVG(c.edad)
FROM ciclista c
GROUP BY c.nomeq
HAVING AVG(c.edad) >= ALL
(SELECT AVG(d.edad) FROM ciclista d GROUP BY d.nomeq);
SELECT C.nomeq, AVG(c.edad)
FROM ciclista c
GROUP BY c.nomeq
HAVING AVG(c.edad) =
SELECT MAX(edad) FROM
(SELECT AVG(d.edad) as edad FROM ciclista d GROUP BY d.nomeq);



-- ¿Cuántos ciclistas hay?
SELECT COUNT(*) FROM ciclista;

-- Selecciona el nombre de los ciclistas que no hayan ganado ninguna etapa habiendo salido de una ciudad con más de 200.000 habitantes.
SELECT DISTINCT C.nombre
FROM ciclista C
WHERE dorsal NOT IN (SELECT dorsal FROM etapa ) AND  C.salida IN (SELECT poblacion FROM ciudad);

SELECT DISTINCT c.nombre FROM ciclista c WHERE c.dorsal NOT IN (SELECT dorsal FROM etapa) AND c.salida IN (SELECT salida FROM ciudad WHERE poblacion>200000);

-- Selecciona el nombre de las ciudades que hayan sido salida y llegada de la misma etapa.
SELECT salida AS "CIUDAD DE SALIDA" , llegada AS "CIUDAD DE LLEGADA"
FROM etapa 
WHERE salida = llegada;

-- Selecciona el nombre de los ciclistas que han llevado el maillot de color 'Amarillo' alguna vez.
SELECT DISTINCT C.nombre
FROM ciclista C , maillot M , llevar LL
WHERE C.dorsal = LL.dorsal AND LL.codigo = M.codigo
AND M.color LIKE "Amarillo";


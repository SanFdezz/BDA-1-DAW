-- ciclismo entero.
-- Obtener el código, el tipo, el color y el premio de todos los maillots que hay.
SELECT * FROM maillot;

-- Obtener el dorsal y el nombre de los ciclistas cuya edad sea menor o igual que 25 años.
SELECT dorsal, nombre FROM ciclista WHERE edad <= 25;

-- Obtener el nombre y la altura de todos los puertos de categoría ‘E’ (Especial)
SELECT nompuerto, altura FROM puerto WHERE categoria LIKE "E";

-- Obtener el valor del atributo netapa de aquellas etapas con salida y llegada en la misma ciudad.
SELECT netapa FROM etapa WHERE salida = llegada;

-- ¿Cuántos ciclistas hay?.
SELECT COUNT(*) AS "NÚMERO DE CICLISTAS" FROM ciclista;

-- ¿Cuántos ciclistas hay con edad superior a 25 años?
SELECT COUNT(*) AS "CICLISTAS DE MÁS DE 25 AÑOS" FROM ciclista WHERE edad > 25;

-- ¿Cuántos equipos hay?.
SELECT COUNT(*) AS "NÚMERO DE EQUIPOS" FROM equipo;

-- Obtener la media de edad de los ciclistas.
SELECT AVG(edad) AS "MEDIA DE EDAD" FROM ciclista;

--  Obtener la altura mínima y máxima de los puertos de montaña
SELECT MAX(altura) AS "ALTURA MÁXIMA" , MIN(altura) AS "ALTURA MÍNIMA" FROM puerto;

-- Obtener el nombre y la categoría de los puertos ganados por ciclistas del equipo ‘Banesto’.
SELECT DISTINCT nompuerto AS "NOMBRE DEL PUERTO", categoria 
FROM puerto P, ciclista C 
WHERE P.dorsal = C.dorsal 
AND C.nomeq LIKE "Banesto"; 

-- Obtener el nombre del cada puerto indicando el número (netapa) y los kilómetros de la etapa en la que se encuentra el puerto.
SELECT P.nompuerto , E.netapa, E.km
FROM puerto P INNER JOIN etapa E
ON 


use burgers;

-- query 1
SELECT CUS.name AS "NOMBRE DEL CLIENTE" , CUS.customercod AS "CODIGO DEL CLIENTE" , sum(BUR.price) AS "DINERO GASTADO" 
FROM customers CUS, burgers BUR, orders ORD 
WHERE ORD.NBurger = BUR.NBurger AND CUS.customerCod = ORD.customerCod GROUP BY 1,2 ORDER BY 3 desc;

-- QUERY 2
SELECT BUR.NBurger AS "HAMBURGUESAS CON TOPPINGS" 
FROM burgers BUR, toppings TOP 
WHERE BUR.NBurger = TOP.NBurger 
GROUP BY 1 ORDER BY BUR.price desc;

-- query 3
SELECT CUS.customercod AS "CODIGO DEL CLIENTE" FROM customers CUS INNER JOIN orders ORD 
ON CUS.customerCod = ORD.customerCod WHERE ORD.NBurger = "Super";

-- query 4
SELECT DISTINCT CU.NAME AS 'NOMBRE DEL CLIENTE'
FROM Customers CU, Orders ORD, Burgers BU, Toppings T
WHERE CU.customerCod = ORD.customerCod AND ORD.NBurger = BU.NBurger
AND BU.NBurger IN ( SELECT NBurger FROM Toppings WHERE topping = 'ONION')
AND BU.NBurger IN ( SELECT NBurger FROM Toppings WHERE topping LIKE '%CHEESE%');

-- query 5
use burgers;
SELECT B.NBurger AS "NOMBRE HAMBURGUESA", B.price AS "PRECIO" 
FROM burgers B, toppings T 
WHERE B.NBurger = T.NBurger
AND B.NBurger IN (SELECT NBurger FROM toppings WHERE topping like '%CHEESE%'OR topping = 'TOMATO') GROUP BY 1;

-- query 6 En clase llegamos a la conclusión de que esta era la forma que pedía, ya que eramos incapaces de entender el enunciado:
use burgers;
SELECT CU.NAME AS 'NOMBRE CLIENTES' 
FROM CUSTOMERS CU 
WHERE CU.customerCod 
NOT IN (SELECT CU.CUSTOMERCOD FROM CUSTOMERS CU, ORDERS ORD WHERE CU.customerCod = ORD.customerCod GROUP BY 1);
-- y si no, entendimos que podia ser asi:
SELECT CU.NAME AS "NOMBRE DE CLIENTE"
FROM BURGERS B, CUSTOMERS CU, ORDERS ORD 
WHERE ORD.NBURGER = B.NBURGER AND ORD.CUSTOMERCOD = CU.CUSTOMERCOD
GROUP BY 1;
-- O ASI:
SELECT distinct CU.NAME AS 'NOMBRE CLIENTE'
FROM Customers CU, Orders ORD, Burgers BUR, Toppings TOP
WHERE CU.customerCod = ORD.customerCod AND ORD.NBurger = BUR.NBurger
AND BUR.NBURGER NOT IN ( SELECT NBURGER FROM TOPPINGS WHERE TOPPING = 'TOMATO' OR TOPPING LIKE '%CHEESE%')
OR CU.customerCod NOT IN (SELECT CU.CUSTOMERCOD
FROM CUSTOMERS CU, ORDERS ORD
WHERE CU.customerCod = ORD.customerCod
GROUP BY 1);

-- y ahora si es en base a la query 1:
SELECT CU.customerCod AS "CÓDIGO DE CLIENTE", CU.name AS "NOMBRE DE CLIENTE", SUM(BU.price) AS "PRECIO"
FROM customers CU
LEFT JOIN orders ORD ON CU.customerCod = ORD.customerCod
LEFT JOIN burgers BU ON ORD.NBurger = BU.NBurger
GROUP BY 1, 2
ORDER BY 3 DESC;

-- query 7
USE burgers;
SELECT BUR.NBurger as "HAMBURGUESAS"
FROM burgers BUR INNER JOIN toppings TOP
ON BUR.NBurger = TOP.NBurger
WHERE TOP.amount > 2 -- yo he interpretado que haya más de 2 toppings del mismo
GROUP BY 1
ORDER BY BUR.price asc;

-- si no, este seria el resultado:
SELECT BUR.NBurger as "HAMBURGUESAS"
FROM burgers BUR INNER JOIN toppings TOP
ON BUR.NBurger = TOP.NBurger
GROUP BY 1
HAVING COUNT(TOP.topping) >2
ORDER BY BUR.price asc;

-- QUERY 8
SELECT DISTINCT BUR.NBurger AS "CÓDIGO HAMBURGUESA", CONCAT(BUR.price, " €") AS "PRECIO"
FROM burgers BUR INNER JOIN toppings TOP 
ON BUR.NBurger = TOP.NBurger
WHERE BUR.NBurger IN (SELECT TOP.NBurger 
						FROM toppings TOP 
						WHERE TOP.topping = 'avocado' AND TOP.amount >3 OR TOP.topping like '%CHEESE%');

-- QUERY 9
DROP VIEW HAMBURGUESA_TOPPINGS;
CREATE VIEW HAMBURGUESA_TOPPINGS AS(
SELECT BUR.NBurger AS "HAMBURGUESA CON MÁS TOPPINGS", COUNT(DISTINCT T.topping) AS "CANTIDAD DE TOPINGS", COUNT(DISTINCT C.customerCod) AS "PERSONAS QUE HAN COMPRADO"
FROM burgers BUR INNER JOIN toppings T INNER JOIN customers C INNER JOIN orders O 
ON C.customerCod = O.customerCod AND BUR.NBurger = T.NBurger AND O.NBurger = BUR.NBurger
GROUP BY 1
ORDER BY 2 desc
LIMIT 1);

SELECT * FROM burgers.hamburguesa_toppings;

-- QUERY 10
SELECT MAX(O.date) AS 'FECHA ÚLTIMA COMPRA'
FROM BURGERS B INNER JOIN TOPPINGS T INNER JOIN CUSTOMERS C INNER JOIN ORDERS O
ON  C.customerCod = O.customerCod AND O.NBurger = B.NBurger AND B.NBURGER = T.NBURGER
GROUP BY B.NBURGER 
ORDER BY count(distinct T.TOPPING) DESC
LIMIT 1;




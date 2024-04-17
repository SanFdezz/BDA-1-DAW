use jardineria;
-- query 31 Mostrar el nombre de todos aquellos clientes que hayan realizado al menos un pedido ordenado alfabéticamente.(pista 19 filas)
SELECT DISTINCT C.nombrecliente from clientes C, pedidos P 
where C.codigocliente = P.codigocliente 
order by 1 asc;

-- QUERY 32 Mostrar todos los pedidos del cliente “Beragua” con el importe total de cada pedido, ordenado por el número de pedido.(pista 5 filas)
SELECT P.codigopedido as "Pedido", sum(P.cantidad*P.preciounidad) as "Importe total" from  detallepedidos P INNER JOIN clientes C INNER JOIN pedidos PE
ON P.codigopedido = PE.codigopedido and PE.codigocliente = C.codigocliente WHERE C.nombrecliente = "Beragua" 
GROUP BY 1;

-- QUERY 33 Mostrar los pedidos con número comprendido entre 100 y 110, con el importe total de cada uno de ellos, ordenado por el número del pedido.(pista 11 filas
SELECT PE.codigopedido as "Número de pedido", CONCAT(CAST(sum(P.cantidad*P.preciounidad) AS CHAR(20)), " €") as "Importe total" from pedidos PE, detallepedidos P, clientes C 
WHERE PE.codigopedido = P.codigopedido AND PE.codigocliente = C.codigocliente AND PE.codigopedido BETWEEN 100 and 110 GROUP BY 1 ORDER BY 1;

-- QUERY 34 Calcular el importe máximo de un pedido y el importe mínimo de un pedido de todos los pedidos realizados por los clientes.(pista 1 filas)

-- QUERY 35 
-- Mostrar el nombre del producto y el total de unidades pedidas, de los productos de
-- los cuales se hayan pedido más de 450 unidades ordenados de mayor a menor por el número de unidades.(pista 2 filas)
SELECT PRO.nombre as "Nombre del producto" , sum(D.cantidad) as "Unidades pedidas" FROM productos PRO INNER JOIN detallepedidos D
ON PRO.codigoproducto = D.codigoproducto GROUP BY 1 HAVING sum(D.cantidad) > 450 order by 2 desc; 

-- QUERY 36 Mostrar el nombre del cliente y la suma total del importe de todos los pedidos realizados por él, ordenado por el nombre del cliente.(pista 18 filas)
SELECT CL.nombrecliente AS "Nombre del cliente", CONCAT(CAST(sum(DP.cantidad*DP.preciounidad) AS CHAR(20)), " €") AS "Importe de los pedidos" 
FROM detallepedidos DP INNER JOIN clientes CL INNER JOIN pedidos PED ON DP.codigopedido = PED.codigopedido AND PED.codigocliente = CL.codigocliente 
GROUP BY 1 ORDER BY 1;

-- QUERY 37 Mostrar nombre del producto y precio de venta del producto más caro (pista 1 filas)
use jardineria;
SELECT PRO.nombre AS "NOMBRE DEL PRODUCTO" , PRO.precioventa AS "PRECIO DE VENTA" FROM productos PRO
WHERE PRO.precioventa = (SELECT MAX(precioventa) FROM productos);

-- QUERY 38 Mostrar nombre del cliente, el número de pedido, la base imponible del pedido, el importe IVA (21%) y total del pedido, para los pedidos 100,103,106 y 109.(4 filas)





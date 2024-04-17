-- Workshop B
use jardineria;

-- query 21
update clientes set Ciudad="Fuenlabrada" where Ciudad="Fenlabrada";
update clientes set Ciudad="Barcelona" where Ciudad=" Barcelona";
select count(*) as "Num_de_Clientes", ciudad from clientes group by ciudad order by 1 desc;

-- query 22
select count(*) as "Num_de_Clientes", ciudad from clientes where ciudad like 'M%' or ciudad like 'S%' group by ciudad order by 1 desc;

-- query 23
select count(*) as "Num_de_Clientes", ciudad from clientes where pais = "España" group by ciudad having count(*)>1 order by 1 desc;

-- query 24
select max(PrecioVenta-PrecioProveedor) as "Beneficio máximo" , gama as "Gama" 
from productos where CantidadEnStock > 1 
group by gama order by 1 desc;

-- query 25
select CodigoCliente as "Codigo de Cliente" , count(*) as "Cuantos_Pedidos" 
from pedidos group by CodigoCliente order by 2 desc, 1;

-- query 26 en INNER JOIN
select C.NombreCliente as "Cliente" ,  count(P.Estado) as "Cuantos_Rechazados" 
from clientes C inner join pedidos P 
on C.CodigoCliente = P.CodigoCliente
where P.Estado = "Rechazado"
group by C.CodigoCliente order by 2 desc,1;
-- query 26 en PRODUCTO CARTESIANO
select C.NombreCliente as "Cliente" , count(P.Estado) as "Cuantos_Rechazados"
from clientes C, pedidos P
where C.CodigoCliente = P.CodigoCliente
and P.Estado = "Rechazado"
group by C.CodigoCliente order by 2 desc,1;

-- query 27
select sum(Cantidad*PrecioUnidad) as "Total"
from detallepedidos where CodigoPedido = "10";

-- query 28.1
select CodigoProducto, max(Cantidad) as "Cantidad Máxima" 
from detallepedidos where Cantidad>=100
group by CodigoProducto order by Cantidad asc, 1; -- no se puede agrupar por el mismo campo que calculas xdd

-- query 28.2
select D.CodigoProducto, P.Nombre, max(D.Cantidad) as "Cantidad Máxima"
from detallepedidos D inner join productos P
on  D.CodigoProducto = P.CodigoProducto
where Cantidad>=100
group by CodigoProducto order by Cantidad asc, 1, 2;

-- query 29.1
select D.CodigoProducto, P.Nombre as "Producto", sum(D.Cantidad*D.PrecioUnidad) as "Total Producto"
from detallepedidos D , productos P 
where D.CodigoProducto = P.CodigoProducto
group by D.CodigoProducto, P.Nombre 
having sum(D.Cantidad*D.PrecioUnidad) >= 800 and sum(D.Cantidad*D.PrecioUnidad) <= 1000
order by 3,1,2; -- en el group by tienen que estar todos los campos del select que no sean funciones de agregados Sandra !!

-- query 29.2
select CodigoProducto, sum(Cantidad*PrecioUnidad) as "Total Producto"
from detallepedidos where PrecioUnidad >= 50 and PrecioUnidad <= 100
group by CodigoProducto
having sum(Cantidad*PrecioUnidad) >= 800 and sum(Cantidad*PrecioUnidad) <= 1000
order by 1,2;

-- query 29.3
select C.CodigoCliente, C.NombreCliente, P.CodigoPedido 
from clientes C inner join pedidos P inner join empleados E
on C.CodigoEmpleadoRepVentas = E.CodigoEmpleado and C.CodigoCliente = P.CodigoCliente
where E.nombre ="Emmanuel";

-- query 29.4 
-- CARTESIANO: 
select E.nombre, count(P.CodigoPedido) as "Número de pedidos"
from empleados E, pedidos P, clientes C 
where C.CodigoEmpleadoRepVentas = E.CodigoEmpleado and C.CodigoCliente = P.CodigoCliente
group by E.nombre order by 2,1;
-- INNER JOIN
select E.nombre, count(P.CodigoPedido) as "Número de pedidos"
from clientes C inner join pedidos P inner join empleados E 
on C.CodigoEmpleadoRepVentas = E.CodigoEmpleado and C.CodigoCliente = P.CodigoCliente
group by E.nombre order by 2,1;

-- query 29.5 
select max(PrecioVenta-PrecioProveedor) as "Beneficio máximo" , nombre
from productos where CantidadEnStock >0
group by nombre order by 1 desc limit 1;

-- CICLISMO !!!

-- query 10: Obtener el nombre y la categoría de los puertos ganados por ciclistas del equipo ‘Banesto’.
use ciclismo;
select P.nompuerto as "Nombre puerto", P.categoria as "Puerto categoría" 
from puerto P, equipo E, ciclista C 
where P.dorsal = C.dorsal and E.nomeq = C.nomeq
and E.nomeq = "Banesto";  

-- query 11: Obtener el nombre del cada puerto indicando el número (netapa) y los kilómetros de la etapa en la que se encuentra el puerto.
select P.nompuerto, E.netapa, E.km from puerto P inner join etapa E 
on P.netapa = E.netapa order by 1, 2, 3 ;

-- query 12: Obtener el nombre y el director de los equipos a los que pertenezca algún ciclista mayor de 33 años.



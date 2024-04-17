-- query 11
use jardineria;
update clientes set Ciudad="Fuenlabrada" where Ciudad="Fenlabrada";
update clientes set Ciudad="Barcelona" where Ciudad=" Barcelona";
select distinct Ciudad from clientes;

-- query 12
select count(*) as "Número de clientes" from clientes;

-- query 13
select nombre as "Prod",  CantidadEnStock as "stock", PrecioProveedor as "PVP" from productos where gama="Herramientas" order by nombre;

-- query 14
select CantidadEnStock*PrecioProveedor as "valor", nombre as "prod" from productos where gama="Herramientas" order by CantidadEnStock*PrecioProveedor;

-- query 15
select nombre as "prod", PrecioVenta-PrecioProveedor as "Beneficio" from productos where gama="Herramientas";

-- query 16
select max(PrecioVenta-PrecioProveedor) as "Beneficio máximo" from productos where CantidadEnStock>0;

-- query 17
select CodigoPedido as "idPedido", FechaPedido as "Pedido", CodigoCliente as "idCliente", FechaEntrega as "Entrega", FechaEsperada as "Estimación", FechaEntrega-FechaEsperada as "Retraso" 
from pedidos where FechaEsperada<FechaEntrega order by FechaEntrega-FechaEsperada desc;

-- query 18
select count(*) as "Número de pedidos" from pedidos where CodigoCliente between '30' and '40' and CodigoCliente <> 30;

-- query 19.1
select CodigoCliente, FechaPedido, Estado from pedidos where FechaEntrega is null and Estado = "Entregado" or CodigoCliente in (3,5,10) order by FechaPedido;

-- query 19.2
select CodigoPedido as "pedido", NumeroLinea as "Linea" , CodigoProducto as "Producto", PrecioUnidad as "PVP" 
from detallepedidos 
where CodigoProducto not like '%0' and CodigoProducto not like '%2' and CodigoProducto not like '%4' and CodigoProducto not like '%6' and CodigoProducto like 'FR%' and PrecioUnidad > 70;

-- CICLISMO.
use ciclismo;
-- query 1
select codigo as "COD", tipo as "TIPO", color as "COLOR", premio as "PREMIO" from maillot;

-- query 2
select dorsal, nombre from ciclista where edad <= 25;

-- query 3
select nompuerto, altura from puerto where categoria = 'E';

-- query 4
select netapa from etapa where salida = llegada;

-- query 5
select count(*) from ciclista;

-- query 6
select count(*) from ciclista where edad >25;

-- query 7
select count(*) from equipo;

-- query 8
select FORMAT(avg(edad), 2) as 'agv(edad)' from ciclista;

-- query 9
select min(altura), max(altura)  from puerto;

-- MÚSICA
use musica;
-- query 1
select count(*) from disco;

-- query 2
select nombre from grupo where pais <> 'España';

-- query 3
select titulo from cancion where duracion > 5;

-- query 4
select distinct funcion from pertenece;

-- query 5
select nombre, sede from club where num > 500;







-- *** BBDD 09_jardineria ***

-- 1 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select cl.nombre_cliente, cl.fk_empleado_rep_ventas,em.nombre, em.apellido1, ofi.ciudad 
from pagos p  
right join clientes cl 
on p.fk_cliente=cl.id_cliente 
join empleados em on cl.fk_empleado_rep_ventas=em.id_empleado 
join oficinas ofi on em.fk_oficina=ofi.id_oficina
where p.fk_cliente is null ;

-- 2 Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
select distinct cl.nombre_cliente, id_cliente
from clientes cl
left join pagos p on p.fk_cliente=cl.id_cliente 
left join pedidos ped on ped.fk_cliente=cl.id_cliente
where p.fk_cliente is null and ped.fk_cliente is null;

-- 3 Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
select  distinct cl.nombre_cliente, id_cliente
from clientes cl
join pagos p on p.fk_cliente=cl.id_cliente;

-- 4 Calcula el número de clientes que tiene la empresa.
select count(id_cliente) from clientes;

-- 5 Devuelve el nombre del producto que tenga el precio de venta más caro.

select * from productos 
where precio_venta = (select max(precio_venta) from productos);

-- 6 Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
select count(id_empleado) , o.ciudad, o.id_oficina 
from oficinas o join empleados e on e.fk_oficina=o.id_oficina 
group by o.id_oficina;

-- 7 Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
select * from pedidos 
where fecha_entrega > fecha_esperada;

-- 8 Devuelve un listado de los productos que nunca han aparecido en un pedido.
select * from productos 
left join detalles_pedido on fk_producto=id_producto 
left join pedidos on fk_pedido=id_pedido
where id_pedido is null;

-- 9 Calcula el número de clientes que no tiene asignado representante de ventas.
select count(id_cliente) from clientes where fk_empleado_rep_ventas is null;

-- 10 Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
select distinct id_empleado, nombre,apellido1,apellido2, puesto 
from empleados left join clientes on fk_empleado_rep_ventas=id_empleado 
where fk_empleado_rep_ventas is null;


-- 11 Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
select id_cliente, ciudad,fk_empleado_rep_ventas from clientes where (fk_empleado_rep_ventas= 11 or fk_empleado_rep_ventas= 30) and ciudad='Madrid'; 

-- 12 Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select * from empleados where fk_jefe is null;

-- 13 Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago, utilizando una subconsulta
select * from clientes join pedidos on fk_cliente=id_cliente; 

select clientes.* from pagos  
right join clientes on fk_cliente=id_cliente
join(select * from clientes join pedidos on fk_cliente=id_cliente) pedido_cliente
on clientes.id_cliente= pedido_cliente.fk_cliente
where  id_transaccion is null group by id_cliente ;

-- 14 Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select * from pagos 
where year(fecha_pago)= 2008
order by fecha_pago desc;

-- 15 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente, utilizando una subconsulta
select no_repre.nombre, no_repre.apellido1, no_repre.apellido2 , o.telefono
 from oficinas o 
 join (select *
	from empleados e 
	left  join clientes c on e.id_empleado = c.fk_empleado_rep_ventas 
	where c.fk_empleado_rep_ventas is null ) no_repre on no_repre.fk_oficina = o.id_oficina;

-- 16 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
select id_cliente, c.nombre_cliente ,c.fk_empleado_rep_ventas, e.nombre
 from clientes c join empleados  e on c.fk_empleado_rep_ventas = e.id_empleado
 join pagos p on p.fk_cliente=c.id_cliente;

-- 17 Devuelve el nombre del producto del que se han vendido más unidades. 
-- (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido)
select fk_producto,nombre,sum(cantidad) from productos join detalles_pedido on fk_producto = id_producto group by fk_producto ;

	-- cantdidad maxima vendida de un producto
    select sum(cantidad) cant from detalles_pedido group by fk_producto order by cant desc limit 1;
    
select p.*, sum(dp.cantidad) cant
from productos p
join detalles_pedido dp on p.id_producto = dp.fk_producto
group by p.id_producto
having cant = (select sum(cantidad) cant from detalles_pedido group by fk_producto order by cant desc limit 1);

-- 18 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
select * from empleados join clientes on fk_empleado_rep_ventas=id_empleado where fk_empleado_rep_ventas is null and fk_oficina is null;

-- 20 ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
select * from clientes where ciudad = 'Madrid';

-- 21 Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select id_oficina,oficina,ciudad from oficinas;

-- 22 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
SELECT 
    e.id_empleado,
    e.nombre AS empleado,
    e.fk_jefe,
    j.nombre AS nombre_jefe
FROM empleados e
left JOIN empleados j ON e.fk_jefe = j.id_empleado
LEFT JOIN clientes c ON c.fk_empleado_rep_ventas = e.id_empleado
WHERE c.id_cliente IS NULL;

-- 23 Devuelve el producto que más unidades tiene en stock.
select p.* from productos p
where cantidad_en_stock = (select max(cantidad_en_stock) from productos) ;
 
-- 24 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
select c.nombre_cliente,e.nombre from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
left join pagos p on p.fk_cliente = c.id_cliente 
where p.fk_cliente is null;


-- 25 Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
select ciudad, telefono from oficinas where pais ='España'; 

-- 26 La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado.

-- La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido.
select id_producto, (p.precio_proveedor * dp.cantidad ) base_imponible,(p.precio_proveedor * dp.cantidad )* 0.21 iva, (p.precio_proveedor * dp.cantidad )* 1.21 total_facturacion
 from productos p join detalles_pedido dp on dp.fk_producto = p.id_producto;
-- El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.

-- 27 Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
select nombre, apellido1, apellido2, email from empleados where fk_jefe=7; 

-- 28 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select distinct o.id_oficina, o.linea_direccion1,o.linea_direccion2 
from oficinas  o
join empleados e on e.fk_oficina=o.id_oficina 
join clientes c on c.fk_empleado_rep_ventas=e.id_empleado 
where c.ciudad= 'Fuenlabrada';

-- 29 Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select * from pedidos 
where estado= 'Rechazado' and year(fecha_entrega) = 2009;

-- 30 Devuelve un listado con todas las formas de pago que aparecen en la tabla pago.
-- Tenga en cuenta que no deben aparecer formas de pago repetidas.
select distinct forma_pago from pagos;

-- 31 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
 select c.* from clientes c
 left join pagos p on fk_cliente=id_cliente 
 where fk_cliente is null;

-- 32 Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
select  c.* from clientes c  
join pedidos p on p.fk_cliente=c.id_cliente 
left join pagos ps on ps.fk_cliente= c.id_cliente 
where ps.fk_cliente is null group by id_cliente;

-- 33 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
select sum(cantidad),fk_pedido from detalles_pedido group by fk_pedido;

-- 34 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

select distinct fk_gama, gama, fk_cliente, nombre_cliente
from productos p
join gamas_productos gp on fk_gama= id_gama
join detalles_pedido dp on fk_producto=id_producto
join pedidos on fk_pedido=id_pedido
join clientes on fk_cliente = id_cliente;

-- 36 Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select estado from pedidos group by estado;

-- 37 Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. 
-- El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
select p.* , gama from productos p
join gamas_productos on fk_gama=id_gama 
where gama = 'Ornamentales' and cantidad_en_stock > 100 
order by precio_venta desc;


-- 38 Calcula el precio de venta del producto más caro y más barato en una misma consulta.
select min(precio_venta), max(precio_venta) from productos ;

select * from productos
where precio_venta = (select min(precio_venta) from productos) or precio_venta = (select max(precio_venta) from productos);

-- 39 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select c.nombre_cliente , e.nombre,o.ciudad, fk_oficina 
from empleados e join clientes c on c.fk_empleado_rep_ventas=e.id_empleado
join oficinas o on e.fk_oficina=o.id_oficina;

-- 40 Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
select nombre, count(id_cliente)
from empleados  right join  clientes on fk_empleado_rep_ventas=id_empleado
group by nombre;

-- 41 Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas
-- y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
select nombre_cliente,nombre,apellido1,telefono 
from clientes join empleados on fk_empleado_rep_ventas=id_empleado
left join pagos on fk_cliente=id_cliente
where fk_cliente is null;

-- 42 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
select nombre_cliente , fecha_pedido from clientes 
join pedidos on fk_cliente=id_cliente
where year(fecha_pedido)= 2008 
order by nombre_cliente asc;

-- 43 Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
select e.nombre,e.apellido1,e.apellido2, e.email from empleados e
join empleados j on e.fk_jefe=j.id_empleado
where j.nombre ='Alberto' and j.apellido1 = 'Soria' ;

-- 44 Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
select id_producto , nombre from productos join detalles_pedido 
on fk_producto=id_producto 
group by id_producto;

-- 45 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select c.nombre_cliente,e.nombre,o.ciudad
from clientes c
join pagos p on p.fk_cliente=c.id_cliente
join empleados e on fk_empleado_rep_ventas=id_empleado
join oficinas o on fk_oficina=id_oficina;

-- 46 Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno.
-- El listado deberá estar ordenado por el número total de unidades vendidas.
select id_producto,nombre, sum(cantidad) total_unidades from productos p 
join detalles_pedido on fk_producto=id_producto
group by id_producto 
order by total_unidades desc
limit 20;


-- 47 Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.
select c.nombre_cliente,e.nombre,apellido1,o.ciudad
from clientes c
join empleados e on fk_empleado_rep_ventas=id_empleado
join oficinas o on fk_oficina=id_oficina;

-- 48 Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. 
-- Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta: Utilizando la función YEAR de MySQL., 
-- Utilizando la función DATE_FORMAT de MySQL., Sin utilizar ninguna de las funciones anteriores.
select distinct fk_cliente from pagos 
where year(fecha_pago)=2008;

select distinct fk_cliente from pagos 
where date_format(fecha_pago , '%Y')= 2008;

select distinct fk_cliente from pagos 
where fecha_pago between '2008-01-01' and '2008-12-31';

-- 49 Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
select c.id_cliente,c.nombre_cliente,e.nombre,e.apellido1
from clientes c
join empleados e
on c.fk_empleado_rep_ventas=id_empleado
group by c.id_cliente;

-- 50 Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
select id_cliente,apellido_contacto ,(select  min(fecha_pago) 
from pagos p where p.fk_cliente=c.id_cliente) fecha_min,
(select max(fecha_pago)from pagos 
where p.fk_cliente=c.id_cliente) fecha_max
from clientes c join pagos p on p.fk_cliente=c.id_cliente;

select id_cliente,apellido_contacto ,min(fecha_pago),max(fecha_pago)
from clientes join pagos on fk_cliente=id_cliente
group by id_cliente;

-- 51 Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
select * from clientes 
where limite_credito > (select sum(total) from pagos where fk_cliente=id_cliente group by fk_cliente);

-- 52 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
select e.nombre as nombre_empleado, j.nombre as nombre_jefe from empleados e 
join empleados j on e.fk_jefe=j.id_empleado;

-- 53 ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
select estado, count(id_pedido) total from pedidos
group by estado;

-- 54 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
select * from oficinas where  id_oficina not in(
select distinct fk_oficina from oficinas 
join empleados on fk_oficina=id_oficina 
join clientes on fk_empleado_rep_ventas=id_empleado
join pedidos on fk_cliente= id_cliente
join detalles_pedido on fk_pedido=id_pedido
join productos on fk_producto=id_producto
join gamas_productos on fk_gama= id_gama
where gama='Frutales');

-- 55 Devuelve un listado con el nombre de los todos los clientes españoles.
select nombre_cliente from clientes 
where pais= 'Spain';

-- 56 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
select id_empleado ,nombre, oficinas.* from empleados 
left join clientes on fk_empleado_rep_ventas= id_empleado
join oficinas on fk_oficina=id_oficina 
where fk_empleado_rep_ventas is null;

-- 57 Devuelve el producto que menos unidades tiene en stock.
select id_producto,nombre,cantidad_en_stock
from productos
where cantidad_en_stock= (select min(cantidad_en_stock)from productos )group by id_producto;

-- 58 Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M
select count(id_cliente),ciudad  from clientes where ciudad like 'M%' group by ciudad;

-- 59 Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
select * from pedidos where 
 month(fecha_entrega)=01;
 
-- 60 ¿Cuál fue el pago medio en 2009?
select round(avg(total),2)pago_medio from pagos where year(fecha_pago)=2009;

-- 61 Devuelve el nombre del cliente con mayor límite de crédito.
select id_cliente,nombre_cliente
from clientes 
where limite_credito = (select max(limite_credito) from clientes);

-- 62 Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. 
-- Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
select id_cliente,nombre_cliente,count(id_pedido) from  clientes join pedidos on fk_cliente = id_cliente
group by id_cliente;

-- 63 Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre y la descripción.
select id_producto,nombre,descripcion 
from productos left join detalles_pedido on fk_producto=id_producto
where fk_producto is null;

-- 64 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
select e.nombre,e.apellido1,e.apellido2,e.puesto,o.telefono
from empleados e join oficinas o on e.fk_oficina=o.id_oficina
left join clientes c on c.fk_empleado_rep_ventas=e.id_empleado
where c.fk_empleado_rep_ventas is null;

-- 65 Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
select e.nombre empleado,j.nombre jefe,jf.nombre jefazo from empleados e 
left join empleados j on e.fk_jefe=j.id_empleado
left join empleados jf on e.fk_jefe=jf.id_empleado;


-- 66 Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.
select sum(total),year(fecha_pago) from pagos group by year(fecha_pago);

-- 67 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
select * from clientes left join pedidos on fk_cliente=id_cliente
where fk_cliente is null;

-- 68 Devuelve el nombre del cliente con mayor límite de crédito utilizando una subconsulta
select nombre_cliente from clientes 
where limite_credito = (select max(limite_credito)from clientes);

-- 69 Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada. 
-- Utilizando la función ADDDATE de MySQL., Utilizando la función DATEDIFF de MySQL., ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?

-- el adddate le agrega o le quita dias:
select id_pedido,fk_cliente,fecha_esperada,fecha_entrega from pedidos 
where adddate(fecha_entrega,2 ) <= fecha_esperada;

-- datediff solo resta fechas:
select id_pedido,fk_cliente,fecha_esperada,fecha_entrega from pedidos 
where datediff(fecha_esperada,fecha_entrega)>=2;

-- forma incorrecta:
select id_pedido,fk_cliente,fecha_esperada,fecha_entrega from pedidos 
where fecha_esperada - fecha_entrega >=2 ;

-- 70 Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
select nombre,apellido1,puesto from empleados
left join clientes on fk_empleado_rep_ventas=id_empleado
where fk_empleado_rep_ventas is null;

-- 71 Devuelve el nombre del producto que tenga el precio de venta más caro utilizando una subconsulta
select id_producto, nombre from productos 
where precio_venta = (select max(precio_venta) from productos);

-- 72 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos.
-- Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
select id_cliente,nombre_cliente, sum(total) from clientes  left join pagos
on fk_cliente=id_cliente where fk_cliente= id_cliente 
group by id_cliente ; 

-- 73 ¿Cuántos clientes tiene cada país?
select pais, count(id_cliente)
from clientes group by pais;

-- 75 Lista las ventas totales de los productos que hayan facturado más de 3000 euros.
-- Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
select pro.id_producto,pro.nombre,sum(dp.cantidad),sum(dp.cantidad * dp.precio_unidad) total, round((sum(dp.cantidad * dp.precio_unidad) * 1.21),2) total_iva
from productos pro
join detalles_pedido dp on dp.fk_producto= pro.id_producto
group by pro.id_producto
having total > 3000;

-- 76 Calcula el número de productos diferentes que hay en cada uno de los pedidos.
select count(fk_producto), fk_pedido from detalles_pedido 
group by fk_pedido ;

-- 77 ¿Cuántos empleados hay en la compañía?
select count(id_empleado) from empleados 
where fk_jefe is not null;

-- 78 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
select nombre_cliente from clientes join pedidos 
on fk_cliente=id_cliente 
where fecha_entrega > fecha_esperada
group by nombre_cliente;

-- 79 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
select id_empleado, nombre from empleados 
where fk_oficina is null;

-- *** Vistas ***
-- 80 Escriba una vista que se llame listado_pagos_clientes que muestre un listado donde aparezcan todos los clientes y los pagos que ha realizado cada uno de ellos. 
-- La vista deberá tener las siguientes columnas: nombre y apellidos del cliente concatenados, teléfono, ciudad, pais, fecha_pago, total del pago, id de la transacción
create or replace view listado_pagos_cliente as
select id_cliente, concat(c.nombre_cliente,' ', c.nombre_contacto,' ', c.apellido_contacto) clientes,c.telefono,c.ciudad,c.pais,p.id_transaccion,p.fecha_pago,p.total 
from clientes c join pagos p on p.fk_cliente=c.id_cliente;

-- 81 Escriba una vista que se llame listado_pedidos_clientes que muestre un listado donde aparezcan todos los clientes y los pedidos que ha realizado cada uno de ellos. 
-- La vista deáber tener las siguientes columnas: nombre y apellidos del cliente concatendados, teléfono, ciudad, pais, código del pedido, fecha del pedido, fecha esperada, fecha de entrega y la cantidad total del pedido, que será la suma del producto de todas las cantidades por el precio de cada unidad, que aparecen en cada línea de pedido.
create or replace view listado_pedidos_clientes as
select id_cliente, concat(c.nombre_cliente,' ', c.nombre_contacto,' ', c.apellido_contacto) clientes,c.telefono,c.ciudad,c.pais,p.id_pedido,fecha_esperada,fecha_entrega,sum(dp.cantidad * dp.precio_unidad) cantidad_total 
from clientes c join pedidos p on p.fk_cliente=c.id_cliente
join detalles_pedido dp on dp.fk_pedido=p.id_pedido
group by id_pedido;


-- 82 Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes de la ciudad de Madrid que han realizado pagos.
select * from listado_pagos_cliente 
where ciudad='Madrid';

-- 83 Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes que todavía no han recibido su pedido.
select * from listado_pedidos_clientes 
where fecha_entrega is null;

-- 84 Utilice las vistas que ha creado en los pasos anteriores para calcular el número de pedidos que se ha realizado cada uno de los clientes.
select clientes,id_cliente , count(id_pedido) from listado_pedidos_clientes 
group by id_cliente;

-- 85 Utilice las vistas que ha creado en los pasos anteriores para calcular el valor del pedido máximo y mínimo que ha realizado cada cliente.
select id_cliente, max(cantidad_total),min(cantidad_total) from listado_pedidos_clientes
group by id_cliente;


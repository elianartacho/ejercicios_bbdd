-- *** BBDD 02_tienda ***
use 02_tienda;

-- 1 Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select producto, precio, fabricante from productos p , fabricantes f order by precio asc limit 1;

-- 2 Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
select producto, precio, fabricante from productos p , fabricantes f order by precio desc limit 1;

-- 3 Devuelve una lista de todos los productos del fabricante Lenovo.
select producto from productos p join fabricantes f on p.fk_fabricante=f.id_fabricante where fabricante='Lenovo';

-- 4 Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
select producto, precio from productos p join fabricantes f on p.fk_fabricante=f.id_fabricante where fabricante ='Crucial' and precio > 200;

-- 5 Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.
select p.producto, f.fabricante from productos p join fabricantes f on p.fk_fabricante=f.id_fabricante where fabricante = 'Asus' or  fabricante = 'Hewlett-Packardy' or fabricante = 'Seagate';

-- 6 Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
-- 7 Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
-- 8 Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
-- 9 Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
-- 10 Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
-- 11 Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
-- 12 Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
-- 13 Calcula el número total de productos que hay en la tabla productos.
select count(producto)
from productos ;

-- 14 Calcula el número total de fabricantes que hay en la tabla fabricante.
select count(fabricante)
from fabricantes;

-- 15 Calcula el número de valores distintos de código de fabricante aparecen en la tabla productos.
select count(distinct fk_fabricante) 
from productos ;

-- 16 Calcula la media del precio de todos los productos.
select round(avg (precio),2) media_productos
 from productos;

-- 17 Calcula el precio más barato de todos los productos.
select min(precio) 
from productos; 

-- 18 Calcula el precio más caro de todos los productos.
select max(precio)
 from productos;

-- 19 Lista el nombre y el precio del producto más barato.
select producto, precio 
from productos
 where precio =(select min(precio)from productos);
 
-- 20 Lista el nombre y el precio del producto más caro.
select producto, precio 
from productos
 where precio =(select max(precio)from productos);

-- 21 Calcula la suma de los precios de todos los productos.
select sum(precio) suma_precios 
from productos;

-- 22 Calcula el número de productos que tiene el fabricante Asus.
select count(producto) productos_Asus 
from productos p 
join fabricantes f on p.fk_fabricante=f.id_fabricante 
where fabricante= 'Asus';

-- 23 Calcula la media del precio de todos los productos del fabricante Asus.
select round(avg (precio)) precio_media_Asus 
from productos p 
join fabricantes f on p.fk_fabricante =f.Id_fabricante 
where fabricante='Asus';

-- 24 Calcula el precio más barato de todos los productos del fabricante Asus.
select min(precio) from productos p 
join fabricantes f on p.fk_fabricante=f.id_fabricante 
where fabricante = 'Asus';
  
-- 25 Calcula el precio más caro de todos los productos del fabricante Asus.
select max(precio) 
from productos p 
join fabricantes f on p.fk_fabricante=f.id_fabricante 
where fabricante = 'Asus';

-- 26 Calcula la suma de todos los productos del fabricante Asus.
select count(producto) 
from productos 
join fabricantes on fk_fabricante=id_fabricante 
where fabricante = 'Asus';

-- 27 Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.
select min(precio) precio_minimo, max(precio) precio_maximo, avg(precio) precio_medio, count(producto) total_productos
from productos 
join fabricantes 
on fk_fabricante=id_fabricante 
where fabricante = 'Crucial';

-- 28 Muestra el número total de productos que tiene cada uno de los fabricantes. El listado también debe incluir los fabricantes que no tienen ningún producto.
-- El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. Ordene el resultado descendentemente por el número de productos.
 select count(id_producto) cant_product , fabricante 
 from productos
 right join fabricantes 
 on fk_fabricante=id_fabricante
 group by fabricante
 order by cant_product desc;
 
 
-- 29 Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
select min(precio) precio_minimo, max(precio) precio_maximo, avg(precio) precio_medio, count(producto) total_productos, fabricante 
from productos 
join fabricantes 
on fk_fabricante=id_fabricante 
group by id_fabricante;

-- 30 Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. 
-- No es necesario mostrar el nombre del fabricante, con el código del fabricante es suficiente.
select min(precio) precio_minimo, max(precio) precio_maximo, avg(precio) precio_medio, count(producto) total_productos, id_fabricante 
from productos 
join fabricantes 
on fk_fabricante=id_fabricante 
group by id_fabricante
having precio_medio > 200;

-- 31 Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. 
-- Es necesario mostrar el nombre del fabricante.
select min(precio) precio_minimo, max(precio) precio_maximo, avg(precio) precio_medio, count(producto) total_productos, fabricante
from productos 
join fabricantes 
on fk_fabricante=id_fabricante 
group by id_fabricante
having precio_medio > 200;

-- 32 Calcula el número de productos que tienen un precio mayor o igual a 180€.
select count(id_producto) from productos where precio >=180;

-- 33 Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.
select count(producto) , fabricante
from productos 
join fabricantes 
on fk_fabricante=id_fabricante
where precio >= 180
group by id_fabricante;

-- 34 Lista el precio medio los productos de cada fabricante, mostrando solamente el código del fabricante.
select id_fabricante , avg(precio) media
from productos 
join fabricantes 
on fk_fabricante=id_fabricante
group by id_fabricante;

-- 35 Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.

-- 36 Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.
select fabricante from productos join fabricantes on fk_fabricante=id_fabricante group by id_fabricante
having round(avg(precio),2) >=150;

-- 37 Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.

-- 38 Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.
select fabricante, count(id_producto)
from productos
join fabricantes on fk_fabricante=id_fabricante
where precio >=220
group by id_fabricante;

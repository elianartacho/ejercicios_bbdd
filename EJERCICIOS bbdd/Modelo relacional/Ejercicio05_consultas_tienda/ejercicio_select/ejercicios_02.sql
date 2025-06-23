-- base de datos 05_empleados
use 05_empleados;

-- 1 Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
select nombre, apellido1, apellido2, departamento,id_departamento 
from empleados em 
join departamentos dep on em.fk_departamento=dep.id_departamento ;
-- 2 Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.
select em.*, departamento,id_departamento 
from empleados em 
join departamentos dep on em.fk_departamento=dep.id_departamento 
order by departamento asc, em.apellido1, em.apellido2 , em.nombre ;

-- 3 Devuelve un listado con el código y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.
select distinct departamento , id_departamento from departamentos dep join empleados em on em.fk_departamento=dep.id_departamento;

-- 4 Devuelve un listado con el código, el nombre del departamento y el valor del presupuesto del que dispone, solamente de aquellos departamentos que tienen empleados.
  select distinct departamento, id_departamento, presupuesto from departamentos dep join empleados em on em.fk_departamento=dep.id_departamento;

-- El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) menos el valor de los gastos que ha generado (columna gastos).
select cast(presupuesto as signed)- gastos presupuesto_actual from departamentos ;

-- Verificar el resultado en el departamento I+D si es correcto.

-- 5 Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.
select departamento from departamentos join empleados em on fk_departamento=id_departamento where nif='38382980M';

-- 6 Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.
select departamento from departamentos join empleados em on fk_departamento=id_departamento where nombre= 'Pepe' and apellido1='Ruiz' and apellido2= 'Santana';

-- 7 Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.
select distinct * from empleados em join departamentos dep on fk_departamento=id_departamento where departamento='I+D' order by em.apellido1, em.apellido2, em.nombre ;

-- 8 Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.
select distinct * from empleados em join departamentos dep on fk_departamento=id_departamento where departamento in ('I+D','Sistemas', 'Contabilidad') order by em.apellido1, em.apellido2, em.nombre ;

-- 9 Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
select distinct nombre,presupuesto from empleados em join departamentos dep on fk_departamento=id_departamento where presupuesto not between 100000 and 200000;

-- 10 Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
select departamento from departamentos join empleados on fk_departamento=id_departamento where apellido2 is null ;

-- ****Resuelva las siguientes consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.***
-- 11 Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. Este listado también debe incluir los empleados que no tienen ningún departamento asociado.
select * from empleados left join departamentos on fk_departamento=id_departamento ;

-- 12 Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.
select distinct * from empleados left join departamentos on fk_departamento=id_departamento where fk_departamento is null; 

-- 13 Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
select departamento from departamentos left join empleados on fk_departamento=id_departamento where fk_departamento is null;

-- 14 Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.
select * from empleados left join departamentos on fk_departamento=id_departamento union select * from empleados right join departamentos on fk_departamento=id_departamento order by departamento;

-- 15 Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.
select * from empleados left join departamentos on fk_departamento=id_departamento where fk_departamento is null union select * from empleados right join departamentos on fk_departamento=id_departamento where fk_departamento is null order by departamento;

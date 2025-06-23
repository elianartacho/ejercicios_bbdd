-- Datos del jefazo
select * from empleados where fk_jefe is not null;

-- Datos de los directores generales del jefazo,conociendo la id del jefazo
select * from empleados where fk_jefe = 2;

-- Datos de todos los empleados con el nombre de su jefe
select *
 from empleados emp 
 join empleados jefes on emp.fk_jefe = jefes. idempleados;
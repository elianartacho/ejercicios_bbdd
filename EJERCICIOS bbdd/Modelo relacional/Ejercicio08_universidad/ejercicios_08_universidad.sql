-- *** BBDD 06_universidad ***
use ejercicios_08_universidad;

-- 1.Obtener el nombre completo de los alumnos que estén cursando "Matematica Discreta"
select nombre,apellido1,apellido2 
from alumnos 
join notas on fk_alumno=id_alumno   
join asignaturas on fk_asignatura=id_asignatura where asignatura='Matematica Discreta';


-- 2. Obtener el nombre completo y la nota obtenida de los alumnos que hayan cursado "Matematica Discreta"
select nombre,apellido1,apellido2 ,nota
from alumnos 
join notas on fk_alumno=id_alumno   
join asignaturas on fk_asignatura=id_asignatura where asignatura='Matematica Discreta';


-- 3 Obtener el listado de profesores de la Factultad de "Informatica"
select distinct  nombre,apellido1,apellido2,id_profesor 
from profesores 
join asignaturas on fk_profesor=id_profesor 
where facultad='Informatica';

-- 4 Obtener la cantidad de alumnos por ciudad
select count(id_alumno),ciudad from alumnos group by ciudad ;

-- 5  Obtener el nombre completo y edad de todos los alumnos
select nombre, apellido1, apellido2, timestampdiff(year, fecha_nacimiento, now()) as edad from alumnos ;

-- 6 Obtener las edades de los alumnos que cursan asignaturas
select timestampdiff(year, fecha_nacimiento, now()) edad, asignatura ,nombre,apellido1,apellido2
from alumnos join notas on fk_alumno=id_alumno join asignaturas on fk_asignatura=id_asignatura ;

-- 7 Obtener las notas medias de los alumnos por edad
select round(avg(nota),2) media ,timestampdiff(year, fecha_nacimiento, now()) edad  
from alumnos join notas on fk_alumno=id_alumno 
group by edad ;

-- 8 Cantidad de alumnos matriculados en más de dos asignaturas: en tres partes:

	-- Listado de alumnos matriculados en asignaturas
        select id_alumno ,fk_asignatura from alumnos join notas on fk_alumno=id_alumno;
        
	-- Cantidad de asignaturas que cursa cada alumno, los que cursan mas de dos
    select id_alumno , count(fk_asignatura) cant from alumnos join notas on fk_alumno=id_alumno group by id_alumno having cant > 2;
        
	-- contar el resultado anterior
    select count(*) 
    from (select id_alumno , count(fk_asignatura) cant from alumnos join notas on fk_alumno=id_alumno group by id_alumno having cant > 2) c;
    
-- 9 Obtener los datos de los alumnos que no cursan ninguna asignatura ni tienen ninguna nota
select * from alumnos left join notas on fk_alumno=id_alumno where fk_asignatura is null;

-- 10 Cantidad de notas y media de notas de cada alumno
select count(nota) cant_notas,round(avg (nota),2) nota_media, id_alumno
from notas join alumnos a on fk_alumno=id_alumno 
group by id_alumno;  
 
-- 11  Listado de profesores con la cantidad de asignaturas que imparte cada uno de ellos, aunque ahora no estén impartiendo ninguna.
select count(id_asignatura) cant_asignaturas,id_profesor, nombre,apellido1,apellido2
 from asignaturas right join profesores on fk_profesor=id_profesor 
 group by id_profesor;

-- 12 Notas medias por asignaturas que imparte cada profesor
select avg(nota) nota_media,asignatura, id_profesor,nombre,apellido1, apellido2 
from notas
join asignaturas on fk_asignatura=id_asignatura 
join profesores on fk_profesor=id_profesor group by id_asignatura, id_profesor;

-- 13 Mostrar, de la Asignatura “Programacion I”, la nota máxima, mínima y la diferencia entre ambas. 
select min(nota) nota_minima, max(nota) nota_maxima, max(nota)- min(nota) diferencia,  asignatura 
from notas join asignaturas on fk_asignatura=id_asignatura
 where asignatura='Programacion I';
   -- 13b Devolver también el número de alumnos que la han cursado.
select count(id_alumno), min(nota) nota_minima, max(nota) nota_maxima, max(nota)- min(nota) diferencia,  asignatura 
from notas 
join asignaturas on fk_asignatura=id_asignatura 
join alumnos on fk_alumno=id_alumno 
where asignatura='Programacion I'
group by id_asignatura;

-- 14 Obtener de Cada profesor las asignaturas que imparte, con los alumnos en cada una de ellas y su nota
select p.id_profesor, p.nombre, a.asignatura, alu.id_alumno, alu.nombre, n.nota
from asignaturas a
join profesores p on a.fk_profesor = p.id_profesor
join notas n on n.fk_asignatura = a.id_asignatura 
join alumnos alu on n.fk_alumno = alu.id_alumno
order by p.nombre, a.asignatura, alu.nombre;

-- *** Subconsultas ***
-- 15  Cantidad de alumnos aprobados por ciudad, usando una subconsulta
 select count(id_alumno) cant, ciudad
 from alumnos
 where id_alumno in (select distinct fk_alumno  from notas  Where nota >=5 ) 
 group by ciudad;  

-- 16 Notas de las asignaturas de cada uno de los alumnos comparada con la nota media de la asignatura
 
	-- nota media de cada asignatura (tabla media_asignaturas)
 select asignaturas.*, avg(nota) nota_media 
 from notas 
 join asignaturas on fk_asignatura = id_asignatura
 group by fk_asignatura;
 
 
 select alu.id_alumno, alu.nombre , n.nota, media_asignaturas.asignatura, media_asignaturas.nota_media
 from alumnos alu
 join notas n on n.fk_alumno=alu.id_alumno 
 join
	(select asignaturas.*, avg(nota) nota_media 
	from notas 
	join asignaturas on fk_asignatura = id_asignatura
	group by fk_asignatura ) media_asignaturas
 on n.fk_asignatura = media_asignaturas.id_asignatura where nota is not null;


-- 17 Alumnos que están cursando asignaturas con los profesores de Málaga (subconsulta en JOIN)
select distinct id_alumno,nombre, apellido1
from alumnos al join notas n on n.fk_alumno=al.id_alumno 
join (select ciudad,asignatura,id_asignatura
from asignaturas a join profesores p on a.fk_profesor=p.id_profesor where ciudad='Malaga') b
on n.fk_asignatura=b.id_asignatura;



-- 18 Nota media por asignatura, sólo aquéllas que la nota media sea mayor a la nota media del alumnos con dni 55630078R

select avg(nota) media,asignatura , id_asignatura
from notas join asignaturas on fk_asignatura=id_asignatura 
group by id_asignatura
having media > (select avg(nota) media
from notas 
join alumnos on fk_alumno=id_alumno
where dni= '55630078R');




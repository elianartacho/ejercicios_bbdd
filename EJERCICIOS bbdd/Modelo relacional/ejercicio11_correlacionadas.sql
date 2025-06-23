use 02_tienda;

-- subconsultas correlacionadas

select p.producto, p.precio, (select avg(precio) from productos where id_producto !=p.id_producto)
from productos p;

select alu.id_alumno,alu.apellido1, a.id_asignatura, a.asignatura, n.nota, medias.media,
(select avg(nota) from notas 
where  fk_alumno != alu.id_alumno and fk_asignatura = a-id_asignatura) media_resto
from alumnos alu
join notas n on alu.id.alumno= n.fk_alumno
join asignaturas a on n.fk_asignatura = a.id_asignatura
join (select fk_asignatura ,avg(nota) media
from notas
group by fk_asigantura) medias on n.fk_asignatura=medias.fk_asignatura where n.nota is not null;


-- alumnos que no cursas asignaturas 
use 06_universidad;

select *
from alumnos a
where not exists(select * from notas where fk_alumno =a.id_alumno);

select * 
from alumnos a
left join notas  on a.id_alumno = fk_alumno
where fk_alumno is null;




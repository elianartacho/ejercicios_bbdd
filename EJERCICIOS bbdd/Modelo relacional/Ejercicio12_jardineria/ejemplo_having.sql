select * from detalles_pedido;


select fk_producto, sum(cantidad) cant
from detalles_pedido
where precio_unidad > 50
group by fk_producto
having cant > 20;
SELECT * FROM 01_negocio.productos;
select * from productos;
update productos set prod_precio =12.50 where idproducto =23;

rollback;

select @@autocommit;
set autocommit =0;

update productos set prod_precio =100 where idproducto =23;
commit;
rollback;






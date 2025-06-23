drop database if exists 03_alquiler_coches;
create database 03_alquiler_coches;
use 03_alquiler_coches;

create table marcas(
	id_marca int AUTO_INCREMENT,
    marca varchar(30) not null unique,
    primary key (id_marca)
);

create table modelos(
	id_modelo int AUTO_INCREMENT,
    modelo varchar(30) not null unique,
    fk_marca int not null,
    primary key(id_modelo),
	foreign key (fk_marca) references marcas(id_marca)

);

create table coches(
	id_coche int AUTO_INCREMENT,
    matricula varchar(10) not null unique,
    color varchar(20) not null,
    precio_alquiler decimal(8,2) not null,
    fk_modelo int not null,
    primary key(id_coche),
	foreign key (fk_modelo) references modelos(id_modelo)
);

create table coches_por_reservas(
	fk_coche int,
    fk_reserva int,
    litros int not null,
    km_inicio int not null,
    km_fin int,
    primary key (fk_coche, fk_reserva),
    constraint cpr_coches foreign key (fk_coche) references coches(id_coche),
    foreign key (fk_reserva) references reservas(id_reserva)
);
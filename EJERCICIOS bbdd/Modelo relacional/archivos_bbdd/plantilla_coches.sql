drop database if exists Alquiler_coches;

create database Alquiler_coches;

use Alquiler_coches;
create table Marcas(
id_marca int primary key auto_increment,
marca varchar(20) not null
 );
 create table Modelos(
 id_modelo int primary key auto_increment,
 modelo varchar (30) not null,
 fk_marca int not null,
 constraint modelos_marcas foreign key (fk_marca)
 references Marcas(id_marca)
 );
 create table Coches(
 id_coche int primary key auto_increment,
 precio_alquiler decimal ,
 matricula varchar(15) not null unique key,
 color varchar(15) ,
 fk_modelo int not null,
 constraint coches_modelos foreign key (fk_modelo) references Modelos (id_modelo)
 );
create table Clientes(
id_cliente int primary key auto_increment,
dni varchar(10) not null unique key,
telefono varchar(15),
direccion varchar(50),
nombre varchar(15)
);

create table Reservas(
id_reserva int primary key ,
fecha_inicio date ,
fecha_fin date,
precio_total decimal,
fk_cliente int not null,
constraint reserva_cliente foreign key (fk_cliente) references Clientes (id_cliente)
); 

 create table coches_por_reserva(
 primary key (fk_coche, fk_reserva),
 fk_coche int,
 fk_reserva int,
 litros_gasolina int not null,
 Km_inicio int not null,
 Km_fin int,
 foreign key (fk_coche) references Coches (id_coche),
 foreign key (fk_reserva) references Reservas (id_reserva)
 );
 
 create table Avales(
 primary key (fk_cliente, fk_reserva),
 fk_cliente int,
 fk_reserva int,
 porcentaje varchar(5),
 foreign key(fk_cliente) references Clientes (id_cliente),
 foreign key(fk_reserva) references Reservas (id_reserva)
 );
 
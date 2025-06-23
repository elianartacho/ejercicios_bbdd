
create database despacho_abogados;
use despacho_abogados;

create table personas(
id_persona int auto_increment primary key,
DNI varchar(20) unique,
nombre varchar (45) ,
apellidos varchar (45),
telefono varchar (45),
direccion varchar (100));

create table empleados(
matricula int unique ,
id_empleado varchar(20) primary key,
constraint personal_empleado foreign key (id_empleado) references personas (id_persona)
);

create table clientes(
id_cliente varchar(20)  primary key,
foreign key (id_cliente) references personas (id_persona)
);

create table procuradores(
fecha_ingreso date ,
id_procurador varchar(20) primary key ,
foreign key (id_procurador) references empleados (id_empleado)

);
create table abogados (
nro_matricula varchar (15) not null unique,
id_abogado varchar(20) primary key ,
foreign key (id_abogado) references empleados (id_empleado)
);
create table expedientes(
N_expediente int primary key,
descripcion varchar (35) not null,
decripcion_detallada varchar (35) ,
fecha_inicial date ,
fecha_final date,
fk_id_cliente varchar(20) not null,
fk_id_abogado varchar(20) ,
foreign key (fk_id_cliente) references clientes (id_cliente),
foreign key (fk_id_abogado) references abogados  (id_abogado)
);

create table intervenciones(
id_gestion int primary key,
fecha date ,
hora time ,
fk_N_expediente int not null,
fk_id_empleado varchar (20) ,
foreign key (fk_N_expediente ) references expedientes (N_expediente ),
foreign key (fk_id_empleado) references empleados (id_empleado)
);


create table estados(
n_estado int auto_increment primary key

);

create table exped_estados(
fecha date ,
fk_n_estado int ,
fk_N_expediente int,
primary key (fk_n_estado, fk_N_expediente),
foreign key (fk_n_estado) references estados (n_estado),
foreign key (fk_N_expediente) references expedientes (N_expediente)
);
create table especialidades (
n_especialidad varchar (45) primary key 
);

create table abg_tienen_espe(
fk_n_especialidad varchar(45)  ,
fk_id_abogado varchar(20) not null ,
primary key (fk_n_especialidad, fk_id_abogado),
foreign key (fk_n_especialidad) references especialidades(n_especialidad),
foreign key (fk_id_abogado) references abogados(id_abogado)  

);

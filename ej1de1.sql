create database ej1de1
go
use ej1de1

create table provincias
(
	idprovincia tinyint identity(1,1) primary key,
	provincia varchar(30),
)

create table localidades
(
	codigoPostal int not null primary key,
	nombre varchar(30) not null,
	idprovincia tinyint foreign key references provincias(idprovincia),
)

create table marcas
(
	idmarca bigint identity (1,1) not null primary key,
	marca nvarchar(20) not null,
)

create table vehiculos
(
	patente varchar(10) not null primary key,
	marca bigint foreign key references marcas(idmarca),

)

create table tiposDeMultas
(
	idtipo bigint identity (1,1) primary key,
	tipo varchar(30) not null,
	importe money check(importe > 0),
)

create table agentes_transito
(
	legajo int identity(1,1) not null,
	nombres varchar(50) not null,
	apellidos varchar(50) not null,
	fchaNacimiento date not null,
	fchaIngreso date not null,
	sueldo money check(sueldo>0) not null,
	email nvarchar(50) null,
	telefono nvarchar(30) null,
	estado bit not null,
	primary key(legajo),
)

create table multas
(
	idmulta bigint identity(1,1) primary key,
	idtipo bigint foreign key references tiposDeMultas(idtipo),
	patente varchar(10) not null foreign key references vehiculos(patente),
	fchaInfraccion date not null,
	localidad int foreign key references localidades(codigoPostal),
	agente int null foreign key references agentes_transito(legajo),
	--importe 
	pagado bit not null,
	  
)
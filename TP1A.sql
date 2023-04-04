Create database tp1a
go

use tp1a
go


CREATE TABLE MARCAS
(
	CODIGO BIGINT IDENTITY(1,1) PRIMARY KEY,
	DESCRIPCION NVARCHAR(30) NOT NULL,
)

CREATE TABLE TIPO_ARTICULOS
(
	IDTIPO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TIPO VARCHAR(30),
	
)

CREATE TABLE PROVINCIAS
(
	IDPROVINCIA TINYINT PRIMARY KEY,
	NOMBRE VARCHAR(50),
)

CREATE TABLE LOCALIDADES
(
	IDPROVINCIA TINYINT FOREIGN KEY REFERENCES PROVINCIAS(IDPROVINCIA),
	CODIGOPOSTAL INT NOT NULL PRIMARY KEY,
	NOMBRE VARCHAR(50) NOT NULL,
)

CREATE TABLE ARTICULOS
(

	CODIGO VARCHAR(6) PRIMARY KEY,
	DESCRIPCION VARCHAR(50) NOT NULL,
	MARCA BIGINT FOREIGN KEY REFERENCES MARCAS(CODIGO),
	PRECIOVENTA MONEY NOT NULL CHECK(PRECIOVENTA>0),
	PRECIOCOMPRA MONEY NOT NULL CHECK(PRECIOCOMPRA>0),
	TIPOARTICULO INT FOREIGN KEY REFERENCES TIPO_ARTICULOS(IDTIPO),
	STOCKACTUAL INT NOT NULL CHECK(STOCKACTUAL>0),
	STOCKMINIMO INT NOT NULL CHECK(STOCKMINIMO>0),
	ESTADO BIT,

)



CREATE TABLE CLIENTES
(
	DNI INT NOT NULL PRIMARY KEY,
	APELLIDO VARCHAR(100) NOT NULL,
	NOMBRE VARCHAR(100) NOT NULL,
	SEXO CHAR(1) CHECK(SEXO = 'M' OR SEXO='F'),
	TELEFONO NVARCHAR(30),
	MAIL NVARCHAR(30),
	FECHAALTA DATE,
	FECHANACIMIENTO DATE,
	EDAD TINYINT CHECK(EDAD>0),
	DIRECCION VARCHAR(100) NOT NULL,
	CODIGOPOSTAL INT FOREIGN KEY REFERENCES LOCALIDADES(CODIGOPOSTAL),
	
)


CREATE TABLE VENDEDORES
(
	DNI INT NOT NULL UNIQUE,
	LEGAJO INT PRIMARY KEY,
	APELLIDO VARCHAR(100) NOT NULL, 
	NOMBRE VARCHAR(100) NOT NULL,
	SEXO CHAR(1) CHECK(SEXO='F' OR SEXO='M'),
	FECHANAC DATE NOT NULL,
	DIRECCION VARCHAR(100) NOT NULL,
	CODIGOPOSTAL INT FOREIGN KEY REFERENCES LOCALIDADES(CODIGOPOSTAL),
	TELEFONO NVARCHAR(30),

)


CREATE TABLE DETALLE_VENDEDOR
 (
	LEGAJO INT PRIMARY KEY FOREIGN KEY REFERENCES VENDEDORES(LEGAJO),
	FECHAINGRESO DATE NOT NULL,
	SUELDO MONEY CHECK(SUELDO>0),
	--TOTALVENTAS MONEY,
	--TOTALFACTURADO MONEY,
 )

 CREATE TABLE VENTAS
(
	IDFACTURA BIGINT NOT NULL IDENTITY (1,1) PRIMARY KEY,
	FECHAVENTA DATE NOT NULL,
	CLIENTE INT NOT NULL FOREIGN KEY REFERENCES CLIENTES(DNI),
	VENDEDOR INT FOREIGN KEY REFERENCES VENDEDORES(LEGAJO),
	FORMAPAGO CHAR(1) CHECK(FORMAPAGO = 'E' OR FORMAPAGO ='T'),
	IMPORTETOTAL MONEY ,
)

CREATE TABLE DETALLE_VENTA
(
	IDFACTURA BIGINT FOREIGN KEY REFERENCES VENTAS(IDFACTURA),
	ARTICULO VARCHAR(6) NOT NULL FOREIGN KEY REFERENCES ARTICULOS(CODIGO),
	PRECIO MONEY NOT NULL CHECK(PRECIO>0),
	CANTIDAD INT NOT NULL,
	PRIMARY KEY (IDFACTURA,ARTICULO),
)

--NORMALIZAR LA BASE DE DATOS

--ESCRIBIR EL CODIGO SQL
--GENERAR EL DIAGRAMA DE BASE DE DATOS
--4 CONTESTAR
-- A. COMO SERIA LA MEJOR FORMA DE INDICAR QUE UN ARTICULO NO POSEE MARCA? 
---RESP. AGREGAR SIN MARCA?
--B, CONSIDERA CORRECTO ALMACENAR PRECIO UNITARIOO AL MOMENTO DE LA COMPRA? POR QUE?
---RESP. DEPENDE, AUNQUE EN ESTE CASO N ES CORRECTO YA QUE EL ARTICULO YA POSEE EL PRECIO
--C. QUE TIPO DE COLUMNA ME PERMITE GENERAR UN NUMERO CORRELATIVO PARA EL CODIGO DE FACTURA?
--RESP. IDENTITY DE 1 EN 1
--- D, QUE OCURRE CON LAS COLUMNAS TOTAL DE VENTAS REALIZADAS EN EL ULTIMO MES Y TOTAL FACTURADO EN EL ULTIMO MES?
---NO LO ENTIENDO NO ES LO MISMO? TOTAL VENTAS DE ULTIMO MES? Y SE PODRIA CALCULAR DIRECTAMENTE CON LAS VENTAS NO  HARIA FALTA
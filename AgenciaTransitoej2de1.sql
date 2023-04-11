
Create Database AgenciaTransito
Go
Use AgenciaTransito
go
CREATE TABLE Provincias(
    IDProvincia smallint not null primary key identity (1, 1),
    Provincia varchar(50) not null
)
go
CREATE TABLE Localidades(
    IDLocalidad int not null primary key identity (1, 1),
    Localidad varchar(150) not null,
    IDProvincia smallint not null foreign key references Provincias(IDProvincia)
)
Go
CREATE TABLE TipoInfracciones (
    IdTipoInfraccion INT NOT NULL PRIMARY KEY identity (1, 1),
    Descripcion VARCHAR(100),
    ImporteReferencia MONEY NOT NULL
);
go
CREATE TABLE Agentes (
    IdAgente INT NOT NULL PRIMARY KEY identity (1, 1),
    Legajo varchar(10) NOT NULL UNIQUE,
    Nombres VARCHAR(50) NOT NULL,
    Apellidos VARCHAR(50) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    FechaIngreso DATE NOT NULL,
    Email VARCHAR(100) NULL,
    Telefono VARCHAR(20) NULL,
    Celular VARCHAR(20) NULL,
    Activo BIT NOT NULL
);

alter table agentes
add sueldo money not null default(100000)

GO
CREATE TABLE Multas (
    IdMulta INT NOT NULL PRIMARY KEY IDENTITY (1, 1),
    IdTipoInfraccion INT NOT NULL FOREIGN KEY REFERENCES TipoInfracciones(IdTipoInfraccion),
    IDLocalidad INT NOT NULL FOREIGN KEY REFERENCES Localidades(IDLocalidad),
    IdAgente INT NULL FOREIGN KEY REFERENCES Agentes(IdAgente),
    Patente VARCHAR(10) NOT NULL,
    FechaHora DATETIME NOT NULL,
    Monto MONEY NOT NULL,
    Pagada BIT NOT NULL DEFAULT (0)
);


-- Restricciones Multas
Alter Table Multas
Add Constraint FK_Multas_Localidades Foreign Key (IDLocalidad) References Localidades(IDLocalidad)
Go
Alter Table Multas
Add Constraint FK_Multas_TipoInfracciones Foreign Key (IDTipoInfraccion) References TipoInfracciones(IDTipoInfraccion)
Go
Alter Table Multas
Add Constraint FK_Multas_Agentes Foreign Key (IDAgente) References Agentes(IDAgente)
GO
Alter Table Multas
Add Constraint CHK_Monto_Positivo Check(Monto > 0)
go
-- Restricciones Agentes
Alter Table Agentes
Add Constraint UQ_Legajo Unique(Legajo)
go
-- Restricciones Localidades
Alter Table Localidades
Add Constraint FK_Localidades_Provincias Foreign key (IDProvincia) References Provincias(IDProvincia)
go
-- Agregamos una columna, la modificamos y luego la borramos
Alter Table Agentes
Add EstadoCivil varchar(20) null
go
Alter Table Agentes
Alter Column EstadoCivil varchar(50) not null
go
Alter Table Agentes
Drop Column EstadoCivil
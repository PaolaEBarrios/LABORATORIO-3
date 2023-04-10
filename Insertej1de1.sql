
insert into provincias values ('Buenos Aires')
insert into provincias values ('Cordoba')


insert into localidades(codigoPostal,nombre,idprovincia) values (1623,'Ingeniero Maschwitz',1)
insert into localidades(codigoPostal, nombre, idprovincia) values (1648, 'Tigre',1)
insert into localidades(codigoPostal, nombre, idprovincia) values (5010,'Barrio General Lamadrid',2)

insert into marcas values ('Ford')
insert into marcas values ('Renault')

insert into vehiculos(patente, marca) values ('a1111',1)
insert into vehiculos(patente, marca) values ('b1111',2)
insert into vehiculos(patente, marca) values ('c1111',2)

insert into tiposDeMultas(tipo, importe) values ('No respetar semaforo', 10000)
insert into tiposDeMultas(tipo, importe) values ('Exceso de velocidad', 15000)
insert into tiposDeMultas(tipo, importe) values ('Mal estacionado', 5000)


insert into agentes_transito(nombres,apellidos,fchaNacimiento,fchaIngreso,sueldo, email,telefono,estado) values ('PEPE','AGUIRRE','1995-05-12','2004-02-11',80000,null,'11223344',1)
insert into agentes_transito(nombres,apellidos,fchaNacimiento,fchaIngreso,sueldo, email,telefono,estado) values ('JUAN','PERALTA','1989-03-3','2010-06-1',100000,'PERALTA@GMAIL.COM','11333333',1)

insert into multas(idtipo,patente,fchaInfraccion,localidad,agente,pagado) values(1,'a1111','2022-09-5',1648,2,0)
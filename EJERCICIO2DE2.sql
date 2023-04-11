--1
--Listado con las localidades, su ID, nombre y el nombre de la provincia a la que pertenece. 
Select l.idlocalidad,l.localidad,p.provincia from localidades as l
inner join provincias as p
on l.idprovincia=p.idprovincia

--2
--Listado que informe el ID de la multa, el monto a abonar y los datos del agente que la realizó. 
--Debe incluir los apellidos y nombres de los agentes. Así como también la fecha de nacimiento y la edad.

select m.IdMulta, m.Monto,a.Apellidos,a.Nombres,a.FechaNacimiento,year(getdate())-YEAR(a.FechaNacimiento) as Edad from agentes as a
inner join Multas as m
on m.IdAgente=a.IdAgente

--3
--Listar todos los datos de todas las multas realizadas por agentes que a la fecha de hoy tengan más de 5 años de antigüedad.
Select * from multas as m
inner join agentes as a
on a.IdAgente=m.IdAgente
where year(getdate())-year(a.FechaIngreso)>5

--4
--Listar todos los datos de todas las multas cuyo importe de referencia supere los $15000.

Select * from multas as m
inner join TipoInfracciones as t
on t.IdTipoInfraccion=m.IdTipoInfraccion
where t.ImporteReferencia>15000

--5
--Listar los nombres y apellidos de los agentes, sin repetir, que hayan labrado multas en la provincia de Buenos Aires o en Cordoba.

select distinct a.Nombres,a.Apellidos from Agentes as a
inner join multas as  m
on m.IdAgente=a.IdAgente
inner join Localidades as l
on l.IDLocalidad=m.IDLocalidad
inner join Provincias as p
on p.IDProvincia=l.IDProvincia
where p.Provincia='Buenos Aires' or p.Provincia='Cordoba'


--6
--Listar los nombres y apellidos de los agentes, sin repetir, que hayan labrado multas del tipo "Exceso de velocidad".

Select distinct a.Apellidos,a.Nombres from agentes as a
inner join multas as m
on m.IdAgente=a.IdAgente
inner join TipoInfracciones as t
on t.IdTipoInfraccion=m.IdTipoInfraccion
where t.Descripcion='Exceso de velocidad'

--7
--Listar apellidos y nombres de los agentes que no hayan labrado multas.

select a.Apellidos,a.Nombres from Agentes as a
left join Multas as m
on m.IdAgente=a.IdAgente
where m.IdAgente is null

--8
--Por cada multa, lista el nombre de la localidad y provincia, el tipo de multa, 
--los apellidos y nombres de los agentes y su legajo, el monto de la multa y 
--la diferencia en pesos en relación al tipo de infracción cometida.

Select l.Localidad,p.Provincia,t.Descripcion, a.Apellidos,a.Legajo,m.Monto, (m.Monto-t.ImporteReferencia) as diferencia
from multas as m
inner join Localidades as l
on l.IDLocalidad=m.IDLocalidad
inner join Provincias as p
on p.IDProvincia=l.IDProvincia
inner join Agentes as a
on a.IdAgente=m.IdAgente
inner join TipoInfracciones as t
on t.IdTipoInfraccion=m.IdTipoInfraccion

--9
--Listar las localidades en las que no se hayan registrado multas.

Select * from Localidades as l
left join Multas as m
on m.IDLocalidad=l.IDLocalidad
where m.IDLocalidad is null


--10
--Listar los datos de las multas pagadas que se hayan labrado en la provincia de Buenos Aires.

select * from multas as m
inner join Localidades as l
on l.IDLocalidad=m.IDLocalidad
inner join Provincias as p
on p.IDProvincia=l.IDProvincia
where m.Pagada=1 and p.Provincia='Buenos Aires'

--11
--Listar el ID de la multa, la patente, el monto y el importe de referencia a partir del tipo de infracción cometida. 
--También incluir una columna llamada TipoDeImporte a partir de las siguientes condiciones:
--'Punitorio' si el monto de la multa es mayor al importe de referencia
--'Leve' si el monto de la multa es menor al importe de referencia
--'Justo' si el monto de la multa es igual al importe de referencia

Select m.IdMulta,m.Patente,m.Monto, t.ImporteReferencia,
case 
when t.ImporteReferencia<m.Monto then 'PUNITORIO' 
when t.ImporteReferencia>m.Monto then 'LEVE'
else 
	'JUSTO'
	END
	AS 'TipoDeImporte'
from multas as m	
inner join TipoInfracciones as t
on t.IdTipoInfraccion=m.IdTipoInfraccion

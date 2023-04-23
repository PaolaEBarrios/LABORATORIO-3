--Actividad 2.3

--1
--Listado con la cantidad de agentes
Select COUNT(*) as cantAgentes from Agentes as a

--2
--Listado con importe de referencia promedio de los tipos de infracciones
Select AVG(ti.ImporteReferencia)as PromedioReferencia from TipoInfracciones as ti


--3
--Listado con la suma de los montos de las multas. Indistintamente de si fueron pagadas o no.
Select SUM(m.Monto) from Multas as m

--4
--Listado con la cantidad de pagos que se realizaron.
Select count(m.Monto) from Multas as m
where m.Pagada=1

--5
--Listado con la cantidad de multas realizadas en la provincia de Buenos Aires.
--NOTA: Utilizar el nombre 'Buenos Aires' de la provincia.
Select count(m.IdMulta) as MultasEnBSAS from Multas as m
inner join Localidades as l
on l.IDLocalidad=m.IDLocalidad
inner join Provincias as p
on p.IDProvincia=l.IDProvincia
where p.Provincia='Buenos Aires'

--6
--Listado con el promedio de antigüedad de los agentes que se encuentren activos.

Select AVG(year(getdate())-Year(a.FechaIngreso)) as PROMEDIOANTIGUEDAD from Agentes as a
where a.Activo=1

--7
--Listado con el monto más elevado que se haya registrado en una multa.
Select MAX(m.Monto) as MontoMasAlto from multas as m

--8
--Listado con el importe de pago más pequeño que se haya registrado.
Select Min(m.Monto) from multas as m
where Pagada=1

--9
--Por cada agente, listar Legajo, Apellidos y Nombres y la cantidad de multas que registraron.
Select distinct a.Legajo,a.Apellidos,a.Nombres,count(m.IdMulta) AS cantMultas  from Agentes as a
inner join multas as m
on m.IdAgente=a.IdAgente
group by a.Legajo,a.Apellidos,a.Nombres

--10
--Por cada tipo de infracción, listar la descripción y el promedio de montos de las multas asociadas a dicho tipo de infracción.
Select ti.Descripcion,AVG(m.Monto) from multas as m
inner join TipoInfracciones as ti
on ti.IdTipoInfraccion=m.IdTipoInfraccion
group by ti.IdTipoInfraccion, ti.Descripcion

--11
--Por cada multa, indicar la fecha, la patente, el importe de la multa y la cantidad de pagos realizados. 
--Solamente mostrar la información de las multas que hayan sido pagadas en su totalidad.

Select distinct m.IdMulta,m.FechaHora, m.Patente, p.importe, count(p.idmulta) from multas as m
inner join Pagos as p
on m.IdMulta=p.idmulta
group by m.IdMulta,m.FechaHora,m.patente,p.importe
order by m.IdMulta asc
--IMPORTE DE MONTOS MULTAS
Select distinct m.IdMulta,m.FechaHora, m.Patente,	m.Monto, count(p.idmulta) as 'CANT DE PAGOS' from multas as m
inner join Pagos as p
on m.IdMulta=p.idmulta
group by m.IdMulta,m.FechaHora,m.patente,m.monto
order by m.IdMulta asc

--12
--Listar todos los datos de las multas que hayan registrado más de un pago.

Select m.IdMulta,m.IdAgente,m.IDLocalidad,m.FechaHora,m.IdTipoInfraccion,m.Monto,m.Patente,m.Patente from multas as m
inner join pagos as p
on p.idmulta=m.IdMulta
group by m.IdMulta,m.IdAgente,m.IDLocalidad,m.FechaHora,m.IdTipoInfraccion,m.Monto,m.Patente,m.Patente
having count(p.idmulta)>1


--13
--Listar todos los datos de todos los agentes que hayan registrado multas con un monto que en promedio supere los $10000
Select * from Agentes as a
inner join multas as m
on m.IdAgente=a.IdAgente


--14
--Listar el tipo de infracción que más cantidad de multas haya registrado.
Select top (1) with ties ti.Descripcion,count(m.IdTipoInfraccion) as 'Cant De Infracciones' from TipoInfracciones as ti
inner join multas as m
on m.IdTipoInfraccion=ti.IdTipoInfraccion
group by ti.Descripcion
order by count(m.IdTipoInfraccion) desc

--15
--Listar por cada patente, la cantidad de infracciones distintas que se cometieron.
Select distinct m.Patente, count(distinct m.IdTipoInfraccion) from multas as m
inner join TipoInfracciones as ti
on ti.IdTipoInfraccion=m.IdTipoInfraccion
group by m.Patente
order by m.Patente asc

--16
--Listar por cada patente, el texto literal 'Multas pagadas' y el monto total de los pagos registrados por esa patente. 
--Además, por cada patente, el texto literal 'Multas por pagar' y el monto total de lo que se adeuda.

Select distinct m.Patente, ' MULTAS PAGADAS' ,SUM(p.importe),' MULTAS POR PAGAR ',SUM(m.Monto) from multas as m
inner join pagos as p
on p.idmulta=m.IdMulta
group by m.Patente


--17
--Listado con los nombres de los medios de pagos que se hayan utilizado más de 3 veces.
Select mp.nombre from MediosPago as Mp
inner join pagos as p
on p.idmediopago=mp.idmediopago
group by mp.nombre
having count(p.idmediopago)>3



--18
--Los legajos, apellidos y nombres de los agentes que hayan labrado más de 2 multas con tipos de infracciones distintas.


--19
--El total recaudado en concepto de pagos discriminado por nombre de medio de pago.


--20
--Un listado con el siguiente formato:

--Descripción        Tipo           Recaudado
-------------------------------------------------
--Tigre              Localidad      $xxxx
--San Fernando       Localidad      $xxxx
--Rosario            Localidad      $xxxx
--Buenos Aires       Provincia      $xxxx
--Santa Fe           Provincia      $xxxx
--Argentina          País           $xxxx




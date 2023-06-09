--Actividad 2.4

--1
--La patente, apellidos y nombres del agente que labr√≥ la multa y monto de aquellas multas que superan el monto promedio.
use AgenciaTransito

SELECT M.PATENTE, A.Apellidos,A.Nombres, M.monto FROM AGENTES AS A
inner join Multas as m 
on m.IdAgente=a.IdAgente
where m.Monto>
(
	SELECT AVG(M.Monto) FROM MULTAS AS M
)
order by m.Patente asc


--2
--Las multas que sean m√°s costosas que la multa m√°s costosa por 'No respetar se√±al de stop'.

SELECT * FROM MULTAS AS M
Where m.Monto > 
(
	SELECT MAX(M.MONTO) FROM MULTAS AS  M
	INNER JOIN TipoInfracciones AS TP
	ON TP.IdTipoInfraccion=M.IdTipoInfraccion
	WHERE TP.Descripcion='No respetar se√±al de stop'
)

--3
--Los apellidos y nombres de los agentes que no hayan labrado multas en los dos primeros meses de 2023.

Select a.Apellidos,a.Nombres from agentes as a
where a.IdAgente not in
(

	Select a.IdAgente from Multas as m
	inner join Agentes as a
	on a.IdAgente=m.IdAgente
	where year(m.FechaHora) = 2023 and (MONTH(m.FechaHora) between 01 and 02)
	
)


--4
--Los apellidos y nombres de los agentes que no hayan labrado multas por 'Exceso de velocidad'.

Select a.Apellidos,a.Nombres from Agentes as a
where a.IdAgente not in
(

	select a.IdAgente from multas as m
	inner join agentes as a
	on a.IdAgente=m.IdAgente
	inner join TipoInfracciones as ti
	on ti.IdTipoInfraccion=m.IdTipoInfraccion
	where ti.descripcion ='Exceso de velocidad'
)
order by a.Apellidos asc

--5
--Los legajos, apellidos y nombre de los agentes que hayan labrado multas de todos los tipos de infracciones existentes.

Select a.Legajo,a.Apellidos,a.Nombres from agentes as a
inner join multas as m
on m.IdAgente=a.IdAgente
inner join TipoInfracciones as ti
on ti.IdTipoInfraccion=m.IdTipoInfraccion
group by a.legajo,a.apellidos,a.nombres
having count(distinct m.IdTipoInfraccion) >=
(
	Select count(ti.IdTipoInfraccion) from TipoInfracciones as ti
)


--6
--Los legajos, apellidos y nombres de los agentes que hayan labrado m√°s cantidad de multas que la cantidad de multas generadas por un radar
--(multas con IDAgente con valor NULL)

Select a.Legajo,a.Apellidos,a.Nombres from Agentes as a
inner join multas as m
on m.IdAgente=a.IdAgente
group by a.Legajo,a.Apellidos,a.Nombres
having count(m.idagente) >
(
	Select count(m.IdMulta) from Multas as m
	where m.IdAgente is null
)

--7
--Por cada agente, listar legajo, apellidos, nombres, cantidad de multas realizadas durante el d√≠a 
--y cantidad de multas realizadas durante la noche.
--NOTA: 
--El turno noche ocurre pasadas las 20:00 y antes de las 05:00.

Select 
a.legajo,a.Apellidos,a.Nombres,
(select count(m.IdAgente) from multas as m where (datepart(hour, m.FechaHora) between '20' and '23' or datepart(hour,m.FechaHora) between '1' and '4' or datepart(hour,m.FechaHora) = '00')  and a.IdAgente=m.IdAgente) as 'multas de noche',
(select count(m.IdAgente) from multas as m where datepart(hour, m.FechaHora) between '5' and '19' and a.IdAgente=m.IdAgente) as 'multas de dia' 
from agentes as a
group by a.IdAgente,a.Legajo,a.Apellidos,a.Nombres



--select a.Apellidos, count(*) as 'multas', m.FechaHora from multas as m
--inner join agentes as a
--on a.IdAgente=m.IdAgente
--where a.Apellidos='Gomez' or a.Apellidos='Sanchez' or a.Apellidos = 'Lopez' or a.Apellidos= 'Hernandez'
--group by a.Legajo,m.Fechahora,a.Apellidos
--order by a.Apellidos asc
-------------------------------------------------------------------------------------------------------------

--8
<<<<<<< HEAD
--Por cada patente, el total acumulado de pagos realizados con medios de pago no electrÛnicos
--y el total acumulado de pagos realizados con alg˙n medio de pago electrÛnicos.

Select distinct Patente,
(Select sum(p.importe))


from Multas as M




--9
--La cantidad de agentes que hicieron igual cantidad de multas por la noche que durante el dÌa.

select count(m.IdAgente) from agentes as a
inner join multas as m
on m.IdAgente=a.IdAgente
where 
	(datepart(hour, m.FechaHora) between '20' and '23' or datepart(hour,m.FechaHora) between '1' and '4' 
		or datepart(hour,m.FechaHora) = '00')
		
(select count(m.IdAgente) from multas as m where datepart(hour, m.FechaHora) between '5' and '19' and a.IdAgente=m.IdAgente)



--10
--Las patentes que, en total, hayan abonado m·s en concepto de pagos
--con medios no electrÛnicos que pagos con medios electrÛnicos.
--Pero debe haber abonado tanto con medios de pago electrÛnicos como con medios de pago no electrÛnicos.
Select m.Patente
from multas as m
inner join pagos as p
on p.IDMulta=m.IdMulta
inner join MediosPago as mp
on mp.IDMedioPago=p.IDMedioPago
where
(
	select sum(p.Importe) from pagos as p 
	inner join 
	MediosPago as mp 
	on mp.IDMedioPago=p.IDMedioPago
	having  count(p.IDMedioPago)>1 and mp.Nombre='Efectivo'
) < ---es menor a
(
	select sum(p.Importe) from pagos as p inner join 
	MediosPago as mp
	on mp.IDMedioPago=p.IDMedioPago
	having count (p.IDMedioPago)>1 and mp.Nombre not like 'Efectivo'
)



select m.patente, p.Importe,mp.Nombre from multas as m
inner join pagos as p
on p.IDMulta= m.IdMulta
inner join MediosPago as mp
on mp.IDMedioPago=p.IDMedioPago
group by m.Patente,p.Importe,mp.Nombre

--11
--Los legajos, apellidos y nombres de agentes que hicieron m·s de dos multas durante el dÌa y ninguna multa durante la noche.


=======
--Por cada patente, el total acumulado de pagos realizados con medios de pago no electr√≥nicos y el total acumulado de pagos realizados con alg√∫n medio de pago electr√≥nicos.
--9
--La cantidad de agentes que hicieron igual cantidad de multas por la noche que durante el d√≠a.
--10
--Las patentes que, en total, hayan abonado m√°s en concepto de pagos con medios no electr√≥nicos que pagos con medios electr√≥nicos. Pero debe haber abonado tanto con medios de pago electr√≥nicos como con medios de pago no electr√≥nicos.
--11
--Los legajos, apellidos y nombres de agentes que hicieron m√°s de dos multas durante el d√≠a y ninguna multa durante la noche.
>>>>>>> 16227de0e0b0a09fa3e1f82fd7dc9e2f2856ef2f
--12
--La cantidad de agentes que hayan registrado m√°s multas que la cantidad de multas generadas por un radar (multas con IDAgente con valor NULL)

--probando una actualizcion de git remota para local




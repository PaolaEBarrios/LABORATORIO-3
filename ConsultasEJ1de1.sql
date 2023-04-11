--1
--Apellido, nombres y fecha de ingreso de todos los agentes
Select a.Apellidos,a.Nombres, a.FechaIngreso from Agentes as a

--2
--Apellido, nombres y antigüedad de todos los agentes
Select a.Apellidos,a.Nombres, (year(GETDATE())-year(a.FechaIngreso)) as antiguedad from agentes as a
 
--3
--Apellido y nombres de aquellos agentes que no estén activos.
select a.Apellidos,a.Nombres from agentes as a
where a.Activo = 0
--4
--Apellido y nombres y antigüedad de aquellos agentes cuyo sueldo sea entre 50000 y 100000.
select a.Apellidos,a.Nombres,(year(getdate())-year(a.FechaIngreso)) as antiguedad from agentes as a
where a.sueldo between 50000 and 100000
--5
--Apellidos y nombres y edad de los colaboradores con legajos A001, A005 y A015
select a.apellidos, a.Nombres,(year(getdate())-year(a.FechaNacimiento))as edad from agentes as a
where a.Legajo in('a001','a005','a015')
--6
--Todos los datos de todas las multas ordenadas por monto de forma descendente.
select * from multas as m
order by m.monto desc
--7
--Todos los datos de las multas realizadas en el mes 02 de 2023.
select * from multas as m
where year(m.FechaHora)=2023 and MONTH(m.fechahora)=2

--8
--Todos los datos de todas las multas que hayan superado el monto de $20000.
select * from multas as m
where m.Monto > 20000

--9
--Apellido y nombres de los agentes que no hayan registrado teléfono.
select a.Apellidos,a.Nombres from agentes as a
where a.Telefono is null
--10
--Apellido y nombres de los agentes que hayan registrado mail pero no teléfono.

select a.Nombres, a.Apellidos from agentes as a
where a.Telefono is null and a.Email is not null

--11
--Apellidos, nombres y datos de contacto de todos los agentes.
--Nota: En datos de contacto debe figurar el número de celular, si no tiene celular el número de teléfono fijo
--y si no tiene este último el mail. En caso de no tener ninguno de los tres debe figurar 'Incontactable'.

select a.Apellidos,a.Nombres,
case 
when a.Celular is not null then 'celular +'+a.Celular
when a.Telefono is not null then 'telefono +' +a.Telefono
when a.Email is not null then 'email + '+a.Email
--when a.celular is null and a.telefono is null and a.email is null then 'INCONTACTABLE'
ELSE
	'INCONTACTABLE'
end
as contacto
from agentes as a

--12
--Apellidos, nombres y medio de contacto de todos los agentes. Si tiene celular debe figurar 'Celular'. 
--Si no tiene celular pero tiene teléfono fijo debe figurar 'Teléfono fijo' de lo contrario y si tiene Mail debe figurar 'Email'.
--Si no posee ninguno de los tres debe figurar NULL.
Select a.Nombres,a.Apellidos,
case
when a.celular is not null then 'CELULAR'
when a.Telefono is not null then 'TELEFONO FIJO'
when a.Email is not null then 'Email'
else
	null
	END
	as 'MEDIO DE CONTACTO'
from Agentes as a

--13
--Todos los datos de los agentes que hayan nacido luego del año 2000

Select * from Agentes as a 
where year(a.FechaNacimiento)>2000

--14
--Todos los datos de los agentes que hayan nacido entre los meses de Enero y Julio (inclusive)
Select * from Agentes as a
where MONTH(a.FechaNacimiento) between '01'and '07'

--15
--Todos los datos de los agentes cuyo apellido finalice con vocal
Select * from Agentes as a 
where a.Apellidos like '%[aeiou]'

--16
--Todos los datos de los agentes cuyo nombre comience con 'A' y contenga al menos otra 'A'. Por ejemplo, Ana, Anatasia, Aaron, etc
Select * from Agentes as a
where a.Nombres like 'a%[a]'

--17
--Todos los agentes que tengan más de 10 años de antigüedad
Select * from Agentes as a 
where (year(GETDATE())-year(a.FechaIngreso)) > 10

--18
--Las patentes, sin repetir, que hayan registrado multas
Select distinct  m.Patente from Multas as m
--group by m.Patente

--19
--Todos los datos de todas las multas labradas en el mes de marzo de 2023 con un recargo del 25% en una columna llamada NuevoImporte.

Select m.FechaHora,m.IdAgente,m.Patente,m.IDLocalidad,m.IdMulta,m.Pagada,M.MONTO, (m.Monto*1.25) as 'NUEVO IMPORTE' from multas as m
where MONTH(m.FechaHora)=03

--20
--Todos los datos de todos los colaboradores ordenados por apellido ascendentemente en primera instancia y
--por nombre descendentemente en segunda instancia.

Select * from agentes as a
order by a.Apellidos asc



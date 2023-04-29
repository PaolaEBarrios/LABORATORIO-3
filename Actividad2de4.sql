--Actividad 2.4

--1
--La patente, apellidos y nombres del agente que labr� la multa y monto de aquellas multas que superan el monto promedio.

SELECT M.PATENTE, A.Apellidos,A.Nombres, M.monto FROM AGENTES AS A
inner join Multas as m 
on m.IdAgente=a.IdAgente
where m.Monto>
(
	SELECT AVG(M.Monto) FROM MULTAS AS M
)
order by m.Patente asc


--2
--Las multas que sean m�s costosas que la multa m�s costosa por 'No respetar se�al de stop'.

SELECT * FROM MULTAS AS M
Where m.Monto > 
(
	SELECT MAX(M.MONTO) FROM MULTAS AS  M
	INNER JOIN TipoInfracciones AS TP
	ON TP.IdTipoInfraccion=M.IdTipoInfraccion
	WHERE TP.Descripcion='No respetar se�al de stop'
)
--3
--Los apellidos y nombres de los agentes que no hayan labrado multas en los dos primeros meses de 2023.



--4
--Los apellidos y nombres de los agentes que no hayan labrado multas por 'Exceso de velocidad'.
--5
--Los legajos, apellidos y nombre de los agentes que hayan labrado multas de todos los tipos de infracciones existentes.
--6
--Los legajos, apellidos y nombres de los agentes que hayan labrado m�s cantidad de multas que la cantidad de multas generadas por un radar (multas con IDAgente con valor NULL)
--7
--Por cada agente, listar legajo, apellidos, nombres, cantidad de multas realizadas durante el d�a y cantidad de multas realizadas durante la noche.

--NOTA: El turno noche ocurre pasadas las 20:00 y antes de las 05:00.
--8
--Por cada patente, el total acumulado de pagos realizados con medios de pago no electr�nicos y el total acumulado de pagos realizados con alg�n medio de pago electr�nicos.
--9
--La cantidad de agentes que hicieron igual cantidad de multas por la noche que durante el d�a.
--10
--Las patentes que, en total, hayan abonado m�s en concepto de pagos con medios no electr�nicos que pagos con medios electr�nicos. Pero debe haber abonado tanto con medios de pago electr�nicos como con medios de pago no electr�nicos.
--11
--Los legajos, apellidos y nombres de agentes que hicieron m�s de dos multas durante el d�a y ninguna multa durante la noche.
--12
--La cantidad de agentes que hayan registrado m�s multas que la cantidad de multas generadas por un radar (multas con IDAgente con valor NULL)



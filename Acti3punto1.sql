--Actividad 3.1
use AgenciaTransito
--1
--Crear una vista llamada VW_Multas que permita visualizar la información de las multas con los datos del agente
--incluyendo apellidos y nombres, nombre de la localidad, patente del vehículo, fecha y monto de la multa.

Create VIEW VW_Multas as 
select a.Apellidos,a.Nombres,l.Localidad,m.Patente,m.FechaHora,m.Monto from agentes as a 
inner join Multas as m
on m.IdAgente=a.IdAgente
inner join Localidades as l
on l.IDLocalidad=m.IDLocalidad

Select * from VW_Multas

--2
--Modificar la vista VW_Multas para incluir el legajo del agente, la antigüedad en años, 
--el nombre de la provincia junto al de la localidad y la descripción del tipo de multa.

Alter view VW_MULTAS as 
SELECT A.Legajo,A.Apellidos,a.Nombres, YEAR(GETDATE())-YEAR(A.FechaIngreso) AS ANTIGUEDAD, P.Provincia, l.Localidad, ti.Descripcion,m.Patente,m.FechaHora,m.Monto 
from agentes as a inner join Multas as m on m.IdAgente=a.IdAgente
inner join Localidades as l on l.IDLocalidad=m.IDLocalidad
INNER JOIN Provincias AS P
ON P.IDProvincia=L.IDProvincia
INNER JOIN TipoInfracciones AS TI
ON TI.IdTipoInfraccion=M.IdTipoInfraccion

--3
--Crear un procedimiento almacenado llamado SP_MultasVehiculo
--que reciba un parámetro que representa la patente de un vehículo. Listar las multas que registra. 
--Indicando fecha y hora de la multa, descripción del tipo de multa e importe a abonar. También una leyenda que indique si la multa fue abonada o no.

CREATE PROCEDURE SP_MULTASVEHICULO (
	@pPATENTE VARCHAR(10)
)
AS
BEGIN 
	Select m.FechaHora,ti.descripcion,ti.ImporteReferencia,
	case 
	when m.Pagada=1 then 'pagada'
	else 'no pagada'
		end
		as pago
	from multas as m
	inner join TipoInfracciones as ti
	on ti.IdTipoInfraccion=m.IdTipoInfraccion
	where m.Patente=@pPATENTE
END

select * from Multas



exec SP_MULTASVEHICULO AB123CD

--4
--Crear una función que reciba un parámetro que representa la patente de un vehículo 
--y devuelva el total adeudado por ese vehículo en concepto de multas.

CREATE PROCEDURE SP_TOTALADEUDADO(
	@pPatente varchar(10)
)
AS 
BEGIN 
	SELECT SUM(m.Monto) AS 'TOTAL ADEUDADO' FROM MULTAS AS M
	WHERE @pPatente=m.Patente AND M.Pagada=0
END


exec SP_TOTALADEUDADO AB123CD


--5
--Crear una función que reciba un parámetro que representa la patente de un vehículo 
--y devuelva el total abonado por ese vehículo en concepto de multas.



--6
--Crear un procedimiento almacenado llamado SP_AgregarMulta que reciba IDTipoInfraccion, IDLocalidad,
--IDAgente, Patente, Fecha y hora, Monto a abonar y registre la multa.


--7
--Crear un procedimiento almacenado llamado SP_ProcesarPagos 
--que determine el estado Pagada de todas las multas a partir 
--de los pagos que se encuentran registrados 
--(La suma de todos los pagos de una multa debe ser igual o mayor al monto de la multa para considerarlo Pagado).




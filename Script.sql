CREATE DATABASE DBEmpleado2;

USE DBEmpleado2;

CREATE TABLE Departamento(
	idDepartamento int primary key identity(1,1),
	nombre varchar(50)
);

CREATE TABLE Empleado(
	idEmpleado int primary key identity(1,1),
	nombreCompleto varchar(50),
	idDepartamento int references Departamento(idDepartamento),
	sueldo int,
	fechaContrato date
);

INSERT INTO Departamento(nombre) VALUES
('Administracion'),
('Marketing'),
('Ventas'),
('Comercio');

INSERT INTO Empleado(nombreCompleto,idDepartamento,sueldo,fechaContrato) VALUES
('Franco Hernandez',1,1400,getdate());

SELECT * FROM Departamento;
SELECT * FROM Empleado;


/*********************************** Crear procedimientos almacenados **************************************/
CREATE PROCEDURE sp_ListaDepartamentos
AS
BEGIN
	SELECT idDepartamento,nombre FROM Departamento;
END


CREATE PROCEDURE sp_ListaEmpleados
AS
BEGIN
	SET dateformat dmy;
	SELECT e.idEmpleado,e.nombreCompleto,
	d.idDepartamento,d.nombre,
	e.sueldo,convert(char(10),e.fechaContrato,103) 'fechaContrato'
	FROM Empleado e
	INNER JOIN Departamento d ON (e.idDepartamento=d.idDepartamento);
END


CREATE PROCEDURE sp_GuardarEmpleado(
	@nombreCompleto varchar(50),
	@idDepartamento int,
	@sueldo int,
	@fechaContrato varchar(10)
)
AS
BEGIN
	SET dateformat dmy;
	INSERT INTO Empleado(nombreCompleto,idDepartamento,sueldo,fechaContrato) 
	VALUES (@nombreCompleto,@idDepartamento,@sueldo,convert(date,@fechaContrato));
END

CREATE PROCEDURE sp_EditarEmpleado(
	@idEmpleado int,
	@nombreCompleto varchar(50),
	@idDepartamento int,
	@sueldo int,
	@fechaContrato varchar(10)
)
AS
BEGIN
	SET dateformat dmy;
	UPDATE Empleado SET
	nombreCompleto = @nombreCompleto,
	idDepartamento = @idDepartamento,
	sueldo = @sueldo,
	fechaContrato = convert(date,@fechaContrato)
	WHERE idEmpleado = @idEmpleado;
END


CREATE PROCEDURE sp_EliminarEmpleado(
	@idEmpleado int
)
AS
BEGIN
	DELETE Empleado WHERE idEmpleado = @idEmpleado;
END


SELECT * FROM Empleado;
SELECT * FROM Departamento;
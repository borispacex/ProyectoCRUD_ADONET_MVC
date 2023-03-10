USE [master]
GO
/****** Object:  Database [DBEmpleado2]    Script Date: 23/01/2023 19:22:35 ******/
CREATE DATABASE [DBEmpleado2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBEmpleado2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVERDEV\MSSQL\DATA\DBEmpleado2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBEmpleado2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVERDEV\MSSQL\DATA\DBEmpleado2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DBEmpleado2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBEmpleado2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBEmpleado2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBEmpleado2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBEmpleado2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBEmpleado2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBEmpleado2] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBEmpleado2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBEmpleado2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBEmpleado2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBEmpleado2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBEmpleado2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBEmpleado2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBEmpleado2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBEmpleado2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBEmpleado2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBEmpleado2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBEmpleado2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBEmpleado2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBEmpleado2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBEmpleado2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBEmpleado2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBEmpleado2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBEmpleado2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBEmpleado2] SET RECOVERY FULL 
GO
ALTER DATABASE [DBEmpleado2] SET  MULTI_USER 
GO
ALTER DATABASE [DBEmpleado2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBEmpleado2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBEmpleado2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBEmpleado2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBEmpleado2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBEmpleado2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DBEmpleado2', N'ON'
GO
ALTER DATABASE [DBEmpleado2] SET QUERY_STORE = OFF
GO
USE [DBEmpleado2]
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 23/01/2023 19:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamento](
	[idDepartamento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idDepartamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 23/01/2023 19:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleado](
	[idEmpleado] [int] IDENTITY(1,1) NOT NULL,
	[nombreCompleto] [varchar](50) NULL,
	[idDepartamento] [int] NULL,
	[sueldo] [int] NULL,
	[fechaContrato] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[idEmpleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Departamento] ON 

INSERT [dbo].[Departamento] ([idDepartamento], [nombre]) VALUES (1, N'Administracion')
INSERT [dbo].[Departamento] ([idDepartamento], [nombre]) VALUES (2, N'Marketing')
INSERT [dbo].[Departamento] ([idDepartamento], [nombre]) VALUES (3, N'Ventas')
INSERT [dbo].[Departamento] ([idDepartamento], [nombre]) VALUES (4, N'Comercio')
SET IDENTITY_INSERT [dbo].[Departamento] OFF
GO
SET IDENTITY_INSERT [dbo].[Empleado] ON 

INSERT [dbo].[Empleado] ([idEmpleado], [nombreCompleto], [idDepartamento], [sueldo], [fechaContrato]) VALUES (1, N'Franco Hernandez', 1, 1400, CAST(N'2023-01-20' AS Date))
SET IDENTITY_INSERT [dbo].[Empleado] OFF
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD FOREIGN KEY([idDepartamento])
REFERENCES [dbo].[Departamento] ([idDepartamento])
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarEmpleado]    Script Date: 23/01/2023 19:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_EditarEmpleado](
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
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarEmpleado]    Script Date: 23/01/2023 19:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_EliminarEmpleado](
	@idEmpleado int
)
AS
BEGIN
	DELETE Empleado WHERE idEmpleado = @idEmpleado;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GuardarEmpleado]    Script Date: 23/01/2023 19:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GuardarEmpleado](
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
GO
/****** Object:  StoredProcedure [dbo].[sp_ListaDepartamentos]    Script Date: 23/01/2023 19:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ListaDepartamentos]
AS
BEGIN
	SELECT idDepartamento,nombre FROM Departamento;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ListaEmpleados]    Script Date: 23/01/2023 19:22:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ListaEmpleados]
AS
BEGIN
	SET dateformat dmy;
	SELECT e.idEmpleado,e.nombreCompleto,
	d.idDepartamento,d.nombre,
	e.sueldo,convert(char(10),e.fechaContrato,103) 'fechaContrato'
	FROM Empleado e
	INNER JOIN Departamento d ON (e.idDepartamento=d.idDepartamento);
END
GO
USE [master]
GO
ALTER DATABASE [DBEmpleado2] SET  READ_WRITE 
GO

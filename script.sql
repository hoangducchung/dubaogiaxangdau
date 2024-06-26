USE [master]
GO
/****** Object:  Database [FuelPriceForecastDB]    Script Date: 03/06/2024 7:56:05 SA ******/
CREATE DATABASE [FuelPriceForecastDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FuelPriceForecastDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\FuelPriceForecastDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FuelPriceForecastDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\FuelPriceForecastDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [FuelPriceForecastDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FuelPriceForecastDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FuelPriceForecastDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [FuelPriceForecastDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FuelPriceForecastDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FuelPriceForecastDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [FuelPriceForecastDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FuelPriceForecastDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FuelPriceForecastDB] SET  MULTI_USER 
GO
ALTER DATABASE [FuelPriceForecastDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FuelPriceForecastDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FuelPriceForecastDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FuelPriceForecastDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FuelPriceForecastDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FuelPriceForecastDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [FuelPriceForecastDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [FuelPriceForecastDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [FuelPriceForecastDB]
GO
/****** Object:  Table [dbo].[Forecasts]    Script Date: 03/06/2024 7:56:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forecasts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fuel_type_id] [int] NULL,
	[forecast] [decimal](10, 2) NOT NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fuel_Types]    Script Date: 03/06/2024 7:56:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fuel_Types](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fuel_name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK__Fuel_Typ__3213E83F39A5F854] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prices]    Script Date: 03/06/2024 7:56:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prices](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fuel_type_id] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[time_stamp] [datetime2](7) NOT NULL,
 CONSTRAINT [PK__Prices__3213E83F239950C3] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Forecasts]  WITH CHECK ADD  CONSTRAINT [FK__Forecasts__fuel___3C69FB99] FOREIGN KEY([fuel_type_id])
REFERENCES [dbo].[Fuel_Types] ([id])
GO
ALTER TABLE [dbo].[Forecasts] CHECK CONSTRAINT [FK__Forecasts__fuel___3C69FB99]
GO
ALTER TABLE [dbo].[Prices]  WITH CHECK ADD  CONSTRAINT [FK__Prices__fuel_typ__398D8EEE] FOREIGN KEY([fuel_type_id])
REFERENCES [dbo].[Fuel_Types] ([id])
GO
ALTER TABLE [dbo].[Prices] CHECK CONSTRAINT [FK__Prices__fuel_typ__398D8EEE]
GO
/****** Object:  StoredProcedure [dbo].[SP_Forecasts]    Script Date: 03/06/2024 7:56:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hoàng Đức Chung
-- Create date: 31.5.2024
-- Description:	SP_Forecasts
-- =============================================
CREATE PROCEDURE [dbo].[SP_Forecasts]
    @fuel_type_id INT,
    @forecast DECIMAL(10, 2),
    @created_at DATETIME
AS
BEGIN
    INSERT INTO Forecasts (fuel_type_id, forecast, created_at)
    VALUES (@fuel_type_id, @forecast, @created_at);
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_Fuel_Types]    Script Date: 03/06/2024 7:56:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hoàng Đức Chung
-- Create date: 31.5.2024
-- Description:	SP_Fuel_Types
-- =============================================
CREATE PROCEDURE [dbo].[SP_Fuel_Types]
    @fuel_name NVARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1
           FROM FUEL_TYPES
           WHERE FUEL_NAME = @fuel_name)
	BEGIN
		PRINT 'Giá trị đã tồn tại, không thêm nữa';
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM Fuel_Types)
		BEGIN
			DBCC CHECKIDENT ('Fuel_Types', RESEED, 0);
		END
		INSERT INTO Fuel_Types (fuel_name)
		VALUES (@fuel_name);
		PRINT 'Thêm thành công!!';
	END;

	
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_Insert_Value]    Script Date: 03/06/2024 7:56:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Hoàng Đức Chung>
-- Create date: <31.5.2024>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Insert_Value] 
	@fuel_name NVARCHAR(255) = Null,
	@price DECIMAL(10, 2) = Null,
    @timestamp DATETIME2 = Null,
	@forecast DECIMAL(10, 2) = Null,
    @created_at DATETIME = Null
AS
BEGIN
	-- Thêm vào Bảng Fuell_Types
	IF EXISTS (SELECT 1
           FROM FUEL_TYPES
           WHERE FUEL_NAME = @fuel_name)
	BEGIN
		PRINT 'Giá trị đã tồn tại, không thêm nữa';
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM Fuel_Types)
		BEGIN
			DBCC CHECKIDENT ('Fuel_Types', RESEED, 0);
		END
		INSERT INTO Fuel_Types (fuel_name)
		VALUES (@fuel_name);
	END;

	--Lấy Fuel_Type_id
	DECLARE @id int;

	SELECT @id = id 
	FROM Fuel_Types
	WHERE fuel_name = @fuel_name;

	IF (@id IS NOT NULL)
	BEGIN
		PRINT('Fuel_Type_id: ' + CAST(@id AS NVARCHAR(10)));

		IF (@price IS NOT NULL and @timestamp IS NOT NULL)
		Begin
			--Thêm vào Bảng Prices
			INSERT INTO Prices (fuel_type_id, price, time_stamp)
			VALUES (@id, @price, @timestamp);
			PRINT 'Đã thêm thành công vào Bảng Prices';
		end

		IF (@forecast IS NOT NULL and @created_at IS NOT NULL)
		Begin
			--Thêm vào Bảng Forecast
			INSERT INTO Forecasts (fuel_type_id, forecast, created_at)
			VALUES (@id, @forecast, @created_at);
			PRINT 'Đã thêm thành công vào Bảng Forecast';
		end
	END
	ELSE
	BEGIN
		PRINT('Không tìm thấy Fuel_Type_id cho ' + @fuel_name);
	END
	

END
GO
/****** Object:  StoredProcedure [dbo].[SP_Prices]    Script Date: 03/06/2024 7:56:05 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hoàng Đức Chung
-- Create date: 31.5.2024
-- Description:	SP_Prices
-- =============================================
CREATE PROCEDURE [dbo].[SP_Prices]
    @fuel_type_id INT,
    @price DECIMAL(10, 2),
    @timestamp DATETIME
AS
BEGIN
    INSERT INTO Prices (fuel_type_id, price, time_stamp)
    VALUES (@fuel_type_id, @price, @timestamp);
END;
GO
USE [master]
GO
ALTER DATABASE [FuelPriceForecastDB] SET  READ_WRITE 
GO

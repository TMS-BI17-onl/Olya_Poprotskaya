CREATE TABLE Sales (
	SalesID		INT IDENTITY(1,1),
	ClientID	INT,
	HotelID		INT,
	ManagerID	INT,
	SalesDate	DATE NOT NULL
			CONSTRAINT DF_SalesDate_FctSales DEFAULT GETDATE(),
	StartDate	DATE NOT NULL,
	EndDate		DATE NOT NULL,
	AviaID		INT,
	Discount	INT
			CONSTRAINT DF_Discount_FctSales DEFAULT NULL,
			CONSTRAINT CK_Discount_FctSales CHECK(Discount>0),
	Price		MONEY
			CONSTRAINT DF_Price_FctSales DEFAULT NULL,				
			CONSTRAINT CK_Price_FctSales CHECK(Price>0),
	CONSTRAINT PK_SalesID_FctSales PRIMARY KEY (SalesID)
);

CREATE TABLE Clients (
	ClientID	INT IDENTITY(1,1),
	FirstName	NVARCHAR(50) NOT NULL,
	LastName	NVARCHAR(50) NOT NULL,
	TypeClient	NVARCHAR (15),
	Passport	uniqueidentifier NOT NULL  
					DEFAULT newid()
					CONSTRAINT UQ_Passport_DimClients UNIQUE,
	PhoneNumber VARCHAR(20),
	Adress		NVARCHAR(150),
	Discount	INT,
	BirthDate	DATE,
	CONSTRAINT PK_ClientID_DimClients PRIMARY KEY (ClientID)
);

CREATE TABLE Managers (
	ManagerID	INT IDENTITY(1,1),
	FirstName	NVARCHAR(50) NOT NULL,
	Passport	uniqueidentifier NOT NULL  
					DEFAULT newid()
					CONSTRAINT UQ_Passport_DimManager UNIQUE,
	Position	VARCHAR(50),
	PhoneNumber NVARCHAR(50),
	Email		NVARCHAR (50),
	Territory	NVARCHAR(50),
	CONSTRAINT PK_ManagerID_DimManagers PRIMARY KEY (ManagerID)
);

CREATE TABLE Hotels (
	HotelID		INT IDENTITY(1,1),
	HotelName	NVARCHAR(50) NOT NULL,
	HotelType	NVARCHAR(50),
	Country		NVARCHAR (50) NOT NULL,
	City		NVARCHAR(50) NOT NULL,
	Adress		NVARCHAR(150),
	LocationType NVARCHAR(50),
	RoomType	NVARCHAR(50),
	TypeFood	NVARCHAR(50),
	Price		MONEY
			CONSTRAINT DF_Price_DimHotels DEFAULT NULL,				
			CONSTRAINT CK_Price_DimHotels CHECK(Price>0),
	CONSTRAINT PK_HotelID_DimHotel PRIMARY KEY (HotelID)
);

CREATE TABLE AirFlight (
	AviaID			INT IDENTITY(1,1),
	Departure		DATE NOT NULL,
	CityDeparture	NVARCHAR(50) NOT NULL,
	CityArrival		NVARCHAR (50) NOT NULL,
	Arrival			DATETIME NOT NULL,
	Baggage			NVARCHAR(50),
	FlightNumber	NVARCHAR(50),
		CONSTRAINT PK_AviaID_DimAirFlight PRIMARY KEY (AviaID)
);

ALTER TABLE dbo.Sales 
ADD CONSTRAINT FK_ClientID_FctSales FOREIGN KEY(ClientID)
				REFERENCES dbo.Clients(ClientID),
	CONSTRAINT FK_HotelID_FctSales FOREIGN KEY(HotelID)
				REFERENCES dbo.Hotels (HotelID),
	CONSTRAINT FK_ManagerID_FctSales FOREIGN KEY(ManagerID)
				REFERENCES dbo.Managers (ManagerID),
	CONSTRAINT FK_AviaID_FctSales FOREIGN KEY(AviaID)
				REFERENCES dbo.AirFlight (AviaID)

INSERT INTO Hotels (HotelName, HotelType, Country, City, Adress,
					LocationType, RoomType, TypeFood, Price)
SELECT  HotelName, HotelType, Country, City, Adress,
					LocationType, RoomType, TypeFood, 
					Price
FROM [dbo].[data_hotels]

SELECT *
FROM Sales

TRUNCATE TABLE Clients

DROP TABLE Managers

ALTER TABLE Sales
DROP CONSTRAINT CK_Price_FctSales

INSERT INTO Clients (FirstName, LastName, TypeClient, Passport,
					PhoneNumber, Adress, Discount, BirthDate)
SELECT FirstName, LastName, TypeClient, Passport,
					PhoneNumber, Adress, Discount, BirthDate
FROM [dbo].[data_clients]

INSERT INTO AirFlight(Departure, CityDeparture, CityArrival, 
						Arrival,Baggage,FlightNumber)
SELECT Departure, CityDeparture, 
		CityArrival, Arrival,Baggage,FlightNumber
FROM [dbo].[data_air_flight]

INSERT INTO Managers (FirstName,Passport, Position,
						PhoneNumber, Email,Territory)
SELECT FirstName,Passport, Position,
						PhoneNumber, Email,Territory
FROM [dbo].[data_manager]

INSERT INTO Sales (ClientID, HotelID, ManagerID, AviaID, SalesDate,StartDate,
					EndDate,  Discount, Price)
SELECT TOP 1000000 S1.CL_ID, S1.MAN_ID, S1.HOT_ID, S1.AV_ID,
			DATEADD(DAY, -1*FLOOR (RAND(CHECKSUM(NEWID()))*365),DEP1),
			DATEADD (DAY, -1*FLOOR (RAND(CHECKSUM(NEWID()))*3),DEP1),
			DATEADD (DAY,FLOOR (RAND(CHECKSUM(NEWID()))*30),DEP1),
			S1.DISC, S1.PR
FROM (SELECT FLOOR (RAND(CHECKSUM(NEWID()))*1000) AS CL_ID,
				FLOOR (RAND(CHECKSUM(NEWID()))*1000) AS MAN_ID,
				FLOOR (RAND(CHECKSUM(NEWID()))*1000) AS HOT_ID,
				AviaID AS AV_ID,
				FLOOR (RAND(CHECKSUM(NEWID()))*20) AS DISC,
				ROUND (RAND(CHECKSUM(NEWID()))*10000,2) AS PR,
				Departure AS DEP1
				FROM AirFlight CROSS JOIN Clients) S1
WHERE CL_ID>0 AND MAN_ID>0 AND HOT_ID>0
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
	Position	VARCHAR(20),
	PhoneNumber NVARCHAR(20),
	Email		NVARCHAR (25),
	Territory	NVARCHAR(50),
	CONSTRAINT PK_ManagerID_DimManagers PRIMARY KEY (ManagerID)
);

CREATE TABLE Hotels (
	HotelID		INT IDENTITY(1,1),
	HotelName	NVARCHAR(50) NOT NULL,
	HotelType	NVARCHAR(15),
	Country		NVARCHAR (15) NOT NULL,
	City		NVARCHAR(25) NOT NULL,
	Adress		NVARCHAR(150),
	LocationType NVARCHAR(15),
	RoomType	NVARCHAR(15),
	TypeFood	NVARCHAR(15),
	Price		MONEY
			CONSTRAINT DF_Price_DimHotels DEFAULT NULL,				
			CONSTRAINT CK_Price_DimHotels CHECK(Price>0),
	CONSTRAINT PK_HotelID_DimHotel PRIMARY KEY (HotelID)
);

CREATE TABLE AirFlight (
	AviaID			INT IDENTITY(1,1),
	Departure		DATE NOT NULL,
	CityDeparture	NVARCHAR(25) NOT NULL,
	CityArrival		NVARCHAR (25) NOT NULL,
	Arrival			DATETIME NOT NULL,
	Baggage			NVARCHAR(10),
	FlightNumber	NVARCHAR(10),
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


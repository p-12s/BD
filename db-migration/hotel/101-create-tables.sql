-------------- create table Hotel --------------
-- 1)	Отели: hotel - id отеля, название отеля, количество звезд, адрес.
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Hotel' AND xtype='U')
  CREATE TABLE Hotel (
    HotelId int IDENTITY(1, 1) NOT NULL,
    Name nvarchar (100) NOT NULL,
    StarsCount int NOT NULL,
    Address nvarchar (255) NOT NULL,
    CONSTRAINT PK_Hotel PRIMARY KEY CLUSTERED 
    (
      HotelId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  )
  ON [PRIMARY]
GO

-------------- create table Category --------------
-- 2)	Категории номеров: room_kind - id категории номер, название (люкс, эконом), минимальная площадь по категории.

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Category' AND xtype='U')
  CREATE TABLE Category (
    CategoryId int IDENTITY(1, 1) NOT NULL,
    Name nvarchar (100) NOT NULL,
    MinimumArea float NOT NULL,
	CONSTRAINT PK_Category PRIMARY KEY CLUSTERED 
    (
      CategoryId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO

-------------- create table Room --------------
-- 3)	Комнаты: room - id комнаты, id отеля, id категории номер, номер комнаты в отеле, стоимость суток проживания.

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Room' AND xtype='U')
  CREATE TABLE Room (
    RoomId int IDENTITY(1, 1) NOT NULL,
    HotelId int NOT NULL,
    CategoryId int NOT NULL,
    RoomNumberInHotel int NOT NULL,
    Price money NOT NULL,
    CONSTRAINT PK_Room PRIMARY KEY CLUSTERED 
    (
      RoomId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO

-------------- create table Client --------------
-- 4)	Клиенты: client - id клиента, фио, телефон.
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Client' AND xtype='U')
  CREATE TABLE Client (
    ClientId int IDENTITY(1, 1) NOT NULL,
    FullName nvarchar (255) NOT NULL,
    Phone nvarchar (100) NOT NULL,
    CONSTRAINT PK_Client PRIMARY KEY CLUSTERED 
    (
      ClientId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO 

-------------- create table Reservation --------------
-- 5)  Бронь: id - брони, id клиента, дата бронирования
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Reservation' AND xtype='U')
  CREATE TABLE Reservation (
    ReservationId int IDENTITY(1, 1) NOT NULL,
    ClientId int NOT NULL,
    ReservationDate date NOT NULL,
    CONSTRAINT PK_Reservation PRIMARY KEY CLUSTERED 
    (
      ReservationId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO 

-------------- create table ArmorRoom --------------
-- 6)  Комната в брони: id, id брони, id категории номера, дата заезда, дата выезда.
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='RoomInReservation' AND xtype='U')
  CREATE TABLE ArmorRoom (
    RoomInReservationId int IDENTITY(1, 1) NOT NULL,
    ReservationId int NOT NULL,
    CategoryId int NOT NULL,
    ArrivalDate date NOT NULL,
    DepartureDate date NOT NULL,
    CONSTRAINT PK_RoomInReservation PRIMARY KEY CLUSTERED 
    (
      RoomInReservationId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO 


IF OBJECT_ID('FK_ProductionOrder') IS NULL
  ALTER TABLE [Order]
    WITH CHECK
    ADD CONSTRAINT FK_ProductionOrder
    FOREIGN KEY (ProductionId) REFERENCES Production(ProductionId)
    ON DELETE CASCADE
  GO

  ALTER TABLE [Order] 
    CHECK CONSTRAINT FK_ProductionOrder
  GO  

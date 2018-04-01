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

IF OBJECT_ID('FK_HotelRoom') IS NULL
  ALTER TABLE [Room]
    WITH CHECK
    ADD CONSTRAINT FK_HotelRoom
    FOREIGN KEY (HotelId) REFERENCES Hotel(HotelId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Room] 
    CHECK CONSTRAINT FK_HotelRoom
  GO

IF OBJECT_ID('FK_CategoryRoom') IS NULL
  ALTER TABLE [Room]
    WITH CHECK
    ADD CONSTRAINT FK_CategoryRoom
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Room] 
    CHECK CONSTRAINT FK_CategoryRoom
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

IF OBJECT_ID('FK_ClientReservation') IS NULL
  ALTER TABLE [Reservation]
    WITH CHECK
    ADD CONSTRAINT FK_ClientReservation
    FOREIGN KEY (ClientId) REFERENCES Client(ClientId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Reservation] 
    CHECK CONSTRAINT FK_ClientReservation
  GO

-------------- create table RoomInReservation --------------
-- 6)  Комната в брони: id, id брони, id категории номера, дата заезда, дата выезда.
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='RoomInReservation' AND xtype='U')
  CREATE TABLE RoomInReservation (
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

IF OBJECT_ID('FK_ReservationRoomInReservation') IS NULL
  ALTER TABLE [RoomInReservation]
    WITH CHECK
    ADD CONSTRAINT FK_ReservationRoomInReservation
    FOREIGN KEY (ReservationId) REFERENCES Reservation(ReservationId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [RoomInReservation] 
    CHECK CONSTRAINT FK_ReservationRoomInReservation
  GO

IF OBJECT_ID('FK_CategoryRoomInReservation') IS NULL
  ALTER TABLE [RoomInReservation]
    WITH CHECK
    ADD CONSTRAINT FK_CategoryRoomInReservation
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [RoomInReservation] 
    CHECK CONSTRAINT FK_CategoryRoomInReservation
  GO
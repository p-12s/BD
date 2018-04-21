
--====================
--2)	Выдать информацию о клиентах гостиницы “Алтай”, проживавших в номерах категории “люкс”.
SELECT Cl.ClientId, Cl.FullName, Cl.Phone FROM Client AS Cl
INNER JOIN Reservation AS Res ON Cl.ClientId = Res.ClientId
INNER JOIN RoomInReservation AS RiR ON Res.ReservationId = RiR.ReservationId
INNER JOIN Category AS C ON RiR.CategoryId = C.CategoryId
INNER JOIN Room AS R ON R.CategoryId = C.CategoryId
INNER JOIN Hotel AS H ON H.HotelId = R.HotelId
WHERE H.Name = 'Алтай' AND C.Name = 'Люкс (Lux)'
GROUP BY Cl.ClientId, Cl.FullName, Cl.Phone
ORDER BY Cl.ClientId ASC

-- from 0.126568 to 0.0463841 (~60%)
-- composite Room = 0.0627325
-- composite Room - unique Name in Category = 0.124514
-- composite Room - unique Name in Category - Name in Hotel = 0.0642507
-- unique Name in Category - unique Name in Hotel = 0.110771

--- make Name in Category table as unique index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'UI_Category_Name')
	DROP INDEX UI_Category_Name ON Category
	CREATE UNIQUE INDEX UI_Category_Name ON Category (Name)
GO
--- make Name in Hotel table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Hotel_Name')
	DROP INDEX [IX_Hotel_Name] ON Hotel
	CREATE INDEX [IX_Hotel_Name] ON Hotel (Name)
GO
--- make HotelId-CategoryId in Room table as composite index 
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Room_HotelId-CategoryId')
	DROP INDEX [IX_Room_HotelId-CategoryId] ON Room
	CREATE INDEX [IX_Room_HotelId-CategoryId] ON Room (HotelId, CategoryId)
GO
--- make RoomId-ReservationId in RoomInReservation as composite index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_RoomId-ReservationId')
	DROP INDEX [IX_RoomInReservation_RoomId-ReservationId] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_RoomId-ReservationId] ON RoomInReservation (RoomId, ReservationId)
GO
--- make ClientId in Reservation as index - a little bit faster
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Reservation_ClientId')
	DROP INDEX [IX_Reservation_ClientId] ON Reservation
	CREATE INDEX [IX_Reservation_ClientId] ON Reservation (ClientId)
GO

--=====================
--3)	Дать список свободных номеров всех гостиниц на 30.05.12.
SELECT * FROM Room WHERE RoomId NOT IN (
  SELECT R.RoomId FROM RoomInReservation AS RiR 
  RIGHT JOIN Room AS R ON R.RoomId = RiR.RoomId
  WHERE '2012-05-30' BETWEEN RiR.ArrivalDate AND RiR.DepartureDate
)
ORDER BY RoomId, HotelId
-- SELECT * FROM RoomInReservation WHERE RoomId = 105


--- from 0.0310008 to 0.0305198 (~2%)
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_ArrivalDate-DepartureDate')
	DROP INDEX [IX_RoomInReservation_ArrivalDate-DepartureDate] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_ArrivalDate-DepartureDate] ON RoomInReservation (ArrivalDate, DepartureDate)
GO
--- make separately index - a little bit faster
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_ArrivalDate')
	DROP INDEX [IX_RoomInReservation_ArrivalDate] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_ArrivalDate] ON RoomInReservation (ArrivalDate)
GO

IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_DepartureDate')
	DROP INDEX [IX_RoomInReservation_DepartureDate] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_DepartureDate] ON RoomInReservation (DepartureDate)
GO
-- make RoomId in RoomInReservation as index - no result (although it should be)
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_RoomId')
	DROP INDEX [IX_RoomInReservation_RoomId] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_RoomId] ON RoomInReservation (RoomId)
GO

--====================
--4)	Дать количество проживающих в гостинице “Восток” на 25.05.12 по каждому номеру
SELECT C.CategoryId, COUNT(Cl.ClientId) FROM RoomInReservation AS RiR 
INNER JOIN Room AS R ON R.RoomId = RiR.RoomId
INNER JOIN Category AS C ON C.CategoryId = R.CategoryId
INNER JOIN Hotel AS H ON H.HotelId = R.HotelId
INNER JOIN Reservation AS Res ON Res.ReservationId = RiR.ReservationId
INNER JOIN Client AS Cl ON Res.ClientId = Cl.ClientId
WHERE '2012-05-25' BETWEEN RiR.ArrivalDate AND RiR.DepartureDate AND H.Name = 'Восток'
GROUP BY C.CategoryId

-- from 0.0366261 to 0.0317572 (~15%)
--- make separately index - a little bit faster. why? scan whatever!
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_ArrivalDate')
	DROP INDEX [IX_RoomInReservation_ArrivalDate] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_ArrivalDate] ON RoomInReservation (ArrivalDate)
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_DepartureDate')
	DROP INDEX [IX_RoomInReservation_DepartureDate] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_DepartureDate] ON RoomInReservation (DepartureDate)
GO
-- make Name in Hotel as index - made it worse
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Hotel_Name')
	DROP INDEX [IX_Hotel_Name] ON Hotel
	CREATE INDEX [IX_Hotel_Name] ON Hotel (Name)
GO
---- make separately index - a little bit faster
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Room_CategoryId')
	DROP INDEX [IX_Room_CategoryId] ON Room
	CREATE INDEX [IX_Room_CategoryId] ON Room (CategoryId)
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Room_HotelId')
	DROP INDEX [IX_Room_HotelId] ON Room
	CREATE INDEX [IX_Room_HotelId] ON Room (HotelId)
GO

IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_RoomId')
	DROP INDEX [IX_RoomInReservation_RoomId] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_RoomId] ON RoomInReservation (RoomId)
GO

--====================
--5)  Дать список последних проживавших клиентов по всем комнатам гостиницы “Космос”, выехавшим в апреле 2012 с указанием даты выезда.
SELECT R.RoomId, MAX(DepartureDate) AS DepartureDate
INTO #TempTable
FROM RoomInReservation AS RiR
INNER JOIN Room AS R ON R.RoomId = RiR.RoomId
INNER JOIN Hotel AS H ON H.HotelId = R.HotelId
WHERE DepartureDate BETWEEN '2012-04-01' AND '2012-04-30' AND H.Name = 'Космос'
GROUP BY R.RoomId

SELECT T.RoomId, T.DepartureDate, C.FullName FROM #TempTable AS T
INNER JOIN RoomInReservation AS RiR ON RiR.DepartureDate = T.DepartureDate AND RiR.RoomId = T.RoomId
INNER JOIN Reservation AS Res ON Res.ReservationId = RiR.ReservationId
INNER JOIN Client AS C ON C.ClientId = Res.ClientId
ORDER BY C.FullName

-- DROP TABLE #TempTable

-- from 0.0388278 to 0.0 (~%)
-- make Name in Hotel as index - made it worse
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Hotel_Name')
	DROP INDEX [IX_Hotel_Name] ON Hotel
	CREATE INDEX [IX_Hotel_Name] ON Hotel (Name)
GO
-- make HotelId in Room as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Room_HotelId')
	DROP INDEX [IX_Room_HotelId] ON Room
	CREATE INDEX [IX_Room_HotelId] ON Room (HotelId)
GO
-- make RoomId in RoomInReservation as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_RoomId')
	DROP INDEX [IX_RoomInReservation_RoomId] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_RoomId] ON RoomInReservation (RoomId)
GO

-- make HotelId in Room as index (add in #TempTable) - don't work
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_TempTable_DepartureDate')
	DROP INDEX [IX_TempTable_DepartureDate] ON #TempTable
	CREATE INDEX [IX_TempTable_DepartureDate] ON #TempTable (DepartureDate)
GO
-- make HotelId in Room as index (add in #TempTable) - don't work
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_TempTable_RoomId')
	DROP INDEX [IX_TempTable_RoomId] ON #TempTable
	CREATE INDEX [IX_TempTable_RoomId] ON #TempTable (RoomId)
GO

-- доделать

--====================
--6)  Продлить до 30.05.12 дату проживания в гостинице “Сокол” всем клиентам комнат категории “люкс”, которые заселились 15.05.12, а выезжают 28.05.12

UPDATE RoomInReservation
SET RoomInReservation.DepartureDate = '2012-05-30'
-- SELECT *
FROM RoomInReservation AS RiR
INNER JOIN Room AS R ON R.RoomId = RiR.RoomId
INNER JOIN Hotel AS H ON H.HotelId = R.HotelId
INNER JOIN Category AS C ON R.CategoryId = C.CategoryId
WHERE RiR.ArrivalDate = '2012-05-15' AND RiR.DepartureDate = '2012-05-28' AND H.Name = 'Сокол' AND C.Name = 'Люкс (Lux)'
-- from 0.0138033 to 0.0 (~%)

-- make separately index - a little bit faster. why? scan whatever!
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_ArrivalDate')
	DROP INDEX [IX_RoomInReservation_ArrivalDate] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_ArrivalDate] ON RoomInReservation (ArrivalDate)
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_DepartureDate')
	DROP INDEX [IX_RoomInReservation_DepartureDate] ON RoomInReservation
	CREATE INDEX [IX_RoomInReservation_DepartureDate] ON RoomInReservation (DepartureDate)
GO
-- make Name in Category table as unique index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'UI_Category_Name')
	DROP INDEX UI_Category_Name ON Category
	CREATE UNIQUE INDEX UI_Category_Name ON Category (Name)
GO
-- make Name in Hotel table as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Hotel_Name')
	DROP INDEX [IX_Hotel_Name] ON Hotel
	CREATE INDEX [IX_Hotel_Name] ON Hotel (Name)
GO

-- make RoomId in Hotel table as index. don't work
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_RoomInReservation_RoomId')
	DROP INDEX [IX_RoomInReservation_RoomId] ON RoomInReservation
	-- CREATE INDEX [IX_RoomInReservation_RoomId] ON RoomInReservation (RoomId)
GO

--====================
--7)  Привести пример транзакции при создании брони.
BEGIN TRANSACTION
  DECLARE @clientName varchar(60) = 'Антонов Антон Антонович'
  DECLARE @reservationDate datetime = '2012-05-01'
  DECLARE @clientId int = (SELECT ClientId FROM Client WHERE FullName = @clientName)

  DECLARE @hotelName varchar(60) = 'Сокол'
  DECLARE @categoryName varchar(60) = 'Стандарт'
  DECLARE @arrivalDate datetime = '2012-05-03'
  DECLARE @departureDate datetime = '2012-05-04'

  DECLARE @roomId int = (
  SELECT TOP 1 RoomId FROM Room
  INNER JOIN Hotel AS H ON H.Name = @hotelName
  INNER JOIN Category AS C ON C.Name = @categoryName)

  INSERT INTO Reservation (ClientId, ReservationDate) VALUES (@clientId, @reservationDate)

  DECLARE @reservationId int = (SELECT SCOPE_IDENTITY())

  INSERT INTO RoomInReservation (ReservationId, RoomId, ArrivalDate, DepartureDate)
  VALUES (@reservationId, @roomId, @arrivalDate, @departureDate)
COMMIT TRANSACTION

--- make FullName in Client as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Client_FullName')
	DROP INDEX [IX_Client_FullName] ON Client
	CREATE INDEX [IX_Client_FullName] ON Client (FullName)
GO
--- make Name in Hotel as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Hotel_Name')
	DROP INDEX [IX_Hotel_Name] ON Hotel
	CREATE INDEX [IX_Hotel_Name] ON Hotel (Name)
GO
--- make Name in Category as index
IF EXISTS (SELECT name from sys.indexes WHERE name = N'UI_Category_Name')
	DROP INDEX [UI_Category_Name] ON Category
	CREATE UNIQUE INDEX [UI_Category_Name] ON Category (Name)
GO

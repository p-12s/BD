--Требуется:
--1) Создать базу данных и заполнить данными, необходимыми для проверки запросов. Добавить индексы и внешние ключи.

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

--3)	Дать список свободных номеров всех гостиниц на 30.05.12.
SELECT * FROM Room WHERE RoomId NOT IN (
  SELECT R.RoomId FROM RoomInReservation AS RiR 
  RIGHT JOIN Room AS R ON R.RoomId = RiR.RoomId
  WHERE '2012-05-30' BETWEEN RiR.ArrivalDate AND RiR.DepartureDate
)
ORDER BY RoomId, HotelId

--4)	Дать количество проживающих в гостинице “Восток” на 25.05.12 по каждому номеру
SELECT C.CategoryId, COUNT(Cl.ClientId) FROM RoomInReservation AS RiR 
INNER JOIN Room AS R ON R.RoomId = RiR.RoomId
INNER JOIN Category AS C ON C.CategoryId = R.CategoryId
INNER JOIN Hotel AS H ON H.HotelId = R.HotelId
INNER JOIN Reservation AS Res ON Res.ReservationId = RiR.ReservationId
INNER JOIN Client AS Cl ON Res.ClientId = Cl.ClientId
WHERE '2012-05-25' BETWEEN RiR.ArrivalDate AND RiR.DepartureDate AND H.Name = 'Восток'
GROUP BY C.CategoryId

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
 
--6)  Продлить до 30.05.12 дату проживания в гостинице “Сокол” всем клиентам комнат категории “люкс”, которые заселились 15.05.12, а выезжают 28.05.12

UPDATE RoomInReservation
SET RoomInReservation.DepartureDate = '2012-05-30'
FROM RoomInReservation AS RiR
INNER JOIN Room AS R ON R.RoomId = RiR.RoomId
INNER JOIN Hotel AS H ON H.HotelId = R.HotelId
INNER JOIN Category AS C ON R.CategoryId = C.CategoryId
WHERE RiR.ArrivalDate = '2012-05-15' AND RiR.DepartureDate = '2012-05-28' AND H.Name = 'Сокол' AND C.Name = 'Люкс (Lux)'

-- RoomInReservationId = 27     DepartureDate = '2012-05-28'

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

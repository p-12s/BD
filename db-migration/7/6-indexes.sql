/*
УНИКАЛЬНЫЙ ИНДЕКС
	Нельзя создать уникальный индекс для одного столбца, если в более чем одной строке этого столбца содержится значение NULL. 
	Нельзя также создать уникальный индекс для нескольких столбцов, 
	если в более чем одной строке такой комбинации столбцов содержится значение NULL. 
	При индексировании такие значения будут рассматриваться как дубликаты.

«Префик индекса» может принимать одно из следующих значений:
IX = обычный индекс;
UX = уникальный (кластерный) индекс.

Наилучшим образом будет применение кластеризованного индекса 
на столбцах с уникальными значениями и не позволяющими использовать NULL.

В таблице не может быть 2 кластеризованных индекса
*/

-- 2) Выдать информацию по всем заказам лекарства “Кордерон” компании “Аргус” с указанием названий аптек, дат, объема заказов.

-- ============== result: 0.020

SELECT D.Name, O.OrderDate, O.QuantityMedicineInOrder FROM Orders AS O
LEFT JOIN Drugstore AS D ON O.DrugstoreId = D.DrugstoreId
WHERE O.ProductionId = 
(
	SELECT P.ProductionId FROM Production AS P 
	WHERE CompanyId = (SELECT C.CompanyId FROM Company AS C WHERE C.Name = 'Аргус') 
		AND MedicineId = (SELECT M.MedicineId FROM Medicine AS M WHERE M.Name = 'Кордерон')
)
SELECT D.Name, O.OrderDate, O.QuantityMedicineInOrder FROM Orders AS O
LEFT JOIN Drugstore AS D ON O.DrugstoreId = D.DrugstoreId
WHERE O.ProductionId = 
(
	SELECT P.ProductionId FROM Production AS P 
	WHERE CompanyId = (SELECT C.CompanyId FROM Company AS C WHERE C.Name = 'Аргус') 
		AND MedicineId = (SELECT M.MedicineId FROM Medicine AS M WHERE M.Name = 'Кордерон')
)
-- add unique index for Company(Name)
IF EXISTS (SELECT name from sys.indexes WHERE name = N'UI_Company_Name')
	DROP INDEX UI_Company_Name ON Company
	CREATE UNIQUE INDEX UI_Company_Name ON Company (Name)
GO
-- add unique index for Medicine(Name)
IF EXISTS (SELECT name from sys.indexes WHERE name = N'UI_Medicine_Name')
	DROP INDEX UI_Medicine_Name ON Medicine
	CREATE UNIQUE INDEX UI_Medicine_Name ON Medicine (Name)
GO
-- Order DrugstoreId, ProductionId
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Orders_DrugstoreId')
	DROP INDEX IX_Orders_DrugstoreId ON Orders
	CREATE INDEX IX_Orders_DrugstoreId ON Orders (DrugstoreId)
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Orders_ProductionId')
	DROP INDEX IX_Orders_ProductionId ON Orders
	CREATE INDEX IX_Orders_ProductionId ON Orders (ProductionId)
GO
-- Production CompanyId, MedicineId, 
IF EXISTS (SELECT name from sys.indexes WHERE name = N'XI_Production_CompanyId-MedicineId')
	DROP INDEX [XI_Production_CompanyId-MedicineId] ON Production
	CREATE INDEX [XI_Production_CompanyId-MedicineId] ON Production (CompanyId, MedicineId)
GO

--========================================================================================
-- 3) Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 1.05.12.
SELECT M.Name FROM Medicine AS M WHERE M.MedicineId IN (
SELECT P.MedicineId AS MinDate FROM Orders AS O
JOIN Production AS P ON P.ProductionId = O.ProductionId
JOIN Company AS C ON C.CompanyId = P.CompanyId
WHERE C.CompanyId = (SELECT C.CompanyId FROM Company AS C WHERE C.Name = 'Фарма')
GROUP BY P.MedicineId
HAVING MIN(OrderDate) > '2012-05-01')

-- ============== simple: 0.0188

-- add unique index for Company(Name)
IF EXISTS (SELECT name from sys.indexes WHERE name = N'AK_Company_Name')
	DROP INDEX AK_Company_Name ON Company
	CREATE UNIQUE INDEX AK_Company_Name ON Company (Name)
GO

-- 4) Дать минимальный и максимальный баллы по лекарствам каждой фирмы, которая производит не менее 10 препаратов, с указанием названий фирмы и лекарства
SELECT P.CompanyId, C.Name, MIN(P.QualityControl) AS MinQ, MAX(P.QualityControl) AS MaxQ
FROM Production AS P
LEFT JOIN Company AS C ON P.CompanyId = C.CompanyId
GROUP BY P.CompanyId, C.Name
HAVING COUNT(*) > 10

-- 5) Дать списки сделавших заказы аптек по всем дилерам компании “Годеон Рихтер”. Если у дилера нет заказов, в названии аптеки проставить NULL.
SELECT P.DealerId, D.Name
FROM Production AS P 
LEFT JOIN Orders AS O ON P.ProductionId = O.ProductionId 
LEFT JOIN Drugstore AS D ON O.DrugstoreId = D.DrugstoreId
WHERE P.CompanyId = (SELECT C.CompanyId FROM Company AS C WHERE C.Name LIKE '%Годеон Рихтер%')
GROUP BY P.DealerId, O.DrugstoreId, D.Name
-- add unique index for Company(Name)
IF EXISTS (SELECT name from sys.indexes WHERE name = N'AK_Company_Name')
	DROP INDEX AK_Company_Name ON Company
	CREATE UNIQUE INDEX AK_Company_Name ON Company (Name)
GO

-- 6) Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней.
UPDATE Production SET Price = Price * 0.8 
WHERE ProductionId IN (
  SELECT P.ProductionId FROM Production AS P
  INNER JOIN Medicine AS M ON P.MedicineId = M.MedicineId
  WHERE (P.Price > 3000) AND (M.DurationOfTreatment <= 7))

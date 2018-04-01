-- get all foreign keys in database
SELECT f.name AS ForeignKey, 
   OBJECT_NAME(f.parent_object_id) AS TableName, 
   COL_NAME(fc.parent_object_id, fc.parent_column_id) AS ColumnName, 
   OBJECT_NAME (f.referenced_object_id) AS ReferenceTableName, 
   COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS ReferenceColumnName 
FROM sys.foreign_keys AS f 
INNER JOIN sys.foreign_key_columns AS fc 
   ON f.OBJECT_ID = fc.constraint_object_id

-- 2) Выдать информацию по всем заказам лекарства “Кордерон” компании “Аргус” с указанием названий аптек, дат, объема заказов.
SELECT D.Name, O.OrderDate, O.QuantityMedicineInOrder FROM Orders AS O
LEFT JOIN Drugstore AS D ON O.DrugstoreId = D.DrugstoreId
WHERE O.ProductionId = (SELECT P.ProductionId FROM Production AS P 
WHERE CompanyId = (SELECT C.CompanyId FROM Company AS C WHERE C.Name LIKE '%Аргус%') AND MedicineId = (SELECT M.MedicineId FROM Medicine AS M WHERE M.Name LIKE '%Кордерон%'))
-- or
SELECT D.Name, O.OrderDate, O.QuantityMedicineInOrder FROM Production AS P 
JOIN Company AS C ON P.CompanyId = C.CompanyId
JOIN Medicine AS M ON P.MedicineId = M.MedicineId
JOIN Orders AS O ON O.ProductionId = P.ProductionId
JOIN Drugstore AS D ON D.DrugstoreId = O.DrugstoreId
WHERE C.Name = 'Аргус' AND M.Name = 'Кордерон' 
-- from 0.020484 to 0.019865 (~5%)

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
-- Orders DrugstoreId, ProductionId
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Orders_DrugstoreId')
	DROP INDEX IX_Orders_DrugstoreId ON Orders
	CREATE INDEX IX_Orders_DrugstoreId ON Orders (DrugstoreId)
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Orders_ProductionId')
	DROP INDEX IX_Orders_ProductionId ON Orders
	CREATE INDEX IX_Orders_ProductionId ON Orders (ProductionId)
GO
-- Production CompanyId, MedicineId, 
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Production_CompanyId-MedicineId')
	DROP INDEX [IX_Production_CompanyId-MedicineId] ON Production
	CREATE INDEX [IX_Production_CompanyId-MedicineId] ON Production (CompanyId, MedicineId)
GO

--=====================
-- 3) Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 1.05.12.
SELECT P.MedicineId, M.Name, (O.OrderDate) AS MinDate 
FROM Production AS P 
LEFT JOIN Orders AS O ON P.ProductionId = O.OrderId 
LEFT JOIN Medicine AS M ON P.MedicineId = M.MedicineId
WHERE P.CompanyId = (SELECT C.CompanyId FROM Company AS C WHERE C.Name LIKE '%Фарма%') AND (O.OrderDate > '2012-05-01')
GROUP BY P.MedicineId, O.OrderDate, M.Name

-- from 0.030023 to 0.025926 (~20%)
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
-- Orders ProductionId
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Orders_ProductionId')
	DROP INDEX IX_Orders_ProductionId ON Orders
	CREATE INDEX IX_Orders_ProductionId ON Orders (ProductionId)
GO
-- Production CompanyId, MedicineId, 
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Production_CompanyId-MedicineId')
	DROP INDEX [IX_Production_CompanyId-MedicineId] ON Production
	CREATE INDEX [IX_Production_CompanyId-MedicineId] ON Production (CompanyId, MedicineId)
GO
-- Orders OrderDate
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Orders_OrderDate')
	DROP INDEX IX_Orders_OrderDate ON Orders
	CREATE INDEX IX_Orders_OrderDate ON Orders (OrderDate)
GO
-- add unique index for Medicine(Name)
IF EXISTS (SELECT name from sys.indexes WHERE name = N'UI_Medicine_Name')
	DROP INDEX UI_Medicine_Name ON Medicine
	CREATE UNIQUE INDEX UI_Medicine_Name ON Medicine (Name)
GO

--====================
-- 4) Дать минимальный и максимальный баллы по лекарствам каждой фирмы, которая производит не менее 10 препаратов, с указанием названий фирмы и лекарства
SELECT P.CompanyId, C.Name, MIN(P.QualityControl) AS MinQ, MAX(P.QualityControl) AS MaxQ
FROM Production AS P
LEFT JOIN Company AS C ON P.CompanyId = C.CompanyId
GROUP BY P.CompanyId, C.Name
HAVING COUNT(*) > 10

-- from 0.024157 to 0.024157 (0%, because the MIN/MAX doesn’t use indexes, and GROUP BY works after WHERE (which is not here))

--====================
-- 5) Дать списки сделавших заказы аптек по всем дилерам компании “Годеон Рихтер”. Если у дилера нет заказов, в названии аптеки проставить NULL.
SELECT P.DealerId, D.Name
FROM Production AS P 
LEFT JOIN Orders AS O ON P.ProductionId = O.ProductionId 
LEFT JOIN Drugstore AS D ON O.DrugstoreId = D.DrugstoreId
WHERE P.CompanyId = (SELECT C.CompanyId FROM Company AS C WHERE C.Name LIKE '%Годеон Рихтер%')
GROUP BY P.DealerId, O.DrugstoreId, D.Name

-- from 0.027071 to 0.024157 
-- Orders DrugstoreId, ProductionId (separate) (0.0263656)
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Orders_DrugstoreId')
	DROP INDEX [IX_Orders_DrugstoreId] ON Orders
	CREATE INDEX [IX_Orders_DrugstoreId] ON Orders (DrugstoreId)
GO
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Orders_ProductionId')
	DROP INDEX [IX_Orders_ProductionId] ON Orders
	CREATE INDEX [IX_Orders_ProductionId] ON Orders (ProductionId)
GO
-- Production CompanyId, DealerId
IF EXISTS (SELECT name from sys.indexes WHERE name = N'XI_Production_CompanyId-DealerId')
	DROP INDEX [XI_Production_CompanyId-DealerId] ON Production
	CREATE INDEX [XI_Production_CompanyId-DealerId] ON Production (CompanyId, DealerId)
GO
-- add unique index for Company(Name)
IF EXISTS (SELECT name from sys.indexes WHERE name = N'UI_Company_Name')
	DROP INDEX [UI_Company_Name] ON Company
	CREATE UNIQUE INDEX [UI_Company_Name] ON Company (Name)
GO

--====================
-- 6) Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней.
UPDATE Production SET Price = Price * 0.8 
WHERE ProductionId IN (
  SELECT P.ProductionId FROM Production AS P
  INNER JOIN Medicine AS M ON P.MedicineId = M.MedicineId
  WHERE (P.Price > 3000) AND (M.DurationOfTreatment <= 7))

-- from 0.007479 to 0.007387
-- Production Price, MedicineId
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Production_Price-MedicineId')
	DROP INDEX [IX_Production_Price-MedicineId] ON Production
	CREATE INDEX [IX_Production_Price-MedicineId] ON Production (Price, MedicineId)
GO
-- Medicine MedicineId, DurationOfTreatment 
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_Medicine_MedicineId-DurationOfTreatment')
	DROP INDEX [IX_Medicine_MedicineId-DurationOfTreatment] ON Medicine
	CREATE INDEX [IX_Medicine_MedicineId-DurationOfTreatment] ON Medicine (MedicineId, DurationOfTreatment)
GO






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
SELECT 
  Medicine.Name AS 'Drug', 
  Company.Name AS 'Company name',
  Drugstore.Name AS 'Drugstore name',
  Drugstore.Address AS 'Drugstore address',
  [Order].OrderDate AS 'Date ordering',
  [Order].QuantityMedicineInOrder AS 'Order quantity'
FROM Production
INNER JOIN Medicine 
  ON Production.MedicineId = Medicine.MedicineId
INNER JOIN Company
  ON Production.CompanyId = Company.CompanyId
INNER JOIN [Order]
  ON Production.ProductionId = [Order].ProductionId
INNER JOIN Drugstore
  ON [Order].DrugstoreId = Drugstore.DrugstoreId
WHERE (Company.Name LIKE '%Аргус%') AND (Medicine.Name LIKE '%Кордерон%')

-- 3) Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 1.05.12.
SELECT 
  *
FROM Production
LEFT JOIN [Order]
  ON Production.ProductionId = [Order].ProductionId
INNER JOIN Medicine 
  ON Production.MedicineId = Medicine.MedicineId
INNER JOIN Company
  ON Production.CompanyId = Company.CompanyId
WHERE (Company.Name LIKE '%Фарма%') AND ([Order].OrderDate < '2012-05-01') AND ([Order].ProductionId IS NULL)


SELECT 
  *
FROM Production
LEFT JOIN [Order]
  ON Production.ProductionId = [Order].ProductionId
WHERE ([Order].ProductionId IS NULL)

-- 4) Дать минимальный и максимальный баллы по лекарствам каждой фирмы, которая производит не менее 10 препаратов, с указанием названий фирмы и лекарства.

SELECT
  ProductionId, CompanyId, COUNT(MedicineId) AS 'Medicine count'
FROM Production
GROUP BY ProductionId


SELECT 
  SellingId, 
  Sum(ProductID) AS Sum
FROM ProductInSelling
GROUP BY SellingId
HAVING Sum(ProductId) BETWEEN 1.0 AND 3.0
ORDER BY SellingId

-- 5) Дать списки сделавших заказы аптек по всем дилерам компании “Гедеон Рихтер”. Если у дилера нет заказов, в названии аптеки проставить NULL.

-- 6) Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней.




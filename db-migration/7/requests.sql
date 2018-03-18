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

-- 4) Дать минимальный и максимальный баллы по лекарствам каждой фирмы, 
-- которая производит не менее 10 препаратов, 
-- с указанием названий фирмы и лекарства.

SELECT
  N.Name,
  M.MedicineCount,
  M.MinQuality,
  M.Name AS NameMin,
  M.MinQPrice,
  M.MaxQuality,
  M.NameMax,
  M.MaxQPrice
FROM
  (
    SELECT
      K.CompanyId,
      K.MedicineCount,
      K.MinQuality,
      K.Name,
      K.Price AS MinQPrice,
      K.MaxQuality,
      L.Name AS NameMax,
      K.MaxQPrice
    FROM
      (
        SELECT
          I.CompanyId,
          I.MedicineCount,
          I.MinQuality,
          I.Name,
          I.Price,
          I.MaxQuality,
          J.MedicineId AS MaxQMedId,
          J.Price AS MaxQPrice
        FROM
          (
            SELECT
              G.CompanyId,
              G.MedicineCount,
              G.MinQuality,
              G.Name,
              G.Price,
              H.MaxQuality
            FROM
              (
                SELECT
                  F.CompanyId,
                  F.MedicineCount,
                  F.MinQuality,
                  M.Name,
                  F.Price
                FROM
                  (
                    SELECT
                      E.CompanyId,
                      E.MedicineCount,
                      E.MinQuality,
                      P.MedicineId,
                      P.Price
                    FROM
                      (
                        SELECT
                          D.CompanyId,
                          D.MedicineCount,
                          C.MinQuality
                        FROM
                          (
                            SELECT
                              *
                            FROM
                              (
                                (
                                  SELECT
                                    CompanyId,
                                    COUNT(MedicineId) AS 'MedicineCount'
                                  FROM
                                    Production AS A
                                  GROUP BY
                                    A.CompanyId
                                )
                              ) AS B
                            WHERE
                              B.MedicineCount >= 10
                          ) AS D
                          LEFT JOIN (
                            SELECT
                              CompanyId,
                              MIN(QualityControl) AS MinQuality
                            FROM
                              Production AS MinQ
                            GROUP BY
                              CompanyId
                          ) AS C ON D.CompanyId = C.CompanyId
                      ) AS E
                      LEFT JOIN Production AS P ON E.CompanyId = P.CompanyId
                      AND E.MinQuality = P.QualityControl
                  ) AS F
                  LEFT JOIN Medicine AS M ON F.MedicineId = M.MedicineId
              ) AS G
              LEFT JOIN (
                SELECT
                  CompanyId,
                  MAX(QualityControl) AS MaxQuality
                FROM
                  Production AS MaxQ
                GROUP BY
                  CompanyId
              ) AS H ON G.CompanyId = H.CompanyId
          ) AS I
          LEFT JOIN Production AS J ON I.CompanyId = J.CompanyId
          AND I.MaxQuality = J.QualityControl
      ) AS K
      LEFT JOIN Medicine AS L ON K.MaxQMedId = L.MedicineId
  ) AS M
  LEFT JOIN Company AS N ON M.CompanyId = N.CompanyId



-- 5) Дать списки сделавших заказы аптек по всем дилерам компании “Гедеон Рихтер”. 
-- Если у дилера нет заказов, в названии аптеки проставить NULL.
SELECT
  Production.ProductionId,
  Drugstore.Name AS 'Drugstore',
  Dealer.Surname AS 'Dealer surname',
  Company.Name
FROM Production
LEFT JOIN [Order]
  ON Production.ProductionId = [Order].ProductionId
LEFT JOIN Drugstore
  ON [Order].DrugstoreId = Drugstore.DrugstoreId
LEFT JOIN Dealer
  ON Production.DealerId = Dealer.DealerId
LEFT JOIN Company
  ON Production.CompanyId = Company.CompanyId
WHERE Company.Name LIKE '%Годеон Рихтер%'

-- 6) Уменьшить на 20% стоимость всех лекарств, 
-- если она превышает 3000, а длительность лечения не более 7 дней.
SELECT 
  Medicine.MedicineId,
  Medicine.Name,
  Production.Price AS 'Old price',
  (CAST((Production.Price * 0.8) AS money)) AS 'Discount price'
FROM Production
INNER JOIN Medicine
  ON Production.MedicineId = Medicine.MedicineId
WHERE (Production.Price > 3000) AND (Medicine.DurationOfTreatment <= 7)


UPDATE Production
SET ListPrice = ListPrice * 2
FROM Production.Product AS p
INNER JOIN Purchasing.ProductVendor AS pv
    ON p.ProductID = pv.ProductID AND BusinessEntityID = 1540;
GO


---

UPDATE Production
SET Price = Price * 0.8
FROM 
(
SELECT
*
FROM
(
SELECT 
  Medicine.MedicineId,
  (CAST((Production.Price * 0.8) AS money)) AS 'DiscountPrice',
  Production.Price AS 'OldPrice'
FROM Production
INNER JOIN Medicine
ON Production.MedicineId = Medicine.MedicineId
WHERE (Production.Price > 3000) AND (Medicine.DurationOfTreatment <= 7)
) AS A
INNER JOIN A
ON A.OldPrice = Production.Price AND A.MedicineId = Production.MedicineId


UPDATE Production.Product
SET ListPrice = ListPrice * 2
FROM 
Production.Product AS p
INNER JOIN 

Purchasing.ProductVendor AS pv
ON p.ProductID = pv.ProductID AND BusinessEntityID = 1540;


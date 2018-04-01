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

--=====================
-- 3) Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 1.05.12.
SELECT P.MedicineId, M.Name, (O.OrderDate) AS MinDate 
FROM Production AS P 
LEFT JOIN Orders AS O ON P.ProductionId = O.OrderId 
LEFT JOIN Medicine AS M ON P.MedicineId = M.MedicineId
WHERE P.CompanyId = (SELECT C.CompanyId FROM Company AS C WHERE C.Name LIKE '%Фарма%') AND (O.OrderDate > '2012-05-01')
GROUP BY P.MedicineId, O.OrderDate, M.Name

--====================
-- 4) Дать минимальный и максимальный баллы по лекарствам каждой фирмы, которая производит не менее 10 препаратов, с указанием названий фирмы и лекарства
SELECT P.CompanyId, C.Name, MIN(P.QualityControl) AS MinQ, MAX(P.QualityControl) AS MaxQ
FROM Production AS P
LEFT JOIN Company AS C ON P.CompanyId = C.CompanyId
GROUP BY P.CompanyId, C.Name
HAVING COUNT(*) > 10

--====================
-- 5) Дать списки сделавших заказы аптек по всем дилерам компании “Годеон Рихтер”. Если у дилера нет заказов, в названии аптеки проставить NULL.
SELECT P.DealerId, D.Name
FROM Production AS P 
LEFT JOIN Orders AS O ON P.ProductionId = O.ProductionId 
LEFT JOIN Drugstore AS D ON O.DrugstoreId = D.DrugstoreId
WHERE P.CompanyId = (SELECT C.CompanyId FROM Company AS C WHERE C.Name LIKE '%Годеон Рихтер%')
GROUP BY P.DealerId, O.DrugstoreId, D.Name

--====================
-- 6) Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней.
UPDATE Production SET Price = Price * 0.8 
WHERE ProductionId IN (
  SELECT P.ProductionId FROM Production AS P
  INNER JOIN Medicine AS M ON P.MedicineId = M.MedicineId
  WHERE (P.Price > 3000) AND (M.DurationOfTreatment <= 7))


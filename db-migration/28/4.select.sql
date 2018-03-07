-- 1. С определенным набором извлекаемых атрибутов (SELECT atr1, atr2 FROM...)
SELECT Name, Price 
FROM Product

-- 2. Со всеми атрибутами (SELECT * FROM...)
SELECT * 
FROM Product

-- 3. С условием по атрибуту (SELECT * FROM ... WHERE atr1 = "")
SELECT * 
FROM Product
WHERE Name = 'Слива'

-- 4.a - ASC
SELECT *
FROM Product
ORDER BY Name
ASC

-- 4.b - DESC
SELECT *
FROM Product
ORDER BY Name
DESC

-- 4.c - по двум атрибутам
SELECT *
FROM ProductInSelling
ORDER BY ProductId, Count
ASC

-- 4.d - по первому атрибуту, из списка извлекаемых
SELECT *
FROM ProductInSelling
ORDER BY 1
ASC

-- 2. SELECT с функциями агрегации

-- a. 4.1 MIN
-- b. 4.2 MAX 
-- c. 4.3 AVG
-- d. 4.4 SUM
SELECT * FROM ProductInSelling
SELECT 
  SellingId, 
  MIN(Count) AS MinCountForSellingId, 
  MAX(Count) AS MaxCountForSellingId,
  AVG(Count) AS AvgCountForSellingId,
  Sum(Count) AS SumCountForSellingId
FROM ProductInSelling
GROUP BY SellingId    

-- 3. GROUP BY + текстовое объяснение извлекаемых данных
-- a. функция агрегации GROUP BY
SELECT * FROM ProductInSelling
SELECT 
  SellingId, 
  COUNT(ProductId) AS ProductCountInSelling
FROM ProductInSelling
GROUP BY SellingId 

-- b. функция агрегации GROUP BY HAVING                              
SELECT * FROM ProductInSelling
SELECT 
  SellingId, 
  Sum(ProductID) AS Sum
FROM ProductInSelling
GROUP BY SellingId
SELECT 
  SellingId, 
  Sum(ProductID) AS Sum
FROM ProductInSelling
GROUP BY SellingId
HAVING Sum(ProductId) BETWEEN 1.0 AND 3.0
ORDER BY SellingId

-- rename NULL cell
SELECT 
  ProducrId, Name, ISNULL(Manufacture, 'N/A') AS Manuf
FROM
  Product

-- LIKE
SELECT ProducrId, Name, ISNULL(Manufacture, 'N/A') AS Manuf
FROM Product
WHERE Name NOT LIKE 'М%'

-- CONVERT
SELECT contactID, fn, sn, Email 
FROM tblContacts
WHERE contactID BETWEEN 105 AND 110
ORDER BY CONVERT(varchar(255), Email)

-- 4.1 JOINS

-- LEFT JOIN двух таблиц + WHERE по 1 атрибуту
-- найти все номера продаж, в которых были проданы Бананы
SELECT *
FROM ProductInSelling
LEFT JOIN Product ON ProductInSelling.ProductId = Product.ProductId
WHERE Product.Name LIKE 'Банан%'


-- RIGHT JOIN двух таблиц, получить те же записи как в 4.1.
SELECT *
FROM Product
RIGHT JOIN ProductInSelling ON Product.ProductId = ProductInSelling.ProductId
WHERE Product.Name LIKE 'Банан%'

-- LEFT JOIN двух таблиц + WHERE по 2 атрибутам из 1 таблицы
-- получить продукты, которые были в продаже №1, кроме продукта под №1
SELECT *
FROM ProductInSelling
LEFT JOIN Product ON ProductInSelling.ProductId = Product.ProductId
WHERE ProductInSelling.SellingId = 1 AND ProductInSelling.ProductId != 1

-- LEFT JOIN двух таблиц + WHERE по 1 атрибуту из каждой таблицы
-- найти номера продаж, совершенных 2018-01-01, и имена покупателей должны содержать буквы "ри"
SELECT *
FROM Selling
LEFT JOIN Seller ON Selling.SellerId = Seller.SellerId
WHERE Selling.Date = '2018-01-01' AND Seller.Name LIKE '%ри%'

-- LEFT JOIN трех таблиц + WHERE по 1 атрибуту из каждой таблицы
-- Найти номера продаж (кроме №1), 
--   которые были совершены 2018-01-01, 
--   и имена покупателей должны содержать буквы "ри"
SELECT *
FROM ProductInSelling
LEFT JOIN Selling ON ProductInSelling.SellingId = Selling.SellingId
LEFT JOIN Seller ON Selling.SellerId = Seller.SellerId
WHERE ProductInSelling.SellingId != 1 AND Selling.Date = '2018-01-01' AND Seller.Name LIKE '%ри%'

-- SUBSTRING + CHARINDEX
SELECT 
  LEFT(Url, 15) AS URL, 
  SUBSTRING(Url, 1, CHARINDEX('.', Url) - 1 ) AS UrlIndex,
  * 
FROM Host

-- DATEPART
SELECT
  DATEPART(ss, CreationDate) AS Seconds,
  DATEPART(mm, CreationDate) AS Minutes,
  DATEPART(hh, CreationDate) AS Hour,
  DAY(CreationDate) AS Day,
  MONTH(CreationDate) AS Month,
  YEAR(CreationDate) AS Year,  
  *
FROM Host





















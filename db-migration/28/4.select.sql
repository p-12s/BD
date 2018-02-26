-- 1. С определенным набором извлекаемых атрибутов (SELECT atr1, atr2 FROM...)

SELECT Name, Price 
FROM [goods_sellers_sales].[dbo].[Product]

-- 2. Со всеми атрибутами (SELECT * FROM...)

SELECT * 
FROM [goods_sellers_sales].[dbo].[Product]

-- 3. С условием по атрибуту (SELECT * FROM ... WHERE atr1 = "")

SELECT * 
FROM [goods_sellers_sales].[dbo].[Product]
WHERE Name = 'Слива'

-- 4.a - ASC
SELECT *
FROM [goods_sellers_sales].[dbo].[Product]
ORDER BY Name
ASC

-- 4.b - DESC
SELECT *
FROM [goods_sellers_sales].[dbo].[Product]
ORDER BY Name
DESC

-- 4.c - по двум атрибутам
SELECT *
FROM [goods_sellers_sales].[dbo].[ProductInSelling]
ORDER BY ProductId, Count
ASC

-- 4.d - по первому атрибуту, из списка извлекаемых
SELECT *
FROM [goods_sellers_sales].[dbo].[ProductInSelling]
ORDER BY 1
ASC

-- 2. SELECT с функциями агрегации

-- a. 4.1 MIN
-- b. 4.2 MAX 
-- c. 4.3 AVG
-- d. 4.4 SUM
SELECT * FROM [goods_sellers_sales].[dbo].[ProductInSelling]
SELECT 
  SellingId, 
  MIN(Count) AS MinCountForSellingId, 
  MAX(Count) AS MaxCountForSellingId,
  AVG(Count) AS AvgCountForSellingId,
  Sum(Count) AS SumCountForSellingId
FROM [goods_sellers_sales].[dbo].[ProductInSelling]
GROUP BY SellingId    


-- 3. GROUP BY + текстовое объяснение извлекаемых данных
-- a. функция агрегации GROUP BY
SELECT * FROM [goods_sellers_sales].[dbo].[ProductInSelling]

SELECT 
  SellingId, 
  COUNT(ProductId) AS ProductCountInSelling
FROM [goods_sellers_sales].[dbo].[ProductInSelling]
GROUP BY SellingId 

-- b. функция агрегации GROUP BY HAVING                              
SELECT * FROM [goods_sellers_sales].[dbo].[ProductInSelling]

SELECT 
  SellingId, 
  Sum(ProductID) AS Sum
FROM [goods_sellers_sales].[dbo].[ProductInSelling]
GROUP BY SellingId

SELECT 
  SellingId, 
  Sum(ProductID) AS Sum
FROM [goods_sellers_sales].[dbo].[ProductInSelling]
GROUP BY SellingId
HAVING Sum(ProductId) BETWEEN 1.0 AND 3.0
ORDER BY SellingId
















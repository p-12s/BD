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
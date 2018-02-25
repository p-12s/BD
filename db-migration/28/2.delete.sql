-- 1. Всех записей

DELETE FROM [goods_sellers_sales].[dbo].[Product]

-- 2. По условию

DELETE FROM [goods_sellers_sales].[dbo].[Product] 
  WHERE Name='Лимон'

-- 3. Очистить таблицу

TRUNCATE [goods_sellers_sales].[dbo].[Product] 
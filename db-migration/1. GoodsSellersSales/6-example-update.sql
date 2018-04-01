-- 1. Всех записей

UPDATE [goods_sellers_sales].[dbo].[Product]
  SET Name = N'Морковь', Manufacture = 'ООО "Морковь"', Price = 120.50 
                                                    
-- 2. По условию обновляя один атрибут
                                                                              
UPDATE [goods_sellers_sales].[dbo].[Product]
  SET Price = 40.50
  WHERE ProductId = 1

-- 3. По условию обновляя несколько атрибутов

UPDATE [goods_sellers_sales].[dbo].[Product]
  SET Name = N'Слива', Manufacture = 'ООО "Слива"', Price = 40.50
  WHERE ProductId = 2
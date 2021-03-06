-- 1. Без указания списка полей

INSERT INTO [goods_sellers_sales].[dbo].[Product]
  VALUES 
    (N'Апельсины', N'ООО "Апельсин"', 10.50)

-- 2. С указанием списка полей

INSERT INTO [goods_sellers_sales].[dbo].[Product] ([Name], [Manufacture], [Price]) 
  VALUES 
    (N'Апельсины', N'ООО "Апельсин"', 10.50)

-- 3. С чтением значения из другой таблицы

INSERT INTO [goods_sellers_sales].[dbo].[Product] ([Name], [Manufacture], [Price])
SELECT (Name + 'ка'), ('ООО ' + Surname), (SellerId * 100)
FROM [goods_sellers_sales].[dbo].[Seller]

SELECT * FROM [goods_sellers_sales].[dbo].[Product]


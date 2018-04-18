INSERT INTO [goods_sellers_sales].[dbo].[Product] ([Name], [Manufacture], [Price]) 
  VALUES 
    (N'Апельсины', N'ООО "Апельсин"', 10.50), 
    (N'Лимон', N'ООО "Лимон"', 20.50), 
    (N'Банан', N'ООО "Банан"', 30.50), 
    (N'Груша', N'ООО "Груша"', 40.50), 
    (N'Кокос', N'ООО "Кокос"', 50.50) 

INSERT INTO [goods_sellers_sales].[dbo].[Seller]  ([Name], [Surname]) 
  VALUES 
    (N'Антон', N'Антонов'),
    (N'Борис', N'Борисов'),
    (N'Виктор', N'Викторов'),
    (N'Григорий', N'Григорьев'),
    (N'Дмитрий', N'Дмитриев')

INSERT INTO [goods_sellers_sales].[dbo].[Selling]  ([SellerId], [Date]) 
  VALUES 
    (1, '2018-01-01 00:00:00.000'),
    (2, '2018-01-01 00:00:00.000'),
    (3, '2018-01-01 00:00:00.000'),
    (3, '2018-01-02 00:00:00.000'),
    (4, '2018-01-01 00:00:00.000'),
    (5, '2018-01-01 00:00:00.000'),
    (5, '2018-01-02 00:00:00.000')

INSERT INTO [goods_sellers_sales].[dbo].[ProductInSelling]  ([SellingId], [ProductId], [Count]) 
  VALUES 
    (1, 1, 2.45),
    (1, 2, 5.00),
    (2, 2, 0.60),
    (2, 3, 3.20),
    (3, 3, 2.12),
    (3, 4, 1.60),
    (4, 4, 3.21),
    (5, 4, 1.34),
    (5, 5, 8.90)
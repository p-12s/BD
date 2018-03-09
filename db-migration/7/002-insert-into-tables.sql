INSERT INTO Drugstore 
  VALUES 
    (N'Аптечный пункт Журавушка', N'Йошкар-Ола, ул. Прохорова, 50'), 
    (N'36,6', N'424000, Йошкар-Ола, ул. Советская, 133'),
    (N'ABC № 2', N'424000, Республика Марий Эл, город Йошкар-Ола, переулок Лёни Голикова, 9'), 
    (N'FamilyPharm', N'424000, Йошкар-Ола, Ленинский просп., 58'), 
    (N'Farmani', N'Россия, Республика Марий Эл, Йошкар-Ола, улица Баумана, 11Б'), 
    (N'Farmani', N'Йошкар-Ола, ул. Красноармейская, 118а'), 
    (N'Farmani', N'Россия, Республика Марий Эл, Медведевский район, посёлок городского типа Медведево, Советская улица, 45'), 
    (N'Mixtura', N'Йошкар-Ола, ул. Воинов-Интернационалистов, 37'), 
    (N'Аверс - Медикал', N'Россия, Республика Марий Эл, Йошкар-Ола, улица Петрова, 14А')

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
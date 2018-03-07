-- создать БД, если не существует




-------------- create table Product --------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Product' AND xtype='U')
  CREATE TABLE [goods_sellers_sales].[dbo].[Product](
    [ProductId] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](255) NOT NULL,
    [Manufacture] [nvarchar](255) NOT NULL,
    [Price] [float] NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
    (
      [ProductId] ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  )
  ON [PRIMARY]
GO

-------------- create table Seller --------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Seller' AND xtype='U')
  CREATE TABLE [goods_sellers_sales].[dbo].[Seller](
    [SellerId] [int] IDENTITY(1,1) NOT NULL,
    [Name] [nvarchar](255) NOT NULL,
    [Surname] [nvarchar](255) NOT NULL,
    CONSTRAINT [PK_dbo.Seller] PRIMARY KEY CLUSTERED 
    (
      [SellerId] ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO

-------------- create table Selling --------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Selling' AND xtype='U')
  CREATE TABLE [goods_sellers_sales].[dbo].[Selling](
    [SellingId] [int] IDENTITY(1,1) NOT NULL,
    [SellerId] [int] NOT NULL,
    [Date] [datetime] NOT NULL,
    CONSTRAINT [PK_dbo.Selling] PRIMARY KEY CLUSTERED 
    (
      [SellingId] ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO

IF OBJECT_ID('[goods_sellers_sales].[dbo].[FK_dbo.Selling_dbo.Seller_SellerId]') IS NULL
  ALTER TABLE [goods_sellers_sales].[dbo].[Selling]  
    WITH CHECK 
    ADD CONSTRAINT [FK_dbo.Selling_dbo.Seller_SellerId] 
    FOREIGN KEY([SellerId])
    REFERENCES [goods_sellers_sales].[dbo].[Seller] ([SellerId])
    ON DELETE CASCADE
  GO

  ALTER TABLE [dbo].[Selling] 
    CHECK CONSTRAINT [FK_dbo.Selling_dbo.Seller_SellerId]
  GO  

-------------- create table ProductInSelling --------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ProductInSelling' AND xtype='U')
  CREATE TABLE [goods_sellers_sales].[dbo].[ProductInSelling](
    [ProductInSellingId] [int] IDENTITY(1,1) NOT NULL,
    [SellingId] [int] NOT NULL,
    [ProductId] [int] NOT NULL,
    [Count] [float] NOT NULL,
    CONSTRAINT [PK_dbo.ProductInSelling] PRIMARY KEY CLUSTERED 
    (
      [ProductInSellingId] ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  )
  ON [PRIMARY]
GO

IF OBJECT_ID('[goods_sellers_sales].[dbo].[FK_dbo.ProductInSelling_dbo.Selling_SellingId]') IS NULL
  ALTER TABLE [goods_sellers_sales].[dbo].[ProductInSelling]  
    WITH CHECK 
    ADD CONSTRAINT [FK_dbo.ProductInSelling_dbo.Selling_SellingId] 
    FOREIGN KEY([SellingId])
    REFERENCES [goods_sellers_sales].[dbo].[Selling] ([SellingId])
    ON DELETE CASCADE
  GO  

  ALTER TABLE [dbo].[ProductInSelling] 
    CHECK CONSTRAINT [FK_dbo.ProductInSelling_dbo.Selling_SellingId]
  GO

IF OBJECT_ID('[goods_sellers_sales].[dbo].[FK_dbo.ProductInSelling_dbo.Product_ProductId]') IS NULL
  ALTER TABLE [goods_sellers_sales].[dbo].[ProductInSelling]  
    WITH CHECK 
    ADD CONSTRAINT [FK_dbo.ProductInSelling_dbo.Product_ProductId] 
    FOREIGN KEY([ProductId])
    REFERENCES [goods_sellers_sales].[dbo].[Product] ([ProductId])
    ON DELETE CASCADE
  GO 

  ALTER TABLE [dbo].[ProductInSelling] 
    CHECK CONSTRAINT [FK_dbo.ProductInSelling_dbo.Product_ProductId]
  GO
-------------- create table Company --------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Company' AND xtype='U')
  CREATE TABLE Company (
    CompanyId int IDENTITY(1, 1) NOT NULL,
    Name nvarchar (100) NOT NULL,
    YearOfFoundation int NOT NULL,
    CONSTRAINT PK_Company PRIMARY KEY CLUSTERED 
    (
      CompanyId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  )
  ON [PRIMARY]
GO

-------------- create table Dealer --------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Dealer' AND xtype='U')
  CREATE TABLE Dealer (
    DealerId int IDENTITY(1, 1) NOT NULL,
    Surname nvarchar (100) NOT NULL,
    Phone nvarchar (100) NOT NULL,
    CONSTRAINT PK_Dealer PRIMARY KEY CLUSTERED 
    (
      DealerId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO

-------------- create table Medicine --------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Medicine' AND xtype='U')
  CREATE TABLE Medicine (
    MedicineId int IDENTITY(1, 1) NOT NULL,
    Name nvarchar (100) NOT NULL,
    DurationOfTreatment int NOT NULL,
    CONSTRAINT PK_Medicine PRIMARY KEY CLUSTERED 
    (
      MedicineId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO          

-------------- create table Production --------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Production' AND xtype='U')
  CREATE TABLE Production (
    ProductionId int IDENTITY(1, 1) NOT NULL,
    CompanyId int NOT NULL,
    MedicineId int NOT NULL,
    Price money NOT NULL,
    QualityControl int NOT NULL,
    DealerId int NOT NULL,
    CONSTRAINT PK_Production PRIMARY KEY CLUSTERED 
    (
      ProductionId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  )
  ON [PRIMARY]
GO

IF OBJECT_ID('FK_MedicineProduction') IS NULL
  ALTER TABLE [Production]
    WITH CHECK
    ADD CONSTRAINT FK_MedicineProduction
    FOREIGN KEY (MedicineId) REFERENCES Medicine(MedicineId)
    ON DELETE CASCADE
  GO

  ALTER TABLE [Production] 
    CHECK CONSTRAINT FK_MedicineProduction
  GO  

IF OBJECT_ID('FK_CompanyProduction') IS NULL
  ALTER TABLE [Production]
    WITH CHECK
    ADD CONSTRAINT FK_CompanyProduction
    FOREIGN KEY (CompanyId) REFERENCES Company(CompanyId)
    ON DELETE CASCADE
  GO

  ALTER TABLE [Production] 
    CHECK CONSTRAINT FK_CompanyProduction
  GO

IF OBJECT_ID('FK_DealerProduction') IS NULL
  ALTER TABLE [Production]
    WITH CHECK
    ADD CONSTRAINT FK_DealerProduction
    FOREIGN KEY (DealerId) REFERENCES Dealer(DealerId)
    ON DELETE CASCADE
  GO

  ALTER TABLE [Production] 
    CHECK CONSTRAINT FK_DealerProduction
  GO
-------------- create table Drugstore --------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Drugstore' AND xtype='U')
  CREATE TABLE Drugstore (
    DrugstoreId int IDENTITY(1, 1) NOT NULL,
    Name nvarchar (100) NOT NULL,
    Address nvarchar (255) NOT NULL,
    CONSTRAINT PK_Drugstore PRIMARY KEY CLUSTERED 
    (
      DrugstoreId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  )
  ON [PRIMARY]
GO

-------------- create table Order --------------
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Order' AND xtype='U')
  CREATE TABLE [Order](
    OrderId int IDENTITY(1, 1) NOT NULL,
    DrugstoreId int NOT NULL,
    ProductionId int NOT NULL,
    OrderDate date NOT NULL,     
    QualityMedicineInOrder int NOT NULL,
    CONSTRAINT PK_Order PRIMARY KEY CLUSTERED 
    (
      OrderId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  )
  ON [PRIMARY]
GO

IF OBJECT_ID('FK_DrugstoreOrder') IS NULL
  ALTER TABLE [Order]
    WITH CHECK
    ADD CONSTRAINT FK_DrugstoreOrder
    FOREIGN KEY (DrugstoreId) REFERENCES Drugstore(DrugstoreId)
    ON DELETE CASCADE
  GO

  ALTER TABLE [Order] 
    CHECK CONSTRAINT FK_DrugstoreOrder
  GO  

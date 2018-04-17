-------------- create table Subject --------------
-- 1) Предметы: id предмета, название, количество учебных часов.
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Subject' AND xtype='U')
  CREATE TABLE Subject (
    SubjectId int IDENTITY(1, 1) NOT NULL,
    Name nvarchar (100) NOT NULL,
    HoursCount int NOT NULL,        
    CONSTRAINT PK_Subject PRIMARY KEY CLUSTERED 
    (
      SubjectId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  )
  ON [PRIMARY]
GO

-------------- create table Teacher --------------
-- 2) Преподаватели: id преподавателя, фамилия, должность.
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Teacher' AND xtype='U')
  CREATE TABLE Teacher (
    TeacherId int IDENTITY(1, 1) NOT NULL,
    Surname nvarchar (100) NOT NULL,
    Position nvarchar (100) NOT NULL,
    MinimumArea float NOT NULL,
	CONSTRAINT PK_Category PRIMARY KEY CLUSTERED 
    (
      TeacherId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO

-------------- create table Class --------------
-- 3)	Группы: id группы, краткое название группы (ПС-21),  id старосты, Spec - краткое название специальности (ПС, ВМ, ИВТ).
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Class' AND xtype='U')
  CREATE TABLE Class (
    ClassId int IDENTITY(1, 1) NOT NULL, 
    Abbreviation nvarchar (20) NOT NULL,
    PraepostorId int NOT NULL,
    Spec nvarchar (10) NOT NULL,
    CONSTRAINT PK_Class PRIMARY KEY CLUSTERED 
    (
      ClassId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO

IF OBJECT_ID('FK_ClassStudent') IS NULL
  ALTER TABLE [Class]
    WITH CHECK
    ADD CONSTRAINT FK_ClassStudent
    FOREIGN KEY (PraepostorId) REFERENCES Student(StudentId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Class] 
    CHECK CONSTRAINT FK_ClassStudent
  GO
              
-------------- create table Student --------------
-- 4)	Студенты: id студента, фамилия, id группы, год рождения.
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Student' AND xtype='U')
  CREATE TABLE Student (
    StudentId int IDENTITY(1, 1) NOT NULL,
    Surname nvarchar (100) NOT NULL,
    ClassId int NOT NULL,
    YearOfBirth int NOT NULL,
    CONSTRAINT PK_Student PRIMARY KEY CLUSTERED 
    (
      StudentId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO 

-------------- create table Job --------------
--5) Занятия: id занятия, id преподавателя, id предмета, id группы, дата. 
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Job' AND xtype='U')
  CREATE TABLE Job (
    JobId int IDENTITY(1, 1) NOT NULL,
    TeacherId int NOT NULL,
    SubjectId int NOT NULL, 
    ClassId int NOT NULL,
    JobDate date NOT NULL,
    CONSTRAINT PK_Job PRIMARY KEY CLUSTERED 
    (
      JobId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO 

IF OBJECT_ID('FK_ClientReservation') IS NULL
  ALTER TABLE [Reservation]
    WITH CHECK
    ADD CONSTRAINT FK_ClientReservation
    FOREIGN KEY (ClientId) REFERENCES Client(ClientId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Reservation] 
    CHECK CONSTRAINT FK_ClientReservation
  GO

-------------- create table Rating --------------
-- 6)  Оценки: id оценки, номер студента, номер занятия, оценка.
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Rating' AND xtype='U')
  CREATE TABLE RoomInReservRatingation (
    RatingId int IDENTITY(1, 1) NOT NULL,
    StudentId int NOT NULL,
    JobId int NOT NULL,    
    Rating int NOT NULL,    
    CONSTRAINT PK_Rating PRIMARY KEY CLUSTERED 
    (
      RatingId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
GO 

IF OBJECT_ID('FK_ReservationRoomInReservation') IS NULL
  ALTER TABLE [RoomInReservation]
    WITH CHECK
    ADD CONSTRAINT FK_ReservationRoomInReservation
    FOREIGN KEY (ReservationId) REFERENCES Reservation(ReservationId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [RoomInReservation] 
    CHECK CONSTRAINT FK_ReservationRoomInReservation
  GO

IF OBJECT_ID('FK_CategoryRoomInReservation') IS NULL
  ALTER TABLE [RoomInReservation]
    WITH CHECK
    ADD CONSTRAINT FK_CategoryRoomInReservation
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [RoomInReservation] 
    CHECK CONSTRAINT FK_CategoryRoomInReservation
  GO
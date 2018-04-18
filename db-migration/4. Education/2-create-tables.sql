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
	CONSTRAINT PK_Teacher PRIMARY KEY CLUSTERED 
    (
      TeacherId ASC
    )
    WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
    ON [PRIMARY]
  ) 
  ON [PRIMARY]
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
--------------
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
--------------  ЦИКЛ!
IF OBJECT_ID('FK_StudentClass') IS NULL
  ALTER TABLE [Student]
    WITH CHECK
    ADD CONSTRAINT FK_StudentClass
    FOREIGN KEY (ClassId) REFERENCES [Class](ClassId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Student] 
    CHECK CONSTRAINT FK_StudentClass
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
--------------
IF OBJECT_ID('FK_JobTeacher') IS NULL
  ALTER TABLE [Job]
    WITH CHECK
    ADD CONSTRAINT FK_JobTeacher
    FOREIGN KEY (TeacherId) REFERENCES Teacher(TeacherId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Job] 
    CHECK CONSTRAINT FK_JobTeacher
  GO
--------------
IF OBJECT_ID('FK_JobSubject') IS NULL
  ALTER TABLE [Job]
    WITH CHECK
    ADD CONSTRAINT FK_JobSubject
    FOREIGN KEY (SubjectId) REFERENCES Subject(SubjectId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Job] 
    CHECK CONSTRAINT FK_JobSubject
  GO
--------------
IF OBJECT_ID('FK_JobClass') IS NULL
  ALTER TABLE [Job]
    WITH CHECK
    ADD CONSTRAINT FK_JobClass
    FOREIGN KEY (ClassId) REFERENCES Class(ClassId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Job] 
    CHECK CONSTRAINT FK_JobClass
  GO

-------------- create table Rating --------------
-- 6)  Оценки: id оценки, номер студента, номер занятия, оценка.
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Rating' AND xtype='U')
  CREATE TABLE Rating (
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
--------------
IF OBJECT_ID('FK_RatingStudent') IS NULL
  ALTER TABLE [Rating]
    WITH CHECK
    ADD CONSTRAINT FK_RatingStudent
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Rating] 
    CHECK CONSTRAINT FK_RatingStudent
  GO
--------------
IF OBJECT_ID('FK_RatingJob') IS NULL
  ALTER TABLE [Rating]
    WITH CHECK
    ADD CONSTRAINT FK_RatingJob
    FOREIGN KEY (JobId) REFERENCES Job(JobId)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  GO

  ALTER TABLE [Rating] 
    CHECK CONSTRAINT FK_RatingJob
  GO
  
  
  
  
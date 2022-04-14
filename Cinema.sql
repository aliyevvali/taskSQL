--Create database Cinema
--use Cinema
--Create Table Customer(
--	Id int identity(1,1) Primary Key,
--	[Name] nvarchar(100) not null,
--	Surname nvarchar(100) not null,
--	Age int
--)
--Create Table [Sessions](
--	Id int identity(1,1) Primary Key,
--	[Time] time 
--)
--Create Table Tickets(
--	Id int identity(1,1) Primary Key,
--	SoldDate datetime,
--	Price float Check(Price>0),
--	Place int,
--	CustomerId int references Customer(Id),
--	HallId int references Hall(Id),
--	FilmId int references Films(Id),
--	[Sessions] int references [Sessions](Id)
--)
--Create Table Hall(
--	Id int identity(1,1) Primary Key,
--	Name nvarchar(100) Not Null,
--	SeatCount int Check(SeatCount >0)
--)
--Create Table Films(
--	Id int identity(1,1) Primary Key,
--	Name nvarchar(100),
--	ReleaseDate date
--)
--Create Table Genres(
--	Id int identity(1,1) Primary Key,
--	Name nvarchar(100) Not Null
--)
--Create Table Actor(
--	Id int identity(1,1) Primary Key,
--	Name nvarchar(100) Not Null,
--	Surname nvarchar(100) Not Null,
--	Age int Check(Age >0)
--)
--Create Table FilmActors(
--	Id int identity(1,1) Primary Key,
--	FilmId int references Films(Id),
--	Actor int references Actor(Id)
--)
--Create Table FilmGenres(
--	Id int identity(1,1) Primary Key,
--	FilmId int references Films(Id),
--	GenreId int references Genres(Id)
--)

------------------------------------------------------------------------
--Insert Into Actor(Name,Surname,Age)
--Values('Will','Smith',53),
--		('Leonardo','DiCaprio',47),
--		('Angelina','Jolie',46)

--Insert Into Actor(Name,Surname,Age)
--Values('Tom','Cruise',59),
--	('Robert','Downey',57),
--	('Tom','Hanks',65),
--	('Johnny','Depp',58),
--	('Brad','Pitt',58),
--	('Dwayne ','Johnson',49)

--Insert Into Genres(name)
--Values('Komediya Filmi'),
--		('Doyush Filmi'),
--		('Dram Filmi'),
--		('Casus Filmi')

--Insert Into Films(Name,ReleaseDate)
--Values('Mission Impossible','2018-09-25'),
--		('Bad Boys','2020-07-06'),
--		('Fury','2014-01-01'),
--		('Eternals','2021-10-13'),
--		('Iron Man','2008-04-21'),
--		('Baywatch','2017-02-12'),
--		('The Green Mile','1999-05-18'),
--		('Caribbean','2003-11-03'),
--		('Iron Man 2','2010-02-20')


--Insert Into Hall(Name,SeatCount)
--Values('Zall 1',50),
--		('Zall 2',40),
--		('Zall 3',30),
--		('Zall 4',10)

--Insert Into FilmGenres(FilmId,GenreId)
--Values(1,1),
--(2,4),
--(3,2),
--(4,2),
--(5,2),
--(6,3),
--(7,1)



--Select * From Films
--Select * From Genres

--Insert Into FilmActors(FilmID,Actor)
--Values(1,4),
--		(2,8),
--		(3,1),
--		(4,3),
--		(5,7),
--		(6,6),
--		(7,2),
--		(8,9)
		


--Select * From Films
--Select * From  Actor
--Insert Into Customer(Name,Surname,Age)
--Values('Ali','aliyev',19),
--('Rufet','Asgerov',24),
--('Ferhad','Xidirov',20),
--('Nicat','Huseyinli',20),
--('Elvin','Zeyinzade',22),
--('Ayxan','Ceferov',18),
--('Murad','Mamedli',20)

--Insert Into [Sessions]([time])
--Values('22:40:20.0000000'),
--		('22:41:20.0000000'),
--		('22:42:20.0000000'),
--		('22:43:20.0000000'),
--		('22:44:20.0000000'),
--		('22:45:20.0000000'),
--		('22:46:20.0000000'),
--		('22:47:20.0000000'),
--		('22:48:20.0000000')
--Select * From Sessions
--INSERT INTO Tickets(SoldDate,Price,Place,CustomerId,HallId,FilmId,[Sessions])
--Values('2022-04-14',7,12,1,1,1,1),
--	('2022-04-14',4,11,2,1,2,2),
--	('2022-04-14',3.5,1,3,3,3,3),
--	('2022-04-14',10,6,4,2,4,4),
--	('2022-04-14',15,8,5,3,5,6),
--	('2022-04-14',6,9,6,2,6,5),
--	('2022-04-14',8,22,7,2,7,8)
	

--Select * From Tickets , customer


--1)

--Create PROCEDURE usp_BuyTicket @HallId int , @SessionId int , @FilmId int , @CustomerId  int

--as

--	Insert into Values(@HallId,@SessionId,@FilmId,@CustomerId)





---2)
--Create Function GetEmptySeat  (@HallId int, @SessionId int)
--Returns int
--As
--Begin
--Declare @Count int
--Select @Count = Count (h.SeatCount - t.HallId) From Halls as h, Tickets as t
--where
--h.Id = t.HallId
--Return @Count
--End



--ALTER Function GetEmptySeat  (@HallId int, @SessionId int)
--Returns int
--As
--Begin
--Declare @Count int
--Select @Count = SUM(Hall.SeatCount - Tickets.Id) From Tickets 
--Join Hall
--On
--Hall.Id = Tickets.HallId
--Where Hall.Id = @HallId and Tickets.[Sessions] = @SessionId
--Return @Count
--End

--Drop FUnction dbo.GetEmptySeat



	
--Create Function GetEmptySeat (@HallId int, @SessionId int)
--Returns int
--As
--Begin
--Declare @Count int
--Select @Count = h.SeatCount - Count(s.Id) From Tickets as t
--Join Hall As h
--On
--h.Id = t.HallId
--Join [Sessions] s
--On
--s.Id = t.Sessions
--Where @HallId = h.Id and @SessionId = t.Sessions
--Group by h.SeatCount, s.Id
--Return @Count
--End


-----2---------

Alter Function GetEmptySeat (@HallId int, @SessionId int)
Returns int
As
Begin
Declare @Count int
Select @Count = h.SeatCount - Count(s.Id) From Tickets as t
Join Hall As h
On
h.Id = t.HallId
Join [Sessions] as s
On
s.Id = t.Sessions
Where @HallId = h.Id and @SessionId = t.Sessions
Group by h.SeatCount, s.Id
IF @COUNT IS NULL
BEGIN
	SELECT @Count =Hall.SeatCount FROM Tickets
	JOIN Hall
	ON Hall.Id=@HallId
	JOIN [Sessions]
	ON [Sessions].Id =@SessionId
END
	Return @Count
End
Select dbo.GetEmptySeat(1,1)
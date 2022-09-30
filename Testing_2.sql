CREATE TABLE department (
departmentid	int primary key auto_increment,
departmentname	varchar(50)
);

CREATE TABLE Position (
PositionID		int primary key auto_increment,
PositionName	enum ('Dev','Test',' Scrum Master','PM')

);

CREATE TABLE `ACCOUNT` (
AccountID		int primary key auto_increment,
Email			varchar(30),
Username		varchar(50),
FullName		varchar(50),
DepartmentID	int,
PositionID		int,
CreateDate		date,
foreign key (DepartmentID) references department (DepartmentID),
foreign key (PositionID) references `Position` (PositionID)

);

CREATE TABLE `Group` (
GroupID		int primary key auto_increment,
GroupName	varchar(50),
CreatorID	int,
CreateDate	date,
foreign key (CreatorID) references Account (AccountID)

);

CREATE TABLE GroupAccount (
GroupID		int,
AccountID	int,
JoinDate	date,
foreign key (AccountID) references Account (AccountID),
foreign key (GroupID) references `Group` (GroupID)

);

CREATE TABLE TypeQuestion (
TypeID 		int primary key auto_increment,
TypeName	enum ('Essay', 'MultipleChoice')

);

CREATE TABLE CategoryQuestion (
CategoryID		int primary key auto_increment,
CategoryName	varchar(100)

 
);
DROP DATABASE IF EXISTS question;

CREATE TABLE Question (
QuestionID		int primary key auto_increment,
Content			varchar(200),
CategoryID		int,
TypeID			int,
CreatorID		int,
CreateDate		date,
foreign key (CategoryID) references CategoryQuestion (CategoryID),
foreign key (TypeID) references TypeQuestion (TypeID),
foreign key (CreatorID) references Account (AccountID)

);

CREATE TABLE Answer (
AnswerID		int primary key auto_increment,
Content			varchar(100),
QuestionID		int,
isCorrect		bit,
foreign key (QuestionID) references Question (QuestionID)


);

CREATE TABLE Exam (
ExamID			int primary key auto_increment,
`Code`			varchar(20),
Title			varchar(100),
CategoryID		int,
Duration		int,
CreatorID		int,
CreateDate		date,
foreign key (CategoryID) references CategoryQuestion (CategoryID),
foreign key (CreatorID) references Account (AccountID)

);

CREATE TABLE ExamQuestion (
ExamID		 int,
QuestionID	 int,
foreign key (QuestionID) references Question (QuestionID),
foreign key (ExamID) references Exam (ExamID)
);

insert into `position`(position.PositionName)
values 	("Dev"),
		("Test"),
		(' Scrum Master'),
        ('PM');
insert into department (department.departmentname)
value	('maketing'),
		('nhansu'),
        ('baove'),
        ('giamdoc'),
        ('phogiamdoc'),
        ('banhang');

insert into `group` (GroupName,CreatorID,CreateDate) 
value	('sale1',2,'2008-11-11'),
		('sale2',1,'2008-12-22'),
        ('sale3',2,'2011-02-12'),
        ('sale4',1,'2021-01-11'),
        ('sale5',2,'2022-02-11');
        
 insert into groupaccount (GroupID,AccountID,JoinDate)
 value	(6,1,'2022-01-15'),
		(7,1,'2022-12-22');
	
insert into CategoryQuestion (CategoryName)
value	('cau hoi van hoc'),
		('cau toan hoc'),
        ('van cau hoi vi sao');
        
insert into exam (`code`,title, CategoryID,Duration,CreatorID,CreateDate)
value 	('vtiq001','đề thi c#',1,60,1,'2019-04-05'),
		('vtiq002','đề thi php',2,60,2,'2019-04-05'),
        ('vtiq003','đề thi c++',3,120,2,'2019-04-07'),
        ('vtiq004','đề thi java',6,60,1,'2020-04-08');
	
insert into question (Content,CategoryID,TypeID,CreatorID,CreateDate)
value	('cau hoi van hoc',2,1,2,'2022-12-22'),
		('cau toan hoc','3','2','2','1994-05-26'),
        ('van cau hoi vi sao','4','1','2','1995-12-22');
        
insert into answer (Content,QuestionID, isCorrect)
value	('cau tra loi 1',10,0),
		('cau tra loi 2',11,1),
        ('cau tra loi 3',12,0);
        
insert into examquestion (ExamID,QuestionID)
value	(9,11),
		(10,12),
        (12,11);
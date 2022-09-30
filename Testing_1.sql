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
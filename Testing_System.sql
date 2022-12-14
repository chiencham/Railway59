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

Drop Table if exists GroupAccount;
CREATE TABLE GroupAccount (
GroupID		int,
AccountID	int,
JoinDate	date,
primary key (GroupID, AccountID),
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
		(6,2,'2022-01-15'),
        (6,5,'2022-01-15'),
        (6,6,'2022-01-15'),
        (6,7,'2022-01-15'),
		(7,1,'2022-12-22');
	
insert into CategoryQuestion (CategoryName)
value	('cau hoi van hoc'),
		('cau toan hoc'),
        ('van cau hoi vi sao');
        
insert into exam (`code`,title, CategoryID,Duration,CreatorID,CreateDate)
value 	('vtiq001','????? thi c#',1,60,1,'2019-04-05'),
		('vtiq002','????? thi php',2,60,2,'2019-04-05'),
        ('vtiq003','????? thi c++',3,120,2,'2019-04-07'),
        ('vtiq004','????? thi java',6,60,1,'2020-04-08');
	
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

-- q1 l???y danh s??ch ph??ng ban
select * 
from 	department;

-- 3: l???y ra id c???a ph??ng ban "Sale"
select departmentid
 from department 
 where departmentname='sale';
 
 -- lay ra tat cac chuc vu (position)
 select * 
 from	position;
 
 
 -- lay ra c??c tthoog tin c???a position c?? positionName = 'Test'
 select *
 from	position
 where	PositionName = 'test';
 
 -- lay ra exam c?? code = 'vtiq001' va duration =60
 select *
 from	exam 
 where	`code` = 'vtiq001' and duration =60;
 

-- q4 l???y ra th??ng tin account c?? full name d??i nh???t
select * 
from	account
where	length(FullName) = (SELECT MAX(LENGTH(Fullname)) FROM `Account`);-- t??m ????? d??i fullname d??i nh???t

-- L???y ra th??ng tin account c?? full name d??i nh???t v?? thu???c ph??ng ban c?? id = 3
select * 
from	account
where	length(fullname) = (select max(length(fullname)) from `account`) and PositionID = 3;

-- L???y ra t??n group ???? tham gia tr?????c ng??y 20/12/2019(ng??y / th??ng / n??m) n??m - th??ng - ng??y
select * 
from	`group`
where	CreateDate < '2019-12-20';

-- L???y ra c??c m?? ????? thi c?? th???i gian thi >= 60 ph??t v?? ???????c t???o tr?????c ng??y 20/12/2019
select `code`
from	exam 
where	Duration >= 60 and CreateDate < '2019-12-22';

-- L???y ra 3 group ???????c t???o g???n ????y nh???t
select *
from `group`
order by CreateDate DESC-- order by; s???p x???p   +   t??n c???t c???n s???p x???p +    ki???u s???p x???p(giam hay t??ng)
limit 3;-- l???y 3 phan tu dau tien


--   c?? 5 s??    1 4 3 2 5   lay ra 3 so lon nhat 
-- s???p xep theo gi???m d??n    5 4 3 2 1 
-- lay ra 3 so dau hang    5 4 3

-- ?????m s??? nhan vien thu???c department c?? departmentid = 2
select * 
from	account 
where	departmentid = 2;

select count(*)  -- ?????m s??? h??ng 
from	account 
where	departmentid = 2;

-- L???y ra nh??n vi??n c?? t??n b???t ?????u b???ng ch??? "D" v?? k???t th??c b???ng ch??? "o"
select *
from	account
where	FullName like 'D%' and FullName like '%o';
-- 			Dong   like  'D%'  Dndsaodx   == D%

-- X??a t???t c??? c??c exam ???????c t???o tr?????c ng??y 20/12/2019

delete from exam
where CreateDate < '2019-12-20';

select * from exam;

-- 13: X??a t???t c??? c??c question c?? n???i dung b???t ?????u b???ng t??? "c??u h???i%"
delete from question
where Content like 'cau hoi%';


-- Update th??ng tin c???a account c?? id = 5 th??nh t??n "Nguy???n B?? L???c" v?? email th??nh loc.nguyenba@vti.com.vn
update `account`
set		 FullName = 'Nguy???n B?? L???c', Email = 'loc.nguyenba@vti.com.vn'
where	AccountID = 5;

-- update account c?? id = 5 s??? thu???c group c?? id = 4
update groupaccount
set 	GroupID = 4 
where AccountID = 5;

-- q1 Vi???t l???nh ????? l???y ra danh s??ch nh??n vi??n v?? th??ng tin ph??ng ban c???a h???
select * 
from	`Account`a 
join	department d on a.departmentid = d.departmentid;

-- q2 Vi???t l???nh ????? l???y ra th??ng tin c??c account ???????c t???o sau ng??y 20/12/2010
select *
from	`account` a
join	department d on a.DepartmentID = d.departmentid
join	position   p on a.PositionID = p.PositionID
where	CreateDate > '2010-12-20';

-- q3 Vi???t l???nh ????? l???y ra t???t c??? c??c developer
-- lay tat ca thong tin cua account co positionname = dev
select *
from	`account` a
join	department d on a.DepartmentID = d.departmentid
join	position	p on a.Positionid = p.PositionID
where	p.PositionName = 'Dev';

-- Vi???t l???nh ????? l???y ra danh s??ch c??c ph??ng ban c?? >=3 nh??n vi??n

select d.departmentname, count(a.DepartmentID)
from	`account` a
join	department d on a.DepartmentID = d.departmentid
group by a.DepartmentID
having count(a.DepartmentID) >=3; 

-- Vi???t l???nh ????? l???y ra danh s??ch c??u h???i ???????c s??? d???ng trong ????? thi nhi???u nh???t 
select q.*,count(a.QuestionID) 
from	examquestion a 
join	question q on a.QuestionID = q.QuestionID
group by a.QuestionID
having count(a.QuestionID) =(select count(a.QuestionID) 
							from	examquestion a 
							join	question q on a.QuestionID = q.QuestionID
							group by a.QuestionID
							order by count(a.QuestionID) desc
							limit 1  );

-- Vi???t l???nh ????? l???y ra danh s??ch c??u h???i ???????c s??? d???ng trong ????? thi nhi???u nh???t 
-- b1: t??m xem  c??u h???i dc d??ng nhi???u nh???t l?? bao nhi??u l???n
	select count(QuestionID) 
	from	examquestion 
	group by QuestionID
	order by count(QuestionID) desc --  asc: t??ng d???n   desc: gi???m d???n
	limit 1 ;
    --  = 3 l???n  ==5

-- b2: l???p v??o diefu ki???n sau khi join
select q.*,count(a.QuestionID) 
from	examquestion a 
join	question q on a.QuestionID = q.QuestionID
group by a.QuestionID
having count(a.QuestionID) =(select count(a.QuestionID) 
							from	examquestion  a
							group by a.QuestionID
							order by count(a.QuestionID) desc
							limit 1 );

-- Th??ng k?? m???i category Question ???????c s??? d???ng trong bao nhi??u Question 
select a.*, count(a.CategoryID)
from			categoryquestion a 
join			question c 	on 	a.CategoryID = c.CategoryID
group by 		a.CategoryID;

-- Th??ng k?? m???i Question ???????c s??? d???ng trong bao nhi??u Exam
select a.*, count(a.QuestionID)
from		question a 
join		examquestion e on a.QuestionID = e.QuestionID
group by	a.QuestionID;

-- L???y ra Question c?? nhi???u c??u tr??? l???i nh???t
select  count(q.QuestionID)
from	answer a 
join 	question q on a.QuestionID = q.QuestionID
group by q.QuestionID 
order by count(q.QuestionID) desc
limit 1;
--  =1
select  q.*
from	answer a 
join 	question q on a.QuestionID = q.QuestionID
group by q.QuestionID 
having count(q.QuestionID) =(select  count(q.QuestionID)
							from	answer a 
							join 	question q on a.QuestionID = q.QuestionID
							group by q.QuestionID 
							order by count(q.QuestionID) desc
							limit 1);
					
-- Th???ng k?? s??? l?????ng account trong m???i group 
select count(accountid),g.GroupName
from	groupaccount a
join	`group` g on a.GroupID = g.GroupID 
group by 	a.GroupID;

-- T??m ch???c v??? c?? ??t ng?????i nh???t
select count(a.AccountID),p.positionid,p.PositionName
from	`account` a
join	 position p on a.PositionID = p.PositionID
group by  p.PositionID
order by  count(a.AccountID) 
limit 1;

-- L???y th??ng tin chi ti???t c???a c??u h???i bao g???m: th??ng tin c?? b???n c???a question, lo???i c??u h???i, ai l?? ng?????i t???o ra c??u h???i, c??u tr??? l???i l?? g??, ...
select  q.Content as cau_hoi ,a.Content as cau_tra_loi
from	question q 
join	answer a on q.QuestionID = a.QuestionID ;

-- L???y ra s??? l?????ng c??u h???i c???a m???i lo???i t??? lu???n hay tr???c nghi???m
select  count(q.QuestionID),t.TypeName
from 	question q 
join	typequestion t on  q.TypeID = t.TypeID
group by  t.TypeID;

-- :L???y ra group kh??ng c?? account n??o
select *
from	`group` g 
left join	groupaccount c on g.GroupID = c.GroupID
where c.GroupID is null;

-- L???y ra question kh??ng c?? answer n??o
select q.QuestionID,q.Content
from	question q 
left join  answer a on q.QuestionID = a.QuestionID
where  a.QuestionID is null; 

-- L???y c??c account thu???c nh??m th??? 6
select *
from	`account` a 
join 	groupaccount g on a.AccountID = g.AccountID
where	g.GroupID = 6; 

-- L???y c??c account thu???c nh??m th??? 7
select *
from	`account` a 
join 	groupaccount g on a.AccountID = g.AccountID
where	g.GroupID = 7; 

-- Gh??p 2 k???t qu??? t??? c??u a) v?? c??u b) sao cho kh??ng c?? record n??o tr??ng nhau
select *
from	`account` a 
join 	groupaccount g on a.AccountID = g.AccountID
where	g.GroupID = 6
union all
select *
from	`account` a 
join 	groupaccount g on a.AccountID = g.AccountID
where	g.GroupID = 7; 

-- bai 18: L???y c??c group c?? l???n h??n 5 th??nh vi??n    join 2 b???ng n??o d?? vs nhau     group by theo c??jt n??o ????,  diefu kien count(cot n??o d??)<5
		-- b) L???y c??c group c?? nh??? h??n 7 th??nh vi??n   join 2 b???ng n??o d?? vs nhau     group by theo c??jt n??o ????,  diefu kien count(cot n??o d??)>7
        --  Gh??p 2 k???t qu??? t??? c??u a) v?? c??u b) uninon
        
select g.groupname,count(ga.accountid)
from `group` g
join	groupaccount ga on g.GroupID = ga.GroupID
group by	ga.GroupID
having	count(ga.accountid)>=5
union 
select g.groupname,count(ga.accountid)
from `group` g
join	groupaccount ga on g.GroupID = ga.GroupID
group by	ga.GroupID
having	count(ga.accountid)<=7



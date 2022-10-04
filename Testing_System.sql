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

-- q1 lấy danh sách phòng ban
select * 
from 	department;

-- 3: lấy ra id của phòng ban "Sale"
select departmentid
 from department 
 where departmentname='sale';
 
 -- lay ra tat cac chuc vu (position)
 select * 
 from	position;
 
 
 -- lay ra các tthoog tin của position có positionName = 'Test'
 select *
 from	position
 where	PositionName = 'test';
 
 -- lay ra exam có code = 'vtiq001' va duration =60
 select *
 from	exam 
 where	`code` = 'vtiq001' and duration =60;
 

-- q4 lấy ra thông tin account có full name dài nhất
select * 
from	account
where	length(FullName) = (SELECT MAX(LENGTH(Fullname)) FROM `Account`);-- tìm độ dài fullname dài nhất

-- Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
select * 
from	account
where	length(fullname) = (select max(length(fullname)) from `account`) and PositionID = 3;

-- Lấy ra tên group đã tham gia trước ngày 20/12/2019(ngày / tháng / năm) năm - tháng - ngày
select * 
from	`group`
where	CreateDate < '2019-12-20';

-- Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
select `code`
from	exam 
where	Duration >= 60 and CreateDate < '2019-12-22';

-- Lấy ra 3 group được tạo gần đây nhất
select *
from `group`
order by CreateDate DESC-- order by; sắp xếp   +   tên cột cần sắp xếp +    kiểu sắp xếp(giam hay tăng)
limit 3;-- lấy 3 phan tu dau tien


--   có 5 sô    1 4 3 2 5   lay ra 3 so lon nhat 
-- sắp xep theo giảm dàn    5 4 3 2 1 
-- lay ra 3 so dau hang    5 4 3

-- Đếm số nhan vien thuộc department có departmentid = 2
select * 
from	account 
where	departmentid = 2;

select count(*)  -- đếm số hàng 
from	account 
where	departmentid = 2;

-- Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
select *
from	account
where	FullName like 'D%' and FullName like '%o';
-- 			Dong   like  'D%'  Dndsaodx   == D%

-- Xóa tất cả các exam được tạo trước ngày 20/12/2019

delete from exam
where CreateDate < '2019-12-20';

select * from exam;

-- 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi%"
delete from question
where Content like 'cau hoi%';


-- Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
update `account`
set		 FullName = 'Nguyễn Bá Lộc', Email = 'loc.nguyenba@vti.com.vn'
where	AccountID = 5;

-- update account có id = 5 sẽ thuộc group có id = 4
update groupaccount
set 	GroupID = 4 
where AccountID = 5;

-- q1 Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
select * 
from	`Account`a 
join	department d on a.departmentid = d.departmentid;

-- q2 Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
select *
from	`account` a
join	department d on a.DepartmentID = d.departmentid
join	position   p on a.PositionID = p.PositionID
where	CreateDate > '2010-12-20';

-- q3 Viết lệnh để lấy ra tất cả các developer
-- lay tat ca thong tin cua account co positionname = dev
select *
from	`account` a
join	department d on a.DepartmentID = d.departmentid
join	position	p on a.Positionid = p.PositionID
where	p.PositionName = 'Dev';

-- Viết lệnh để lấy ra danh sách các phòng ban có >=3 nhân viên

select d.departmentname, count(a.DepartmentID)
from	`account` a
join	department d on a.DepartmentID = d.departmentid
group by a.DepartmentID
having count(a.DepartmentID) >=3; 

-- Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất 
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

-- Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất 
-- b1: tìm xem  câu hỏi dc dùng nhiều nhất là bao nhiêu lần
	select count(QuestionID) 
	from	examquestion 
	group by QuestionID
	order by count(QuestionID) desc --  asc: tăng dần   desc: giảm dần
	limit 1 ;
    --  = 3 lần  ==5

-- b2: lắp vào diefu kiện sau khi join
select q.*,count(a.QuestionID) 
from	examquestion a 
join	question q on a.QuestionID = q.QuestionID
group by a.QuestionID
having count(a.QuestionID) =(select count(a.QuestionID) 
							from	examquestion  a
							group by a.QuestionID
							order by count(a.QuestionID) desc
							limit 1 );

-- Thông kê mỗi category Question được sử dụng trong bao nhiêu Question 
select a.*, count(a.CategoryID)
from			categoryquestion a 
join			question c 	on 	a.CategoryID = c.CategoryID
group by 		a.CategoryID;

-- Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
select a.*, count(a.QuestionID)
from		question a 
join		examquestion e on a.QuestionID = e.QuestionID
group by	a.QuestionID;

-- Lấy ra Question có nhiều câu trả lời nhất
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
					
-- Thống kê số lượng account trong mỗi group 
select count(accountid),g.GroupName
from	groupaccount a
join	`group` g on a.GroupID = g.GroupID 
group by 	a.GroupID;

-- Tìm chức vụ có ít người nhất
select count(a.AccountID),p.positionid,p.PositionName
from	`account` a
join	 position p on a.PositionID = p.PositionID
group by  p.PositionID
order by  count(a.AccountID) 
limit 1;

-- Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
select  q.Content as cau_hoi ,a.Content as cau_tra_loi
from	question q 
join	answer a on q.QuestionID = a.QuestionID ;

-- Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
select  count(q.QuestionID),t.TypeName
from 	question q 
join	typequestion t on  q.TypeID = t.TypeID
group by  t.TypeID;

-- :Lấy ra group không có account nào
select *
from	`group` g 
left join	groupaccount c on g.GroupID = c.GroupID
where c.GroupID is null;

-- Lấy ra question không có answer nào
select q.QuestionID,q.Content
from	question q 
left join  answer a on q.QuestionID = a.QuestionID
where  a.QuestionID is null; 

-- Lấy các account thuộc nhóm thứ 6
select *
from	`account` a 
join 	groupaccount g on a.AccountID = g.AccountID
where	g.GroupID = 6; 

-- Lấy các account thuộc nhóm thứ 7
select *
from	`account` a 
join 	groupaccount g on a.AccountID = g.AccountID
where	g.GroupID = 7; 

-- Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
select *
from	`account` a 
join 	groupaccount g on a.AccountID = g.AccountID
where	g.GroupID = 6
union all
select *
from	`account` a 
join 	groupaccount g on a.AccountID = g.AccountID
where	g.GroupID = 7; 

-- bai 18: Lấy các group có lớn hơn 5 thành viên    join 2 bảng nào dó vs nhau     group by theo côjt nào đó,  diefu kien count(cot nào dó)<5
		-- b) Lấy các group có nhỏ hơn 7 thành viên   join 2 bảng nào dó vs nhau     group by theo côjt nào đó,  diefu kien count(cot nào dó)>7
        --  Ghép 2 kết quả từ câu a) và câu b) uninon
        
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



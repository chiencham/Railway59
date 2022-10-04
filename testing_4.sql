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


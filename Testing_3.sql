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
DROP DATABASE IF EXISTS Testing_System_Assignment_3;
CREATE DATABASE Testing_System_Assignment_3;
USE Testing_System_Assignment_3;

-- CREATE TABLE 1: DEPARTMENT
CREATE TABLE Department (
	DepartmentID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName	NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- CREATE TABLE 2: POSITION
CREATE TABLE Position (
	PositionID		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName 	ENUM('Dev','Test','Scrum Manager','PM') NOT NULL UNIQUE KEY
);

-- CREATE TABLE 3: ACCOUNT
CREATE TABLE  `Account` (
	AccountID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email			VARCHAR(50) NOT NULL UNIQUE KEY,
    Username		VARCHAR(50) CHECK (length(username) >= 6 ) NOT NULL UNIQUE KEY,
    Fullname		NVARCHAR(50) NOT NULL,
    DepartmentID	TINYINT UNSIGNED NOT NULL,
    PositionID		SMALLINT UNSIGNED NOT NULL,
    CreateDate		DATE NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES Position (PositionID)
    );
    
 -- CREATE TABLE 4: GROUP   
CREATE TABLE `Group` (
	GroupID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName		NVARCHAR(50) NOT NULL,
    CreatorID		TINYINT UNSIGNED NOT NULL,
    CreateDate		DATE
);

-- CREATE TABLE 5: GROUP ACCOUNT
CREATE TABLE GroupAccount (
	GroupID			TINYINT UNSIGNED NOT NULL,
    AccountID		TINYINT UNSIGNED NOT NULL,
    JoinDate		DATE
);

-- CREATE TABLE 6: TYPE QUESTION
CREATE TABLE TypeQuestion (
	TypeID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName 		ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

-- CREATE TABLE 7: CATEGORY QUESTION
CREATE TABLE CategoryQuestion (
	CategoryID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	CategoryName	NVARCHAR(50)	NOT NULL
);

-- CREATE TABLE 8: QUESTION
CREATE TABLE Question (
	QuestionID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content			NVARCHAR(10000),
    CategoryID		TINYINT UNSIGNED,
    TypeID 			TINYINT UNSIGNED,
    CreatorID		TINYINT UNSIGNED,
    CreateDate		DATE,
    FOREIGN KEY (TypeID) REFERENCES TypeQuestion (TypeID),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID)
);

-- CREATE TABLE 9: ANSWER
CREATE TABLE Answer (
	AnswerID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content			NVARCHAR(50),
    QuestionID		TINYINT UNSIGNED, 
    isCorrect		ENUM('True','False'),
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);
 
 -- CREATE TABLE 10: EXAM
 CREATE TABLE Exam (
	ExamID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`			SMALLINT UNSIGNED UNIQUE KEY NOT NULL,
    Tittle			NVARCHAR(50) NOT NULL,
    CategoryID 		TINYINT UNSIGNED NOT NULL,
    Duration 		TINYINT NOT NULL,
    CreatorID		TINYINT UNSIGNED NOT NULL, 
    CreateDate		DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID)
 );
 
 -- CREATE TABLE 11: EXAM QUESTION
 CREATE TABLE ExamQuestion (
	ExamID			TINYINT UNSIGNED PRIMARY KEY,
	QuestionID		TINYINT UNSIGNED,
    FOREIGN KEY (ExamID) REFERENCES Exam (ExamID),
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
 );
 
 
 
-- ======================= ADD DATA INTO TABLES=======================
-- ===================================================================

-- Add data into "Department"
INSERT INTO Department	(DepartmentName)
VALUES					(N'Gi??m ?????c'),
						(N'Th?? k??'),
                        (N'Nh??n s???'),
                        (N'K??? thu???t'),
						(N'Sale'),
                        (N'B???o v???'),
                        (N'Nh?? b???p'),
                        (N'Qu???n ?????c'),
                        (N'K??? to??n'),
                        (N'Ph??p ch???');
					
-- Add data into "Position"
INSERT INTO Position (PositionName)
VALUES 				 ('Dev'			),
					 ('Test'		),
					 ('Scrum Manager'),
					 ('PM'			);
                        
-- Add data into "Account"
INSERT INTO `Account` 	(Email 					,Username 		,Fullname 			,DepartmentID 	,PositionID 	,CreateDate)
VALUES 					('cuongtoi123@gmail.com','cuongtoi'		,'Ch??u Vi???t C?????ng'  ,'1'			,'2'			,'2020-01-02'),
                        ('tuananh999@gmail.com'	,'tuananh'		,'L????ng Tu???n Anh'	,'2'			,'4'			,'2020-02-03'),
						('huanhoahong@yahoo.com','huanhoahong'	,'B??i Xu??n Hu???n'	,'3'			,'3'			,'2020-03-04'),
                        ('namcamcute@gmail.com'	,'namcam'		,'Tr????ng V??n Cam'	,'4'			,'1'			,'2020-04-05'),
                        ('luyendeath@gmail.com'	,'vailuyen'		,'L?? V??n Luy???n'		,'5'			,'2'			,'2020-05-06'),
						('khongminh@gmail.com'	,'giacatluong'	,'Gia C??t D???'		,'6'			,'1'			,'2020-06-07'),
                        ('taothao@yahoo.com'	,'taothaoduoi'	,'T??o V??n Th??o'		,'7'			,'3'			,'2020-07-08'),
                        ('messi@gmail.com'		,'quabongvang'	,'Nguy???n Quang H???i'	,'8'			,'3'			,'2020-08-09'),
                        ('captain@yahoo.com'	,'tienbip'		,'Nguy???n M???nh Ti???n'	,'9'			,'2'			,'2020-12-23'),
                        ('doandaihiep@yahoo.com','doandaihiep'	,'Do??n Ch?? B??nh'	,'10'			,'2'			,'2020-09-10');
                        
-- Add data into "Group"
INSERT INTO `Group`		(GroupName	 	,CreatorID		,CreateDate)
VALUES					('VTI01'		,5				,'2019-01-02'),
						('VTI02'		,4				,'2020-09-02'),
                        ('VTI03'		,3				,'2020-07-04'),
                        ('VTI04'		,2				,'2020-10-10'),
                        ('VTI05'		,1				,'2020-02-03'),
                        ('VTI06'		,10				,'2020-03-12'),
                        ('VTI07'		,8				,'2020-07-07'),
                        ('VTI08'		,9				,'2020-05-01'),
                        ('VTI09'		,6				,'2020-06-01');
                        
-- Add data into "GroupAccount"
INSERT INTO GroupAccount 	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	1		,    1		,'2019-03-05'),
							(	1		,    2		,'2020-03-07'),
							(	3		,    3		,'2020-03-09'),
							(	3		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	1		,    3		,'2020-04-06'),
							(	1		,    7		,'2020-04-07'),
							(	8		,    3		,'2020-04-08'),
							(	1		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');
                            
-- Add data into "TypeQuestion"
INSERT INTO TypeQuestion	(TypeName)
VALUES 						('Essay'			), 
							('Multiple-Choice'	); 
                            
-- Add data into "CategoryQuestion"                            
INSERT INTO	CategoryQuestion		(CategoryName	)
VALUES 								('To??n'			),
									('L??'			),
									('H??a'			),
									('Sinh'			),
									('V??n'			),
									('S???'			),
									('?????a'			),
									('Anh'			),
									('Ph??p'			),
									('?????c'			);
                                    
-- Add data into "Question"
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'C??u h???i v??? To??n'	,	1		,   '1'			,   '2'		,'2020-04-05'),
						(N'C??u h???i v??? L??'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'H???i v??? H??a'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(N'H???i v??? Sinh'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'H???i v??? V??n'		,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'H???i v??? S???'		,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'H???i v??? ?????a'		,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'H???i v??? Anh'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'H???i v??? Ph??p'		,	4		,   '2'			,   '9'		,'2020-04-07'),
						(N'H???i v??? ?????c'		,	7		,   '1'			,   '10'	,'2020-04-07');
                        
-- Add data into "Answers" 
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Tr??? l???i 01'	,   1			,	'True'	),
					(N'Tr??? l???i 02'	,   1			,	'False'	),
                    (N'Tr??? l???i 03'	,   1			,	'False'	),
                    (N'Tr??? l???i 04'	,   1			,	'TRUE'	),
                    (N'Tr??? l???i 05'	,   2			,	'False'	),
                    (N'Tr??? l???i 06'	,   3			,	'True'	),
                    (N'Tr??? l???i 07'	,   4			,	'False'	),
                    (N'Tr??? l???i 08'	,   8			,	'False'	),
                    (N'Tr??? l???i 09'	,   9			,	'True'	),
                    (N'Tr??? l???i 10'	,   10			,	'False'	);            
                    
-- Add data into "Exam"
INSERT INTO Exam	(`Code`		, Tittle						, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('1001'		, N'????? thi To??n'				,	1			,	60		,   '5'			,'2019-04-05'),
					('1002'		, N'????? thi L??'					,	10			,	60		,   '2'			,'2019-04-05'),
                    ('1003'		, N'????? thi H??a'					,	9			,	120		,   '2'			,'2019-04-07'),
                    ('1004'		, N'????? thi Sinh'				,	6			,	60		,   '3'			,'2020-04-08'),
                    ('1005'		, N'????? thi V??n'					,	5			,	120		,   '4'			,'2020-04-10'),
                    ('1006'		, N'????? thi S???'					,	3			,	60		,   '6'			,'2020-04-05'),
                    ('1007'		, N'????? thi ?????a'					,	2			,	60		,   '7'			,'2020-04-05'),
                    ('1008'		, N'????? thi Anh'					,	8			,	60		,   '8'			,'2020-04-07'),
                    ('1009'		, N'????? thi Ph??p'				,	4			,	90		,   '9'			,'2020-04-07'),
                    ('1010'		, N'????? thi ?????c'					,	7			,	90		,   '10'		,'2020-04-08');         
                    
-- Add data "ExamQuestion"
INSERT INTO ExamQuestion(ExamID	, QuestionID	) 
VALUES 					(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		); 
                        
					
-- ===================== TRUY V???N D??? LI???U =====================
-- ============================================================

-- Question 2: L???y ra t???t c??? c??c ph??ng ban
SELECT 	* 
FROM	Department;

-- Question 3: L???y ra ID ph??ng ban "Sale"
SELECT	DepartmentID 
FROM	Department
WHERE 	DepartmentName = 'sale';


-- Question 4: L???y ra th??ng tin account c?? fullname d??i nh???t 
select * from `Account`
where length(Fullname) = (Select max(length(fullname)) from `Account`)
order by fullname DESC;

-- Question 5: L???y ra th??ng tin account c?? fullname d??i nh???t v?? thu???c ph??ng ban c?? ID = 3
select * from `Account`
where length(Fullname) = (Select max(length(fullname)) from `Account`) and departmentID = 3
order by fullname DESC;

-- Question 6: L???y ra t??n group ???? tham gia tr?????c ng??y 20/12/2019
select groupname from `group`
where Createdate < '2019-12-20';

-- Question 7: L???y ra t??n ID c???a question c?? >= 4 c??u tr??? l???i
SELECT QuestionID, count(QuestionID) AS 'SoLuongCauTraLoi' FROM answer 
GROUP BY QuestionID
HAVING count(QuestionID) >=4;

-- Question 8: L???y ra c??c m?? ????? thi c?? tgian thi >= 60 ph??t v?? ???????c t???o tr?????c ng??y 20/12/2019
select `code` from exam
where duration >= 60 and createdate <= '2020-12-20';

-- Question 9: L???y ra 5 group ???????c t???o g???n ????y nh???t
 select * from `group`
 order by createdate DESC
 limit 5 ;

-- Question 10: ?????m s??? nh??n vi??n thu???c department c?? id = 2
select departmentid, count(accountid) AS `SoLuong` from `Account`
where departmentid = 2;

-- Question 11: L???y ra nh??n vi??n b???t ?????u b???ng ch??? "D" v?? k???t th??c b???ng ch??? "O"
Select fullname from `account`
where (substring_index(fullname,'.',-1)) Like 'L%H';

-- Question 12: X??a t???t c??? c??c exam ???????c t???o tr?????c ng??y 20/12/2019
Delete
From exam 
where createdate <'2019-12-20';
Alter Table examquestion Drop Constraint examquestion_ibfk_1;

-- Question 13: X??a t???t c??? c??c question c?? n???i dung b???t ?????u b???ng t??? 'c??u h???i'
delete
from `question`
where (substring_index(content,'.',2)) like 'c??u h???i %';
Alter Table answer Drop Constraint answer_ibfk_1;

-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails 
-- (`testing_system_assignment_3`.`answer`, CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`QuestionID`) 
-- REFERENCES `question` (`QuestionID`))


-- Question 14: update th??ng tin c???a account c?? id = 5 th??nh "Nguy???n B?? L???c" v?? ?????i email th??nh "loc.nguyenba@vti.com.vn"
update `account`
set fullname = N'Nguy???n B?? L???c',
	email = 'loc.nguyenba@vti.com.vn'
where Accountid = 5;

-- Question 15: update account c?? id = 5 s??? thu???c group c?? id = 4
update `groupaccount`
set accountid = 5
where groupid = 4;








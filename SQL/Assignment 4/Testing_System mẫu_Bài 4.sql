/* Lenh xoa Database */
DROP DATABASE IF EXISTS `Testing_System_1`;
/* Lenh tao Database */
CREATE DATABASE IF NOT EXISTS `Testing_System_1`;
/* Lenh su dung Database */
USE `Testing_System_1`;


/*------------------- Create table ----------------------- */

/* Lenh xoa bang */
DROP TABLE IF EXISTS `Department`;
/* Len tao bang va cac cot du lieu cua bang--*/
CREATE TABLE `Department`
(
    `DepartmentID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `DepartmentName` VARCHAR(50) NOT NULL UNIQUE KEY
);
Select * From `Department`;

DROP TABLE IF EXISTS `Position`;
CREATE TABLE IF NOT EXISTS `Position`
(
    `PositionID`   TINYINT UNSIGNED AUTO_INCREMENT,
    `PositionName` ENUM ('Dev1', 'Dev2', 'Test', 'Scrum Master', 'PM'),
    CONSTRAINT pk_1 PRIMARY KEY (PositionID)
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE IF NOT EXISTS `Account`
(
    `AccountID`    MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Email`        VARCHAR(100) UNIQUE,
    `Username`     VARCHAR(50) NOT NULL,
    `Fullname`     VARCHAR(50),
    `DepartmentID` TINYINT UNSIGNED,
    `PositionID`  TINYINT UNSIGNED,
    `CreateDate`   DATETIME ,
    CONSTRAINT fk_dp_id FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_ps_id FOREIGN KEY (`PositionID`) REFERENCES `Position` (`PositionID`) ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE IF NOT EXISTS `Group`
(
    `GroupID`    MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `GroupName`  VARCHAR(50) NOT NULL,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME
);

DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE IF NOT EXISTS `GroupAccount`
(
    `GroupID`   MEDIUMINT,
    `AccountID` MEDIUMINT,
    `JoinDate`  DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE IF NOT EXISTS `TypeQuestion`
(
    `TypeID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `TypeName` VARCHAR(50)
);

DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE IF NOT EXISTS `CategoryQuestion`
(
    `CategoryID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `CategoryName` ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')
);

DROP TABLE IF EXISTS `Question`;
CREATE TABLE IF NOT EXISTS `Question`
(
    `QuestionID` TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(50),
    `CategoryID` TINYINT UNSIGNED,
    `TypeID`     TINYINT UNSIGNED,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME ,
    CONSTRAINT fk_q1 FOREIGN KEY (`CreatorID`) REFERENCES `Account` (`AccountID`) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_q2 FOREIGN KEY (`CategoryID`) REFERENCES `CategoryQuestion` (`CategoryID`) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_q3 FOREIGN KEY (`TypeID`) REFERENCES `TypeQuestion` (`TypeID`) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS `Answer`;
CREATE TABLE IF NOT EXISTS `Answer`
(
    `AnswerID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(50),
    `QuestionID` TINYINT UNSIGNED,
    `isCorrect`  BIT, 
    CONSTRAINT fk_qid FOREIGN KEY (`QuestionID`) REFERENCES `Question` (`QuestionID`) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE IF NOT EXISTS `Exam`
(
    `ExamID`     TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code`       VARCHAR(20) NOT NULL,
    `Title`      VARCHAR(50) NOT NULL,
    `CategoryID` TINYINT UNSIGNED,
    `Duration`   TINYINT,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME ,
    CONSTRAINT fk_ex_1 FOREIGN KEY (CreatorID) REFERENCES Account (AccountID) ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT fk_ex_2 FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID) ON UPDATE CASCADE ON DELETE SET NULL
);


DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE IF NOT EXISTS `ExamQuestion`
(
    `ExamID`     TINYINT UNSIGNED,
    `QuestionID` TINYINT UNSIGNED,
    CONSTRAINT fk_eq1 FOREIGN KEY (ExamID) REFERENCES Exam (ExamID),
    CONSTRAINT fk_eq2 FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);


/* ---------------------- INSERT DATA ---------------------------- */
/* INSERT DATA bang Department */
INSERT INTO `Department`(`DepartmentName`)
VALUES ('Phong Ky Thuat 1'),
       ('Phong Ky Thuat 2'),
       ('Phong Dev 1'),
       ('Phong Dev 2'),
       ('Phong Sale'),
       ('Phong Marketing'),
       ('Phong Giam Doc'),
       ('Phong Tai Chinh');

/* Lenh sua bang `Position` sua kieu du lieu cot `PositionName` */
ALTER TABLE `Position`
    MODIFY COLUMN `PositionName` ENUM ('Dev1', 'Dev2', 'PM', 'Leader', 'Scrum Master' , 'Test');
/* INSERT DATA bang Position */
INSERT INTO `Position`(`PositionName`)
VALUES ('Dev1'),
       ('Dev2'),
       ('Test'),
       ('PM'),
       ('Leader'),
       ('Scrum Master');

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `Account`
    DROP CONSTRAINT `fk_dp_id`,
    DROP CONSTRAINT `fk_ps_id`;
/* INSERT DATA bang Account */
INSERT INTO `Account`(`Email`, `Username`, `Fullname`, `DepartmentID`, `PositionID`, `CreateDate`)
VALUES ('vti_account1@vtiacademy.com', 'vti1', 'Nguyen Van Tinh', 1, 1, '2019-12-01'),
       ('vti_account2@vtiacademy.com', 'vti2', 'Trinh Hoai Linh', 1, 2, '2020-12-01'),
       ('vti_account3@vtiacademy.com', 'vti3', 'Nguyen Van Test', 1, 1, '2020-07-01'),
       ('vti_account4@vtiacademy.com', 'vti4', 'Tran Van Tinh', 1, 2, '2019-09-01'),
       ('vti_account5@vtiacademy.com', 'account5', 'Ho Van Tinh', 3, 2, '2021-07-01'),
       ('vti_account6@vtiacademy.com', 'account_vti6', 'Cao Thai Son', 3, 1, NOW()),
       ('vti_7@vtiacademy.com', 'account_vti7', 'Tam Th???t T??ng', 3, 3, '2020-10-01'),
       ('vti_8@vtiacademy.com', 'account_vti8', 'Nguyen Quynh Thu', 3, 4, '2019-04-01'),
       ('vti_9@vtiacademy.com', 'account_vti9', 'Tran Kim Tuyen', 2, 1, NOW()),
       ('vti_account10@vtiacademy.com', 'account_vti10', 'Nguyen Ba Dao', 1, 5, '2019-10-01'),
       ('vti_account11@vtiacademy.com', 'account_vti11', 'Nguyen Van Binh', 1, 3, '2020-12-01');

/* INSERT DATA bang Group */
INSERT INTO `Group`(`GroupName`, `CreatorID`, CreateDate)
VALUES ('Nhom 1', '3', '2021-04-03'),
       ('Nhom 2', '3', '2019-01-03'),
       ('Nhom 3', '2', '2020-04-03'),
       ('Nhom 4', '1', NOW()),
       ('Nhom 5', '3', '2021-06-03'),
       ('Nhom 6', '1', '2020-04-03'),
       ('Nhom 7', '5', '2021-04-03'),
       ('Nhom 8', '5', '2019-05-03'),
       ('Nhom 9', '3', '2019-01-03'),
       ('Nhom 10', '1', NOW());

/* INSERT DATA bang GroupAccount */
INSERT INTO `GroupAccount`(`GroupID`, `AccountID`, `JoinDate`)
VALUES ('1', '1', '2021-06-01'),
       ('1', '3', '2020-01-01'),
       ('1', '2', NOW()),
       ('1', '4', '2021-06-01'),
       ('2', '1', '2021-06-01'),
       ('2', '10', '2019-05-01'),
       ('5', '1', '2021-06-01'),
       ('5', '3', '2020-01-01'),
       ('5', '4', '2021-07-01'),
       ('3', '1', '2021-06-01'),
       ('9', '2', '2021-06-01'),
       ('10', '1', NOW());

/* INSERT DATA bang TypeQuestion */
INSERT INTO `TypeQuestion`(`TypeName`)
VALUES ('Trac nghiem'),
       ('Tu Luan');

/* INSERT DATA bang CategoryQuestion */
/*`CategoryName` ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')*/
INSERT INTO `CategoryQuestion` (`CategoryName`)
VALUES ('Java'),
       ('SQL'),
       ('HTML'),
       ('CSS '),
       ('.NET'),
       ('Python'),
       ('Ruby'),
       ('JavaScript');

/* Lenh sua bang `Question` Xoa rang buoc khoa ngoai Foreign Key */
ALTER TABLE `Question`
    DROP CONSTRAINT `fk_q1`,
    DROP CONSTRAINT `fk_q2`,
    DROP CONSTRAINT `fk_q3`;
/* INSERT DATA bang Question */
INSERT INTO `Question`(`Content`, CategoryID, TypeID, CreatorID, CreateDate)
VALUES ('C??u h???i SQL 1', 2, 2, 1, '2021-04-01'),
       ('C??u h???i SQL 2', 2, 2, 2, '2020-01-01'),
       ('C??u h???i JAVA 1', 1, 1, 10, '2021-07-01'),
       ('C??u h???i JAVA 2', 1, 2, 5, '2021-06-01'),
       ('C??u h???i HTML 1', 3, 1, 2, NOW()),
       ('C??u h???i HTML 2', 3, 2, 2, NOW());

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `Answer`
    DROP CONSTRAINT `fk_qid`;
/* INSERT DATA bang Answer */
INSERT INTO `Answer` (`Content`, `QuestionID`, `isCorrect`)
VALUES ('C??u tr??? l???i 1 - question SQL 1', 1, 1),
       ('C??u tr??? l???i 2 - question SQL 1', 1, 0),
       ('C??u tr??? l???i 3 - question SQL 1', 1, 0),
       ('C??u tr??? l???i 4 - question SQL 1', 1, 1),
       ('C??u tr??? l???i 1 - question SQL 2', 2, 0),
       ('C??u tr??? l???i 2 - question SQL 2', 2, 0),
       ('C??u tr??? l???i 3 - question SQL 2', 2, 0),
       ('C??u tr??? l???i 4 - question SQL 2', 2, 1),
       ('C??u tr??? l???i 1 - question JAVA 1', 3, 0),
       ('C??u tr??? l???i 2 - question JAVA 1', 3, 1),
       ('C??u tr??? l???i 1 - question JAVA 2', 4, 0),
       ('C??u tr??? l???i 2 - question JAVA 2', 4, 0),
       ('C??u tr??? l???i 3 - question JAVA 2', 4, 0),
       ('C??u tr??? l???i 4 - question JAVA 2', 4, 1),
       ('C??u tr??? l???i 1 - question HTML 1', 5, 1),
       ('C??u tr??? l???i 2 - question HTML 2', 5, 0);

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `Exam`
    DROP CONSTRAINT `fk_ex_1`;
ALTER TABLE `Exam`
    DROP CONSTRAINT `fk_ex_2`;
/* INSERT DATA bang Exam */
INSERT INTO `Exam`(`Code`, `Title`, `CategoryID`, `Duration`, `CreatorID`, `CreateDate`)
VALUES ('MS_01', 'De thi 01', 1, 90, 1, NOW()),
       ('MS_02', 'De thi 02', 1, 60, 5, NOW()),
       ('MS_03', 'De thi 03', 2, 60, 9, NOW()),
       ('MS_04', 'De thi 04', 2, 90, 1, NOW()),
       ('MS_05', 'De thi 05', 1, 60, 2, NOW()),
       ('MS_06', 'De thi 06', 2, 90, 2, NOW()),
       ('MS_07', 'De thi 07', 1, 60, 1, NOW());

/* lenh sua bang xoa khoa ngoai foreign key*/
ALTER TABLE `ExamQuestion`
    DROP CONSTRAINT `fk_eq1`,
    DROP CONSTRAINT `fk_eq2`;
/* INSERT DATA bang Examquestion */
INSERT INTO `ExamQuestion`
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 1),
       (5, 2),
       (6, 2),
       (7, 2),
       (8, 2),
       (9, 3),
       (10, 3),
       (11, 4),
       (12, 4),
       (13, 4),
       (14, 4),
       (15, 5),
       (16, 5);


-- ===================================== B??i t???p ======================================
-- Question 1: Vi???t l???nh ????? l???y ra danh s??ch nh??n vi??n v?? th??ng tin ph??ng ban c???a h???

Select A.Accountid, A.Email, A.Username, D.Departmentname
From `account` A 
Inner join Department D 
on D.DepartmentID = A.DepartmentID;

-- Question 2: Vi???t l???nh ????? l???y ra th??ng tin c??c account ???????c t???o sau ng??y 20/12/2021

Select *
from `account`
where createdate < '2021-12-20';

-- Question 3: Vi???t l???nh ????? l???y ra t???t c??? c??c developer

Select A.username , A.fullname , A.email , P.Positionname
from `Account` A 
inner join Position P
on P.PositionID = A.PositionID
where P.Positionname = 'dev1' or P.Positionname = 'dev2';

-- Question 4: Vi???t l???nh ????? l???y ra danh s??ch c??c ph??ng ban c?? >3 nh??n vi??n

select 	D.Departmentname, count(A.departmentid) as 'Sonhanvien'
from `account` A
inner join department D
on D.Departmentid = A.Departmentid
Group by A.Departmentid
having count(A.departmentid) >=3;

-- Question 5: Vi???t l???nh ????? l???y ra danh s??ch c??u h???i ???????c s??? d???ng trong ????? thi nhi???u nh???t

select EQ.questionID , Q.Content , count(EQ.questionID) as 'S??? l???n ???????c h???i l??' from examquestion EQ
inner join Question Q 
on EQ.questionID = Q.QuestionID
group by EQ.QuestionID
having count(EQ.QuestionID) = (select max(checker) from (select EQ.QuestionID , count(EQ.ExamID) as checker 
														from examquestion EQ
														group by EQ.QuestionID) as maximum);

-- Question 6: Th???ng k?? m???i category Question ???????c s??? d???ng trong bao nhi??u Question

Select CQ.CategoryID , CQ.CategoryName , count(q.categoryID) as `S??? l???n ???????c h???i`
from `question` Q right join categoryquestion CQ on cq.categoryid = q.categoryid
group by (categoryid);


-- Question 7: Th??ng k?? m???i Question ???????c s??? d???ng trong bao nhi??u Exam

Select Q.QuestionID , count(EQ.QuestionID) as 's??? l???n ???????c s??? d???ng'
from examquestion EQ 
right join Question Q 
on Q.QuestionID = EQ.QuestionID
Group by (EQ.QuestionID);

-- Question 8: L???y ra Question c?? nhi???u c??u tr??? l???i nh???t

SELECT Q.QuestionID, Q.Content, count(A.QuestionID) FROM answer A
INNER JOIN question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(A.QuestionID) = (SELECT max(countQues) FROM
(SELECT count(B.QuestionID) AS countQues FROM answer B
GROUP BY B.QuestionID) AS countAnsw);

-- Question 9: Th???ng k?? s??? l?????ng account trong m???i group

Select G.GroupID , count(GA.GroupID) as 'S??? ng?????i trong Group n??y'
from `group` G 
left join groupaccount GA
on G.GroupID = GA.GroupID
Group by G.GroupID;

-- Question 10: T??m ch???c v??? c?? ??t ng?????i nh???t

Select P.Positionname , P.PositionID , count(A.positionID) as 's??? ng?????i mang ch???c v??? n??y' from `account` A
inner join position P 
on A.PositionID = P.positionID
group by A.PositionID
having count(A.PositionID) = (Select min(checker) from (select A.PositionID , count(A.PositionID) as checker
														from `account` A
														group by A.PositionID) as minimum);




-- Question 11: Th???ng k?? m???i ph??ng ban c?? bao nhi??u dev, test, scrum master, PM

Select D.Departmentname, P.Positionname, count(P.Positionname) as 'S??? ng?????i l??m ??? v??? tr?? n??y l??' from `account` A
inner join Department D on D.Departmentid = A.Departmentid
inner join position p on P.Positionid = A.Positionid
group by P.PositionID, d.DepartmentID;




/* Question 12: L???y th??ng tin chi ti???t c???a c??u h???i bao g???m: th??ng tin c?? b???n c???a question, lo???i c??u h???i, 
ai l?? ng?????i t???o ra c??u h???i, c??u tr??? l???i l?? g??*/

Select Q.QuestionID , CQ.Categoryname, Q.Content , A.Fullname , ANS.Content, Q.CreatorID, TQ.Typename from Question Q
inner join TypeQuestion TQ 		on Q.TypeID = TQ.TypeID
inner join answer ANS 			on Q.QuestionID = ANS.QuestionID
inner join `account` A			on Q.CreatorID = A.AccountID
inner join  Categoryquestion CQ on Q.CategoryID = CQ.CategoryID
order by Q.QuestionID;

-- Question 13: L???y ra s??? l?????ng c??u h???i c???a m???i lo???i t??? lu???n hay tr???c nghi???m

Select Q.Questionid, Q.Content, TQ.TypeID, TQ.Typename from Question Q
inner join TypeQuestion TQ on TQ.TypeID = Q.TypeID
group by Q.Questionid;


-- Question 14: L???y ra group kh??ng c?? account n??o

SELECT *  FROM `group` g
LEFT JOIN `groupaccount` ga ON g.GroupID = ga.GroupID
Where AccountID is NUll;

-- Question 16: L???y ra question kh??ng c?? answer n??o

select * from `question`Q
left join  answer A on A.QuestionID = Q.QuestionID
where A.QuestionID is null;

/* Question 17: a) L???y c??c account thu???c nh??m th??? 1
b) L???y c??c account thu???c nh??m th??? 2
c) Gh??p 2 k???t qu??? t??? c??u a) v?? c??u b) sao cho kh??ng c?? record n??o tr??ng nhau*/

Select Accountid 
from groupaccount
where groupid = 1

Union

Select Accountid 
from groupaccount
where groupid = 2;

/* Question 18: a) L???y c??c group c?? l???n h??n 3 th??nh vi??n
b) L???y c??c group c?? nh??? h??n 7 th??nh vi??n
c) Gh??p 2 k???t qu??? t??? c??u a) v?? c??u b) */


Select Groupid
from Groupaccount
group by groupid
having count(accountid) > 3

union all

Select Groupid
from Groupaccount
group by groupid
having count(accountid) < 7;


/* t???i sao c??u a kh??ng l???y ???????c b???ng: 
Select Groupid
from Groupaccount
where count(accountid) > 3; */











































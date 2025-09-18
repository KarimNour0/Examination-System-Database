-- Create DB and use it
create database ITIExaminationSystem
go
use ITIExaminationSystem
--------------------------------------
--Creating Tables
go

create table Department(
	DeptID INT PRIMARY KEY,
	DeptName NVARCHAR(200) NOT NULL,
	IsActive bit NOT NULL Default 1
);
go


create table Track(
	TrackID INT PRIMARY KEY,
    TrackName NVARCHAR(60) NOT NULL,
	Dept_ID  INT NOT NULL,
	TotalHours INT NULL,
    [Description]  NVARCHAR(1000) NULL,
	IsActive bit NOT NULL Default 1,
	CONSTRAINT FK_Track_Dept FOREIGN KEY (Dept_ID) REFERENCES Department(DeptID)
);
go

create table Branch(
	BranchID INT PRIMARY KEY,
	BranchName VARCHAR(50),
    IsActive bit NOT NULL Default 1,
	Manager_UID INT NULL
);
go

create table [Class](
    Branch_ID INT NOT NULL,
    Class_Number NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Class_Branch FOREIGN KEY (Branch_ID) REFERENCES dbo.Branch(BranchID),
	CONSTRAINT PK_Class PRIMARY KEY (Branch_ID,Class_Number)
);
go


create table Intake(
    IntakeID INT PRIMARY KEY,
    IntakeName NVARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
	IsActive BIT DEFAULT 1
);
go



create table [Open] (
    Track_ID  INT NOT NULL,
    Intake_ID INT NOT NULL,
    Branch_ID INT NOT NULL,
    CONSTRAINT CPK_open PRIMARY KEY (Track_ID, Intake_ID, Branch_ID),
    CONSTRAINT FK_Open_Track FOREIGN KEY (Track_ID) REFERENCES Track(TrackID),
    CONSTRAINT FK_Open_Intake FOREIGN KEY (Intake_ID) REFERENCES Intake(IntakeID),
    CONSTRAINT FK_Open_Branch FOREIGN KEY (Branch_ID) REFERENCES Branch(BranchID)
);
go



create table [Role](
    RoleID INT PRIMARY KEY,
    RoleName   NVARCHAR(100)  NOT NULL
);
go

create table [User] (
    UserID INT PRIMARY KEY,
	Role_ID INT NOT NULL,
    [Name] NVARCHAR(60) NOT NULL,
    [Address] NVARCHAR(200) NULL,
    Email NVARCHAR(120) NOT NULL,
    [Password] NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(13) NULL,
    DOB DATE NULL,
    Branch_ID INT NULL,
    Dept_ID INT NULL,
    Track_ID INT NULL,
    Intake_ID  INT NULL,
	IsActive BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_User_Role FOREIGN KEY (Role_ID) REFERENCES [Role](RoleID),
    CONSTRAINT FK_User_Branch FOREIGN KEY (Branch_ID) REFERENCES Branch(BranchID),
    CONSTRAINT FK_User_Department FOREIGN KEY (Dept_ID) REFERENCES Department(DeptID),
    CONSTRAINT FK_User_Track FOREIGN KEY (Track_ID) REFERENCES Track(TrackID),
    CONSTRAINT FK_User_Intake FOREIGN KEY (Intake_ID) REFERENCES Intake(IntakeID)
);
go


ALTER TABLE Branch
ADD CONSTRAINT FK_Branch_Manager
FOREIGN KEY (Manager_UID) REFERENCES [User](UserID)
ON DELETE SET NULL;

go

create table Course(
    CourseID INT PRIMARY KEY,
    CourseName NVARCHAR(60) NOT NULL,
    [Description] NVARCHAR(400) NULL,
    MaxDegree INT NULL,
    MinDegree INT NULL
);
go

create table Exam(
    ExamID INT PRIMARY KEY,
    Course_ID INT NOT NULL,
    Start_Time TIME(0) NOT NULL,
    End_Time TIME(0) NOT NULL,
    [Date] DATE NOT NULL,
    Score INT NULL,
    ExamType NVARCHAR(10) NOT NULL,
	Branch_ID INT NOT NULL,
    Track_ID int NOT NULL,
	[User_ID] INT NOT NULL,
    Archived BIT NOT NULL CONSTRAINT DF_Exam_Archived DEFAULT (0)
	CONSTRAINT FK_Exam_UserID FOREIGN KEY ([User_ID]) REFERENCES [User](UserID),
	CONSTRAINT FK_Exam_BranchID FOREIGN KEY (Branch_ID) REFERENCES Branch(BranchID),
    CONSTRAINT FK_Exam_Course FOREIGN KEY (Course_ID) REFERENCES Course(CourseID),
    CONSTRAINT FK_Exam_Track FOREIGN KEY (Track_ID) REFERENCES dbo.Track(TrackID),
    CONSTRAINT CK_Exam_Type CHECK (ExamType IN ('corrective', 'normal'))
);
go



create table Track_Course(
    Track_ID  INT NOT NULL,
    Course_ID INT NOT NULL,
    CONSTRAINT PK_Track_Course PRIMARY KEY (Track_ID, Course_ID),
    CONSTRAINT FK_TC_Track  FOREIGN KEY (Track_ID)  REFERENCES Track(TrackID),
    CONSTRAINT FK_TC_Course FOREIGN KEY (Course_ID) REFERENCES Course(CourseID)
);
go


create table UserTakes(
    User_ID   INT NOT NULL,
    Course_ID INT NOT NULL,
    CONSTRAINT PK_Take PRIMARY KEY (User_ID, Course_ID),
    CONSTRAINT FK_Take_User   FOREIGN KEY (User_ID)   REFERENCES [User](UserID),
    CONSTRAINT FK_Take_Course FOREIGN KEY (Course_ID) REFERENCES Course(CourseID)
);
go


create table Teach(
    User_ID INT NOT NULL,
    Course_ID INT NOT NULL,
    Branch_ID INT NOT NULL,
	Track_ID int NOT NULL,
    CONSTRAINT PK_Teach PRIMARY KEY (User_ID, Course_ID, Branch_ID,Track_ID),
    CONSTRAINT FK_Teach_User FOREIGN KEY(User_ID) REFERENCES [User](UserID),
    CONSTRAINT FK_Teach_Course FOREIGN KEY (Course_ID) REFERENCES dbo.Course(CourseID),
    CONSTRAINT FK_Teach_Branch FOREIGN KEY (Branch_ID) REFERENCES dbo.Branch(BranchID),
	CONSTRAINT FK_Teach_Track FOREIGN KEY (Track_ID) REFERENCES dbo.Track(TrackID)
	);
go

create table QuestionPool(
    QPID INT PRIMARY KEY,
    Course_ID INT NOT NULL,
    [Type] NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(500) NOT NULL,
    CONSTRAINT FK_QP_Course FOREIGN KEY (Course_ID) REFERENCES Course(CourseID),
    CONSTRAINT CK_QP_Type CHECK ([Type] IN ('MCQ', 'Text', 'TrueFalse'))
);
go


create table Answer_MCQ(
    QP_ID INT NOT NULL,
    OptionID TINYINT NOT NULL,
    [Option] NVARCHAR(50) NOT NULL,
    IS_Correct BIT NOT NULL DEFAULT(0),
    CONSTRAINT PK_Answer_MCQ PRIMARY KEY (QP_ID, OptionID),
    CONSTRAINT FK_AMCQ_QP FOREIGN KEY (QP_ID) REFERENCES dbo.QuestionPool(QPID),
    CONSTRAINT CK_AMCQ_OptionID CHECK (OptionID BETWEEN 1 AND 4)
);
go


create table [Choose](
    Exam_ID INT NOT NULL,
    QP_ID INT NOT NULL,
    Degree INT NOT NULL,
    CONSTRAINT PK_Choose PRIMARY KEY (Exam_ID, QP_ID),
    CONSTRAINT FK_Choose_Exam FOREIGN KEY (Exam_ID) REFERENCES Exam(ExamID),
    CONSTRAINT FK_Choose_QP   FOREIGN KEY (QP_ID) REFERENCES QuestionPool(QPID)
);
go


create table StudentAnswer(
    User_ID INT NOT NULL,
    Exam_ID INT NOT NULL,
    QP_ID INT NOT NULL,
    Student_Answer NVARCHAR(500) NULL,
	QScore int,
    CONSTRAINT PK_Student_Answer PRIMARY KEY (User_ID, Exam_ID, QP_ID),
    CONSTRAINT FK_SA_User FOREIGN KEY (User_ID) REFERENCES [User](UserID),
    CONSTRAINT FK_SA_Exam FOREIGN KEY (Exam_ID) REFERENCES Exam(ExamID),
    CONSTRAINT FK_SA_QP   FOREIGN KEY (QP_ID) REFERENCES QuestionPool(QPID)
);
go

create table Answer_Text(
    QP_ID INT NOT NULL PRIMARY KEY,
    Answer NVARCHAR(1000) NOT NULL,
    CONSTRAINT FK_AT_QP FOREIGN KEY (QP_ID) REFERENCES QuestionPool(QPID)
);
go


CREATE TABLE dbo.StudentExamResult
(
    User_ID      INT         NOT NULL,
    Exam_ID      INT         NOT NULL,
    TotalScore   INT         NOT NULL,
    IsPass       BIT         NOT NULL,
    CalculatedAt DATETIME    NOT NULL CONSTRAINT DF_StudentExamResult_CalcAt DEFAULT (GETDATE()),
    CONSTRAINT PK_StudentExamResult PRIMARY KEY (User_ID, Exam_ID),
    CONSTRAINT FK_SER_User FOREIGN KEY (User_ID) REFERENCES dbo.[User](UserID),
    CONSTRAINT FK_SER_Exam FOREIGN KEY (Exam_ID) REFERENCES dbo.Exam(ExamID)
);
go

create table AuditExamSubmissions (
    Log_ID INT IDENTITY(1,1) PRIMARY KEY,
    [User_ID] INT NOT NULL,
    Exam_ID INT NOT NULL,
    Question_Pool_ID INT  NULL,
    Student_Answer NVARCHAR(4000) NULL,
    Attempt_Time DATETIME DEFAULT GETDATE(),
);
go

CREATE TABLE AuditUserChanges (
    Log_ID INT IDENTITY(1,1) PRIMARY KEY,
    [User_ID] INT NOT NULL,
    Role_ID INT NOT NULL,
    Department_ID INT  NULL,
    Track_ID INT  NULL,
    Attempt_Time DATETIME DEFAULT GETDATE(),
    Name nvarchar(120) NOT NULL,
    Email nvarchar(120)  NULL
);
go

------------------------------------------
--Index
------------------------------------------
--Only One manager Allowed
create unique index UX_OnlyOneManager
    on [User](Role_ID,IsActive)
    where Role_ID = 4 and IsActive = 1
;

go
--Class
create index IX_Class_Branch
on [Class](Branch_ID);
create index IX_Branch_ClassNumber
on [Class](Branch_ID, Class_Number)
;
go

--Intake
create unique nonclustered index IX_IntakeName
on Intake(IntakeName);
create index IX_ActiveIntakes
on Intake(IsActive)
;
go

--Open
create index IX_Open_Track
on [Open](Track_id);
create index IX_Open_Branch
on [Open](Branch_id);
create index IX_Open_Intake
on [Open](Intake_id)
;
go

--Users
create index IX_RoleID
on [user](Role_ID);
create index IX_UserName
on [user]([Name]);
create unique nonclustered index IX_UserEmail
on [User](UserID,Email);
create unique nonclustered index IX_UserPhone
on [User](UserID,Phone);
create index IX_UserBranch
on [user](Branch_ID);
create index IX_UserDept
on [user](Dept_ID);
create index IX_UserTrack
on [user](Track_ID);
create index IX_UserStatus
on [user](IsActive)
;
go

--Course
create unique nonclustered index IX_CourseName
on Course(CourseName)
;
go

--Exam
create index IX_ExamCourse
on Exam(Course_ID);
create index IX_ExamDate
on Exam([Date]);
create index IX_ExamType
on Exam(ExamType);
create index IX_Exam_UID
on Exam([User_ID]);
create index IX_Exam_BranchID
on Exam(Branch_ID)
;
go

--Track_Course
create index IX_TC
on Track_Course(Track_ID);
create index IX_TC_Course
on Track_Course(Course_ID)
;
go

--Student Takes Couerse
create index IX_UserTakes_User
on UserTakes(User_ID);
create index IX_UserTakes_Course
on UserTakes(Course_ID)
;
go

--Instructors Teach Course
create index IX_Teach_User
on Teach([User_ID]);
create index IX_Teach_Course
on Teach(Course_ID);
create index IX_Teach_Branch
on Teach(Branch_ID);
create index IX_Teach_Track
on Teach(Track_ID)
;
go

-- Question Pool
create index IX_QP_Course
on QuestionPool(Course_ID);
create index IX_QP_Type
on QuestionPool([Type]);
create index IX_QP_Course_Type
on QuestionPool(Course_ID, [Type])
;
go

-- Answer_MCQ
create index IX_AnsMCQ_QP
on Answer_MCQ(QP_ID);
create index IX_IsCorrect
on Answer_MCQ(IS_Correct)
;
go

-- Choose
create index IX_Choose_Exam
on Choose(Exam_ID);
create index IX_Choose_QP
ON Choose(QP_ID)
;
go

--
create index IX_StudentAnswer_User
on StudentAnswer([User_ID]);
create index IX_StudentAnswer_Exam
on StudentAnswer(Exam_ID);
create index IX_StudentAnswer_QP
on StudentAnswer(QP_ID)
;


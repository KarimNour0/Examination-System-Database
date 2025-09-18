EXEC AddStudent 
    @Name = N'Ahmed Ali',
    @Address = N'Cairo',
    @Email = N'ahmed@test.com',
    @Password = N'pass123',
    @Phone = N'01000000001',
    @DOB = '2000-05-01',
    @BranchID = 1,
    @TrackID = 1;
----------------------------
EXEC AddInstructor 
    @Name = N'Mona Hassan',
    @Address = N'Alex',
    @Email = N'mona@test.com',
    @Password = N'abc123',
    @Phone = N'01000000002',
    @DOB = '1980-10-12',
    @DeptID = 2,
    @BranchID = 1;
    --------------------------
    EXEC AddAdmin 
    @Name = N'Samir Ibrahim',
    @Address = N'Giza',
    @Email = N'samir@test.com',
    @Password = N'root123',
    @Phone = N'01000000003',
    @DOB = '1990-07-20',
    @BranchID = 1;

----------------------------
EXEC Change_TM_New 
    @Name = N'New Manager',
    @Address = N'Mansoura',
    @Email = N'manager@test.com',
    @Password = N'man123',
    @Phone = N'01000000004',
    @DOB = '1975-09-10';
---------------------------
EXEC RemoveUser @UID = 3;
------------------------
EXEC StudentToInstructor @UserID = 10, @DeptID = 2, @BranchID = 1;
----------------------------------
exec AddDept @DeptName = N'Computer Science';
------------------------------------------
exec RemoveDept @DeptID = 2;
-----------------------------
exec AddTrack 
    @TrackID = 100,
    @TrackName = N'.NET Development',
    @Dept_ID = 2,
    @TotalHours = 120,
    @Description = N'Development using .NET stack';
---------------------------------------------------------
exec RemoveTrack @TrackID = 10;
-------------------------------------------
exec Open_New_Branch @BranchName = N'Ismailia';
-------------------------------------------------
exec RemoveBranch @BranchID = 3;
----------------------------------------
exec NewIntake 
    @IntakeName = N'Intake Sep 2026',
    @StartDate = '2025-09-01',
    @EndDate = '2026-01-31';
------------
exec StopIntake @IntakeID = 5;
--------------------------------------------------------------------------
exec NewOpenning @TrackID = 2, @IntakeID = 6, @BranchID = 1;
--------------------------------------------------------------------------
exec AddCourse 
    @CourseName = N'Database Systemss',
    @Description = N'Intro to DB',
    @Max_Degree = 100,
    @Min_Degree = 50;
----------------------------------------------------------------------------
exec AddTrackCourse @Track_ID = 55, @Course_ID = 10;
-----------------
exec RemoveTrackCourse @Track_ID = 55, @Course_ID = 10;
----------------------------------------
exec AddUserTakes @User_ID = 15, @Course_ID = 10;
----------------------------------------------------------------------------------------------
exec RemoveUserTakes @User_ID = 15, @Course_ID = 10;
--------------------------------------------------
-----------------------Test------------
exec dbo.AddQuestionUnified
    @Course_ID = 10,
    @Type = N'MCQ',
    @Description = N'What is SQL?',
    @Option1 = N'Programming Language',
    @Option2 = N'Query Language',
    @Option3 = N'Operating System',
    @CorrectOption = 2;
----------------------
exec dbo.AddQuestionUnified
    @Course_ID = 10,
    @Type = N'TrueFalse',
    @Description = N'SQL stands for Structured Query Language',
    @CorrectOption = 1;
---------------------------
exec dbo.AddQuestionUnified
    @Course_ID = 10,
    @Type = N'Text',
    @Description = N'Explain normalization',
    @TextAnswer = N'Reducing redundancy in database design';
    ------------------------------------------------------------
exec dbo.RemoveQuestionUnified @QPID = 12;
------------------------------------------------
exec AssignInstructorCourse @UserID = 7, @CourseID = 10, @BranchID = 1, @TrackID = 2;
------------------------------------------
exec AddQuestionToExam @ExamID = 100, @QPID = 12, @Degree = 10;

------------------------------------------

exec CreateExam 
    @ExamID = 6768,
    @Course_ID = 4,
    @Track_ID = 1,
    @Start_Time = '10:27',
    @End_Time = '16:00',
    @Date = '2025-09-3',
    @Score = 100,
    @ExamType = 'normal',
    @Branch_ID = 1,
    @UserID = 81;

exec dbo.populateexamchooseauto
    @examid = 6768 ,
    @questioncount =3
--------------------------------------------------------------
---- will not work untill an start date of the exam has started
exec dbo.StudentAnswer_PROCEDURE 
    @user_id = 113, 
    @exam_id = 1, 
    @question_id = 17,  
    @student_answer = N'Query Language';

exec dbo.StudentAnswer_PROCEDURE 
    @user_id = 113, 
    @exam_id = 676, 
    @question_id = 16, 
    @student_answer = N'true';

exec dbo.StudentAnswer_PROCEDURE 
@user_id = 113, 
@exam_id = 676, 
@question_id = 39, 
@student_answer = N'false';

exec dbo.ProcessFinishedExamsAndArchive;

update Exam set End_Time = '14:50' where ExamID = 676

    -- Core Entities
SELECT * FROM Department;
SELECT * FROM Track;
SELECT * FROM Branch;
SELECT * FROM [Class];
SELECT * FROM Intake;
SELECT * FROM [Open];
SELECT * FROM [Role];
SELECT * FROM [User];
SELECT * FROM Course;
SELECT * FROM Exam;

-- Relationships
SELECT * FROM Track_Course;
SELECT * FROM UserTakes;
SELECT * FROM Teach;

-- Questions & Answers
SELECT * FROM QuestionPool ;
SELECT * FROM Answer_MCQ;
SELECT * FROM [Choose];
SELECT * FROM StudentAnswer;
SELECT * FROM Answer_Text;

-- Audit & Logging
SELECT * FROM AuditUserChanges;
SELECT * FROM AuditExamSubmissions;



select * from StudentExamResult


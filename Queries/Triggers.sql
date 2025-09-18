use ITIExaminationSystem
go
-----------------------------------------------------------
--Triggers
-----------------------------------------------------------
--Prevent Non-Instructor as Branch Manager
CREATE OR ALTER TRIGGER NonInstructorasManager
ON [User]
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  -- Example meaning:
  -- Role_ID: 1 = Student, 3 = Admin, 4 = Manager (replace with your real IDs!)
  IF EXISTS (
    SELECT 1
    FROM inserted i
    JOIN deleted  d ON i.UserID = d.UserID
    WHERE d.Role_ID IN (1,3)   -- from Student/Admin
      AND i.Role_ID = 4        -- to Manager
  )
  BEGIN
    RAISERROR('Cannot change Student/Admin to Manager via user update.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;
GO



-- Checks no 2 exams on the same date and course
CREATE OR ALTER TRIGGER trg_Exam_NoOverlap
ON Exam
AFTER INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  IF EXISTS (
    SELECT 1
    FROM inserted i
    JOIN dbo.Exam e
      ON e.Course_ID = i.Course_ID
     AND e.Branch_ID = i.Branch_ID
     AND e.[Date]    = i.[Date]
     AND e.ExamID   <> i.ExamID
     AND (i.Start_Time < e.End_Time AND e.Start_Time < i.End_Time)
  )
  BEGIN
    RAISERROR('Another exam for this course/branch/date overlaps in time.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;



-----TotalDegreeWithinMax
go
CREATE OR ALTER TRIGGER trg_Choose_TotalDegreeWithinMax
ON [Choose]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  SET NOCOUNT ON;

  IF EXISTS (
    SELECT 1
    FROM Exam e
    JOIN Course c ON c.CourseID = e.Course_ID
    CROSS APPLY (
      SELECT SUM(ch.Degree) AS SumDeg
      FROM [Choose] ch
      WHERE ch.Exam_ID = e.ExamID
    ) s
    WHERE s.SumDeg > c.MaxDegree
  )
  BEGIN
    RAISERROR('Sum of question Degrees for this Exam exceeds Course.MaxDegree.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;

GO


---------------------
--Cascade Delete Prevention/

create OR ALTER trigger DeletePrevention
on  [User]
after delete
as
begin
    if exists(
        select * from deleted d
        join UserTakes  T
        on d.UserID = T.[User_ID]
        join Course C on C.CourseID = T.Course_ID
    )
    BEGIN
    rollback
    print 'You cannot delete the user ' 
    END

    end
go

CREATE OR ALTER TRIGGER trg_AuditUserChanges
ON [User]
AFTER INSERT, UPDATE
AS
BEGIN
  INSERT INTO dbo.AuditUserChanges (User_ID, Role_ID, Department_ID, Track_ID, Name, Email)
  SELECT i.UserID, i.Role_ID, i.Dept_ID, i.Track_ID, i.[Name], i.Email
  FROM inserted i;
END;
GO

-------Audit Exam Submissions /-- (Log) --------------------
go
create or alter trigger trg_ExamAttemptLog
on StudentAnswer
after insert , update
as
begin
  INSERT INTO dbo.AuditExamSubmissions (User_ID, Exam_ID, Question_Pool_ID, Student_Answer)
  SELECT i.User_ID, i.Exam_ID, i.QP_ID, i.Student_Answer
  FROM inserted i;
end;

----------------------------

-- Text answers must be for Text questions
go
CREATE OR ALTER TRIGGER trg_AnswerText_OnlyForText
ON Answer_Text
AFTER INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  IF EXISTS (
    SELECT 1
    FROM inserted i
    JOIN QuestionPool qp ON qp.QPID = i.QP_ID
    WHERE qp.[Type] <> N'Text'
  )
  BEGIN
    RAISERROR(N'Answer_Text allowed only for Text questions.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;
GO

-- MCQ/TF options only for MCQ or TrueFalse
CREATE OR ALTER TRIGGER trg_AnswerMCQ_OnlyForMCQorTF
ON Answer_MCQ
AFTER INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON;


  IF EXISTS (
    SELECT 1
    FROM inserted i
    JOIN QuestionPool qp ON qp.QPID = i.QP_ID
    WHERE qp.[Type] NOT IN (N'MCQ', N'TrueFalse')
  )
  BEGIN
    RAISERROR(N'Answer_MCQ allowed only for MCQ/TrueFalse questions.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;
GO

-- For True/False: OptionID 1='True', 2='False' only
CREATE OR ALTER TRIGGER trg_AnswerMCQ_ValidateTF
ON Answer_MCQ
AFTER INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  IF EXISTS (
    SELECT 1
    FROM inserted i
    JOIN QuestionPool qp ON qp.QPID = i.QP_ID
    WHERE qp.[Type] = N'TrueFalse'
      AND NOT (
           (i.OptionID = 1 AND i.[Option] = N'True')
        OR (i.OptionID = 2 AND i.[Option] = N'False')
      )
  )
  BEGIN
    RAISERROR(N'TF must be OptionID 1=True or 2=False.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;
GO



-- Validate Branch.Manager_UID points to a user whose Role is Manager
CREATE OR ALTER TRIGGER trg_Branch_ManagerRoleOnly
ON dbo.Branch
AFTER INSERT, UPDATE
AS
BEGIN
  IF EXISTS (
    SELECT 1
    FROM inserted i
    JOIN dbo.[User] u ON u.UserID = i.Manager_UID
    WHERE u.Role_ID <> 4  -- <-- put your actual Manager RoleID here
  )
  BEGIN
    RAISERROR('Manager_UID must reference a user with Manager role.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;
GO




----------------------------Commented Triggers for ease of testing data--------------------------------------------
/*
--Restrict Answers To Exam Window- start_time و end_time.--
CREATE OR ALTER TRIGGER trg_StudentAnswer_WithinExamWindow
ON StudentAnswer
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  SET NOCOUNT ON;

  -- Current Time should be between StartDate and End DAte
  IF EXISTS (
    SELECT 1
    FROM inserted i
    JOIN dbo.Exam e ON e.ExamID = i.Exam_ID
    WHERE GETDATE() NOT BETWEEN
          (CAST(e.[Date] AS DATETIME) + CAST(e.Start_Time AS DATETIME))
      AND (CAST(e.[Date] AS DATETIME) + CAST(e.End_Time   AS DATETIME))
  )
  BEGIN
    RAISERROR('Submissions are only allowed during the exam window.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
 
  -- DELETE: 
  IF EXISTS (
    SELECT 1
    FROM deleted d
    JOIN dbo.Exam e ON e.ExamID = d.Exam_ID
    WHERE GETDATE() NOT BETWEEN
          (CAST(e.[Date] AS DATETIME) + CAST(e.Start_Time AS DATETIME))
      AND (CAST(e.[Date] AS DATETIME) + CAST(e.End_Time   AS DATETIME))
  )
  BEGIN
    RAISERROR('Deleting submissions is only allowed during the exam window.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;



-----Choose_LockAfterExamStart
CREATE OR ALTER TRIGGER trg_Choose_LockAfterExamStart
ON [Choose]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  SET NOCOUNT ON;

  IF EXISTS (
    SELECT 1
    FROM (
      SELECT Exam_ID FROM inserted
      UNION
      SELECT Exam_ID FROM deleted
    ) AS x
    JOIN dbo.Exam e ON e.ExamID = x.Exam_ID
    WHERE GETDATE() >= (CAST(e.[Date] AS DATETIME) + CAST(e.Start_Time AS DATETIME))
  )
  BEGIN
    RAISERROR('Cannot modify exam questions after the exam has started.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;




  --------Lock Editting on Exam After Start
CREATE OR ALTER TRIGGER trg_Exam_LockAfterStart
ON Exam
AFTER UPDATE, DELETE
AS
BEGIN
  SET NOCOUNT ON;

  IF EXISTS (
    SELECT 1
    FROM deleted d
    WHERE (CAST(d.[Date] AS DATETIME) + CAST(d.Start_Time AS DATETIME)) <= GETDATE()
  )
  BEGIN
    RAISERROR('You cannot modify or delete an exam after it has started.', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN;
  END
END;
*/

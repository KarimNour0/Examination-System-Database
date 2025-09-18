/* =========================================================
   ITIexaminationSystem — Role Grants + Test Harness
   ========================================================= */


USE ITIexaminationSystem;

GO

CREATE ROLE app_student;
CREATE ROLE app_instructor;
CREATE ROLE app_admin;
CREATE ROLE app_tm;
GO

DENY INSERT, UPDATE, DELETE ON SCHEMA::dbo TO PUBLIC;
GO

GRANT SELECT ON OBJECT::dbo.course_list_view          TO app_student, app_instructor, app_admin, app_tm;
GRANT SELECT ON OBJECT::dbo.exam_schedule_view        TO app_student, app_instructor, app_admin, app_tm;
GRANT SELECT ON OBJECT::dbo.exam_results_summary_view TO app_student, app_instructor, app_admin, app_tm;

GRANT SELECT ON OBJECT::dbo.student_transcript_view   TO app_student, app_admin, app_tm;
GRANT SELECT ON OBJECT::dbo.student_exam_detail_view  TO app_student, app_admin, app_tm;

GRANT SELECT ON OBJECT::dbo.instructor_courses_view   TO app_instructor, app_admin, app_tm;
GRANT SELECT ON OBJECT::dbo.instructor_exam_view      TO app_instructor, app_admin, app_tm;

GRANT SELECT ON OBJECT::dbo.question_pool_view        TO app_instructor, app_admin, app_tm;

GRANT SELECT ON OBJECT::dbo.student_info_view         TO app_admin, app_tm;


-- Core exam / questions
GRANT EXECUTE ON OBJECT::dbo.CreateExam                 TO app_instructor;
GRANT EXECUTE ON OBJECT::dbo.AddQuestionToExam          TO app_instructor;
GRANT EXECUTE ON OBJECT::dbo.AddQuestionUnified         TO app_instructor;
GRANT EXECUTE ON OBJECT::dbo.RemoveQuestionUnified      TO app_instructor;

-- Enrollment (student)
GRANT EXECUTE ON OBJECT::dbo.AddUserTakes               TO app_instructor, app_admin, app_tm;
GRANT EXECUTE ON OBJECT::dbo.RemoveUserTakes            TO app_instructor, app_admin, app_tm;

-- Catalog / structure
GRANT EXECUTE ON OBJECT::dbo.AddCourse                  TO app_admin, app_tm;
GRANT EXECUTE ON OBJECT::dbo.AddTrackCourse             TO app_tm;
GRANT EXECUTE ON OBJECT::dbo.RemoveTrackCourse          TO app_tm;
GRANT EXECUTE ON OBJECT::dbo.AssignInstructorCourse     TO app_admin, app_tm;

GRANT EXECUTE ON OBJECT::dbo.AddDept                    TO app_tm;
GRANT EXECUTE ON OBJECT::dbo.RemoveDept                 TO app_tm;
GRANT EXECUTE ON OBJECT::dbo.AddTrack                   TO app_tm;
GRANT EXECUTE ON OBJECT::dbo.RemoveTrack                TO app_tm;

GRANT EXECUTE ON OBJECT::dbo.Open_New_Branch            TO app_tm;
GRANT EXECUTE ON OBJECT::dbo.RemoveBranch               TO app_tm;

GRANT EXECUTE ON OBJECT::dbo.NewIntake                  TO app_tm;
GRANT EXECUTE ON OBJECT::dbo.StopIntake                 TO app_tm;
GRANT EXECUTE ON OBJECT::dbo.NewOpenning                TO app_tm;

-- User management
GRANT EXECUTE ON OBJECT::dbo.AddStudent                 TO app_admin;
GRANT EXECUTE ON OBJECT::dbo.AddInstructor              TO app_admin;
GRANT EXECUTE ON OBJECT::dbo.AddAdmin                   TO app_admin;
GRANT EXECUTE ON OBJECT::dbo.RemoveUser                 TO app_admin, app_tm;
GRANT EXECUTE ON OBJECT::dbo.StudentToInstructor        TO app_admin, app_tm;
GRANT EXECUTE ON OBJECT::dbo.Change_TM_From_Instructors TO app_admin;
GRANT EXECUTE ON OBJECT::dbo.Change_TM_New              TO app_admin;

GRANT EXECUTE ON OBJECT::dbo.populateexamchooseauto      TO app_instructor, app_tm;
GRANT EXECUTE ON OBJECT::dbo.StudentAnswer_PROCEDURE     TO app_student;
GRANT EXECUTE ON OBJECT::dbo.ProcessFinishedExamsAndArchive TO app_admin, app_tm;

GO

/* Optional: block direct DML on schema for app roles (keeps surface clean) */


CREATE USER u_student    WITHOUT LOGIN;
CREATE USER u_instructor WITHOUT LOGIN;
CREATE USER u_admin      WITHOUT LOGIN;
CREATE USER u_tm         WITHOUT LOGIN;

ALTER ROLE app_student    ADD MEMBER u_student;    
ALTER ROLE app_instructor ADD MEMBER u_instructor; 
ALTER ROLE app_admin      ADD MEMBER u_admin;      
ALTER ROLE app_tm         ADD MEMBER u_tm;   

go
PRINT '== ADMIN SETUP: Ensure Teach mapping for Instructor 80 / Course 1 / Branch 1 / Track 1 ==';
EXECUTE AS USER = 'u_admin';
BEGIN TRY
  EXEC dbo.AssignInstructorCourse @UserID=80, @CourseID=1, @BranchID=1, @TrackID=1;
  PRINT 'OK: Teach mapping created or already existed.';
  REVERT;
END TRY
BEGIN CATCH
  PRINT 'INFO: AssignInstructorCourse -> ' + ERROR_MESSAGE();
  REVERT;
END CATCH
go

-- STUDENT (VIEW + SP)
PRINT '== STUDENT VIEW ==';
EXECUTE AS USER = 'u_student';
BEGIN TRY
  /* Pick the most relevant student view you have; fall back to course_list_view */
      SELECT TOP 5 * FROM dbo.student_transcript_view;
      SELECT TOP 5 * FROM dbo.student_exam_detail_view;
      SELECT TOP 5 * FROM dbo.course_list_view; -- generic
      REVERT;
     PRINT 'OK: Student VIEW query executed.';
END TRY
BEGIN CATCH
  REVERT;
  PRINT 'FAIL(Student VIEW): ' + ERROR_MESSAGE();
END CATCH

go
PRINT '== STUDENT SP ==';
EXECUTE AS USER = 'u_student';
BEGIN TRY
  -- Use enrollment SPs for student (replace 116 with a real Student UserID; Course 1 assumed)
  EXEC dbo.AddUserTakes    @User_ID=116, @Course_ID=1;
  EXEC dbo.RemoveUserTakes @User_ID=116, @Course_ID=1;
  PRINT 'OK: Student SP (Add/RemoveUserTakes) executed.';
  REVERT;
END TRY
BEGIN CATCH
  PRINT 'FAIL(Student SP): ' + ERROR_MESSAGE();
  REVERT;
END CATCH
GO

-- INSTRUCTOR (VIEW + SP)
PRINT '== INSTRUCTOR VIEW ==';
EXECUTE AS USER = 'u_instructor';
BEGIN TRY
      SELECT TOP 5 * FROM dbo.instructor_courses_view;
      SELECT TOP 5 * FROM dbo.instructor_exam_view;
  PRINT 'OK: Instructor VIEW query executed.';
  REVERT;
END TRY
BEGIN CATCH
  PRINT 'FAIL(Instructor VIEW): ' + ERROR_MESSAGE();
  REVERT;
END CATCH

PRINT '== INSTRUCTOR SP ==';
EXECUTE AS USER = 'u_instructor';
DECLARE @ExamID INT = 91001, @QPID INT;
BEGIN TRY
    EXEC dbo.AddQuestionUnified
         @Course_ID=1, @Type=N'MCQ', @Description=N'Q: 2+2=?',
         @Option1=N'3', @Option2=N'4', @Option3=N'5', @Option4=N'22', @CorrectOption=2;
    SELECT @QPID = MAX(QPID) FROM dbo.QuestionPool WHERE Course_ID=1;

    EXEC dbo.CreateExam
         @ExamID=@ExamID, @Course_ID=1, @Track_ID=1,
         @Start_Time='09:00', @End_Time='10:00', @Date='2025-12-01',
         @Score=100, @ExamType=N'normal', @Branch_ID=1, @UserID=80;
  

    EXEC dbo.AddQuestionToExam @ExamID=@ExamID, @QPID=@QPID, @Degree=10;
    EXEC dbo.populateexamchooseauto @examid=@ExamID, @questioncount=3, @allowedtypes=N'mcq,truefalse';

  PRINT 'OK: Instructor SP flow executed.';
  REVERT;
END TRY
BEGIN CATCH
  PRINT 'FAIL(Instructor SP): ' + ERROR_MESSAGE();
    REVERT;
END CATCH
GO

-- ADMIN (VIEW + SP)
PRINT '== ADMIN VIEW ==';
EXECUTE AS USER = 'u_admin';
BEGIN TRY
      SELECT TOP 5 * FROM dbo.exam_results_summary_view;
      SELECT TOP 5 * FROM dbo.v_Exam_Safe;
  PRINT 'OK: Admin VIEW query executed.';
  REVERT;
END TRY
BEGIN CATCH
  PRINT 'FAIL(Admin VIEW): ' + ERROR_MESSAGE();
  REVERT;
END CATCH

PRINT '== ADMIN SP ==';
EXECUTE AS USER = 'u_admin';
BEGIN TRY
    EXEC dbo.AddCourse @CourseName=N'Test Course QA', @Description=N'Demo', @Max_Degree=100, @Min_Degree=50;
    EXEC dbo.ProcessFinishedExamsAndArchive;
  PRINT 'OK: Admin SPs executed.';
  REVERT;
END TRY
BEGIN CATCH
  PRINT 'FAIL(Admin SP): ' + ERROR_MESSAGE();
  REVERT;
END CATCH
GO

-- TRAINING MANAGER (VIEW + SP)
PRINT '== TM VIEW ==';
EXECUTE AS USER = 'u_tm';
BEGIN TRY
      SELECT TOP 5 * FROM dbo.exam_schedule_view;
  PRINT 'OK: TM VIEW query executed.';
  REVERT;
END TRY
BEGIN CATCH
  PRINT 'FAIL(TM VIEW): ' + ERROR_MESSAGE();
  REVERT;
END CATCH

PRINT '== TM SP ==';
EXECUTE AS USER = 'u_tm';
BEGIN TRY
    EXEC dbo.Open_New_Branch @BranchName=N'DEMO_TM_BRANCH';
    EXEC dbo.NewOpenning @TrackID=1, @IntakeID=1, @BranchID=1;
    EXEC dbo.populateexamchooseauto @examid=91001, @questioncount=2;
  PRINT 'OK: TM SPs executed.';
  REVERT;
END TRY
BEGIN CATCH
  PRINT 'FAIL(TM SP): ' + ERROR_MESSAGE();
  REVERT;
END CATCH


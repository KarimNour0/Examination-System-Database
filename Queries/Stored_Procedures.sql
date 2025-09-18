use ITIexaminationSystem;
go

CREATE OR ALTER FUNCTION dbo.ufn_DefaultIntakeID()
RETURNS INT
AS
BEGIN
    DECLARE @id INT;
    SELECT @id = MAX(IntakeID) FROM dbo.Intake;
    RETURN @id;
END


/*Adding & Removing Users*/
go
create or alter procedure AddStudent
   @Name nvarchar(60),
   @Address nvarchar(200),
   @Email nvarchar(120),
   @Password nvarchar(100),
   @Phone nvarchar(13),
   @DOB date,
   @BranchID int,
   @TrackID int
  
as
begin
		declare @NewUserID INT;
		select @NewUserID = ISNULL(MAX(UserID), 0) + 1 FROM [user];

	   insert into [user] (UserID, Role_ID, [Name], [Address], Email, [Password], Phone, DOB, Branch_ID, Track_ID, Intake_ID)
		values (@NewUserID, (select RoleID from [Role] where RoleName = 'Student'), @name, @address, @email, @password,@phone, @dob, @branchid, @trackid, dbo.ufn_DefaultIntakeID())
end
go
create or alter procedure AddInstructor
   @Name nvarchar(60),
   @Address nvarchar(200),
   @Email nvarchar(120),
   @Password nvarchar(100),
   @Phone nvarchar(13),
   @DOB date,
   @DeptID int,
   @BranchID int
as
begin
    declare @NewUserID INT;
    select @NewUserID = ISNULL(MAX(UserID), 0) + 1 FROM [user];

    insert into [user] (UserID, Role_ID, [Name], [Address], Email, [Password], Phone, DOB, Branch_ID, Dept_ID)
    values (@NewUserID, (select RoleID from [Role] where RoleName = 'Instructor'), @name, @address, @email, @password,@phone, @dob, @BranchID, @DeptID)
end

go
create or alter procedure AddAdmin
   @Name nvarchar(60),
   @Address nvarchar(200),
   @Email nvarchar(120),
   @Password nvarchar(100),
   @Phone nvarchar(13),
   @DOB date,
   @BranchID int
as
begin
    declare @NewUserID INT;
    select @NewUserID = ISNULL(MAX(UserID), 0) + 1 FROM [user];

    insert into [user] (UserID, Role_ID, [Name], [Address], Email, [Password], Phone, DOB, Branch_ID)
    values (@NewUserID, (select RoleID from [Role] where RoleName = 'Admin'), @name, @address, @email, @password,@phone, @dob, @BranchID)
end

go
create or alter procedure Change_TM_From_Instructors
	@NewTM INT
as
begin
    declare @NewUserID INT;
    select @NewUserID = ISNULL(MAX(UserID), 0) + 1 FROM [user];

	update [user] set IsActive = 0 where Role_id = (select RoleID from [Role] where RoleName = 'Training Manager');
	update [user] set IsActive = 0 where UserID = @NewTM;
	insert into [user](UserID,Role_ID,[Name],[Address],Email,[Password],Phone,DOB)
		select @NewUserID , (select RoleID from [Role] where RoleName = 'Training Manager') , [Name] , [Address] , Email , [Password] , Phone , DOB
		from [user] where UserID = @NewTM;
	update Branch set Manager_UID = @NewUserID
end

go
create or alter procedure Change_TM_New
   @Name nvarchar(60),
   @Address nvarchar(200),
   @Email nvarchar(120),
   @Password nvarchar(100),
   @Phone nvarchar(13),
   @DOB date
as
begin
    declare @NewUserID INT;
    select @NewUserID = ISNULL(MAX(UserID), 0) + 1 FROM [user];

	update [user] set IsActive = 0 where Role_id = (select RoleID from [Role] where RoleName = 'Training Manager');
	insert into [user](UserID,Role_ID,[Name],[Address],Email,[Password],Phone,DOB)
	values
	(@NewUserID,4,@Name,@Address,@Email,@Password,@Phone,@DOB);

	update Branch set Manager_UID = @NewUserID;
end

go
create or alter procedure RemoveUser
	@UID int
as
begin
	declare @RemoveRole int
	declare @RemoveStatus int
	select @RemoveRole = Role_ID from [User] where UserID = @UID
	select @RemoveStatus = IsActive from [User] where UserID = @UID
	
	if (@RemoveRole = (select RoleID from [Role] where RoleName = 'Training Manager') and @RemoveStatus = 1)
		begin
		print 'Use SP Change_TM'
		return;
		end
	else
		begin
		update [user] set IsActive = 0
		where UserID = @UID
		end
end

go
create or alter procedure StudentToInstructor
   @UserID int,
   @DeptID int,
   @BranchID int
   
as
begin
	declare @Role int;
	select @Role = Role_ID from [User] where UserID = @UserID

	if @Role = (select RoleID from [Role] where RoleName = 'Student')
		begin
			declare @NewUserID INT;
			select @NewUserID = ISNULL(MAX(UserID), 0) + 1 FROM [user];

			insert into [User](UserID,Role_ID,[Name],[Address],Email,[Password],Phone,DOB,Dept_ID,Branch_ID)
			select @NewUserID, (select RoleID from [Role] where RoleName = 'Instructor'), [Name], [Address], Email, [Password], Phone, DOB, @DeptID, @BranchID
			from [User] where UserID = @UserID	
			
			update [User] set IsActive = 0 where UserID = @UserID
		end
		else
			begin
				print 'This is not a Student';
				return;
			end
end
-----------------------------------------------------------------------------------------------------
go
/* Adding & Removing Departments */
create or alter procedure AddDept
	@DeptName NVARCHAR(50)
as
begin
	declare @NewDeptID INT;
    select @NewDeptID = ISNULL(MAX(DeptID), 0) + 1 FROM Department;

	insert into Department (DeptID, DeptName)
	values (@NewDeptID , @DeptName)
end

go
create or alter procedure RemoveDept
	@DeptID INT
as
begin

	print 'Instructors That need to be reassigned to new depts'
	select * from [User] where Dept_ID = @DeptID and IsActive = 1

	print 'Tracks That need to be reassigned to new depts'
	select * from Track where Dept_ID = @DeptID and IsActive = 1

	update Department set IsActive = 0
	where DeptID = @DeptID
end
-----------------------------------------------------------------------------------------------------
go
/* Adding Removing Tracks */
create or alter procedure AddTrack
	@TrackID INT,
    @TrackName NVARCHAR(60),
	@Dept_ID INT,
	@TotalHours INT,
    @Description NVARCHAR(1000)
as
begin
	declare @NewTrackID INT;
    select @NewTrackID = ISNULL(MAX(TrackID), 0) + 1 from Track;

	insert into Track(TrackID,TrackName,Dept_ID,TotalHours,[Description])
	values(@TrackID,@TrackName,@Dept_ID,@TotalHours,@Description)
end

go
create or alter procedure RemoveTrack
	@TrackID int
as
begin
	update Track set IsActive = 0 where TrackID = @TrackID

	print 'Track Removed'
	print 'These are the last Students to join this track!'
	select * from [User] where IsActive = 1 and Track_ID = @TrackID
end

-----------------------------------------------------------------------------------------------------
go
create or alter procedure Open_New_Branch
	@BranchName VARCHAR(50)
as
begin
	declare @NewBranchID INT;
    select @NewBranchID = ISNULL(MAX(BranchID), 0) + 1 FROM Branch;

	insert into Branch(BranchID,BranchName,Manager_UID)
	values(@NewBranchID,@BranchName,(select UserID from [User] where Role_ID = (select RoleID from [Role] where RoleName = 'Training Manager') and IsActive = 1));
	print 'Branch Added'
end

go
create or alter procedure RemoveBranch
    @BranchID int
as
begin
    declare @ActiveIntake int;
    declare @EndDate date;

    select @ActiveIntake = IntakeID, 
           @EndDate = EndDate
    from Intake
    where IsActive = 1;

    if exists (
        select 1 from [Open] 
		where Intake_ID = @ActiveIntake and Branch_ID = @BranchID)
		begin
			print 'Cant remove before Intake ' 
				  + cast(@ActiveIntake as varchar(10)) 
				  + ' End Date of ' 
				  + convert(varchar(10), @EndDate, 120);
		end
		else
			begin
				update Branch set IsActive = 0 where BranchID = @BranchID;
				delete from [Class] where Branch_ID = @BranchID;
				print 'Branch removed successfully';
			end 
end

-----------------------------------------------------------------------------------------------------
go
create or alter procedure NewIntake
    @IntakeName NVARCHAR(100),
    @StartDate DATE,
    @EndDate DATE
as
begin
    if @EndDate <= @StartDate
		begin
			print 'Error: EndDate must be greater than StartDate';
			return;
		end
	else
		begin
			declare @NewIntakeID INT;
			select @NewIntakeID = ISNULL(MAX(IntakeID), 0) + 1 from Intake;

			insert into Intake(IntakeID,IntakeName,StartDate,EndDate)
			values(@NewIntakeID,@IntakeName,@StartDate,@EndDate)
		end
end

go
create or alter procedure StopIntake
    @IntakeID int
as
begin
    declare @EndDate date;

    select @EndDate = EndDate
    from Intake
    where IntakeID = @IntakeID;

    if @EndDate > getdate()
    begin
        print('This intake is currently running, we cannot remove it!');
        return;
    end;

    update Intake 
    set IsActive = 0 
    where IntakeID = @IntakeID;

    update [User] 
    set IsActive = 0 
    where Intake_ID = @IntakeID;
end;
-----------------------------------------------------------------------------------------------------
go
create or alter procedure NewOpenning
    @TrackID  INT,
    @IntakeID INT,
    @BranchID INT
as
begin
	insert into [Open](Track_ID,Intake_ID,Branch_ID)
	values(@TrackID,@IntakeID,@BranchID)
end
-----------------------------------------------------------------------------------------------------
go
create procedure AddCourse
    @CourseName NVARCHAR(60),
    @Description NVARCHAR(400),
    @Max_Degree INT,
    @Min_Degree INT
as
begin
	declare @NewCourseID INT;
	select @NewCourseID = ISNULL(MAX(CourseID), 0) + 1 from Course;

    insert into course (CourseID, CourseName, [description], MaxDegree, MinDegree)
    values (@NewCourseID, @CourseName, @Description, @Max_Degree, @Min_Degree);
end

-----------------------------------------------------------------------------------------------------
go
CREATE OR ALTER PROCEDURE AddTrackCourse
    @Track_ID INT,
    @Course_ID INT
AS
BEGIN
    INSERT INTO Track_Course (Track_ID, Course_ID)
    VALUES (@Track_ID, @Course_ID)

    PRINT 'Course Added to Track Successfully'
END

/* Remove Track_Course */
go
CREATE OR ALTER PROCEDURE RemoveTrackCourse
    @Track_ID INT,
    @Course_ID INT
AS
BEGIN
    DELETE FROM Track_Course
    WHERE Track_ID = @Track_ID AND Course_ID = @Course_ID

    PRINT 'Course Removed from Track Successfully'

    PRINT 'These are the remaining Courses in this Track:'
    SELECT c.CourseID, c.CourseName
    FROM Track_Course tc
    JOIN Course c ON tc.Course_ID = c.CourseID
    WHERE tc.Track_ID = @Track_ID
END
-----------------------------------------------------------------------------------------------------
/* Add UserTakes */
go
CREATE OR ALTER PROCEDURE AddUserTakes
    @User_ID INT,
    @Course_ID INT
AS
BEGIN
    INSERT INTO UserTakes (User_ID, Course_ID)
    VALUES (@User_ID, @Course_ID)

    PRINT 'User Enrolled in Course Successfully'
END



----------------------------------------------------------------------------------------------

GO
/* Remove UserTakes */
CREATE OR ALTER PROCEDURE RemoveUserTakes
    @User_ID INT,
    @Course_ID INT
AS
BEGIN
    DELETE FROM UserTakes
    WHERE User_ID = @User_ID AND Course_ID = @Course_ID

    PRINT 'User Unenrolled from Course Successfully'

    PRINT 'These are the remaining Courses this User is taking:'
    SELECT c.CourseID, c.CourseName
    FROM UserTakes ut
    JOIN Course c ON ut.Course_ID = c.CourseID
    WHERE ut.User_ID = @User_ID
END
------------------------------------------------------------------------
/* Add QuestionPool,Answer_MCQ */
GO

CREATE OR ALTER PROCEDURE dbo.AddQuestionUnified
    @Course_ID     INT,
    @Type          NVARCHAR(30),           -- 'MCQ' | 'TrueFalse' | 'Text'
    @Description   NVARCHAR(500),
    @Option1       NVARCHAR(50) = NULL,    -- used for MCQ
    @Option2       NVARCHAR(50) = NULL,
    @Option3       NVARCHAR(50) = NULL,
    @Option4       NVARCHAR(50) = NULL,
    @CorrectOption TINYINT      = NULL,    -- 1..4 for MCQ, 1..2 for TrueFalse
    @TextAnswer    NVARCHAR(1000) = NULL   -- expected answer for Text (optional)
AS
BEGIN

    BEGIN TRY
        /* ---------- Validation ---------- */
        IF NOT EXISTS (SELECT 1 FROM dbo.Course WHERE CourseID = @Course_ID)
        BEGIN
            RAISERROR('Course_ID does not exist.', 16, 1);
            RETURN;
        END;

        IF @Type NOT IN (N'MCQ', N'TrueFalse', N'Text')
        BEGIN
            RAISERROR('Invalid Type. Allowed: MCQ, TrueFalse, Text.', 16, 1);
            RETURN;
        END;

        -- Text: no options allowed; answer is optional but recommended
        IF @Type = N'Text' AND (
           @Option1 IS NOT NULL OR @Option2 IS NOT NULL OR
           @Option3 IS NOT NULL OR @Option4 IS NOT NULL OR
           @CorrectOption IS NOT NULL)
        BEGIN
            RAISERROR('Text questions must not include options or CorrectOption.', 16, 1);
            RETURN;
        END;

        -- True/False: CorrectOption must be 1 (True) or 2 (False)
        IF @Type = N'TrueFalse' AND (@CorrectOption NOT IN (1,2))
        BEGIN
            RAISERROR('For TrueFalse, CorrectOption must be 1 (True) or 2 (False).', 16, 1);
            RETURN;
        END;

        -- MCQ: need 1–4 options; CorrectOption in 1..4 and must exist
        IF @Type = N'MCQ'
        BEGIN
            DECLARE @optCount INT =
                (CASE WHEN @Option1 IS NOT NULL THEN 1 ELSE 0 END) +
                (CASE WHEN @Option2 IS NOT NULL THEN 1 ELSE 0 END) +
                (CASE WHEN @Option3 IS NOT NULL THEN 1 ELSE 0 END) +
                (CASE WHEN @Option4 IS NOT NULL THEN 1 ELSE 0 END);

            IF @optCount = 0
            BEGIN
                RAISERROR('MCQ must have at least one option.', 16, 1);
                RETURN;
            END;

            IF @CorrectOption NOT BETWEEN 1 AND 4
            BEGIN
                RAISERROR('For MCQ, CorrectOption must be between 1 and 4.', 16, 1);
                RETURN;
            END;

            IF (@CorrectOption = 1 AND @Option1 IS NULL) OR
               (@CorrectOption = 2 AND @Option2 IS NULL) OR
               (@CorrectOption = 3 AND @Option3 IS NULL) OR
               (@CorrectOption = 4 AND @Option4 IS NULL)
            BEGIN
                RAISERROR('CorrectOption must reference a non-NULL option.', 16, 1);
                RETURN;
            END;
        END;

        /* ---------- Atomic insert ---------- */
        BEGIN TRAN;

        -- Concurrency-safe QPID allocation
        DECLARE @NewQPID INT;
        SELECT @NewQPID = ISNULL(MAX(QPID), 0) + 1
        FROM dbo.QuestionPool WITH (UPDLOCK, HOLDLOCK);

        INSERT INTO dbo.QuestionPool(QPID, Course_ID, [Type], [Description])
        VALUES (@NewQPID, @Course_ID, @Type, @Description);

        IF @Type = N'MCQ'
        BEGIN
            IF @Option1 IS NOT NULL
                INSERT INTO dbo.Answer_MCQ(QP_ID, OptionID, [Option], IS_Correct)
                VALUES (@NewQPID, 1, @Option1, IIF(@CorrectOption=1,1,0));
            IF @Option2 IS NOT NULL
                INSERT INTO dbo.Answer_MCQ(QP_ID, OptionID, [Option], IS_Correct)
                VALUES (@NewQPID, 2, @Option2, IIF(@CorrectOption=2,1,0));
            IF @Option3 IS NOT NULL
                INSERT INTO dbo.Answer_MCQ(QP_ID, OptionID, [Option], IS_Correct)
                VALUES (@NewQPID, 3, @Option3, IIF(@CorrectOption=3,1,0));
            IF @Option4 IS NOT NULL
                INSERT INTO dbo.Answer_MCQ(QP_ID, OptionID, [Option], IS_Correct)
                VALUES (@NewQPID, 4, @Option4, IIF(@CorrectOption=4,1,0));
        END
        ELSE IF @Type = N'TrueFalse'
        BEGIN
            -- Always insert canonical TF options
            INSERT INTO dbo.Answer_MCQ(QP_ID, OptionID, [Option], IS_Correct)
            VALUES
                (@NewQPID, 1, N'True',  IIF(@CorrectOption=1,1,0)),
                (@NewQPID, 2, N'False', IIF(@CorrectOption=2,1,0));
        END
        ELSE IF @Type = N'Text'
        BEGIN
            -- Save expected/model answer only if provided
            IF @TextAnswer IS NOT NULL
                INSERT INTO dbo.Answer_Text(QP_ID, Answer)
                VALUES (@NewQPID, @TextAnswer);
        END

        COMMIT TRAN;

        PRINT 'Question (QPID=' + CAST(@NewQPID AS NVARCHAR(20)) + ') and answers added successfully.';
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRAN;
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END

/* Remove QuestionPool,Answer_MCQ */
GO
CREATE OR ALTER PROCEDURE dbo.RemoveQuestionUnified
    @QPID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @QType NVARCHAR(10);

    -- Find the type of the question
    SELECT @QType = [Type]
    FROM dbo.QuestionPool
    WHERE QPID = @QPID;

    IF @QType IS NULL
    BEGIN
        PRINT 'No question found with the given QPID.';
        RETURN;
    END;

    -- Remove answers depending on type
    IF @QType IN (N'MCQ', N'TrueFalse')
    BEGIN
        DELETE FROM dbo.Answer_MCQ WHERE QP_ID = @QPID;
    END
    ELSE IF @QType = N'Text'
    BEGIN
        DELETE FROM dbo.Answer_Text WHERE QP_ID = @QPID;
    END;

    -- Remove from QuestionPool itself
    DELETE FROM dbo.QuestionPool WHERE QPID = @QPID;

    PRINT 'Question and related answers removed successfully';
END;
GO

------------------------------------------------------------------------
go
create procedure AssignInstructorCourse
    @UserID int,
    @CourseID int,
	@BranchID int,
	@TrackID int
as
begin
    insert into Teach ([User_ID], Course_ID,Branch_ID,Track_ID)
    values (@UserID, @CourseID,@BranchID,@TrackID);
end;
------------------------------------------------------------------------
go
create or alter procedure CreateExam
    @ExamID int,
    @Course_ID int,
    @Track_ID int,
    @Start_Time TIME(0),
    @End_Time TIME(0),
    @Date DATE,
    @Score int,
    @ExamType nvarchar(10),
	@Branch_ID INT,
	@UserID int
as
begin

    if @Start_Time >= @End_Time
        raiserror(N'Exam Start_Time must be earlier than End_Time.', 16, 1);

    -- check that user teaches this course in this branch
    if not exists (
        select 1
        from Teach t
        where t.User_ID = @UserID
          and t.Course_ID = @Course_ID
          and t.Branch_ID = @Branch_ID
          and t.Track_ID  = @Track_ID
    )
    begin
        raiserror(N'This user is not assigned to teach the given course in this branch and the Track_ID.', 16, 1);
        return;
    end

    else 
    begin
    insert into exam (ExamID, Course_ID, Start_Time, End_Time, [Date], score, ExamType, Branch_ID, [User_ID], Track_ID)
    values (@examid, @Course_ID, @Start_Time, @End_Time, @Date, @Score, @ExamType, @Branch_ID, @UserID, @Track_ID );
    end

end
go
create or alter procedure AddQuestionToExam
	@ExamID int,
	@QPID int,
	@Degree int
as
begin
	insert into [Choose](Exam_ID,QP_ID,Degree)
	values(@ExamID,@QPID,@Degree);
end

------------------------------------------------------------------------

go
create or alter procedure populateexamchooseauto
    @examid        int,
    @questioncount int           = 10,
    @allowedtypes  nvarchar(100) = N'mcq,truefalse,text'
as
begin
    if @questioncount <= 0
    begin
        raiserror(N'@questioncount must be > 0.', 16, 1);
        return;
    end

    declare
        @course_id  int,
        @branch_id  int,
        @user_id    int,
        @score      int,
        @date       date,
        @start_time time(0);

    select
        @course_id  = e.course_id,
        @branch_id  = e.branch_id,
        @user_id    = e.[user_id],
        @score      = e.score,
        @date       = e.[date],
        @start_time = e.start_time
    from dbo.exam e
    where e.examid = @examid;

    if @course_id is null
    begin
        raiserror(N'examid not found.', 16, 1);
        return;
    end

    declare @startdt datetime2(0) =
        dateadd(day, datediff(day, 0, @date), cast(@start_time as datetime2(0)));

    if getdate() >= @startdt
    begin
        raiserror(N'cannot modify questions for an exam that has started.', 16, 1);
        return;
    end

    declare @maxdegree int, @targettotal int;

    select @maxdegree = c.maxdegree
    from dbo.course c
    where c.courseid = @course_id;

    if @maxdegree is null
    begin
        raiserror(N'course.maxdegree not set.', 16, 1);
        return;
    end

    select @targettotal =
        case
            when @score is null then @maxdegree
            when @score > @maxdegree then @maxdegree
            else @score
        end;

    ;with allowed as (
        select ltrim(rtrim(value)) as t
        from string_split(@allowedtypes, N',')
    ),
    pool as (
        select q.QPID
        from dbo.questionpool q
        where q.course_id = @course_id
          and q.[type] in (select t from allowed)
    )
    select top (@questioncount) QPID
    into #picked
    from pool
    order by newid();

    declare @pickedcount int;
    select @pickedcount = count(*) from #picked;

    if @pickedcount < @questioncount
    begin
        drop table if exists #picked;
        raiserror(N'not enough questions for the requested filters/count.', 16, 1);
        return;
    end

    declare @base int = @targettotal / @questioncount,
            @rem  int = @targettotal % @questioncount;

    begin tran;

    delete from dbo.[choose]
    where exam_id = @examid;

    ;with numbered as (
        select QPID, row_number() over (order by QPID) as rn
        from #picked
    )
    insert into dbo.[choose] (exam_id, qp_id, degree)
    select
        @examid,
        QPID,
        @base + case when rn <= @rem then 1 else 0 end
    from numbered;

    commit tran;

    drop table if exists #picked;

end

GO

----
GO
CREATE OR ALTER PROCEDURE dbo.ProcessFinishedExamsAndArchive
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRAN;

        /* 1) Identify exams that finished and are not archived */
        ;WITH Finished AS (
            SELECT e.ExamID, e.Course_ID
            FROM dbo.Exam e
            WHERE (e.Archived = 0 OR e.Archived IS NULL)
              AND GETDATE() >= (CONVERT(datetime, e.[Date]) + CONVERT(datetime, e.End_Time))
        ),
        Totals AS (
            /* total per (User, Exam) only for those finished exams */
            SELECT sa.User_ID,
                   sa.Exam_ID,
                   SUM(ISNULL(sa.QScore, 0)) AS TotalScore
            FROM dbo.StudentAnswer sa
            JOIN Finished f ON f.ExamID = sa.Exam_ID
            GROUP BY sa.User_ID, sa.Exam_ID
        ),
        Thresholds AS (
            SELECT f.ExamID,
                   ISNULL(c.MinDegree, 0) AS MinRequired
            FROM Finished f
            JOIN dbo.Course c ON c.CourseID = f.Course_ID
        )

        /* INSERT results */
        INSERT INTO dbo.StudentExamResult (User_ID, Exam_ID, TotalScore, IsPass, CalculatedAt)
        SELECT t.User_ID,
               t.Exam_ID,
               t.TotalScore,
               CASE WHEN t.TotalScore >= th.MinRequired THEN 1 ELSE 0 END,
               GETDATE()
        FROM Totals t
        JOIN Thresholds th ON th.ExamID = t.Exam_ID
        WHERE NOT EXISTS (
            SELECT 1
            FROM dbo.StudentExamResult ser
            WHERE ser.User_ID = t.User_ID AND ser.Exam_ID = t.Exam_ID
        );

        /* 4) Mark processed exams as archived */
        UPDATE e
        SET e.Archived = 1
        FROM dbo.Exam e
        WHERE EXISTS (SELECT 1 FROM Finished f WHERE f.ExamID = e.ExamID);

        COMMIT;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END
go
CREATE OR ALTER PROCEDURE dbo.StudentAnswer_PROCEDURE
    @user_id        INT,
    @exam_id        INT,
    @question_id    INT,
    @student_answer NVARCHAR(2000)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRAN;

        DECLARE
            @CourseID        INT           = NULL,
            @QType           NVARCHAR(10)  = NULL,
            @Degree          INT           = NULL,
            @CorrectOptionID INT           = NULL,
            @ChosenOptionID  INT           = NULL,
            @QScore          INT           = NULL;

        -- Exam → Course
        SELECT @CourseID = e.Course_ID
        FROM dbo.Exam e
        WHERE e.ExamID = @exam_id;

        IF @CourseID IS NULL
        BEGIN
            RAISERROR(N'Invalid Exam_ID.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- Question belongs to course → type
        SELECT @QType = qp.[Type]
        FROM dbo.QuestionPool qp
        WHERE qp.QPID = @question_id
          AND qp.Course_ID = @CourseID;

        IF @QType IS NULL
        BEGIN
            RAISERROR(N'Invalid Question_ID for this exam''s course.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        -- Degree on this exam
        SELECT @Degree = ch.Degree
        FROM dbo.[Choose] ch
        WHERE ch.Exam_ID = @exam_id
          AND ch.QP_ID   = @question_id;

        IF @Degree IS NULL
        BEGIN
            RAISERROR(N'This question is not assigned to the specified exam.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        /*========================
          MCQ / TrueFalse
        ========================*/
        IF @QType IN (N'MCQ', N'TrueFalse')
        BEGIN
            DECLARE @ans NVARCHAR(20) = UPPER(LTRIM(RTRIM(ISNULL(@student_answer, N''))));

            -- Try numeric first
            SET @ChosenOptionID = TRY_CAST(@ans AS INT);
            IF @ChosenOptionID IS NULL
            BEGIN
                SET @ChosenOptionID =
                    CASE @ans
                        WHEN N'A' THEN 1 WHEN N'B' THEN 2 WHEN N'C' THEN 3 WHEN N'D' THEN 4
                        WHEN N'T' THEN 1 WHEN N'TRUE'  THEN 1 WHEN N'Y' THEN 1 WHEN N'YES' THEN 1
                        WHEN N'F' THEN 2 WHEN N'FALSE' THEN 2 WHEN N'N' THEN 2 WHEN N'NO'  THEN 2
                        WHEN N'0' THEN 2 WHEN N'1' THEN 1
                    END;
            END

            IF @ChosenOptionID IS NULL
            BEGIN
                RAISERROR(N'Invalid answer format for MCQ/TrueFalse.', 16, 1);
                ROLLBACK TRANSACTION; RETURN;
            END

            IF NOT EXISTS (
                SELECT 1
                FROM dbo.Answer_MCQ
                WHERE QP_ID = @question_id AND OptionID = @ChosenOptionID
            )
            BEGIN
                RAISERROR(N'Chosen option does not exist for this question.', 16, 1);
                ROLLBACK TRANSACTION; RETURN;
            END

            SELECT @CorrectOptionID = am.OptionID
            FROM dbo.Answer_MCQ am
            WHERE am.QP_ID = @question_id AND am.IS_Correct = 1;

            IF @CorrectOptionID IS NULL
            BEGIN
                RAISERROR(N'No correct option configured for this question.', 16, 1);
                ROLLBACK TRANSACTION; RETURN;
            END

            SET @QScore = CASE WHEN @ChosenOptionID = @CorrectOptionID THEN @Degree ELSE 0 END;
            SET @student_answer = CONVERT(NVARCHAR(5), @ChosenOptionID);
        END

        /*========================
          Text (≥ 4-word overlap)
        ========================*/
        ELSE IF @QType = N'Text'
        BEGIN
            DECLARE @ModelAnswer NVARCHAR(1000) = NULL;
            SELECT @ModelAnswer = at.Answer
            FROM dbo.Answer_Text at
            WHERE at.QP_ID = @question_id;

            IF @ModelAnswer IS NULL OR @student_answer IS NULL
            BEGIN
                SET @QScore = NULL;
            END
            ELSE
            BEGIN
                -- Normalize (case, punctuation incl. Arabic, simple Arabic unifications)
                DECLARE @Punct NVARCHAR(100) = N'.,;:!?"()[]{}''-_/|\،؛؟';
                DECLARE @stu NVARCHAR(2000) = LOWER(@student_answer);
                DECLARE @mod NVARCHAR(2000) = LOWER(@ModelAnswer);

                -- unify alef variants + drop tatweel
                SET @stu = REPLACE(REPLACE(REPLACE(@stu, N'أ', N'ا'), N'إ', N'ا'), N'آ', N'ا');
                SET @mod = REPLACE(REPLACE(REPLACE(@mod, N'أ', N'ا'), N'إ', N'ا'), N'آ', N'ا');
                SET @stu = REPLACE(@stu, NCHAR(1600), N''); -- tatweel
                SET @mod = REPLACE(@mod, NCHAR(1600), N'');

                -- strip punctuation by translating to spaces (lengths match)
                SET @stu = TRANSLATE(@stu, @Punct, REPLICATE(N' ', LEN(@Punct)));
                SET @mod = TRANSLATE(@mod, @Punct, REPLICATE(N' ', LEN(@Punct)));

                -- collapse multiple spaces
                WHILE CHARINDEX(N'  ', @stu) > 0 SET @stu = REPLACE(@stu, N'  ', N' ');
                WHILE CHARINDEX(N'  ', @mod) > 0 SET @mod = REPLACE(@mod, N'  ', N' ');

                DECLARE @StudentWords TABLE(word NVARCHAR(100) PRIMARY KEY);
                DECLARE @ModelWords   TABLE(word NVARCHAR(100) PRIMARY KEY);

                INSERT INTO @StudentWords(word)
                SELECT DISTINCT LTRIM(RTRIM(value))
                FROM STRING_SPLIT(@stu, N' ')
                WHERE LEN(LTRIM(RTRIM(value))) > 0;

                INSERT INTO @ModelWords(word)
                SELECT DISTINCT LTRIM(RTRIM(value))
                FROM STRING_SPLIT(@mod, N' ')
                WHERE LEN(LTRIM(RTRIM(value))) > 0;

                DECLARE @Matches INT;
                SELECT @Matches = COUNT(*)
                FROM @StudentWords s
                JOIN @ModelWords   m ON m.word = s.word;

                SET @QScore = CASE WHEN @Matches >= 4 THEN @Degree ELSE 0 END;
            END
        END
        ELSE
        BEGIN
            RAISERROR(N'Unknown question type.', 16, 1);
            ROLLBACK TRANSACTION; RETURN;
        END

        /* Upsert */
        IF EXISTS (
            SELECT 1
            FROM dbo.StudentAnswer
            WHERE User_ID = @user_id AND Exam_ID = @exam_id AND QP_ID = @question_id
        )
        BEGIN
            UPDATE dbo.StudentAnswer
            SET Student_Answer = @student_answer,
                QScore         = @QScore
            WHERE User_ID = @user_id AND Exam_ID = @exam_id AND QP_ID = @question_id;
        END
        ELSE
        BEGIN
            INSERT INTO dbo.StudentAnswer(User_ID, Exam_ID, QP_ID, Student_Answer, QScore)
            VALUES(@user_id, @exam_id, @question_id, @student_answer, @QScore);
        END

        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        DECLARE @msg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@msg, 16, 1);
    END CATCH
END
GO


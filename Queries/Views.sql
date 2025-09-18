use ITIexaminationSystem;
go

------------------------------------------------------
-- 1) exam_schedule_view
------------------------------------------------------
create or alter view exam_schedule_view as
select 
    e.examid,
    c.coursename,
    e.examtype,
    e.[date],
    e.start_time,
    e.end_time,
    b.branchname,
    t.trackname,
    u.name as instructor_name
from exam e
join course c on e.course_id = c.courseid
join branch b on e.branch_id = b.branchid
join track t on e.track_id = t.trackid
join [user] u on e.user_id = u.userid;
go

------------------------------------------------------
-- 2) course_list_view
------------------------------------------------------
create or alter view course_list_view as
select 
    c.courseid,
    c.coursename,
    c.[description],
    c.maxdegree,
    c.mindegree,
    t.trackname
from course c
left join track_course tc on c.courseid = tc.course_id
left join track t on tc.track_id = t.trackid;
go

------------------------------------------------------
-- 3) student_info_view
------------------------------------------------------
create or alter view student_info_view as
select 
    u.userid,
    u.name,
    u.email,
    u.phone,
    u.dob,
    b.branchname,
    d.deptname,
    t.trackname,
    i.intakename
from [user] u
left join branch b on u.branch_id = b.branchid
left join department d on u.dept_id = d.deptid
left join track t on u.track_id = t.trackid
left join intake i on u.intake_id = i.intakeid
where u.role_id = 3; -- 3 = student
go


------------------------------------------------------
-- 4) instructor_courses_view
------------------------------------------------------
create or alter view instructor_courses_view as
select 
    u.userid,
    u.name as instructor_name,
    c.coursename,
    b.branchname,
    t.trackname
from teach th
join [user] u on th.user_id = u.userid
join course c on th.course_id = c.courseid
join branch b on th.branch_id = b.branchid
join track t on th.track_id = t.trackid;
go


------------------------------------------------------
-- 5) question_pool_view
------------------------------------------------------
create or alter view question_pool_view as
select 
    q.qpid,
    q.type,
    q.[description],
    c.coursename
from questionpool q
join course c on q.course_id = c.courseid;
go


------------------------------------------------------
-- 6) student_transcript_view
------------------------------------------------------
create or alter view student_transcript_view as
select 
    u.userid,
    u.name as student_name,
    c.coursename,
    e.examid,
    e.examtype,
    e.[date],
    c.maxdegree,
    c.mindegree,
    ser.totalscore as student_degree,
    case 
        when ser.ispass = 1 then 'pass'
        else 'fail'
    end as result_status,
    ser.calculatedat
from [user] u
join studentexamresult ser on u.userid = ser.user_id
join exam e on ser.exam_id = e.examid
join course c on e.course_id = c.courseid
where u.role_id = 3;
go



------------------------------------------------------
-- 7) exam_results_summary_view
------------------------------------------------------
create or alter view exam_results_summary_view as
select 
    e.examid,
    c.coursename,
    e.examtype,
    e.[date],
    count(ser.user_id) as total_students,
    sum(case when ser.ispass = 1 then 1 else 0 end) as passed_students,
    sum(case when ser.ispass = 0 then 1 else 0 end) as failed_students,
    cast(
        100.0 * sum(case when ser.ispass = 1 then 1 else 0 end) 
        / nullif(count(ser.user_id),0) 
        as decimal(5,2)
    ) as pass_percentage
from exam e
join course c on e.course_id = c.courseid
left join studentexamresult ser on e.examid = ser.exam_id
group by e.examid, c.coursename, e.examtype, e.[date];
go


-- 8) student_exam_detail_view
create or alter view student_exam_detail_view as
select 
    u.userid,
    u.name as student_name,
    e.examid,
    c.coursename,
    q.qpid,
    q.[description] as question_desc,
    ch.degree as question_degree,
    isnull(sa.student_answer, '') as student_answer,
    isnull(sa.qscore,0) as scored
from [user] u
join studentexamresult ser on u.userid = ser.user_id
join exam e on ser.exam_id = e.examid
join course c on e.course_id = c.courseid
join [choose] ch on ch.exam_id = e.examid
join questionpool q on q.qpid = ch.qp_id
left join studentanswer sa 
       on sa.user_id = u.userid 
      and sa.exam_id = e.examid 
      and sa.qp_id = q.qpid
where u.role_id = 2;

go


-- 9) instructor_exam_view
create or alter view instructor_exam_view as
select 
    u.userid as instructor_id,
    u.name as instructor_name,
    e.examid,
    c.coursename,
    e.examtype,
    e.[date],
    count(ser.user_id) as total_students,
    sum(isnull(ser.totalscore,0)) as total_obtained,
    cast(avg(isnull(ser.totalscore,0)) as decimal(5,2)) as avg_score
from [user] u
join exam e on u.userid = e.user_id
join course c on e.course_id = c.courseid
left join studentexamresult ser on e.examid = ser.exam_id
where u.role_id = 2 -- 2 = instructor
group by u.userid, u.name, e.examid, c.coursename, e.examtype, e.[date];
go





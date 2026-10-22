create database if not exists universitycoursemanagement;
use universitycoursemanagement;
drop table if exists enrollments;
drop table if exists students;
drop table if exists courses;
drop table if exists instructors;
drop table if exists departments;
create table departments (
    departmentid int primary key,
    departmentname varchar(100) not null unique
);
create table students (
    studentid int primary key,
    firstname varchar(50) not null,
    lastname varchar(50) not null,
    email varchar(100) not null unique,
    birthdate date,
    enrollmentdate date not null
);
create table courses (
    courseid int primary key,
    coursename varchar(100) not null,
    departmentid int not null,
    credits int not null,
    foreign key (departmentid)
        references departments(departmentid)
);
create table instructors (
    instructorid int primary key,
    firstname varchar(50) not null,
    lastname varchar(50) not null,
    email varchar(100) not null unique,
    departmentid int not null,
    salary decimal(10,2) not null,
    foreign key (departmentid)
        references departments(departmentid)
);
create table enrollments (
    enrollmentid int primary key,
    studentid int not null,
    courseid int not null,
    enrollmentdate date not null,
    foreign key (studentid)
        references students(studentid),
    foreign key (courseid)
        references courses(courseid),
    unique (studentid, courseid)
);
insert into departments (departmentid, departmentname)
values
(1, 'Computer Science'),
(2, 'Mathematics');
insert into students
(studentid, firstname, lastname, email, birthdate, enrollmentdate)
values
(1, 'John', 'Doe', 'john.doe@email.com',
 '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@email.com',
 '1999-05-25', '2021-08-01'),
(3, 'Michael', 'Brown', 'michael.brown@email.com',
 '2001-03-12', '2022-07-15'),
(4, 'Emily', 'Davis', 'emily.davis@email.com',
 '2000-11-20', '2023-08-01'),
(5, 'David', 'Wilson', 'david.wilson@email.com',
 '1998-09-05', '2020-08-01'),
(6, 'Sarah', 'Taylor', 'sarah.taylor@email.com',
 '2002-04-18', '2024-08-01'),
(7, 'Robert', 'Miller', 'robert.miller@email.com',
 '2001-12-10', '2023-07-20'),
(8, 'Olivia', 'Anderson', 'olivia.anderson@email.com',
 '2002-06-30', '2025-08-01');
insert into courses (courseid, coursename, departmentid, credits)
values
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 2, 4),
(103, 'Calculus', 2, 3),
(104, 'Database Systems', 1, 4);
insert into instructors
(instructorid, firstname, lastname, email, departmentid, salary)
values
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 75000),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 65000),
(3, 'Carol', 'White', 'carol.white@univ.com', 1, 85000),
(4, 'David', 'Clark', 'david.clark@univ.com', 2, 70000);
insert into enrollments
(enrollmentid, studentid, courseid, enrollmentdate)
values
(1, 1, 101, '2022-08-01'),
(2, 2, 102, '2021-08-01'),
(3, 1, 102, '2022-08-05'),
(4, 2, 101, '2021-08-05'),
(5, 3, 101, '2022-07-15'),
(6, 3, 102, '2022-07-20'),
(7, 4, 101, '2023-08-01'),
(8, 5, 101, '2020-08-01'),
(9, 6, 101, '2024-08-01'),
(10, 7, 103, '2023-07-20'),
(11, 8, 103, '2025-08-01'),
(12, 4, 104, '2023-08-10');
select * from students;
select * from courses;
select * from instructors;
select * from enrollments;
select * from departments;
insert into departments (departmentid, departmentname)
values (99, 'Test Department');
insert into students
(studentid, firstname, lastname, email, birthdate, enrollmentdate)
values
(99, 'Test', 'Student', 'test.student@email.com',
 '2000-01-01', '2026-01-01');
insert into courses (courseid, coursename, departmentid, credits)
values (999, 'Test Course', 99, 3);
insert into instructors
(instructorid, firstname, lastname, email, departmentid, salary)
values
(99, 'Test', 'Instructor', 'test.instructor@univ.com', 99, 50000);
insert into enrollments
(enrollmentid, studentid, courseid, enrollmentdate)
values (999, 99, 999, '2026-01-01');
select * from departments where departmentid = 99;
select * from students where studentid = 99;
select * from courses where courseid = 999;
select * from instructors where instructorid = 99;
select * from enrollments where enrollmentid = 999;
update departments
set departmentname = 'Updated Test Department'
where departmentid = 99;
update students
set firstname = 'Updated'
where studentid = 99;
update courses
set credits = 4
where courseid = 999;
update instructors
set salary = 55000
where instructorid = 99;
update enrollments
set enrollmentdate = '2026-02-01'
where enrollmentid = 999;
delete from enrollments where enrollmentid = 999;
delete from students where studentid = 99;
delete from courses where courseid = 999;
delete from instructors where instructorid = 99;
delete from departments where departmentid = 99;
select *
from students
where enrollmentdate >= '2023-01-01';
select c.*
from courses c
inner join departments d
    on c.departmentid = d.departmentid
where d.departmentname = 'Mathematics'
limit 5;
select
    c.courseid,
    c.coursename,
    count(distinct e.studentid) as totalstudents
from courses c
inner join enrollments e
    on c.courseid = e.courseid
group by c.courseid, c.coursename
having count(distinct e.studentid) > 5;
select
    s.studentid,
    s.firstname,
    s.lastname
from students s
inner join enrollments e
    on s.studentid = e.studentid
inner join courses c
    on e.courseid = c.courseid
where c.coursename in ('Introduction to SQL', 'Data Structures')
group by s.studentid, s.firstname, s.lastname
having count(distinct c.coursename) = 2;
select distinct
    s.studentid,
    s.firstname,
    s.lastname,
    c.coursename
from students s
inner join enrollments e
    on s.studentid = e.studentid
inner join courses c
    on e.courseid = c.courseid
where c.coursename in ('Introduction to SQL', 'Data Structures')
order by s.studentid;
select avg(credits) as averagecredits
from courses;
select max(i.salary) as maximumsalary
from instructors i
inner join departments d
    on i.departmentid = d.departmentid
where d.departmentname = 'Computer Science';
select
    d.departmentid,
    d.departmentname,
    count(distinct e.studentid) as totalstudents
from departments d
left join courses c
    on d.departmentid = c.departmentid
left join enrollments e
    on c.courseid = e.courseid
group by d.departmentid, d.departmentname
order by d.departmentid;
select
    s.studentid,
    s.firstname,
    s.lastname,
    c.courseid,
    c.coursename,
    e.enrollmentdate
from students s
inner join enrollments e
    on s.studentid = e.studentid
inner join courses c
    on e.courseid = c.courseid
order by s.studentid, c.courseid;
select
    s.studentid,
    s.firstname,
    s.lastname,
    c.coursename
from students s
left join enrollments e
    on s.studentid = e.studentid
left join courses c
    on e.courseid = c.courseid
order by s.studentid;
select
    i.instructorid,
    concat(i.firstname, ' ', i.lastname) as instructorname,
    d.departmentname,
    i.salary
from instructors i
inner join departments d
    on i.departmentid = d.departmentid;
select
    studentid,
    firstname,
    lastname,
    enrollmentdate,
    year(enrollmentdate) as enrollmentyear
from students;
select
    instructorid,
    concat(firstname, ' ', lastname) as instructorfullname
from instructors;
select
    enrollmentid,
    studentid,
    courseid,
    enrollmentdate,
    count(*) over (
        order by enrollmentdate, enrollmentid
        rows between unbounded preceding and current row
    ) as runningtotal
from enrollments
order by enrollmentdate, enrollmentid;
select
    studentid,
    firstname,
    lastname,
    enrollmentdate,
    case
        when enrollmentdate < date_sub(curdate(), interval 4 year)
            then 'Senior'
        else 'Junior'
    end as studentstatus
from students
order by studentid;

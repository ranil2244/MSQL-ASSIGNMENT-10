CREATE DATABASE Teachers2;
USE Teachers2;

create table teachers (id int , name varchar(20), 
subject varchar(20),
 experience int,
 salary int);
insert into teachers(id ,name, subject, experience,  salary) values 
(1,'Amal', 'Mathematics', 8, 60000),
(2,'Jothy', 'Science', 6, 63000),
(3,'Paul', 'English', 16, 65000),
(4,'Mathew', 'History', 4, 62000),
(5,'Remya', 'Art', 3, 47000),
(6,'Navya', 'Geography', 12, 55000),
(7,'Lisy', 'Physics', 7, 56000),
(8,'Hanok', 'Chemistry', 8, 52000);
select * from teachers;

delimiter $$
create trigger before_insert_teacher 
before insert on teachers for each row
begin
if new.salary<0 then
signal sqlstate '45000' set message_text ='Salary cannot be negative';
end if;
end $$
delimiter ;
/*insert into teachers(id ,name, subject, experience,  salary) values 
(9,'habee', 'Hindi', 9, -1);*/

create table teacher_log(log_id int ,teacher_id int, action varchar(20),timestamp datetime);
delimiter $$
create trigger after_insert_teacher 
after insert on teachers for each row
begin
insert into teacher_log(teacher_id,action,timestamp) values
(new.id,'insert',now());
end $$
delimiter ;

delimiter $$
create trigger before_delete_teacher
before delete on teachers for each row
begin
if old.experience>7 then
signal sqlstate '45000' set message_text= 'Cant delete teachers with experience more then 7';
end if;
end $$
delimiter ;

delimiter $$
create trigger after_delete_teacher 
after delete on teachers for each row
begin
insert into teacher_log(teacher_id,action,timestamp) values
(old.id,'delete',now());
end $$
delimiter ;
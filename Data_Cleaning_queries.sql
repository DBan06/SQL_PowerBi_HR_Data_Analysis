create database projects;
use projects;

select * from hr;
describe hr;
set sql_safe_updates=0;
alter table hr
change column ï»¿id emp_id varchar(20) null;

-- ==================================================================================================
select birthdate from hr;
update hr
set birthdate=case
when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;
alter table hr
modify column birthdate date;
-- ====================================================================================================
select hire_date from hr;
update hr
set hire_date=case
when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;
alter table hr
modify column hire_date date;
-- ======================================================================================================
select termdate from hr;
update hr
set termdate=date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate!='';

alter table hr
modify column termdate date;
-- =======================================================================================================
-- adding the age column
alter table hr
add column age int;
update hr
set age=timestampdiff(year,birthdate,curdate());
-- ==============================================================================================================
select count(*) from hr where age<18;
select max(age) from hr;

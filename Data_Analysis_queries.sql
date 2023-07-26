select * from hr;
-- ===============================================================================================
-- what is the gender breakdown of employees in the company
select gender, count(*) as count 
from hr 
where age>=18 and termdate like '%0000-00-00' 
group by gender;
-- ===============================================================================================
-- what is the race/ethnicity breakdown of employees in the company
select race, count(*) as count
 from hr 
 where age>=18 and termdate like '%0000-00-00' 
 group by race 
 order by count desc;
-- ===============================================================================================
-- what is the age distribution of employees in the company
select 
case
when age>=18 and age<25 then '18-24'
when age>=25 and age<35 then  '25-34'
when age>=35 and age<45 then  '35-44'
when age>=45 and age<55 then  '45-54'
when age>=55 and age<65 then  '55-64'
else '65+'
end as age_group,
count(*) as count
from hr where age>=18 and termdate like '%0000-00-00' group by age_group order by age_group; 
-- ===============================================================================================
-- gender distribution as per age group
select gender,
case 
when age>=18 and age<25 then '18-24'
when age>=25 and age<35 then '25-34'
when age>=25 and age<45 then '35-44'
when age>=45 and age<55 then '45-54'
when age>=55 and age<65 then '55-64'
else '65+'
end as age_group, count(*) as count
from hr where age>=18 and termdate like '%0000-00-00' group by gender,age_group order by age_group;
-- ===============================================================================================
-- how many employees work at headquarters vs remote locations
select location,count(*) as count
from hr
 where age>=18 and termdate like '%0000-00-00' 
 group by location;
 -- ===============================================================================================
 -- what is the average length of employment for employees who have been terminated
  select round(avg(datediff(termdate,hire_date))/365,0) as avg_length_employment
 from hr where termdate<=curdate() and termdate<> '0000-00-00' and age>=18;
  -- ===============================================================================================
  -- how does gender distribution vary across departments 
 select department,gender,count(*) from hr where age>=18 and termdate='0000-00-00'
 group by department,gender order by department;
 
 -- ===================================================================================================
 
--  what is the distribution of jobtitles across the company
select jobtitle,count(*) from hr
where age>=18 and termdate='0000-00-00' group by jobtitle order by jobtitle desc;
 -- ===================================================================================================
 
 -- which department has the highest number of turnover rate 
 
 select department, total_count, terminated_count, terminated_count/total_count as termination_rate
 from 
 (
 select department, count(*) as total_count,
 sum(case when termdate<>'0000-00-00' and termdate<=curdate() then 1 else 0 end) as terminated_count
 from hr where age>=18 group by department) as subquery
 order by termination_rate desc;
  -- ===================================================================================================
  -- what is the distribution of employees across locations city and state
  select location_state,count(*) as count from hr where age>=18 and termdate='0000-00-00'
  group by location_state
  order by count desc;

select year, hires, terminations, hires-terminations as net_change, round((hires-terminations)/hires*100,2) as net_change_percent
from
(select year(hire_date) as year, count(*) as hires, 
sum(case when termdate<>'0000-00-00' and termdate<=curdate() then 1 else 0 end) as terminations
from hr where age>=18 group by year) as subquery 
order by year asc;

select department, round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
from hr
where termdate<=curdate() and termdate<>'0000-00-00' and age>=18
group by department; 
 

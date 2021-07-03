use HR ;

select * from  employees ;
select * from  departments ;
select * from  locations   ;
-- -------------------------------------------------------------------

# 1. Fetch the 3rd and 4th highest salary earned by an employee.

select    salary 
from      employees
order by  salary desc
limit 2,2 ;


# 2. Fetch details of departments in which the maximum salary is more than 10000.

select    	d.department_id , d.department_name , d.manager_id , d.location_id , e.salary
from      	departments d 
inner join  employees e 
on        	d.department_id = e.department_id
group by  	d.department_id , d.department_name
having    	max(e.salary) > 10000 ;

--

# 3. Fetch the name of the city of the employees whose ID's are 130 and 150

select      city , employee_id 
from 	    employees e 
inner join  departments d  on  e.employee_id = d.department_id 
inner join  locations l    on  l.location_id = d.location_id 
where       employee_id in (130,150) ;



# 4. Fetch all the details of employees working in US / UK

select 		e.* , l.country_id 
from        locations l 
inner join  departments d 	
on  		l.location_id = d.location_id
inner join 	employees e 	
on  		d.department_id = e.department_id
where 		l.country_id in ('US','UK') ;


# 5. Fetch the Employee name, phone number and manager name of all employees working in new jersey or california

select 		concat(e.first_name,' ',e.last_name)  as  Employee_name , e.phone_number,
			concat(m.first_name,' ',m.last_name)  as  Manager_name , l.state_province
from        employees e 
right join  employees m   on  e.manager_id = m.employee_id 
right join  departments d on  e.department_id = d.department_id
right join  locations l   on  d.location_id = l.location_id
where       l.state_province in ('New jersey','California') ;



# 6. Fetch details of departments managed by John / Alexander

select distinct 	d.* , m.first_name  
from  				employees e 
inner join 			employees m    on  e.manager_id = m.employee_id
inner join 			departments d  on  e.manager_id = d.manager_id
where 				m.first_name   in  ('John','Alexander');

--

# 7. Fetch records of all employees whose salary is more than the overall average salary

select * 	
from   employees
where  salary >  ( select avg(salary) from employees );

--

# 8. Fetch all records of employees whose salary is greater than the average salary of a sales rep (job_id = SA_Rep)

select * 
from   employees
where  salary  >  ( select avg(salary) from employees where job_id='SA_Rep' ) ;

--

# 9. Fetch a report all managers who manage more than 3 employees

select   manager_id  ,  count(*)  as Num_of_emp ,  first_name 
from     employees 
group by manager_id
having   count(*)>3 ; 



# 10. Fetch a report of all employees names, ids, department name, salary and department average salary.

select    e.first_name , e.employee_id , d.department_name , e.salary ,
          ( SELECT  AVG(salary) 
            FROM 	employees 
            WHERE   employees.department_id = e.department_id )   as   avg_salary  

from 	  employees e 
left join departments d  
on  	  e.department_id  =  d.department_id ;

--

# 12. Fetch a report of all employees (emp id, name & salary) along with the difference of their salary 
      -- from their department’s average salary. 
      -- Please group this data department-wise and sort the data in order of the salary difference


select     e.first_name  ,  e.employee_id  ,  d.department_name  ,  e.salary  ,
					   ( SELECT AVG(salary) FROM employees WHERE employees.department_id = e.department_id )   as   avg_salary ,
		   e.salary  - ( SELECT AVG(salary) FROM employees WHERE employees.department_id = e.department_id)    as   Difference

from       employees e 
left join  departments d  on  e.department_id  =  d.department_id
group by   e.department_id , e.employee_id
order by   Difference desc ;


# 13. For each employee in department 80, fetch a report of their names, id, department name, salary, max salary in their 
     -- department, difference between the max salary and their salary.


select 			e.department_id , concat(e.first_name,' ' ,e.last_name) , d.department_name , e.employee_id ,
				e.salary , j.max_salary , j.max_salary - e.salary  as  Difference_salary
                
from 			employees e
inner join 		departments d   on   e.department_id  =  d.department_id
inner join 		jobs j 			on 	 e.job_id  =  j.job_id
where 			e.department_id = 80 ;


# 14.Select all the employees who joined the organization on the 3rd of every month. 

select  * 
from    employees
where   month(hire_date)=3 ; 

--

# 15.Fetch the names of countries having less than 10 employees. 

select 		c.country_name , count(e.employee_id) as Count_Employees 
from 		employees e
inner join 	departments d 	on  e.department_id =  d.department_id
inner join 	locations l 	on 	d.location_id   =  l.location_id
inner join 	countries c 	on 	l.country_id    =  c.country_id
group by 	c.country_name
having 		count(e.employee_id) < 10
order by 	Count_Employees ;


# 16. Fetch the department name, manager name, and salary of the manager for all managers whose experience is more than 25 years


select 		d.department_name	,	concat(m.first_name,' ',m.last_name) as Manager_name	,	m.salary
from 		employees e 
inner join 	employees m   on   e.manager_id    = m.employee_id
inner join  departments d on   m.department_id = d.department_id
where       (datediff(curdate(),m.hire_date)/365.25) > 25
group by    d.department_name ;



# 17. WAQ to get the name of employees and the total number of months worked by the employees.
    -- Order your results by the total number of months employed

select     concat(first_name,' ' ,last_name)  as  Name   ,  floor(datediff(curdate(),hire_date)/30)  as   Months_worked
from	   employees
order by   Months_worked desc ;



# 18. WAQ to get the name of employees, their joining date and total years of experience of the employees 

select 	  concat(e.first_name,' ',e.last_name) 	      as   Employee_name   ,    e.hire_date   as  Joining_Date,
		  floor(datediff (curdate(),e.hire_date) / 365) as   Years_Experienced

from 	  employees e 
order by  Years_experienced desc;



# 19. Salary is dispatched for all employees on the last day of the month. Fetch a report of employees’ name, phone 
     -- and the date on which they received their first salary in the company.

select 	concat(e.first_name,' ',e.last_name) as  Name	,	e.phone_number ,
		Last_day(e.hire_date)                as  First_Day_Salary_Date

from 	employees e ;



# 20. Salary is dispatched for all employees on the last day of the month. Fetch a report of employees’ name,
	-- phone and the date on which they received their second salary in the company.

select 	concat(e.first_name,' ',e.last_name)  as  Name  ,   e.phone_number   ,
		Last_day (adddate(e.hire_date,interval 1 month))   as  Second_Day_Salary_Date

from 	employees e ;



# 21. 2 weeks from now bonus will be released for the employees. Display employees name, their salary and the bonus date. 

select 		concat  (first_name,' ',last_name)  ,  salary ,  
			adddate(curdate(),interval 2 week)  as Bonus_date

from 		employees ;


# 22. Display a report of employee name, hiring date, current job, past job of all employees who were hired after 1999.


select 		concat(e.first_name,' ' ,e.last_name)  as  Employee_name  ,  e.hire_date ,
			e.job_id  as  Current_Job , jh.job_id  as  Previous_Job 
            
from 		employees e 
left join 	job_history jh  on e.employee_id=jh.employee_id
where 		year(e.hire_date) >= '1999-01-01'
group by 	e.hire_date , e.job_id , jh.job_id ;

--

# 23. Fetch a report of all employees who joined before their respective managers.

select 		e.* 
from 		employees e 
inner join  employees m  on   e.manager_id  =  m.employee_id
where       datediff(curdate() , e.hire_date)   >   datediff(curdate() , m.hire_date)  ;


# 24. Display system date ,total number of rows from employees and departments table in a single row and 3 columns.

select 		sysdate()  ,  
			(select count(*) from employees )    as   emp ,
			(select count(*) from departments )  as   dept 
from  dual ;



# 25. Display the first and last name and salary for those employees who earn less than the employee earn whose number is 182. 

select   first_name , last_name , salary 
from     employees 
where    salary  <  (select salary from employees where employee_id=182) ;



# 26. Write a query in SQL to display the job title, department name, full name (first and last name ) of employee, 
  -- and starting date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 1997. 


select   		j.job_title  ,   d.department_name   ,   concat(e.first_name,' ',e.last_name)   as Name   ,  jh.start_date
from    		job_history  jh 

inner join 		employees 	e   on  jh.employee_id   =  e.employee_id
inner join 		departments d 	on  e.department_id  =  d.department_id
inner join 		jobs 		j   on  e.job_id         =  j.job_id

where 			jh.start_date>='1993-01-01'  and  jh.start_date<='1997-08-31' ; 



# 27.Write a query in SQL to display job title, full name (first and last name ) of employee, 
  -- and the difference between maximum salary for the job and salary of the employee


select 			j.job_title  ,  concat(e.first_name,' ',e.last_name)   as   Full_name , 
				j.max_salary - e.salary as Difference

from 			employees e 
left join 		jobs j 	
on 				e.job_id = j.job_id
group by 		e.employee_id ;
 
 
# 28.  Write a query in SQL to display the full name (first and last name ) of employee with ID and name of the country
       -- presently where (s)he is working.
 
 
 select 	  concat(e.first_name,' ',e.last_name) 	as 	Full_Name 	, 	e.employee_id 	, 	c.country_name
 from 		  employees e 
 inner join   departments d  on 	e.department_id  =  d.department_id
 inner join   locations l 	 on 	d.location_id    =  l.location_id
 inner join   countries c 	 on 	l.country_id     =  c.country_id
 
 group by 	 e.employee_id , c.country_name ;



# 29.Write a query to display the last name, job, and salary for all employees whose job is that of a Programmer or a
   -- Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000. 

select 		e.last_name	,	e.job_id	,	e.salary	,	j.job_title 
from 		employees e 
inner join  jobs j 
on 			e.job_id = j.job_id
where 		j.job_title in ('Programmer','Shipping Clerk')      and 	 e.salary not in (4500,10000,15000) ;



# 30. Write a query in SQL to display those employees who contain a letter z to their first name 
      -- and also display their last name, department, city, and state province.


select 			e.employee_id , concat(e.first_name,' ' ,e.last_name) 	as	 Name	,
				d.department_name , l.city , l.state_province 

from 			employees e 
inner join 		departments d 	on 	e.department_id = d.department_id
inner join 		locations l 	on 	d.location_id 	= l.location_id

where 			e.first_name like '%z%' ; 



# Q31. Fetch all the names and joining dates of employees reporting to manager whose manager id
--     is 100 and display the date in this format - “January, 21, 1991” (14 rows)

SELECT  CONCAT(first_name," ",last_name)  AS Name  ,  DATE_FORMAT (hire_date, '%M,%d,%Y')  AS joining_date 
FROM    employees 
WHERE   manager_id = 100 ;



# Q32. Fetch all the records of employees who joined the organization after the month of April in the 1997 (16 rows)

SELECT * FROM employees 
WHERE   DATE_FORMAT(hire_date,'%y') = '97'   AND   DATE_FORMAT(hire_date,'%m') > '04' ;



# Q33. Fetch all the years in which more than 5 employees joined the organization.

SELECT    DATE_FORMAT (HIRE_DATE, "%Y")
FROM      employees
GROUP BY  DATE_FORMAT (HIRE DATE, '%Y')
HAVING    COUNT(EMPLOYEE_ID) > 5 ;


# Q34. Fetch the records of all employees working as a sales rep (Job_id = SA_REP) whose salary
--     would be greater than 10,000 after an increment of 17% (14 rows)

SELECT * 
FROM   employees 
WHERE  salary*1.17 > 10000   and   job_id like 'SA REP' ;


# Q35. Display the unique departments in employees table along with the total number of employees in each department 
--     in the order of maximum employees.

SELECT    department_id , COUNT(*) total_emp 
FROM      employees 
GROUP BY  department_id
ORDER BY  total_emp DESC ;


# Q36. Fetch all departments having more than 10 employees. (3 rows)

SELECT    job_id , department_id , COUNT(*) 
FROM      employees 
GROUP BY  job_id , department_id
HAVING    COUNT(*) > 10 ;


# Q37. Fetch a report of the difference between the highest and lowest salary against each job.

select    job_id , max(salary)-min(salary) as difference 
from      employees
group by  job_id
order by  job_id desc ;


# Q38. Fetch the length of first name of all employees whose last name ends with a or z. (7 rows)

select   employee_id , first_name , last_name , length(first_name)
from     employees
where    last_name like '%a'   or  last_name like '%z' ;


# Q39. Fetch records of employee names beginning with ae or containing ly. (2 rows)

select * 
from   employees 
where  concat(first_name,last_name) like 'ae%'    or   concat(first_name,last_name) like '%ly%' ;


# Q40. Fetch records of all employees whose first name begins or ends with a vowel (aeiou) (41 rows)

select * 
from   employees
where  substr(first_name,1,1)   in   ('a','e','i','o','u')    or    substr(first_name,-1)  in  ('a','e','i','o','u') ;


# Q41. Fetch a report of all employees who joined before their respective managers. (30 rows)

select * 
from   			employees e
LEFT OUTER JOIN employees m    
ON     			e.manager_id = m.employee_id
where  			e.hire_date < m.hire_date ;


# Q42. Display a report of employee_id, employee name, employee phone number and the country he / she is working in.

SELECT  employee_id , first_name , last_name , c.country_name
FROM    Employees e 
JOIN  	Departments d     ON    e.department_id = d.department_id
JOIN    locations         ON    d.location_id = l.location_id
JOIN    countries c       ON    l.country_id = c.country_id ;

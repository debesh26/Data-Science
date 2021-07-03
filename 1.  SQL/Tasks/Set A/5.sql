use Schemas_3 ;

select * from youtube ;
-- ------------------------------------------------------------

# Q1. Display the video Id and the number of likes of the video that has got maximum likes

select  video_id , likes 
from    youtube
where   likes in ( select max(likes) from youtube ) ;


# Q2. Print video_id and channel_title where channel_title ends with 'a' and contains 8 characters.

select  video_id , channel_title 
from    youtube
where   channel_title in  ( select channel_title from youtube  where channel_title like '_______a' ) ;


# Q3. Display the publish date, trending date and description of the channel 'vox'.

select  publish_date , trending_date , channel_title , description 
from    youtube
where   channel_title in  ( select channel_title from youtube  where channel_title ='vox' ) ;


# Q4. Display the channel_title, publish_date and the trending_date having category id in between 5 to 10.

select  publish _date , trending date , channel_title 
from    youtube
where   category_id in  ( select category_id from youtube  where category_id between 5 and 10 ) ;



# Q5. Display the video id and number of views of the video that has received like more than average likes.

select  video_id , views 
from    youtube
where   likes > ( select avg(likes) from youtube ) ;


-- --------------------------------------------------------------------
select * from wine ;
-- --------------------------------------------------------------------

# Q1. Rank the winery according to the quality of the wine (points).

select  winery , points , dense_rank() over (order by points desc)  as Wine_rank
from    wine ;


# Q2. Use aggregate window functions to find the average of points for each row within its partition (country). 
-- -- Also arrange the result in the descending order by country.

select  * , avg(points) over (partition by country order by country desc)  as avg_points
from    wine ;

-- -------------------------------------------------------------------------
select * from students ;
-- -------------------------------------------------------------------------

# Q1. Rank the students on the basis of their marks subjectwise.

select  *  , rank() over ( order by marks )  as  my_rank 
from    students ;


# Q2. Provide the new roll numbers to the students on the basis of their names alphabetically.

select  distinct(name) ,  dense_rank() over ( order by name )  as  Roll_Number 
from    students ;


# Q3. Use the aggregate window functions to display the sum of marks in each row within its partition (Subject).

select   * , sum(marks) over (partition by subject) as sum1 
from     students ;


# Q4. Display the records from the students table where partition should be done on subjects and use sum as a window function on marks, 
-- -- arrange the rows in unbounded preceding manner.

select   * , sum(marks) over ( partition by subject order by marks ROWS UNBOUNDED PRECEDING )  as  ‘new’ 
from     students; 


# Q5. Find the dense rank of the students on the basis of their marks subjectwise. Store the result in a new table 'Students_Ranked'

create table Students_Ranked as
							 select  * , dense_rank() over ( partition by subject ORDER BY marks DESC)  as 'dense_RNK'
							 FROM    students ;

select * from Students_Ranked ;


# Q6. Find the 2nd highest marks student subject wise.alter

select  * 
from    ( select *  ,  rank()        over (partition by subject order by marks desc)   as rank_marks from students ) t1
where   rank_marks = 2 ;

-- ---------------------------------------------------------------------------
select * from  department_details ;
select * from  employee_details   ;
-- --------------------------------------------------------------------------

# Q1. Create a view "details" that contains the 
--    columns employee_id, first_name, last_name and the salary from the table "employee_details".
 
create view details_vw as
					  select 	employee_id , first_name , last_name , salary	
					  from 		employee details ;
 
 
# Q2. Update the view "details" such that it contains the records from the 
--    columns employee_id, first_name, last_name, salary, hire_date and job_id 
--     where job_id is ‘IT_PROG’.

alter view details_vw as
					  select 	   employee_id , first_name , last_name , salary , HIRE_DATE , JOB_ID
					  from 	       employee_details
					  where 	   JOB_ID = 'IT PROG' ;


# Q.3 Create a view "check_salary" that contains the records from the 
-- -- columns employee_id, first_name, last_name, job_id and salary from the table "employee_details" 
-- --  where the salary should be greater than 50000.

create view check_salary_vw as
							select 		employee_id  , first_name , last_name , JOB_ ID , salary
							from 		employee details
							where 		salary > 50000 ;


# Q4  Create a view "location_details" that contains the records from the 
-- -- columns department_name, manager_id and the location_id from the table "department_details" 
-- --  where the department_name is ‘Shipping’.
 
create view location_details_vw  as
								 select 		department_name , manager_id , location_id
								 from 			department_details
								 where 			department_name = 'Shipping' ;


 
# Q5.  Create a view "salary_range" such that it contains the records from the 
-- --  columns employee_id, first_name, last_name, job_id and salary from the table "employee_details" 
-- --  where the salary is in the range (30000 to 50000).


create view salary_range_vw as
							select 		employee_id , first_name , last_name , job_id , salary
							from 		employee_details
							where 		salary between 30000 and 50000 ;


# Q6. Create a view "employee_department" that contains the common records from the tables "employee_details" and "department_table".

create view employee_department_vw  as
									select    emp.EMPLOYEE ID , emp.first_name , emp.LAST_NAME , dept.DEPARTMENT_ID , dept.DEPARTMENT_NAME
									from 	  employee_details   as emp 
									join 	  department_details as dept
									on 		  emp.DEPARTMENT_ID  =  dept.DEPARTMENT_ID;


# Q7.  Create a view "pattern_matching" such that it contains the records from the 
-- --  columns employee_id, first_name, job_id and salary from the table name "employee_details" 
-- --  where first_name ends with "l".

create view pattern_matching_vw as
								select 		employee_id , first_name , job_id , salary
								from 		employee details
								where 		first_name like '%l' ;


# Q8. Drop multiple existing views "pattern_matching", "salary" and "location_details".

drop view  pattern_matching_vw  ,  salary_range_vw  ,  location_details_vw ;

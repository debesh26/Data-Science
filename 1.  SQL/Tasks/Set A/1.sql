
use Schemas_1 ;

select * from property_price ;
-- ----------------------------------------------------

# Q1. Print The First Three Characters Of  Exterior1st.

Select substring(Exterior1st,1,3)   
from   Property_Price ;


# Q2. Print Brick_Veneer_Area   Excluding  Brick_Veneer_Type, “None” And “BrkCmn” 

Select  Brick_Veneer_Area , Brick_Veneer_Type   
from    Property_Price      
where 	Brick_Veneer_Type not in ('None','BrkCmn') ;


# Q3. Print Remodel_Year , Exterior2nd  Whose Exterior2nd Contains ‘H’.

Select  Remodel_Year , Exterior2nd    
from    Property_Price         
where 	Exterior2nd  like '%H%' ;


# Q4. Print details of  Remodel_year from 1983 to 2006

select  * 
from 	Property_Price    
where   Remodel_Year between 1983 and 2006 ;


# Q5. Print details of  Brick_Veneer_Type which ends with e and contains 4 alphabets.

Select 	* 
from 	Property_Price    
where  	Brick_Veneer_Type  like '____e' ;


# Q6. Print nearest largest integer value of column Garage_Area

Select  ceil(Garage_Area) 
from 	Property_Price ;


# Q7. Fetch the 3rd highest value of column Brick_Veneer_Area 

Select    Brick_Veneer_Area   
from      Property_Price       
order by  Brick_Veneer_Area   desc 
limit     2,1 ;


# Q8.Rename column LowQualFinSF to Low_Qual_Fin_SF 

Alter table  Property_Price     
change  	 Low_Qual_Fin_SF  LowQualFinSF  varchar(150) ;


# Q9.Extract total Sale_Price for each year_sold column 

Select    	Year_Sold , sum(Sale_Price)   
from      	Property_Price      
group by  	Year_Sold ;



# Q10. Extract Year_Sold, Sale_Price whose price is greater than 100000.

Select 	   Year_Sold , Sale_Price   
from       Property_Price      
group by   Year_Sold  
having 	   Sale_Price  >  100000 ;



# Q11. Count all duplicate values of column  Brick_Veneer_Type

Select    Brick_Veneer_Type , count(Brick_Veneer_Type) 
from 	  Property_Price    
group by  Brick_Veneer_Type 
having    count(Brick_Veneer_Type) > 1 ;


-- -----------------------------------------------------------------------------------
select * from sandwich ;
-- -----------------------------------------------------------------------------------

# Q1. Display the details of sandwiches were price range between 20 to 50.

 select * 
 from   sandwich 
 where  price between 20 and 50 ;


# Q2. Display the details of sandwiches of brown bread.

 select name 
 from   sandwich 
 where  bread = 'Brown';
				

# Q3. Display the names of the sandwiches in uppercase.

 select upper(name) 
 from   sandwich;


# Q4. Display the names of the sandwiches where the filling contains “veg”.

 select name 
 from   sandwich 
 where  filling like '%veg%';


# Q5. Replace the “san” of the sandwich name with “mac” and display. e.g. “san-chicken” should be displayed as “mac-chicken”. 

 select replace(name,'san','mac') 
 from   sandwich ;
 
 
 # Q6. Using table sandwich display the average price of the sandwiches as per the type of bread.

 select 	avg(price), bread 
 from 		sandwich 
 group by 	bread;


# Q7. Display maximum price  bread wise whose price is greater than 40.  

select 	 max(price) , bread , price
from 	 sandwich 
group by bread
having 	 price > 40;


-- --------------------------------------------------------------------------------
select * from emp ;
-- --------------------------------------------------------------------------------


# Q1. Return the result as “<Name of employee> joined on <Hire_date> for all the employees .
     -- Sample Output : “Namrata Joined on 1st January 1999” 
  
 select  distinct concat (empname , ' joined on ' , date_format(hire_date,'%D %M %Y'))   
 from    emp ;


# Q2. Display non duplicate rows without using distinct. 

select * from emp 
union
select * from emp ;


# Q3. Display all the details of employees who work in the same department and drawing salary less than 5000,
	 -- sorted by highest to lowest salary

select  e1.empid, e1.empname, e1.hire_date, e1.salary, e1.deptno 
from 	emp e1
join 	emp e2  
on 		e1.deptno = e2.deptno
where 	e1.empid <> e2.empid 
and 	salary < 5000;


# Q4. Display empname,hire_date, salary according to  salary rank with no gaps in ranking values by using window  function. 
	  -- Label the ranked column as “salary_rank”.

select 		empname , hire_date , salary ,   dense_rank()	over(order by salary desc)  as salary_rank
from 		emp;


# Q5. Display empname,hire_date, salary based on date employee was hired with no gaps in ranking values by using window  function. 
	  -- Label the ranked column as “seniority”.

select 		empname , hire_date , salary ,  dense_rank() 	over(order by hire_date )  as  seniority
from 		emp;


# Q6. Display empname,deptno,hiredate with next senior's hire date as seniorityDate 

SELECT  empName , deptno,
        hire_Date ,
        LEAD(hire_date,1) OVER (
								PARTITION BY deptno
								ORDER BY     hire_Date desc )   as  seniorityDate
FROM emp;
    
    
# Q7. Display year and number of employees joined in each year in employee table

select 	 	year(hire_date)	,	count(distinct empid) 
from 	 	emp
group by 	year(hire_date) ;


-- --------------------------------------------------------------------------
select * from Train ;
select * from Ticket ;
select * from Journey ;
-- -------------------------------------------------------------------------
    
# Q1. List the number of trains with the current number of ticket bookings done between Mumbai and Delhi on 18th Dec 2019. 

Select 		count(distinct t.train_no)  as 'No. of trains', 
			count(j1.journey_id) 		as 'No. of ticket bookings' 

from 		Train t 
inner join 	Journey j1 	
on 			t.Train_no	=  j1.Train_no
Where 		src='Mumbai'    and 	dest='Delhi'    and 	 Date_journey='2019-12-18' 
group by 	Date_Journey ;


# Q2. Display names of the passengers who are travelling between Bangalore and Chennai in 2AC, travelling on 12/02/2012. 

Select 	pname 	
from 	Ticket 
where 	class='2AC'  and 	Journey_id 	in	
											(  select 		journey_id 
											   from 		Train t 
											   inner join 	Journey j1 	
											   on 			t.Train_no  =  j1.Train_no
											   Where       src='Bangalore'    and    dest='Chennai'   and    Date_journey='2012-04-12'
											);
                                            
-- --------------------------------------------------------------------
select  *  from  student ;
select  *  from  marks      ;
select  *  from  details   ;
-- --------------------------------------------------------------------

# 1. Display the name of students along with their respective score and city of residence

select  s_name , score , address_city   
from    student s 
join    marks m    on   s.s_id      =  m.s_id
join    details d  on   m.school_id =  d.school_id ;


# 2. Display the names of all the students and their corresponding email id. 
     -- Fetch the names of those students as well who does not have an email address provided
     
select           s_name , email_id 
from 			 student s 
left join        marks m    on   s.s_id      =  m.s_id
left outer join  details d  on   m.school_id =  d.school_id ;


# 3. Display the number of students who have passed or failed respectively

Select 		count(*) 
from 		student s 
join 		marks m    on   s.s_id = m.s_id 
group by 	status;


# 4. Display name and email address of the student who is an 'IMO finalist'

select 	s_name	,	email_id 
from 	student s ,	marks m , details d
where 	s.s_id = m.s_id   and 	m.school_id = d.school_id   and    accomplishments='IMO finalist' ;


# 5. Display the name of cities where the students reside without duplicates. 

select distinct address_city 
from   details;


# 6. Display the minimum score for status in fail as "Min Low marks" along with school id, email id and status

SELECT 	min(score)  as  'Min Low marks' ,  status , marks.school_id , email_id 
from 	marks 
join 	details     
on 	    marks.school_id = details.school_id ;


# 7. Display the number of unique schools in the schema 

Select 	count(distinct school_id) 
from 	marks;



# 8. Display the number of students who reside in Bangalore

select count(*)
from   student s 
join   marks m    on  s.s_id = m.s_id
join   details d  on  m.school_id = d.school_id 
where  address_city='Banglore';


# 9. Display the name of those students who has the character â€˜sâ€™ as the second last character in their name.

select  s_name 
from 	student 
where 	s_name like '%s_';


# 10. Display the first two letters of all the student names

select substring(s_name,1,2) 
from   student;


# 11. Display the email address of those students who have the word â€˜Geekâ€™ mentioned in their accomplishments 

select 	email_id 
from 	details
where 	accomplishments like '%Geek%';


# 12. Display name and status of those students who has a school id in any of the following -1004, 1012 ,1016 

select 	s_name , status 
from 	student s ,	marks m 
where 	s.s_id = m.s_id    and 	 school_id in (1004,1012,1016) ;


# 13. Display name and score of the students who have scored marks between 80 and 90

select 	s_name  ,  status 
from 	student s ,	marks m 
where 	s.s_id = m.s_id    and 	 score between 80 and 90 ;


# 14. Display '1st Division' for students 
	-- who have scored more than 90, '2nd Division' for those who have 
	-- scored more than 70 and '3rd Division' for those who have scored more
	-- than 50 else display 'Fail'. 
    
Select score , case 
			   when score>90 then '1st Division'
               when score>70 then '2nd Division'
               when score>50 then '3rd Division'
               else 'Fail' 
               end as tag
from marks;    



# 15.Display top 5 score, status, address_city along with school_id

select 	  score , status , address_city , marks.school_id 
from 	  marks 
join 	  details	 
on  	  marks.school_id = details.school_id
order by  score desc 
limit 5;
 
 
-- -----------------------------------------------------------------------
select * from departments ;
select * from employees   ;
-- -----------------------------------------------------------------------

# 1. Get department name, employee name, and salary of the all employees whose experience is more than 25 years

Select DEPARTMENT_NAME, FIRST_NAME, SALARY  , datediff (SYSDATE() , HIRE_DATE) / 365
FROM   departments D 
JOIN   employees E  
ON 	   D.department_id = E.department_id  
WHERE  datediff (SYSDATE() , HIRE_DATE) / 365 > 25 ;



# 2. Display the department id and number of employees of those groups that have more than 2 employees. 

SELECT    department_id , COUNT(*) as 'Num of Employee'
FROM	  employees
GROUP BY  department_id
HAVING    COUNT(*) > 2;



# 3. Write down the query to print firstname such that first letter of the name is in Lower Case and all other letter in Upper Case.

SELECT 	 First_Name , 
		 CONCAT ( LOWER(SUBSTRING(First_Name, 1, 1))    ,   UPPER(SUBSTRING(First_Name,2,LENGTH(First_Name) - 1)))    AS  First_Name
FROM	 employees ;


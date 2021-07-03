
-- ------  Dataset  :  Department_Details  ,   Employee_details    -------------------------------------------------

# Use subqueries

# Q1.  Retrive employee_id , first_name , last_name and salary details of those employees whose salary is greater than the average salary.

select 	EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY 
from 	employee_details
where 	salary >  ( select avg(salary) from employee_details ) ;


# Q2.  Display first_name , last_name and department_id of those employee where the location_id of their department is 1700

select  first_name , last_name , department_id  
from    employee_details
where   department_id in  ( select department_id from department_details where location_id=1700 ) ;


# Q3.  From the table employees_details, extract the employee_id, first_name, last_name, job_id and department_id 
--     where manager_id is equal to the employee_id.

SELECT 	employee_id , manager_id , FIRST_NAME , LAST_NAME , JOB_ID , DEPARTMENT_ID
FROM 	employee_details E
WHERE 	EXISTS ( SELECT * FROM employee_details WHERE MANAGER_ID = E.EMPLOYEE_ID ) ;


# Q4.  Extract employee_id, first_name, last_name, phone_number and email of employees having job_id as 'IT_PROG'.

SELECT  employee_id , first_name , last_name , phone_number , email
FROM 	employee_details
WHERE 	Job_id = ANY ( SELECT Job_id FROM employee_details WHERE Job_id = 'IT_PROG' ) ;


# Q5.  Extract employee_id, first_name, last_name, phone_number, email of those employees whose job_id is not 'IT_PROG'.

SELECT  employee_id , first_name , last_name , phone_number , email , job_id
FROM 	employee_details
WHERE 	Job_id = ANY ( SELECT job_id FROM employee_details WHERE NOT Job_id = 'IT_PROG' ) ;


# Q6.  Display employee_id, first_name, last_name, phone_number, salary and job_id  of all the employees 
--     having salary greater than 30000.

SELECT 	employee_id, first_name, salary
FROM 	employee_details
WHERE 	salary = ANY ( SELECT salary FROM employee _details WHERE salary >= 30000 );


# Q7.  Extract employee_id, first_name, last_name, phone_number, salary and job_id of  
--     employees belonging to the 'Contracting' department 

SELECT  employee_id, first_name, last_name, salary 
FROM 	employee_details
WHERE 	DEPARTMENT_ID IN  ( SELECT DEPARTMENT_ID FROM Department_Details WHERE DEPARTMENT_NAME = 'Contracting' ) ;


# Q8.  Extract the details of employees having meeting id '204' and location id '1700'

SELECT *
FROM   employee_details
WHERE  manager_id IN ( SELECT manager_id FROM Department_Details WHERE Manager_ID = 121 and Location_Id = 1700 ) ;


# Q9.  Extract employee_id, first_name of the employees who does not belong to 'Contracting' department

SELECT   employee_id , first_name
FROM     employee_details
WHERE    DEPARTMENT_ID NOT IN  ( SELECT DEPARTMENT_ID FROM Department_Details  WHERE DEPARTMENT_NAME = 'Contracting' );


# Q10. Display employee_id, first_name, last_name, salary, job_id and hire_date of employees having salary in the range 30000 to 45000.

SELECT  employee_id , first_name , last_name , salary , job_id , hire_date
FROM    employee_details
WHERE   salary IN ( SELECT salary FROM employee_details  WHERE salary BETWEEN '30000' AND '45000' ) ;

use Schemas_3 ;

select * from titanic ;
-- --------------------------------------------------------

# Q1. Display the age, first_name and last_name of those passengers who has minimum age

select  age , first_name , last_name 
from    titanic
where   age in ( select min(age) from titanic ) ;


# Q2. Display the age, first name and survival status of those passengers who survived the accident 
--  (Survived = 1 ; Not_Survived = 0)

select   age , first_name , survived  
from     titanic
where    survived=1 ;

# Q3. Display the age, first_name, last_name and pclass of those passengers where pclass is 1 or 2.

select  age , first_name , last_name  
from    titanic
where   pclass  in  ( select pclass  from titanic  where pclass in (1,2) ) ;


# Q4. Display the first_name, last_name, passenger_no of the passenger who paid the maximum fare. 
	-- Display the maximum fare paid by the passenger as well

select  fare , passenger_no , first_name ,  last_name  
from    titanic
where   fare in ( select max(fare)  from titanic ) ;


# Q5. Display the survived status of all the male passengers.

select  survived , first_name , last_name ,  sex 
from    titanic
where   sex in  ( select sex from titanic   where sex='male' ) ;


# Q6. Display the passenger_no, first_name, last_name and embark_town of those passenger where embark_town should not contain any word ending with ‘rg’.

select  passenger_no , first_name , last_name , embark_town  
from    titanic
where   embark_town  in ( select embark_town from titanic  where embark_town not like '%rg') ;


# Q7. Retrieve the first_name, last_name and fare details of those passengers who paid fare greater than average fare. 

select  passenger_no , first_name , last_name , fare 
from    titanic
where   fare >  ( select avg(fare) from titanic ) ;


# Q8. Retrieve the deck, first_name, last_name and age details of all those passengers having age in between 20 to 35.

select  deck , first_name , last_name , age 
from    titanic
where   age in  ( select age from titanic  where age between 20 and 35 ) ; 


# Q9. Display the passenger_no and first_name of all the passenger whose name starts with the letter 'A'

select  passenger_no ,  first_name  
from    titanic
where   first_name in  ( select first_name from titanic  where first_name like 'A%' ) ;


# Q10. Display the passenger_no, first_name, last_name and embark_town from the given table where the embark_town should end with 'on'.

select  passenger_no , first_name , last_name , embark_town 
from    titanic
where   embark_town in  ( select embark_town from titanic  where embark_town like '%on' ) ;


# Q11. From the given table retrieve the passenger_no, first_name, last_name of the passengers who are alive. (Note : alive = yes ; not_alive = no).

select  passenger_no , first_name , last_name 
from    titanic
where   alive in  ( select alive from titanic  where alive ="yes" ) ;


# Q12. Extract the first_name, last_name and passenger_no of the passengers who were on deck 90.

select  passenger_no , first_name , last_name , deck , deck_number 
from    titanic
where   deck_number in ( select deck_number from titanic  where deck_number=90 ) ; 


# Q13. Display the sex, age, fare and deck_number of the passenger having name 'Steven King'.

select  sex , age , fare , deck_number 
from    titanic
where   ( first_name , last_name ) in  ( select first_name , last_name from titanic  where first_name = ‘Steven and last_name=‘King’ ) ;


# Q14. Display the passengers who belong to the third class.

select  * 
from    titanic
where   pclass in ( select pclass from titanic where pclass=3 ) ;

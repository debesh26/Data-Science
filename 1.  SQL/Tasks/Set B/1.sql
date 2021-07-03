
--  ----------- Dataset  : Placement  -----------------------------------------------

#1. Display all the students who are placed. 

select  sl_no 
from 	placement
where 	status="Placed" ;


#2. Display total breakup between total no of Male and Female candidates.

SELECT   gender , COUNT(*) as "total" 
from 	 placement
GROUP BY gender ;


#3. Count the number of students who studied in central and other boards in SSC. 

SELECT   ssc_b , COUNT(*) as "total" 
from 	 placement  
GROUP BY ssc_b ;


#4. Display the maximum and minimum scores for the SSC .

select  max(ssc_p) , min(ssc_p) 
from    placement ;


#5. Display the maximum etest scores for people with and without prior work experience.

select  	workex , max(etest_p) 
from 		placement
group by 	workex ;


#6. Get the average percentage scored by students in different mba specialisation.

select 		specialisation , avg(mba_p) 
from 		placement
group by 	specialisation;


#7. WAQ to rank the students based on their ssc and hsc percentages.

select  sl_no , ssc_p , hsc_p ,   rank() over (order by ssc_p desc , hsc_p desc)  as "rank" 
from    placement ;


#8. Among the non placed students, rank them in such an order that  top scorer in e_test gets the 1st rank and so on

select  sl_no , status , etest_p ,   rank() over (order by etest_p desc)  as  "rank"
from    placement
where   status="Not Placed" ;


#9. WAQ to get the maximum and the minimum package offered to the students placed so far.

select max(salary) , min(salary) 
from   placement
where  status="Placed" ;


#10. A placement activity needs the students to be grouped into 10 unique groups.
     -- Divide them into the groups based on the percentage scored in mba and also etest.
     -- Create groups in a such way that the possibility of getting selected should be high 
	 -- And a minimum of 5 groups need to be selected.
     
select * from 
(
	select  sl_no , (mba_p + etest_p)/2 as  combi_p ,  NTILE(10) OVER (ORDER by (mba_p + etest_p)/2 desc)   as  Groupno 
	from    Placement
) a 
where Groupno <= 5 ; 
     

#11. Convert the MBA percentages to percentile ranks, so that the students can refer the rank list 
--   and fill details for competitive exams.

Select  * , p_rank*100 
from  ( 
		select * , percent_rank() over (order by mba_p)  as p_rank 
        from   Placement
	  )a ;


#12. Find the details about the students who lie in the bottom 25 percentile . 
--   Identify them so that a special prep session can be conducted.

Select * , p_rank*100
from  ( 
		select  * , percent_rank() over (order by etest_p)  as p_rank 
        from    Placement
	  )a 
where p_rank*100 <= 25 ;
 

#13. The University has decided to honor special certificates to the top 5 students in each specialisation of mba. 
--   Find the list and details of such students.

Select sl_no , specialisation 
from  
( 
	Select 	sl_no , specialisation , Rank() over (partition by specialisation order by mba_p desc)  as spe_rank 
	from 	Placement
)a 
where spe_rank <= 5 ; 

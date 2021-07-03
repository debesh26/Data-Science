--  ------- Dataset : admission_predict.csv   --------------------------

# Q1. A university is looking for candidates with GRE score between 330 and 340. Also they should be proficient in english 
--    i.e. their Toefl score should not be less than 115. Create a view for this university.

create view GT_Filter_vw as
						 select * from admission_predict
						 where  GRE_Score between 330 and 346   and   TOEFL_Score >= 115 ;


# Q2. Create a view of the candidates with the CGPA greater than the average CGPA.

create View cgpa_more_than_avg_vw as
								  select * from admission predict
								  where cgpa >  ( select avg(cgpa) from admission predict ) ;
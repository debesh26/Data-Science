
-- -------- Dataset  :  Video_Games  -------------------------------

# 1. Find platform and total sales in America for each category of the column "platform".

SELECT     Platform , SUM(NA_Sales)  
FROM 	   Video_Games
GROUP BY   Platform ;



# 2.  Find the name, platform and total sales in America for each category of the column 'platform' as 'Total_Profit' 
-- -- and the total sales in America for all the platforms as 'Platform_Profit'. 
-- -- Also arrange the results in descending order according to the Platform_Profit.

SELECT   Name , Platform ,
		 SUM(NA_Sales) OVER()                        AS  Platform_profit,
		 SUM(NA_Sales) OVER(PARTITION BY Platform)   AS  Total_profit

FROM 	  Video_Games
ORDER BY  platform_profit DESC ;



# 3. Use nonaggregate window functions to produce the row number for each row 
-- --  within its partition (Platform) ordered by release year.

SELECT  Name , Platform , Year_of_Release , Genre ,
		ROW_NUMBER() OVER (PARTITION BY Platform   ORDER BY Year_of_Release DESC)   AS row_num
FROM 	Video_Games ;



# 4. Use aggregate window functions to produce the average global sales of each row within its partition (Year of release). 
-- -- Also arrange the result in the descending order by year of release.
   
SELECT 	  Name  , Platform , Year_of_Release ,  AVG(Global_Sales) OVER(PARTITION BY Year_of_Release)  AS  AvgGlobalSales
FROM      Video_Games
ORDER BY  Year_of_Release DESC ;


# 5. Round off the sales of America, arrange them in descending order and rank the games using RANK() and DENSE_RANK(). 

SELECT  Name , Platform,    ROUND(NA_Sales,0)                  AS  Sales,
		RANK()       OVER ( ORDER BY ROUND(NA_Sales,0) DESC )  AS  RNK,
		DENSE_RANK() OVER ( ORDER BY ROUND(NA_Sales,0) DESC )  AS  Dense_RNK
FROM 	Video_Games ;


use Schemas_2 ;

-- -----------------------------------------------------------------------
select * from Bank_inventory_pricing ;
-- ------------------------------------------------------------------------

# Q1. Print aggregate Purchase_cost and average of estimated_sale_price   during 2nd month . 

Select  sum(Purchase_cost) , avg(estimated_sale_price) 
from    Bank_inventory_pricing     
Where   month = 2 ;


# Q2. Print average of estimated_sale_price with two decimals 

Select convert ( avg(estimated_sale_price) , decimal(6,2) )  
from   Bank_inventory_pricing;


# Q3. Print Products appearing  for more than once during month : 1

Select   	product , count (product) 
from     	Bank_inventory_pricing 
Where 		month = 1 
Group by  	product 
Having    	count(product ) > 1 ;


# Q4. Print Products that are appearing more than once  and whose purchase_cost is greater than 
--    estimated_sale_price , assuming estimated_sale_price is 0 if not updated

Select 		product , count(product) 
from   		Bank_inventory_pricing 
Where  		purchase_cost > ifnull(estimated_sale_price,0)
Group by 	product 
Having   	count(product ) > 1	;



# Q5. Print sum of  purchase_cost  with default value of 2000/-

Select sum ( ifnull(purchase_cost , 2000) ) 
from   Bank_Inventory_pricing;


# Q6. Print unique records without displaying the month.

SELECT     Product ,  Quantity ,  Price ,  purchase_cost ,  Estimated_sale_price 
FROM       Bank_inventory_pricing
group by   Product ,  Quantity ,  Price ,  purchase_cost ,  Estimated_sale_price ;



# Q7. If purchase_cost is not updated then it’s value is equal to estimated_sale_price. 
--    With the above condition, print average of  Purchase_cost. 

SELECT  avg ( coalesce (purchase_cost, estimated_sale_price) )  
from    bank_inventory_pricing ;


# Q8. Print count of unique Products

Select 		count(distinct product) 
from   		Bank_inventory_pricing ;


# Q9. Print product & difference of maximum and minimum purchase_cost of each product.

Select 		product , max(purchase_cost)  - min(purchase_cost)
FROM   		Bank_Inventory_Pricing
GROUP BY	Product;


# Q10. Print aggregate Purchase_cost during 1st and 2nd month 

Select     Month, sum(Purchase_cost ) 
from       Bank_inventory_pricing   
Group by   month ;


# Q11. Print Products with an average value of Purchase_cost per product only when exceeding average of 6000.

Select 		product , avg(purchase_cost) 
from 		Bank_inventory_pricing 
group by 	product 
having 		avg(purchase_cost) > 6000 ;



# Q12. Print  products whose average of purchase_cost is less than sum of purchase_cost   

Select		 product  , avg(purchase_cost) , sum(purchase_cost)
from 		 Bank_inventory_pricing
group by 	 Product
having 		 avg(purchase_cost) < sum(purchase_cost) ;


# Q13. Print product and its average of Estimated_sale_price when  purchase_cost is not mentioned. 

Select  	Product , avg(Estimated_sale_price)  
from    	Bank_inventory_pricing
Where   	purchase_cost  is null 
group by 	Product;



# Q14. Display maximum estimated_sale_price of each product  when the product total quantity is exceeding 4 and 
--     its purchase_cost is not updated. 

SELECT 		Product , MAX(Estimated_sale_price) , sum(Quantity)         	 
FROM 		Bank_inventory_pricing
where 		purchase_cost is not null
GROUP BY 	product
having 		sum(Quantity)  > 4 ;



# Q15. Print products whose average of purchase_cost per product is less than 200    

Select  	Product	, avg(purchase_cost)           
from    	Bank_inventory_pricing
group  by 	Product
having  	ifnull ( avg(purchase_cost), 0 )  < 200 ;



# Q16. Print each Product with its highest estimated_sale_price . 

SELECT 		PRODUCT , MAX(Estimated_Sale_Price)
FROM   		Bank_Inventory_Pricing
GROUP BY 	Product;



# Q17. Print product with an increase in  average of estimated_sale_price  by 15% when average product_cost is more than estimated_sale_price 

SELECT 		Product,  
			AVG (Estimated_sale_price)          as 	org_avg_estimate_price,
			AVG (Estimated_sale_price) * 1.15   as 	new_avg_estimate_price

from 		bank_inventory_pricing
GROUP BY 	Product 
having 		AVG(purchase_cost) 	>  AVG(Estimated_sale_price) ;



# Q18. Calculate average estimated_sale_price for each product . 
--     For any updated estimated_sale_price, replace the value with purchase_cost 

Select    product, avg (ifnull(estimated_sale_price , purchase_cost))  
from      bank_inventory_pricing 
Group by  Product ;



# Q19. Print products and their avg price on condition that products appeared in at least three different months. 

select 		product , avg(price) , count(distinct month) 
from 		bank_inventory_pricing 
Group by 	product 
Having 		count(distinct month) > 2;

-- --------------------------------------------------------------------
# All tables except Bank_inventory_pricing
-- --------------------------------------------------------------------


# Q1. Print customer Id, customer name and average account_balance maintained by each customer for all of his/her accounts in the bank.

Select   	bc.customer_id  , customer_name  ,  avg(ba.Balance_amount)  as All_account_balance_amount
from     	bank_customer         bc  
inner join  Bank_Account_Details  ba
on       	bc.customer_id = ba.Customer_id
group by  	bc.customer_id , bc.customer_name ;



# Q2. Print customer_id , account_number and balance_amount , 
--    condition that if balance_amount is nil then assign transaction_amount  for account_type = "Credit Card"

Select      customer_id , ba.account_number,
			Case 
            when   ifnull(balance_amount,0) = 0   then  Transaction_amount  
            else   balance_amount 
            end    as balance_amount
            
from        Bank_Account_Details ba  
inner join 	bank_account_transaction bat
on          ba.account_number = bat.account_number
and         account_type = "Credit Card";



# Q3. Print customer_id , account_number and balance_amount , 
--    conPrint account number,  balance_amount, transaction_amount from Bank_Account_Details and bank_account_transaction 
--    for all the transactions occurred during march,2020 and april, 2020

Select      ba.Account_Number, Balance_amount, Transaction_amount, Transaction_Date
from    	Bank_Account_Details ba  
inner join  bank_account_transaction bat
on      	ba.account_number = bat.account_number
And     	( Transaction_Date between "2020-03-01" and "2020-04-30" ) ;



# Q4:
-- Print all of the customer id, account number,  balance_amount, transaction_amount 
-- from bank_customer, Bank_Account_Details and bank_account_transaction tables 
-- where excluding all of their transactions in march 2020

Select  	ba.Customer_id , ba.Account_Number , Balance_amount , Transaction_amount , Transaction_Date
from    	Bank_Account_Details ba  
Left join  	bank_account_transaction bat
on      	ba.account_number = bat.account_number
And NOT 	( date_format(Transaction_Date , '%Y-%m') = "2020-03" );


# Q5:
-- Print only the customer id, customer name, account_number, balance_amount who did transactions during the first quarter. 
-- Do not display the accounts if they have not done any transactions in the first quarter.

Select   	ba.Customer_id , ba.Account_Number, Balance_amount , transaction_amount , transaction_date 
from     	Bank_Account_Details ba  
Inner join 	bank_account_transaction bat
on       	ba.account_number = bat.account_number
And      	( date_format(Transaction_Date , '%Y-%m') <= "2020-03" );


# Q6:
-- Print account_number, Event, Customer_message from BANK_CUSTOMER_MESSAGES and Bank_Account_Details 
-- to display an “Adhoc" Event for all customers who have  “SAVINGS" account_type account.

SELECT   	Account_Number, Event , Customer_message 
FROM      	Bank_Account_Details  
CROSS JOIN  BANK_CUSTOMER_MESSAGES 
ON        	Event = "Adhoc"  
And       	ACCOUNT_TYPE = "SAVINGS" ;


# Q7:
-- Print Customer_id, Account_Number, Account_type, and display deducted balance_amount by  
-- subtracting only negative transaction_amounts for Relationship_type = "P" ( P - means  Primary , S - means Secondary )

SELECT   	ba.Customer_id , ba.Account_Number,   (Balance_amount + IFNULL(transaction_amount, 0))   AS   deducted_balance_amount
FROM     	Bank_Account_Details       ba 
LEFT JOIN 	bank_account_transaction   bat 
ON       	ba.account_number = bat.account_number 
AND      	Relationship_type = "P"	;


# Q8:
--  Display records of All Accounts , their Account_types, the transaction amount.
--  Along with first step, Display other columns with corresponding linking account number, account types 

SELECT  br1.Account_Number    primary_account ,
    	br1.Account_type      primary_account_type,
    	br2.Account_Number    Seconday_account,
    	br2.Account_type      Seconday_account_type

FROM    bank_account_relationship_details   br1  LEFT JOIN    bank_account_relationship_details   br2
ON      br1.account_number = br2.linking_account_number;


# Q9:
--   Display records of All Accounts , their Account_types, the transaction amount.
--   Along with first step, Display other columns with corresponding linking account number, account types 
--   After retrieving all records of accounts and their linked accounts, display the  transaction amount of accounts appeared  in another column.

SELECT 		br1.Account_Number       primary_account_number ,
			br1.Account_type      	 primary_account_type,
			br2.Account_Number    	 secondary_account_number,
			br2.Account_type      	 secondary_account_type,  
			bt1.Transaction_amount   primary_acct_tran_amount
            
from   		bank_account_relationship_details   br1   LEFT JOIN   bank_account_relationship_details   br2
on     		br1.Account_Number = br2.Linking_Account_Number

LEFT JOIN  bank_account_transaction  bat
on         br1.Account_Number  = bat.Account_Number;


# Q10. Display all saving account holders have “Add-on Credit Cards" and “Credit cards" 

SELECT  
		br1.Account_Number     primary_account_number ,
		br1.Account_type       primary_account_type,
		br2.Account_Number     secondary_account_number,
		br2.Account_type       secondary_account_type
        
from          bank_account_relationship_details  br1   
INNER JOIN    bank_account_relationship_details  br2
on            br1.Account_Number = br2.Linking_Account_Number
and           br2.Account_type like '%Credit%' ;

# Q11:
-- Display  records of “SAVINGS” account linked with “Credit cards" account_type and its credit aggregate sum of transaction amount. 

Select
		br1.Account_Number  		 Primary_account_number,
		br1.Account_type			 Primary_account_type,
		br2.Account_Number  		 Secondary_account_number,
		br2.Account_type			 Secondary_account_type,
		sum(bt2.Transaction_amount)  Secondary_account_transaction_amount
    
FROM  	bank_account_relationship_details br1  JOIN   bank_account_relationship_details br2
ON    	br1.Account_Number   = br2.Linking_Account_Number
AND   	br2.Account_type     = 'Credit Card'    

JOIN  	bank_account_transaction bt2
on    	bt2.Account_Number = br2.Account_Number

group by   br1.Account_Number , br1.Account_type , br2.Account_Number , br2.Account_type ;


# Q12:
# Compare the aggregate transaction amount of current month versus aggregate transaction with previous months.
# Display account_number, transaction_amount , 
-- sum of current month transaction amount ,
-- current month transaction date , 
-- sum of previous month transaction amount , 
-- previous month transaction date.
 
 
SELECT
			bt1.account_Number                            Primary_account_number,
			date_format(bt2.Transaction_Date , '%Y-%m')   next_month_transaction_date,
			sum(bt2.Transaction_amount)                   current_month_cr_tran,
			sum(bt1.Transaction_amount)                   prev_month_cr_tran,
			date_format(bt1.Transaction_Date , '%Y-%m')   previous_month_transaction_date

FROM   		bank_account_transaction  bt2 
JOIN 		bank_account_transaction  bt1
on     		bt2.Account_Number = bt1.Account_Number
and    		date_format(bt2.Transaction_Date , '%Y-%m') > date_format(bt1.Transaction_Date , '%Y-%m')

group by 	bt2.account_Number, date_format(bt2.Transaction_Date , '%Y-%m') ,  date_format(bt1.Transaction_Date , '%Y-%m')	;


# Q13:
-- Display individual accounts absolute transaction of every next  month is greater than the previous months .
 

SELECT
		bt2.account_Number  		 Primary_account_number,
		sum(bt2.Transaction_amount)  current_month_tran,
		bt2.Transaction_Date 		 CURRENT_tran_date,
		sum(bt1.Transaction_amount)  prev_month_tran,
		bt1.Transaction_Date 		 prev_tran_date
        
FROM 	bank_account_transaction bt2 
JOIN 	bank_account_transaction bt1
on 		bt2.Account_Number = bt1.Account_Number
and 	bt2.Transaction_Date > bt1.Transaction_Date

group by  bt2.account_Number , bt2.Transaction_Date , bt1.Transaction_Date
HAVING    abs(sum(bt2.Transaction_amount)) > abs(sum(bt1.Transaction_amount));


# Q14:
-- Find the no. of transactions of credit cards including add-on Credit Cards

SELECT
		br1.Account_Number 				credit_card_account_number,
		br1.Account_type   				credit_card_account_type,
		count(bat.transaction_amount)   count_of_Transaction_amount

FROM   		bank_account_relationship_details   br1  
LEFT JOIN  	bank_account_relationship_details   br2
ON     		br1.Account_Number  =  br2.Linking_Account_Number

JOIN 		bank_account_transaction   bat
ON   		br1.Account_Number = bat.Account_Number
and  		br1.Account_type   like '%Credit%'

group by  	br1.Account_Number , br1.Account_type ;
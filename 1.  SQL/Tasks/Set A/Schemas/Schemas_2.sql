
Create Database Schemas_2 ;
use Schemas_2 ;

Create table Bank_Inventory_pricing ( 
										Product   				CHAR(15) ,
										Quantity    			INT, 
										Price     				Real ,
									    purchase_cost         	Decimal(6,2), 
										Estimated_sale_price  	Float,
										Month                 	int
									) ;

 Insert into Bank_Inventory_pricing values  ( 'PayCard' , 2 , 300.45, 8000.87, 9000.56, 1 ) , ( 'PayCard' , 2 , 800.45, 5000.80, 8700.56, 1 ) , ( 'PayCard' , 2 , 500.45, 6000.47, 7400.56, 1 ) , ('PayPoints' , 4 , 390.87, 7000.67, 6700.56, 2 )  , ( 'SmartPay' , 5  , 290.69, 5600.77, 3200.12 , 1) ,( 'MaxGain',    3 , NULL, 4600.67, 3233.11 , 1 )  ,  ( 'MaxGain',   6 , 220.39, 4690.67, NULL , 2 )   ,  ( 'SuperSave', 7 , 290.30, NULL, 3200.13 ,1 )   ,  ( 'SuperSave', 6 , 560.30, NULL, 4200.13 ,1 )   ,  ( 'SuperSave', 6 , NULL, 2600.77, 3200.13 ,2 )  ,  ( 'SuperSave', 9 , NULL, 5400.71, 9200.13 ,3 )  , ( 'SmartSav',   3 , 250.89, 5900.97, NULL ,1 ) , ( 'SmartSav',   3 , 250.89, 5900.97, 8999.34 ,1 ) , ( 'SmartSav',   3 , 250.89, NULL , 5610.82 , 2 ) ,( 'EasyCash',   3 , 250.89, NULL, 5610.82 ,1 ) ,( 'EasyCash',   3 , 250.89, NULL, 5610.82 , 2 ) , ( 'EasyCash',   3 , 250.89, NULL, 5610.82 , 3 ) ,( 'BusiCard'  ,  1, 3000.99 , NULL, 3500, 3) , ( 'BusiCard'  ,  1, 4000.99 , NULL, 3500, 2)  ; 
 
 
CREATE TABLE BANK_CUSTOMER ( 
								customer_id 	INT ,
								customer_name 	VARCHAR(20),
								Address 		VARCHAR(20),
								state_code  	VARCHAR(3) ,    	 
								Telephone   	VARCHAR(10)	
							);
                
INSERT INTO BANK_CUSTOMER VALUES  (123001,"Oliver", "225-5, Emeryville", "CA" , "1897614500") , (123002,"George", "194-6,New brighton","MN" , "1897617000") , (123003,"Harry", "2909-5,walnut creek","CA" , "1897617866") , (123004,"Jack", "229-5, Concord",  "CA" , "1897627999") , (123005,"Jacob", "325-7, Mission Dist","SFO", "1897637000") , (123006,"Noah", "275-9, saint-paul" ,  "MN" , "1897613200") , (123007,"Charlie","125-1,Richfield",   "MN" , "1897617666") , (123008,"Robin","3005-1,Heathrow", "NY" , "1897614000")  ; 
                                   


CREATE TABLE BANK_CUSTOMER_EXPORT ( 
									customer_id 	CHAR(10),
									customer_name 	CHAR(20),
									Address 		CHAR(20),
									state_code  	CHAR(3),    	 
									Telephone  		CHAR(10)  
								  );
    
INSERT INTO BANK_CUSTOMER_EXPORT VALUES  ("123001 ","Oliver", "225-5, Emeryville", "CA" , "1897614500")  , ("123002 ","George", "194-6,New brighton","MN" , "189761700")  ;


CREATE TABLE Bank_Account_Details	(
										Customer_id 		INT,           	 
										Account_Number 		VARCHAR(19),
										Account_type 		VARCHAR(25),
										Balance_amount 		INT,
										Account_status 		VARCHAR(10),             	 
										Relationship_type 	Varchar(1) ) ;
                                
INSERT INTO Bank_Account_Details  VALUES  ( 123001, "4000-1956-3456",  "SAVINGS" , 200000 ,"ACTIVE","P") , (123001, "5000-1700-3456", "RECURRING DEPOSITS" ,9400000 ,"ACTIVE","S") ,  (123002, "4000-1956-2001",  "SAVINGS", 400000 ,"ACTIVE","P") , (123002, "5000-1700-5001",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S") , (123003, "4000-1956-2900",  "SAVINGS" ,750000,"INACTIVE","P") ,(123004, "5000-1700-6091", "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S") ,(123004, "4000-1956-3401",  "SAVINGS" , 655000 ,"ACTIVE","P") ,(123005, "4000-1956-5102",  "SAVINGS" , 300000 ,"ACTIVE","P") ,(123006, "4000-1956-5698",  "SAVINGS" , 455000 ,"ACTIVE" ,"P") ,(123007, "5000-1700-9800",  "SAVINGS" , 355000 ,"ACTIVE" ,"P") ,(123007, "4000-1956-9977",  "RECURRING DEPOSITS" , 7025000,"ACTIVE" ,"S") ,(123007, "9000-1700-7777-4321",  "Credit Card"	,0  ,"INACTIVE", "P") ,(123007, '5900-1900-9877-5543', "Add-on Credit Card" ,   0   ,"ACTIVE", "S") , (123008, "5000-1700-7755",  "SAVINGS"  , 0   ,"INACTIVE","P") , (123006, '5800-1700-9800-7755', "Credit Card"   , 0  ,"ACTIVE", "P") , (123006, '5890-1970-7706-8912', "Add-on Credit Card"   , 0   ,"ACTIVE", "S")  ;



CREATE TABLE Bank_Account_Relationship_Details (
													Customer_id 			INT,
													Account_Number 			VARCHAR(19),
													Account_type 			VARCHAR(25),
													Linking_Account_Number 	VARCHAR(19)		);
                                

INSERT INTO Bank_Account_Relationship_Details  VALUES  (123001, "4000-1956-3456",  "SAVINGS" , "") , (123001, "5000-1700-3456",  "RECURRING DEPOSITS" , "4000-1956-3456"),  (123002, "4000-1956-2001",  "SAVINGS" , "" ),(123002, "5000-1700-5001",  "RECURRING DEPOSITS" , "4000-1956-2001" ),(123003, "4000-1956-2900",  "SAVINGS" , "" ),(123004, "5000-1700-6091",  "RECURRING DEPOSITS" , "4000-1956-2900" ),(123004, "5000-1700-7791",  "RECURRING DEPOSITS" , "4000-1956-2900" ),(123007, "5000-1700-9800",  "SAVINGS" , "" ),(123007, "4000-1956-9977",  "RECURRING DEPOSITS" , "5000-1700-9800" ),(NULL, "9000-1700-7777-4321",  "Credit Card" , "5000-1700-9800" ),(NULL, '5900-1900-9877-5543', 'Add-on Credit Card', '9000-1700-7777-4321' ),(NULL, '5800-1700-9800-7755', 'Credit Card', '4000-1956-5698' ),(NULL, '5890-1970-7706-8912', 'Add-on Credit Card', '5800-1700-9800-7755' )  ;



CREATE TABLE BANK_ACCOUNT_TRANSACTION (  
											Account_Number 		 VARCHAR(19),
											Transaction_amount 	 Decimal(18,2) ,
											Transcation_channel  VARCHAR(18) ,
											Province 			 varchar(3) ,
											Transaction_Date 	 Date           
									  ) ;

INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES  ( "4000-1956-3456",  -2000,  "ATM withdrawl" , "CA", "2020-01-13" ) , ( "4000-1956-2001",  -4000, 	"POS-Walmart"  , "MN", 	"2020-02-14" ) , ( "4000-1956-2001",  -1600, "UPI transfer"  , "MN", "2020-01-19") , ( "4000-1956-2001",  	-6000, 		"Bankers cheque", 	"CA", 	"2020-03-23") , ( "4000-1956-2001",  	-3000, 		"Net banking"   , 	"CA", 	"2020-04-24"	),( "4000-1956-2001",  	23000, 		"cheque deposit", 	"MN", 	"2020-03-15"	),( "5000-1700-6091",  	40000, 		"ECS transfer"  , 	"NY", 	"2020-02-19"	),( "5000-1700-7791",  	40000, 		"ECS transfer"  , 	"NY", 	"2020-02-19"	),( "4000-1956-3401",   	8000, 		"Cash Deposit"  , 	"NY", 	"2020-01-19"	),( "4000-1956-5102",  	-6500, 		"ATM withdrawal" , 	"NY", 	"2020-03-14"	),( "4000-1956-5698",  	-9000, 		"Cash Deposit"  , 	"NY", 	"2020-03-27"	),( "4000-1956-9977",  	50000, 		"ECS transfer"  , 	"NY", 	"2020-01-16"	),( "9000-1700-7777-4321",  -5000, 	"POS-Walmart", 		"NY", 	"2020-02-17"	),( "9000-1700-7777-4321",  -8000, 	"Shopping Cart", 	"MN", 	"2020-03-13"	),( "9000-1700-7777-4321",  -2500, 	"Shopping Cart", 	"MN", 	"2020-04-21"	),( "5800-1700-9800-7755", -9000, 	"POS-Walmart",		"MN", 	"2020-04-13"	),( '5890-1970-7706-8912', -11000, 	"Shopping Cart" , 	"NY" , 	"2020-03-12"	),('4000-1956-9977' ,    10000.00     ,'ECS transfer',     'MN' ,    '2020-02-16' ) ,  ('4000-1956-9977' ,    40000.00     ,'ECS transfer',     'MN' ,    '2020-03-18' ) ,('4000-1956-9977' ,    60000.00     ,'ECS transfer',     'MN' ,    '2020-04-18' ) ,('4000-1956-9977' ,    20000.00     ,'ECS transfer',     'MN' ,    '2020-03-20' ) ,('4000-1956-9977' ,    49000.00     ,'ECS transfer',     'MN' ,    '2020-06-18' ) ;


CREATE TABLE BANK_CUSTOMER_MESSAGES (  
										Event 					VARCHAR(24),
										Customer_message 		VARCHAR(75),
										Notice_delivery_mode 	VARCHAR(15)		
									) ;


INSERT INTO BANK_CUSTOMER_MESSAGES  VALUES ( "Adhoc"             ,  "All Banks are closed due to announcement of National strike", "mobile" ) ;
INSERT INTO BANK_CUSTOMER_MESSAGES  VALUES ( "Transaction Limit" ,  "Only limited withdrawals per card are allowed from ATM machines", "mobile" ) ;




CREATE TABLE BANK_INTEREST_RATE	(  
									account_type 	varchar(24),
									interest_rate 	decimal(4,2),
									month 			varchar(2),
									year  			varchar(4)		
								);

INSERT  INTO BANK_INTEREST_RATE VALUES  ( "SAVINGS" , 0.04 , '02' , '2020' ) ,  ( "RECURRING DEPOSITS" , 0.07, '02' , '2020' ) ,   ( "PRIVILEGED_INTEREST_RATE" , 0.08 , '02' , '2020' )  ;


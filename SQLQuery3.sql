use [bank loan db];
select *from bank_loan_data;


                   /* ------------------- DASHBOARD-1 ---------------*/

-- QUES1:- TOTAL LOAN APLICATION

select COUNT(id) from bank_loan_data                              -- find the total application
select COUNT(id) AS total_loan_application from bank_loan_data    --create alias of column and find the total application


/*
select  home_ownership,
COUNT(id) AS total_loan_application from bank_loan_data    -- find ownership wise total loan application 
group by home_ownership 

select  home_ownership,
COUNT(id) AS total_loan_application from bank_loan_data    --find ownership wise total loan application by order
group by home_ownership 
order by total_loan_application desc
*/


 -- QUES1(a) :- here we find a specific month total loan application 
 select count(id) MTD_total_loan_month from bank_loan_data      -- MTD = MONTH TO DATE (this denote current month date )
 where MONTH(issue_date)=12 and YEAR(issue_date) = 2021          -- if we have multiple year then we specify year condtion clause

 -- QUES1(b):-
 select count(id) PMTD_total_loan_month from bank_loan_data      -- PMTD = PREVIOUS MONTH TO DATE
 where MONTH(issue_date)=11 and YEAR(issue_date) = 2021          -- if we have multiple year then we specify year condtion clause

 -- MoM =  (Current Month Value - Previous Month Value) / Previous Month Value) 
 -- MoM =  (Current Month Value - Previous Month Value) / Previous Month Value) * 100 {if we want percentage add *100}



 -- QUES2 :- TOTAL FUNDED AMOUNT
 select SUM(loan_amount) as TOTAL_FUNDED_AMOUNT from bank_loan_data

 -- QUES2(a) :- TOTAL FUNDED AMOUNT
 select SUM(loan_amount) as MTD_TOTAL_FUNDED_AMOUNT from bank_loan_data           -- MTD = MONTH TO DATE (this denote current month date )
 where MONTH(issue_date)=12 and YEAR(issue_date)=2021


 -- QUES2(b) :- TOTAL FUNDED AMOUNT
 select SUM(loan_amount) as PMTD_TOTAL_FUNDED_AMOUNT from bank_loan_data           -- PMTD = PREVOIUS MONTH TO DATE (this denote current month date )
 where MONTH(issue_date)=11 and YEAR(issue_date)=2021


 -- QUES 3:- TOTAL AMOUNT RECIVED
 select SUM(total_payment) as TOTAL_AMOUNT_RECIVED from bank_loan_data


 -- QUES 3(a):-
 select SUM(total_payment) as MTD_TOTAL_AMOUNT_RECIVED from bank_loan_data
 where MONTH(issue_date)=12 and YEAR(issue_date)=2021

 -- QUES 3(b):-
 select SUM(total_payment) as PMTD_TOTAL_AMOUNT_RECIVED from bank_loan_data
 where MONTH(issue_date)=11 and YEAR(issue_date)=2021


-- QUES 4:- AVERAGE INTREST RATE
select AVG(int_rate)as AVERAGE_INTREST_RTAE from bank_loan_data

select AVG(int_rate)*100 as AVERAGE_INTREST_RTAE from bank_loan_data    -- if we want percentage  use *100

select ROUND( AVG(int_rate),2) *100 as AVERAGE_INTREST_RTAE from bank_loan_data      -- if we want round value 2 decimal places 

-- QUES 4(a):-
select ROUND( AVG(int_rate),5) *100 as MTD_AVERAGE_INTREST_RTAE from bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

-- QUES 4(b) :-
select ROUND( AVG(int_rate),5) *100 as PMTD_AVERAGE_INTREST_RTAE from bank_loan_data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021



-- QUES 5:- AVERAGE DEBT-TO_ INCOME RATIO (DTI)
select AVG(dti) *100 as AVG_DTI from bank_loan_data

select ROUND( AVG(dti),5) *100 as AVG_DTI from bank_loan_data

-- QUES 5(a)
select ROUND( AVG(dti),5) *100 as AVG_DTI from bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) = 2021

-- QUES 5(b):-
select ROUND( AVG(dti),5) *100 as PMTD_AVG_DTI from bank_loan_data
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021


									/* GOOD LOAN  */
		--	good loan is that "fully paid" and "current" a cording to data sheet
		
select loan_status from bank_loan_data

-- QUES 6 good loan
select
	(COUNT(case when loan_status = 'Fully Paid' or loan_status = 'current' then id end)*100)
	/
	COUNT(id) as GOOD_LOAN_PERCENTAGE
from bank_loan_data

-- QUES 6(a) find GOOD_LOAN_APPLICATION
select COUNT(id) as GOOD_LOAN_APPLICATION from bank_loan_data
where loan_status ='Fully Paid' or loan_status='current'

--QUES 6(b) good loan funded
select SUM(loan_amount) as GOOD_LOAN_FUNDED from bank_loan_data
where loan_status ='Fully Paid' or loan_status='current'

--QUES 6(c) Good Loan Total Received Amount
select SUM(total_payment) as GOOD_LOAN_TOTAL_RECEIVED from bank_loan_data
where loan_status ='Fully Paid' or loan_status='current'


-- QUES 7 BAD LOAN
select COUNT(loan_status) from bank_loan_data
where loan_status= 'charged off'

-- QUES 7(a) bad loan percentage
select
	(COUNT(case when loan_status = 'charged off' then id END) * 100.0)/
	COUNT(id) as BAD_LOAN_PERCANTAGE
	from bank_loan_data


-- QUES 7(B) total bad loan  application 
select COUNT(id) as BAD_LOAN_APPLICATION  from bank_loan_data
where loan_status='charged off'

-- QUES 7(c) total bad loan amount
select
SUM(loan_amount)as BAD_LOAN_funded from bank_loan_data
where loan_status='charged off'

-- QUES 7(d) bad loan amount recived 
select sum(total_payment)from bank_loan_data
where loan_status='charged off'


-- QUES 8 LOAN STATUS GRID VIEW
select 
		loan_status,
		COUNT(id) as Total_loan_application,
		sum(total_payment) as Total_amount_recived,
		sum(loan_amount) as total_funded_amount,
		avg(int_rate*100) as Intrest_Rate,
		avg(dti*100) as DTI
	from bank_loan_data
	group by loan_status

-- QUES 8(a) MTD(Month to Date )
select 
		loan_status,
		sum(total_payment) as MTD_Total_amount_recived,
		sum(loan_amount) as MTD_total_funded_amount
	from bank_loan_data
	where MONTH(issue_date)=12
	group by loan_status


	/* ----------------- DASHBOARD 2 ------------------------*/
-- QUES 1 MONTHLY TRANDES BY ISSUE DATE
select
	MONTH(issue_date) as MONTH_NUMBER,
	DATENAME(month,issue_date) as MONTH_NAME,
	COUNT(id) as TOTAL_LOAN_APPLICATION,
	SUM(loan_amount) as TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) as TOTAL_RECEIVED_AMOUNT
from bank_loan_data
GROUP BY MONTH(issue_date),DATENAME(month,issue_date)
ORDER BY MONTH(issue_date)

--QUES 2 REGIONAL ANALYSIS BY STATE 

SELECT
	address_state,
	COUNT(id) as TOTAL_LOAN_APPLICATION,
	SUM(loan_amount) as TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) as TOTAL_RECEIVED_AMOUNT
from bank_loan_data
GROUP BY address_state
ORDER BY COUNT(id) desc

--QUES 3 LOAN TERM ANALYSIS 

select 
	term,
	count(id) as TOTAL_LOAN_APPLICATION,
	SUM(loan_amount) as TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) as TOTAL_RECEVIED_AMOUNT
from bank_loan_data
GROUP BY term
ORDER BY term

-- QUES 4 EMPLOYE LENGHTH ANALYSIS 

select
	emp_length as EMP_LENGHTH,
	COUNT(id) as TOTAL_LOAN_APPLICATION,
	SUM(loan_amount) as TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) as TOTAL_RECEIVED_AMOUNT
from bank_loan_data
GROUP BY emp_length
order by emp_length


-- QUES 5 LOAN PURPOSE BREAKDOWN 
select
	purpose as PURPOSE,
	COUNT(id) as TOTAL_LAON_APPLICATION,
	SUM(loan_amount) as TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) as TOTAL_RECEIVED_AMOUNT
from bank_loan_data
group by purpose
order by COUNT(id) desc


-- QUES 6 HOME OWNERSHIP ANALYSIS
select 
	home_ownership,
	COUNT(id) as TOTAL_LOAN_APPLICATION ,
	SUM(loan_amount) as TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) as TOTAL_REICVED_AMOUNT
FROM bank_loan_data
GROUP BY home_ownership
order by COUNT(id) desc

                      /*----------- DASHBOARD 3 -----------*/

-- QUES 1- GRADE WISE OWNERSHIP
select 
	home_ownership,
	-- COUNT(id) as TOTAL_LOAN_APPLICATION ,
	COUNT(grade) as GRADE,
	SUM(loan_amount) as TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) as TOTAL_REICVED_AMOUNT
FROM bank_loan_data
where grade='A'
GROUP BY home_ownership
order by COUNT(grade) desc

-- QUES 1(a)
select 
	home_ownership,
	-- COUNT(id) as TOTAL_LOAN_APPLICATION ,
	COUNT(grade) as GRADE,
	SUM(loan_amount) as TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) as TOTAL_REICVED_AMOUNT
FROM bank_loan_data
where grade='A' and address_state='CA'
GROUP BY home_ownership
order by COUNT(grade) desc
 


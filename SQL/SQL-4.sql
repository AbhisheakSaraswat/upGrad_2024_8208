/* Common Table Expression
CTEs are defined by 'with' clause, they are storing
temporary result that exist only for the duration of the
execution of your query.
We can not apply any indexes or constraint over the CTEs
*/

With YourCteName as
(
	-- YourQuery
)
Select * from YourCteName;
With Rank_Analytical As
(
Select FirstName, LastName, Occupation, YearlyIncome,
Rank() Over (partition by occupation order by YearlyIncome)
as NormalRank From EmployeeDb
)
Select * from Rank_Analytical Where NormalRank = 3;
With FilteredSales As
(
with MySales as
(
Select Region, Segment, Year(OrderDate) as SalesYear, sum(Sales) as TotalSales
From SuperStore
Where year(OrderDate) = 2016
Group by Region, Segment, SalesYear
) Select * from MySales 
Where Region in ('South','East') and TotalSales > 50000
) Select * from FilteredSales;

/* Temporary Table:
A temp table is only accessed when Your sql connection is created.
A temp table is automatically removed from the system when the session terminated
in mysql.
*/

Create Temporary Table SummaryTable
Select *, dense_rank() over (partition by occupation order by Yearlyincome desc) as
dRank from EmployeeDB;

Select * from summaryTable;


Create temporary table Testing
Select * from EmployeeDb Where Sales > 4000;

Select * from Testing;

Create temporary table Temp_Emp
(
	EmpID int auto_increment primary key,
    EmpName varchar(20),
    State varchar(10)
);
insert into temp_emp (empName, state)
values ('Abhishek','UP'),('Abhinav','MP'),('Saransh','HP');

Select * from Temp_Emp;

-- Case Statement
Select * from Superstore;

SELECT OrderID,CustomerName,Region,Category,Sales,
    CASE
        WHEN Sales BETWEEN 0 AND 500 THEN 'Sales 0 - 500'
        WHEN Sales > 500 AND Sales <= 1000 THEN 'Sales 500 - 1000'
        WHEN Sales > 1000 AND Sales <= 5000 THEN 'Sales 1000 - 5000'
        ELSE 'Sales > 5000'
    END AS 'SalesBucket'
FROM
    Superstore;
-- Can you Find How many Customer with Alpha A, M, H, Z and Others

With SalesBucket_CTE As
(
	SELECT OrderID,CustomerName,Region,Category,Sales,
    CASE
        WHEN Sales BETWEEN 0 AND 500 THEN 'Sales 0 - 500'
        WHEN Sales > 500 AND Sales <= 1000 THEN 'Sales 500 - 1000'
        WHEN Sales > 1000 AND Sales <= 5000 THEN 'Sales 1000 - 5000'
        ELSE 'Sales > 5000'
    END AS 'SalesBucket'
FROM
    Superstore

) Select SalesBucket, Count(*) as EachBucket From SalesBucket_CTE 
Group by SalesBucket;

With MyCte As
(
	SELECT OrderID,CustomerName,Region,Category,Sales,
    CASE
		When CustomerName Like 'A%' then 'Customer_A'
		When CustomerName Like 'M%' then 'Customer_M'
		When CustomerName Like 'H%' then 'Customer_H'
		When CustomerName Like 'Z%' then 'Customer_Z'
	ELSE 'OtherChar' End as CustomerNameWithAlpha
	From Superstore
) Select CustomerNameWithAlpha, count(*) as CountofCust 
From MYCTE Group by CustomerNameWithAlpha;

Select count(*) as A From Superstore Where CustomerName Like 'A%';

-- ---------------------------------------------

Select Statement
Where Clause
Order Clause
In, and, or, not, not in, exists, not exists, between, not between
group by (sql agg)
having

SQL Aggregated Functions:
sum, max, min, std, count, avg etc with group by and having clause

SQL Joins and Windows Function and SQL Analytical Function, Case When

-- Temp, TempTable, CTE, Sub-Query, sub-co-related Query
-- Stored Procedure and Functions


-- If : if(condition, Truepart, FalsePart)
Select Category, SubCategory, ProductID, Quantity,
if (Quantity > 0 ,'In-Stock','OutOfStock') as StatusofStock
From Superstore
Order by Quantity;

Select Distinct Region,
If (Region = 'West', 1, If(Region = 'South',2,If(Region='Central',3,4))) as RegionStatus
From Superstore;
/*

What If My first table contains null value when I am joining the data (what will happen)
What if My both table contains null values in my On parameter, then what will bhe output.
I have 1 table where we have 10 recs, and 4 records are null and in the 2nd table
I have 12 recs with 2 null value, I want to perform Inner Join, LeftJoin,
Right Join, Cross Join and Full OuterJoin -> How many rows will come?
*/

--  How we can create the User Defined Function in SQL
/* SQL allows users to crate custom function, which can be reused in 
multiple queries if needed, this is helpful for operations that are not
supported by built-in functions.

Note: 
1. Use the create function statement
2. Define the input parameters, the return type and the logic within the 
function.
3. Once created, the function can called in any query.
*/
Delimiter $$
Create Function Calc_Income_Tax(income int)
Returns Decimal(10,2)
deterministic
Begin
	Declare tax decimal(10,2) default 0.00;
	If income <= 500000 THEN 
		set tax = income * 0.05;
	elseif income <= 1000000 THEN 
		set tax = (500000 * 0.05) + ((income - 500000) * 0.10);
	else
		set tax = (500000 * 0.05) + (500000 * 0.10) + ((income - 1000000) * 0.15);
	end if;
    RETURN tax;
End $$
Delimiter ;

Select * from EmployeeDb;
Select *, Calc_Income_Tax(YearlyIncome) as tax_amount
From EmployeeDB;

Select Calc_Income_Tax(2500000) as Tax_Amount;

/* Stored Procedure:
SP is pre-compiled set of sql statements that can be executed on demand.
Sp are great for executing complex operations, as they accept parameters
and can include multiple sql statements within them

Note: They do not always return values (unlike functions), but they can
return result sets.
They can perform action such modifying data or processing task on the server.
*/

Delimiter $$
Create procedure getValues(In occptn varchar(20), in income decimal(10,2))
Begin
	Select FirstName, Education, Occupation, Grade, yearlyincome, Sales
    From EmployeeDB
    Where Occupation = occptn and Yearlyincome >= income;
End $$
Delimiter ;

Call getValues('Professional',40000);


Delimiter $$
Create procedure GetOrdersByRegionCategoryProfit
(In p_region varchar(20),
in p_category varchar(20),
in p_min_profit decimal(10,2)
)
Begin

	Select OrderID, OrderDate, shipmode, city, state, customerName,
    region, category, sales, profit, quantity
    from superstore
    Where Region = p_region
    and category = p_category
    and profit >= p_min_profit;
End $$
Delimiter ;

call GetOrdersByRegionCategoryProfit('South','Furniture',400)


-- Difference between UDF and SP




























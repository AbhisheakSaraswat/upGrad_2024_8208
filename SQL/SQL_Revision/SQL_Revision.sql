Select * from Superstore;
RENAME TABLE  EmployeeData TO Employee_Data;

-- How to rename the column and its type
Alter Table Superstore CHANGE Column OrderDate Order_date date;

create table testing
(
	Empid varchar(10),
    EmpName varchar(20)
);

Alter Table Testing add primary key (EmpID);

Alter Table TableName Add Foreign Key (columnName) references
AnotherTableName (ColumnName);

Alter Table Testing Drop Primary key;

/* Unique Constraint:

Unique constraint will ensures that all value should be unique in the column.
All the values should be distinct in that column.
You can multiple unique key column in a single table. A unique kye;s column
can have only single null (In MS SQL)
Where as we can insert multiple null value in a same column.
*/

Alter table Testing Add constraint UK_Testing unique(empID);

Insert into Testing(EmpID,EmpName)
values (null,'Abhishek');

Create table Testing1
(
	id int
);

alter table testing1 add constraint ukTesting1 unique(id);

insert into testing1(id)
values(null);

Select * from testing1;


Alter Table Testing1 Add Check (ID >= 101 and ID <= 500);

insert into testing1(id)
values(501);

Alter Table Company Add Check(Age >= 18 and Age <= 59);
Alter Table Company Add check(Salary >=350000);
Alter Table Company Add check(City = "Delhi");

Alter Table TableName Add Constraint Check_for_city Check
(city = 'Delhi');

Alter Table TableName Drop Check Check_for_city;

/* View in MySQL

A View is a virtual table that is based on the result of your sql query.
Your view is just a mirror of your data and it does not store data physically.

Simplying Queries:
Whenever you are applying Joins, SubQueries and SQL Aggregations etc
then you can only view the data (You can not change anything in View),
WhereAs, If you are not using Joins,SubQueries,Aggreagations etc then you
can change the view and if view changes which means my main table data
changes.

Enhance Security: View can be restrict to the specific column or row of a table.
They can not access main data directly.

Reusability: User can store the complex query result into the view for furture reference.

*/

Select * from EmployeeDB;
Create View Employee_View
As
Select FirstName, LastName, Occupation, Grade, Sales
From EmployeeDB
Where Sales > 3000;

Select * from Employee_View;

Select count(*) as DgradeEmployee from EmployeeDb
Where Grade = 'D'; -- 5;

Select * from Employee_View
Where Grade ='D';

Delete from Employee_View Where Grade = 'D';

Set SQL_Safe_Updates = 0;

Select * from EmployeeDB;

Create View view_EmployeeSales
As
Select Education, Occupation, Grade, sum(Sales) as TotalSales
From employeedb
group by Education, Grade, Occupation;

Select * from  view_employeesales;

Delete From View_employeessales 
Where Grade = 'D';

Select * from Employee_view;

Select * from EmployeeDB
Where Occupation = 'Management' and Grade = 'A';

update Employee_view
Set Sales = 9999
Where Occupation = 'Management' and Grade = 'A';

Select * from  view_employeesales
Where Occupation = 'Management' and Grade = 'A';

Create View view_Employee
As
Select * from EmployeeDB
Where Sales < 
(Select Sales from EmployeeDB Order by Sales Desc Limit 1);

Select * from view_Employee;
Delete from view_employee where grade = 'a'

/* Stored Procedure

Stored Procedure is just a group of statement of your sql queries. You can create
stored procedure with set of sql statements that can be stored in database server and all the set of 
statements executed in a single unit. You can write a complex login or n number queries and stored
in a stored procedure
*/
use DataAnalytics
Delimiter $$
	Create Procedure to_get_employeedb()
    Begin
		Select * from EmployeeDB;
    End $$
Delimiter ;

Call to_get_employeedb()

Delimiter $$
Create Procedure to_get_summaryOfSales()
Begin
		Select distinct region, round(sum(sales) over (partition by region),2) as TotalSales,
        round(avg(sales) over (partition by region),2) as avgSales,
        min(sales) over (partition by region) as MinSales,
        max(sales) over (partition by region) as MaxSales,
        count(sales) over (partition by region) as TotalTransaction
        From Superstore;
End $$
Delimiter ;

call to_get_summaryOfSales()


Delimiter $$
Create Procedure get_Min_Max_Sales(minSales Int, maxSales int)
Begin
	Select * from superstore where sales between minSales and maxSales Order by Sales Desc;
End $$
Delimiter ;

call get_Min_Max_Sales(1000,1001);

drop procedure if exists  to_get_employeedb;


-- Change the delimiter to something other than a semicolon temporarily
DELIMITER $$

-- Create the function
CREATE FUNCTION GetCustomerTotalSales(customer_id VARCHAR(50))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_sales DECIMAL(10,2);
    SELECT SUM(Sales) INTO total_sales
    FROM Superstore
    WHERE `CustomerID` = customer_id;
    RETURN total_sales;
END $$
-- Reset the delimiter back to semicolon
DELIMITER ;

Select * from superstore;

SELECT GetCustomerTotalSales('CG-12520') AS TotalSales;

DELIMITER $$
CREATE FUNCTION GetAvgSalesByCategory(category_name VARCHAR(50))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE avg_sales DECIMAL(10,2);
    SELECT AVG(Sales) INTO avg_sales
    FROM Superstore
    WHERE Category = category_name;
    RETURN avg_sales;
END $$
DELIMITER ;


Select GetAvgSalesByCategory('Technology');


DELIMITER $$
CREATE FUNCTION GetSalesByDateRange(start_date DATE, end_date DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_sales DECIMAL(10,2);
    SELECT SUM(Sales) INTO total_sales
    FROM Superstore
    WHERE ShipDate BETWEEN start_date AND end_date;
    RETURN total_sales;
END $$
Delimiter ;

Select * from superstore 
order by shipdate limit 5;

select GetSalesByDateRange('01/01/15','01/02/15')

DELIMITER $$
CREATE FUNCTION testing()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	Select * from superstore where Region = 'West';
END $$
Delimiter ;

-- Difference between stored procedure and function

-- No, you cannot define a stored procedure inside a function in MySQL.
/*
Yes, you can call a function inside a stored procedure in MySQL.

Stored procedures can execute functions, just like they can execute other SQL queries. 
When calling a function inside a stored procedure, you can use the result of the function 
in SQL statements or logic within the procedure.
*/

/*
Summary:
Stored Procedures can return result sets (tables) directly.
Functions in MySQL can only return single values (not tables or multiple rows).
*/

/*Question:  How we can define a function in stored procedure or how to write (Home Task)
I need 2 examples on superstore data set and share your answers on my linkedin
*/








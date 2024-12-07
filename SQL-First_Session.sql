/*
MS SQL Server
MySQL
Oracle
PostgreSQL
TerraData
MS Access
DB2
etc.
*/
-- To Interact above application we need of SQL queries.
-- Note: SQL is not case-sensitive query language.
/* Types of SQL Queries: 

1. Data Definition Language (DDL)
Create, Drop, Alter, Truncate, Rename etc

2. Data Manipulation Language (DML)
Insert, Update, Delete

3. Data Control Language (DCL)
Grant, Revoke

4. Transaction Control Language (TCL)
Commit, Rollback, SavePoint

5. Data Query Langauge
Select
*/

-- Fields : Columns and Records : Rows

-- Creation of DataBase
Create Database upGrad_2014;
use upGrad_2014;

Create table Employee
(
	EmpID int,
    FirstName varchar(30),
    LastName varchar(30)
)

Select * From Employee;

-- Can you Insert the data into the table
Insert into Employee (EmpID, FirstName, LastName) 
Values (101,'Pranay','Jain'), 
(102,'Ameya','Parab'), (103,'John','Farmer');

Select * from Employee;

Create Table Departments
(
	DeptID Char(10) not null,
    DeparmentName varchar(20),
    Location nvarchar(20)
);

-- Char, VarChar, VarChar(MAX) nVarChar, nVarChar(Max), NChar, 

Use hr_database;

Select * from employees;

Select employee_id, first_name, Salary, email from employees;

-- First Five Records
Select * from Employees Limit 5;

/* Order by Clause:

Using Order by clause we can sort the data either in asc or desc order,
by default we can sort the data in asc order.
*/
Select * from Employees
Order by First_name;

Select * from employees order by first_name desc;

Select * from employees 
order by first_name asc, salary desc, department_id asc

-- How can I find Top 5 Employees based on their Salary
Select * from employees order by salary desc limit 5;

/*
Where Clause: 

Using the where clause we can filter the data, where clause can filter the 
normal rows from the table. In where can use logical operators, 'in', like, between etc
*/

Select * from employees where salary<= 4000;

Select * from employees where salary >= 4000 and salary <= 6000
order by salary desc;

Select * from employees
Where (Salary >= 6000 and phone_number is not null and manager_id is not null)
and (Job_id = 6 or job_id = 7 or job_id = 8 or job_id = 12)
Order by Salary;

-- If you have multiple criteria on a single column then try to use 'in' operator

Select * from employees
Where (Salary >= 6000 and phone_number is not null and manager_id is not null)
and Job_id in (6,7,8,12,1000)
Order by Salary;


Select * from employees
Where (Salary >= 6000 and phone_number is not null and manager_id is not null)
and Job_id not in (6,7,8,12,1000)
Order by Salary;


-- Filter the salary >4000 and your salary less than 6000 | 
-- Salary > 10000 and your salary <=12000
Select * from employees
Where (salary >= 4000 and Salary < 6000)
OR (Salary > 10000 and Salary <= 12000);

Select * from Employees
where phone_number is not null;

-- SQL Wild Card
-- In MS excel : 1. * (A series of char) 2. ? (A single char)
-- In MySQL : % (A series of Char) 2. _ ( A single Char)

Select * from employees
where first_name like 'A%';

Select * from employees
where first_name like 'A%' or first_name like 'D%';

Select * from employees
where first_name like '__A%';

Select * from employees
where first_name not like '__A%';

Select * from Employees
where first_name like '%y';


Select * from Employees
where hire_date like '1999%';

Select * from employees where employee_id like '%1%';

Select * from Employees
where hire_date like '%01%';

Select * from Employees
where email not like '%yahoo%';

-- between and SQL Aggregate operator
Select * from employees where employee_id like '%2%'
and first_name like 'A%';
Select * from employees where employee_id like '1_2%';
-- here this patterns means contains 2 anywhere
-- Between Operator

Select * from employees where salary between 4000 and 6000
Order by Salary;

Select * from employees where salary not between 4000 and 6000
Order by Salary;

/* SQL Aggregated Functions :
	SUM, MAX, MIN, AVG, COUNT, STD etc
*/

use knowledgehut;

Select sum(Sales) as TotalSales From superstore;
Select round(sum(sales),2) as TotalSales from superstore;

-- Count of records
Select count(*) as Total_Records from Superstore;
Select count(1) as Total_Records from Superstore;
Select count("Abhishek") as Total_Records from Superstore;

/* Can you give me region wise sales?
Here, non-aggregate column : Region
Aggregate column : Sales
*/

Select Region, round(sum(Sales),0) as TotalSales From Superstore
Group by Region;

Select * from superstore limit 1;

Select Region, Segment, round(sum(Sales),0) as TotalSales From Superstore
Group by Region, Segment;

Select Region, Segment, round(sum(Sales),0) as TotalSales From Superstore
Group by Segment, Region;

SELECT 
    Region, Category, Segment,
    ROUND(SUM(sales), 0) AS TotalSales,
    COUNT(*) AS TotalRecs,
    AVG(Quantity) AS AvgQuantity
FROM
    superstore
GROUP BY Region , Category , Segment;

-- Filter the TotalRecs > 500
SELECT 
    Region, Category, Segment,
    ROUND(SUM(sales), 0) AS TotalSales,
    COUNT(*) AS TotalRecs,
    AVG(Quantity) AS AvgQuantity
FROM
    superstore
Where Segment != 'Corporate'
GROUP BY Region , Category , Segment
Having TotalRecs > 500;

SELECT 
    Region, Category, Segment,
    ROUND(SUM(sales), 0) AS TotalSales,
    COUNT(*) AS TotalRecs,
    AVG(Quantity) AS AvgQuantity
FROM
    superstore
GROUP BY Region , Category , Segment
Having TotalRecs > 500 and Segment != 'Corporate';


-- Can we use having clause without using group by ?
Select * from Superstore
having Category = 'Furniture';

Select * from Superstore
having Category like 'F%'

/* Diff b/w Where and having 
Where and having: Using where clause we can filter the normal rows (non-aggregated rows),
and using clause we can filter the non-aggregated or aggregated rows.
Basically, Having used to filter the aggregated rows from the table
*/

use hr_database;

Select * from employees;

Select phone_number, count(*) as cnt
from employees
group by phone_number
order by cnt desc

Select * from Employees;
Select count(*) as NumberOfRows from employees
where manager_id is not null;



















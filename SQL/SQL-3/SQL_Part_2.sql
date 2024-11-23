CREATE TABLE employees (
    id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    full_time BOOLEAN
);

-- Inserting dummy data into the table
INSERT INTO employees (id, first_name, last_name, age, department, salary, full_time)
VALUES
(1, 'John', 'Doe', 28, 'Finance', 50000.00, TRUE),
(2, 'Jane', 'Smith', 32, 'IT', 55000.00, TRUE),
(3, 'Emily', 'Jones', 24, 'Marketing', 45000.00, FALSE),
(4, 'Chris', 'Brown', 45, 'IT', 75000.00, TRUE),
(5, 'Jessica', 'Davis', 36, 'HR', 48000.00, FALSE),
(6, 'Michael', 'Wilson', 41, 'Finance', 65000.00, TRUE),
(7, 'Sarah', 'Miller', 29, 'Marketing', 47000.00, TRUE),
(8, 'James', 'Taylor', 39, 'HR', 52000.00, TRUE),
(9, 'Robert', 'Moore', 33, 'IT', 60000.00, FALSE),
(10, 'Jennifer', 'Anderson', 30, 'Finance', 49000.00, TRUE),
(11, 'Linda', 'Thomas', 27, 'Marketing', 43000.00, FALSE),
(12, 'David', 'Jackson', 53, 'HR', 68000.00, TRUE),
(13, 'Karen', 'White', 47, 'Finance', 71000.00, TRUE),
(14, 'Richard', 'Harris', 31, 'IT', 64000.00, FALSE),
(15, 'Susan', 'Martin', 38, 'Marketing', 56000.00, TRUE),
(16, 'Joseph', 'Thompson', 28, 'Finance', 52000.00, FALSE),
(17, 'Charles', 'Garcia', 34, 'HR', 58000.00, TRUE),
(18, 'Mary', 'Martinez', 41, 'Marketing', 73000.00, TRUE),
(19, 'Patricia', 'Robinson', 29, 'IT', 47000.00, FALSE),
(20, 'Thomas', 'Clark', 37, 'Finance', 65000.00, TRUE);

Select * from employees;

Select ID, salary,
salary * 12 as Annual_salary, -- Multiplication
salary / 30 as Day_WiseSalary, -- Division
salary + 1000 as IncreasedSalary,
Salary - 1000 as DescresedSalary
from employees;

Select * from employees
where department = 'IT' or age > 45;

Select * from employees
where department = 'IT' AND age < 45;

Select * from superstore;

-- SQL Aggregate Function
Select count(*) from superstore;
-- Count the number of transactions where Sales > 5000
Select count(*) as TotalTrans from Superstore
Where Sales > 5000;
-- Calc the total sales of all customers
Select sum(Sales) as TotalSales from Superstore;
-- Avg sales of customer
Select avg(Sales) as AverageSales from Superstore;
-- total sales of south region
Select sum(Sales) as TotalSales from Superstore
Where region = 'South';
-- avg of east region based on sales
Select avg(Sales) as AverageSales from Superstore
where region = 'East';

select max(sales) as HighestSales
from superstore;

Select Region, Sales, City, Category from
superstore
order by sales desc limit 2

-- can you find 2nd highest sales
Select max(sales) as SecondHighestSales
From Superstore
Where Sales < (select max(sales) from superstore)
Limit 1;

-- can you find all the relevant column of 2ndhighestsales
Select * 
From Superstore
Where Sales < (select max(sales) from superstore)
Order by Sales Desc
Limit 1;

-- SQL Group By -- Having Clause
-- Can you give Region wise Total Transactions
/* When you are using group by:

Any colum list you are providing in your select
statement, that list of column should be the part
of group by clause except sql aggregate operators.
*/

Select Region, Count(*) as Region_Trans
From Superstore
Group by Region
Order by Region_Trans Desc;

Select Region, sum(Sales) as Region_Wise_Sales
From Superstore
Group by Region
Order by Region_Wise_Sales Desc;

-- Region and Category wise Total Sales
Select Region, Category, sum(Sales) as Region_Wise_Sales
From Superstore
Group by Region, Category
Order by Region;

Select Region,Category,SubCategory, Count(*) as Cnt
From Superstore
Where Category = 'Office Supplies' -- non aggregate column we can filter here
Group by Category,Region,SubCategory;

Select Region,Category,SubCategory, Count(*) as Cnt
From Superstore
Group by Category,Region,SubCategory
Having cnt > 400;

/* having clause:

When you are using group by clause and you want to filter
aggregated column result then we will be use having clause

So Sir?
Q. Can I use having clause on non-aggregated column?
A. Yes we can use with non-aggregated column as well.

Q. Can I use having clause without using group by?
A.
*/
Select Region,Category,SubCategory, Count(*) as Cnt
From Superstore
Group by Category,Region,SubCategory
Having Category = 'Technology';


Select Region, Category, subcategory, sales
from superstore
having sales > 5000 and category = 'Technology';

-- can I use aggregated func without using group by
Select sum(sales) as totalSales from superstore;
-- Q. can I use aggregated func with non-aggregated column list or columns without using group by
-- A. we can not use it
SELECT 
    region, AVG(sales) AS avgSales
FROM
    superstore
GROUP BY region;

Select region, category, avg(sales) as avgSales from superstore
where region = 'East'
group by category,region
having category != 'Furniture';


Select region, category, sum(sales) as sumSales from superstore
where region = 'East' and category != 'Furniture' -- I am using where because, I want to filter the non-aggregate column
group by category,region
having sumSales  > 1000 -- filtering the aggreate column (sumSales)
Order by sumSales desc;

SELECT 
    region, category, SUM(sales) AS sumSales
FROM
    superstore
GROUP BY category , region
HAVING sumSales > 1000
    AND (region = 'East'
    AND category != 'Furniture')
ORDER BY sumSales DESC;


Select Region, Segment, Category, 
sum(Sales) as TotalSales,
round(avg(Sales),2) as AvgSales,
Max(Sales) as MaxSales,
Min(Sales) as MinSales,
Count(*) as TotalTransaction
From Superstore
Group by Region, Segment, Category
having Segment = 'Corporate' and (category != 'Furniture')
And (TotalTransaction >= 100 and TotalTransaction <= 400);

SELECT 
    Region,
    Segment,
    Category,
    SUM(Sales) AS TotalSales,
    ROUND(AVG(Sales), 2) AS AvgSales,
    MAX(Sales) AS MaxSales,
    MIN(Sales) AS MinSales,
    COUNT(*) AS TotalTransaction
FROM
    Superstore
WHERE
    Segment = 'Corporate'
        AND (category != 'Furniture')
GROUP BY Region , Segment , Category
HAVING (COUNT(*) >= 100 AND COUNT(*) <= 400);
-- having (TotalTransaction >= 100 and TotalTransaction <= 400)

-- Creating new table -- knowlegehut
CREATE TABLE employee_details (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    date_of_joining DATETIME,
    salary DECIMAL(10, 2),
    bonus_percent FLOAT
);

-- Inserting dummy data into the table
INSERT INTO employee_details (employee_id, first_name, last_name, date_of_birth, date_of_joining, salary, bonus_percent)
VALUES
(1, 'John', 'Doe', '1985-07-20', '2010-06-01 09:00:00', 50000.00, 5.75),
(2, 'Jane', 'Smith', '1990-08-12', '2012-07-15 09:00:00', 55000.00, 4.5),
(3, 'Emily', 'Jones', '1982-09-30', '2008-08-08 09:00:00', 45000.00, 6.7),
(4, 'Chris', 'Brown', '1975-01-15', '2005-03-05 09:00:00', 75000.00, 7.2),
(5, 'Jessica', 'Davis', '1995-12-19', '2017-11-20 09:00:00', 48000.00, 3.9),
(6, 'Michael', 'Wilson', '1978-04-05', '2000-04-16 09:00:00', 65000.00, 5.0),
(7, 'Sarah', 'Miller', '1988-05-25', '2011-01-09 09:00:00', 47000.00, 4.75),
(8, 'James', 'Taylor', '1972-10-30', '1998-09-17 09:00:00', 52000.00, 5.5);

Select * from employee_details;
-- lower and upper 
SELECT 
    LOWER(first_name) AS Fname, UPPER(last_name) AS Lname
FROM
    employee_details;

-- Concate FirstName and LastName
SELECT 
    CONCAT(first_name, ' ', last_name) AS FullName
FROM
    employee_details;

SELECT 
    first_name,
    last_name,
    DATEDIFF(CURRENT_DATE, date_of_birth) / 365 AS Age
FROM
    employee_Details;

Select first_name, last_name,
floor(datediff(current_Date, date_of_joining) / 365) as Age
from employee_Details;

Select * from employee_Details;
Select first_name, last_Name, salary,
round(salary + (salary * bonus_percent / 100),0) as total_compensation
from employee_Details;

-- Schema Designing -- FK, PK, Null, Not Null, Default etc






-- How to create a database
create database upGrad;
use upgrad;
Create Table Employee
(
	EmpID varchar(10),
    EmpName varchar(50),
    City varchar(20),
    Salary int
);
-- How to insert the data into the table
insert into Employee(EmpID,EmpName,City,Salary)
values 
('101','Abhisheak','Goa',50000),
('102','Yatin','Chennai',55000),
('103','Abhinav','Mumbai',58000),
('104','Bhargavi','Pune',58000),
('105','Vivek','Noida',40000);
Select * from Employee;

-- Insert, Delete, Drop, Order by, Where, In, Between, and, or, not
/* Update Statement
Using update command we can update the tables info based on
some condition.
*/

-- use double hyphen when you want to make a comment of a line
/*
When you want make multiple line of comment
*/
-- Every statement is closed by semicolon

Select * from EmployeeDB;

Select * from EmployeeDB Limit 2;

-- Order by Clause
/* Using this clause we can sort the data 
either in asc or desc order, by default order by clause
work on asc order.
*/

Select * from EmployeeDB Order by Salary;
Select First_Name, Last_Name, Salary, Email from EmployeeDB
Order by Salary Desc;

Select * from employeedb1
Order by Sales desc;

-- How to sort the data based on more than 1 column
Select * from employeedb1 
Order by YearlyIncome desc, FirstName Desc;

/* Where Clause
This clause basically work for filter the data, we can 
filter the data based on certain condition from the table
*/
Select * from employeedb1 where sales >= 4000;

select * from employeedb1 where grade = 'A';
select * from employeedb1 
where 
(grade = 'A' or grade = 'D');

select * from employeedb1 
where 
(grade = 'A' or grade = 'D')
and (occupation = 'Professional')
and (Education = 'Bachelors')
Order by Sales;

-- IN clause with Where Clause

Select FirstName, LastName, Occupation, Grade, Sales
From EmployeeDB1
Where Grade in ('A','D')
AND Occupation in ('Management','Clerical');

-- I want all the employee except Grade A or D
Select FirstName, LastName, Occupation, Grade, Sales
From EmployeeDB1
Where Grade not in ('A','D');

-- Between Clause
Select FirstName, LastName, Occupation, Grade, Sales
From EmployeeDB1
Where Sales between 3000 and 3805
And Grade in ('A','C')
And Occupation = 'Clerical';

Select FirstName, LastName, Occupation, Grade, Sales
From EmployeeDB1
Where Sales not between 3000 and 3805
And Grade in ('A','C')
And Occupation = 'Clerical';

-- Delete Statement
select * from employeedb
where salary = 4800;

Delete from employeedb where salary = 4800;

SET SQL_SAFE_UPDATES = 0;

Select * from employeedb
where salary >= 12000
and manager_id = 100;

delete from employeedb
where salary >= 12000
and manager_id = 100;

Select * from employeedb
where last_name = 'King';

delete from employeedb where last_name = 'king';

Select count(*) TotalNumberRec from EmployeeDB;

create table Testing
(
ID int
);

-- Using drop we can drop the table permanently
drop table testing;

-- I want to delete all the data in one go
select * from employee;
delete from employee; -- without where clause I am using delete statement which mean I want to delete all the data from table

Drop Table Employee;

/* Delete vs Drop vs Truncate

Delete is DML statement and DROP is DDL Statement.

Using Delete statement we can delete the data from the table
based on condition or based on without condition.
Note: Delete statement just delete the data but table's structured
remain as same. or more specifically, delete statement does not
delete the structure of table.

Where as DROP: Using drop we can drop the table permanently,
When your table is dropped successfully, it means Table and its data has gone.

Note: Delete statement can be rolleback, where as Drop statement can not be rollback at any situation.

Truncate: Truncate also DDL statement, we can truncate all the data from the table without using condition, although we can not supply where condition in the truncate statment.
Note: Truncate statement also can not be rollback.
*/

Select * from Employee;

upDate Employee set Salary = 90000 Where EmpID = '101';

update employee set salary = 60000 where city != 'Goa';

update employee set City = 'Goa' where empid = '104';

update employee set salary = 10000 where city = 'Goa'
and Salary >= 60000;

Select * from Employee;

/* Alter statement (command)
Using alter statement we can alter the table structure,
we can change the data type of column or we can add a column
or we can drop the column if needed.
*/

Alter Table employee Modify column EmpID Int;

Alter table employee modify column EmpName varchar(100);

-- add a column with status
Alter table employee add column emp_status varchar(20);
Select * from Employee;
update employee set emp_status = 'active';

Select * from employee;

-- Truncate
Truncate table Employee
where employee = 'A' -- in truncate statement we can not use where condition

select * from employee;

/* Primary key and Foreign Key Relationship */
Create Table Departments
(
DepartmentID Int Primary Key,
DepartmentName varchar(100) not null
);

insert into Departments(DepartmentID,DepartmentName)
values (1,'Mechnical Engineering'),(2,'Civil Engineering'),
(3,'Computer Science'),(4,'Electrical Engineering');

Select * from Departments;

Create Table Students
(
	StudentID Int Primary Key,First_Name Varchar(50) Not null,
    Last_Name varchar(50) Not Null,DateOfBirth Date,
    Email varchar(100) Unique not null,Department_ID int,Score Int,
    foreign key (Department_ID) REFERENCES Departments(DepartmentID)
);
Insert Into students(
studentID,First_Name,Last_Name,DateofBirth,Email,Department_id,Score)
values (1,'Abhishek','Saraswat','1999-10-10','myprogrammingisfun@gmail.com',3,85)

Select * from students;

Insert Into students(
studentID,First_Name,Last_Name,DateofBirth,Email,Department_id,Score)
values (2,'Abhinav','Sharma','2000-09-10','abhinav@gmail.com',1,90)

Select * from departments;

delete from departments where departmentid = 3;
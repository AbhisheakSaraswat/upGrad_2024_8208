/* SQL Joins
Joins is the most commonly used claues in SQL, it is used to combine and retrieve data
from two or more tables. 
Different type of joins:
1. Inner Join | Natural Join | Common Join 
2. Left Join | Left Outer Join
3. Right Join | Right Outer Join
4. Full Join | Full Outer Join | Outer Join
5. Cross Join

-- General Syntax of Joins (Except Cross Join)

Select ColumnList from TableName1
Inner Join TableName2
On TableName1.column_Name = TableName2.column_Name
Inner Join TableName3
on TableName2.column_Name = TableName3.column_Name

*/

-- Inner Join : Inner Join will give you only common records from the tables it is just like vlookup of ms excel.


use hr;

Select * from employees;
select * from departments;

-- Can you fetch employee's department Name and Location and Country Info
Select Employee_ID, concat(First_Name,' ',Last_Name) as FullName,
Salary, dept.department_name, dept.location_id
From Employees as emp
Inner Join Departments as dept
on emp.department_id = dept.department_id
Where dept.Department_name = 'Shipping';


Select count(*) as TotalCount
From
(
	Select Employee_ID, concat(First_Name,' ',Last_Name) as FullName,
	Salary, dept.department_name, dept.location_id
	From Employees as emp
	Inner Join Departments as dept
	on emp.department_id = dept.department_id
	Where dept.Department_name = 'Shipping'
) as Temp;


Select Employee_ID, concat(First_Name,' ',Last_Name) as FullName,
Salary, dept.department_name, dept.location_id, loc.Street_address, loc.city, loc.country_id,cntry.country_name,
cntry.region_id, regn.region_name
From Employees as emp
Inner Join Departments as dept
on emp.department_id = dept.department_id
Inner Join Locations as loc
on dept.location_id = loc.location_id
Inner Join Countries as cntry
on loc.country_id = cntry.country_id
Inner Join Regions as Regn
on cntry.region_id = Regn.region_id;


Select * from Employees;

Select M.First_Name as EmpName,E.First_Name as ManagerName,  M.Manager_id as ManagerID
From Employees as E
Inner Join Employees as M
on E.Employee_ID = M.Manager_ID;

Select ManagerName, count(*) as EmpCount FROM
(
	Select M.First_Name as EmpName,E.First_Name as ManagerName,  M.Manager_id as ManagerID
	From Employees as E
	Inner Join Employees as M
	on E.Employee_ID = M.Manager_ID
) as T
group by ManagerName
Order by EmpCount DESC;


Select * from Employees
left Join Departments
on Employees.department_id = departments.department_id;

Select * from departments;


Select * from Employees
right Join Departments
on Employees.department_id = departments.department_id;


-- How to apply full join
Select column_list from Table_1
Left Join Right_Table_2
on Table_1.OrderID = Right_Table_2.OrderID
UNION
Select column_list from Table_1
Right Join Right_Table_2
on Table_1.OrderID = Right_Table_2.OrderID









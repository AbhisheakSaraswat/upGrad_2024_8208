/* SQL Analytical Function

Select Column_List, AnalyticalFunctionname over 
(Partition by ColumName Order by ColunName) as AliasName
From Tablename
*/


Select * from Superstore;

Select sum(Sales) as TotalSales from Superstore;

Select  Region, sum(Sales) as Totalsales
From SuperStore
Group by Region;

Select  Distinct Region, sum(Sales) Over () as TotalSales
From SuperStore;

Select  Distinct Region, 
sum(Sales) Over (partition by Region Order by Region) as TotalSales
From SuperStore;

Select  Distinct Region, 
sum(Sales) Over (partition by Region) as TotalSales,
avg(Sales) Over (partition by Region) as AvgSales,
max(Sales) Over (partition by Region) as MaxSales,
min(Sales) Over (partition by Region) as MinSales,
count(*) Over (Partition by Region) as Totalcount
From SuperStore;

Select FirstName, Education, Occupation, Grade,
Sales, row_number() over() as RowNumber
from EmployeeDB;


Select row_number() over() as RowNumber,OrderID, 
Region, Sales, Category
from superstore;

Select * From
(
	Select row_number() over() as RowNumber,OrderID, 
	Region, Sales, Category
	from superstore
) as Temp
Where RowNumber % 100 = 0;

Select * from EmployeeDB;

Select FirstName, Occupation, Education, Grade, Sales,
row_number() over(partition by Grade Order by Sales) as RowNumber
From EmployeeDB;

-- Can you find out 2nd Lowest Sales of each grade
Select * From
(
	Select FirstName, Occupation, Education, Grade, Sales,
	row_number() over(partition by Grade Order by Sales) as RowNumber
	From EmployeeDB
) as T
Where RowNumber = 2;

-- can you find 2nd highest sales
Select FirstName, Grade, Sales, RowNumber From
(
	Select FirstName, Occupation, Education, Grade, Sales,
	row_number() over(partition by Grade Order by Sales DESC) as RowNumber
	From EmployeeDB
) as T
Where RowNumber = 2;


	Select FirstName, Occupation, Education, Grade, Sales,
	row_number() over(partition by Education, Grade Order by Sales DESC) as RowNumber
	From EmployeeDB;


-- Can you give me 3rd Lowest Sales Against Each Region in Superstore
Select * from
(
Select Region, Sales as TotalSales,
row_number() over (partition by region order by sales) as rowNumber
from superstore
) as T
Where rowNumber =3;


-- Rank and DenseRank

Select * from EmployeeDB;

/* Rank : This function will apply the ranking on a column of a table.
If your columns conatins the same value then it will give you the same rank
but in the next rank you will see the jump.

Abhisheak: 1000->1, Abhinav : 1000->1 and Aman : 1100->3 using RankFunction

DenseRank: This function will apply the ranking on a column of a table.
If your columns conatins the same value then it will give you the same rank
but in the next rank you will not see the jump.

Abhisheak: 1000->1, Abhinav : 1000->1 and Aman : 1100->2 using RankFunction

*/

Select FirstName, LastName, Occupation, yearlyIncome,
Rank() Over (order by Yearlyincome asc) as NormalRank,
dense_Rank() Over (order by Yearlyincome asc) as DenseRank
from EmployeeDB;


Select FirstName, LastName, Occupation, yearlyIncome,
Rank() Over (Partition by Occupation order by Yearlyincome asc) as NormalRank,
dense_Rank() Over (Partition by Occupation  order by Yearlyincome asc) as DenseRank
from EmployeeDB;

-- Moving Average and Sum of Specific Rows
Select Category, Sales,
avg(Sales) Over (Order by Category Rows Between 2 Preceding and Current Row)as MovingAvg,
max(Sales) Over (Order by Category Rows Between 2 Preceding and Current Row)as MovingMax,
min(Sales) Over (Order by Category Rows Between 2 Preceding and Current Row)as MovingMin,
sum(Sales) Over (Order by Category Rows Between 2 Preceding and Current Row)as Cumsum
From Superstore;

Select Category, Sales,
avg(Sales) Over (Order by Category Rows Between Current Row and 2 Following)as MovingAvg,
max(Sales) Over (Order by Category Rows Between Current Row and 2 Following)as MovingMax,
min(Sales) Over (Order by Category Rows Between Current Row and 2 Following)as MovingMin,
sum(Sales) Over (Order by Category Rows Between Current Row and 2 Following)as Cumsum
From Superstore;

Select * from superstore limit 1;

-- How to change the data type of column using query
Alter Table `Knowledgehut`.`superstore`
Change column `Quantity` `Quantity` int


-- CTE, CASE Statement, Functions and Procedure (Lag and Lead)

-- Find the difference between ones next income and previous income in the same state
-- Lag and Lead
CREATE DATABASE ex1;

USE ex1;

-- Create a table

CREATE TABLE new_table (

order_number INT PRIMARY KEY,

name VARCHAR(50),

age INT,

occupation VARCHAR(50),

city VARCHAR(50),

state VARCHAR(50),

income DECIMAL(10, 2)

);

-- Insert all rows into the new_table
INSERT INTO new_table (order_number,name, age, occupation, city, state, income)
VALUES
(1001, 'Rahul Sharma', 28, 'Software Engineer', 'Delhi', 'Delhi', 1200000.00),
(1002, 'Priya Mehta', 34, 'Doctor', 'Mumbai', 'Maharashtra', 1500000.00),
(1003, 'Arjun Kumar', 45, 'Business Analyst', 'Bengaluru', 'Karnataka', 1400000.00),
(1004, 'Aishwarya Nair', 30, 'Architect', 'Chennai', 'Tamil Nadu', 900000.00),
(1005, 'Rajesh Verma', 22, 'Civil Engineer', 'Kolkata', 'West Bengal', 600000.00),
(1006, 'Sneha Patil', 29, 'Marketing Manager', 'Pune', 'Maharashtra', 800000.00),
(1007, 'Vikram Singh', 39, 'Teacher', 'Jaipur', 'Rajasthan', 500000.00),
(1008, 'Neha Gupta', 41, 'Fashion Designer', 'Lucknow', 'Uttar Pradesh', 1200000.00),
(1009, 'Rohan Joshi', 35, 'Mechanical Engineer', 'Ahmedabad', 'Gujarat', 1000000.00),
(1010, 'Meera Iyer', 27, 'Data Scientist', 'Coimbatore', 'Tamil Nadu', 1600000.00),
(1011, 'Suresh Rao', 32, 'Banker', 'Hyderabad', 'Telangana', 750000.00),
(1012, 'Anjali Deshmukh', 36, 'Journalist', 'Nagpur', 'Maharashtra', 600000.00),
(1013, 'Amitabh Mishra', 33, 'Lawyer', 'Patna', 'Bihar', 1300000.00),
(1014, 'Divya Kapoor', 26, 'Graphic Designer', 'Chandigarh', 'Punjab', 700000.00),
(1015, 'Karthik Reddy', 40, 'Doctor', 'Visakhapatnam', 'Andhra Pradesh', 1500000.00),
(1016, 'Pooja Aggarwal', 31, 'HR Manager', 'Gurgaon', 'Haryana', 850000.00),
(1017, 'Manish Pandey', 29, 'Accountant', 'Bhopal', 'Madhya Pradesh', 700000.00),
(1018, 'Simran Kaur', 28, 'Content Writer', 'Amritsar', 'Punjab', 500000.00),
(1019, 'Siddharth Jain', 38, 'Professor', 'Indore', 'Madhya Pradesh', 1000000.00),
(1020, 'Alka Yadav', 42, 'Nurse', 'Kanpur', 'Uttar Pradesh', 600000.00),
(1021, 'Ravi Shetty', 34, 'Entrepreneur', 'Mangalore', 'Karnataka', 2000000.00),
(1022, 'Preeti Sinha', 30, 'Pharmacist', 'Ranchi', 'Jharkhand', 750000.00),
(1023, 'Aditya Bansal', 33, 'Product Manager', 'Gwalior', 'Madhya Pradesh', 1400000.00),
(1024, 'Sunita Singh', 39, 'Real Estate Agent', 'Agra', 'Uttar Pradesh', 1250000.00),
(1025, 'Harsh Patel', 27, 'Software Developer', 'Surat', 'Gujarat', 900000.00),
(1026, 'Ishita Saxena', 35, 'Teacher', 'Varanasi', 'Uttar Pradesh', 600000.00),
(1027, 'Abhinav Choudhary', 32, 'Consultant', 'Jaipur', 'Rajasthan', 1200000.00),
(1028, 'Radha Bhatt', 26, 'Interior Designer', 'Dehradun', 'Uttarakhand', 800000.00),
(1029, 'Kiran Thakur', 40, 'Software Architect', 'Aurangabad', 'Maharashtra', 1700000.00),
(1030, 'Nisha Dubey', 37, 'HR Executive', 'Raipur', 'Chhattisgarh', 850000.00),
(1031, 'Yashwant Singh', 31, 'Pilot', 'Jodhpur', 'Rajasthan', 1600000.00),
(1032, 'Lakshmi Menon', 38, 'Doctor', 'Kochi', 'Kerala', 1500000.00),
(1033, 'Rakesh Malhotra', 29, 'Chartered Accountant', 'Chandigarh', 'Punjab', 1100000.00),
(1034, 'Shruti Joshi', 36, 'Event Manager', 'Noida', 'Uttar Pradesh', 800000.00),
(1035, 'Pranav Desai', 41, 'Civil Engineer', 'Vadodara', 'Gujarat', 1000000.00),
(1036, 'Anita Sharma', 33, 'Business Development Manager', 'Faridabad', 'Haryana', 1200000.00),
(1037, 'Ashok Kapoor', 28, 'Civil Engineer', 'Ludhiana', 'Punjab', 700000.00),
(1038, 'Geeta Bhatia', 44, 'Doctor', 'Thiruvananthapuram', 'Kerala', 1400000.00),
(1039, 'Varun Prasad', 35, 'Lawyer', 'Mysore', 'Karnataka', 1300000.00),
(1040, 'Aarav Gupta', 25, 'Software Engineer', 'Gurgaon', 'Haryana', 750000.00),
(1041, 'Aditi Rao', 29, 'Doctor', 'Mumbai', 'Maharashtra', 1400000.00),
(1042, 'Rakesh Singh', 40, 'Business Analyst', 'Noida', 'Uttar Pradesh', 1300000.00),
(1043, 'Simran Kaur', 35, 'Teacher', 'Amritsar', 'Punjab', 600000.00),
(1044, 'Rajiv Menon', 45, 'Banker', 'Kochi', 'Kerala', 1500000.00),
(1045, 'Pooja Verma', 28, 'Content Writer', 'Lucknow', 'Uttar Pradesh', 550000.00),
(1046, 'Nitin Sharma', 32, 'Lawyer', 'Delhi', 'Delhi', 1200000.00),
(1047, 'Sneha Iyer', 36, 'Interior Designer', 'Chennai', 'Tamil Nadu', 850000.00),
(1048, 'Vikram Kumar', 42, 'Civil Engineer', 'Pune', 'Maharashtra', 1100000.00),
(1049, 'Karan Patel', 38, 'HR Manager', 'Surat', 'Gujarat', 800000.00),
(1050, 'Ritika Kapoor', 26, 'Software Developer', 'Bengaluru', 'Karnataka', 950000.00),
(1051, 'Aditya Deshmukh', 30, 'Journalist', 'Nagpur', 'Maharashtra', 600000.00),
(1052, 'Aman Joshi', 33, 'Event Manager', 'Jaipur', 'Rajasthan', 700000.00),
(1053, 'Swati Sharma', 29, 'Doctor', 'Hyderabad', 'Telangana', 1350000.00),
(1054, 'Yashwant Yadav', 34, 'Architect', 'Kanpur', 'Uttar Pradesh', 1250000.00),
(1055, 'Alok Bansal', 41, 'Software Architect', 'Ahmedabad', 'Gujarat', 1600000.00),
(1056, 'Isha Chatterjee', 28, 'Graphic Designer', 'Kolkata', 'West Bengal', 700000.00),
(1057, 'Arjun Thakur', 36, 'Business Development Manager', 'Gurgaon', 'Haryana', 1100000.00),
(1058, 'Rajesh Patel', 50, 'Consultant', 'Vadodara', 'Gujarat', 1350000.00),
(1059, 'Deepika Singh', 31, 'Chartered Accountant', 'Agra', 'Uttar Pradesh', 950000.00),
(1060, 'Sanjay Reddy', 37, 'Software Developer', 'Bengaluru', 'Karnataka', 1250000.00),
(1061, 'Monika Nair', 44, 'Doctor', 'Chennai', 'Tamil Nadu', 1400000.00),
(1062, 'Rohan Verma', 28, 'Lawyer', 'Delhi', 'Delhi', 1200000.00),
(1063, 'Kavita Rao', 40, 'Pharmacist', 'Hyderabad', 'Telangana', 900000.00),
(1064, 'Shivani Desai', 39, 'Fashion Designer', 'Surat', 'Gujarat', 1200000.00),
(1065, 'Aakash Kapoor', 27, 'Teacher', 'Lucknow', 'Uttar Pradesh', 500000.00),
(1066, 'Nandini Sharma', 36, 'Marketing Manager', 'Pune', 'Maharashtra', 1050000.00),
(1067, 'Vivek Menon', 48, 'Entrepreneur', 'Kochi', 'Kerala', 2200000.00),
(1068, 'Preeti Arora', 34, 'Civil Engineer', 'Nagpur', 'Maharashtra', 1150000.00),
(1069, 'Abhay Verma', 29, 'HR Executive', 'Jaipur', 'Rajasthan', 650000.00),
(1070, 'Rajesh Reddy', 42, 'Lawyer', 'Visakhapatnam', 'Andhra Pradesh', 1300000.00),
(1071, 'Shruti Agarwal', 30, 'Consultant', 'Patna', 'Bihar', 850000.00),
(1072, 'Karthik Gupta', 27, 'Software Engineer', 'Delhi', 'Delhi', 800000.00),
(1073, 'Sana Patel', 39, 'Architect', 'Ahmedabad', 'Gujarat', 1250000.00),
(1074, 'Pankaj Sharma', 31, 'Data Scientist', 'Bengaluru', 'Karnataka', 1600000.00),
(1075, 'Vimal Singh', 35, 'Doctor', 'Kanpur', 'Uttar Pradesh', 1400000.00),
(1076, 'Kiran Kumar', 40, 'Real Estate Agent', 'Mumbai', 'Maharashtra', 1150000.00),
(1077, 'Anil Mehta', 46, 'Professor', 'Chandigarh', 'Punjab', 950000.00),
(1078, 'Shweta Rao', 28, 'Fashion Designer', 'Hyderabad', 'Telangana', 800000.00),
(1079, 'Deepak Agarwal', 31, 'Pilot', 'Gwalior', 'Madhya Pradesh', 1600000.00),
(1080, 'Nisha Singh', 36, 'Doctor', 'Patna', 'Bihar', 1450000.00),
(1081, 'Ravi Joshi', 32, 'Civil Engineer', 'Chennai', 'Tamil Nadu', 1000000.00),
(1082, 'Priya Gupta', 29, 'Software Developer', 'Delhi', 'Delhi', 950000.00),
(1083, 'Sunil Kumar', 38, 'Consultant', 'Jaipur', 'Rajasthan', 1250000.00),
(1084, 'Rashmi Desai', 37, 'Journalist', 'Mumbai', 'Maharashtra', 800000.00),
(1085, 'Yogesh Bansal', 30, 'Accountant', 'Pune', 'Maharashtra', 900000.00),
(1086, 'Shiv Kumar', 27, 'Graphic Designer', 'Chandigarh', 'Punjab', 700000.00),
(1087, 'Anita Sharma', 43, 'HR Manager', 'Lucknow', 'Uttar Pradesh', 850000.00),
(1088, 'Naveen Kapoor', 35, 'Business Analyst', 'Surat', 'Gujarat', 1000000.00),
(1089, 'Ashwin Menon', 29, 'Doctor', 'Kochi', 'Kerala', 1400000.00),
(1090, 'Kavya Gupta', 32, 'Software Engineer', 'Bengaluru', 'Karnataka', 1300000.00),
(1091, 'Arvind Patel', 36, 'Chartered Accountant', 'Ahmedabad', 'Gujarat', 1100000.00),
(1092, 'Sneha Thakur', 28, 'Consultant', 'Delhi', 'Delhi', 800000.00),
(1093, 'Mohan Verma', 39, 'Pilot', 'Jaipur', 'Rajasthan', 1400000.00),
(1094, 'Divya Joshi', 37, 'Doctor', 'Mumbai', 'Maharashtra', 1450000.00),
(1095, 'Vikas Bhatia', 40, 'Real Estate Agent', 'Bengaluru', 'Karnataka', 1500000.00),
(1096, 'Akash Reddy', 31, 'Journalist', 'Visakhapatnam', 'Andhra Pradesh', 800000.00);

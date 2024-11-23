/* SQL Key Constraint - that help enforce data
integrity and establish relationship between tables.

There are several types of key constrain, each 
serving a specific purpose.

null, not null, default, primary key, foreign key,
unique key, check etc

1. PK: Uniquely identifiers each value in the column.
A single table can have onle 1 primary key.
PK: Not contains dupliate and null 1 table can have 1pk

*/

create database upGrad_Nov;
create table regions
(
	region_id varchar(20) primary key,
    region_name varchar(30)
);

create table countries
(
	country_id varchar(20) primary key,
    country_name varchar(30) not null,
    region_id varchar(20),
    foreign key (region_id) references regions(region_id)
);

create table locations
(
	location_id varchar(20) primary key,
    street_address varchar(30) default null,
    postal_code int,
    state_province varchar(30),
    country_id varchar(20) not null,
    foreign key (country_id) references countries(country_id)
);

create table departments
(
	department_id varchar(20) primary key,
    department_name varchar(20),
    manager_id varchar(20),
    location_id varchar(20),
    foreign key (location_id) references locations(location_id)
);

create table jobs
(
	job_id int primary key,
    job_title varchar(20),
    min_salary int,
    max_salary int
);

create table employees
(
	employee_id varchar(10) primary key,
    first_name varchar(20),
    last_name varchar(20),
    email varchar(50), phone_number int,
    hire_Date date, job_id int, manager_id varchar(10),
    department_id varchar(20),
    foreign key (job_id) references jobs(job_id),
    foreign key (department_id) references departments(department_id),
    foreign key (manager_id) references employees(employee_id)
);

create table dependents
(
	dependent_id varchar(20),
    first_name varchar(20),
    last_name varchar(20),
    relationship varchar(10),
    employee_id varchar(10),
    primary key (employee_id),
    foreign key (employee_id) references employees(employee_id)
);

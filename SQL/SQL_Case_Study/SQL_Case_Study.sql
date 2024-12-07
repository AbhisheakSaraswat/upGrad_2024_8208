create database case_study;

CREATE TABLE city_day (
    City VARCHAR(50),
    Date DATE,
    PM2_5 FLOAT,
    PM10 FLOAT,
    NO FLOAT,
    NO2 FLOAT,
    NOx FLOAT,
    NH3 FLOAT,
    CO FLOAT,
    SO2 FLOAT,
    O3 FLOAT,
    Benzene FLOAT,
    Toluene FLOAT,
    Xylene FLOAT,
    AQI INT,
    AQI_Bucket VARCHAR(50)
);

CREATE TABLE station_day (
    StationId VARCHAR(20),
    Date DATE,
    PM2_5 FLOAT,
    PM10 FLOAT,
    NO FLOAT,
    NO2 FLOAT,
    NOx FLOAT,
    NH3 FLOAT,
    CO FLOAT,
    SO2 FLOAT,
    O3 FLOAT,
    Benzene FLOAT,
    Toluene FLOAT,
    Xylene FLOAT,
    AQI INT,
    AQI_Bucket VARCHAR(50)
);

CREATE TABLE stations (
    StationId VARCHAR(20),
    StationName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Status VARCHAR(20)
);

Select * from city_day limit 2;
Select * from station_day limit 2;
select * from stations limit 2;

-- Count rows with missing values for key pollutatns (PM2.5, PM10, AQI) in city_day
Select count(*) as MissingPM25
From city_day
where PM2_5 is null;

Select count(*) as MissingPM25
From city_day
where AQI is null;

Select count(*) as MissingPM25
From city_day
where PM10 is null;


-- Can you calculate the average AQI for each city
SELECT 
    city, AVG(aqi) AS AverageAQI
FROM
    city_day
GROUP BY city
ORDER BY AverageAQI DESC;


-- Join station_day with stations to get addiontal details (city, state)

Select * from stations limit 2;
Select * from station_day limit 2;

Select sd.Date, s.StationName, S.City, S.State, sd.PM2_5, sd.AQI, sd.AQI_Bucket
From Station_day as sd
Join Stations as s
on sd.StationID = s.StationID;

-- Can you classify cities into different AQI Categories (Good, Moderate, Poor, Very Poor)
/* if your AQI <= 50 : 'Good'
AQI in the range of 51 and 100 : 'Satisfactory'
AQI 101 to 200 : 'Moderate'
AQI 201 to 300 : 'Poor'
AGI 301 to 400 : 'Very Poor'
*/

Select * from city_day;

select City, avg(AQI) as Avg_AQI,
CASE 
	WHEN avg(aqi) <= 50 THEN 'Good' 
    WHEN avg(aqi) between 51 AND 100 THEN 'satisfactory' 
    WHEN avg(aqi) between 101 AND 200 THEN 'poor'
    WHEN avg(aqi) between 201 AND 400 THEN 'very poor' 
    Else 'Severe' END AS categories 
from city_day
group by city
order by Avg_AQI Desc;


With AQI_Status As
(
			select City, avg(AQI) as Avg_AQI,
			CASE 
				WHEN avg(aqi) <= 50 THEN 'Good' 
				WHEN avg(aqi) between 51 AND 100 THEN 'satisfactory' 
				WHEN avg(aqi) between 101 AND 200 THEN 'poor'
				WHEN avg(aqi) between 201 AND 400 THEN 'very poor' 
				Else 'Severe' END AS categories 
			from city_day
			group by city
			order by Avg_AQI Desc
)
Select categories, count(*) as Categories_Count
From AQI_Status
Group by categories
Order by Categories_Count Desc;

-- Using Temp
Select categories, count(*) as Categories_Count
From 
(
select City, avg(AQI) as Avg_AQI,
			CASE 
				WHEN avg(aqi) <= 50 THEN 'Good' 
				WHEN avg(aqi) between 51 AND 100 THEN 'satisfactory' 
				WHEN avg(aqi) between 101 AND 200 THEN 'poor'
				WHEN avg(aqi) between 201 AND 400 THEN 'very poor' 
				Else 'Severe' END AS categories 
			from city_day
			group by city
			order by Avg_AQI Desc
) as T
Group by categories
Order by Categories_Count Desc;

-- Find the worst and best cities based on their AQI
Select city, avg(aqi) as Avg_AQI
from city_day
group by city
order by avg_aqi desc
limit 1;

Select city, avg(aqi) as Avg_AQI
from city_day
group by city
order by avg_aqi
limit 1;

-- List Stations near industrial areas with the highest levels of PM2.5 and PM10
Select * from station_day limit 1;
Select * from stations limit 1;

Select s.StationName, s.City, round(avg(sd.PM2_5),2) as AvgPM25, 
round(avg(sd.PM10),2) as AvgPM10
From station_day as sd
Inner Join Stations as s
on sd.stationid = s.stationid
where s.city in ('Delhi', 'Kanpur','Kolkata')
Group by s.StationName, s.city
Order by AvgPM25 DESC, AvgPM10 DESC;

-- Summar of Polluation after and before 2020

with PreIntervention as 
(
	SELECT City, Avg(aqi) as PreAQI
    from city_day
    where date <' 2020-01-01'
    group by city
),
PostIntervention As
(
	SELECT City, Avg(aqi) as PostAQI
    from city_day
    where date >= '2020-01-01'
    group by city
)
Select pre.city, pre.PreAQI, pos.PostAQI, (pre.PreAQI - pos.PostAQI) as AQI_Improvement
From PreIntervention as pre
Inner Join PostIntervention as pos
on pre.City = pos.City
Order by AQI_Improvement DESC;

-- Lets create a yearly and monthly average of aqi

with MonthlyAvgAQI As
(
	Select city,  extract(Month from `date`) as Month,
    Extract(year from `date`) as Year,
    Avg(Aqi) as MonthlyAvgAQI
    from city_day
    group by city, extract(Month from `date`),Extract(year from `date`)

),
YearlyFluctuation As
(
	Select City, Year, Max(MonthlyAvgAQI) - Min(MonthlyAvgAQI) as AQIFluctuation
    from MonthlyAvgAQI
    Group by city, year
)
Select city, year, AQIFluctuation from YearlyFluctuation
Where AQIFluctuation > 50
Order by AQIFluctuation desc


With Pre2016Sales AS
(
    SELECT Region, round(SUM(Sales),2) as TotalSalesBefore2016
    FROM Superstore
    WHERE Order_Date < '2016-01-01'
    GROUP BY Region
),
Post2016Sales AS
(
    SELECT Region, round(SUM(sales),2) as TotalSalesAfter2016
    From Superstore
    Where Order_Date >= '2016-01-01'
    GROUP by Region
)
SELECT p.Region, p.TotalSalesBefore2016,
q.TotalSalesAfter2016, round((q.TotalSalesAfter2016 - p.TotalSalesBefore2016),2)
as SalesChange
From Pre2016Sales as p
Inner Join Post2016Sales as q
on p.Region = q.Region
Order by SalesChange desc

Select Region, Sum(Sales) as TotalSales
From Superstore
group by Region

/*
You can import the data for employeetable of last 3 years
and compare the salary growth of each employee using 3 different CTE
where you will be calculate avg growth of 2022, 2023, 2024
*/


















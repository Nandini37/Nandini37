SELECT * FROM sql_project.zomato;

USE sql_project;

-- Cleaning Data
-- Updatinng Columns names

-- Changing column name Restuarant Id, Country Code to country_code in table zomoto

ALTER table `sql_project`.`zomato`
CHANGE `ï»¿Restaurant ID` `Restaurant ID` int;


ALTER table `sql_project`.`zomato`
CHANGE `Country Code` `county_code` int;

-- Changing column name Country Code to country_code in table country-code

ALTER table `sql_project`.`country-code`
CHANGE `ï»¿Country Code` `county_code` int;

-- Checking updated column names
SELECT * from zomato ;

-- Checking data types

DESCRIBE zomato ;

-- Changing data types

ALTER table `sql_project`.`zomato`
CHANGE `Restaurant ID` `Restaurant_ID` int NOT NULL; 

-- Adding primary key to zomato table
ALTER table `sql_project`.`zomato`
ADD PRIMARY KEY (`Restaurant_ID`) ;

-- Adding primary key to country code

ALTER TABLE `sql_project`.`country-code` 
CHANGE COLUMN `county_code` `county_code` INT NOT NULL ,
ADD PRIMARY KEY (`county_code`);
;

SELECT DISTINCT `Currency` 
FROM zomato;

SELECT * 
FROM zomato;


-- Cities which have atleast 3 restaurants with rating>=4 --
SELECT  City,COUNT(City) AS Count FROM zomato
WHERE `Aggregate rating`>= 4
GROUP BY City
HAVING COUNT(City)>=3
ORDER BY 1 ASC;

ALTER TABLE `sql_project`.`country-code` 
RENAME TO  `sql_project`.`country_code` ;

SELECT 
Distinct City, count(Restaurant_ID) ,
country_code.Country,
zomato.county_code
FROM zomato
LEFT JOIN country_code
ON zomato.county_code = country_code.county_code
group by City
order by count(Restaurant_ID) desc;

SELECT 
    COUNT(Restaurant_ID)
FROM
    zomato;
    
SET SQL_SAFE_UPDATES = 0;

-- Adding column country ---
ALTER TABLE zomato
ADD  Country VARCHAR(255);
UPDATE zomato
SET Country = CASE
WHEN county_code =1 THEN 'India'
WHEN county_code =214 THEN 'UAE'
WHEN county_code =215 THEN 'UK'
WHEN county_code = 216 THEN'USA'
WHEN county_code =14 THEN 'Australia'
WHEN county_code =30 THEN 'Brazil'
WHEN county_code =37 THEN 'Canada'
WHEN county_code =94 THEN 'Indonesia'
WHEN county_code =148 THEN 'New Zealand'
WHEN county_code =162 THEN 'Phillipines'
WHEN county_code =166 THEN 'Qatar'
WHEN county_code =184 THEN 'Singapore'
WHEN county_code =189 THEN'South Africa'
WHEN county_code =191 THEN 'Sri Lanka'
WHEN county_code =208 THEN 'Turkey'
ELSE NULL 
END;

select * from zomato;

select * from country_code;


-- Looking for McDonald's --
SELECT * FROM zomato 
WHERE `Restaurant Name` LIKE'McD%'AND `Has Online delivery`='Yes' ;


-- Top 10 restaurants with most outlet in a city --
SELECT   `Restaurant Name`, City,COUNT(`Restaurant Name`) AS Total_Restaurants  FROM zomato 
GROUP BY `Restaurant Name`,City
ORDER BY COUNT(`Restaurant Name`) DESC
LIMIT 10;

-- Droppiing a column
ALTER TABLE zomato DROP COLUMN `Price range`;
select * from zomato






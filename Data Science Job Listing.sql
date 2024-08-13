-- Data Cleaning

SELECT *
FROM data_science_listing;

CREATE TABLE ds_listing
LIKE data_science_listing;

SELECT *
FROM ds_listing;

INSERT ds_listing
SELECT *
FROM data_science_listing;

SELECT *
FROM ds_listing;

ALTER TABLE ds_listing
	RENAME 	COLUMN `Position` to `position`;
    
ALTER TABLE ds_listing
	RENAME 	COLUMN `Job Title` to `job_title`;
    
ALTER TABLE ds_listing
	RENAME 	COLUMN `Company Name` to `company_name`;
    
ALTER TABLE ds_listing
	RENAME 	COLUMN `Location` to `location`;
    
ALTER TABLE ds_listing
	RENAME 	COLUMN `Salary` to `salary`;
    
ALTER TABLE ds_listing
	RENAME 	COLUMN `Date` to `date`;
    
ALTER TABLE ds_listing
	RENAME 	COLUMN `Logo` to `logo`;
    
ALTER TABLE ds_listing
	RENAME 	COLUMN `Job Link` to `job_link`;
    
ALTER TABLE ds_listing
	RENAME 	COLUMN `Company Rating` to `company_rating`;
    
SELECT *
FROM ds_listing;


-- Remove Duplicates

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY job_title, company_name, location, salary, `date`, company_rating) as row_num
FROM ds_listing
;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY job_title, company_name, location, salary, `date`, company_rating) as row_num
FROM ds_listing
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1
;


CREATE TABLE `ds_listing2` (
  `position` int DEFAULT NULL,
  `job_title` text,
  `company_name` text,
  `location` text,
  `salary` text,
  `date` text,
  `logo` text,
  `job_link` text,
  `company_rating` double DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM ds_listing2;

INSERT INTO ds_listing2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY job_title, company_name, location, salary, `date`, company_rating) as row_num
FROM ds_listing
;

SELECT *
FROM ds_listing2
WHERE row_num > 1;

DELETE
FROM ds_listing2
WHERE row_num > 1;

SELECT *
FROM ds_listing2;


-- Standardizing Data

SELECT DISTINCT(company_name)
FROM ds_listing2
ORDER BY 1;

UPDATE ds_listing2
SET company_name = 'Esquire Law'
WHERE company_name LIKE 'Esquire%';

SELECT DISTINCT(job_title)
FROM ds_listing2
ORDER BY 1;

UPDATE ds_listing2
SET job_title = 'Applied Scientist'
WHERE job_title LIKE 'Applied Scientist%';

UPDATE ds_listing2
SET job_title = 'Data Analyst'
WHERE job_title LIKE 'Data Analy%';

UPDATE ds_listing2
SET job_title = 'Data Engineer'
WHERE job_title LIKE 'Data Engineer%';

UPDATE ds_listing2
SET job_title = 'Data Science'
WHERE job_title LIKE 'Data Scien%';

UPDATE ds_listing2
SET job_title = 'Director Data Science'
WHERE job_title LIKE 'Director, Data%';

UPDATE ds_listing2
SET job_title = 'Director Data Science'
WHERE job_title LIKE 'Director I,%';

UPDATE ds_listing2
SET job_title = 'Junior Data Scientist'
WHERE job_title LIKE 'Junior Data Science%';

UPDATE ds_listing2
SET job_title = 'Lead Data Scientist'
WHERE job_title LIKE 'Lead Data Science%';

UPDATE ds_listing2
SET job_title = 'Manager Data Scientist'
WHERE job_title LIKE 'Manager - Data Scien%';

UPDATE ds_listing2
SET job_title = 'Manager Data Scientist'
WHERE job_title LIKE 'Manager -Data Scien%';

UPDATE ds_listing2
SET job_title = 'Manager Data Scientist'
WHERE job_title LIKE 'Manager, Data Scien%';

UPDATE ds_listing2
SET job_title = 'OAG #24-196:Data Miner - Reasearch Data Analyst'
WHERE job_title LIKE 'OAG%';

UPDATE ds_listing2
SET job_title = 'Principal Data Scientist'
WHERE job_title LIKE 'Principal Data Scine%';

UPDATE ds_listing2
SET job_title = 'Quantitative Analytics Senior'
WHERE job_title LIKE 'Quantitative Analytics%';

UPDATE ds_listing2
SET job_title = 'Researcher Scientist'
WHERE job_title LIKE 'Research%';

UPDATE ds_listing2
SET job_title = 'Senior Data Analyst'
WHERE job_title LIKE 'Senior Data Analyst%';

UPDATE ds_listing2
SET job_title = 'Senior Data Scientist'
WHERE job_title LIKE 'Senior Data Scien%';

UPDATE ds_listing2
SET job_title = 'Senior Research Data Scientist'
WHERE job_title LIKE 'Senior Research Scien%';

UPDATE ds_listing2
SET job_title = 'Senior Financial Data Analyst'
WHERE job_title LIKE 'Sr. Data Analyst%';

UPDATE ds_listing2
SET job_title = 'Supply Chain Analyst'
WHERE job_title LIKE 'Supply Chain%';

SELECT DISTINCT(location)
FROM ds_listing2
ORDER BY 1;

SELECT location, 
SUBSTRING(location, 1, LOCATE(',',location)) AS city,
SUBSTRING(location, LOCATE(',', location), LENGTH(location)) AS state
FROM ds_listing2;

ALTER TABLE ds_listing2
ADD city text;

UPDATE ds_listing2
SET city = SUBSTRING(location, 1, LOCATE(',',location));

ALTER TABLE ds_listing2
ADD state text;

UPDATE ds_listing2
SET state = SUBSTRING(location, LOCATE(',', location), LENGTH(location));

SELECT *
FROM ds_listing2;

SELECT DISTINCT city, TRIM(TRAILING ',' FROM city)
FROM ds_listing2;

UPDATE ds_listing2
SET city = TRIM(TRAILING ',' FROM city);

SELECT DISTINCT state, TRIM(',' FROM state)
FROM ds_listing2;

UPDATE ds_listing2
SET state = TRIM(',' FROM state);

SELECT *
FROM ds_listing2;

SELECT DISTINCT state
FROM ds_listing2;

UPDATE ds_listing2
SET state = TRIM(' ' FROM state);

UPDATE ds_listing2
SET state = 'New York'
WHERE state LIKE 'NY';

UPDATE ds_listing2
SET state = 'Texas'
WHERE state LIKE 'TX';

UPDATE ds_listing2
SET state = 'Nevada'
WHERE state LIKE 'NV';

UPDATE ds_listing2
SET state = 'Virginia'
WHERE state LIKE 'VA';

UPDATE ds_listing2
SET state = 'California'
WHERE state LIKE 'CA';

UPDATE ds_listing2
SET state = 'Tennessee'
WHERE state LIKE 'TENNEESSEE';

UPDATE ds_listing2
SET state = 'Connecticut'
WHERE state LIKE 'CT';

UPDATE ds_listing2
SET state = 'North Carolina'
WHERE state LIKE 'NC';

UPDATE ds_listing2
SET state = 'Wisconsin'
WHERE state LIKE 'WI';

UPDATE ds_listing2
SET state = 'Washington'
WHERE state LIKE 'WA';

UPDATE ds_listing2
SET state = 'Georgia'
WHERE state LIKE 'GA';

UPDATE ds_listing2
SET state = 'Pennsylvania'
WHERE state LIKE 'PA';

UPDATE ds_listing2
SET state = 'District of Columbia'
WHERE state LIKE 'DC';

UPDATE ds_listing2
SET state = 'Ohio'
WHERE state LIKE 'OH';

UPDATE ds_listing2
SET state = 'New Jersey'
WHERE state LIKE 'NJ';

UPDATE ds_listing2
SET state = 'Florida'
WHERE state LIKE 'FL';

UPDATE ds_listing2
SET state = 'Delaware'
WHERE state LIKE 'DE';

UPDATE ds_listing2
SET state = 'Louisiana'
WHERE state LIKE 'LA';

UPDATE ds_listing2
SET state = 'Illinois'
WHERE state LIKE 'IL';

UPDATE ds_listing2
SET state = 'Minnesota'
WHERE state LIKE 'MN';

UPDATE ds_listing2
SET state = 'Arizona'
WHERE state LIKE 'AZ';

UPDATE ds_listing2
SET state = 'Massachusetts'
WHERE state LIKE 'MA';

UPDATE ds_listing2
SET state = 'Indiana'
WHERE state LIKE 'IN';

UPDATE ds_listing2
SET state = 'New Hampshire'
WHERE state LIKE 'NH';

UPDATE ds_listing2
SET state = 'Maryland'
WHERE state LIKE 'Md';

UPDATE ds_listing2
SET state = 'Alabama'
WHERE state LIKE 'AL';

UPDATE ds_listing2
SET state = 'Colorado'
WHERE state LIKE 'CO';

UPDATE ds_listing2
SET state = 'South Carolina'
WHERE state LIKE 'SC';

UPDATE ds_listing2
SET state = 'Utah'
WHERE state LIKE 'UT';

UPDATE ds_listing2
SET state = 'Mississippi'
WHERE state LIKE 'MS';

UPDATE ds_listing2
SET state = 'Kansas'
WHERE state LIKE 'KS';

UPDATE ds_listing2
SET state = 'Michigan'
WHERE state LIKE 'MI';

UPDATE ds_listing2
SET state = 'Nebraska'
WHERE state LIKE 'NE';

UPDATE ds_listing2
SET state = 'Oregon'
WHERE state LIKE 'OR';

UPDATE ds_listing2
SET state = 'Kentucky'
WHERE state LIKE 'KY';

SELECT DISTINCT city, state
FROM ds_listing2
ORDER BY 1;

UPDATE ds_listing2
SET city = 'New York City'
WHERE city LIKE 'New York';

SELECT *
FROM ds_listing2;

SELECT company_name,
SUBSTR(company_name,1 , LENGTH(company_name) - 3) AS cleaned_company_name
FROM ds_listing2;

UPDATE ds_listing2
SET company_name = SUBSTR(company_name,1 , LENGTH(company_name) - 3);

UPDATE ds_listing2
SET salary = TRIM(TRAILING  '(' FROM salary);

SELECT salary1, salary2
FROM ds_listing2
;

SELECT salary, 
SUBSTRING(salary, 1, LOCATE(' ', salary)) AS salary1,
SUBSTRING(salary, LOCATE(' ', salary), LENGTH(salary)) AS salary2
FROM ds_listing2;

ALTER TABLE ds_listing2
ADD salary1 text;

UPDATE ds_listing2
SET salary1 = SUBSTRING(salary, 1, LOCATE(' ', salary));

ALTER TABLE ds_listing2
ADD salary2 text;

UPDATE ds_listing2
SET salary2 = SUBSTRING(salary, LOCATE(' ', salary), LENGTH(salary));

SELECT DISTINCT salary2,
TRIM(LEADING ' - ' FROM salary2),
TRIM(TRAILING ' ' FROM salary2)
FROM ds_listing2;

SELECT TRIM(TRAILING ' ' FROM salary2),
TRIM(LEADING ' - ' from salary2),
LENGTH(TRIM(LEADING ' - ' from salary2))
FROM ds_listing2;

UPDATE ds_listing2
SET salary2 = TRIM(LEADING ' - ' FROM salary2);

SELECT salary1, salary2
FROM ds_listing2
;

UPDATE ds_listing2
SET salary1 = '$147K'
WHERE salary1 LIKE '$70.00%';

UPDATE ds_listing2
SET salary2 = '$168KB'
WHERE salary2 LIKE '$168K%';

UPDATE ds_listing2
SET salary1 = '$84K'
WHERE salary1 LIKE '$84K%';

UPDATE ds_listing2
SET salary2 = '$95KB'
WHERE salary2 LIKE '$95K%';

UPDATE ds_listing2
SET salary1 = '$73K'
WHERE salary1 LIKE '$35.0%';

UPDATE ds_listing2
SET salary2 = '$78KB'
WHERE salary2 LIKE '$78K%';

UPDATE ds_listing2
SET salary1 = '$63K'
WHERE salary1 LIKE '$30.0%';

UPDATE ds_listing2
SET salary2 = '$105KB'
WHERE salary2 LIKE '$105K%';

UPDATE ds_listing2
SET salary1 = '$116K'
WHERE salary1 LIKE '$55.0%';

UPDATE ds_listing2
SET salary2 = '$137KB'
WHERE salary2 LIKE '$137K%';

UPDATE ds_listing2
SET salary1 = null
WHERE salary1 LIKE '$23.00B%';

UPDATE ds_listing2
SET salary2 = NULL
WHERE salary2 = '%H0%';

UPDATE ds_listing2
SET salary1 = '$111K'
WHERE salary1 LIKE '$52.8%';

UPDATE ds_listing2
SET salary2 = '$150KB'
WHERE salary2 LIKE '150K%';

UPDATE ds_listing2
SET salary1 = '$116K'
WHERE salary1 LIKE '$55.0%';

UPDATE ds_listing2
SET salary2 = '$126KB'
WHERE salary2 LIKE '$126Kb%';

UPDATE ds_listing2
SET salary2 = '$137KB'
WHERE salary2 LIKE '$137K%';

UPDATE ds_listing2
SET salary1 = '$107K'
WHERE salary1 LIKE '$50.72%';

UPDATE ds_listing2
SET salary2 = '$147KB'
WHERE salary2 LIKE '$147B%';

UPDATE ds_listing2
SET salary1 = '$152K'
WHERE salary1 LIKE '$72.52%';

UPDATE ds_listing2
SET salary2 = '$244KB'
WHERE salary2 LIKE '$244K%';

UPDATE ds_listing2
SET salary1 = '$66K'
WHERE salary1 LIKE '$31.43%';

UPDATE ds_listing2
SET salary2 = '$83KB'
WHERE salary2 LIKE '$83K%';

UPDATE ds_listing2
SET salary1 = NULL
WHERE salary1 LIKE '$20.00B%';

UPDATE ds_listing2
SET salary1 = NULL
WHERE salary1 LIKE '$17.00B%';

UPDATE ds_listing2
SET salary1 = NULL
WHERE salary1 LIKE '$50.00B%';

UPDATE ds_listing2
SET salary1 = NULL
WHERE salary1 LIKE '$14.00B%';

UPDATE ds_listing2
SET salary1 = '$52K'
WHERE salary1 LIKE '$25.0%';

UPDATE ds_listing2
SET salary2 = '$73KB'
WHERE salary2 LIKE '$73K%';

UPDATE ds_listing2
SET salary1 = '$66K'
WHERE salary1 LIKE '$31.45%';

UPDATE ds_listing2
SET salary2 = '$89KB'
WHERE salary2 LIKE '$89%';

UPDATE ds_listing2
SET salary1 = '$44K'
WHERE salary1 LIKE '$21.0%';

UPDATE ds_listing2
SET salary2 = '$48KB'
WHERE salary2 LIKE '$48%';

UPDATE ds_listing2
SET salary1 = '$130K'
WHERE salary1 LIKE '$62.0%';

UPDATE ds_listing2
SET salary2 = '$152KB'
WHERE salary2 LIKE '$152K%';

UPDATE ds_listing2
SET salary1 = '$95K'
WHERE salary1 LIKE '$45.0%';

UPDATE ds_listing2
SET salary2 = '$137KB'
WHERE salary2 LIKE '$137K%';

UPDATE ds_listing2
SET salary1 = '$50K'
WHERE salary1 LIKE '$24.0%';

UPDATE ds_listing2
SET salary2 = '$105KB'
WHERE salary2 LIKE '$105K%';

UPDATE ds_listing2
SET salary1 = '$126K'
WHERE salary1 LIKE '$60.0%';

UPDATE ds_listing2
SET salary2 = '$127KB'
WHERE salary2 LIKE '$60.5%';

UPDATE ds_listing2
SET salary1 = NULL
WHERE salary1 LIKE '$75.00B%';

UPDATE ds_listing2
SET salary1 = '$110K'
WHERE salary1 LIKE '$52.25%';

UPDATE ds_listing2
SET salary2 = '$150KB'
WHERE salary2 LIKE '$150K%';

SELECT salary1, salary2
FROM ds_listing2;

ALTER TABLE ds_listing2
RENAME COLUMN `date` to job_posted;


-- NULL Values and blank Values

UPDATE ds_listing2
SET salary1 = NULL
WHERE salary1 = '';

UPDATE ds_listing2
SET salary2 = NULL
WHERE salary2 = '';

DELETE 
FROM ds_listing2
WHERE salary1 IS NULL 
AND salary2 IS NULL
;

UPDATE ds_listing2
SET city = NULL
WHERE city = '';

UPDATE ds_listing2
SET state = NULL
WHERE state = '';

DELETE 
FROM ds_listing2
WHERE city IS NULL 
AND state IS NULL
;

SELECT *
FROM ds_listing2
ORDER BY 1
;


-- Remove any Column


ALTER TABLE ds_listing2
DROP COLUMN row_num;

ALTER TABLE ds_listing2
DROP COLUMN location;

ALTER TABLE ds_listing2
DROP COLUMN salary;

ALTER TABLE ds_listing2
DROP COLUMN logo;

ALTER TABLE ds_listing2
DROP COLUMN job_link;

SELECT *,
CONCAT(salary1, ' - ', salary2) AS salary
FROM ds_listing2;

ALTER TABLE ds_listing2
ADD salary text;

UPDATE ds_listing2
SET salary = CONCAT(salary1, ' - ', salary2);

SELECT *
FROM ds_listing2
ORDER BY 1
;

ALTER TABLE ds_listing2
DROP COLUMN salary1;

ALTER TABLE ds_listing2
DROP COLUMN salary2;

SELECT *
FROM ds_listing2
ORDER BY 1
;

SELECT `position`, salary
FROM ds_listing2
ORDER BY 1
;

DELETE 
FROM ds_listing2
WHERE `position` = 17
;

DELETE 
FROM ds_listing2
WHERE `position` = 81
;

DELETE 
FROM ds_listing2
WHERE `position` = 100
;

DELETE 
FROM ds_listing2
WHERE `position` = 112
;

DELETE 
FROM ds_listing2
WHERE `position` = 155
;

DELETE 
FROM ds_listing2
WHERE `position` = 205
;

DELETE 
FROM ds_listing2
WHERE `position` = 304
;

DELETE 
FROM ds_listing2
WHERE `position` = 423
;

SELECT *
FROM ds_listing2
ORDER BY 1
;



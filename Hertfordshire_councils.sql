-- CREATE THE DATABASE --
CREATE DATABASE
hertfordshire_councils;

-- USE THE DATABASE --

USE hertfordshire_councils;


-- CREATE councils TABLE

CREATE TABLE councils (
    council_id INT PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	type VARCHAR(50),
	contact_number VARCHAR(20),
	email VARCHAR(200)
);


-- CREATE populations TABLE

CREATE TABLE populations (
    populations_id INT PRIMARY KEY,
	council_id INT,
	year INT,
	population INT,
	FOREIGN KEY (council_id)
	REFERENCES councils(council_id)
);

                       
-- INSERT SAMPLE DATA INTO councils --

INSERT INTO councils (council_id, name, type, contact_number, email)
VALUES
(1, 'Hertsmere', 'Borough', '0208 207 2277', 'info@hertsmere.gov.uk'),
(2, 'Watford', 'Borough', '01923 226400', 'enquiries@watford.gov.uk'),
(3, 'Stevenage', 'Borough', '01438 242242', 'customer.service@stevenage.gov.uk'),
(4, 'Dacorum', 'District', '01442 228000', 'info@dacorum.gov.uk'),
(5, 'Broxbourne', 'Borough', '01992 785577', 'customer.services@broxbourne.gov.uk')
;


-- INSERT SAMPLE DATA INTO populations --

INSERT INTO populations (populations_id, council_id, year, population)
VALUES
(1, 1, 2020, 1056000),
(2, 2, 2020, 96500),
(3, 3, 2020, 88200),
(4, 4, 2020, 154300),
(5, 5, 2020, 97000)
;

-- LETS LOOK AT THE TABLES CREATED --

SELECT *
FROM councils
;

SELECT *
FROM populations
;


-- TRYING OUT SOME SQL QUERIES --

-- SELECT STATEMENT --

SELECT Name, type 
FROM councils
;

SELECT year, population
FROM populations
;


-- SELECT DISTINCT --
SELECT DISTINCT type
FROM councils;


-- WHERE CLAUSE--
SELECT *
FROM councils
WHERE  type = 'District'
;

SELECT *
FROM populations
WHERE population = 88200
;


-- LOGICAL OPERATORS AND, OR, NOT

SELECT *
FROM councils
WHERE type = 'District' AND 
contact_number IS NOT NULL
;

SELECT *
FROM councils
WHERE type = 'District' OR type = 'Borough'
;

SELECT *
FROM councils
WHERE NOT email LIKE '%@gov.uk'
;


--LIKE STATEMENT --
SELECT *
FROM councils 
WHERE contact_number LIKE '01%'
;

SELECT *
FROM councils
WHERE name LIKE 'S%'
;
 

 -- GROUP BY AND ORDER BY --
 SELECT name, type
 FROM councils
 GROUP BY name, type
 ORDER BY name DESC
 ;

 SELECT type,
  COUNT(*) AS council_count
  FROM councils
  GROUP BY type
 ORDER BY council_count
 ;


 --HAVING CLAUSE --
 
 SELECT type,
  COUNT(*) AS council_count
  FROM councils
  GROUP BY type
  HAVING COUNT(*) > 2
  ;



  -- LIMIT(TOP) AND AS --

  SELECT TOP 5 name, type 
  FROM councils
  ORDER BY name ASC
  ;

  SELECT name AS council_name,
         type AS council_type
		 FROM councils
		 ;


 -- INNER JOIN --

 SELECT councils.name, councils.type, populations.year, populations.population
 FROM councils INNER JOIN populations ON councils.council_id = populations.council_id
 ;

  -- UNIONS --

  SELECT name, type
  FROM councils
  WHERE  type = 'District'
  UNION
  SELECT name, type 
  FROM councils
  WHERE type = 'Borough'
  ;

  -- UNION ALL --

  SELECT name, type
  FROM councils
  WHERE type = 'District'
  UNION ALL
  SELECT name, type
  FROM councils
  WHERE type = 'Borough'
  ;


  -- UNION DISTINCT --

  SELECT DISTINCT name, type
  FROM (SELECT name, type
  FROM councils
  WHERE type = 'District'
  UNION ALL
  SELECT name, type
  FROM councils
  WHERE type = 'Borough') AS combined
  ;


  -- STRING FUNCTIONS --
 -- (UPPER) --

 SELECT UPPER(name) AS Uppercase_name
 FROM councils
 ;

 -- (LOWER) --

 SELECT LOWER(name) AS Lowercase_name
 FROM councils;


-- (LEFT) --

SELECT LEFT(name, 3) AS left_three_chars
FROM councils
;

-- (RIGHT) --

SELECT RIGHT(name, 3) AS right_three_chars
FROM councils;


-- (TRIM) --

SELECT TRIM('    ' FROM name) AS trimmed_name
FROM councils;

-- (SUBSTRING) --

SELECT SUBSTRING(name, 1, 5) AS substring_name
FROM councils
;

-- (REPLACE) --

SELECT REPLACE(name, 'council', 'C') AS replaced_name
FROM councils
;


-- (LOCATE/CHARINDEX) --

SELECT CHARINDEX('Herts', name)
FROM councils
;

-- (CONCAT) --

SELECT CONCAT(name, ' ', type) AS full_name 
FROM councils


-- CASE STATEMENT --

SELECT name,
    CASE
       WHEN type ='District' THEN 'District Council'
	   WHEN type = 'Borough' THEN 'Borough Council'
	   ELSE 'Unknown Type'
	   END AS council_type_description
	   FROM councils
	   ;

-- SUBQUERY --

SELECT name, type 
FROM councils
WHERE council_id IN (
SELECT council_id
FROM populations
WHERE population > 100000
);


--WINDOW FUNCTIONS --

SELECT name, type, ROW_NUMBER() OVER
(PARTITION BY type ORDER BY name) AS row_num
FROM councils
;


-- VIEW --

CREATE VIEW council_population_summaary AS
 SELECT councils.name, councils.type, populations.year, populations.population
 FROM councils INNER JOIN populations ON councils.council_id = populations.council_id
 ;


 SELECT *
 FROM council_population_summaary
 ;


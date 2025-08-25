CREATE DATABASE IF NOT EXISTS orangetheory_locations;
USE orangetheory_locations;

DROP TABLE IF EXISTS orangetheory_studios;

CREATE TABLE orangetheory_studios (
  id            VARCHAR(64) PRIMARY KEY,   -- UUIDs; CHAR(36) also fine
  name          VARCHAR(120),
  status        VARCHAR(50),
  address       VARCHAR(255),
  city          VARCHAR(120),
  state         VARCHAR(50),
  postal_code   VARCHAR(20),               -- keep as text (leading zeros)
  latitude      DECIMAL(10,8),
  longitude     DECIMAL(11,8)
);

LOAD DATA LOCAL INFILE '/Users/madelineswallows/Downloads/orangetheory_studios_mysql_ready.csv'
INTO TABLE orangetheory_studios
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, name, status, address, city, state, postal_code, latitude, longitude);

SELECT * FROM orangetheory_studios;

DROP TABLE IF EXISTS otf_with_demographics;

CREATE TABLE otf_with_demographics (
    id VARCHAR(64) PRIMARY KEY,
    GEOID VARCHAR(32),
    matched_place VARCHAR(255),
    total_employed INT,
    practitioners INT,
    technologists INT,
    total_population INT,
    pct_medical_professionals DECIMAL(15,10)
);

LOAD DATA LOCAL INFILE '/Users/madelineswallows/Downloads/otf_with_demographics_mysql_ready.csv'
INTO TABLE otf_with_demographics
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, GEOID, matched_place, total_employed, practitioners, technologists, total_population, pct_medical_professionals);

DROP TABLE IF EXISTS isochrone_demographics;

CREATE TABLE isochrone_demographics (
    iso_id VARCHAR(128) PRIMARY KEY,
    total_population INT,
    weighted_income DECIMAL(20,4)
);

LOAD DATA LOCAL INFILE '/Users/madelineswallows/Downloads/isochrone_demographics.csv'
INTO TABLE isochrone_demographics
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(iso_id, total_population, weighted_income);

DROP TABLE IF EXISTS otf_with_isochrone;

CREATE TABLE otf_with_isochrone (
    id VARCHAR(64) PRIMARY KEY,
    iso_id VARCHAR(128),
    GEOID VARCHAR(32),
    total_employed INT,
    practitioners INT,
    technologists INT,
    otf_population INT,
    pct_medical_professionals DECIMAL(15,10),
    iso_population INT,
    weighted_income DECIMAL(20,4)
);

INSERT INTO otf_with_isochrone
SELECT 
    o.id,
    i.iso_id,
    o.GEOID,
    o.total_employed,
    o.practitioners,
    o.technologists,
    o.total_population AS otf_population,
    o.pct_medical_professionals / 100 AS pct_medical_professionals,
    i.total_population AS iso_population,
    i.weighted_income
FROM otf_with_demographics o
JOIN isochrone_demographics i
    ON i.iso_id = CONCAT(o.id, '_8min');
    
SELECT * FROM otf_with_isochrone;

SELECT *
FROM orangetheory_studios s
JOIN otf_with_isochrone o
	ON s.id = o.id;
    
SELECT s.city, s.state, o.pct_medical_professionals
FROM orangetheory_studios s
JOIN otf_with_isochrone o
	ON s.id = o.id
GROUP BY s.city, s.state, o.pct_medical_professionals;

SELECT s.id, s.city, s.state, o.iso_population, o.weighted_income
FROM orangetheory_studios s
JOIN otf_with_isochrone o
	ON s.id = o.id;
















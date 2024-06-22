CREATE DATABASE Human_Resources;

 USE Human_Resources;
 
 SELECT * FROM HR;
 
 ALTER TABLE HR
 CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;
 
 DESCRIBE HR;
 
 SELECT birthdate FROM HR;
 
 SET sql_safe_updates = 0;
 
 UPDATE HR
 SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE HR
MODIFY COLUMN birthdate DATE;

UPDATE HR
 SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE HR
MODIFY COLUMN hire_date DATE;

UPDATE HR
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE HR
MODIFY COLUMN termdate DATE;

ALTER TABLE HR
ADD COLUMN AGE INT;

UPDATE HR
SET AGE = timestampdiff(YEAR, birthdate, CURDATE());

SELECT
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM HR;

SELECT COUNT(*) FROM HR WHERE age < 18;

 SELECT * FROM HR;
 
 
    
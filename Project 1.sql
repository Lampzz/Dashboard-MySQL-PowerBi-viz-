
-- Question 1
-- What is the gender breakdown of employees in the company?

SELECT gender, count(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;

-- Question 2
-- What is the race/ethnicity breakdown of employees in the company?

SELECT race, count(*) AS count
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;

-- Question 3
-- What is the age distribution of employees in the company?

SELECT
	min(age) AS youngest,
    max(age) AS oldest
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00';

SELECT
	CASE
		WHEN age >= 18 AND age <= 24 THEN '18-24'
		WHEN age >= 25 AND age <= 34 THEN '25-34'
		WHEN age >= 35 AND age <= 44 THEN '35-44'
		WHEN age >= 45 AND age <= 54 THEN '45-64'
		WHEN age >= 55 AND age <= 64 THEN '55-64'
		ELSE '65+'
	END AS age_group,
count(*) AS COUNT
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;

SELECT
	CASE
		WHEN age >= 18 AND age <= 24 THEN '18-24'
		WHEN age >= 25 AND age <= 34 THEN '25-34'
		WHEN age >= 35 AND age <= 44 THEN '35-44'
		WHEN age >= 45 AND age <= 54 THEN '45-64'
		WHEN age >= 55 AND age <= 64 THEN '55-64'
		ELSE '65+'
	END AS age_group, gender,
count(*) AS COUNT
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- Question 4
-- How many employees work at the headquarters versus remote locations?

SELECT location, count(*) AS COUNT
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;

-- Question 5
-- What is the average length of employment for employees who have been terminated?

SELECT 
	round(AVG(datediff(termdate, hire_date))/365,0) AS avg_length
FROM HR
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >=18;

-- Question 6
-- How does the gender distribution cary across departments and job titles?

SELECT department, gender, count(*) AS COUNT
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

-- Question 7
-- What is the distribution of job titles across the company?

SELECT jobtitle, count(*) AS COUNT
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- Question 8
-- Which department has the highest turnover rate?

SELECT department,
	total_count,
	terminated_count,
	terminated_count/total_count AS termination_rate
FROM (
	SELECT department,
    count(*) AS total_count,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate()THEN 1 ELSE 0 END) AS terminated_count
    FROM HR
    WHERE age >= 18
    GROUP BY department
    ) AS subquery
ORDER BY termination_rate DESC;

-- Question 9
-- What is the distribution of employees across locations by city and state?

SELECT location_state, count(*) AS COUNT
FROM HR
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY COUNT DESC;

-- Question 10
-- How has the company's employee count change over time based on hire and term dates?

SELECT
	year,
    hires,
    terminations,
    hires - terminations as net_change,
    round((hires - terminations)/hires*100,2) AS net_change_percent
FROM(
	SELECT 
		YEAR(hire_date) AS year,
		count(*) AS hires,
		SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate()THEN 1 ELSE 0 END) AS terminations
		FROM HR
		WHERE age >=18
		GROUP BY YEAR(hire_date)
		) AS subquery
ORDER by year ASC;

-- Question 11
-- What is the tenure distribution for each department?

SELECT department, round(AVG(datediff(termdate, hire_date)/365),0) AS avg_tenure
FROM HR
WHERE termdate <= curdate() AND termdate <> '0000-00-00' and age >= 18
GROUP BY department;








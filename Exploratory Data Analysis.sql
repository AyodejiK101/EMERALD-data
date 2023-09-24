select * from employee_test
select * from employee_perf

--1.What is the average training score of employees in each department
SELECT 
	Department,
	round(avg(avg_training_score),1 )as AVG_score
FROM
	Employee_test
GROUP BY Department
ORDER BY AVG_score DESC;

--2.What is the average previous year rating by department?
SELECT
	Department,
	round(avg(previous_year_rating),1)as AVG_PREVIOUS_YEAR
FROM employee_test
Group by department;

--3.What is the average training score of employees by education type?
SELECT
	education,
	round(avg(avg_training_score),1 )as AVG_score
FROM employee_test
Group by education;

--4.Group Average training score into grades (A,B,C,D,E,F) and what grade had the highest and lowest number of employees
SELECT
	CASE
	WHEN avg_training_score >=80 then 'A'
	WHEN avg_training_score BETWEEN 70 AND 79 then 'B'
	WHEN avg_training_score BETWEEN 60 AND 69 then 'C'
	WHEN avg_training_score BETWEEN 50 AND 59 then 'D'
	WHEN avg_training_score BETWEEN 40 AND 49 then 'E'
	ELSE 'F'
	END as Grade,
	count (employee_id) as EmployeeCount
	From Employee_test
	group by grade
	order by EmployeeCount desc;




--5.Which three departments have the highest average job satisfaction among employees with a Bachelor's degree?
SELECT 
	et.department, round(avg(ep.jobsatisfaction),1) as Job_satisfaction, education
FROM 
	Employee_perf as ep
		JOIN employee_test as et
			on et.employee_id = ep.employee_id
WHERE
	education ilike 'bachelo%'
GROUP BY 
	et.department, education
ORDER BY 
	Job_satisfaction desc
limit 3;

--6.What is the average previous year rating by recruitment channel?
SELECT
	recruitment_channel as rc, 
	round(avg(previous_year_rating),1) as AVG_previous_Year_rating
FROM
	Employee_test
GROUP BY rc;

--7.What is the split of gender by the previous year rating?
SELECT
	Gender, 
	count(previous_year_rating) as Prv_year_rating
FROM
	Employee_test
GROUP BY gender;

--8.Based on the age group created what is the average previous year rating and average training score.
SELECT 
	CASE
	WHEN age between 20 and 29 then '20-29'
	WHEN age between 30 and 39 then '30-39'
	WHEN age between 40 and 49 then '40-49'
	WHEN age between 50 and 59 then '50-59'
	else '>60'
	end as Age_group,
	Round(avg(previous_year_rating),1) as avg_Previous_year_rating, 
	round(avg(avg_training_score),1) as avg_Training_score
FROM
	Employee_test
GROUP BY Age_group;
	
--9.What is the average age of male and female employees, and how many employees are there for each gender?
SELECT
	gender,
	count (employee_id),
	ROUND(AVG (AGE)) AS AVG_AGE
From Employee_test
GROUP BY  gender;

--10.Who are the top 5 highest-earning employees with a JobLevel of 3 or higher?

SELECT 
	employee_id, Monthlyincome, joblevel
FROM 
	employee_perf
WHERE 
	joblevel >=3
ORDER BY Monthlyincome desc
limit 5;


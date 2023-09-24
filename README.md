# EMERALD SQL files
SQL files and process to aid descision making for Employee promotions in Emerals Technologies

#Tailored Data Analytics using sql 
![image](https://github.com/AyodejiK101/EMERALD-data/assets/140984130/4d1a3843-b371-4464-ac03-54a7b3755c08)


#--1.How many employees do we have in the organization and what is the maximum length of service?
- SELECT  
	COUNT (employee_id) as Total_Employees,
	MAX(Length_of_service) as Max_YearsInService
FROM Employee_test;

#--2.How many employees are there in each department?
- SELECT 
	distinct department,
	COUNT(Employee_id) as Number_of_Employees
FROM Employee_test
GROUP BY department
order by Number_of_Employees desc;

#--3.What is the proportion of male to female employees?
- SELECT
	gender,
	count (employee_id) as Employees
FROM
	Employee_test
GROUP BY Gender;

#--4.Group Employee age into 5 categories (20 – 29, 30 – 39, 40-49, 50-59, >60). What age group has the highest and lowest employee?
- SELECT 
	CASE
	WHEN age between 20 and 29 then '20-29'
	WHEN age between 30 and 39 then '30-39'
	WHEN age between 40 and 49 then '40-49'
	WHEN age between 50 and 59 then '50-59'
	else '>60'
	end as Age_group,
COUNT (Employee_id) AS Employee_count
FROM Employee_test
GROUP BY Age_group
order by Employee_count desc;

--5.Who works in the Finance department?
SELECT *
FROM Employee_test
where department  ilike '%finance%';

--6.Who has the highest average training score among all employees?
SELECT 
	Employee_id, 
	Max(avg_training_score)as Score
FROM Employee_test
group by Employee_id
order by Score desc
limit 2; -- we have a tie

--7.Which regions have the highest number of departures (employees who have left), and what are the corresponding departments?
SELECT
	et.region, et.department, count (et.employee_id) as Depatures
FROM employee_perf as ep
	join Employee_test as et 
	on et.employee_id = ep.employee_id
where ep.attrition ='Yes'
Group by et.region, et.department
order by Depatures desc;

--8.Which department has the most employees, and which department has the fewest employees?
SELECT 
	distinct department, count (employee_id) as Number_of_employees
	from employee_test
	group by department
	order by Number_of_employees desc;
	
--9.Who are the top 5 highest-earning employees in the 'Technology' department?
SELECT
	et.Employee_id, ep.monthlyincome AS INCOME
FROM 
	Employee_test as et
Join Employee_perf as ep
	on et.employee_id = ep.employee_id
where et.department ilike 'Technology'
GROUP BY et.Employee_id, ep.monthlyincome 
ORDER BY INCOME desc
limit 5;

--10.Who are the employees with awards in departments with more than 100 employees, and what are their department names?
SELECT 
	ep.*, et.department
FROM employee_perf AS ep
INNER JOIN employee_test AS et 
          ON ep.employee_id = et.employee_id
WHERE et.awards_won = 1
AND et.department IN (
    SELECT department
    FROM employee_test
    GROUP BY department
    HAVING COUNT(employee_id) > 100

WITH CTE_Example  (Gender,avg_sal,max_salary,min_salary,count_sal) AS
(
SELECT 	gender, AVG(salary) avg_sal ,MAX(salary),MIN(salary),COUNT(salary)
FROM employee_demographics ed
JOIN employee_salary es
ON ed.employee_id=es.employee_id
group by gender
)	
SELECT * FROM
CTE_Example

;

WITH CTE_Example AS 
(
SELECT 	employee_id,gender,birth_date
FROM employee_demographics 
where birth_date>'1985-01-01'
)	,
CTE_Example2 AS 
(
SELECT 	employee_id,salary
FROM employee_salary 
where salary>50000
)	

SELECT * 
FROM CTE_Example
JOIN CTE_Example2
ON CTE_Example.employee_id=CTE_Example2.employee_id
;
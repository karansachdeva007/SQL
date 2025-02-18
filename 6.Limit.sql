-- LIMIT 

SELECT * 
FROM employee_demographics
order by age DESC
LIMIT 3
;


SELECT * 
FROM employee_demographics
order by age DESC
LIMIT 1,2
;
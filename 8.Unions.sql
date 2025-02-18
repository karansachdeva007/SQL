SELECT first_name,last_name FROM employee_demographics
UNION distinct
SELECT first_name,last_name FROM employee_salary;



SELECT first_name,last_name ,'Old Man' as label
FROM employee_demographics
WHERE AGE>40 and gender="Male"
UNION
SELECT first_name,last_name ,'Old lady' as label
FROM employee_demographics
WHERE AGE>40 and gender="Female"
UNION
SELECT first_name,last_name ,'Highly paid' as label
FROM employee_salary
WHERE Salary>70000
ORDER BY first_name,last_name
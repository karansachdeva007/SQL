-- JOINS
SELECT  * 
FROM employee_demographics;
SELECT  * 
FROM employee_salary;

-- INNER JOIN
SELECT  ed.first_name,ed.last_name,es.occupation,es.salary
FROM employee_demographics as ed
JOIN employee_salary as es
ON ed.employee_id=es.employee_id;



-- OUTER JOIN 

SELECT  *
FROM employee_demographics as ed
 RIGHT JOIN employee_salary as es
ON ed.employee_id=es.employee_id;
-- above query will take everything from salary table


-- SELF JOIN
Select * 
from employee_salary emp1
JOIN employee_salary emp2
on emp1.employee_id=emp2.employee_id;

Select emp1.employee_id,emp1.first_name,emp1.last_name,emp2.employee_id,emp2.first_name,emp2.last_name 
from employee_salary emp1
JOIN employee_salary emp2
on emp1.employee_id+2=emp2.employee_id;


-- joining multiple tables together
SELECT  *
FROM employee_demographics as ed
JOIN employee_salary as es
ON ed.employee_id=es.employee_id
INNER JOIN parks_departments AS pd
ON es.dept_id=pd.department_id
;
SELECT * FROM parks_departments
-- CASE statements
-- The CASE statement is used for conditional logic in SQL queries. It works like an IF-ELSE statement in programming languages

SELECT first_name,last_name,age,
CASE
    WHEN age<=30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Middle Age'
    WHEN age>=50 THEN 'Old'
END AS Category

FROM employee_demographics;



-- pay increase and bonus
-- =50000-->5%
-- =70000--->7%
-- Finance -->10% bonus
SELECT first_name,last_name,salary,
CASE
   WHEN salary<50000 THEN salary+(salary*0.05)
    WHEN salary=50000 THEN salary+(salary*0.06)
    WHEN salary>50000 THEN salary+(salary*0.07)
END AS New_Salary,
CASE
    WHEN dept_id=6 THEN salary*.10

END AS Bonus
FROM employee_salary ;



SELECT *
FROM employee_salary;
SELECT * 
FROM parks_departments 
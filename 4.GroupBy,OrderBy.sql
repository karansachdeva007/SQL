-- GROUP BY clause

SELECT * FROM employee_demographics;

SELECT Gender,AVG(age),MAX(age),MIN(age),COUNT(age)
FROM employee_demographics
group by Gender;


SELECT occupation,salary
FROM employee_salary
group by occupation,salary;



-- ORDER BY 
SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

SELECT *
FROM employee_demographics
ORDER BY gender,age;

SELECT *
FROM employee_demographics
ORDER BY 5,4;
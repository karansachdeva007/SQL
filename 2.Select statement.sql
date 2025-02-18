SELECT * FROM employee_demographics;
SELECT * FROM parks_and_recreation.employee_demographics;

SELECT first_name FROM parks_and_recreation.employee_demographics;
SELECT 
first_name ,
last_name,
gender
FROM parks_and_recreation.employee_demographics;
SELECT 
first_name ,
last_name,
age,
(age+10)*10+10
FROM parks_and_recreation.employee_demographics;
-- --PEMDAS




SELECT GENDER 
FROM parks_and_recreation.employee_demographics;
SELECT DISTINCT GENDER 
FROM parks_and_recreation.employee_demographics;

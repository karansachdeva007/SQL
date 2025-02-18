-- --WHERE Clause

SELECT * 
FROM  employee_salary
WHERE first_name='Leslie';


SELECT * 
FROM  employee_salary
WHERE salary>50000;



SELECT * 
FROM  employee_demographics
WHERE gender !="Female";


SELECT * 
FROM  employee_demographics
WHERE birth_date > '1985-01-01';
-- YY/MM/Date


-- LogICAL OPERATORS

SELECT * 
FROM  employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender='male';

-- isolated conditional statements
SELECT * 
FROM  employee_demographics
WHERE (first_name="Leslie" AND age=44)  OR age>55;


-- Like statement
-- % and _
SELECT * 
FROM  employee_demographics
WHERE first_name LIKE "J_r%";

SELECT * 
FROM  employee_demographics
WHERE first_name LIKE "a___%";

-- give the names which contain 'er' in their name
SELECT * 
FROM  employee_demographics
WHERE first_name LIKE "%er%"  
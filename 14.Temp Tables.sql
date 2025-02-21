-- TEMPORARY TABLES

-- Temporary tables exist only within the session in which they are created.
-- If you disconnect or close your session, the table is automatically dropped.


-- Create a temporary table
CREATE TEMPORARY TABLE tempo_table (
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favourite_movie VARCHAR(100)
);

-- Select from the empty temporary table
SELECT * FROM tempo_table;

-- Insert data into the temporary table
INSERT INTO tempo_table (first_name, last_name, favourite_movie)
VALUES ('Karan', 'Sachdeva', 'Special Ops');

-- Select from the temporary table after insertion
SELECT * FROM tempo_table;



SELECT * FROM employee_salary;

CREATE  TEMPORARY TABLE salary_over_50k
SELECT * 
FROM employee_salary
WHERE salary>50000 ;

SELECT * FROM employee_salary;
SELECT * FROM salary_over_50k
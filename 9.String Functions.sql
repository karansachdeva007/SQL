-- STRING FUNCTIONS
SELECT length('skyfall');

SELECT first_name,length(first_name)
FROM employee_demographics
order by 2;

SELECT upper('sky');
SELECT lower('SKY');


SELECT first_name,upper(first_name)
FROM employee_demographics;


-- trim()-->removes both trailing and leading whitepaces
SELECT TRIM('                  sky                        ');
-- Removes leading (left-side) spaces from a string
SELECT LTRIM('                  sky                        ');
-- Removes trailing (right-side) spaces from a string
SELECT RTRIM('                  sky                        ');





 -- SUBSTRING() function extracts a portion of a string based on a starting position and length
--  SYNTAX--->SUBSTRING(string, start_position, length)
-- string: The input string from which a substring is extracted
-- start_position: The starting position (1-based index)
-- length: The number of characters to extract
SELECT 
first_name,LEFT(first_name,4),
RIGHT(first_name,4),
SUBSTRING(first_name,3,2),
birth_date,
SUBSTRING(birth_date,6,2) AS birth_month
FROM employee_demographics;



-- REPLACE() function replaces occurrences of a substring within a string
SELECT first_name,REPLACE(first_name,'a','yz')
FROM employee_demographics;


-- LOCATE() function finds the position of a substring within a string
SELECT LOCATE('X','ALEXANDER');
SELECT LOCATE('World', 'Hello World') AS Position;
SELECT first_name,LOCATE('An',first_name)
FROM employee_demographics;



SELECT first_name,last_name,
CONCAT(first_name,' ',last_name) AS Full_Name
FROM employee_demographics;

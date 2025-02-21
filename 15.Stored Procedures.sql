SELECT * FROM employee_salary
WHERE SALARY >=50000;
CREATE procedure large_salaries()
SELECT * FROM employee_salary
WHERE SALARY >=50000;

CALL large_salaries();



DELIMITER $$
CREATE procedure large_salaries2()
BEGIN
	SELECT * FROM employee_salary
	WHERE SALARY >=50000;
	SELECT * FROM employee_salary
	WHERE SALARY >=10000;	 
END $$
DELIMITER ;

CALL large_salaries2();




DELIMITER $$
CREATE procedure large_salaries3(e_id INT)
BEGIN
	SELECT salary 
    FROM employee_salary
    WHERE employee_id=e_id
;	 
END $$
DELIMITER ;

CALL large_salaries3(1);
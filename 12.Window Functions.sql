

SELECT 	gender,AVG(salary) AS avg_salary
FROM employee_demographics ed
JOIN employee_salary es
ON ed.employee_id=es.employee_id
group by gender;


-- using window function
SELECT 	ed.first_name,ed.last_name,gender,AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics ed
JOIN employee_salary es
ON ed.employee_id=es.employee_id
;
	

-- this SQL query is using window functions (SUM() OVER()) to calculate a rolling total of salaries partitioned by gender while ordering by employee_id
	SELECT 	ed.first_name,ed.last_name,gender,salary,
	SUM(salary) OVER(PARTITION BY gender ORDER BY ed.employee_id) AS rolling_total	
	FROM employee_demographics ed
	JOIN employee_salary es
	ON ed.employee_id=es.employee_id
	;
    
    
    
   -- If multiple employees have the same salary, ROW_NUMBER() will still assign unique numbers 
    	SELECT 	ed.employee_id,ed.first_name,ed.last_name,gender,salary,
ROW_NUMBER() OVER() 
	FROM employee_demographics ed
	JOIN employee_salary es
	ON ed.employee_id=es.employee_id
	;
    
    
        	SELECT 	ed.employee_id,ed.first_name,ed.last_name,gender,salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num
	FROM employee_demographics ed
	JOIN employee_salary es
	ON ed.employee_id=es.employee_id
	;
    
    -- If multiple employees have the same salary, ROW_NUMBER() will still assign unique numbers. To handle ties, use RANK():
            	SELECT 	ed.employee_id,ed.first_name,ed.last_name,gender,salary,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num	
	FROM employee_demographics ed
	JOIN employee_salary es
	ON ed.employee_id=es.employee_id
	;
    
    
    SELECT 	ed.employee_id,ed.first_name,ed.last_name,gender,salary,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num	
	FROM employee_demographics ed
	JOIN employee_salary es
	ON ed.employee_id=es.employee_id
	;
    
    
   --  row_number,rank,dense_rank combined query in 1
   SELECT 	ed.employee_id,ed.first_name,ed.last_name,gender,salary,
   ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num	,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num	
	FROM employee_demographics ed
	JOIN employee_salary es
	ON ed.employee_id=es.employee_id
	;
-- having vs where

	SELECT gender,avg(age)
    FROM employee_demographics
    group by gender
    having avg(age)>40;
    

SELECT occupation,avg(salary)
    FROM employee_salary
    where occupation LIKE "%Manager%"
    group by occupation
   having avg(salary)>75000
      
-- A subquery in SQL is a query nested inside another query. It is used to fetch intermediate results that the outer query can use for filtering, aggregation, or computation.




select * 
FROM employee_demographics
WHERE employee_id In(
select employee_id 
FROM employee_salary 
where dept_id=1
);




SELECT first_name,salary,
(SELECT AVG(salary) FROM employee_salary )
FROM employee_salary;




SELECT gender,AVG(age),Max(age),Min(Age),Count(age)
FROM employee_demographics
group by gender;
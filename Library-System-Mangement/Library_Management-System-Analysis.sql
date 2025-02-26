select * from books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from return_status;


-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')";
INSERT INTO books(isbn,book_title,category,rental_price,status,author,publisher)
VALUES(978-1-60129-456-2,'To Kill a Mockingbird','Classic',6.00,'yes','Harper Lee','J.B. ''Lippincott & Co.');
select * FROM books;


-- Task 2: Update an Existing Member's Address
select * from members;
UPDATE members
set member_address='125 OAK'
where member_id='C103';

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status
WHERE   issued_id =   'IS121';
select * from issued_status;

-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT
    issued_emp_id,
    COUNT(*)
FROM issued_status
GROUP BY 1
HAVING COUNT(*) > 1;

-- Task 6: Create Summary Tables: Used CTAS to generate new tables 
-- based on query results - each book and total book_issued_cnt**
CREATE TABLE book_issued_cnt AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS issue_count
FROM issued_status as ist
JOIN books as b
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

select * from book_issued_cnt;

-- Task 7: retrieve books in special category

-- select count(category) from books
-- where category='classic'
-- group by category;
select * from books
where category='classic';

-- Task 8: Find Total Rental Income by Category:
SELECT 
    b.category,
    SUM(b.rental_price),
    COUNT(*)
FROM 
issued_status as ist
JOIN
books as b
ON b.isbn = ist.issued_book_isbn
GROUP BY 1;

-- Task 9: List Members Who Registered in the Last 180 Days:
SELECT * FROM members 
WHERE reg_date >= DATE_SUB(CURRENT_DATE, INTERVAL 180 DAY);


INSERT INTO members (member_id, member_name, member_address, reg_date)
VALUES
('C120', 'Karan', '199 Main Chowk', '2025-02-26'),
('C121', 'Goutam', '200 Main Chowk', '2025-02-26');
select * from members;

 -- Task 10: List Employees with Their Branch Manager's Name and their branch details:
SELECT 
   e1.*,
   b.manager_id,
    e2.emp_name as manager
FROM employees as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employees as e2
ON e2.emp_id = b.manager_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;
SELECT * FROM expensive_books;

-- Task 12: Retrieve the List of Books Not Yet Returned
SELECT * FROM issued_status as ist
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;

-- Task 13: Identify Members with Overdue Books
-- Write a query to identify members who have overdue books .
-- Display the member's_id, member's name, book title, issue date, and days overdue.

SELECT 
    ist.issued_member_id,
    m.member_name,
    bk.book_title,
    ist.issued_date,
     rs.return_date ,
  DATEDIFF(CURDATE(), ist.issued_date) AS overdue_days
FROM issued_status as ist
JOIN 
members as m
    ON m.member_id = ist.issued_member_id
JOIN 
books as bk
ON bk.isbn = ist.issued_book_isbn
LEFT JOIN 
return_status as rs
ON rs.issued_id = ist.issued_id
where rs.return_date is NULL 
AND
DATEDIFF(CURDATE(), ist.issued_date) >320 ;


SELECT current_date();
-- for random date
SELECT 
    ist.issued_member_id,
    m.member_name,
    bk.book_title,
    ist.issued_date,
    -- rs.return_date,
    DATEDIFF('2024-05-01', ist.issued_date) AS overdue_days
FROM issued_status AS ist
JOIN members AS m
    ON m.member_id = ist.issued_member_id
JOIN books AS bk
    ON bk.isbn = ist.issued_book_isbn
LEFT JOIN return_status AS rs
    ON rs.issued_id = ist.issued_id
WHERE rs.return_date IS NULL
AND
DATEDIFF('2024-05-01', ist.issued_date) >30
order by 1;

/*Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" 
when they are returned (based on entries in the return_status table).*/

SELECT * FROM issued_status
WHERE issued_book_isbn  LIKE '978-0-451-52994%';

select * from books 
WHERE isbn = '978-0-451-52994-2';

update books
set status='no'
where isbn = '978-0-451-52994-2';

select * from return_status
where issued_id='IS130';

INSERT INTO return_status (return_id, issued_id, return_date)
VALUES ('RS125', 'IS130', CURRENT_DATE());


select * from return_status
where return_id='RS125';

update books
set status='yes'
where isbn = '978-0-451-52994-2';

-- STORED Procedure
DELIMITER $$

CREATE PROCEDURE add_return_records( 
IN p_return_id VARCHAR(20),
IN p_issued_id VARCHAR(20))
BEGIN
-- all ur logic and code

   DECLARE v_isbn VARCHAR(20);
 DECLARE v_book_name VARCHAR(255);
 
-- inserting into returns based on user input	
INSERT INTO return_status (return_id, issued_id, return_date)
VALUES (p_return_id, p_issued_id, CURRENT_DATE());

 SELECT 
        issued_book_isbn,
        issued_book_name
        INTO
        v_isbn,
     v_book_name
    FROM issued_status
    WHERE issued_id = p_issued_id;

    UPDATE books
    SET status = 'yes'
    WHERE isbn = v_isbn;
    
    SELECT CONCAT('Thank you for returning the book: ', v_book_name) AS message;	
END $$

-- Testing FUNCTION add_return_records

issued_id = IS135
ISBN = WHERE isbn = '978-0-307-58837-1'

SELECT * FROM books
WHERE isbn = '978-0-307-58837-1';

SELECT * FROM issued_status
WHERE issued_book_isbn = '978-0-307-58837-1';

SELECT * FROM return_status
WHERE issued_id = 'IS135';

DELIMITER ;

CALL add_return_records('RS138','IS135')	;
CALL add_return_records('RS148', 'IS140');

SELECT * FROM return_status
WHERE issued_id = 'IS140';
SELECT * FROM books
WHERE isbn = '978-0-307-58837-1';

-- Task 15: Branch Performance Report
-- Create a query that generates a performance report for each branch, showing the number of books issued, the 
-- number of books returned, and the total revenue generated from book rentals.
 
 CREATE TABLE branch_report
 AS
select 
    b.branch_id,
    b.manager_id,
       COUNT(ist.issued_id) as number_book_issued,
    COUNT(rs.return_id) as number_of_book_return,
      SUM(bk.rental_price) as total_revenue
from issued_status as ist
JOIN employees as e
ON e.emp_id=ist.issued_emp_id
JOIN branch as b
ON e.branch_id=b.branch_id
LEFT JOIN return_status as rs
ON rs.issued_id=ist.issued_id
JOIN books as bk
ON ist.issued_book_isbn=bk.isbn
GROUP BY 1, 2;

SELECT * FROM branch_report;

-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members 
-- containing members who have issued at least one book in the last 2 months.

CREATE TABLE active_members AS
SELECT * FROM members
WHERE member_id IN (
    SELECT DISTINCT issued_member_id   
    FROM issued_status
    WHERE issued_date >= DATE_SUB(CURRENT_DATE, INTERVAL 2 MONTH)
);

SELECT * FROM active_members;


-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most 
-- book issues. Display the employee name, number of books processed, and their branch.

SELECT 
    e.emp_name,
    b.branch_id,
    b.manager_id,
    b.branch_address,
    COUNT(ist.issued_id) AS no_book_issued
FROM issued_status AS ist
JOIN employees AS e ON e.emp_id = ist.issued_emp_id
JOIN branch AS b ON e.branch_id = b.branch_id
GROUP BY 1,2,3,4
ORDER BY no_book_issued DESC
LIMIT 3;


-- Task 18: Stored Procedure Objective:
--  Create a stored procedure to manage the status of books in a library system. 
-- Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 
-- The procedure should function as follows: 
-- The stored procedure should take the book_id as an input parameter. The procedure should first check if 
-- the book is available (status = 'yes'). 
-- If the book is available, it should be issued, and the status in the books table 
-- should be updated to 'no'. If the book is not available (status = 'no'), the procedure should 
-- return an error message indicating that the book is currently not available.

select * from books
where status ='Yes';
select * from issued_status;

DELIMITER $$

CREATE PROCEDURE issue_booka(
    IN p_issued_id VARCHAR(20),
    IN p_issued_member_id VARCHAR(20),
    IN p_issued_book_isbn VARCHAR(30),
    IN p_issued_emp_id VARCHAR(20),
    IN p_issued_date DATE  -- NEW 5th Argument
)
BEGIN
    DECLARE v_status VARCHAR(20);
    DECLARE v_exists INT;

    -- Check if book exists and retrieve its status
    SELECT status INTO v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;

    -- Check if the issue ID already exists to prevent duplicates
    SELECT COUNT(*) INTO v_exists FROM issued_status WHERE issued_id = p_issued_id;
    
    -- If the book is not found
    IF v_status IS NULL THEN
        SELECT CONCAT('Error: Book with ISBN ', p_issued_book_isbn, ' does not exist in the system.') AS message;

    -- If the issue ID already exists
    ELSEIF v_exists > 0 THEN
        SELECT CONCAT('Error: Issue ID ', p_issued_id, ' already exists. Choose a unique ID.') AS message;

    -- If the book is available, proceed with issuing
    ELSEIF v_status = 'yes' THEN
        INSERT INTO issued_status (issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        VALUES (p_issued_id, p_issued_member_id, p_issued_date, p_issued_book_isbn, p_issued_emp_id);

        -- Update book status to 'no' (indicating it's issued)
        UPDATE books
        SET status = 'no'
        WHERE isbn = p_issued_book_isbn;

        -- Success message
        SELECT CONCAT('Book issued successfully: ', p_issued_book_isbn, ' on ', p_issued_date) AS message;

    ELSE
        -- Book is not available
        SELECT CONCAT('Sorry, the book is not available: ', p_issued_book_isbn) AS message;
    END IF;
END $$

DELIMITER ;
SHOW CREATE PROCEDURE issue_booka;
-- Case 1: Issue a book with a specific date (should succeed)
CALL issue_booka('IS200', 'C110', '978-0-553-29698-2', 'E104', '2025-02-27');

-- Case 2: Try to issue an already issued book (should fail)
CALL issue_booka('IS201', 'C111', '978-0-375-41398-8', 'E104', '2025-02-27');

-- Case 3: Try to issue a non-existent book (should fail)
CALL issue_booka('IS202', 'C112', '999-9-9999-9999-9', 'E104', '2025-02-27');

-- Case 4: Try to issue with a duplicate issue ID (should fail)
CALL issue_booka('IS200', 'C113', '978-0-553-29698-2', 'E105', '2025-02-27');

-- Case 5: Issue another available book with today's date (should succeed)
CALL issue_booka('IS203', 'C114', '978-0-141-03435-8', 'E106', CURRENT_DATE());


-- Check issued books after issuing
SELECT * FROM issued_status;


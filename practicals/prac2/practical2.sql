-- Retrieve all employees with an address in Houston, TX
SELECT fname, lname, address FROM employee
WHERE address LIKE '%Houston, TX%';

-- Find employees that were born in the 1950's
SELECT fname, lname, bdate FROM employee
WHERE date_part('Year', bdate)::VARCHAR LIKE '195%';

-- Get the full name in a single returned field (with a space between the names)
SELECT fname || ' ' || lname AS full_name from employee;

-- Find the sum, maximum, and minimum salary of all employees
SELECT SUM(salary), MAX(salary), MIN(salary)
FROM employee;

-- Find the sum of all salaries, maximum salary, and the minimum salary for the research department
SELECT SUM(salary), MAX(salary), MIN(salary)
FROM employee JOIN department ON dno = dnumber
WHERE dname = 'Research';

-- A count of all employees
SELECT COUNT(*) AS "Count of Employees"
FROM employee;

-- Count the number of distinct salary values in the database
SELECT COUNT(DISTINCT salary)
FROM employee;

-- Retrieve the number of employees and the average salary for each department.
SELECT d.dname, COUNT(*), AVG(salary)
FROM employee JOIN department AS d ON dno = dnumber
GROUP BY d.dname;

-- For each project that has more than 2 employees, list the project number, name and number of employees working on the project
SELECT pnumber, pname, COUNT(*)
FROM project, works_on
WHERE pnumber=pno
GROUP BY pnumber, pname
HAVING COUNT(*) > 2;

-- This view directly inherits the names of the SELECTed attributes from the
-- base tables
CREATE VIEW works_on1
AS SELECT fname,lname,pname,hours
FROM employee, project, works_on
WHERE ssn=essn AND pno=pnumber;

-- Look at the contents of your view...
SELECT * FROM works_on1;

-- This view renames the attributes and makes use of a GROUP BY clause to 
-- return the number of employees and the total salary for each department
CREATE VIEW dept_info(dept_name, no_of_emps,total_sal)
AS SELECT dname, COUNT(*),SUM(salary)
FROM department, employee
WHERE dnumber = dno
GROUP BY dname;

-- Look at the contents of your view...
SELECT * FROM dept_info;

-- To remove a view, use the DROP VIEW command
DROP VIEW dept_info;
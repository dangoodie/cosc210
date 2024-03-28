-- Return all employees who do not have a supervisor
SELECT fname, lname
FROM employee
WHERE superssn IS NULL;

-- Return all employees who have a supervisor
SELECT fname, lname
FROM employee
WHERE superssn IS NOT NULL;

-- Returns a list of project numbers that involves
-- an employ with last name 'Smith' as a manager or a worker

SELECT DISTINCT pnumber
FROM project
WHERE pnumber IN 
    (SELECT pnumber
    FROM project, department, employee
    WHERE dnum = dnumber AND mgrssn=ssn and lname = 'Smith') 
    OR
    pnumber IN
    (SELECT pnumber 
    FROM works_on, employee
    WHERE essn=ssn AND lname='Smith');


-- Returns a list of employees who work on all projects that employee '123456789' works on
SELECT DISTINCT essn
FROM works_on
WHERE (pno,hours) IN
    (SELECT pno,hours
    FROM works_on
    WHERE essn = '123456789')

-- Return all employees with a salary greater
-- than all employees in department 5

SELECT fname,lname
FROM EMPLOYEE
WHERE salary > ALL
    (SELECT salary 
    FROM employee
    WHERE dno = 5);


SELECT E.fname, E.lname
FROM employee AS E
WHERE E.ssn IN 
    (SELECT essn
    FROM dependent AS D 
    WHERE E.fname = D.dependent_name AND E.sex = D.sex);

SELECT e.fname, e.lname
FROM employee AS E
WHERE EXISTS
    (SELECT * 
    FROM dependent AS D
    WHERE E.ssn = D.essn AND 
        E.sex = D.sex AND 
        E.fname = D.dependent_name) 

-- Retrieve the names of employees who do 
-- not have dependents.

SELECT fname, lname 
FROM employee
WHERE NOT EXISTS
    (SELECT * 
    FROM dependent
    WHERE ssn=essn);

-- Retrieve the names of employees who do 
-- have dependents.

SELECT fname, lname 
FROM employee
WHERE EXISTS
    (SELECT * 
    FROM dependent
    WHERE ssn=essn);

-- Retrieve the name of each employee who works on all
-- projects by department 4

SELECT lname, fname
FROM employee
WHERE NOT EXISTS
    (SELECT * 
    FROM works_on B
    WHERE (B.pno IN 
        (SELECT pnumber
        FROM project
        where dnum=4)
        AND
        NOT EXISTS 
            (SELECT * 
             FROM works_on C
             WHERE C.essn = ssn AND C.pno = B.pno)));

SELECT e.lname AS Employee_Name, s.lname AS Supervisor_name
FROM (employee AS e LEFT OUTER JOIN employee as s ON e.superssn=s.ssn); 

-- Exercise 1
-- a. Retrieve the first name and last name of all employees who do not work on the project with name 'ProductZ'
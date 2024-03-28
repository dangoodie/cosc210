-- a.
--The query may still be specified in SQL by using a nested query as follows (not all
--implementations may support this type of query):
SELECT DNAME, COUNT (*)
FROM DEPARTMENT, EMPLOYEE
WHERE DNUMBER=DNO AND SEX='M' AND DNO IN ( SELECT DNO
FROM EMPLOYEE
GROUP BY DNO
HAVING AVG (SALARY) > 30000 )
GROUP BY DNAME;

-- b.
CREATE VIEW ex_2d AS
SELECT p1.pname, COUNT(employee.ssn), sum(works_on.hours), department.dname
FROM project AS p1, department, employee, works_on
WHERE works_on.essn = employee.ssn AND
    works_on.pno = p1.pnumber AND
    p1.dnum = department.dnumber AND
     (SELECT count(wo2.pno) 
      FROM works_on as wo2 
      WHERE wo2.pno = p1.pnumber) > 1
GROUP BY p1.pname,department.dname;
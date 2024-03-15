-- Display customer account numbers with balances greater than $500.00
SELECT ano FROM customer_account WHERE balance > 50000;

-- Display customer loans with amounts less than $1000.00
SELECT * FROM customer_loan WHERE amount < 1000000;

-- Display customer names with ssn's between 502 and 504
SELECT name, ssn FROM customer WHERE ssn >= 502 AND ssn <= 504;

-- Display customers that are from Armidale.
SELECT * FROM customer WHERE c_address LIKE '%Armidale%';

-- Display names and phone numbers for customers with an area code starting with 5.
SELECT name,phone FROM customer WHERE phone LIKE '(5%';

-- Display bank and branch numbers for Student accounts in one cell, preceded by *BSB:*.
SELECT 'BSB:'||bco||bno AS bsb FROM account WHERE atype LIKE '%Student%';

-- Diplay BSB and account numbers through concatenation
SELECT ''||a.bco||a.bno AS BSB, ''||ca.ano||ca.cssn AS ACC FROM account AS a
  JOIN customer_account AS ca ON ca.ano=a.anum;

-- Display customers with a student account from Armidale branch

SELECT c.name, a.atype, ca.balance, bb.b_address FROM customer AS c
  JOIN customer_account AS ca ON ca.cssn = c.ssn
  JOIN account AS a ON a.anum = ca.ano
  JOIN bank_branch as bb ON (a.bno,a.bco) = (bb.bnum,bb.bco)
  WHERE bb.b_address LIKE '%Armidale%'
    AND a.atype LIKE '%Student%';
  
SELECT c.name, a.atype, ca.balance, bb.b_address 
  FROM customer AS c, 
  customer_account AS ca, 
  account AS a, 
  bank_branch AS bb
  WHERE c.ssn = ca.cssn 
    AND ca.ano = a.anum 
    AND (a.bno,a.bco) = (bb.bnum, bb.bco) 
    AND bb.b_address LIKE '%Armidale%' 
    AND a.atype LIKE '%Student%';

-- Display average, total, and count of balance per branch.
SELECT '$'||ROUND(AVG(ca.balance)/100, 2) AS "average balance", '$'||ROUND(SUM(ca.balance)/100,2) AS "total balance", COUNT(ca.balance), bb.b_address
  FROM customer_account AS ca,
  account AS a,
  bank_branch AS bb
  WHERE ca.ano = a.anum
    AND (a.bno,a.bco) = (bb.bnum,bb.bco)
  GROUP BY bb.b_address;

-- List the number of accounts and names of customers who have more than one account
SELECT c.name, COUNT(ca.cssn) FROM customer AS c, customer_account AS ca
  WHERE c.ssn = ca.cssn
  GROUP BY c.ssn
  HAVING COUNT(ca.cssn) > 1;

-- Creating a view
CREATE VIEW account_details AS
    SELECT c.name,''||a.bco||a.bno AS BSB, ''||ca.ano||ca.cssn AS ACC, '$'||ROUND(ca.balance/100,2) AS balance FROM account AS a
      JOIN customer_account AS ca ON ca.ano=a.anum
      JOIN customer AS c ON ca.cssn = c.ssn;

-- Display the view
SELECT * FROM account_details;
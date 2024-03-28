-- a.
SELECT name, major
FROM student
WHERE NOT EXISTS
    (SELECT * 
    FROM grade_report
    WHERE student_number = student.student_number AND NOT(grade='A'));

-- b.
SELECT name, major
FROM student
WHERE NOT EXISTS
    (SELECT * 
    FROM grade_report
    WHERE student_number = student.student_number AND (grade='A'));
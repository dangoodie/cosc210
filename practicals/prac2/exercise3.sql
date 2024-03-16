/*
 * Exercise 3
 * A database that stores student and course information
 */

CREATE TABLE student (
  name VARCHAR(50) NOT NULL,
  student_number INT PRIMARY KEY,
  class INT NOT NULL,
  major VARCHAR(50) NOT NULL
);

CREATE TABLE course (
  course_name VARCHAR(50) NOT NULL,
  course_number VARCHAR(50) PRIMARY KEY,
  credit_hours INT NOT NULL,
  department VARCHAR(50) NOT NULL
);

CREATE TABLE section (
  section_identifier INT PRIMARY KEY,
  course_number VARCHAR(50) NOT NULL,
  semester VARCHAR(50) NOT NULL,
  year INT NOT NULL,
  instructor VARCHAR(50) NOT NULL,
  FOREIGN KEY (course_number) REFERENCES course(course_number)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE grade_report (
  student_number INT,
  section_identifier INT,
  grade VARCHAR(2) NOT NULL,
  PRIMARY KEY (student_number, section_identifier),
  FOREIGN KEY (student_number) REFERENCES student(student_number)
    ON DELETE CASCADE ON UPDATE CASCADE
  FOREIGN KEY (section_identifier) REFERENCES section(section_identifier)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE prerequisite (
  course_number VARCHAR(50),
  prerequisite_number VARCHAR(50),
  PRIMARY KEY (course_number, prerequisite_number),
  FOREIGN KEY (course_number) REFERENCES course(course_number)
    ON DELETE CASCADE ON UPDATE CASCADE
  FOREIGN KEY (prerequisite_number) REFERENCES course(course_number)
    ON DELETE CASCADE ON UPDATE CASCADE
);
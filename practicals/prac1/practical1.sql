CREATE TABLE department (
  dname        varchar(25) not null,
  dnumber      integer primary key,
  mgrssn       char(9) not null, 
  mgrstartdate date
);


CREATE TABLE project (
  pname      varchar(25) unique not null,
  pnumber    integer primary key,
  plocation  varchar(15),
  dnum       integer not null,
  foreign key (dnum) references department(dnumber)
);

CREATE TABLE employee (
  fname    varchar(15) NOT NULL, 
  minit    varchar(1),
  lname    varchar(15) NOT NULL,
  ssn      char(9) PRIMARY KEY,
  bdate    date,
  address  varchar(50),
  sex      char,
  salary   decimal(10,2),
  superssn char(9),
  dno      integer,
  foreign key (superssn) references employee(ssn)
        ON DELETE SET NULL ON UPDATE CASCADE,
  foreign key (dno) references department(dnumber)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE dependent (
  essn           char(9),
  dependent_name varchar(15),
  sex            char,
  bdate          date,
  relationship   varchar(8),
  primary key (essn,dependent_name),
  foreign key (essn) references employee(ssn)
);

CREATE TABLE dept_locations (
  dnumber   integer,
  dlocation varchar(15), 
  primary key (dnumber,dlocation),
  foreign key (dnumber) references department(dnumber)
);

CREATE TABLE works_on (
  essn   char(9),
  pno    integer,
  hours  decimal(4,1),
  primary key (essn,pno),
  foreign key (essn) references employee(ssn),
  foreign key (pno) references project(pnumber)
);


-- copy from each csv file
\copy department FROM '/home/squid/repos/cosc210/practicals/prac1/data/department.csv' CSV;
\copy employee FROM '/home/squid/repos/cosc210/practicals/prac1/data/employee.csv' CSV;
\copy dependent FROM '/home/squid/repos/cosc210/practicals/prac1/data/dependent.csv' CSV;
\copy project FROM '/home/squid/repos/cosc210/practicals/prac1/data/project.csv' CSV;
\copy works_on FROM '/home/squid/repos/cosc210/practicals/prac1/data/works_on.csv' CSV;
\copy dept_locations FROM '/home/squid/repos/cosc210/practicals/prac1/data/dept_locations.csv' CSV;


-- exercise 7 library database
CREATE TABLE publisher (
  publisher_name varchar(50) primary key,
  address varchar(50) not null,
  phone varchar(15) not null
);

CREATE TABLE book (
  book_id integer primary key,
  title varchar(50) not null,
  publisher_name varchar(50) not null,
  FOREIGN KEY (publisher_name) REFERENCES publisher(publisher_name)
    ON UPDATE CASCADE
);

CREATE TABLE book_author (
  book_id integer,
  author_name varchar(50),
  PRIMARY KEY (book_id, author_name),
  FOREIGN KEY (book_id) REFERENCES book(book_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE library_branch (
  branch_id integer not null primary key,
  branch_name varchar(50) not null,
  address varchar(50) not null
);

CREATE TABLE borrower (
  card_no integer primary key,
  name varchar(50) not null,
  address varchar(50) not null,
  phone varchar(15) not null
)

CREATE TABLE book_copies (
  book_id integer,
  branch_id integer,
  no_of_copies integer not null,
  PRIMARY KEY (book_id, branch_id),
  FOREIGN KEY (book_id) REFERENCES book(book_id),
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (branch_id) REFERENCES library_branch(branch_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE book_loans (
  book_id integer,
  branch_id integer,
  card_no integer,
  date_out date not null,
  due_date date not null,
  PRIMARY KEY (book_id, branch_id, card_no),
  FOREIGN KEY (book_id) REFERENCES book(book_id),
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (branch_id) REFERENCES library_branch(branch_id),
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (card_no) REFERENCES borrower(card_no)
    ON DELETE CASCADE ON UPDATE CASCADE
);


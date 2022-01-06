-- 3. Use the employees database
USE employees;

-- 4. List all the tables in the database
SHOW tables;

-- 5. Explore the employees table.
--    What different data types are present on this table?
-- ANSWER: int, date, varchar, enum, date
DESCRIBE employees;

-- 6. Which tables do you think contain a numeric type column?
-- ANSWER: dept_emp, dept_manager, employees, salaries, titles

-- 7. Which tables do you think contain a string type column?
-- ANSWER: departments, dept_emp, dept_manager, employees, title

-- 8. Which tables do you think contain a date type column?
-- ANSWER: dept_emp, dept_manager, employees, salaries, titles

-- 9. What is the relationshiop between the employees and the 
--    departments table?
-- ANSWER: there is no direct relationship between the two tables, 
--         but they are linked through the dept_emp table.

-- 10. Show the SQL that created the dept_manager table
SHOW CREATE TABLE dept_manager;

-- ANSWER:
-- CREATE TABLE `dept_manager` (
--   `emp_no` int NOT NULL,
--   `dept_no` char(4) NOT NULL,
--   `from_date` date NOT NULL,
--   `to_date` date NOT NULL,
--   PRIMARY KEY (`emp_no`,`dept_no`),
--   KEY `dept_no` (`dept_no`),
--   CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--   CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1
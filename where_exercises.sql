-- 2. Find all current or previous employees with first 
--    names 'Irena', 'Vidya', or 'Maya' using IN.

SELECT *
  FROM employees 
  WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- Enter a comment with the number of records returned
-- ANSWER: 709

SELECT COUNT(*)
  FROM employees 
  WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- 3. Find all current or previous employees with first 
--    names 'Irena', 'Vidya', or 'Maya' as in Q2, but use
--    OR instead of IN. 

SELECT *
  FROM employees 
  WHERE first_name = 'Irena'
    OR first_name = 'Vidya'
    OR first_name = 'Maya';

-- Enter a comment with the number of records returned. 
-- Does it match number of rows from Q2?
-- ANSWER: 709, yes it matches

SELECT COUNT(*)
  FROM employees 
  WHERE first_name = 'Irena'
    OR first_name = 'Vidya'
    OR first_name = 'Maya';

-- 4. Find all current or previous employees with first 
--    names 'Irena', 'Vidya', or 'Maya', using OR, and who 
--    is male. Enter a comment with the number of records 
--    returned. 
-- ANSWER: 441

SELECT *
  FROM employees 
  WHERE gender = 'M'
     AND (
          first_name = 'Irena' 
          OR first_name = 'Vidya' 
          OR first_name = 'Maya'
         );

SELECT COUNT(*)
  FROM employees 
  WHERE gender = 'M'
     AND (
          first_name = 'Irena' 
          OR first_name = 'Vidya' 
          OR first_name = 'Maya'
         );

-- 5. Find all current orprevious employees whose last 
--    name starts with 'E'. Enter a comment with the number
--    of employees whose last name starts with 'E'. 
-- ANSWER: 7330

SELECT first_name, last_name
  FROM employees
  WHERE last_name LIKE 'E%';

SELECT COUNT(*)
  FROM employees
  WHERE last_name LIKE 'E%';

-- 6. Find all current or previous employees whose last 
--    name starts or ends with 'E'. Enter a comment with 
--    the number of employees whose last name starts or ends
--    with 'E'. 
--ANSWER: 30723

SELECT first_name, last_name
  FROM employees
  WHERE last_name LIKE 'E%'
        OR last_name LIKE '%e';

SELECT COUNT(*)
  FROM employees
  WHERE last_name LIKE 'E%'
        OR last_name LIKE '%e';

-- 6a. How many employees have a last name that ends with 'E'
--     but does not start with 'E'?
--ANSWER: 23393

SELECT COUNT(*)
  FROM employees
  WHERE last_name LIKE '%e'
    AND last_name NOT LIKE 'E%';

-- 7. Find all current or previous employees whose last name 
--    starts and ends with 'E'. Enter a comment with the number
--    of employees whose last name starts and ends with 'E'. 
--ANSWER: 899

SELECT first_name, last_name
  FROM employees
  WHERE last_name LIKE 'E%'
    AND last_name LIKE '%e'
  ORDER BY last_name, first_name;

SELECT COUNT(*)
  FROM employees
  WHERE last_name LIKE 'E%'
    AND last_name LIKE '%e';

-- 7a. How many employees' last names end with E, regardless
--     of whether they start with E?
--ANSWER: 24292

SELECT COUNT(*)
  FROM employees
  WHERE last_name LIKE '%e';

-- 8. Find all current or previous employees hired in the 90s.
--    Enter a comment with the number of employees returned. 
--ANSWER: 135214

SELECT first_name, last_name, hire_date
  FROM employees
  WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
  ORDER BY hire_date, last_name, first_name;

  SELECT COUNT(*)
  FROM employees
  WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

-- 9. Find all current or previous employees born on Christmas. 
--    Enter a comment with the number of employees returned.
--ANSWER: 789

SELECT first_name, last_name, hire_date
  FROM employees
  WHERE hire_date LIKE '%12-25'
  ORDER BY hire_date, last_name, first_name;

SELECT COUNT(*)
  FROM employees
  WHERE hire_date LIKE '%12-25';

--10. Find all current or previos employees hired in the 90s
--    and born on Christmas. Enter a comment with the number 
--    of employees returned. 
--ANSWER: 346

SELECT first_name, last_name, hire_date
  FROM employees
  WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
    AND hire_date LIKE '%12-25'
  ORDER BY hire_date, last_name, first_name;

SELECT COUNT(*)
  FROM employees
  WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
    AND hire_date LIKE '%12-25';

-- 11. Find all current or previous employees with a 'q' 
--     in their last name. Enter a comment with the number
--     of records returned. 
--ANSWER: 1873

SELECT first_name, last_name
  FROM employees
  WHERE last_name LIKE '%q%'
  ORDER BY last_name, first_name;

SELECT COUNT(*)
  FROM employees
  WHERE last_name LIKE '%q%';

-- 12. Find all current or previous employees with a 'q' in
--     their last name but not 'qu'. How many employees are
--     found?
--ANSWER: 547

SELECT first_name, last_name
  FROM employees
  WHERE last_name LIKE '%q%'
    AND last_name NOT LIKE '%qu%'
  ORDER BY last_name, first_name;

SELECT COUNT(*)
  FROM employees
  WHERE last_name LIKE '%q%'
    AND last_name NOT LIKE '%qu%';
-- 2. Find all employees with first names 'Irena', 'Vidya', 
--    or 'Maya', and order your results returned by first 
--    name. In your comments, answer: What was the first and 
--    last name of the last person in the table.  
--ANSWER: Vidya Simmen

SELECT *
  FROM employees 
  WHERE first_name IN ('Irena', 'Vidya', 'Maya')
  ORDER BY first_name;

-- 3. Find all employees with first names 'Irena', 'Vidya',
--    or 'Maya', and order your results returned by first 
--    name and then last name. 
--    In your comments, answer: What was the first and last 
--    name in the first row of the results?
--ANSWER: Irena Acton
--    What was the first and last name of the last person
--    in the table. 
--ANSWER: Vidya Zweizig

SELECT *
  FROM employees 
  WHERE first_name IN ('Irena', 'Vidya', 'Maya')
  ORDER BY first_name, last_name;

-- 4. Find all employees with first names 'Irena', 'Vidya',
--    or 'Maya', and order your results returned by last 
--    name and then first name. 
--    In your comments, answer: What was the first and 
--    last name in the first row of the results?
--ANSWER: Irena Acton
--    What was the first and last name of the last person 
--    in the table? 
--ANSWER: Maya Zyda

SELECT *
  FROM employees 
  WHERE first_name IN ('Irena', 'Vidya', 'Maya')
  ORDER BY last_name, first_name;

-- 5. Write a query to find all employees whose last name 
--    starts and ends with E. Sort the results by employee 
--    number. 
--NUMBER OF EMPLOYEES: 899
--FIRST EMPLOYEE: 10021 Ramzi Erde
--LAST EMPLOYEE: 499648 Tadahiro Erde

SELECT * 
  FROM employees 
  WHERE last_name LIKE 'E%'
    AND last_name LIKE '%e'
  ORDER BY emp_no; 

SELECT COUNT(*) 
  FROM employees 
  WHERE last_name LIKE 'E%'
    AND last_name LIKE '%e';

-- 6. Write a query to find all employees whose last name 
--    starts and ends with 'E'. Sort the results by their
--    hire date, so that the newest employees are listed 
--    first. 
--NUMBER OF EMPLOYEES: 899
--NEWEST EMPLOYEE: Teiji Eldridge
--OLDEST EMPLOYEE: Sergi Erde

SELECT * 
  FROM employees 
  WHERE last_name LIKE 'E%'
    AND last_name LIKE '%e'
  ORDER BY hire_date DESC; 

SELECT COUNT(*) 
  FROM employees 
  WHERE last_name LIKE 'E%'
    AND last_name LIKE '%e';

-- 7. Find all employees hired in the 90s and born on Christmas.
--    Sort the results so that the oldest employee who was
--    hired last is the first result. 
--NUMBER OF EMPLOYEES:
--OLDEST EMPLOYEE, HIRED LAST:
--YOUNGEST EMPLOYEE, HIRED FIRST: 

SELECT *
  FROM employees
  WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
    AND hire_date LIKE '%12-25'
  ORDER BY birth_date, hire_date DESC;

SELECT COUNT(*)
  FROM employees
  WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
    AND hire_date LIKE '%12-25';
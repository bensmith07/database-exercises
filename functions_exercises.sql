-- 2. Write a query to find all employees whose lat name 
--    starts and ends with E. Use a concat() to combine 
--    their first and last name together as a single column 
--    named full_name

SELECT CONCAT(first_name, ' ', last_name) AS 'full_name' 
  FROM employees 
  WHERE last_name LIKE 'E%'
    AND last_name LIKE '%e'
  ORDER BY last_name, first_name;

-- 3. Convert the names produced in your last query to all
--    uppercase. 

SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS 'full_name' 
  FROM employees 
  WHERE last_name LIKE 'E%'
    AND last_name LIKE '%e'
  ORDER BY last_name, first_name;

-- Find all employees hired in the 90s and born on Christmas.
-- Use datediff() function to find how many days they have 
-- been working at the company (Hint: you will also need to
-- use NOW() or CURDATE() ).

SELECT first_name, 
       last_name, 
       DATEDIFF(NOW(), hire_date) AS days_worked
  FROM employees
  WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
    AND hire_date LIKE '%12-25'
    ORDER BY days_worked DESC, last_name, first_name;

-- 5. Find the smallest and largest current salary from 
--    the salaries table.
--MIN: 38623
--MAX: 158220

SELECT MIN(salary), MAX(salary)
  FROM salaries
  WHERE to_date = '9999-01-01'

-- 6. Use your knowledge of built in SQL functions to generate
--    a username for all of the employees. A username should
--    be all lowercase, and consist of the first characer of
--    the employees first name, the first 4 characters of the
--    employee's last name, an underscore, the month the
--    employee was born, and the last two digits of the year
--    that they were born. 

SELECT first_name, last_name, birth_date,
       LOWER(CONCAT(
                    SUBSTR(first_name, 1, 1), 
                    SUBSTR(last_name, 1, 4), 
                    '_',
                    SUBSTR(birth_date, 6, 2), 
                    SUBSTR(birth_date, 3, 2)
                   ))
          AS 'username'
  FROM employees;
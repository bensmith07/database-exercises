-- 2. Use DISTINCT to find the unique titles in the titles
--    table. How many unique titles have their ever been?
--ANSWER: 7

SELECT DISTINCT title
  FROM titles;

SELECT COUNT(DISTINCT title)
  FROM titles;

-- 3. Write a query to find a list of all unique last names 
--    of all employees that start and end with 'E' using 
--    GROUP BY. 

SELECT last_name 
  FROM employees
  WHERE last_name LIKE 'E%'
    AND last_name LIKE '%E'
  GROUP BY last_name;

-- 4. Write a query to find all unique combinations of first
--    and last names of all employees whose last names start 
--    and end with E. 

SELECT *
  FROM employees
  WHERE last_name LIKE 'E%'
    AND last_name LIKE '%E'
  GROUP BY last_name, first_name
  ORDER BY last_name, first_name;

-- 5. Write a query to find the unique last names with a 'q'
--    but not a 'q'
--RESULTS: Chleq, Lindqvist, Qiwen

SELECT last_name
  FROM employees 
  WHERE last_name LIKE '%q%'
    AND last_name NOT LIKE '%qu%'
  GROUP BY last_name;

-- 6. Add a count() to your results (the query above) to find
-- the number of employees with the same last name. 
--RESULTS: Chleq 189, Lindqvist 190, Qiwen 168

SELECT last_name, COUNT(last_name)
  FROM employees 
  WHERE last_name LIKE '%q%'
    AND last_name NOT LIKE '%qu%'
  GROUP BY last_name;

-- 7. Find all employees with first names 'Irena', 'Vidya',
--    or 'Maya'. Use COUNT(*) and GROUOP BY to find the 
--    number of employees for each gender with those names.

SELECT gender, COUNT(*) 
  FROM employees 
  WHERE first_name IN ('Irena', 'Vidya', 'Maya')
  GROUP BY gender;

-- 8. Using your query that generates a username for all
--    of the employees, generate a count of employees for
--    each unique username. Are there any duplicate usernames?
--ANSWER: YES

SELECT LOWER(CONCAT(
                    SUBSTR(first_name, 1, 1), 
                    SUBSTR(last_name, 1, 4), 
                    '_',
                    SUBSTR(birth_date, 6, 2), 
                    SUBSTR(birth_date, 3, 2)
                   ))
          AS 'username',
        COUNT(*)
  FROM employees
  GROUP BY username
  ORDER BY COUNT(*) DESC;

-- BONUS: How many duplicate usernames are there?
-- ANSWER: 13251

SELECT COUNT(*)
    FROM (
          SELECT LOWER(CONCAT(
                    SUBSTR(first_name, 1, 1), 
                    SUBSTR(last_name, 1, 4), 
                    '_',
                    SUBSTR(birth_date, 6, 2), 
                    SUBSTR(birth_date, 3, 2)
                   ))
                  AS 'username',
                COUNT(*) as 'count_of_users'
            FROM employees
            GROUP BY username
          ) as usernames_table
    WHERE count_of_users > 1;

-- 9. More practice with aggregate functions

-- 9a. Determine the historic average salary for each
--     employee.

SELECT emp_no, AVG(salary)
    FROM salaries
    GROUP BY emp_no;

-- 9b. Using the dept_emp table, count how many current
--     employees work in each department. 

SELECT dept_no, COUNT(*) as count_of_emp
    FROM dept_emp
    WHERE to_date = '9999-01-01'
    GROUP BY dept_no;

-- 9c. Determine how many different salaries each employee 
--     has had. This includes both historic and current. 

SELECT emp_no, COUNT(*) AS count_of_salaries
    FROM salaries
    GROUP BY emp_no; 

-- 9d. Find the maximum salary for each employee.  

SELECT emp_no, MAX(salary)
    FROM salaries
    GROUP BY emp_no; 

-- 9e. Find the minimum salary for each employee. 

SELECT emp_no, MIN(salary)
    FROM salaries
    GROUP BY emp_no;

-- 9f. Find the standard deviation of salaries for each emp.

SELECT emp_no, STDDEV(salary)
    FROM salaries
    GROUP BY emp_no;

-- 9g. Find the max salary for each employee where that
--     max salary is greater than $150,000

SELECT emp_no, MAX(salary)
    FROM salaries
    GROUP BY emp_no
    HAVING MAX(salary) > 150000;

-- 9H. Find the average salary for each employee where 
--     that average salary is between $80k and $90k. 

SELECT emp_no, AVG(salary)
    FROM salaries
    GROUP BY emp_no
    HAVING AVG(salary) BETWEEN 80000 AND 90000;


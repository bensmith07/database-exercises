

-- 1. Using the example from the lesson, create 
--    a temporary table called employees_with_departments
--    that contains first_name, last_name, and 
--    dept_name for employees currently with 
--    that department. 

USE employees;

CREATE TEMPORARY TABLE innis_1663.employees_with_departments
    AS  SELECT e.first_name, 
               e.last_name, 
               d.dept_name
          FROM employees as e 
            JOIN dept_emp as de
              ON e.emp_no = de.emp_no
            JOIN departments as d
              ON de.dept_no = d.dept_no 
          WHERE de.to_date = '9999-01-01'
          ORDER BY d.dept_name, 
                   e.last_name, 
                   e.first_name;

-- 1a. Add a column named full_name to this 
--     table. It should be a VARCHAR whose length 
--     is the sum of the lengths of the first name 
--     and last name columns. 

ALTER TABLE innis_1663.employees_with_departments
    ADD full_name VARCHAR(31);

-- 1b. Update the table so that full name 
--     column contains the correct data.

UPDATE innis_1663.employees_with_departments
    SET full_name = CONCAT(first_name, ' ', last_name);
        
-- 1c. Remove the first_name and last_name
--     columns from the table. 

ALTER TABLE innis_1663.employees_with_departments
    DROP COLUMN first_name;

ALTER TABLE innis_1663.employees_with_departments
    DROP COLUMN last_name;

-- 1d. What's another way you could have ended
--     up with this same table?
--ANSWER: include the full_name column specification
--        in the original CREATE TABLE subquery
--        Like so: 

CREATE TEMPORARY TABLE innis_1663.employees_with_departments
    AS  SELECT d.dept_name,
               CONCAT(e.first_name, ' ', e.last_name) AS full_name
          FROM employees e 
            JOIN dept_emp de USING(emp_no)
            JOIN departments d USING(dept_no)
          WHERE de.to_date = '9999-01-01';

-- 2. Create a temporary table based on the 
--    payment table from the sakila database.

USE sakila; 

CREATE TEMPORARY TABLE innis_1663.payment
    AS  SELECT *
          FROM payment
          LIMIT 100;
            
-- 2a. Write the SQL necessary to transform the 
--     amount column such that it is stored as 
--     an integer representing the number of 
--     cents of the payment. For example, 1.99 
--     should become 199.

--first, we need to make space to multiply all
--   values by 100. Without changing the amount
--   column type from DECIMAL(5,2) to 
--   DECIMAL(6,2), there is not enough space 
--   in the column to multiply amounts greater 
--   than $9.99 :
ALTER TABLE innis_1663.payment 
    MODIFY amount DECIMAL(6,2);

-- then we can multiply all by 100
UPDATE innis_1663.payment 
  SET amount = (amount * 100);

-- now that all amounts are multiples of 1.00,
--   we can update the column type to INT without
--   changing any values
ALTER TABLE innis_1663.payment 
    MODIFY amount INT;

-- 3. Find out how the current average pay in 
--    each department compares to the overall, 
--    historical average pay. In order to make 
--    the comparison easier, you should use the 
--    Z-score for salaries. 

-- Create temporary table of current average salaries 
-- by dept:
CREATE TEMPORARY TABLE innis_1663.dept_avg_salary AS
    SELECT d.dept_name AS 'department',
           AVG(s.salary) AS 'curr_avg_sal'
      FROM departments d
        JOIN dept_emp de USING(dept_no)
        JOIN employees e USING(emp_no)
        JOIN salaries s USING(emp_no)
      WHERE s.to_date = '9999-01-01'
        AND de.to_date =  '9999-01-01'
      GROUP BY d.dept_name
      ORDER BY AVG(s.salary) DESC;

-- Find the z-scores:
SELECT department,
       curr_avg_sal, 
       (curr_avg_sal - (SELECT AVG(salary) FROM salaries)) 
          / 
          (SELECT stddev(salary) FROM salaries) 
          AS zscore
FROM innis_1663.dept_avg_salary;

-- 3a. In terms of salary, 
--     what is the best department right now to 
--     work for? The worst? 

--ANSWER: Currently, the sales department has both the highest
--        overall salary, and the highest salary as compared to
--        the historical average salary for the company
--        (at 1.5 standard deviations above the historical
--        mean). The HR department has the lowest overall salary,
--        which is very close to the overall historical average
--        (.0009 standard deviations below the historical mean)






-- 1. Write a query that returns all employees (emp_no), 
--    their department number, their start date, their 
--    end date, and a new column 'is_current_employee' 
--    that is a 1 if the employee is still with the 
--    company and 0 if not. 

SELECT e.emp_no AS employee,
       de.dept_no AS department,
       e.hire_date AS start_date,
       de.to_date AS end_date,
       IF(de.to_date = '9999-01-01', True, False) as is_current_employee
  FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
  WHERE (e.emp_no, de.to_date) 
        IN (
            SELECT e.emp_no, MAX(de.to_date)
                FROM employees e
                JOIN dept_emp de ON e.emp_no = de.emp_no
                GROUP BY e.emp_no 
           );

-- 2. Write a query that returns all employee names 
--    (previous and current), and a new column 
--    'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
--    depending on the first letter of their last name. 

SELECT CONCAT(first_name, ' ', last_name) AS 'Employee',
       CASE
         WHEN SUBSTR(last_name, 1, 1) IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H')
           THEN 'A-H'
         WHEN SUBSTR(last_name, 1, 1) IN ('I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q')
           THEN 'I-Q'
         WHEN SUBSTR(last_name, 1, 1) IN ('R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
           THEN 'R-Z'
         END AS 'alpha_group'
  FROM employees;

-- MORE ELEGANT SOLUTION:

SELECT CONCAT(first_name, ' ', last_name) AS 'Employee',
       CASE
         WHEN LEFT(last_name, 1) <= 'H'
           THEN 'A-H'
         WHEN LEFT(last_name, 1) <= 'Q'
           THEN 'I-Q'
         WHEN LEFT(last_name, 1) <= 'Z'
           THEN 'R-Z'
         END AS 'alpha_group'
  FROM employees;

-- 3. How many employees (current or previous) were born 
--    in each decade?
-- ANSWER: 1950s - 182886
--         1960s - 117138
--         OTHER - 0

SELECT COUNT(*),
       CASE
         WHEN birth_date LIKE '195%' 
           THEN '1950s'
         WHEN birth_date LIKE '196%'
           THEN '1960s'
         ELSE 'OTHER'
         END AS decade
  FROM employees
  GROUP BY decade;

-- MORE ROBUST SOLUTION (works for any decade):

SELECT CONCAT(LEFT(birth_date, 3), '0s') AS decade,
       COUNT(*)
  FROM employees
  GROUP BY decade;

-- 4. What is the current average salary for each of 
--        the following department groups: R&D, Sales & 
--        Marketing, Prod & QM, Finance & HR, Customer 
--        Service? 

SELECT 
       CASE 
         WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
         WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing' 
         WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
         WHEN dept_name IN ('Human Resources', 'Finance') THEN 'Finance & HR'
         ELSE dept_name
         END AS dept_group,
       AVG(s.salary) AS avg_salary
  FROM salaries s 
    JOIN employees e ON s.emp_no = e.emp_no
    JOIN dept_emp de ON e.emp_no = de.emp_no 
    JOIN departments d ON de.dept_no = d.dept_no
  WHERE s.to_date = '9999-01-01'
    AND de.to_date = '9999-01-01'
  GROUP BY dept_group;

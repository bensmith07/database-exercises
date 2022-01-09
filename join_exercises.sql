USE join_example_db;

-- 1. Select all the records from both the users and roles table. 

SELECT * 
  FROM users;

SELECT * 
  FROM roles;

-- 2. Use join, left join, and right join to combine the results 
--    to combine the results from the users and roles tables as
--    we did in the lesson. 

SELECT *
  FROM users 
  JOIN roles on users.role_id = roles.id;

SELECT *
  FROM users 
  LEFT JOIN roles on users.role_id = roles.id;

SELECT *
  FROM users 
  RIGHT JOIN roles on users.role_id = roles.id;

-- 3. Use count and the appropriate join type to get a list
--    of roles along with the number of users that has the 
--    role. 

SELECT roles.name AS role_name, 
         COUNT(users.name) AS count_of_users
  FROM users
    RIGHT JOIN roles ON users.role_id = roles.id
  GROUP BY role_name;


-- 1. use the employees database

USE employees;

-- 2. Write a query that shows each department along with
--    the name of the current manager for that department. 

SELECT d.dept_name AS 'Department Name',
       CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
  FROM employees AS e
    JOIN dept_manager AS dm 
      ON e.emp_no = dm.emp_no
    JOIN departments AS d 
      ON dm.dept_no = d.dept_no
  WHERE dm.to_date = '9999-01-01'
  ORDER BY d.dept_name;

-- 3. Find the name of all departments currently
--    managed by women. 

SELECT d.dept_name AS 'Department',
       CONCAT(e.first_name, ' ', e.last_name) AS 'Manager'
  FROM departments AS d 
    JOIN dept_manager as dm
      ON d.dept_no = dm.dept_no
    JOIN employees as e
      ON dm.emp_no = e.emp_no 
  WHERE e.gender = 'F'
    AND dm.to_date = '9999-01-01'
  ORDER BY d.dept_name;

-- 4. Find the current title of employees currently
--    working in the Customer Service Department

SELECT t.title, COUNT(t.emp_no)
  FROM titles AS t 
    JOIN employees AS e 
      ON t.emp_no = e.emp_no
    JOIN dept_emp AS de
      ON e.emp_no = de.emp_no
    JOIN departments AS d 
      ON de.dept_no = d.dept_no 
  WHERE t.to_date = '9999-01-01'
    AND de.to_date = '9999-01-01'
    AND de.dept_no = 'd009'
  GROUP BY t.title
  ORDER BY t.title;

-- 5. Find the current salary of all current 
--    managers.

SELECT d.dept_name AS 'Department',
       CONCAT(e.first_name, ' ', e.last_name) AS 'Manager',
       s.salary AS 'Salary'
  FROM departments AS d
    JOIN dept_manager AS dm
      on d.dept_no = dm.dept_no
    JOIN employees AS e
      ON dm.emp_no = e.emp_no
    JOIN salaries AS s
      ON e.emp_no = s.emp_no 
  WHERE dm.to_date = '9999-01-01'
    AND s.to_date = '9999-01-01'
  ORDER BY d.dept_name;

-- 6. Find the number of current employees in 
--    each department. 

SELECT d.dept_no AS 'Dept #',
       d.dept_name AS 'Department',
       COUNT(de.emp_no) AS 'Number of Employees'
  FROM departments AS d 
    JOIN dept_emp AS de 
      ON d.dept_no = de.dept_no 
  WHERE de.to_date = '9999-01-01'
  GROUP BY de.dept_no
  ORDER BY d.dept_no;

-- 7. Which department has the highest average
--    salary? Hint: use current not historic 
--    information. 

SELECT d.dept_name AS 'Department', 
       AVG(s.salary) AS 'Average Salary'
  FROM departments AS d
    JOIN dept_emp AS de 
      ON d.dept_no = de.dept_no
    JOIN employees AS e
      ON de.emp_no = e.emp_no 
    JOIN salaries AS s 
      ON e.emp_no = s.emp_no
  WHERE s.to_date = '9999-01-01'
  GROUP BY d.dept_name
  ORDER BY AVG(s.salary) DESC
  LIMIT 1;

-- 8. Who is the highest paid employee in the
--    marketing department?



-- 9. Which current department manager has the 
--    highest salary?

SELECT d.dept_name AS 'Department',
       CONCAT(e.first_name, ' ', e.last_name) AS 'Manager',
       s.salary AS 'Salary'
  FROM departments AS d
    JOIN dept_manager AS dm
      on d.dept_no = dm.dept_no
    JOIN employees AS e
      ON dm.emp_no = e.emp_no
    JOIN salaries AS s
      ON e.emp_no = s.emp_no 
  WHERE dm.to_date = '9999-01-01'
    AND s.to_date = '9999-01-01'
  ORDER BY s.salary DESC 
  LIMIT 1;



-- 10. Determine the average salary for each 
--     department. Use all salary information and
--     round your results. 

SELECT d.dept_name AS 'Department', 
       ROUND(AVG(s.salary), 0) AS 'Average Salary'
  FROM departments AS d
    JOIN dept_emp AS de 
      ON d.dept_no = de.dept_no
    JOIN employees AS e
      ON de.emp_no = e.emp_no 
    JOIN salaries AS s 
      ON e.emp_no = s.emp_no
  GROUP BY d.dept_name
   ORDER BY AVG(s.salary) DESC;

-- 11. Bonus Find the names of all current 
--     employees, their department name, and 
--     their current manager's name.




-- 12. Bonus Who is the highest paid employee 
--     within each department.
 
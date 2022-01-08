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

-- 5. Find the current salary of all current managers. 

SELECT 



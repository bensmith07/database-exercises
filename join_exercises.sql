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

SELECT d.dept_name AS department,
       CONCAT(e.first_name, ' ', e.last_name) as manager
  FROM employees AS e
    JOIN dept_manager AS dm 
      ON dm.emp_no = e.emp_no
    JOIN departments AS d 
      ON d.dept_no = dm.dept_no
  WHERE dm.to_date = '9999-01-01';
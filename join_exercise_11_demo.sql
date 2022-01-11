
-- STEP 1: Find the names of all employees...

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee'


  FROM employees AS e 

----------------------------------------------------------
-- STEP 2: Find the names of all employees...
--         WHO ARE CURRENT EMPLOYEES

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee'


  FROM employees AS e
    JOIN dept_emp AS de 
      ON e.emp_no = de.emp_no 



  WHERE de.to_date = '9999-01-01' 

----------------------------------------------------------
-- STEP 3: Find their department name...

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee',
       d.dept_name


  FROM employees AS e
    JOIN dept_emp AS de 
      ON e.emp_no = de.emp_no
    JOIN departments AS d 
      ON de.dept_no = d.dept_no 
     



  WHERE de.to_date = '9999-01-01' 

  --------------------------------------------------------
  -- STEP 4: Link to the CURRENT manager of that department

  SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee',
       d.dept_name


  FROM employees AS e
    JOIN dept_emp AS de 
      ON e.emp_no = de.emp_no
    JOIN departments AS d 
      ON de.dept_no = d.dept_no 
    JOIN dept_manager AS dm 
      ON d.dept_no = dm.dept_no 
     


  WHERE de.to_date = '9999-01-01' 
    AND dm.to_date = '9999-01-01' 

----------------------------------------------------------
-- STEP 5: Find that manager's name 

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee',
       d.dept_name AS 'Department',
       CONCAT(mgr.first_name, ' ', mgr.last_name) AS 'Mgr Name'


  FROM employees AS e
    JOIN dept_emp AS de 
      ON e.emp_no = de.emp_no
    JOIN departments AS d 
      ON de.dept_no = d.dept_no 
    JOIN dept_manager AS dm 
      ON d.dept_no = dm.dept_no
    JOIN employees AS mgr
      ON dm.emp_no = mgr.emp_no
     


  WHERE de.to_date = '9999-01-01' 
    AND dm.to_date = '9999-01-01' ;




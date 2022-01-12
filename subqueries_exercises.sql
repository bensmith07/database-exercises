
-- 1. Find all the current employees with the
--    same hire date as employee 101010 using a
--    sub-query.

SELECT CONCAT(first_name, ' ', last_name) as 'Employee Name'
  FROM employees
  WHERE hire_date = (
                     SELECT hire_date
                       FROM employees
                       WHERE emp_no = 101010
                    )
    AND emp_no IN (
                   SELECT emp_no
                     FROM dept_emp
                     WHERE to_date = '9999-01-01'
                  )
  ORDER BY last_name, first_name;

-- 2. Find all the titles ever held by all
--    current employees with the first name
--    Aamod.

SELECT t.title
  FROM titles AS t
    JOIN employees AS e
      ON t.emp_no = e.emp_no
  WHERE e.first_name = 'Aamod'
  GROUP BY t.title
  ORDER BY t.title;

-- 3. How many people in the employees table
--    are no longer working for the company?
--ANSWER: 59900

SELECT COUNT(emp_no)
  FROM (
        SELECT emp_no
        FROM dept_emp
        WHERE to_date < CURDATE()
            AND (emp_no, to_date) IN (
                                      SELECT emp_no, MAX(to_date)
                                      FROM dept_emp
                                      GROUP BY emp_no
                                     )
       )
        AS previous_employees;

-- total employees = 300,024
-- previous employees = 91,153


-- 4. Find all the current department managers
--    that are female. List their names in a
--    comment in your code.
--ANSWER: Isamu Legleitner, Karsten Sigstam,
--        Leon DasSarma, Hilary, Kambil

SELECT CONCAT(first_name, ' ', last_name) as 'Female Managers'
  FROM employees
  WHERE gender = 'F'
    AND emp_no IN (
                   SELECT emp_no
                     FROM dept_manager
                     WHERE to_date = '9999-01-01'
                  );

-- 5. Find all the employees who currently have
--    a higher salary than the company' overall,
--    historical average salary.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee',
       s.salary as 'Salary'
  FROM employees AS e
    JOIN salaries AS s
      ON e.emp_no = s.emp_no
  WHERE s.to_date ='9999-01-01'
    AND s.salary > (
                    SELECT AVG(salary)
                      FROM salaries
                   );

-- 6. How many current salaries are within 1
--    standard deviation of the current highest
--    salary?
--ANSWER: 83

SELECT COUNT(salary) AS 'Number of salaries within 1 STDDEV of MAX salary'
  FROM salaries
  WHERE to_date = '9999-01-01'
    AND salary BETWEEN (
                        (SELECT MAX(salary) FROM salaries WHERE to_date = '9999-01-01')
                        - (SELECT STDDEV(salary) FROM salaries WHERE to_date = '9999-01-01')
                       )
                   AND (
                        (SELECT MAX(salary) FROM salaries WHERE to_date = '9999-01-01')
                        + (SELECT STDDEV(salary) FROM salaries WHERE to_date = '9999-01-01')
                       );

--    What percentage of all salaries is
--    this?
--ANSWER: 0.03%

SELECT COUNT(salary) / (
                        SELECT COUNT(salary)
                        FROM salaries
                        WHERE to_date = '9999-01-01'
                       )
            AS 'Portion of salaries within 1 STDDEV of MAX salary'
  FROM salaries
  WHERE to_date = '9999-01-01'
    AND salary BETWEEN (
                        (SELECT MAX(salary) FROM salaries WHERE to_date = '9999-01-01')
                        - (SELECT STDDEV(salary) FROM salaries WHERE to_date = '9999-01-01')
                       )
                   AND (
                        (SELECT MAX(salary) FROM salaries WHERE to_date = '9999-01-01')
                        + (SELECT STDDEV(salary) FROM salaries WHERE to_date = '9999-01-01')
                       );

-- BONUS

-- 1. Find all the department names that
--    currently have female managers.

SELECT d.dept_name
  FROM departments AS d
  WHERE d.dept_no IN (
                      SELECT dm.dept_no
                        FROM dept_manager AS dm
                        WHERE dm.to_date = '9999-01-01'
                          AND dm.emp_no IN (
                                            SELECT emp_no
                                              FROM employees
                                              WHERE gender = 'F'
                                           )
                      );

-- 2. Find the first and last name of the
--    employee with the highest salary.

SELECT first_name, last_name
  FROM employees
  WHERE emp_no IN (
                   SELECT emp_no
                     FROM salaries
                     WHERE salary = (
                                     SELECT MAX(salary)
                                       FROM salaries
                                    )
                  );

-- 3. Find the department name that the
--    employee with the highest salary works in.

SELECT dept_name
  FROM departments
  WHERE dept_no
        IN (
            SELECT dept_no
                FROM dept_emp
                WHERE emp_no
                      IN (
                          SELECT emp_no
                            FROM salaries
                            WHERE salary = (
                                            SELECT MAX(salary)
                                              FROM salaries
                                              WHERE to_date = '9999-01-01'
                                            )
                          )
           );
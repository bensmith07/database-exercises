USE employees;

-- 2. List the first 10 distinct last name sorted in
--    descending order. 

SELECT DISTINCT last_name
  FROM employees 
  ORDER BY last_name DESC 
  LIMIT 10;

-- 3. Find all previous or current employees hired in the 90s
--    and born on Christmas. Sort by hire date and limit your 
--    results to the first 5 records. 
--FIRST 5 EMPLOYEES HIRED ON CHRISTMAS:
--    Yinghua Dredge
--    Jinpo Langford
--    Tiina Speek
--    Takahira Spataro
--    Jaber Piveteau

SELECT *
  FROM employees
  WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
    AND hire_date LIKE '%-12-25'
  ORDER BY hire_date
  LIMIT 5; 

-- 4. The first five results are your first page, the five 
--    after that would be your second page etc. Update the 
--    previous query to find the tenth page of results. 

SELECT *
  FROM employees
  WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
    AND hire_date LIKE '%-12-25'
  ORDER BY hire_date
  LIMIT 5 OFFSET 45;

-- LIMIT and OFFSET can be used to create multiple pages of 
-- data. What is the relationship between OFFSET (number of 
-- results to skip), LIMIT (number of results per page), and
-- the page number?

-- ANSWER: offset_number == (page_number - 1) * (limit_number)
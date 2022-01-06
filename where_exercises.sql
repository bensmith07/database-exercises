-- 2. Find all current or previous employees with first 
--    names 'Irena', 'Vidya', or 'Maya' using IN.

SELECT *
  FROM employees 
  WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- Enter a comment with the number of records returned
-- ANSWER: 709

SELECT COUNT(*)
  FROM employees 
  WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- 3. Find all current or previous employees with first 
--    names 'Irena', 'Vidya', or 'Maya' as in Q2, but use
--    OR instead of IN. 

SELECT *
  FROM employees 
  WHERE first_name = 'Irena'
    OR first_name = 'Vidya'
    OR first_name = 'Maya';

-- Enter a comment with the number of records returned. 
-- Does it match number of rows from Q2?
-- ANSWER: 709, yes it matches

SELECT count(*)
  FROM employees 
  WHERE first_name = 'Irena'
    OR first_name = 'Vidya'
    OR first_name = 'Maya';

-- 4. Find all current or previous employees with first 
--    names 'Irena', 'Vidya', or 'Maya', using OR, and who 
--    is male. Enter a comment with the number of records 
--    returned. 
-- ANSWER: 441

SELECT *
  FROM employees 
  WHERE gender = 'M'
     AND (
          first_name = 'Irena' 
          OR first_name = 'Vidya' 
          OR first_name = 'Maya'
         );

SELECT count(*)
  FROM employees 
  WHERE gender = 'M'
     AND (
          first_name = 'Irena' 
          OR first_name = 'Vidya' 
          OR first_name = 'Maya'
         );
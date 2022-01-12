-- EMPLOYEES DATABASE
USE employees;

-- 1. How much do the current managers of each department 
--    get paid, relative to the average salary for the 
--    department? Is there any department where the 
--    department manager gets paid less than the average 
--    salary?

-- Create temporary table with current average salary for 
-- each department
CREATE TEMPORARY TABLE innis_1663.dept_avg_salary AS
    SELECT d.dept_no,
           d.dept_name AS 'department',
           AVG(s.salary) AS 'curr_avg_sal'
      FROM departments AS d
        JOIN dept_emp AS de
          ON d.dept_no = de.dept_no
        JOIN employees AS e
          ON de.emp_no = e.emp_no
        JOIN salaries as s 
          ON e.emp_no = s.emp_no 
      WHERE s.to_date = '9999-01-01'
      GROUP BY d.dept_name;

-- Perform calculations
SELECT d.dept_name AS 'Department',
       s.salary AS 'Current Manager Salary',
       curr_avg_sal 'Dept Avg Salary',
       s.salary - da.curr_avg_sal AS 'Difference',
       CASE 
         WHEN s.salary - da.curr_avg_sal <= 0 THEN 'Yes'
         ELSE 'No'
         END AS 'Salary less than Average?'
  FROM innis_1663.dept_avg_salary AS da
    JOIN departments AS d 
      ON da.dept_no = d.dept_no 
    JOIN dept_manager AS dm 
      on d.dept_no = dm.dept_no
    JOIN employees AS e  
      ON dm.emp_no = e.emp_no 
    JOIN salaries AS s
      ON e.emp_no = s.emp_no 
  WHERE dm.to_date = '9999-01-01'
    AND s.to_date = '9999-01-01'
  ORDER BY d.dept_name;  


-- WORLD DATABASE
USE world;

-- 1. What languages are spoken in Santa Monica?

SELECT countrylanguage.language, countrylanguage.percentage
  FROM countrylanguage 
    JOIN country 
      ON countrylanguage.countrycode = country.code 
    JOIN city
      ON country.code = city.countrycode 
  WHERE city.name = 'Santa Monica'
  ORDER BY countrylanguage.percentage DESC;

-- 2. How many different countries are in each region?

SELECT region, 
       COUNT(*) AS count_of_countries
  FROM country 
  GROUP BY region
  ORDER BY count_of_countries;

-- 3. What is the population for each region?

SELECT region,
       SUM(population) AS population
  FROM country
  GROUP BY region
  ORDER BY SUM(population) DESC;

-- 4. What is the population for each continent?

SELECT continent,
       SUM(population) AS population
  FROM country
  GROUP BY continent 
  ORDER by SUM(population) DESC; 

-- 5. What is the average life expectancy globally?

SELECT AVG(lifeexpectancy)
  FROM country;

-- 6a. What is the average life expectancy for each region?

SELECT region,
       AVG(lifeexpectancy)
  FROM country
  GROUP BY region
  ORDER BY AVG(lifeexpectancy);

-- 6b. What is the average life expectancy for each continent?

SELECT continent,
       AVG(lifeexpectancy)
  FROM country
  GROUP BY continent
  ORDER BY AVG(lifeexpectancy);

-- BONUS

-- 1. Find all the countries whose local name is different
--    from the official name:

SELECT name, localname
  FROM country
  WHERE name != localname;

-- 2. How many countries have a life expectancy less than x?

SELECT COUNT(*)
  FROM country
  WHERE lifeexpectancy > 50;

-- 3. What state is city x located in?

-- declare local variable x with a city ID (Chicago in this case)
SET @x = 3795;

SELECT country.name AS 'Country'
  FROM country 
    JOIN city
      ON country.code = city.countrycode 
  WHERE city.id = @x;

-- 4. What region of the world is city x located in?

-- declare local variable x with a city ID (Tokyo in this case)
SET @x = 1532

SELECT country.region
  FROM country
    JOIN city
      ON country.code = city.countrycode 
  WHERE city.id = @x;

-- 5. What country is city x located in 

-- declare local variable x with a city ID (Paris in this case)
SET @x = 2974;

SELECT country.name
  FROM country
    JOIN city
      ON country.code = city.countrycode
  WHERE city.id = @x;

-- 6. What is the life expectancy in city x

-- declare local variable x with a city ID (Dayton, OH in this case)
SET @x = 3916;

SELECT country.lifeexpectancy
  FROM country
    JOIN city
      ON country.code = city.countrycode 
  WHERE city.id = @x;

-- SAKILA DATABASE
USE sakila;

-- 1. Display the first and last names in all lowercase
--    of all the actors. 

SELECT LOWER(CONCAT(first_name, ' ', last_name)) AS 'Actor Name'
  FROM actor
  ORDER BY last_name, first_name;

-- 2. find the ID number, first name, and last name of 
--    an actor, of whom you know only the first name, "Joe." 

SELECT actor_id, first_name, last_name
  FROM actor
  WHERE first_name = 'Joe'
  ORDER BY last_name;

-- 3. Find all actors whose last name contain the 
--    letters "gen":

SELECT * 
  FROM actor
  WHERE last_name LIKE '%gen%'
  ORDER BY last_name, first_name;

-- 4. Find all actors whose last names contain the letters
--     "li". This time, order the rows by last name and 
--    first name, in that order.

SELECT * 
  FROM actor
  WHERE last_name LIKE '%li%'
  ORDER BY last_name, first_name;

-- 5. Using IN, display the country_id and country columns 
--    for the following countries: Afghanistan, Bangladesh,
--    and China:

SELECT country_id, country
  FROM country
  WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 6. List the last names of all the actors, as well as how
--    many actors have that last name. 

SELECT last_name, COUNT(*)
  FROM actor 
  GROUP BY last_name;

-- 7. List last names of actors and the number of actors 
--    who have that last name, but only for names that are 
--    shared by at least two actors

SELECT last_name, COUNT(*)
  FROM actor
  GROUP BY last_name
  HAVING COUNT(*) >= 2
  ORDER BY COUNT(*);

-- 8. You cannot locate the schema of the address table. 
--    Which query would you use to re-create it?
SHOW databases;
USE sakila;
SHOW tables;
SHOW CREATE TABLE address;

-- 9. Use JOIN to display the first and last names and 
--    address of each staff member

SELECT s.first_name, s.last_name, a.address
  FROM staff AS s
    JOIN address AS a
      ON s.address_id = a.address_id;

-- 10. Use JOIN to display the total amount rung up 
--     by each staff member in August of 2005.

SELECT CONCAT(s.first_name, ' ', s.last_name) AS 'Staff Member',
       SUM(p.amount)
  FROM staff AS s
    JOIN payment AS p 
      ON s.staff_id = p.staff_id
  GROUP BY p.staff_id;

-- 11. List each film and the number of actors who are 
--     listed for that film.

SELECT f.film_id, f.title, COUNT(fa.actor_id)
  FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id 
  GROUP BY fa.film_id;

-- 12. How many copies of the film Hunchback Impossible 
--     exist in the inventory system?

SELECT COUNT(*) 
  FROM inventory AS i 
    JOIN film AS f
      ON i.film_id = f.film_id
  WHERE f.title = 'HUNCHBACK IMPOSSIBLE'; 

-- 13. Use subqueries to display the titles of movies 
--     starting with the letters K and Q whose language 
--     is English.

SELECT title 
  FROM film 
  WHERE (
         title LIKE 'K%'
         OR title LIKE 'Q%'
        )
    AND language_id IN (
                        SELECT language_id
                          FROM language
                          WHERE name = 'English'
                       );

-- #13 Using joins:

SELECT f.title 
  FROM film f 
    JOIN language l ON f.language_id = l.language_id
  WHERE (
         f.title LIKE 'Q%'
         OR f.title LIKE 'K%'  
        )
    AND l.name = 'English';

-- 14. Use subqueries to display all actors who appear in 
--     the film Alone Trip

SELECT CONCAT(first_name, ' ', last_name) AS 'Actor'
  FROM actor
    WHERE actor_id 
            IN (
                SELECT actor_id
                  FROM film_actor
                  WHERE film_id 
                          IN (
                              SELECT film_id
                                FROM film
                                WHERE title = 'Alone Trip'
                             )
               );

-- 15. You want to run an email marketing campaign in 
--     Canada, for which you will need the names and 
--     email addresses of all Canadian customers.

SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'Name',
       c.email AS 'Email Address'
  FROM customer c
    JOIN address ON c.address_id = address.address_id
    JOIN city    ON address.city_id = city.city_id 
    JOIN country ON city.country_id = country.country_id 
  WHERE country.country = 'Canada';

-- 16. Sales have been lagging among young families, 
--     and you wish to target all family movies for a 
--     promotion. Identify all movies categorized as famiy 
--     films.

SELECT f.title 
  FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id 
    JOIN category c       ON fc.category_id = c.category_id
  WHERE c.name = 'Family';

-- 17. Write a query to display how much business, in 
--     dollars, each store brought in.

SELECT store.store_id, 
       SUM(payment.amount)
  FROM store
    JOIN staff   ON store.store_id = staff.store_id
    JOIN payment ON staff.staff_id = payment.staff_id 
  GROUP by store.store_id;

-- 18. Write a query to display for each store its 
--     store ID, city, and country.

SELECT s.store_id, ct.city, cr.country
  FROM store s 
    JOIN address a  ON s.address_id = a.address_id
    JOIN city ct    ON a.city_id = ct.city_id 
    JOIN country cr ON ct.country_id = cr.country_id;

-- 19. List the top five genres in gross revenue in 
--     descending order. (Hint: you may need to use the 
--     following tables: category, film_category, 
--     inventory, payment, and rental.)

SELECT c.name AS 'Genre',
       SUM(p.amount) AS 'Gross Revenue'
  FROM category c 
    JOIN film_category fc ON c.category_id = fc.category_id 
    JOIN film f           ON fc.film_id = f.film_id 
    JOIN inventory i      ON fc.film_id = i.film_id 
    JOIN rental r         ON i.inventory_id = r.inventory_id 
    JOIN payment p        ON p.rental_id = r.rental_id 
  GROUP BY c.name
  ORDER BY SUM(p.amount) DESC
  LIMIT 5;
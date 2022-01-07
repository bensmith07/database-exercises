-- Use the albums_db database
USE albums_db;
SHOW TABLES;

-- 3. Explore the structure of the albums table. 
DESCRIBE albums;

-- 3a. How many rows are in the albums table?
-- ANSWER: 31
SELECT COUNT(id)
  FROM albums;

-- 3b. How many unique artist names are in the albums table?
-- ANSWER: 23
SELECT COUNT(DISTINCT artist)
  FROM albums;

-- 3c. What is the primary key for albums table?
-- ANSWER: id
DESCRIBE albums;

-- 3d. What is the oldest release date for any album in the 
--     albums table?
-- ANSWER: 1967
SELECT MIN(release_date)
  FROM albums;

-- 4. Write queries to find the following informaiton:

-- 4a. The name of all albums by Pink Floyd
SELECT name
  FROM albums
  WHERE artist = 'Pink Floyd';

-- 4b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date
  FROM albums
  WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

-- 4c. The genre for the album Nevermind
SELECT genre 
  FROM albums 
  WHERE name = 'Nevermind';

-- 4d. Which albums were released in the 1990s
SELECT name
  FROM albums
  WHERE release_date BETWEEN 1990 AND 1999;

-- 4e. Which albums had less than 20 million certified sales
SELECT name
  FROM albums 
  WHERE sales < 20;

-- 4f. All the albums with a genre of "Rock". 
--     Why do these query results not include albums with a
--     genre of "Hard rock" or "Progressive Rock"?
-- ANSWER: this query returns results for albums whose genre
--         is listed as the specific string 'Rock'. 
--         'Hard Rock' and 'Progressive Rock' are different strings.
SELECT name
  FROM albums
  WHERE genre = 'Rock';
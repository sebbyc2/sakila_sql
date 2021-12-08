-- List all actors.
SELECT *
FROM actor;	

-- Find the surname of the actor with the forename 'John'.
SELECT first_name	
FROM actor
WHERE last_name = "John";

-- Find all actors with surname 'Neeson'.
SELECT *	
FROM actor
WHERE last_name = "Neeson";

-- Find all actors with ID numbers divisible by 10.
SELECT *	
FROM actor
WHERE actor_id % 10 = 0;

-- What is the description of the movie with an ID of 100?
SELECT description	
FROM film 
WHERE film_id = 100;

-- Find every R-rated movie.
SELECT *	
FROM film 
WHERE rating = "R";

-- Find every non-R-rated movie.
SELECT *	
FROM film
WHERE rating != "R";

-- Find the ten shortest movies.
SELECT *	
FROM film
ORDER BY length
LIMIT 10;

-- Find the movies with the longest runtime, without using LIMIT.
SELECT *	
FROM film
WHERE length = (
	SELECT MAX(length)
    FROM film
);

-- Find all movies that have deleted scenes.
SELECT *	
FROM film
WHERE special_features
LIKE "%Deleted Scenes%";

-- Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name	
FROM actor
GROUP BY last_name
HAVING COUNT(last_name)=1
ORDER BY last_name DESC;  

-- Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name	
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1 
ORDER BY COUNT(last_name) DESC;

-- Which actor has appeared in the most films?
SELECT a.first_name
	, a.last_name
FROM actor a JOIN film_actor f
ON a.actor_id=f.actor_id
GROUP BY a.actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

-- OR

SELECT first_name
	, last_name
FROM actor
WHERE actor_id = (
	SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    ORDER BY COUNT(actor_id) DESC
    LIMIT 1
    );

-- When is 'Academy Dinosaur' due?
SELECT DATE_ADD(r.rental_date, INTERVAL f.rental_duration DAY) AS due_date
	FROM rental r JOIN inventory i JOIN film f
    ON r.inventory_id=i.inventory_id
    AND i.film_id=f.film_id
    WHERE f.title = "Academy Dinosaur"
    AND r.return_date IS NULL;

-- What is the average runtime of all films?
SELECT AVG(length) AS avg_runtime
	FROM film;
SELECT * FROM category;

-- List the average runtime for every film category.
SELECT c.name AS genre, AVG(f.length)
FROM category c JOIN film_category fc JOIN film f
ON c.category_id=fc.category_id
AND fc.film_id=f.film_id
GROUP BY c.name;

-- List all movies featuring a robot.
SELECT title, description
FROM film
WHERE description LIKE "%robot%";

-- How many movies were released in 2010?
SELECT COUNT(film_id) AS films_2010
FROM film
WHERE release_year = 2010;

-- Find the titles of all the horror movies.
SELECT f.title, c.name AS genre
FROM film f JOIN film_category fc JOIN category c
ON c.category_id=fc.category_id
AND fc.film_id=f.film_id
WHERE c.name = "Horror";

-- List the full name of the staff member with the ID of 2.
SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM staff
WHERE staff_id = 2;

-- List all the movies that Fred Costner has appeared in.
SELECT f.title
	, CONCAT(first_name, " ", last_name) AS actor_name
FROM film f JOIN film_actor fa JOIN actor a
    ON f.film_id=fa.film_id AND fa.actor_id=a.actor_id
	WHERE last_name LIKE "%costner%"
    AND first_name LIKE "%fred%";
    
-- How many distinct countries are there?
SELECT COUNT(DISTINCT (country)) AS country_count
FROM country;

-- List the name of every language in reverse-alphabetical order.
SELECT name
FROM language
GROUP BY language_id
ORDER BY name DESC;

-- List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM actor
WHERE last_name LIKE "%son"
ORDER BY first_name;

-- Which category contains the most films?
SELECT c.name AS top_genre
FROM category c JOIN film_category fc JOIN film f
ON c.category_id=fc.category_id
AND fc.film_id=f.film_id
GROUP BY c.name
ORDER BY COUNT(c.name) DESC
LIMIT 1;



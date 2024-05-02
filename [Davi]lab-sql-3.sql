-- How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) AS unique_actors
FROM SAKILA.ACTOR;

-- In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT COUNT(DISTINCT language_id) AS distinct_languages
FROM SAKILA.FILM;
    
-- How many movies were released with "PG-13" rating?
SELECT COUNT(*) AS PG_13_RATE
FROM SAKILA.FILM
WHERE RATING = 'PG-13';

-- Get 10 the longest movies from 2006.
SELECT TITLE, LENGTH
FROM SAKILA.FILM
WHERE RELEASE_YEAR = 2006
ORDER BY LENGTH DESC
LIMIT 10;

-- How many days has been the company operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(RENTAL_DATE), MIN(RENTAL_DATE)) AS days_open
FROM SAKILA.RENTAL;

-- Show rental info with additional columns month and weekday. Get 20.
SELECT *, MONTH(RENTAL_DATE) AS month, DAYNAME(RENTAL_DATE) AS weekday
FROM SAKILA.RENTAL
LIMIT 20;

-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, MONTH(RENTAL_DATE) AS month, 
  DAYNAME(RENTAL_DATE) AS weekday,
CASE 
	WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend' 
	ELSE 'week-day' 
	END AS day_type
FROM SAKILA.RENTAL;
  
 -- How many rentals were in the last month of activity?    
SELECT COUNT(*) AS rentals_last_month
FROM SAKILA.RENTAL
WHERE RENTAL_DATE >= (SELECT DATE_SUB(LAST_DAY(MAX(rental_date)),
	INTERVAL 1 MONTH) + INTERVAL 1 DAY FROM sakila.rental)
    AND rental_date < (SELECT LAST_DAY(MAX(rental_date)) + INTERVAL 1 DAY FROM sakila.rental);
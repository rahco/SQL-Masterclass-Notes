/* NOTES FROM : 15 Days of SQL The Complete SQL Masterclass */

/****************************/
/* USING DB01 - greencycles */
/****************************/

-- SELECT

SELECT * 
FROM address;

SELECT address, district
FROM address;


-- SELECT - Challenge
/* 
The Marketing Manager asks you for a list of all customers.
With first name, last name and the customer's email address.
*/

SELECT first_name, last_name, email 
FROM customer;


-- ORDER BY
/* 
Used to order results based on a column
*/

SELECT first_name, last_name
FROM customer
ORDER BY first_name;

SELECT first_name, last_name
FROM customer
ORDER BY first_name ASC;

SELECT first_name, last_name
FROM customer
ORDER BY first_name DESC;

/* Multiple columns */
SELECT first_name, last_name
FROM customer
ORDER BY first_name, last_name;

SELECT *
FROM payment
ORDER BY customer_id, amount DESC;


-- ORDER BY - Challenge
/* 
> The Marketing Manager asks you to order the customer list by the last name.
> The want to start from "Z" and work towards "A".
> In case of the same last name the order should be based on the first name - also from "Z" to "A".
*/

SELECT first_name, last_name, email
FROM customer
ORDER BY last_name DESC, first_name DESC;

/* Or */
SELECT first_name, last_name, email
FROM customer
ORDER BY 2 DESC, 1 DESC;


-- SELECT DISTINCT
/* 
Used to SELECT the DISTINCT values in a table
*/

SELECT DISTINCT first_name
FROM actor
ORDER BY first_name;

/* Multiple columns */
SELECT DISTINCT first_name, last_name
FROM actor
ORDER BY first_name;

SELECT DISTINCT rating, rental_duration
FROM film
ORDER BY rating;


-- SELECT DISTINCT - Challenge
/* 
> A marketing team member asks you about the different prices that have been paid.
> To make it easier for them order the prices from high to low.
*/

SELECT DISTINCT amount
FROM payment
ORDER BY amount DESC;


-- LIMIT
/* 
> Used to LIMIT the number of rows in the output
> Always at the very end of your query
> Can help to get a quick idea about a table
*/

SELECT first_name
FROM actor
LIMIT 4;

SELECT first_name
FROM actor
ORDER BY first_name
LIMIT 4;

/* Find out the latest ten rentals */
SELECT *
FROM rental
ORDER BY rental_date DESC
LIMIT 10;


-- COUNT
/* 
> Used to COUNT the number of rows in a output
> Used often in combination with grouping & filtering
 */

SELECT COUNT(first_name)
FROM actor;

SELECT COUNT(DISTINCT first_name)
FROM actor;

SELECT COUNT(*)
FROM customer;

SELECT COUNT(first_name)
FROM customer;

SELECT COUNT(DISTINCT first_name)
FROM customer;


-- Day 01 - Challenges

/* 1. Create a list of all the distinct districts customers are from. */
SELECT DISTINCT(district)
FROM address;

/* 2. What is the latest rental date? */
SELECT rental_date
FROM rental
ORDER BY rental_date DESC
LIMIT 1;

/* 3. How many films does the company have? */
SELECT COUNT(DISTINCT(title))
FROM film;

/* 4. How many distinct last names of the customers are there? */
SELECT COUNT(DISTINCT(last_name))
FROM customer;


-- WHERE
/* Used to FILTER the data in the output */

SELECT *
FROM payment
WHERE amount = 10.99;

SELECT first_name, last_name
FROM customer
WHERE first_name = 'ADAM';

SELECT *
FROM payment
WHERE amount = 0;


-- WHERE - Challenge

/* How many payment were made by the customer with customer_id = 100? */
SELECT COUNT(*)
FROM payment
WHERE customer_id = 100;

/* What is the last name of our customer with first name 'ERICA'? */
SELECT first_name, last_name
FROM customer
WHERE first_name = 'ERICA';


-- WHERE | Operators - <, >, !=, is null

SELECT *
FROM payment
WHERE amount > 10.99;

SELECT *
FROM payment
WHERE amount < 10.99;

SELECT *
FROM payment
WHERE amount < 10.99
ORDER BY amount DESC;

/* Not in */
SELECT *
FROM payment
WHERE amount != 10.99;

/* Is null */
SELECT first_name, last_name
FROM customer
WHERE first_name is null;

/* Is not null */
SELECT first_name, last_name
FROM customer
WHERE first_name is not null;

SELECT COUNT(*)
FROM payment
WHERE amount > 10


-- WHERE | Operators - Challenge

/* The inventory manager asks you how rentals have not been returned yet (return_date is null). */
SELECT COUNT(*)
FROM rental
WHERE return_date is null;

/* The sales manager asks you how for a list of all the payment_ids with an amount less than or equal to $2.
Include payment_id and the amount. */
SELECT payment_id, amount
FROM payment
WHERE amount <= 2;


-- WHERE | AND/OR
/* Used to connect two conditions */

SELECT *
FROM payment
WHERE amount = 10.99
AND customer_id = 426;

SELECT *
FROM payment
WHERE amount = 10.99
OR amount = 9.99;

/* The and conjunction will always be processed first */
SELECT *
FROM payment
WHERE amount = 10.99
OR amount = 9.99
AND customer_id = 426;

/* When we use parentheses it is possible to execute OR before AND */
SELECT *
FROM payment
WHERE (amount = 10.99
OR amount = 9.99)
AND customer_id = 426;

SELECT *
FROM payment
WHERE (customer_id = 30
OR customer_id = 31)
AND amount = 2.99;


-- WHERE | AND/OR - Challenge

/* 
The suppcity manager asks you about a list of all the payment of
the customer 322, 346 and 354 where the amount is either less
than $2 or greater than $10.

It should be ordered by the customer first (ascending) and then
as second condition order by amount in a descending order. 
*/

SELECT *
FROM payment
WHERE 
(customer_id = 322 OR customer_id = 346 OR customer_id = 354)
AND 
(amount < 2 OR amount > 10)
ORDER BY customer_id ASC, amount DESC;


-- WHERE | BETWEEN
/* Used to filter a range of values */

SELECT payment_id, amount
FROM payment
WHERE amount BETWEEN 1.99 AND 6.99;

/* Using NOT BETWEEN */
SELECT payment_id, amount
FROM payment
WHERE amount NOT BETWEEN 1.99 AND 6.99;

/* When we do not specify the time, it is considered 0:00, and 
in this case the results of '2020-01-26' are excluded by the query */
SELECT *
FROM payment
WHERE payment_date BETWEEN '2020-01-24' AND '2020-01-26';

SELECT * 
FROM payment
WHERE payment_date BETWEEN '2020-01-24 0:00' AND '2020-01-26 23:59';


-- WHERE | BETWEEN - Challenge

/* 
There have been some faulty payments and you need to help to
found out how many payments have been affected.

How many payments have been made on January 26th and 27th
2020 (including entire 27th) with an amount between 1.99 and 3.99? 
*/

SELECT COUNT(*)
FROM payment
WHERE 
(payment_date BETWEEN '2020-01-26' AND '2020-01-27 23:59')
AND
(amount BETWEEN 1.99 AND 3.99);


-- WHERE | IN

SELECT *
FROM customer
WHERE customer_id IN (123,212,323,243,353,432);

SELECT *
FROM customer
WHERE first_name IN ('LYDIA', 'MATTHEW');

/* NOT IN */
SELECT *
FROM customer
WHERE first_name NOT IN ('LYDIA', 'MATTHEW');


-- WHERE | IN - Challenge

/* There have been 6 complaints of customers about their payments.
customer_id: 12,25,67,93,124,234
The concerned payments are all the payments of these customers with amounts 4.99, 7.99 and 9.99 in January 2020. */

SELECT *
FROM payment
WHERE (customer_id IN(12,25,67,93,124,234))
AND (amount IN(4.99,7.99,9.99))
AND (payment_date BETWEEN '2020-01-01' AND '2020-01-31 23:59')
LIMIT 10;


-- WHERE | LIKE
/* 
Used to filter by matching against a pattern
✓ Use wildcards: _ any single character
✓ Use wildcards: % any sequence of characters
*/

/* First_name starting with A */
SELECT *
FROM actor
WHERE first_name LIKE 'A%';

/* ILIKE is case-insensitive */
SELECT *
FROM actor
WHERE first_name ILIKE 'a%'

/* First_name containing A */
SELECT *
FROM actor
WHERE first_name LIKE '%A%';

/* First_name starting with any character followed by A */
SELECT *
FROM actor
WHERE first_name LIKE '_A%';

/* NOT LIKE */
SELECT *
FROM actor
WHERE first_name NOT LIKE '_A%';

/* Films where there is drama in the description */
SELECT *
FROM film
WHERE description LIKE '%Drama%';

SELECT *
FROM film
WHERE (description LIKE '%Drama%')
AND (title LIKE 'T%');


-- WHERE | LIKE - Challenge

/* You need to help the inventory manager to find out:
How many movies are there that contain the "Documentary" in
the description? */
SELECT COUNT(*)
FROM film
WHERE description LIKE '%Documentary%';

/* How many customers are there with a first name that is
3 letters long and either an 'X' or a 'Y' as the last letter in the last
name? */
SELECT COUNT(*)
FROM customer
WHERE (first_name LIKE '___')
AND (last_name LIKE '%X' OR last_name LIKE '%Y');


-- AS | Alias
/* Used to assign a alias to the output of a column */

SELECT payment_id AS invoice_no
FROM payment;

SELECT title, description AS description_of_movie, release_year
FROM film
WHERE description LIKE '%Documentary%';

SELECT COUNT(*) AS number_of_documentaries
FROM film
WHERE description LIKE '%Documentary%';


-- Day 02 - Challenges

/* 1. How many movies are there that contain 'Saga'
in the description and where the title starts either
with 'A' or ends with 'R'?
Use the alias 'no_of_movies'. */
SELECT COUNT(*) AS no_of_movies
FROM film
WHERE (description LIKE '%Saga%')
AND (title LIKE 'A%' OR title LIKE '%R');

/* 2. Create a list of all customers where the first name contains
'ER' and has an 'A' as the second letter.
Order the results by the last name descendingly. */
SELECT *
FROM customer
WHERE first_name LIKE '%ER%'
AND first_name LIKE '_A%'
ORDER BY last_name DESC;

/* 3. How many payments are there where the amount is either 0
or is between 3.99 and 7.99 and in the same time has
happened on 2020-05-14. */
SELECT COUNT(*)
FROM payment
WHERE (amount = 0 OR amount BETWEEN 3.99 AND 7.99)
AND (payment_date BETWEEN '2020-05-14' AND '2020-05-14 23:59');


-- AGGREGATE FUNCTIONS

/* SUM */
SELECT SUM(amount)
FROM payment;

/* COUNT */
SELECT COUNT(*)
FROM payment;

/* Multiple aggregations */
SELECT SUM(amount), COUNT(*), ROUND(AVG(amount),2) AS average
FROM payment;


-- AGGREGATE FUNCTIONS - Challenge
/*
Write a query to see the
> Minimum
> Maximum
> Average (rounded0)
> Sum
of the replacement cost of the films
*/
SELECT MIN(replacement_cost), MAX(replacement_cost), ROUND(AVG(replacement_cost), 2) AS average, SUM(replacement_cost)
FROM film;


-- GROUP BY
/* Used to GROUP aggregations BY specific columns */

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id;

SELECT customer_id, SUM(amount)
FROM payment
WHERE customer_id > 3
GROUP BY customer_id;

SELECT customer_id, SUM(amount)
FROM payment
WHERE customer_id > 3
GROUP BY customer_id
ORDER BY customer_id;

SELECT customer_id, SUM(amount), MAX(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;


-- GROUP BY - Challenge
/* There are two competitions between the two employees. */

/* Which employee had the highest sales amount in a single day? */
SELECT staff_id, DATE(payment_date) AS day_payment_date, SUM(amount) AS sale_amount
FROM payment
GROUP BY staff_id, DATE(payment_date)
ORDER BY SUM(amount) DESC;

/* Which employee had the most sales in a single day (not counting payments with amount = 0? */
SELECT staff_id, DATE(payment_date) AS day_payment_date, COUNT(*) AS count_of_sales
FROM payment
WHERE amount != 0
GROUP BY staff_id, DATE(payment_date)
ORDER BY COUNT(*) DESC;


-- GROUP BY Multiple columns

SELECT staff_id, customer_id, SUM(amount), COUNT(*)
FROM payment
GROUP BY staff_id, customer_id
ORDER BY COUNT(*) DESC;


-- HAVING
/* Used to FILTER Groupings BY aggregations */

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 200

SELECT staff_id, DATE(payment_date) AS day_payment_date, COUNT(*) AS count_of_sales
FROM payment
WHERE amount != 0
GROUP BY staff_id, DATE(payment_date)
HAVING COUNT(*) > 400
ORDER BY COUNT(*) DESC;

SELECT staff_id, DATE(payment_date) AS day_payment_date, COUNT(*) AS count_of_sales
FROM payment
WHERE amount != 0
GROUP BY staff_id, DATE(payment_date)
HAVING COUNT(*) = 28 OR COUNT(*) = 658
ORDER BY COUNT(*) DESC;


-- HAVING - Challenge

/*
> In 2020, April 28, 29 and 30 were days with very high revenue.
That's why we want to focus in this task only on these days
(filter accordingly).
> Find out what is the average payment amount grouped by
customer and day – consider only the days/customers with
more than 1 payment (per customer and day).
> Order by the average amount in a descending order.
*/
SELECT customer_id, DATE(payment_date) AS payment_day, ROUND(AVG(amount), 2) AS average_amount, COUNT(*)
FROM payment
WHERE payment_date BETWEEN '2020-04-28' AND '2020-04-30 23:59'
-- Or | WHERE DATE(payment_date) IN ('2020-04-28', '2020-04-29', '2020-04-30')
GROUP BY customer_id, DATE(payment_date)
HAVING COUNT(*) > 1
ORDER BY ROUND(AVG(amount), 2) DESC;


-- LENGTH, LOWER & UPPER

SELECT email, UPPER(email) AS email_upper, LOWER(email) AS email_lower
FROM customer;

/* LENGTH is used to get the number of characters in a text string */
SELECT email, LENGTH(email)
FROM customer;

SELECT email, LENGTH(email)
FROM customer
WHERE LENGTH(email) < 30;


-- LENGTH, LOWER & UPPER - Challenge

/* 
	In the email system there was a problem with names where
either the first name or the last name is more than 10 characters
long.
	Find these customers and output the list of these first and last
names in all lower case.
*/
SELECT LOWER(first_name), LOWER(last_name), LOWER(email)
FROM customer
WHERE LENGTH(first_name) > 10
OR LENGTH(last_name) > 10;


-- LEFT & RIGHT

/* LEFT is used to extract a part of a string, starting from the left side */
SELECT first_name, LEFT(first_name, 2)
FROM customer;

/* RIGHT is used to extract a part of a string, starting from the right side */
SELECT first_name, LEFT(first_name, 3)
FROM customer;

SELECT first_name, RIGHT(LEFT(first_name, 3), 1)
FROM customer;


-- LEFT & RIGHT - Challenge
 
/* Extract the last 5 characters of the email address. */
SELECT email, RIGHT(email, 5)
FROM customer;

/* The email address always ends with '.org'. */
SELECT email, LEFT(RIGHT(email, 4), 1)
FROM customer;


-- CONCATENATE

SELECT first_name, last_name, first_name || ' ' || last_name AS full_name
FROM customer;

SELECT first_name, last_name, LEFT(first_name, 1) || '.' || LEFT(last_name, 1) || '.' AS initials_name
FROM customer;


-- CONCATENATE - Challenge

/*
> You need to create an anonymized version of the email addresses.
> It should be the first character followed by '***' and then the last part starting with '@'.
> Note the email address always ends with '@sakilacustomer.org'.
*/
SELECT email, LEFT(email, 1) || '***' || RIGHT(email, 19) AS anonymized_email
FROM customer;


-- POSITION

/* Used to get the number representing the position of a character in a text string */
SELECT email, POSITION('@' IN email)
FROM customer;

/* Used to get part of a text string */
SELECT email, LEFT(email, POSITION('@' IN email) - 1)
FROM customer;

/* Used with a column name to get the number representing the position of a column's text in a text string */
SELECT email, POSITION(last_name IN email)
FROM customer;

SELECT email, LEFT(email, POSITION(last_name IN email) - 2)
FROM customer;


-- POSITION - Challenge

/*
> In this challenge you have only the email address and the last name of the customers.
> You need to extract the first name from the email address and concatenate it with the 
last name. It should be in the form: "Last name, First name".
*/
SELECT last_name || ', ' || LEFT(email, POSITION(last_name IN email) - 2)
FROM customer;
/* Or */
SELECT last_name || ', ' || LEFT(email, POSITION('.' IN email) -1)
FROM customer;


-- SUBSTRIG

/* Used to EXTRACT a SUBSTRING from a string */
SELECT email, SUBSTRING(email from POSITION('.' in email) + 1 for LENGTH(last_name))
FROM customer;
/* Or */
SELECT email, SUBSTRING(email from POSITION('.' in email) + 1 for POSITION('@' in email) - POSITION('.' in email) - 1)
FROM customer;


-- SUBSTRIG - Challenge

-- You need to create an anonymized form of the email addresses in the following way:
SELECT 
LEFT(email,1) 
|| '***' 
|| SUBSTRING(email from POSITION('.' in email) for 2) 
|| '***' 
|| SUBSTRING(email from POSITION('@' in email))
FROM customer;

--In a second query create an anonymized form of the email addresses in the following way:
SELECT
'***'
|| SUBSTRING(email from POSITION('.' in email) - 1 for 3)
|| '***'
|| SUBSTRING(email from POSITION('@' in email))
FROM customer;


-- EXTRACT
--Used to EXTRACT parts of timestamp/date

SELECT 
EXTRACT(day from rental_date), COUNT(*)
FROM rental
GROUP BY EXTRACT(DAY from rental_date)
ORDER BY COUNT(*) DESC;

SELECT 
EXTRACT(month from rental_date), COUNT(*)
FROM rental
GROUP BY EXTRACT(month from rental_date)
ORDER BY COUNT(*) DESC;


-- EXTRACT - Challenges

-- What's the month with the highest total payment amount?
SELECT 
EXTRACT(month from payment_date) as month, SUM(amount) as total_payment_amount
FROM payment
GROUP BY month
ORDER BY total_payment_amount DESC;

-- What's the day of week with the highest total payment amount? (0 is Sunday)
SELECT 
EXTRACT(dow from payment_date) as day_of_week, SUM(amount) as total_payment_amount
FROM payment
GROUP BY day_of_week
ORDER BY total_payment_amount DESC;

-- What's the highest amount one customer has spent in a week?
SELECT 
customer_id
, EXTRACT(week from payment_date) as week
, SUM(amount) as total_payment_amount
FROM payment
GROUP BY week, customer_id
ORDER BY total_payment_amount DESC;


-- TO_CHAR
-- Used to get custom formats timestamp/date/numbers

SELECT 
*
, EXTRACT( month from payment_date)
, TO_CHAR(payment_date, 'MM-YYYY')
FROM payment;


-- TO_CHAR - Challenges

-- You need to sum payments and group in the following formats: 'Fri, 24/01/2020' ; 'May, 2020' ; 'Thu, 02:44'

-- 'Fri, 24/01/2020'
SELECT
SUM(amount) as total_payment
, TO_CHAR(payment_date, 'Dy, DD/MM/YYYY') as day
FROM payment
GROUP BY day
ORDER BY total_payment ASC;

-- 'May, 2020'
SELECT
SUM(amount) as total_payment
, TO_CHAR(payment_date, 'Mon, YYYY') as mon_year
FROM payment
GROUP BY mon_year
ORDER BY total_payment ASC;

-- 'Thu, 02:44'
SELECT
SUM(amount) as total_payment
, TO_CHAR(payment_date, 'Dy, HH:MI') as day_time
FROM payment
GROUP BY day_time
ORDER BY total_payment DESC;


-- Intervals & Timestamps

SELECT CURRENT_DATE
SELECT CURRENT_TIMESTAMP

SELECT
CURRENT_TIMESTAMP
, rental_date
, CURRENT_TIMESTAMP - rental_date
, return_date - rental_date
, EXTRACT(day from return_date - rental_date)
, EXTRACT(hour from return_date - rental_date)
, EXTRACT(day from return_date - rental_date) * 24 + EXTRACT(hour from return_date - rental_date) as total_hours
, EXTRACT(day from return_date - rental_date) * 24 + EXTRACT(hour from return_date - rental_date) || ' hours'
FROM rental


-- Intervals & Timestamps - Challenges

-- You need to create a list for the suppcity team of all rental durations of customer with customer_id 35.
SELECT
customer_id
, return_date - rental_date as rental_duration
FROM rental
WHERE customer_id = 35;

-- Also you need to find out for the suppcity team which customer has the longest average rental duration?
SELECT
customer_id
, AVG(return_date - rental_date) as rental_duration
FROM rental
GROUP BY customer_id
ORDER BY rental_duration DESC;


-- Mathematical functions and operators

-- When we use integers the result will be truncated
SELECT 9/4

-- With decimal numbers the result will accurate
SELECT 9.0/4

-- Exponentiation
SELECT 2^3

-- Ceiling(x): round up to integer
SELECT CEILING(4.3543)

-- Floor(x): round down to integer
SELECT FLOOR(4.3543)

-- (+)
SELECT film_id, rental_rate as old_rental_rate, rental_rate+1 as new_rental_rate
FROM film;

-- (*)
SELECT film_id, rental_rate as old_rental_rate, ROUND(rental_rate*1.1,2) as new_rental_rate
FROM film;

-- CEILING
SELECT film_id, rental_rate as old_rental_rate, CEILING(rental_rate*1.1)-0.01 as new_rental_rate
FROM film;


-- Mathematical functions and operators - Challenge

/* 
Your manager is thinking about increasing the prices for films
that are more expensive to replace.
For that reason, you should create a list of the films including the
relation of rental rate / replacement cost where the rental rate
is less than 4% of the replacement cost.

Create a list of that film_ids together with the percentage rounded
to 2 decimal places. For example 3.54 (=3.54%).
*/

SELECT film_id, ROUND((rental_rate/replacement_cost)*100,2) as percentage
FROM film
WHERE ROUND((rental_rate/replacement_cost)*100,2) < 4
ORDER BY 2 DESC;


/****************************/
/* USING DB02 - demo */
/****************************/

-- CASE WHEN
/*
Like IF/THEN statement: Goes through a set of conditions
returns a value if a condition is met
*/

SELECT
COUNT(*) as flights,
CASE
WHEN actual_departure is null THEN 'No departure time'
WHEN actual_departure-scheduled_departure < '00:05' THEN 'On time'
WHEN actual_departure-scheduled_departure < '01:00' THEN 'A little bit late'
ELSE 'Very late'
END as is_late
FROM flights
GROUP BY is_late;


-- CASE WHEN - Challenges

-- Chanllenge 1:
/* 
You need to find out how many tickets you have sold in the
following categories:
• Low price ticket: total_amount < 20,000
• Mid price ticket: total_amount between 20,000 and 150,000
• High price ticket: total_amount >= 150,000
How many high price tickets has the company sold?
*/
SELECT
COUNT(*) as flights,
CASE
WHEN total_amount < 20000 THEN 'low price ticket'
WHEN total_amount < 150000 THEN 'mid price ticket'
ELSE 'high price ticket'
END as ticket_price
FROM bookings
GROUP BY ticket_price;

-- Chanllenge 2:
/* 
You need to find out how many flights have departed in the
following seasons:
• Winter: December, January, Februar
• Spring: March, April, May
• Summer: June, July, August
• Fall: September, October, November
*/
SELECT 
COUNT(*) as flights,
CASE
WHEN EXTRACT(month from scheduled_departure) IN (12,1,2) THEN 'Winter'
WHEN EXTRACT (month from scheduled_departure) <= 5 THEN 'Spring'
WHEN EXTRACT (month from scheduled_departure) <= 8 THEN 'Summer'
ELSE 'Fall' 
END as season
FROM flights
GROUP BY season;

-- Chanllenge 3:
/****************************/
/* USING DB01 - greencycles */
/****************************/
/* 
You want to create a tier list in the following way:
1. Rating is 'PG' or 'PG-13' or length is more then 210 min:
'Great rating or long (tier 1)
2. Description contains 'Drama' and length is more than 90min:
'Long drama (tier 2)'
3. Description contains 'Drama' and length is not more than 90min:
'Shcity drama (tier 3)'
4. Rental_rate less than $1:
'Very cheap (tier 4)'
If one movie can be in multiple categories it gets the higher tier assigned.
How can you filter to only those movies that appear in one of these 4 tiers?
*/
SELECT
title,
CASE
WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END as tier_list
FROM film
WHERE 
CASE
WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END is not null;


/****************************/
/* USING DB01 - greencycles */
/****************************/

-- CASE WHEN & SUM

SELECT 
SUM(CASE
WHEN rating IN ('PG', 'G') THEN 1
ELSE 0
END) as no_of_ratings_with_g_or_pg
FROM film;

SELECT
SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) as "G",
SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) as "R",
SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) as "NC-17",
SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) as "PG-13",
SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) as "PG"
FROM film;


/****************************/
/* USING DB02 - demo */
/****************************/

-- COALESCE
-- Returns first value of a list of values which is not null
SELECT
COALESCE(actual_arrival-scheduled_arrival, '0:00')
FROM flights;

-- CAST
-- Changes the data type of a value
SELECT
COALESCE(CAST(actual_arrival-scheduled_arrival AS VARCHAR), 'not arrived')
FROM flights;

SELECT
LENGTH(CAST(actual_arrival AS VARCHAR))
FROM flights;

SELECT
CAST(ticket_no AS bigint)
FROM tickets;


-- REPLACE
-- Replaces text from a string in a column with another text

SELECT 
passenger_id,
REPLACE(passenger_id, ' ', ''),
CAST(REPLACE(passenger_id, ' ', '') AS BIGINT)
FROM tickets;

SELECT
flight_no,
CAST(REPLACE(flight_no, 'PG', '') AS INT)
FROM flights


/****************************/
/* USING DB01 - greencycles */
/****************************/


-- INNER JOIN
-- Inner join produces only the set of records that match in both Table A and Table B.

-- Basic example
SELECT *
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

-- Selecting columns e.g.01
SELECT payment.*, first_name, last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

-- Selecting columns e.g.02
SELECT payment_id, payment.customer_id, amount, first_name, last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

-- Using alias
SELECT payment_id, pmt.customer_id, amount, first_name, last_name
FROM payment as pmt
INNER JOIN customer as ctm
ON pmt.customer_id = ctm.customer_id;

SELECT *
FROM payment
INNER JOIN staff
ON payment.staff_id = payment.staff_id;

SELECT payment.*, first_name, last_name, email
FROM payment
INNER JOIN staff
ON payment.staff_id = payment.staff_id;

SELECT payment.*, first_name, last_name, email
FROM payment
INNER JOIN staff
ON payment.staff_id = payment.staff_id;

-- Filtering with WHERE clause
SELECT payment.*, first_name, last_name, email
FROM payment
INNER JOIN staff
ON payment.staff_id = payment.staff_id
WHERE payment.staff_id=1;


/****************************/
/* USING DB02 - demo */
/****************************/


-- INNER JOIN - Challenge

/*
The airline company wants to understand in which category they sell most
tickets.
How many people choose seats in the category
- Business
- Economy
- Comfort?
*/

SELECT fare_conditions, COUNT(*)
FROM boarding_passes AS b
INNER JOIN seats AS s
ON b.seat_no = s.seat_no
GROUP BY fare_conditions;


-- FULL OUTER JOIN
/* 
Full outer join produces the set of all records in Table A and Table B, 
with matching records from both sides where available. If there is no match, 
the missing side will contain null.
*/

SELECT *
FROM boarding_passes AS b
FULL OUTER JOIN tickets AS t
ON b.ticket_no = t.ticket_no;


-- JOIN & WHERE

-- Filtering null results in table A
SELECT *
FROM boarding_passes AS b
FULL OUTER JOIN tickets AS t
ON b.ticket_no = t.ticket_no
WHERE b.ticket_no IS NULL;

SELECT COUNT(*)
FROM boarding_passes AS b
FULL OUTER JOIN tickets AS t
ON b.ticket_no = t.ticket_no
WHERE b.ticket_no IS NULL;

-- Filtering null results in table B
SELECT COUNT(*)
FROM boarding_passes AS b
FULL OUTER JOIN tickets AS t
ON b.ticket_no = t.ticket_no
WHERE t.ticket_no IS NULL;


-- LEFT OUTER JOIN
/*
Left outer join produces a complete set of records from Table A, 
with the matching records (where available) in Table B. If there 
is no match, the right side will contain null.
*/


SELECT *
FROM aircrafts_data AS a
LEFT JOIN flights AS f
ON a.aircraft_code = f.aircraft_code

-- Filtering null results in table B
SELECT *
FROM aircrafts_data AS a
LEFT JOIN flights AS f
ON a.aircraft_code = f.aircraft_code
WHERE f.flight_id IS NULL;


-- LEFT OUTER JOIN - Challenges

/*  
The flight company is trying to find out what their most popular
seats are.
Try to find out which seat has been chosen most frequently.
Make sure all seats are included even if they have never been
booked.
*/
SELECT s.seat_no, COUNT(*)
FROM seats AS s
LEFT JOIN boarding_passes AS b
ON s.seat_no = b.seat_no
GROUP BY s.seat_no
ORDER BY COUNT(*) DESC


-- Are there seats that have never been booked?

-- No
SELECT COUNT(*)
FROM seats AS s
LEFT JOIN boarding_passes AS b
ON s.seat_no = b.seat_no
WHERE b.seat_no IS null;


-- RIGHT OUTER JOIN
/*
Right outer join produces a complete set of records from Table B, 
with the matching records (where available) in Table A. If there 
is no match, the right side will contain null.
*/

SELECT *
FROM flights AS f
RIGHT JOIN aircrafts_data AS a
ON f.aircraft_code = a.aircraft_code
WHERE f.aircraft_code IS null;


/****************************/
/* USING DB01 - greencycles */
/****************************/

-- RIGHT OUTER JOIN - Challenges
/* 
The company wants to run a phone call campaing on all customers in
Texas (=district).
*/

/* 
What are the customers (first_name, last_name, phone number and their
district) from Texas?
*/
SELECT first_name, last_name, phone, district
FROM customer AS c
LEFT JOIN address AS a
ON c.address_id = a.address_id
WHERE district = 'Texas';

-- Are there any (old) addresses that are not related to any customer?
SELECT *
FROM address AS a
LEFT JOIN customer AS c
ON c.address_id = a.address_id
WHERE c.customer_id IS null;


/****************************/
/* USING DB02 - demo */
/****************************/

-- JOINS ON MULTIPLE CONDITIONS
-- Joining 2 tables with more than one primary key

-- Getting the average price (amount) for the different seat_no!
SELECT seat_no, ROUND(AVG(amount),2)
FROM boarding_passes AS b
LEFT JOIN ticket_flights AS t
ON b.ticket_no = t.ticket_no
AND b.flight_id = t.flight_id
GROUP BY seat_no
ORDER BY 2 DESC;


-- JOINING MULTIPLE TABLES

SELECT t.ticket_no, tf.flight_id, scheduled_departure, passenger_name
FROM tickets AS t
INNER JOIN ticket_flights AS tf
ON t.ticket_no = tf.ticket_no
INNER JOIN flights AS f
ON f.flight_id = tf.flight_id;


-- JOINING MULTIPLE TABLES - Challenge
/* 
The company wants customize their campaigns to customers depending on
the country they are from.
Which customers are from Brazil?
Write a query to get first_name, last_name, email and the country from all
customers from Brazil.
*/
SELECT first_name, last_name, email, co.country
FROM customer AS cu
LEFT JOIN address AS ad
ON cu.address_id = ad.address_id
LEFT JOIN city AS ci
ON ci.city_id = ad.city_id
LEFT JOIN country AS co
ON co.country_id = ci.country_id
WHERE country='Brazil';


/****************************/
/* USING DB02 - demo */
/****************************/

-- CHALLENGES

-- Question 1: Which passenger (passenger_name) has spent most amount in their bookings (total_amount)?
SELECT passenger_name,SUM(total_amount) FROM tickets t
INNER JOIN bookings b
ON t.book_ref=b.book_ref
GROUP BY passenger_name
ORDER BY SUM(total_amount) DESC;
-- Answer: ALEKSANDR IVANOV with 80964000.

-- Question 2: Which fare_condition has ALEKSANDR IVANOV used the most?
SELECT passenger_name, fare_conditions, COUNT(*) FROM tickets t
INNER JOIN bookings b
ON t.book_ref=b.book_ref
INNER JOIN ticket_flights tf
ON t.ticket_no=tf.ticket_no
WHERE passenger_name = 'ALEKSANDR IVANOV'
GROUP BY fare_conditions, passenger_name;
-- Answer: Economy 2131 times.

-- Question 3: Which title has GEORGE LINTON rented the most often?
/****************************/
/* USING DB01 - greencycles */
/****************************/
SELECT first_name, last_name, title, COUNT(*)
FROM customer cu
INNER JOIN rental re
ON cu.customer_id = re.customer_id
INNER JOIN inventory inv
ON inv.inventory_id=re.inventory_id
INNER JOIN film fi
ON fi.film_id = inv.film_id
WHERE first_name='GEORGE' and last_name='LINTON'
GROUP BY title, first_name, last_name
ORDER BY 4 DESC;
-- Answer: CADDYSHACK JEDI - 3 times.


-- UNION
-- UNION merges rows from 2 or more tables into one table with all rows
-- In union, duplicate values are eliminated.
-- If it is necessary to keep duplicate values, the UNION ALL statement should be used.

-- Example of UNION
SELECT first_name FROM actor
UNION 
SELECT first_name FROM customer
ORDER BY first_name;

-- Example of UNION ALL
SELECT first_name FROM actor
UNION ALL
SELECT first_name FROM customer
ORDER BY first_name;

-- Creating a origin column
SELECT first_name, 'actor'as origin FROM actor
UNION
SELECT first_name, 'customer' FROM customer
ORDER BY first_name;

-- Example of UNION with 3 tables
SELECT first_name, 'actor'as origin FROM actor
UNION
SELECT first_name, 'customer' FROM customer
UNION
SELECT UPPER(first_name), 'staff' FROM staff
ORDER BY 2 DESC;


-- SUBQUERIES IN WHERE

-- Using subquery to filter the out put of a query
SELECT *
FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment);

-- Filtering the out put of a query using the equal sinal with a subquery from another table
SELECT *
FROM payment
WHERE customer_id = (SELECT customer_id FROM customer WHERE first_name = 'ADAM');

-- We can use the IN operator if we have a list of multiple values to filter 
SELECT *
FROM payment
WHERE customer_id IN (SELECT customer_id FROM customer WHERE first_name LIKE 'A%');


-- SUBQUERIES IN WHERE - Challenges

-- Select all of the films where the length is longer than the average of all films.
SELECT *
FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- Return all the films that are available in the inventory in store 2 more than 3 times.
SELECT * FROM film
WHERE film_id IN 
	(SELECT film_id FROM inventory
	 WHERE store_id = 2
	 GROUP BY film_id
	 HAVING COUNT(*) > 3);

-- Return all customers' first names and last names that have made a payment on '2020-01-25'
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (SELECT customer_id 
					  FROM payment 
					  WHERE DATE(payment_date) = '2020-01-25');

-- Return all customers' first_names and email addresses that have spent a more than $30
SELECT first_name, email
FROM customer
WHERE customer_id IN (SELECT customer_id
					 FROM payment
					 GROUP BY customer_id
					 HAVING SUM(amount) > 30);

-- Return all customers' first and last names that are form California and have spent more than 100 in total
SELECT first_name, email
FROM customer
WHERE customer_id IN (SELECT customer_id
					 FROM payment
					 GROUP BY customer_id
					 HAVING SUM(amount) > 100)
AND customer_id IN (SELECT customer_id
				   FROM customer
				   INNER JOIN address
				   ON address.address_id = customer.address_id
				   WHERE district = 'California');


-- SUBQUERIES IN FROM

SELECT ROUND(AVG(total_amount), 2) AS avg_lifetime_spent
FROM (SELECT customer_id, SUM(amount) AS total_amount
	 FROM payment
	 GROUP BY customer_id) AS subquery;


-- SUBQUERIES IN FROM - Challenge

-- What is the average total amount spent per day (average daily revenue)?
SELECT ROUND(AVG(amount_per_day), 2) AS daily_rev_avg
FROM (SELECT SUM(amount) AS amount_per_day, DATE(payment_date)
	 FROM payment
	 GROUP BY DATE(payment_date)) AS subquery;


-- SUBQUERIES IN SELECT

SELECT *, (SELECT ROUND(AVG(amount), 2) AS avg_amount FROM payment)
FROM payment


-- SUBQUERIES IN SELECT - Challenges

-- Show all the payments together with how much the payment amount is below the maximum payment amount
SELECT *, (SELECT MAX(amount) FROM payment) - amount AS difference
FROM payment


-- CORRELATED SUBQUERIES IN WHERE

-- Show only those payments that have the highest amount per customer.
SELECT * FROM payment AS p1
WHERE amount = (SELECT MAX(amount) FROM payment AS p2
			   WHERE p1.customer_id = p2.customer_id)
ORDER BY customer_id;


-- CORRELATED SUBQUERIES IN WHERE - Challenges


-- Show only the movies title, their associated film_id and replacement_cost 
-- with the lowest replacement_cost for in each rating category - also show the rating.
SELECT title, film_id, replacement_cost, rating
FROM film AS f1
	WHERE replacement_cost = 
	(SELECT MIN(replacement_cost) 
	FROM film AS f2
	WHERE f1.rating = f2.rating);

-- Show only those movie title, their associated film_id and the length that have 
-- the highest length in each rating category - also show the rating.
SELECT title, film_id, replacement_cost, rating
FROM film AS f1
	WHERE length = 
	(SELECT MAX(length) 
	FROM film AS f2
	WHERE f1.rating = f2.rating);


-- CORRELATED SUBQUERY IN SELECT

-- Show the maximum amount for every customer
SELECT 
*, 
(SELECT MAX(amount) FROM payment AS p2 WHERE p1.customer_id = p2.customer_id)
FROM payment AS p1;


-- CORRELATED SUBQUERY IN SELECT - Challenges

-- Show all the payments plus the total amount for every customer as well 
-- as the number of payments of each customer.
SELECT 
payment_id,
customer_id,
staff_id,
amount,
(SELECT SUM(amount) AS sum_amount FROM payment AS p2 WHERE p1.customer_id = p2.customer_id),
(SELECT COUNT(amount) AS count_payments FROM payment AS p2 WHERE p1.customer_id = p2.customer_id)
FROM payment AS p1
ORDER BY customer_id, amount DESC;

-- Show only those films with the highest replacement costs in their rating 
-- category plus show the average replacement cost in their rating category.
SELECT
title,
replacement_cost,
rating,
(SELECT AVG(replacement_cost) FROM film AS f2 WHERE f1.rating = f2.rating)
FROM film AS f1
WHERE replacement_cost = (SELECT MAX(replacement_cost) FROM film AS f3 WHERE f1.rating = f3.rating);

-- Show only those payments with the highest payment for each customer's first
-- name - including the payment_id of that payment.
SELECT first_name, amount, payment_id
FROM payment AS p1
INNER JOIN customer AS c
ON p1.customer_id = c.customer_id
WHERE amount = (SELECT MAX(amount) FROM payment AS p2 WHERE p1.customer_id = p2.customer_id);
-- How would you solve it if you would not need to see the payment_id?
SELECT first_name, MAX(amount)
FROM payment AS p1
INNER JOIN customer AS c
ON p1.customer_id = c.customer_id
GROUP BY first_name;


/********************************************************************************************/
/* COURSE PROJECT - CHALLENGES - 01 */
/********************************************************************************************/

/* Question 1:
Level: Simple
Topic: DISTINCT
Task: Create a list of all the different (distinct) replacement costs of the films.
Question: What's the lowest replacement cost?
Answer: 9.99 */
SELECT DISTINCT replacement_cost 
FROM film
ORDER BY 1;

/* Question 2:
Level: Moderate
Topic: CASE + GROUP BY
Task: Write a query that gives an overview of how many films have replacements costs in the following cost ranges
low: 9.99 - 19.99
medium: 20.00 - 24.99
high: 25.00 - 29.99
Question: How many films have a replacement cost in the "low" group?
Answer: 514 */
SELECT 
CASE 
WHEN replacement_cost BETWEEN 9.99 AND 19.99
THEN 'low'
WHEN replacement_cost BETWEEN 20 AND 24.99
THEN 'medium'
ELSE 'high'
END as cost_range,
COUNT(*)
FROM film
GROUP BY cost_range;

/* Question 3:
Level: Moderate
Topic: JOIN
Task: Create a list of the film titles including their title, length, and category name ordered descendingly by length. 
Filter the results to only the movies in the category 'Drama' or 'Sports'.
Question: In which category is the longest film and how long is it?
Answer: Sports and 184 */
SELECT 
title,
name,
length
FROM film f
LEFT JOIN film_category fc
ON f.film_id=fc.film_id
LEFT JOIN category c
ON c.category_id=fc.category_id
WHERE name = 'Sports' OR name = 'Drama'
ORDER BY length DESC;

/* Question 4:
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create an overview of how many movies (titles) there are in each category (name).
Question: Which category (name) is the most common among the films?
Answer: Sports with 74 titles */
SELECT
name,
COUNT(title)
FROM film f
INNER JOIN film_category fc
ON f.film_id=fc.film_id
INNER JOIN category c
ON c.category_id=fc.category_id
GROUP BY name
ORDER BY 2 DESC;

/* Question 5:
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create an overview of the actors' first and last names and in how many movies they appear in.
Question: Which actor is part of most movies??
Answer: Susan Davis with 54 movies */
SELECT 
first_name,
last_name,
COUNT(*)
FROM actor a
LEFT JOIN film_actor fa
ON fa.actor_id=a.actor_id
LEFT JOIN film f
ON fa.film_id=f.film_id
GROUP BY first_name, last_name
ORDER BY COUNT(*) DESC;

/* Question 6:
Level: Moderate
Topic: LEFT JOIN & FILTERING
Task: Create an overview of the addresses that are not associated to any customer.
Question: How many addresses are that?
Answer: 4 */
SELECT * FROM address a
LEFT JOIN customer c
ON c.address_id = a.address_id
WHERE c.first_name is null;

/* Question 7:
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create the overview of the sales  to determine the from which city (we are interested in the city in which the 
customer lives, not where the store is) most sales occur.
Question: What city is that and how much is the amount?
Answer: Cape Coral with a total amount of 221.55 */
SELECT 
city,
SUM(amount)
FROM payment p
LEFT JOIN customer c
ON p.customer_id=c.customer_id
LEFT JOIN address a
ON a.address_id=c.address_id
LEFT JOIN city ci
ON ci.city_id=a.city_id
GROUP BY city
ORDER BY city DESC;

/* Question 8:
Level: Moderate to difficult
Topic: JOIN & GROUP BY
Task: Create an overview of the revenue (sum of amount) grouped by a column in the format "country, city".
Question: Which country, city has the least sales?
Answer: United States, Tallahassee with a total amount of 50.85. */
SELECT 
country ||', ' ||city,
SUM(amount)
FROM payment p
LEFT JOIN customer c
ON p.customer_id=c.customer_id
LEFT JOIN address a
ON a.address_id=c.address_id
LEFT JOIN city ci
ON ci.city_id=a.city_id
LEFT JOIN country co
ON co.country_id=ci.country_id
GROUP BY country ||', ' ||city
ORDER BY 2 ASC;

/* Question 9:
Level: Difficult
Topic: Uncorrelated subquery
Task: Create a list with the average of the sales amount each staff_id has per customer.
Question: Which staff_id makes on average more revenue per customer?
Answer: staff_id 2 with an average revenue of 56.64 per customer. */
SELECT 
staff_id,
ROUND(AVG(total),2) as avg_amount 
FROM (
SELECT SUM(amount) as total,customer_id,staff_id
FROM payment
GROUP BY customer_id, staff_id) a
GROUP BY staff_id;

/* Question 10:
Level: Difficult to very difficult
Topic: EXTRACT + Uncorrelated subquery
Task: Create a query that shows average daily revenue of all Sundays.
Question: What is the daily average revenue of all Sundays?
Answer: 1410.65 */
SELECT 
AVG(total)
FROM 
	(SELECT
	 SUM(amount) as total,
	 DATE(payment_date),
	 EXTRACT(dow from payment_date) as weekday
	 FROM payment
	 WHERE EXTRACT(dow from payment_date)=0
	 GROUP BY DATE(payment_date),weekday) daily;

/* Question 11:
Level: Difficult to very difficult
Topic: Correlated subquery
Task: Create a list of movies - with their length and their replacement cost - that are longer than the average 
length in each replacement cost group.
Question: Which two movies are the shortest on that list and how long are they?
Answer: CELEBRITY HORN and SEATTLE EXPECTATIONS with 110 minutes. */
SELECT 
title,
length
FROM film f1
WHERE length > (SELECT AVG(length) FROM film f2
			   WHERE f1.replacement_cost=f2.replacement_cost)
ORDER BY length ASC;

/* Question 12:
Level: Very difficult
Topic: Uncorrelated subquery
Task: Create a list that shows the "average customer lifetime value" grouped by the different districts.
Example:
If there are two customers in "District 1" where one customer has a total (lifetime) spent of $1000 and the second 
customer has a total spent of $2000 then the "average customer lifetime spent" in this district is $1500.
So, first, you need to calculate the total per customer and then the average of these totals per district.
Question: Which district has the highest average customer lifetime value?
Answer: Saint-Denis with an average customer lifetime value of 216.54. */
SELECT
district,
ROUND(AVG(total),2) avg_customer_spent
FROM
(SELECT 
c.customer_id,
district,
SUM(amount) total
FROM payment p
INNER JOIN customer c
ON c.customer_id=p.customer_id
INNER JOIN address a
ON c.address_id=a.address_id
GROUP BY district, c.customer_id) sub
GROUP BY district
ORDER BY 2 DESC;

/* Question 13:
Level: Very difficult
Topic: Correlated query
Task: Create a list that shows all payments including the payment_id, amount, and the film category (name) plus the 
total amount that was made in this category. Order the results ascendingly by the category (name) and as second order 
criterion by the payment_id ascendingly.
Question: What is the total revenue of the category 'Action' and what is the lowest payment_id in that category 'Action'?
Answer: Total revenue in the category 'Action' is 4375.85 and the lowest payment_id in that category is 16055. */
SELECT
title,
amount,
name,
payment_id,
(SELECT SUM(amount) FROM payment p
LEFT JOIN rental r
ON r.rental_id=p.rental_id
LEFT JOIN inventory i
ON i.inventory_id=r.inventory_id
LEFT JOIN film f
ON f.film_id=i.film_id
LEFT JOIN film_category fc
ON fc.film_id=f.film_id
LEFT JOIN category c1
ON c1.category_id=fc.category_id
WHERE c1.name=c.name)
FROM payment p
LEFT JOIN rental r
ON r.rental_id=p.rental_id
LEFT JOIN inventory i
ON i.inventory_id=r.inventory_id
LEFT JOIN film f
ON f.film_id=i.film_id
LEFT JOIN film_category fc
ON fc.film_id=f.film_id
LEFT JOIN category c
ON c.category_id=fc.category_id
ORDER BY name;

/* Bonus question 14:
Level: Extremely difficult
Topic: Correlated and uncorrelated subqueries (nested)
Task: Create a list with the top overall revenue of a film title (sum of amount per title) for each category (name).
Question: Which is the top-performing film in the animation category?
Answer: DOGMA FAMILY with 178.70. */
SELECT
title,
name,
SUM(amount) as total
FROM payment p
LEFT JOIN rental r
ON r.rental_id=p.rental_id
LEFT JOIN inventory i
ON i.inventory_id=r.inventory_id
LEFT JOIN film f
ON f.film_id=i.film_id
LEFT JOIN film_category fc
ON fc.film_id=f.film_id
LEFT JOIN category c
ON c.category_id=fc.category_id
GROUP BY name,title
HAVING SUM(amount) =     (SELECT MAX(total)
			  FROM 
                                (SELECT
			          title,
                                  name,
			          SUM(amount) as total
			          FROM payment p
			          LEFT JOIN rental r
			          ON r.rental_id=p.rental_id
			          LEFT JOIN inventory i
			          ON i.inventory_id=r.inventory_id
				  LEFT JOIN film f
				  ON f.film_id=i.film_id
				  LEFT JOIN film_category fc
				  ON fc.film_id=f.film_id
				  LEFT JOIN category c1
				  ON c1.category_id=fc.category_id
				  GROUP BY name,title) sub
			   WHERE c.name=sub.name);


-- CREATE DATABASE
-- Comand to create a database

CREATE DATABASE company_x
	WITH encoding = 'UTF-8';

-- Comand to add a comment to a database
COMMENT ON DATABASE company_x IS 'That is our database'


-- CREATE TABLE
-- Command to create a table

CREATE TABLE director (
	director_id SERIAL PRIMARY KEY,
	director_account_name VARCHAR(20) UNIQUE,
	first_name VARCHAR(50),
	last_name VARCHAR(50) DEFAULT 'Not specified',
	date_of_birth DATE,
	address_id INT REFERENCES address(address_id)
);


-- CREATE TABLE - Challenge

CREATE TABLE online_sales (
	transaction_id SERIAL PRIMARY KEY,
	customer_id INT REFERENCES customer(customer_id),
	film_id INT REFERENCES film(film_id),
	amount numeric(5,2) NOT NULL,
	promotion_code VARCHAR(10) DEFAULT 'None'
);


-- INSERT
-- Command to insert data into a table

INSERT INTO online_sales (customer_id, film_id,amount,promotion_code)
VALUES 
(124,65,14.99,'PROMO2022'),
(225,231,12.99,'JULYPROMO'),
(119,53,15.99,'SUMMERDEAL');

SELECT * FROM online_sales


-- ALTER TABLE
-- Command to change the general settings of a table

ALTER TABLE director
ALTER COLUMN director_account_name TYPE VARCHAR(30),
ALTER COLUMN last_name DROP DEFAULT,
ALTER COLUMN last_name SET NOT NULL,
ADD COLUMN email VARCHAR(40)

ALTER TABLE director
RENAME director_account_name TO account_name

ALTER TABLE director
RENAME TO directors

SELECT * FROM directors


-- TRUNCATE & DROP TABLE

-- Creating an example table
CREATE TABLE emp_table(
	emp_id SERIAL PRIMARY KEY,
	emp_name TEXT
);
SELECT * FROM emp_table;

-- DROP TABLE = command to delete an entire table
DROP TABLE emp_table;

-- Insert rows
INSERT INTO emp_table
VALUES
	(1, 'Frank'),
	(2, 'Maria')
SELECT * FROM emp_table;

-- TRUNCATE = command to delete all rows from a table.
TRUNCATE TABLE emp_table


-- CHECK
-- Command to create a specific constraint to insert data into a column

CREATE TABLE songs(
	song_id SERIAL PRIMARY KEY,
	song_name VARCHAR(30) NOT NULL,
	genre VARCHAR(30) DEFAULT 'Not defined',
	price numeric(4,2) CHECK(price>=1.99),
	release_date DATE CONSTRAINT date_check CHECK(release_date BETWEEN '01-01-1950' AND CURRENT_DATE)
);

SELECT * FROM songs;

INSERT INTO songs (song_name, price, release_date)
VALUES ('SQL song', 0.99, '01-07-2022');

ALTER TABLE songs
DROP CONSTRAINT songs_price_check;

ALTER TABLE songs
ADD CONSTRAINT songs_price_check CHECK(price>=0.99);


-- UPDATE
-- UPDATE is used to change the values in a column or in a specifc row of a column

SELECT * FROM customer
ORDER BY customer_id ASC;

-- Updating the last_name column of customer_id=1 from SMITH to BROWN
UPDATE customer
SET last_name = 'BROWN'
WHERE customer_id = 1

-- Changing the format of email column to lower case
UPDATE customer
SET email = LOWER(email);


-- UPDATE - Challenges

-- Update all rental prices that are 0.99 to 1.99.
UPDATE film
SET rental_rate = 1.99
WHERE rental_rate = 0.99;

-- Add the column initials (data type varchar(4))
-- Update the values to the actual initials for example Frank Smith should be F.S.
ALTER TABLE customer
ADD COLUMN initials VARCHAR(4);
UPDATE customer
SET initials = LEFT(first_name, 1) || '.' || LEFT(last_name, 1) || '.';


-- DELETE
-- Used to delete rows from a table.

INSERT INTO songs(song_name, genre, price, release_date)
VALUES
('Have a talk with Data', 'Chill out', 5.99, '01-06-2022'),
('Tame the Date', 'Classical', 4.99, '01-06-2022')
SELECT * FROM songs;

-- Deleting rows from table songs using where condition.
DELETE FROM songs
WHERE genre = 'Classical';

-- The RETURNING clause can be used to gain access to rows that have been deleted.
DELETE FROM songs
WHERE genre = 'Classical'
RETURNING *;


-- DELETE - Challenge

-- Delete the rows in the payment table with payment_id 17064 and 17067
DELETE FROM payment
WHERE payment_id IN(17064, 17067);


-- CREATE TABLE AS
-- This join comand is used to create a table based on a query.

-- Creating a table customer_address with a query.
CREATE TABLE customer_address
AS 
SELECT first_name, last_name, email, address, city
FROM customer c
LEFT JOIN address a
ON c.address_id = a.address_id
LEFT JOIN city ci
ON ci.city_id = a.city_id;

SELECT * FROM customer_address;


-- CREATE TABLE AS - Challenge

-- Create the table customer_spendings with the first_name and the last_name of a 
-- customer, and then their total spendings that they have done in the payments table.
CREATE TABLE customer_spendings
AS
SELECT 
first_name || ' ' || last_name AS name,
SUM(amount) AS total_amount
FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY first_name || ' ' || last_name;

SELECT * FROM customer_spendings;


-- CREATE VIEW
-- Creates a virtual table whose contents (columns and rows) are defined by a query, 
-- but the content is not physically materialized and stored in the database.

DROP TABLE customer_spendings;

-- The main syntax is the same as CREATE TABLE AS.
CREATE VIEW customer_spendings
AS
SELECT 
first_name || ' ' || last_name AS name,
SUM(amount) AS total_amount
FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY first_name || ' ' || last_name;

SELECT * FROM customer_spendings;


-- CREATE VIEW - Challenge

/*
> Create a view called films_category that shows a list of the film titles including their title, 
length and category name ordered descendingly by the length.
> Filter the results to only the movies in the category 'Action' and 'Comedy'.
*/
CREATE VIEW films_category
AS
SELECT 
title,
name,
length
FROM film f
LEFT JOIN film_category fc
ON f.film_id=fc.film_id
LEFT JOIN category c
ON c.category_id=fc.category_id
WHERE name IN ('Action','Comedy')
ORDER BY length DESC;

SELECT * FROM films_category;


-- CREATE MATERIALIZED VIEW
-- The CREATE MATERIALIZED VIEW creates a materialized table (which helps performance considering complex queries), 
-- which can be refreshed using the REFRESH MATERIALIZED VIEW <view_name> command.
CREATE MATERIALIZED VIEW mv_film_category
AS
SELECT 
title,
name,
length
FROM film f
LEFT JOIN film_category fc
ON f.film_id=fc.film_id
LEFT JOIN category c
ON c.category_id=fc.category_id
WHERE name IN ('Action','Comedy')
ORDER BY length DESC;

SELECT * FROM mv_film_category;

UPDATE film
SET length = 192
WHERE title = 'SATURN NAME';

REFRESH MATERIALIZED VIEW mv_film_category;

SELECT * FROM mv_film_category;


-- MANAGING VIEWS
-- Table manegement commands can be used to manage views such as: 
-- ALTER VIEW, ALTER MATERIALIZED VIEW, DROP VIEW, DROP MATERIALIZED VIEW and CREATE OR REPLACE VIEW

DROP VIEW customer_anonymous;

ALTER VIEW customer_anonymous
RENAME TO v_customer_info;

ALTER VIEW v_customer_info
RENAME COLUMN name TO customer_name;

CREATE OR REPLACE VIEW v_customer_info
AS new_query


-- MANAGING VIEWS - Challenge

-- In this challenge, we use the view v_customer_info below:
CREATE VIEW v_customer_info
AS
SELECT cu.customer_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country
     FROM customer cu
     JOIN address a ON cu.address_id = a.address_id
     JOIN city ON a.city_id = city.city_id
     JOIN country ON city.country_id = country.country_id
ORDER BY customer_id;
SELECT * FROM v_customer_info;

-- You need to perform the following tasks:

-- 1) Rename the view to v_customer_information.
ALTER VIEW v_customer_info
RENAME TO v_customer_information;
SELECT * FROM v_customer_information;

-- 2) Rename the customer_id column to c_id.
ALTER VIEW v_customer_information
RENAME COLUMN customer_id TO c_id;
SELECT * FROM v_customer_information;

-- 3) Add also the initial column as the last column to the view by replacing the view.
CREATE OR REPLACE VIEW v_customer_information
AS
SELECT 
    cu.customer_id as c_id,
    cu.first_name || ' ' || cu.last_name AS name,
    a.address,
    a.postal_code,
    a.phone,
    city.city,
    country.country,
    CONCAT(LEFT(cu.first_name,1),LEFT(cu.last_name,1)) as initials
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ON a.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
ORDER BY c_id;
SELECT * FROM v_customer_information;


-- IMPORT & EXPORT

-- Creating the empty sales table to import data from csv file.
CREATE TABLE sales (
	transaction_id SERIAL PRIMARY KEY,
	customer_id INT,
	payment_type VARCHAR(20),
	creditcard_no VARCHAR(20),
	cost DECIMAL(5,2),
	quantity INT,
	price DECIMAL(5,2)
);
-- Checking the result
SELECT * FROM sales;

/*
To IMPORT/EXPORT data into/from a table on pgAdmin:
Click with the mouse right botom to access the Import/Export Data window.
After configuring specific settings, the csv file can be imported or exported from the program.
*/


-- OVER() with PARTITION BY
/*
> OVER clause is used with functions to compute aggregated values over a group of rows, referred 
to as a window. This clause gives you control over where the window starts and ends for each row 
in the result set.
> Compered to GROUP BY, OVER clause is more efficient in terms of performance in deep queries.
*/

-- Creating a new column at payment table view, with the sum amount per customer_id.
SELECT 
*,
SUM(amount) OVER(PARTITION BY customer_id)
FROM payment;

-- OVER(PARTITION BY) + ORDER BY
SELECT 
*,
SUM(amount) OVER(PARTITION BY customer_id)
FROM payment
ORDER BY customer_id;

-- OVER(PARTITION BY) + COUNT()
SELECT 
*,
COUNT(*) OVER(PARTITION BY customer_id)
FROM payment
ORDER BY customer_id;

-- OVER clause can be used with more columns in your PARTITION BY clause.
SELECT 
*,
COUNT(*) OVER(PARTITION BY customer_id, staff_id)
FROM payment
ORDER BY customer_id, staff_id;

-- OVER(PARTITION BY) + AVG
SELECT 
*,
AVG(amount) OVER(PARTITION BY customer_id)
FROM payment
ORDER BY customer_id;

-- OVER(PARTITION BY) + ROUND
SELECT 
*,
ROUND(AVG(amount) OVER(PARTITION BY customer_id),2)
FROM payment
ORDER BY customer_id;


-- OVER() with PARTITION BY - Challenges

/*
Write a query that returns the list of movies including
- film_id,
- title,
- length,
- category,
- average length of movies in that category.
Order the results by film_id.
*/
SELECT
f.film_id,
title,
name AS category,
length AS length_of_movie,
ROUND(AVG(length) OVER(PARTITION BY name), 2) AS avg_length_in_category
FROM film f
LEFT JOIN film_category fc
ON f.film_id = fc.film_id
LEFT JOIN category c
ON fc.category_id = c.category_id
ORDER BY 1;

/*
Write a query that returns all payment details including
- the number of payments that were made by this customer
and that amount
Order the results by payment_id.
*/
SELECT
*,
COUNT(*) OVER(PARTITION BY amount, customer_id)
FROM payment
ORDER BY customer_id, amount;


-- OVER() with ORDER BY
/*
> Establish an order for framing or ranking and navigational window functions.
> Using the SUM function, the column result will be the accumulated sum
per row, ordered by the ORDER BY clause.
*/

SELECT 
*,
SUM(amount) OVER(ORDER BY payment_date)
FROM payment;

-- Combining PARTITION BY and ORDER BY.
SELECT 
*,
SUM(amount) OVER(PARTITION BY customer_id 
				 ORDER BY payment_date)
FROM payment;

-- ORDER BY with multiple columns.
SELECT 
*,
SUM(amount) OVER(PARTITION BY customer_id 
				 ORDER BY payment_date, payment_id)
FROM payment;

-- Specifying the ordering definition.
SELECT 
*,
SUM(amount) OVER(PARTITION BY customer_id 
			 
				 ORDER BY payment_date ASC, payment_id)
FROM payment;


/****************************/
/* USING DB02 - demo */
/****************************/

-- OVER() with ORDER BY - Challenges

/*
Write a query that returns the running total of how late the flights are
(difference between actual_arrival and scheduled arrival) ordered by flight_id
including the departure airport.
*/
SELECT
flight_id,
departure_airport,
SUM(actual_arrival-scheduled_arrival) OVER(ORDER BY flight_id)
FROM flights;

/*
As a second query, calculate the same running total but partition also by the
departure airport.
*/
SELECT
flight_id,
departure_airport,
SUM(actual_arrival-scheduled_arrival) OVER(PARTITION BY departure_airport
										   ORDER BY flight_id)
FROM flights;


/****************************/
/* USING DB01 - greencycles */
/****************************/

-- RANK() + OVER()
-- Provides the sort position bases on the specified column entered in the ORDER BY clause.

SELECT
f.title,
c.name,
f.length,
RANK() OVER(ORDER BY length DESC)
FROM film f
LEFT JOIN film_category fc
ON f.film_id = fc.film_id
LEFT JOIN category c
ON c.category_id = fc.category_id;

-- DENSE_RANK() again gives you the ranking within your ordered partition, 
-- but the ranks are consecutive. No ranks are skipped if there are ranks with multiple items.
SELECT
f.title,
c.name,
f.length,
DENSE_RANK() OVER(ORDER BY length)
FROM film f
LEFT JOIN film_category fc
ON f.film_id = fc.film_id
LEFT JOIN category c
ON c.category_id = fc.category_id;

SELECT
f.title,
c.name,
f.length,
DENSE_RANK() OVER(PARTITION BY name
				  ORDER BY length)
FROM film f
LEFT JOIN film_category fc
ON f.film_id = fc.film_id
LEFT JOIN category c
ON c.category_id = fc.category_id;

-- To use OVER as a filter, the query where it is inserted needs to be positioned in a subquery.
SELECT * FROM
(SELECT
f.title,
c.name,
f.length,
DENSE_RANK() OVER(PARTITION BY name
				  ORDER BY length) AS rank
FROM film f
LEFT JOIN film_category fc
ON f.film_id = fc.film_id
LEFT JOIN category c
ON c.category_id = fc.category_id) a
WHERE rank = 1;


-- RANK() + OVER() - Challenge

/*
Write a query that returns the customers' name, the country and how many
payments they have. For that use the existing view customer_list.
Result
Afterwards create a ranking of the top customers with most sales for each
country. Filter the results to only the top 3 customers per country.
*/
SELECT * FROM
(SELECT
name,
country,
COUNT(*),
RANK() OVER(PARTITION BY country
			ORDER BY COUNT(*) DESC) AS rank
FROM customer_list
LEFT JOIN payment
ON id = customer_id
GROUP BY name, country) a
WHERE rank IN (1,2,3);


-- FIRST_VALUE() + OVER()
-- The function returns first value considering the partition created by OVER command.

-- Creating a column with the first value of the column name considering the OVER command.
SELECT
name,
country,
COUNT(*),
FIRST_VALUE(name) OVER(PARTITION BY country
			ORDER BY COUNT(*) DESC) AS rank
FROM customer_list
LEFT JOIN payment
ON id = customer_id
GROUP BY name, country;

SELECT
name,
country,
COUNT(*),
FIRST_VALUE(COUNT(*)) OVER(PARTITION BY country
			ORDER BY COUNT(*) DESC) AS rank
FROM customer_list
LEFT JOIN payment
ON id = customer_id
GROUP BY name, country;

-- Using FIRST_VALUE with complex query.
SELECT
name,
country,
COUNT(*),
FIRST_VALUE(COUNT(*)) OVER(PARTITION BY country
			ORDER BY COUNT(*) ASC) AS rank,
COUNT(*) - FIRST_VALUE(COUNT(*)) OVER(PARTITION BY country
			ORDER BY COUNT(*) ASC)
FROM customer_list
LEFT JOIN payment
ON id = customer_id
GROUP BY name, country;


-- LEAD() & LAG() + OVER()
-- LEAD: returns the next value in our partition.
-- LAD: returns the before value in our partition.

SELECT
name,
country,
COUNT(*),
LEAD(name) OVER(PARTITION BY country
			ORDER BY COUNT(*) ASC) AS rank
FROM customer_list
LEFT JOIN payment
ON id = customer_id
GROUP BY name, country;

-- Using LEAD to access the difference between the previous value.
SELECT
name,
country,
COUNT(*),
LEAD(COUNT(*)) OVER(PARTITION BY country
			ORDER BY COUNT(*) ASC) AS rank,
LEAD(COUNT(*)) OVER(PARTITION BY country
			ORDER BY COUNT(*) ASC) - COUNT(*)
FROM customer_list
LEFT JOIN payment
ON id = customer_id
GROUP BY name, country;

-- Using LAG to access the difference between the before value.
SELECT
name,
country,
COUNT(*),
LAG(COUNT(*)) OVER(PARTITION BY country
			ORDER BY COUNT(*) ASC) AS rank,
LAG(COUNT(*)) OVER(PARTITION BY country
			ORDER BY COUNT(*) ASC) - COUNT(*)
FROM customer_list
LEFT JOIN payment
ON id = customer_id
GROUP BY name, country;


-- LEAD() & LAG() + OVER() - Challenge

/*
Write a query that returns the revenue of the day and the revenue of the
previous day.
Afterwards calculate also the percentage growth compared to the previous
day.
*/
SELECT 
SUM(amount),
DATE(payment_date) AS day,
LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)) AS previous_day,
SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)) AS difference,
ROUND((SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)))
/
LAG(SUM(amount)) OVER(ORDER BY DATE(payment_date)) * 100, 2) AS percentage_growth
FROM payment
GROUP BY DATE(payment_date);


-- GROUPING SETS
-- GROUPING SETS specifies multiple groupings of data in one query. Only the specified groups 
-- are aggregated, instead of the full set of aggregations that are generated by CUBE or ROLLUP .

SELECT
TO_CHAR(payment_date, 'Month') AS month,
staff_id,
SUM(amount)
FROM payment
GROUP BY
	GROUPING SETS(
		(staff_id),
		(month),
		(staff_id, month)
	)
ORDER BY 1, 2;


-- GROUPING SETS - Challenges

-- Write a query that return the sum of the amount for each customer (fist name and last name) 
-- and each staff_id. Also add the overall revenue per customer.
SELECT
first_name,
last_name,
staff_id,
SUM(amount)
FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY 
	GROUPING SETS(
		(first_name, last_name),
		(first_name, last_name, staff_id)
	);

-- Write a query that calculates now the share of revenue each staff_id makes per customer.
SELECT
first_name,
last_name,
staff_id,
SUM(amount) AS total,
ROUND(100 * SUM(amount) / FIRST_VALUE(SUM(amount)) OVER(PARTITION BY first_name, last_name
							 ORDER BY SUM(amount) DESC), 2 ) AS percentage
FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY 
	GROUPING SETS(
		(first_name, last_name),
		(first_name, last_name, staff_id)
	);


-- ROLLUP
/*
> The ROLLUP option allows you to include extra rows that represent the subtotals, 
which are commonly referred to as super-aggregate rows, along with the grand total row. 
> By using the ROLLUP option, you can use a single query to generate multiple grouping sets.
*/

SELECT
'Q' || TO_CHAR(payment_date, 'Q') AS quarter,
EXTRACT(month FROM payment_date) AS month,
DATE(payment_date),
SUM(amount)
FROM payment
GROUP BY
	ROLLUP(
		'Q' || TO_CHAR(payment_date, 'Q'),
		EXTRACT(month FROM payment_date),
		DATE(payment_date)
	)
ORDER BY 1, 2, 3;


/****************************/
/* USING DB02 - demo        */
/****************************/

-- ROLLUP - Challenge

-- Write a query that calculates a booking amount rollup for the hierarchy 
-- of quarter, month, week in month and day.
SELECT
EXTRACT(quarter FROM book_date) AS quarter,
EXTRACT(month FROM book_date) AS month,
TO_CHAR(book_date, 'w') AS week_in_month,
DATE(book_date),
SUM(total_amount)
FROM bookings
GROUP BY
	ROLLUP(
		EXTRACT(quarter FROM book_date),
		EXTRACT(month FROM book_date),
		TO_CHAR(book_date, 'w'),
		DATE(book_date)
	)
ORDER BY 1, 2, 3, 4;


/****************************/
/* USING DB01 - greencycles */
/****************************/

-- CUBE
-- CUBE is metadata which is used to group data along more than one column, creating views with subtotals.

SELECT
customer_id,
staff_id,
DATE(payment_date),
SUM(amount)
FROM payment
GROUP BY
	CUBE(
		customer_id,
		staff_id,
		DATE(payment_date)
	)
ORDER BY 1, 2, 3;


-- CUBE - Challenge

/*
Write a query that returns all grouping sets in all combinations of customer_id, date and 
title with the aggregation of the payment amount.
*/
SELECT 
p.customer_id,
DATE(payment_date),
title,
SUM(amount) as total
FROM payment p
LEFT JOIN rental r
ON r.rental_id=p.rental_id
LEFT JOIN inventory i
ON i.inventory_id=r.inventory_id
LEFT JOIN film f
ON f.film_id=i.film_id
GROUP BY 
CUBE(
p.customer_id,
DATE(payment_date),
title
)
ORDER BY 1,2,3;


-- SELF-JOIN
/*
Self-Join is a type of join, which is performed in cases where the comparison between two columns 
of a same table is required; probably to establish a relationship between them. In other words, a 
table is joined with itself when it contains both Foreign Key and Primary Key in it.
*/

CREATE TABLE employee (
	employee_id INT,
	name VARCHAR (50),
	manager_id INT
);

INSERT INTO employee 
VALUES
	(1, 'Liam Smith', NULL),
	(2, 'Oliver Brown', 1),
	(3, 'Elijah Jones', 1),
	(4, 'William Miller', 1),
	(5, 'James Davis', 2),
	(6, 'Olivia Hernandez', 2),
	(7, 'Emma Lopez', 2),
	(8, 'Sophia Andersen', 2),
	(9, 'Mia Lee', 3),
	(10, 'Ava Robinson', 3);

SELECT * FROM employee;

-- SELF-JOIN Example 01
SELECT
emp.employee_id,
emp.name AS employee,
mng.name AS manager
FROM employee emp
LEFT JOIN employee mng
ON emp.manager_id = mng.employee_id

-- SELF-JOIN Example 01
SELECT
emp.employee_id,
emp.name AS employee,
mng.name AS manager,
mng2.name AS manager_of_manager
FROM employee emp
LEFT JOIN employee mng
ON emp.manager_id = mng.employee_id
LEFT JOIN employee mng2
ON mng.manager_id = mng2.employee_id;


-- SELF-JOIN - Challenge

-- Find all the pairs of films with the same length.
SELECT
f1.title,
f2.title,
f2.length
FROM film f1
LEFT JOIN film f2
ON f1.length = f2.length
WHERE
f1.title <> f2.title
ORDER BY length DESC;


-- CROSS JOIN
/*
used to combine each row of one table with each row of another table, and return 
the Cartesian product of the sets of rows from the tables that are joined.
*/

SELECT
staff_id,
store.store_id,
last_name,
store.store_id * staff_id
FROM staff
CROSS JOIN store;


-- NATURAL JOIN
/*
Combines rows from two or more tables based on the common column(s) between them. 
The common columns on which the tables are joined must have the same name and data 
type across the tables.
*/

SELECT
*
FROM payment
NATURAL INNER JOIN customer;

SELECT
first_name,
last_name,
SUM(amount)
FROM payment
NATURAL INNER JOIN customer
GROUP BY first_name, last_name;


/********************************************************************************************/
/* COURSE PROJECT - CHALLENGES - 02 */
/********************************************************************************************/

/* Task 1.1
In your company there hasn't been a database table with all the employee information yet.
You need to set up the table called employees in the following way:
There should be NOT NULL constraints for the following columns:
first_name,
last_name ,
job_position,
start_date DATE,
birth_date DATE*/
CREATE TABLE employees (
emp_id SERIAL PRIMARY KEY,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
job_position TEXT NOT NULL,
salary decimal(8,2),
start_date DATE NOT NULL,
birth_date DATE NOT NULL,
store_id INT REFERENCES store(store_id),
department_id INT,
manager_id INT
);

/* Task 1.2
Set up an additional table called departments in the following way:
Additionally no column should allow nulls.
department_id,
department,
division*/
CREATE TABLE departments (
department_id SERIAL PRIMARY KEY,
department TEXT NOT NULL,
division TEXT NOT NULL);

/* Task 2
Alter the employees table in the following way:
- Set the column department_id to not null.
- Add a default value of CURRENT_DATE to the column start_date.
- Add the column end_date with an appropriate data type (one that you think makes sense).
- Add a constraint called birth_check that doesn't allow birth dates that are in the future.
- Rename the column job_position to position_title.*/
ALTER TABLE employees 
ALTER COLUMN department_id SET NOT NULL,
ALTER COLUMN start_date SET DEFAULT CURRENT_DATE,
ADD COLUMN end_date DATE,
ADD CONSTRAINT birth_check CHECK(birth_date < CURRENT_DATE);
ALTER TABLE employees
RENAME job_position TO position_title;

/* Task 3.1
Insert the following values into the employees table.
There will be most likely an error when you try to insert the values.
So, try to insert the values and then fix the error.
Columns:
(emp_id,first_name,last_name,position_title,salary,start_date,birth_date,store_id,department_id,manager_id,end_date)
Values:
(1,'Morrie','Conaboy','CTO',21268.94,'2005-04-30','1983-07-10',1,1,NULL,NULL),
(2,'Miller','McQuarter','Head of BI',14614.00,'2019-07-23','1978-11-09',1,1,1,NULL),
(3,'Christalle','McKenny','Head of Sales',12587.00,'1999-02-05','1973-01-09',2,3,1,NULL),
(4,'Sumner','Seares','SQL Analyst',9515.00,'2006-05-31','1976-08-03',2,1,6,NULL),
(5,'Romain','Hacard','BI Consultant',7107.00,'2012-09-24','1984-07-14',1,1,6,NULL),
(6,'Ely','Luscombe','Team Lead Analytics',12564.00,'2002-06-12','1974-08-01',1,1,2,NULL),
(7,'Clywd','Filyashin','Senior SQL Analyst',10510.00,'2010-04-05','1989-07-23',2,1,2,NULL),
(8,'Christopher','Blague','SQL Analyst',9428.00,'2007-09-30','1990-12-07',2,2,6,NULL),
(9,'Roddie','Izen','Software Engineer',4937.00,'2019-03-22','2008-08-30',1,4,6,NULL),
(10,'Ammamaria','Izhak','Customer Support',2355.00,'2005-03-17','1974-07-27',2,5,3,2013-04-14),
(11,'Carlyn','Stripp','Customer Support',3060.00,'2013-09-06','1981-09-05',1,5,3,NULL),
(12,'Reuben','McRorie','Software Engineer',7119.00,'1995-12-31','1958-08-15',1,5,6,NULL),
(13,'Gates','Raison','Marketing Specialist',3910.00,'2013-07-18','1986-06-24',1,3,3,NULL),
(14,'Jordanna','Raitt','Marketing Specialist',5844.00,'2011-10-23','1993-03-16',2,3,3,NULL),
(15,'Guendolen','Motton','BI Consultant',8330.00,'2011-01-10','1980-10-22',2,3,6,NULL),
(16,'Doria','Turbat','Senior SQL Analyst',9278.00,'2010-08-15','1983-01-11',1,1,6,NULL),
(17,'Cort','Bewlie','Project Manager',5463.00,'2013-05-26','1986-10-05',1,5,3,NULL),
(18,'Margarita','Eaden','SQL Analyst',5977.00,'2014-09-24','1978-10-08',2,1,6,2020-03-16),
(19,'Hetty','Kingaby','SQL Analyst',7541.00,'2009-08-17','1999-04-25',1,2,6,'NULL'),
(20,'Lief','Robardley','SQL Analyst',8981.00,'2002-10-23','1971-01-25',2,3,6,2016-07-01),
(21,'Zaneta','Carlozzi','Working Student',1525.00,'2006-08-29','1995-04-16',1,3,6,2012-02-19),
(22,'Giana','Matz','Working Student',1036.00,'2016-03-18','1987-09-25',1,3,6,NULL),
(23,'Hamil','Evershed','Web Developper',3088.00,'2022-02-03','2012-03-30',1,4,2,NULL),
(24,'Lowe','Diamant','Web Developper',6418.00,'2018-12-31','2002-09-07',1,4,2,NULL),
(25,'Jack','Franklin','SQL Analyst',6771.00,'2013-05-18','2005-10-04',1,2,2,NULL),
(26,'Jessica','Brown','SQL Analyst',8566.00,'2003-10-23','1965-01-29',1,1,2,NULL)*/
INSERT INTO employees 
VALUES
(1,'Morrie','Conaboy','CTO',21268.94,'2005-04-30','1983-07-10',1,1,NULL,NULL),
(2,'Miller','McQuarter','Head of BI',14614.00,'2019-07-23','1978-11-09',1,1,1,NULL),
(3,'Christalle','McKenny','Head of Sales',12587.00,'1999-02-05','1973-01-09',2,3,1,NULL),
(4,'Sumner','Seares','SQL Analyst',9515.00,'2006-05-31','1976-08-03',2,1,6,NULL),
(5,'Romain','Hacard','BI Consultant',7107.00,'2012-09-24','1984-07-14',1,1,6,NULL),
(6,'Ely','Luscombe','Team Lead Analytics',12564.00,'2002-06-12','1974-08-01',1,1,2,NULL),
(7,'Clywd','Filyashin','Senior SQL Analyst',10510.00,'2010-04-05','1989-07-23',2,1,2,NULL),
(8,'Christopher','Blague','SQL Analyst',9428.00,'2007-09-30','1990-12-07',2,2,6,NULL),
(9,'Roddie','Izen','Software Engineer',4937.00,'2019-03-22','2008-08-30',1,4,6,NULL),
(10,'Ammamaria','Izhak','Customer Support',2355.00,'2005-03-17','1974-07-27',2,5,3,'2013-04-14'),
(11,'Carlyn','Stripp','Customer Support',3060.00,'2013-09-06','1981-09-05',1,5,3,NULL),
(12,'Reuben','McRorie','Software Engineer',7119.00,'1995-12-31','1958-08-15',1,5,6,NULL),
(13,'Gates','Raison','Marketing Specialist',3910.00,'2013-07-18','1986-06-24',1,3,3,NULL),
(14,'Jordanna','Raitt','Marketing Specialist',5844.00,'2011-10-23','1993-03-16',2,3,3,NULL),
(15,'Guendolen','Motton','BI Consultant',8330.00,'2011-01-10','1980-10-22',2,3,6,NULL),
(16,'Doria','Turbat','Senior SQL Analyst',9278.00,'2010-08-15','1983-01-11',1,1,6,NULL),
(17,'Cort','Bewlie','Project Manager',5463.00,'2013-05-26','1986-10-05',1,5,3,NULL),
(18,'Margarita','Eaden','SQL Analyst',5977.00,'2014-09-24','1978-10-08',2,1,6,'2020-03-16'),
(19,'Hetty','Kingaby','SQL Analyst',7541.00,'2009-08-17','1999-04-25',1,2,6,NULL),
(20,'Lief','Robardley','SQL Analyst',8981.00,'2002-10-23','1971-01-25',2,3,6,'2016-07-01'),
(21,'Zaneta','Carlozzi','Working Student',1525.00,'2006-08-29','1995-04-16',1,3,6,'2012-02-19'),
(22,'Giana','Matz','Working Student',1036.00,'2016-03-18','1987-09-25',1,3,6,NULL),
(23,'Hamil','Evershed','Web Developper',3088.00,'2022-02-03','2012-03-30',1,4,2,NULL),
(24,'Lowe','Diamant','Web Developper',6418.00,'2018-12-31','2002-09-07',1,4,2,NULL),
(25,'Jack','Franklin','SQL Analyst',6771.00,'2013-05-18','2005-10-04',1,2,2,NULL),
(26,'Jessica','Brown','SQL Analyst',8566.00,'2003-10-23','1965-01-29',1,1,2,NULL);

/* Task 3.2
Insert the following values into the departments table.
Columns:
(department_id, department, division)
Values:
(1, Analytics, IT),
(2, Finance, Administration),
(3, Sales, Sales),
(4, Website, IT),
(5, Back Office, Administration)*/
INSERT INTO departments
VALUES (1, 'Analytics','IT'),
(2, 'Finance','Administration'),
(3, 'Sales','Sales'),
(4, 'Website','IT'),
(5, 'Back Office','Administration');

/* Task 4.1
Jack Franklin gets promoted to 'Senior SQL Analyst' and the salary raises to 7200.
Update the values accordingly.*/
UPDATE employees
SET position_title = 'Senior SQL Analyst'
WHERE emp_id=25;
UPDATE employees
SET salary=7200
WHERE emp_id=25;

/* Task 4.2
The responsible people decided to rename the position_title Customer Support to Customer Specialist.
Update the values accordingly.*/
UPDATE employees
SET position_title='Customer Specialist'
WHERE position_title='Customer Support';

/* Task 4.3
All SQL Analysts including Senior SQL Analysts get a raise of 6%.
Upate the salaries accordingly.*/
UPDATE employees
SET salary=salary*1.06
WHERE position_title LIKE '%SQL Analyst';

/* Task 4.4
Question: What is the average salary of a SQL Analyst in the company (excluding Senior SQL Analyst)?*/
SELECT ROUND(AVG(salary),2) FROM employees
WHERE position_title='SQL Analyst';

/* Task 5.1
Write a query that adds a column called manager that contains  first_name and last_name (in one column) in the data output.
Secondly, add a column called is_active with 'false' if the employee has left the company already, otherwise the value is 'true'.*/
SELECT 
emp.*,
CASE WHEN emp.end_date IS NULL THEN 'true'
ELSE 'false' 
END as is_active,
mng.first_name ||' '|| mng.last_name AS manager_name
FROM employees emp
LEFT JOIN employees mng
ON emp.manager_id=mng.emp_id;

/* Task 5.2
Create a view called v_employees_info from that previous query.*/
CREATE VIEW v_employees_info
AS
SELECT 
emp.*,
CASE WHEN emp.end_date IS NULL THEN 'true'
ELSE 'false' 
END as is_active,
mng.first_name ||' '|| mng.last_name AS manager_name
FROM employees emp
LEFT JOIN employees mng
ON emp.manager_id=mng.emp_id;

/* Task 6
Write a query that returns the average salaries for each positions with appropriate roundings.
Question: What is the average salary for a Software Engineer in the company.*/
SELECT 
position_title,
ROUND(AVG(salary),2)
FROM v_employees_info
GROUP BY position_title
ORDER BY 2;

/* Task 7
Write a query that returns the average salaries per division.
Question: What is the average salary in the Sales department?*/
SELECT 
division,
ROUND(AVG(salary),2)
FROM employees e
LEFT JOIN departments d 
ON e.department_id=d.department_id
GROUP BY division
ORDER BY 2;

/* Task 8.1
Write a query that returns the following:
emp_id,
first_name,
last_name,
position_title,
salary
and a column that returns the average salary for every job_position.
Order the results by the emp_id.*/
SELECT
emp_id,
first_name,
last_name,
position_title,
salary,
ROUND(AVG(salary) OVER(PARTITION BY position_title),2) as avg_position_sal
FROM employees
ORDER BY 1;

/* Task 8.2
How many people earn less than there avg_position_salary?
Write a query that answers that question.
Ideally, the output just shows that number directly.*/
SELECT
COUNT(*)
FROM (
SELECT 
emp_id,
salary,
ROUND(AVG(salary) OVER(PARTITION BY position_title),2) as avg_pos_sal
FROM employees) a
WHERE salary<avg_pos_sal;

/* Task 9:
Write a query that returns a running total of the salary development ordered by the start_date.
In your calculation, you can assume their salary has not changed over time, and you can disregard the fact that people have left the company (write the query as if they were still working for the company).
Question: What was the total salary after 2018-12-31?*/
SELECT 
emp_id,
salary,
start_date,
SUM(salary) OVER(ORDER BY start_date) as salary_totals
FROM employees;

/* Task 10:
Create the same running total but now also consider the fact that people were leaving the company.
Note: This challenge is actually very difficult.
Don't worry if you can't solve it you are not expected to do so.
It is possible to solve the challenge even without the hints.
If you want you can try to solve it using the hints and it is still a difficult challenge.
Question: What was the total salary after 2018-12-31?
Hint 1: Use the view v_employees_info.
Hint 2: Create two separate queries: one with all employees and one with the people that have already left
Hint 3: In the first query use start_date and in the second query use end_date instead of the start_date
Hint 4: Multiply the salary of the second query with (-1).
Hint 5: Create a subquery from that UNION and use a window function in that to create the running total.*/
SELECT 
start_date,
SUM(salary) OVER(ORDER BY start_date)
FROM (
SELECT 
emp_id,
salary,
start_date
FROM employees
UNION 
SELECT 
emp_id,
-salary,
end_date
FROM v_employees_info
WHERE is_active ='false'
ORDER BY start_date) a;

/* Task 11.1
Write a query that outputs only the top earner per position_title including first_name and position_title and their salary.
Question: What is the top earner with the position_title SQL Analyst?*/
SELECT
first_name,
position_title,
salary
FROM employees e1
WHERE salary = (SELECT MAX(salary)
			   FROM employees e2
			   WHERE e1.position_title=e2.position_title);

/* Task 11.2
Add also the average salary per position_title.*/
SELECT
first_name,
position_title,
salary,
(SELECT ROUND(AVG(salary),2) as avg_in_pos FROM employees e3
WHERE e1.position_title=e3.position_title)
FROM employees e1
WHERE salary = (SELECT MAX(salary)
			   FROM employees e2
			   WHERE e1.position_title=e2.position_title);

/* Task 11.3
Remove those employees from the output of the previous query that has the same salary as the average of their position_title.
These are the people that are the only ones with their position_title.*/
SELECT
first_name,
position_title,
salary,
(SELECT ROUND(AVG(salary),2) as avg_in_pos FROM employees e3
WHERE e1.position_title=e3.position_title)
FROM employees e1
WHERE salary = (SELECT MAX(salary)
			   FROM employees e2
			   WHERE e1.position_title=e2.position_title)
AND salary<>(SELECT ROUND(AVG(salary),2) as avg_in_pos FROM employees e3
WHERE e1.position_title=e3.position_title);

/* Task 12
Write a query that returns all meaningful aggregations of
- sum of salary,
- number of employees,
- average salary
grouped by all meaningful combinations of
- division,
- department,
- position_title.
Consider the levels of hierarchies in a meaningful way.*/
SELECT 
division,
department,
position_title,
SUM(salary),
COUNT(*),
ROUND(AVG(salary),2)
FROM employees
NATURAL JOIN departments
GROUP BY 
ROLLUP(
division,
department,
position_title
)
ORDER BY 1,2,3;

/* Task 13
Write a query that returns all employees (emp_id) including their position_title, department, their salary, and the rank of that salary partitioned by department.
The highest salary per division should have rank 1.
Question: Which employee (emp_id) is in rank 7 in the department Analytics?*/
SELECT
emp_id,
position_title,
department,
salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees
NATURAL LEFT JOIN departments;

/* Task 14
Write a query that returns only the top earner of each department including
their emp_id, position_title, department, and their salary.
Question: Which employee (emp_id) is the top earner in the department Finance?*/
SELECT * FROM
(
SELECT
emp_id,
position_title,
department,
salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC)
FROM employees
NATURAL LEFT JOIN departments) a
WHERE rank=1;


-- USER-DEFINED FUNCTIONS
-- With the CREATE FUNCTION command it is possible to create a specifc function created by the user.

-- Example of a function that counts the number of movies that have rental rates between 2 variable values.
CREATE FUNCTION count_rr (min_r decimal(4,2), max_r decimal(4,2))
RETURNS INT
LANGUAGE plpgsql
AS
$$
DECLARE
movie_count INT;
BEGIN
SELECT COUNT(*)
INTO movie_count
FROM film
WHERE rental_rate BETWEEN min_r AND max_r;
RETURN movie_count;
END;
$$

-- Evaluating the count_rr fuction
SELECT count_rr(0, 6);

-- Evaluating the count_rr fuction
SELECT count_rr(3, 6);


-- USER-DEFINED FUNCTIONS - Challenge
-- Create a function that expects the customer's first and last name
-- and returns the total amount of payments this customer has made.
CREATE FUNCTION name_search (f_name VARCHAR(20), l_name VARCHAR(20))
RETURNS decimal(6,2)
LANGUAGE plpgsql
AS
$$
DECLARE
total decimal(6,2);
BEGIN
SELECT SUM(amount)
INTO total
FROM payment
NATURAL LEFT JOIN customer
WHERE first_name = f_name
AND
last_name = l_name;
RETURN total;
END;
$$

-- Evaluating the name_search fuction
SELECT name_search('AMY', 'LOPEZ');

-- Using the name_search fuction into a multiple columns SELECT.
SELECT
first_name,
last_name,
name_search(first_name, last_name)
FROM customer;


-- TRANSACTIONS
-- TRANSACTIONS is use to form units of work that belong together and 
-- that should only be committed after we decide to commit then.

CREATE TABLE acc_balance (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
    amount DEC(9,2) NOT NULL    
);

INSERT INTO acc_balance
VALUES 
(1,'Tim','Brown',2500),
(2,'Sandra','Miller',1600)

SELECT * FROM acc_balance;

-- TRANSACTION example
BEGIN;
UPDATE acc_balance
SET amount = amount - 100
WHERE  id = 1;
UPDATE acc_balance
SET amount = amount + 100
WHERE id = 2;
COMMIT;

SELECT * FROM acc_balance;


-- TRANSACTIONS - Challenge

DROP TABLE employees CASCADE;

CREATE TABLE employees (
emp_id SERIAL PRIMARY KEY,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
job_position TEXT NOT NULL,
salary decimal(8,2),
start_date DATE NOT NULL,
birth_date DATE NOT NULL,
store_id INT REFERENCES store(store_id),
department_id INT,
manager_id INT
);

ALTER TABLE employees 
ALTER COLUMN department_id SET NOT NULL,
ALTER COLUMN start_date SET DEFAULT CURRENT_DATE,
ADD COLUMN end_date DATE,
ADD CONSTRAINT birth_check CHECK(birth_date < CURRENT_DATE);

ALTER TABLE employees
RENAME job_position TO position_title;

INSERT INTO employees 
VALUES
(1,'Morrie','Conaboy','CTO',21268.94,'2005-04-30','1983-07-10',1,1,NULL,NULL),
(2,'Miller','McQuarter','Head of BI',14614.00,'2019-07-23','1978-11-09',1,1,1,NULL),
(3,'Christalle','McKenny','Head of Sales',12587.00,'1999-02-05','1973-01-09',2,3,1,NULL),
(4,'Sumner','Seares','SQL Analyst',9515.00,'2006-05-31','1976-08-03',2,1,6,NULL),
(5,'Romain','Hacard','BI Consultant',7107.00,'2012-09-24','1984-07-14',1,1,6,NULL),
(6,'Ely','Luscombe','Team Lead Analytics',12564.00,'2002-06-12','1974-08-01',1,1,2,NULL),
(7,'Clywd','Filyashin','Senior SQL Analyst',10510.00,'2010-04-05','1989-07-23',2,1,2,NULL),
(8,'Christopher','Blague','SQL Analyst',9428.00,'2007-09-30','1990-12-07',2,2,6,NULL),
(9,'Roddie','Izen','Software Engineer',4937.00,'2019-03-22','2008-08-30',1,4,6,NULL),
(10,'Ammamaria','Izhak','Customer Support',2355.00,'2005-03-17','1974-07-27',2,5,3,'2013-04-14'),
(11,'Carlyn','Stripp','Customer Support',3060.00,'2013-09-06','1981-09-05',1,5,3,NULL),
(12,'Reuben','McRorie','Software Engineer',7119.00,'1995-12-31','1958-08-15',1,5,6,NULL),
(13,'Gates','Raison','Marketing Specialist',3910.00,'2013-07-18','1986-06-24',1,3,3,NULL),
(14,'Jordanna','Raitt','Marketing Specialist',5844.00,'2011-10-23','1993-03-16',2,3,3,NULL),
(15,'Guendolen','Motton','BI Consultant',8330.00,'2011-01-10','1980-10-22',2,3,6,NULL),
(16,'Doria','Turbat','Senior SQL Analyst',9278.00,'2010-08-15','1983-01-11',1,1,6,NULL),
(17,'Cort','Bewlie','Project Manager',5463.00,'2013-05-26','1986-10-05',1,5,3,NULL),
(18,'Margarita','Eaden','SQL Analyst',5977.00,'2014-09-24','1978-10-08',2,1,6,'2020-03-16'),
(19,'Hetty','Kingaby','SQL Analyst',7541.00,'2009-08-17','1999-04-25',1,2,6,NULL),
(20,'Lief','Robardley','SQL Analyst',8981.00,'2002-10-23','1971-01-25',2,3,6,'2016-07-01'),
(21,'Zaneta','Carlozzi','Working Student',1525.00,'2006-08-29','1995-04-16',1,3,6,'2012-02-19'),
(22,'Giana','Matz','Working Student',1036.00,'2016-03-18','1987-09-25',1,3,6,NULL),
(23,'Hamil','Evershed','Web Developper',3088.00,'2022-02-03','2012-03-30',1,4,2,NULL),
(24,'Lowe','Diamant','Web Developper',6418.00,'2018-12-31','2002-09-07',1,4,2,NULL),
(25,'Jack','Franklin','SQL Analyst',6771.00,'2013-05-18','2005-10-04',1,2,2,NULL),
(26,'Jessica','Brown','SQL Analyst',8566.00,'2003-10-23','1965-01-29',1,1,2,NULL);

-- The two employees Miller McQuarter and Christalle McKenny have agreed
-- to swap their positions incl. their salary.
SELECT * FROM employees;

BEGIN;
UPDATE employees
SET position_title = 'Head of Sales'
WHERE emp_id = 2;
UPDATE employees
SET position_title = 'Head of BI'
WHERE emp_id = 3;
UPDATE employees
SET salary = 12587.00
WHERE emp_id = 2;
UPDATE employees
SET salary = 14614.00
WHERE emp_id = 3;
COMMIT;

SELECT * FROM employees
ORDER BY emp_id;


-- ROLLBACKS
/*
> ROLLBACK is the SQL command that is used for reverting changes performed by a transaction. 
> When a ROLLBACK command is used it reverts all the changes since last COMMIT or ROLLBACK.
> With SAVEPOINTS is possible to revert the changes to a specific point.
*/

SELECT * FROM acc_balance;

BEGIN;
UPDATE acc_balance
SET amount = amount - 100
WHERE id = 2;
DELETE FROM acc_balance
WHERE id = 1;
ROLLBACK;

BEGIN;
UPDATE acc_balance
SET amount = amount - 100
WHERE id = 2;
SAVEPOINT s1;
DELETE FROM acc_balance
WHERE id = 1;
ROLLBACK TO SAVEPOINT s1;
COMMIT;


-- STORED PROCEDURES
/*
> Like USER-DEFINED FUNCTIONS, STORED PROCEDURES are reusable sets of SQL statements 
that can accept parameters and return results.
> An interesting atribute is that STORED PROCEDURES can be used in TRANSACTIONS.
*/

CREATE OR REPLACE PROCEDURE sp_transfer (tr_amount INT, sender INT, recipient INT)
LANGUAGE plpgsql
AS
$$
BEGIN
-- add balance
UPDATE acc_balance
SET amount = amount + tr_amount
WHERE id = recipient;
-- subtract balance
UPDATE acc_balance
SET amount = amount - tr_amount
WHERE id = sender;
COMMIT;
END;
$$

CALL sp_transfer(500, 1, 2);

SELECT * FROM acc_balance;


-- STORED PROCEDURES - Challenge
/*
Create a stored procedure called emp_swap that accepts two parameters
emp1 and emp2 as input and swaps the two employees' position and salary.
Test the stored procedure with emp_id 2 and 3.
*/

SELECT * FROM employees;

CREATE OR REPLACE PROCEDURE emp_swap (emp1 INT, emp2 INT)
LANGUAGE plpgsql
AS
$$
DECLARE
salary1 DECIMAL(8,2);
salary2 DECIMAL(8,2);
position1 TEXT;
position2 TEXT;
BEGIN
-- store values in variable
SELECT salary
INTO salary1
FROM employees
WHERE emp_id = 1;
SELECT salary
INTO salary2
FROM employees
WHERE emp_id = 2;
SELECT position_title
INTO position1
FROM employees
WHERE emp_id = 1;
SELECT position_title
INTO position2
FROM employees
WHERE emp_id = 2;
-- update salary
UPDATE employees
SET salary = salary2
WHERE emp_id = 1;
UPDATE employees
SET salary = salary1
WHERE emp_id = 2;
-- update titles
UPDATE employees
SET position_title = position2
WHERE emp_id = 1;
UPDATE employees
SET position_title = position1
WHERE emp_id = 2;
COMMIT;
END;
$$

CALL emp_swap (1, 2);

SELECT * FROM employees
ORDER BY 1;


-- USER MANAGEMENT
-- USER MANAGEMENT is the colection of commands used to CREATE, assign PRIVILEGES and DROP users on a server.

-- CREATE USER|ROLE

-- CREATE USER
CREATE USER amar
WITH PASSWORD 'amar1234';

-- CREATE ROLE
CREATE ROLE alex
WITH LOGIN PASSWORD 'alex1234';


-- GRANT & REVOKE privilages

-- GRANT USAGE on schema
GRANT USAGE
ON SCHEMA public
TO amar;

-- GRANT SELECT & UPDATE
GRANT SELECT, UPDATE
ON custumer
TO amar;

-- GRANT all privileges on schema
GRANT ALL
ON ALL TABLE IN SCHEMA public
TO amar;

-- GRANT all privileges on database
GRANT ALL
ON DATABASE greencycles
TO amar;

-- GRANT roles to user
GRANT analyst TO amar;

-- REVOKE INSERT
REVOKE INSERT ON customer FROM amar;

-- REVOKE ALL PRIVILEGES
REVOKE ALL PRIVILEGES ON customer FROM PUBLIC;

-- REVOKE ROLE
REVOKE analyst FROM amar;

-- REVOKE PRIVILEGES
REVOKE DELETE, INSERT
ON ALL TABLES IN SCHEMA public
FROM read_update;


-- DROP USER|ROLE

DROP ROLE alex;

DROP ROLE amar;


-- PRIVILEGES - Challenge
/*
In this challenge you need to create a user, a role and add privileges.
Your tasks are the following:
1 - Create the user mia with password 'mia123'
2 - Create  the role analyst_emp;
3 - Grant SELECT on all tables in the public schema to that role.
4 - Grant INSERT and UPDATE on the employees table to that role.
5 - Add the permission to create databases to that role.
6 - Assign that role to mia and test the privileges with that user.
*/

-- Create user
CREATE USER mia
WITH PASSWORD 'mia123';
 
-- Create role
CREATE ROLE analyst_emp;
 
-- Grant privileges
GRANT SELECT
ON ALL TABLES IN SCHEMA public
TO analyst_emp;
 
GRANT INSERT,UPDATE
ON employees
TO analyst_emp;
 
-- Add permission to create databases
ALTER ROLE analyst_emp CREATEDB;
 
-- Assign role to user
GRANT analyst_emp TO mia;


-- INDEXES
-- Indexes help to make data reads faster, avoiding full table scans.

-- B-TREE INDEX
/*
> Multi-level tree structure
> Breaks data down into pages or blocks
> Should be used for high-cardinality (unique) columns
> Not entire table (costy in terms of storage)
*/

-- BITMAP INDEX
/*
> Particularily good for dataware houses
> Large amounts of data + low-cardinality
> Very storage efficient
> More optimized for read & few DML-operations
*/

-- INDEXES - GUIDELINES
/*
Should we put index on every column?
> No! They come with a cost! Storage + Create/Update time
> Only when necessary!
> Avoid full table reads
> Small tables do not require indexes

On which columns?
> 1. Large tables
> 2. Columns that are used as filters
*/

-- CREATING INDEX

-- Example of 18 seconds query
SELECT
(SELECT AVG(amount)
 FROM payment p2
 WHERE p2.rental_id = p1.rental_id)
 FROM payment p1;

-- Creating index
CREATE INDEX index_rental_id_payment
ON payment
(rental_id);

-- After creating the index, the time cost of the example query dropped to 413 millisecond
SELECT
(SELECT AVG(amount)
 FROM payment p2
 WHERE p2.rental_id = p1.rental_id)
 FROM payment p1;

-- Command to delete an index
DROP INDEX index_rental_id_payment;


/****************************/
/* USING DB02 - demo        */
/****************************/

-- CREATING INDEX - Challenge
-- Execute the following query:

SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
				  FROM flights f1
				   WHERE f1.departure_airport=f2.departure_airport
				   );
				   
-- This query has a very bad performance of 25 seconds.
-- Test indexes on different columns and compare their performance.
-- Also considder an index on multiple columns.
-- On which column(s) would you place an index to get the best performance in the query?

CREATE INDEX flight_no_index
ON flights
(departure_airport,flight_no);

-- After creating the index, the time cost of the example query dropped to 269msec
SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
				  FROM flights f1
				   WHERE f1.departure_airport=f2.departure_airport
				   );

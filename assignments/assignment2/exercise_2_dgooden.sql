-- COSC210 Practical Assignment Template

-- Please complete the assignment questions using the view templates
-- provided below.

-- *******************************************************************
--                           IMPORTANT
-- *******************************************************************

-- Make sure that you do not alter the names of the views or their 
-- attribute values. If you do your assignment will not work in the
-- auto-marking software and you may lose marks!

-- *******************************************************************


CREATE VIEW movie_summary(movie_title, release_date, media_type, retail_price) AS
SELECT movie_title, release_date, media_type, retail_price
FROM movies, stock
WHERE movies.movie_id = stock.movie_id
ORDER BY movie_title ASC;

CREATE VIEW old_shipments(first_name, last_name, movie_id, shipment_id, shipment_date) AS
SELECT first_name, last_name, movie_id, shipment_id, shipment_date
FROM customers, shipments
WHERE customers.customer_id = shipments.customer_id
AND shipment_date < '2010-01-01';

CREATE VIEW richie(movie_title) AS
SELECT movie_title
FROM movies
WHERE director_first_name = 'Ron' AND director_last_name = 'Howard';

CREATE VIEW retail_price_hike(movie_id , retail_price, new_price) AS 
SELECT movies.movie_id, retail_price, retail_price * 1.25 AS new_price
FROM movies, stock
WHERE movies.movie_id = stock.movie_id;

CREATE VIEW profits_from_movie(movie_id, movie_title, total_profit) AS 
SELECT movies.movie_id, movie_title, SUM(retail_price - cost_price) AS total_profit
FROM movies, stock, shipments
WHERE movies.movie_id = stock.movie_id
AND stock.movie_id = shipments.movie_id
GROUP BY movie_title, movies.movie_id;

CREATE VIEW binge_watcher(first_name, last_name) AS
SELECT first_name, last_name
FROM customers, shipments
WHERE customers.customer_id = shipments.customer_id
GROUP BY first_name, last_name, shipment_date
HAVING COUNT(shipment_date) > 1;

CREATE VIEW the_sith(first_name, last_name) AS
SELECT first_name, last_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customers.customer_id
    FROM customers, shipments, movies, stock
    WHERE customers.customer_id = shipments.customer_id
    AND shipments.movie_id = movies.movie_id
    AND movies.movie_id = stock.movie_id
    AND movie_title = 'Star Wars: Episode V - The Empire Strikes Back'
);
                              
CREATE VIEW sole_angry_man(first_name, last_name) AS                            
SELECT first_name, last_name
FROM customers, shipments, movies
WHERE customers.customer_id = shipments.customer_id
AND shipments.movie_id = movies.movie_id
AND movie_title = '12 Angry Men'
GROUP BY first_name, last_name
HAVING COUNT(first_name) = 1;
                          
SELECT movie_title, first_name, last_name, shipment_date
FROM movies, customers, shipments
WHERE movies.movie_id = shipments.movie_id
AND customers.customer_id = shipments.customer_id
ORDER BY last_name, first_name;
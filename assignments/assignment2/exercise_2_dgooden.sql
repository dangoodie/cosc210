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


CREATE VIEW movie_summary(movie_title, release_date, media_type, retail_price)
AS

SELECT movie_title, release_date, media_type, retail_price
FROM movies, stock
WHERE movies.movie_id = stock.movie_id
ORDER BY movie_title ASC;



CREATE VIEW old_shipments(first_name, last_name, movie_id, shipment_id, shipment_date)
AS

SELECT first_name, last_name, movie_id, shipment_id, shipment_date
FROM customers, shipments
WHERE customers.customer_id = shipments.customer_id
AND shipment_date < '2010-01-01';

CREATE VIEW richie(movie_title)
AS

SELECT movie_title
FROM movies
WHERE director_first_name = 'Ron' AND director_last_name = 'Howard';

CREATE VIEW retail_price_hike(movie_id , retail_price, new_price)
AS ...

SELECT movies.movie_id, retail_price, retail_price * 1.25 AS new_price
FROM movies, stock
WHERE movies.movie_id = stock.movie_id;




CREATE VIEW profits_from_movie(movie_id, movie_title, total_profit)
AS ...

-- WTF

CREATE VIEW binge_watcher(first_name, last_name)
AS ...

-- This is where your bit goes: define the query as specified in the
-- assignment description

CREATE VIEW the_sith(first_name, last_name)
AS ...

-- This is where your bit goes: define the query as specified in the
-- assignment description

                              
CREATE VIEW sole_angry_man(first_name, last_name)
AS ...                            

-- This is where your bit goes: define the query as specified in the
-- assignment description
                          
                          


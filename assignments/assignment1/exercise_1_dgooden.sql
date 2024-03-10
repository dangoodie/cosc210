CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  last_name VARCHAR(50) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  address VARCHAR(200),
  city VARCHAR(50),
  state VARCHAR(30) CHECK (state IN ('NSW', 'VIC', 'QLD', 'ACT', 'TAS', 'NT', 'SA', 'WA')),
  postcode VARCHAR(8)
);

CREATE TABLE movies (
  movie_id INT PRIMARY KEY,
  movie_title VARCHAR(100) NOT NULL,
  director_last_name VARCHAR(50) NOT NULL,
  director_first_name VARCHAR(50) NOT NULL,
  genre VARCHAR(20) NOT NULL CHECK (genre IN ('Action', 'Adventure', 'Comedy', 'Romance', 'Science Fiction', 'Documentary', 'Drama', 'Horror')),
  release_date DATE,
  studio_name VARCHAR(50)
);

CREATE TABLE stock (
  movie_id INT,
  media_type VARCHAR(20) CHECK (media_type IN ('DVD', 'Blu-Ray', 'Stream-Media')),
  cost_price REAL CHECK (cost_price > 0),
  retail_price REAL CHECK (retail_price > 0),
  current_stock REAL CHECK (current_stock >= 0),
  PRIMARY KEY (movie_id, media_type),
  FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
    ON DELETE CASCADE
);


CREATE TABLE shipments (
  shipment_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  movie_id INT NOT NULL,
  media_type VARCHAR(20),
  shipment_date DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON DELETE CASCADE,
  FOREIGN KEY (movie_id, media_type) REFERENCES stock(movie_id, media_type)
    ON DELETE CASCADE
);
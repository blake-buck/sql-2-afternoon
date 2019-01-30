SELECT * FROM invoice 
INNER JOIN invoice_line 
ON invoice_line.invoice_id = invoice.invoice_id
WHERE invoice_line.unit_price > 0.99;

SELECT invoice.invoice_date, invoice.total,customer.first_name,
customer.last_name FROM invoice JOIN customer 
ON invoice.customer_id = customer.customer_id;

SELECT customer.first_name,customer.last_name, employee.first_name, employee.last_name
FROM customer JOIN employee 
ON customer.support_rep_id = employee.employee_id;

SELECT album.title, artist.name
FROM album JOIN artist 
ON artist.artist_id = album.artist_id;

SELECT playlist_track.playlist_track_id
FROM playlist_track JOIN playlist 
ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music';

SELECT track.name
FROM playlist_track JOIN track 
ON playlist_track.track_id = track.track_id
WHERE playlist_track.playlist_id = 5;

SELECT track.name, playlist.name
FROM playlist_track INNER JOIN track 
ON playlist_track.track_id = track.track_id
INNER JOIN playlist
ON playlist_track.playlist_id = playlist.playlist_id;

SELECT track.name, album.title
FROM track INNER JOIN album 
ON track.album_id = album.album_id
INNER JOIN genre
ON track.genre_id = genre.genre_id
WHERE genre.name = 'Alternative & Punk';



SELECT * FROM invoice WHERE invoice_id IN (
  SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99
)

SELECT * FROM playlist_track WHERE playlist_id IN (
  SELECT playlist_id FROM playlist WHERE name='Music'
)

SELECT name FROM track WHERE track_id IN (
  SELECT track_id FROM playlist_track WHERE playlist_id IN(
    SELECT playlist_id FROM playlist WHERE playlist_id = 5
  )
)

SELECT * FROM track WHERE genre_id IN (
  SELECT genre_id FROM genre WHERE name = 'Comedy' 
)

SELECT * FROM track WHERE album_id IN (
  SELECT album_id FROM album WHERE title = 'Fireball' 
)

SELECT * FROM track WHERE album_id IN (
  SELECT album_id FROM album WHERE artist_id IN(
    SELECT artist_id FROM artist WHERE name = 'Queen'
  )
)



UPDATE customer SET fax = NULL;

UPDATE customer SET company = 'Self' WHERE company IS NULL;

UPDATE customer SET last_name = 'Thompson' WHERE first_name='Julia' AND last_name='Barnett';

UPDATE customer SET support_rep_id = 4 WHERE email = 'luisrojas@yahoo.cl';

UPDATE track SET composer = 'The darkness around us'
WHERE genreid IN(SELECT genreid FROM genre WHERE name='Metal')



SELECT COUNT(*), genreid FROM track
WHERE genreid IN(SELECT genreid FROM genre)
GROUP BY genreid

SELECT COUNT(*), genreid FROM track
WHERE genreid IN(SELECT genreid FROM genre WHERE name IN('Pop','Rock'))
GROUP BY genreid

SELECT artist.name, COUNT(album.title)
FROM artist JOIN album 
ON artist.artistid = album.artistid
GROUP BY artist.name;



SELECT DISTINCT composer FROM track;

SELECT DISTINCT billingpostalcode FROM invoice;

SELECT DISTINCT company FROM customer;



DELETE FROM practice_delete WHERE type='bronze';

DELETE FROM practice_delete WHERE type='silver';

DELETE FROM practice_delete WHERE value=150;



CREATE TABLE shopper(
  shopper_id SERIAL PRIMARY KEY,
  name TEXT,
  email TEXT
);
CREATE TABLE product(
  product_id SERIAL PRIMARY KEY,
  title TEXT,
  price INT
);
CREATE TABLE orders(
  orders_id SERIAL PRIMARY KEY,
  shopper_id INTEGER REFERENCES shopper(shopper_id),
  product_id INTEGER REFERENCES product(product_id)
)
INSERT INTO product(title, price) VALUES ('A', 1);
INSERT INTO product(title, price) VALUES ('B', 15);
INSERT INTO product(title, price) VALUES ('C', 100);

INSERT INTO shopper(name, email) VALUES ('Abby', 'abby@aol');
INSERT INTO shopper(name, email) VALUES ('Bobby', 'bobby@aol');
INSERT INTO shopper(name, email) VALUES ('Crabby', 'crabby@aol');

INSERT INTO orders(product_id, shopper_id) VALUES(1,1);
INSERT INTO orders(product_id, shopper_id) VALUES(2,2);
INSERT INTO orders(product_id, shopper_id) VALUES(3,3);

SELECT * FROM product WHERE product_id IN(
  SELECT product_id FROM orders WHERE orders_id = 1
)

SELECT * FROM orders;

SELECT price FROM product WHERE product_id IN(
  SELECT product_id FROM orders WHERE orders_id=2
)

SELECT * FROM orders WHERE shopper_id IN(
  SELECT shopper_id FROM shopper WHERE shopper_id=1
)

SELECT COUNT(*) FROM orders WHERE shopper_id IN(
  SELECT shopper_id FROM shopper WHERE shopper_id=1
)
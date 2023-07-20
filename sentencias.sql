-- Primero inicializamos postgres
psql -U postgres

--luego se crea la base de datos dvdrental
 CREATE DATABASE dvd;

 --Luego salimos de psql con el comando exit
 exit
 -- Luego cargamos la base de datos dvdrental.tar
 pg_restore -U postgres -d dvd dvdrental.tar
 -- volvemos a ingresar
 psql -U postgres
 --Me conecto a la bbdd
 \c dvd;
 -- reviso las tablas en la bbdd 
 \dt
 -- reviso la estructura y nombres de tablas
 \d

 -- Construye las siguientes consultas:
--• Aquellas usadas para insertar, modificar y eliminar un Customer, Staff y Actor.

--INSERTAR CUSTOMER (cliente)
INSERT INTO customer (store_id, first_name, last_name, email, address_id, activebool, create_date)
VALUES (600, 'Elba', 'Surero', 'elba.surero@sakilacustomer.org', 17, true, '2006-02-14');

-- Verifico si el INSERT se realizo correctamente
SELECT * FROM customer WHERE first_name = 'Elba' AND last_name = 'Surero';

-- MODIFICAR CUSTOMER
UPDATE customer
SET store_id = 606, first_name = 'Stefani', last_name = 'Germanotta', email = 'gaga@sakilacustomer.org', address_id = 17
WHERE customer_id = 600;

-- Verificar modificacion customer
SELECT customer_id, store_id, first_name, last_name, email, address_id
FROM customer
WHERE customer_id = 600;

-- ELIMINAR CUSTOMER
DELETE FROM customer
WHERE customer_id = 600;
-- verificar si se elimino customer 600
SELECT * FROM customer WHERE customer_id = 600;

--INSERTAR STAFF (empleado)
INSERT INTO staff (first_name, last_name, address_id, email, store_id, active, username, password)
VALUES ('Kevin', 'Parker', 1, 'kevin.parker@sakilacustomer.org', 1, true, 'kevs', 'tameimpala');

--verificar si se inserto correctamente el empleado
SELECT * FROM staff WHERE first_name = 'Kevin' AND last_name = 'Parker';

-- MODIFICAR  STAFF(email y direccion)
UPDATE staff
SET email = 'kevin.parker88@sakilacustomer.org', address_id = 2
WHERE staff_id = 1;

--verificar que se modifico empleado
SELECT * FROM staff WHERE staff_id = 1;

-- ELIMINAR STAFF
DELETE FROM staff
WHERE staff_id = 3;

--verificar si se elimino correctamente el empleado
SELECT * FROM staff;

-- INSERTAR UN ACTOR

INSERT INTO actor (first_name, last_name)
VALUES ('equis', 'dee');
-- verificar si se inserto un actor
SELECT * FROM actor;


--MODIFICAR UN ACTOR
UPDATE actor
SET first_name = 'Tulio'
WHERE actor_id = 201;

--verificar si se modifico el actor
SELECT * FROM actor
WHERE actor_id = 201;

-- ELIMINAR UN ACTOR
DELETE FROM actor
WHERE actor_id = 201;

--verificar si se elimino el actor
SELECT * FROM actor
WHERE actor_id = 201;


--• Listar todas las “rental” con los datos del “customer” dado un año y mes.
SELECT r.rental_id, r.rental_date, c.first_name, c.last_name, c.email
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM r.rental_date) = 2006
  AND EXTRACT(MONTH FROM r.rental_date) = 02
  AND c.first_name = 'John';

--• Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
SELECT payment_id, payment_date, amount
FROM payment;

--• Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.
SELECT *
FROM film
WHERE release_year = 2006
  AND rental_rate > 4.0;

-- Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si
--éstas pueden ser nulas, y su tipo de dato correspondiente.

SELECT
t1.TABLE_NAME AS tabla_nombre,
t1.COLUMN_NAME AS columna_nombre,
t1.ORDINAL_POSITION AS position,
t1.IS_NULLABLE AS nulo,
t1.DATA_TYPE AS tipo_dato,
COALESCE(t1.NUMERIC_PRECISION,
t1.CHARACTER_MAXIMUM_LENGTH) AS longitud
FROM
INFORMATION_SCHEMA.COLUMNS t1
WHERE
t1.TABLE_SCHEMA = 'public'
ORDER BY
t1.TABLE_NAME;



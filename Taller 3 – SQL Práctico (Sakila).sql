# conexión
use sakila;

# parte 1 - select y where

# Mostrar nombre y apellido de todos los clientes
select first_name, last_name from customer;

# Mostrar nombre y apellido de todos los clientes
select * from film
where length >= 120;

# Parte 2 order by

# Ordenar clientes por apellido --> Por orden alfabetico de la A a la Z
select last_name from customer
order by last_name asc;

# Top 5 películas más largas --> TIP: Use la palabra LIMIT
select * from film
order by length desc
limit 5;

# Parte 3 - inner join

# Cantidad pagada y fecha del pago con nombre y apellido del cliente (JOIN entre Payment - Customer)
SELECT customer.first_name, customer.last_name, payment.amount, payment.payment_date FROM payment payment
INNER JOIN customer customer ON payment.customer_id = customer.customer_id
ORDER BY payment.payment_date;

# Películas alquiladas (JOIN entre Rental - Inventory - Film)
SELECT film.film_id, film.title, rental.rental_id, rental.rental_date, rental.return_date FROM rental rental
INNER JOIN inventory inventory
    ON rental.inventory_id = inventory.inventory_id
INNER JOIN film film
    ON inventory.film_id = film.film_id
ORDER BY rental.rental_date;

# Parte 4 - Left Join

# Nombre y apellido de clientes sin pagos (LEFT JOIN entre Payment - Customer pero usando WHERE)
select customer.first_name,customer.last_name
from customer customer
left join payment payment
	on customer.customer_id = payment.customer_id
    where payment.payment_id is null;
    
# Listar los nombres de las peliculas y su duracion de aquellos titulos que no tienen actores    
SELECT film.title AS pelicula,
film.length AS duracion
FROM film film
LEFT JOIN film_actor film_actor 
    ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id IS NULL;


 ## Parte 5 – INSERT, UPDATE, DELETE (Data Definition Language
 
INSERT INTO actor (first_name, last_name)
VALUES ('GEORGE', 'CAMACHO');

UPDATE actor
SET first_name = 'GEORGE',
    last_name = 'CAMACHO'
WHERE first_name = 'Jorge'
  AND last_name = 'Camacho';
  
DELETE FROM actor
WHERE first_name = 'GEORGE'
  AND last_name = 'CAMACHO';


## Parte 6 - Consultas Avanzadas

# Top 5 clientes con mayor cantidad de dinero pagado al servicio de rentas
SELECT customer.customer_id,
    CONCAT(customer.first_name, ' ', customer.last_name) AS cliente,
    SUM(payment.amount) AS total_pagado
FROM customer customer
INNER JOIN payment payment
    ON customer.customer_id = payment.customer_id
GROUP BY
    customer.customer_id,
    customer.first_name,
    customer.last_name
ORDER BY total_pagado DESC
LIMIT 5;


# Top 5 Películas más alquiladas  (JOIN entre Rental - Inventory - Film) --> Agrupar los datos con conteo y tomar las mejores 5
SELECT film.film_id,
    film.title AS pelicula,
    COUNT(rental.rental_id) AS veces_alquilada
FROM rental rental
INNER JOIN inventory inventory
    ON rental.inventory_id = inventory.inventory_id
INNER JOIN film film
    ON inventory.film_id = film.film_id
GROUP BY
    film.film_id,
    film.title
ORDER BY veces_alquilada DESC
LIMIT 5;



# EJERCICIOS DE SAKILA SAMPLE DATABASE | TOMADOS DE: https://www.discoduroderoer.es/ejercicios-propuestos-y-resueltos-sakila-mysql/

# INICIO

USE sakila;

# 1. Actores que tienen de primer nombre ‘Scarlett’.

SELECT * FROM actor WHERE first_name='Scarlett';

# 2. Actores que tienen de apellido ‘Johansson’.

SELECT * FROM actor WHERE last_name='Johansson';

# 3. Actores que contengan una ‘O’ en su nombre.

SELECT * FROM actor WHERE first_name LIKE '%O%';

# 4. Actores que contengan una ‘O’ en su nombre y en una ‘A’ en su apellido.

SELECT * FROM actor WHERE first_name LIKE '%O%' AND last_name LIKE '%A%';

# 5. Actores que contengan dos ‘O’ en su nombre y en una ‘A’ en su apellido.

SELECT * FROM actor WHERE first_name LIKE '%O%O%' AND last_name LIKE '%A%';

# 6. Actores donde su tercera letra sea ‘B’.

SELECT * FROM actor WHERE first_name LIKE '__B%';

# 7. Ciudades que empiezan por ‘a’.

SELECT * FROM city WHERE city LIKE 'A%';

# 8. Ciudades que acaban por ‘s’.

SELECT * FROM city WHERE city LIKE '%S';

# 9. Ciudades del country 61.

SELECT * FROM city WHERE country_id=61;

# 10. Ciudades del country ‘Spain’.

SELECT * FROM city WHERE country_id=(SELECT country_id FROM country WHERE country='Spain');

# 11. Ciudades con nombres compuestos.

SELECT * FROM city WHERE city LIKE '% %';

# 12. Películas con una duración entre 80 y 100.

SELECT * FROM film WHERE length BETWEEN 80 AND 100;

# 13. Peliculas con un rental_rate entre 1 y 3.

SELECT * FROM film WHERE rental_rate BETWEEN 1 AND 3;

# 14. Películas con un titulo de más de 12 letras.

SELECT * FROM film WHERE LENGTH(title)>12;

# 15. Peliculas con un rating de PG o G.

SELECT * FROM film WHERE rating IN ('PG', 'G');

# 16. Peliculas que no tengan un rating de NC-17.

SELECT * FROM film WHERE rating NOT IN ('NC-17');

# 17. Peliculas con un rating PG y duracion de más de 120.

SELECT * FROM film WHERE rating='PG' AND length>120;

# 18. ¿Cuantos actores hay?

SELECT COUNT(actor_id) AS total_actor FROM actor;

# 19. ¿Cuántas ciudades tiene el country ‘Spain’?

SELECT COUNT(city) AS total_city FROM city WHERE country_id=(SELECT country_id FROM country WHERE country='Spain');

# 20. ¿Cuántos countries hay que empiezan por ‘a’?

SELECT COUNT(country) FROM country WHERE country LIKE 'A%';

# 21. Media de duración de peliculas con PG.

SELECT AVG(length) FROM film WHERE rating='PG';

# 22. Suma de rental_rate de todas las peliculas.

SELECT SUM(rental_rate) FROM film;

# 23. Pelicula con mayor duración.

SELECT * FROM film ORDER BY length DESC LIMIT 1;

# 24. Película con menor duración.

SELECT * FROM film ORDER BY length LIMIT 1;

# 25. Mostrar las ciudades del country Spain (multitabla).

SELECT city.city_id, city.city, country.country_id, country.country FROM city INNER JOIN country ON country.country_id = city.country_id WHERE country.country='Spain';

# 26. Mostrar el nombre de la película y el nombre de los actores.

SELECT film.film_id, film.title, actor.actor_id, actor.first_name, actor.last_name FROM film, actor, film_actor WHERE film_actor.film_id=film.film_id AND film_actor.actor_id=actor.actor_id ORDER BY film.title;

# 27. Mostrar el nombre de la película y el de sus categorías.

SELECT film.film_id, film.title, category.name as category FROM film, category, film_category WHERE film.film_id=film_category.film_id AND film_category.category_id=category.category_id ORDER BY film.title;

# 28. Mostrar el country, la ciudad y dirección de cada miembro del staff.

SELECT country.country, city.city, address.address, staff.first_name, staff.last_name FROM country, city, address, staff WHERE country.country_id=city.country_id AND city.city_id=address.city_id AND address.address_id=staff.address_id;

# 29. Mostrar el country, la ciudad y dirección de cada customer.

SELECT country.country, city.city, address.address, customer.first_name, customer.last_name FROM country, city, address, customer WHERE country.country_id=city.country_id AND city.city_id=address.city_id AND address.address_id=customer.address_id;

# 30. Numero de películas de cada rating

SELECT rating, COUNT(*) FROM film GROUP BY rating;

# 31. Cuantas películas ha realizado el actor ED CHASE.

SELECT COUNT(*) FROM film_actor WHERE actor_id=(SELECT actor_id FROM actor WHERE first_name='ED' AND last_name='CHASE');

# 32. Media de duración de las películas cada categoría.

SELECT category.name, AVG(film.length) FROM category, film, film_category WHERE film_category.film_id=film.film_id AND film_category.category_id=category.category_id GROUP BY category.name;

# FIN
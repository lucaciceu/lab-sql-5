use sakila;

-- 1. Drop column picture from staff.
alter table staff
drop column picture;

select * from staff;
-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
insert into staff
values (3, 'TAMMY', 'SANDERS', 79, 'TAMMY.SANDERS@sakilacustomer.org', 2, 1, 'TAMMY', 'tammysan', '2006-02-15 04:57:20');

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.
select film_id from sakila.film
where title = 'Academy Dinosaur';
select inventory_id from sakila.inventory
where film_id = 1 and store_id = 1;
select * from rental
where customer_id = 130;
select * from rental
order by rental_id desc;
insert into rental
values ('16050', '2005-05-31 00:46:32', '1', '130', '2005-06-06 10:00:00', '1', '2006-02-15 21:30:00');

-- 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
-- Check if there are any non-active users
-- Create a table backup table as suggested
-- Insert the non active users in the table backup table
-- Delete the non active users from the table customer
select active, count(customer_id) from customer 
group by active;

drop table deleted_users;

CREATE TABLE deleted_users (
  customer_id int UNIQUE NOT NULL,
  email varchar(50) NOT NULL,
  date datetime NOT NULL,
  CONSTRAINT PRIMARY KEY (customer_id)
) ;

insert into deleted_users
select customer_id, email, create_date 
from customer
where active = 0;

select * from deleted_users;

delete from customer where active = 0;

select * from customer;


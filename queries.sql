use movie_rental_system;

-- 1. List all movies with genre

select m.title, g.name as genre, m.release_year 
from movies m 
join Genres g on m.genre_id = g.genre_id;

-- 2. List all customers

select* from customers;

-- 3. Show all current rentals (not returned yet)

select r.rental_id, m.title, c.name as customer, r.rental_date, r.due_date
from Rentals r 
join Movies m on r.movie_id = m.movie_id
join Customers c on r.customer_id = c.customer_id
where r.return_date is null;

-- 4. List overdue rentals
select r.rental_id, m.title, c.name as customer, r.due_date
from Rentals r 
join Movies m on r.movie_id = m.movie_id
join Customers c on r.customer_id = c.customer_id
where r.return_date is null and r.due_date < curdate();

-- 5. List all late fees (returned late)

select r.rental_id, m.title, c.name as customer, r.due_date
from Rentals r 
join Movies m on r.movie_id = m.movie_id
join Customers c on r.customer_id = c.customer_id
where r.late_fee > 0;

-- 6. Total revenue from payments

select sum(amount_paid) as total_revenue
from payments;

-- 7.  Most rented movies

select m.title, count(*) as times_rented
from Rentals r
join Movies m on r.movie_id = m.movie_id
group by r.movie_id
order by times_rented desc
limit 5;

-- 8.Customer rental history

select c.name, m.title, r.rental_date, r.return_date, r.late_fee
from Rentals r
join Customers c on r.customer_id = c.customer_id
join Movies m on r.movie_id = m.movie_id
order by c.name , r.rental_date;

-- 9. Movies that are currently out of stock

select title, available_copies
from movies
where available_copies = 0;

-- 10. Rentals and payments per customer

select c.name, count(r.rental_id) as rentals, count(p.payment_id) as payments
from Customers as c
left join Rentals r on c.customer_id = r.customer_id
left join payments p on r.rental_id = p.rental_id 
group by c.customer_id;
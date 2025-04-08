create database movie_rental_system ;
use movie_rental_system;

-- Genre Table (option bt useful)

create table Genres (
	genre_id int primary key,
    name varchar (50)
    );
    
-- Movies Table 

create table Movies (	
	movie_id int primary key,
    title varchar(100),
    genre_id int,
    release_year int,
    available_copies int check (available_copies >=0),
    foreign key (genre_id) references Genres(genre_id)
    );
    alter table Movies 
    add rental_price decimal (5,2);
    
-- Customers table

create table Customers (	
	customer_id int primary key,
    name varchar(100),
    email varchar(100),
    phone varchar(50)
    );
    
-- Rentals Table
	
create table Rentals (	
	rental_id int primary key,
    movie_id int,
    customer_id int,
    rental_date date,
    due_date date,
    return_date date,
    late_fee decimal(5,2),
    foreign key (movie_id) references Movies(movie_id),
    foreign key (customer_id) references Customers(customer_id)
    );
    
-- Payment Table

create table Payments (	
	payment_id int primary key,
    rental_id int,
    amount_paid decimal(5,2),
    payment_date date,
    foreign key (rental_id) references Rentals(rental_id)
    );
    
-- Insert Genres
insert into genres (genre_id, name)
values
		(1, 'Action'),
        (2, 'Comedy'),
        (3, 'Drama'),
        (4, 'Sci-Fi'),
        (5, 'Horror');
    
-- Insert Movies
insert into movies (movie_id, title, genre_id, release_year, available_copies, rental_price)
values
		(101, 'Inception', 4, 2010, 5, 3.99),
        (102, 'The Hangover', 2, 2009, 3, 5.99),
        (103, 'The Godfather', 3, 1972, 4, 6.50),
        (104, 'Avengers: End-Game', 1, 2019, 6, 8.92),
        (105, 'A Quiet Place', 5, 2018, 2, 4.50)
;
    
    
    -- Insert Customers
insert into customers(customer_id, name, email, phone)
values
		(1, 'Grace Wang', 'gracewong@example.com', 87456438),
        (2, 'Roddie', 'roddie24@example.com', 67564871),
        (3, 'Jason Rod', 'jasonrod@example.com', 98564876)
      ;
        
 -- Insert Rentals
insert into rentals(rental_id, movie_id, customer_id, rental_date, due_date, return_date, late_fee)
values
		(1001, 101, 1, '2024-03-01', '2024-03-05', '2024-03-06', 1.00),
		(1002, 102, 2, '2024-03-10', '2024-03-15', '2024-03-14', 0.00),
		(1003, 103, 3, '2024-03-20', '2024-03-25', NULL, NULL),
		(1004, 104, 1, '2024-03-22', '2024-03-28', '2024-03-30', 2.00)
;

-- Insert Payments

insert into payments(payment_id, rental_id, amount_paid, payment_date)
values
		(501, 1001, 4.99, '2024-03-06'),
		(502, 1002, 2.99, '2024-03-14'),
		(503, 1004, 7.99, '2024-03-30')
;

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

-- Auto Late Fee Calculation Trigger

-- This will:
-- Trigger before an update on the Rentals table
-- Check if return_date > due_date
-- Set late_fee = days_late * 1.00 (or change the rate as you like)

DELIMITER //

create trigger calculat_late_fee
before update on Rentals
for each row
begin
	if new.return_date is not null and new.return_date > new.due_date then
		set new.late_fee = datediff(new.return_date, new.due_date) * 1.00;
	else
		set new.late_fee = 0.00;
	end if;
end;
//

DELIMITER ;


-- to test the trigger system

select* 
from rentals
where rental_id = 1003
;

-- Now update it with a late return date (e.g., 5 days after due_date):

update Rentals
set return_date = '2024-05-30'
where rental_id = 1003;
-- Check the rentals again

select rental_id, rental_date, due_date, return_date, late_fee
from Rentals
where rental_id = 1003;

-----


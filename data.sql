use movie_rental_system;

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


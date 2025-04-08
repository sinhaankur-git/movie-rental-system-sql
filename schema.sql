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
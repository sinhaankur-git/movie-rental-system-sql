use movie_rental_system;

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
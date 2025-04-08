use movie_rental_system;

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
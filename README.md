# 🎬 Online Movie Rental System (SQL Project)

A hands-on SQL database project simulating an online movie rental service like Netflix or Blockbuster.

## 📁 Files

- `schema.sql` – Create database tables (Movies, Rentals, Customers, Payments)
- `data.sql` – Sample data to populate the system
- `queries.sql` – Useful reports (overdue rentals, revenue, most rented movies, etc.)
- `triggers.sql` – Trigger to auto-calculate late fees
- `full_setup.sql` – (Optional) Run the entire setup in one go

## 🧠 Concepts Practiced

- SQL joins and subqueries
- Aggregation and filtering
- Triggers
- Data modeling with foreign keys
- Constraints and validations

## ✅ How to Run

1. Import `schema.sql` into MySQL
2. Import `data.sql`
3. Import `triggers.sql`
4. Run any queries from `queries.sql`

OR just run `full_setup.sql` if you want everything at once.

## 📌 Example Queries

- View all currently rented movies
- See customers with pending returns
- Calculate total revenue
- Get top 5 most rented movies

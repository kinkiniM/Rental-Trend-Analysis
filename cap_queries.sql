/* 1. Rental Trends */

/* Analyze the monthly rental trends over the available data period. */

-- total number of rentals monthly basis
select MONTHNAME(rental_date) as Rental_Month, year(rental_date) as Rental_Year, count(*) as Num_Of_Rentals
from rental
group by Rental_Month, Rental_Year
order by  Rental_Year;


/* Determine the peak rental hours in a day based on rental transactions */

SELECT 
    EXTRACT(HOUR FROM rental_date) AS rental_hour, 
    date_format(rental_date, '%d-%m') as date_of_rental,
    EXTRACT(YEAR FROM rental_date) as rental_Year,
    COUNT(*) AS total_count
FROM 
    rental
GROUP BY 
    rental_hour, date_of_rental,rental_Year
;


-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

/* Film_Popularity */

/* Identify the top 10 most rented films */
select film.Film_Id, title, Release_Year, Rating, Rental_Rate , count(*) as Num_Of_Rentals
from film 
inner join inventory
on film.film_id = inventory.film_id 
inner join rental
on inventory.inventory_id = rental.inventory_id 
group by film_id
order by Num_Of_Rentals desc
limit 10;

/* Determine which film categories have the highest number of rentals. */

select category.category_Id, name as Category_Name, count(rental_id) as Num_Of_Rentals
from category
inner join film_category on category.category_id = film_category.category_id
inner join film on film.film_id = film_category.film_id
inner join inventory on film.film_id = inventory.film_id 
inner join rental on inventory.inventory_id = rental.inventory_id 
group by category.category_id, category_name
-- order by Num_Of_Rentals desc
;
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------

/* 3. Store Performance */

/* Identify which store generates the highest rental revenue */
select store.store_id, sum(amount) as rental_revenue
from store inner join staff
on store.store_id = staff.store_id
inner join payment on payment.staff_id = store.manager_staff_id
group by store.store_id
order by rental_revenue desc;

/* Determine the distribution of rentals by staff members to assess performance. */

select staff.Staff_Id, CONCAT(first_name, ' ', last_name) as Staff_Name, COUNT(rental_id) AS Total_No_Of_Rentals
FROM rental 
inner join staff  on rental.staff_id = staff.staff_id
group by staff.staff_id, first_name, last_name
order by total_No_Of_rentals desc;
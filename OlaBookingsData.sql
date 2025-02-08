--Create bookings table--
DROP TABLE IF EXISTS bookings;
CREATE TABLE bookings(
	Date DATE,
	Time TIME,
	Booking_ID VARCHAR(100),
	Booking_Status VARCHAR(100),
	Customer_ID	VARCHAR(100),
	Vehicle_Type VARCHAR(100),
	Pickup_Location	VARCHAR(100),
	Drop_Location VARCHAR(100),
	V_TAT INT,
	C_TAT INT,
	Canceled_Rides_by_Customer VARCHAR(100),
	Canceled_Rides_by_Driver VARCHAR(100),
	Incomplete_Rides VARCHAR(100),
	Incomplete_Rides_Reason	VARCHAR(100),
	Booking_Value INT,
	Payment_Method VARCHAR(100),
	Ride_Distance INT,
	Driver_Ratings TEXT,
	Customer_Rating TEXT,
	Vehicle_Images TEXT
);

select * from bookings;

--DATA ANALYSIS AND EXPLORATIONS--

--1. Retrieve all the successful bookings
CREATE VIEW Successful_Bookings AS
SELECT * FROM bookings
WHERE booking_status = 'Success';

SELECT * FROM Successful_Bookings;

--2. Find the average ride distance for each vehicle type?
CREATE VIEW Average_ride_distance_each_vehicle AS
SELECT DISTINCT vehicle_type,
ROUND(AVG(ride_distance),2) AS avg_ride_distance
FROM bookings
GROUP BY 1;

SELECT * FROM Average_ride_distance_each_vehicle;

--3. Get the total number of cancelled rides by customers
CREATE VIEW total_Cancelled_rides_by_customers AS
SELECT COUNT(*) AS total_no
FROM bookings 
WHERE booking_status = 'Canceled by Customer';

SELECT * FROM total_Cancelled_rides_by_customers;

--4. List of top 5 customers who booked the highest number of rides
CREATE VIEW Top_5_Customers AS
SELECT customer_id,
	COUNT(booking_id) AS total_rides
FROM bookings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

SELECT * FROM Top_5_Customers;

--5. Get the number of rides canceled by drivers due to personal and car-related issues
CREATE VIEW rides_canceled_by_drivers_P_C_issues AS 
SELECT count(*) AS cnt
FROM bookings
WHERE canceled_rides_by_driver = 'Personal & Car related issue';

SELECT * FROM rides_canceled_by_drivers_P_C_issues;

--6. Find Maximum and minimum driver ratings for Prime Sedan bookings
CREATE VIEW Ratings_for_Prime_Sedan AS
SELECT vehicle_type, 
       MAX(driver_ratings::NUMERIC) AS max_rating, 
       MIN(driver_ratings::NUMERIC) AS min_rating
FROM bookings
WHERE vehicle_type = 'Prime Sedan'
AND driver_ratings ~ '^[0-9]+(\.[0-9]+)?$'  -- it Ensures only valid numeric values are considered
GROUP BY vehicle_type;

SELECT * FROM Ratings_for_Prime_Sedan;

--7. Retrieve all rides where payment was made using UPI
CREATE VIEW UPI_Payments AS
SELECT * FROM bookings
WHERE payment_method = 'UPI';

SELECT * FROM UPI_Payments;

--8. Find the average customer rating per vehicle type
CREATE VIEW Average_customer_ratings_for_vehicle AS
SELECT vehicle_type,
ROUND(AVG(customer_rating::NUMERIC), 2) AS avg_ratings
FROM bookings 
WHERE customer_rating ~ '^[0-9]+(\.[0-9]+)?$'     -- It ensures only valid numeric values are considered
GROUP BY 1;

SELECT * FROM Average_customer_ratings_for_vehicle;

--9. Calculate the total booking value of rides completed successfully
CREATE VIEW Successful_ride_values AS
SELECT SUM(booking_value) AS total_successful_ride_value
FROM bookings
WHERE booking_status = 'Success';

SELECT * FROM Successful_ride_values;

--10. List all incomplete rides along with the reason
CREATE VIEW Incomplete_rides AS 
SELECT booking_id,
	Incomplete_rides_reason
FROM bookings
WHERE Incomplete_rides = 'Yes';

SELECT * FROM Incomplete_rides;


--END--
















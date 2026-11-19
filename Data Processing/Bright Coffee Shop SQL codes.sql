--1.TOTAL REVENUE
SELECT SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Amount
FROM brightlearn_institution.sales.bright_coffee_shop

--2. TOTAL UNITS SOLD
SELECT SUM(transaction_qty) AS total_units_sold
FROM brightlearn_institution.sales.bright_coffee_shop

--3.TOTAL UNITS SOLD PER PRODUCT TYPE
SELECT product_type,
SUM(transaction_qty) AS units_sold
FROM brightlearn_institution.sales.bright_coffee_shop 
GROUP BY product_type
ORDER BY units_sold DESC

--4.TOTAL REVENUE PER PRODUCT TYPE
SELECT Product_type,
SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Amount
FROM brightlearn_institution.sales.bright_coffee_shop 
GROUP BY ALL

--5.TOTAL UNITS SOLD PER PRODUCT DETAIL
SELECT product_detail,
SUM(transaction_qty) AS units_sold
FROM brightlearn_institution.sales.bright_coffee_shop 
GROUP BY product_detail
ORDER BY units_sold DESC

--6.TOTAL REVENUE PER PRODUCT DETAIL
SELECT Product_detail,
SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Amount
FROM brightlearn_institution.sales.bright_coffee_shop 
GROUP BY ALL

--7.TOTAL UNITS SOLD PER PRODUCT CATEGORY
SELECT product_category,
SUM(transaction_qty) AS units_sold
FROM brightlearn_institution.sales.bright_coffee_shop 
GROUP BY product_category
ORDER BY units_sold DESC

--8. TOTAL REVENUE PER PRODUCT CATEGORY
  SELECT product_category,
  SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
  FROM brightlearn_institution.sales.bright_coffee_shop 
  GROUP BY product_category

--9. TEA PRODUCT REVENUE
SELECT product_type,
    product_category,
    SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM brightlearn_institution.sales.bright_coffee_shop 
WHERE product_category = 'Tea'
GROUP BY product_type,
         product_category

--10. COFFEE PRODUCT REVENUE
SELECT product_type,
    product_category,
    SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM brightlearn_institution.sales.bright_coffee_shop 
WHERE product_category = 'Coffee'
GROUP BY product_type,
         product_category

--11. DRINKING CHOCOLATE TOTAL REVENUE
SELECT product_type,
    product_category,
    SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Revenue
FROM brightlearn_institution.sales.bright_coffee_shop 
WHERE product_category = 'Drinking Chocolate'
GROUP BY product_type,
         product_category

--11 STORES REVENUE RANK 
SELECT store_location,
SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Amount
FROM brightlearn_institution.sales.bright_coffee_shop 
GROUP BY ALL

--12. TOTAL REVENUE BASED ON THE TIME OF THE DAY
--Earliset Transaction Time
SELECT MIN(transaction_time),
       MAX(transaction_time)
FROM brightlearn_institution.sales.bright_coffee_shop

--6:00 - 11:59 > Morning
--12:00 - 17:59 > Afternoon
--18:00 -21:00 > Evening

SELECT    product_type,
          product_category,
          product_detail,
     CASE 
           WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
           WHEN transaction_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
           WHEN transaction_time BETWEEN '18:00:00' AND '21:00:00' THEN 'Evening'
END AS time_bucket,
SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Amount
FROM brightlearn_institution.sales.bright_coffee_shop 
GROUP BY ALL

--13. TOTAL UNITS SOLD BASED ON THE TIME OF THE DAY
SELECT    product_type,
          product_category,
          product_detail,
     CASE 
           WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
           WHEN transaction_time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
           WHEN transaction_time BETWEEN '18:00:00' AND '21:00:00' THEN 'Evening'
END AS time_bucket,
SUM(transaction_qty) AS total_units_sold
FROM brightlearn_institution.sales.bright_coffee_shop 
GROUP BY ALL

--15 30 MIN TIME INTERVAL

SELECT transaction_time,
CONCAT(LPAD(CAST(HOUR(TO_TIMESTAMP(transaction_time, 'HH:mm:ss')) AS STRING), 2, '0'),
        ':',
        LPAD(CAST(FLOOR(MINUTE(TO_TIMESTAMP(transaction_time, 'HH:mm:ss')) / 30) * 30 AS STRING), 2,'0')) AS time_30_min_interval
FROM brightlearn_institution.sales.bright_coffee_shop 

--16.Top 10 Best Selling products
SELECT product_detail,
SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Amount
FROM brightlearn_institution.sales.bright_coffee_shop 
GROUP BY product_detail
ORDER BY Total_Amount DESC
LIMIT 10

--17. Bottom 10 Selling products
SELECT product_detail,
SUM(transaction_qty * CAST(REPLACE(unit_price, ',', '.') AS DECIMAL(10,2))) AS Total_Amount
FROM brightlearn_institution.sales.bright_coffee_shop 
GROUP BY product_detail
ORDER BY Total_Amount ASC
LIMIT 10

--18.EXTRACTION OF MONTH, DAY OF WEEK AND DAY
SELECT transaction_date,
MONTHNAME(transaction_date)AS month_name,
MONTH(transaction_date)AS month_number,
DATE_FORMAT(transaction_date, 'yyyy-MMM') AS month_id,
DAYOFWEEK(transaction_date) AS day_of_week,
DAYNAME(transaction_date) AS day_number
 FROM brightlearn_institution.sales.bright_coffee_shop 


CREATE TABLE pizza_sales (
    pizza_id         INT,
    order_id         INT,
    pizza_name_id    VARCHAR(50),
    quantity         INT,
    order_date       DATE,
    order_time       TIME,
    unit_price       NUMERIC(10,2),
    total_price      NUMERIC(10,2),
    pizza_size       VARCHAR(5),
    pizza_category   VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name       VARCHAR(100)
);

--1. Total Revenue:

select sum(total_price) as Total_Revenue From pizza_sales;

--2. Average Order Value
select sum(total_price)/COUNT(Distinct order_id) as Average_Order_Value
From pizza_sales;

--3. Total Pizzas Sold
select sum(quantity) as  Total_Pizza_Sold  From pizza_sales;

4. Total Orders
select Count(Distinct order_id) as Total_orders
from pizza_sales 

 
5. Average Pizzas Per Order

SELECT ROUND(SUM(quantity)::numeric / COUNT(DISTINCT order_id), 2) AS avg_pizzas_per_order
FROM pizza_sales;

--Daily Trend for Total Orders

SELECT TO_CHAR(order_date, 'Day') AS order_day,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day');


--Hourly Trend for Orders

SELECT EXTRACT(HOUR FROM order_time) AS order_hour,
       COUNT(DISTINCT order_id) AS total_orders
	   from pizza_sales
	   group by EXTRACT(HOUR FROM order_time) 
	   order by EXTRACT(HOUR FROM order_time) 

--% of Sales by Pizza Category   

SELECT pizza_category,
SUM(total_price) AS total_revenue,
ROUND(SUM(total_price) * 100.0 /(SELECT SUM(total_price)FROM pizza_sales), 2) AS PCT
FROM pizza_sales
GROUP BY pizza_category

--% of Sales by Pizza Size
SELECT pizza_size,
       SUM(total_price) AS total_revenue,
       ROUND(SUM(total_price) * 100.0 /
             (SELECT SUM(total_price)
              FROM pizza_sales
              WHERE EXTRACT(QUARTER FROM order_date) = 1), 2) AS pct
FROM pizza_sales
WHERE EXTRACT(QUARTER FROM order_date) = 1
GROUP BY pizza_size
ORDER BY pizza_size;

--Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


--Top 5 Best Sellers by Total Pizzas Sold
select pizza_name,sum(quantity) as Total_Pizzas_Sold 
from pizza_sales
Group by pizza_name
order by sum(quantity) desc limit 5

--Bottom 5 Best Sellers by Total Pizzas Sold
select pizza_name,sum(quantity) as Total_Pizzas_Sold 
from pizza_sales
Group by pizza_name
order by sum(quantity) asc limit 5



















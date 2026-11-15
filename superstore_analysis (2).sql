-- Retail Sales Analysis: SuperStore US
-- Tool: PostgreSQL | Dataset: 1,952 rows | Jan-Jun 2015

-- Q1: Which region generates the most sales and profit?
SELECT region, SUM(sales) as total_sales, SUM(profit) as total_profit
FROM orders 
GROUP BY region 
ORDER BY SUM(sales) DESC;

-- Q2: Which product category has the highest profit margin?
SELECT product_category,
       ROUND((SUM(profit)/SUM(sales) * 100)::NUMERIC, 2) AS profit_margin_percent
FROM orders
GROUP BY product_category
ORDER BY profit_margin_percent DESC;

-- Q3: Who are the top 10 customers by total sales?
SELECT customer_name,
       ROUND(SUM(sales)::NUMERIC,2) AS total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Q4: Which month has the highest sales?
-- Note: order_date is VARCHAR so TO_DATE() used to convert string to date
-- If column were DATE type: EXTRACT(MONTH FROM order_date) would work directly
SELECT EXTRACT(MONTH FROM TO_DATE(order_date, 'DD-MM-YYYY')) AS month,
       ROUND(SUM(sales)::NUMERIC, 2) AS total_sales
FROM orders
GROUP BY month
ORDER BY total_sales DESC;

-- Q5: What is the profit by customer segment?
SELECT customer_segment, 
       ROUND(SUM(profit)::NUMERIC,2) AS total_profit 
FROM orders 
GROUP BY customer_segment 
ORDER BY total_profit DESC;

-- Q6: Why is South making a loss? (profit by category)
SELECT product_category,
       ROUND(SUM(profit)::NUMERIC,2) AS total_profit
FROM orders
WHERE region = 'South'
GROUP BY product_category
ORDER BY total_profit;

-- Q7: Which sub-categories lose the most money in South?
SELECT product_sub_category,
       ROUND(SUM(profit)::NUMERIC,2) AS total_profit
FROM orders
WHERE region = 'South'
GROUP BY product_sub_category
ORDER BY total_profit
LIMIT 5;

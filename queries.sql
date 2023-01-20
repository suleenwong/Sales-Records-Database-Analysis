-- Total number of products
SELECT COUNT(*)
FROM products;

-- Number of products per product line
SELECT productlines.productline, COUNT(*)
FROM products
LEFT JOIN productlines
	ON products.productline = productlines.productline
GROUP BY productlines.productline;

-- Revenue by product line
SELECT 
	productline, 
	SUM(quantityordered*priceeach) AS revenue,
	COUNT(o.*)
FROM products AS p
LEFT JOIN orderdetails AS o
	ON p.productcode = o.productcode
GROUP BY productline;

-- Total cost, revenue and profit of all sales
SELECT 
	products.productcode,
	products.productname,
	SUM(quantityordered*buyprice) AS total_cost,
	SUM(quantityordered*priceeach) AS total_revenue,
	SUM(quantityordered*priceeach)-SUM(quantityordered*buyprice) AS total_profit,
	ROUND(100*(SUM(quantityordered*priceeach)-SUM(quantityordered*buyprice))/SUM(quantityordered*priceeach),2) AS profit_margin
FROM products
LEFT JOIN orderdetails
	ON products.productcode = orderdetails.productcode
GROUP BY products.productcode, products.productname;

-- Average profit margin of all products
SELECT AVG(100*(priceEach-buyprice)/priceEach) AS profit_margin
FROM products
LEFT JOIN orderdetails
	ON products.productcode = orderdetails.productcode;

-- Average revenue per customer
WITH customer_revenue AS (
	SELECT 
		SUM(quantityordered*priceeach) AS revenue,
		SUM(quantityordered*(priceeach-buyprice)) AS profit,
		COUNT(DISTINCT customernumber) AS num_customers
	FROM orders AS o
	INNER JOIN orderdetails AS od
		ON o.orderNumber = od.orderNumber
	INNER JOIN products AS p
		ON od.productcode = p.productcode
)
SELECT 
	revenue/num_customers AS revenue_per_customer,
	profit/num_customers AS profit_per_customer
FROM customer_revenue;

-- Average number of orders per customer
WITH customer_orders AS (
SELECT 
	COUNT(DISTINCT o.ordernumber) AS num_orders,
	COUNT(DISTINCT customernumber) AS num_customers
FROM orders AS o
INNER JOIN orderdetails AS od
	ON o.orderNumber = od.orderNumber
)
SELECT num_orders/num_customers::NUMERIC AS orders_per_customer
FROM customer_orders;

-- Revenue and number of orders by month
SELECT 
	DATE_TRUNC('month',orderdate) AS month,
	COUNT(*) AS num_orders,
	SUM(quantityordered*priceeach) AS revenue
FROM orders
JOIN orderdetails
	ON orders.ordernumber = orderdetails.ordernumber
GROUP BY month
ORDER BY month;

-- Top 5 countries by orders and revenue
SELECT c.country, COUNT(*) AS num_orders, SUM(quantityordered*priceeach) AS revenue
FROM orders AS o
JOIN customers AS c
	ON o.customernumber = c.customernumber
JOIN orderdetails AS od
	ON o.ordernumber = od.ordernumber
GROUP BY c.country
ORDER BY num_orders DESC
LIMIT 5;

-- Number of unique customers and orders per month
SELECT 
	DATE_TRUNC('month',orderdate) AS month,
	COUNT(DISTINCT customers.customernumber),
	COUNT(orders.*)
FROM customers
JOIN orders
	ON customers.customernumber = orders.customernumber
GROUP BY DATE_TRUNC('month',orderdate)
ORDER BY month;

-- Number of new customers per month
WITH payment_with_year_month_table AS (
	SELECT *, 
		   DATE_TRUNC('month', paymentDate) AS year_month
	FROM payments p
),
customers_by_month_table AS (
SELECT 
	p1.year_month, 
	COUNT(*) AS number_of_customers, 
	SUM(p1.amount) AS total
FROM payment_with_year_month_table p1
GROUP BY p1.year_month
ORDER BY p1.year_month
),
new_customers_by_month_table AS (
	SELECT 
		p1.year_month, 
		COUNT(*) AS number_of_new_customers,
		(SELECT number_of_customers FROM customers_by_month_table c WHERE c.year_month = p1.year_month) AS number_of_customers
	FROM payment_with_year_month_table p1
	WHERE p1.customerNumber NOT IN (SELECT customerNumber
									FROM payment_with_year_month_table p2
									WHERE p2.year_month < p1.year_month)
	GROUP BY p1.year_month
)
SELECT *
FROM customers_by_month_table
LEFT JOIN new_customers_by_month_table
ON customers_by_month_table.year_month = new_customers_by_month_table.year_month;


-- Which Products Should We Order More of or Less of?
-- Identify top 10 low stock items
SELECT 
	p.productcode, 
	p.productname,
	p.productline,
	ROUND(100*SUM(o.quantityordered)/p.quantityInStock::NUMERIC,2) AS low_stock
FROM orderdetails AS o
INNER JOIN products AS p
	ON o.productCode = p.productCode
GROUP BY p.productCode, p.productline
ORDER BY low_stock
LIMIT 10;

-- Identify top 10 highest performance products
SELECT 
	productcode,
	SUM(quantityordered*priceeach) AS performance
FROM orderdetails
GROUP BY productcode
ORDER BY performance DESC
LIMIT 10;

-- Priority Products for restocking
WITH low_stock_table AS (
	SELECT p.productcode, 
		   ROUND(SUM(o.quantityordered)/p.quantityInStock::NUMERIC,2) AS low_stock
	FROM orderdetails AS o
	INNER JOIN products AS p
		ON o.productCode = p.productCode
	GROUP BY p.productCode
	ORDER BY low_stock
	LIMIT 10
)
SELECT 
	od.productCode, 
	p.productLine, 
	p.productName,
	SUM(quantityOrdered * priceEach) AS prod_perf
FROM orderdetails AS od
INNER JOIN products AS p
	ON od.productCode = p.productCode
WHERE od.productCode IN (SELECT productCode FROM low_stock_table)
GROUP BY od.productCode, p.productLine, p.productName
ORDER BY prod_perf DESC;


-- How should we match marketing and communication strategies to customer behaviors?
-- Top 5 VIP customers
WITH customerProfit AS (
	SELECT customerNumber, 
		   SUM(quantityordered*(priceeach-buyPrice)) AS profit
	FROM orders AS o
	INNER JOIN orderdetails AS od
		ON o.orderNumber = od.orderNumber
	INNER JOIN products AS p
		ON od.productCode = p.productCode
	GROUP BY customerNumber
	ORDER BY profit DESC
	LIMIT 5
	)
SELECT cp.customerNumber, 
	   cp.profit, 
	   c.customerName,
	   c.contactFirstName,
	   c.contactLastName,
	   c.city, 
	   c.country
FROM customerProfit AS cp
INNER JOIN customers AS c
	ON cp.customerNumber = c.customerNumber
ORDER BY cp.profit;

-- Top 5 less engaged customers
WITH customerProfit AS (
	SELECT customerNumber, 
		   SUM(quantityordered*(priceeach-buyPrice)) AS profit
	FROM orders AS o
	INNER JOIN orderdetails AS od
		ON o.orderNumber = od.orderNumber
	INNER JOIN products AS p
		ON od.productCode = p.productCode
	GROUP BY customerNumber
	ORDER BY profit
	LIMIT 5
	)
SELECT cp.customerNumber, 
	   cp.profit, 
	   c.customerName,
	   c.contactFirstName,
	   c.contactLastName,
	   c.city, 
	   c.country
FROM customerProfit AS cp
INNER JOIN customers AS c
	ON cp.customerNumber = c.customernumber

-- How Much Can We Spend on Acquiring New Customers?
WITH customer_profit AS (
	SELECT 
		customerNumber, 
		SUM(quantityordered*(priceeach-buyPrice)) AS profit
	FROM orders AS o
	INNER JOIN orderdetails AS od
		ON o.orderNumber = od.orderNumber
	INNER JOIN products AS p
		ON od.productCode = p.productCode
	GROUP BY customerNumber
)
SELECT ROUND(AVG(profit)::NUMERIC,2) AS ltv
FROM customer_profit;
ORDER BY customers_by_month_table.year_month;





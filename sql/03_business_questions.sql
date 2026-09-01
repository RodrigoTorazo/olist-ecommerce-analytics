-- ============================================================
-- OLIST E-COMMERCE BUSINESS ANALYSIS
-- ============================================================


-- ============================================================
-- 1. ORDER PERFORMANCE
-- ============================================================

-- Business Question 1:
-- How are orders distributed across different order statuses?
SELECT 
	order_status, 
    COUNT(*)
FROM orders
GROUP BY order_status;

-- Business Question 2:
-- How has the number of orders changed over time?
SELECT 
    YEAR(order_purchase_timestamp) AS year,
    MONTH(order_purchase_timestamp) AS month,
    COUNT(*) AS order_count
FROM orders
GROUP BY year, month
ORDER BY year, month;
	

-- Business Question 3:
-- What percentage of orders were successfully delivered to customers?
SELECT
	SUM(
		CASE WHEN order_status = 'delivered' THEN 1
		ELSE 0
		END
	   ) / COUNT(*) * 100.0 AS delivery_percentage    
FROM orders;

-- ============================================================
-- 2. SALES & REVENUE
-- ============================================================

-- Business Question 4:
-- What is the total revenue generated from product sales?
SELECT
    SUM(price) AS total_product_sales,
    SUM(freight_value) AS total_freight,
    SUM(price + freight_value) AS total_order_value
FROM order_items;

-- Business Question 5A:
-- How has monthly revenue changed over time?
SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    SUM(oi.price) AS total_product_sales,
    SUM(oi.freight_value) AS total_freight,
    SUM(oi.price + oi.freight_value) AS total_order_value
FROM order_items AS oi
JOIN orders AS o
    USING (order_id)
GROUP BY year, month
ORDER BY year, month;

-- Business Question 5B:
-- What was the month-over-month percentage change in total order value?
WITH monthly_sales AS (
    SELECT
        YEAR(o.order_purchase_timestamp) AS year,
        MONTH(o.order_purchase_timestamp) AS month,
        SUM(oi.price) AS total_product_sales,
        SUM(oi.freight_value) AS total_freight,
        SUM(oi.price + oi.freight_value) AS total_order_value
    FROM order_items AS oi
    JOIN orders AS o
        USING (order_id)
    GROUP BY year, month
),

monthly_sales_lag AS (
    SELECT
        year,
        month,
        total_order_value,
        LAG(total_order_value) OVER (
            ORDER BY year, month
        ) AS previous_month
    FROM monthly_sales
)

SELECT
    year,
    month,
    total_order_value,
    previous_month,
    total_order_value - previous_month AS difference,
	ROUND(
    ((total_order_value - previous_month)/previous_month)*100,2) AS month_growth
FROM monthly_sales_lag
ORDER BY year, month;

-- Business Question 6A:
-- What is the average order value, and how does it vary over time?
WITH order_values AS (
    SELECT
        order_id,
        SUM(price) AS order_value
    FROM order_items
    GROUP BY order_id
)

SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    AVG(ov.order_value) AS average_order_value
FROM order_values AS ov
JOIN orders AS o
    USING (order_id)
GROUP BY year, month
ORDER BY year, month;

-- Business Question 6B:
-- How did the average order value change compared with the previous month?

WITH order_values AS (
    SELECT
        order_id,
        SUM(price) AS order_value
    FROM order_items
    GROUP BY order_id
),

monthly_aov AS (
    SELECT 
        YEAR(o.order_purchase_timestamp) AS year,
        MONTH(o.order_purchase_timestamp) AS month,
        AVG(ov.order_value) AS average_order_value
    FROM order_values AS ov
    JOIN orders AS o
        USING (order_id)
    GROUP BY year, month
),

monthly_aov_lag AS (
    SELECT
        year,
        month,
        average_order_value,
        LAG(average_order_value) OVER (
            ORDER BY year, month
        ) AS previous_month
    FROM monthly_aov
)

SELECT
    year,
    month,
    average_order_value,
    previous_month,
    ROUND(average_order_value - previous_month,2) AS aov_difference,
    ROUND(((average_order_value - previous_month)/previous_month)*100,2) AS aov_growth_percentage
FROM monthly_aov_lag
ORDER BY year, month;

-- ============================================================
-- 3. PAYMENTS
-- ============================================================

-- Business Question 7:
-- Which payment methods are most commonly used by customers?
SELECT 
	payment_type,
	COUNT(*) AS number_of_payments
FROM payments
GROUP BY payment_type
ORDER BY number_of_payments DESC;

-- Business Question 8:
-- Which payment methods generate the highest total payment value?
SELECT 
	payment_type,
    SUM(payment_value) AS total_payment
FROM payments
GROUP BY payment_type
ORDER BY total_payment DESC;

-- Business Question 9:
-- How does the number of payment installments relate to order value?
SELECT 
	payment_installments AS installments,
	COUNT(*) AS payments,
    AVG(payment_value) AS avg_payment
FROM payments
GROUP BY payment_installments
ORDER BY payment_installments ASC;


-- ============================================================
-- 4. DELIVERY PERFORMANCE
-- ============================================================

-- Business Question 10:
-- What is the average number of days between purchase and delivery?
SELECT 
	AVG(
		DATEDIFF(
			order_delivered_customer_date,
			order_purchase_timestamp) 
	) AS avg_days_between_purchase_delivery
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- Business Question 11:
-- How often are orders delivered later than the estimated delivery date?
SELECT
	ROUND(
		(SUM(
		CASE WHEN order_delivered_customer_date > order_estimated_delivery_date
        THEN 1
        ELSE 0
        END
		) / COUNT(*)) * 100.0, 2) AS late_delivery_percentage
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
AND order_estimated_delivery_date IS NOT NULL;

-- Business Question 12:
-- Which Brazilian states have the longest average delivery times?
SELECT
	c.customer_state,
	ROUND(	
        AVG(
			DATEDIFF(
				o.order_delivered_customer_date,
				o.order_purchase_timestamp)) ,
	2) AS avg_delivery_time
FROM orders AS o
JOIN customers AS c
USING (customer_id)
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_time DESC;

-- ============================================================
-- 5. CUSTOMERS & GEOGRAPHY
-- ============================================================

-- Business Question 13:
-- Which Brazilian states have the highest number of customers?
SELECT
	customer_state,
    COUNT(*) AS number_of_customers
FROM customers
GROUP BY customer_state
ORDER BY number_of_customers DESC;

-- Business Question 14:
-- Which Brazilian states generate the highest total sales revenue?
SELECT
	c.customer_state,
    SUM(oi.price) AS total_sales_revenue
FROM customers AS c
JOIN orders AS o
USING (customer_id)
JOIN order_items AS oi
USING (order_id)
GROUP BY c.customer_state
ORDER BY total_sales_revenue DESC;

-- Business Question 15:
-- Which states have the highest average order value?
WITH total_order_value AS (
SELECT
	order_id,
	SUM(price) AS order_value
FROM order_items
GROUP BY order_id
)

SELECT 
	c.customer_state,
    AVG(order_value) as avg_order_value
FROM total_order_value
JOIN orders AS o
USING (order_id)
JOIN customers AS c
USING (customer_id)
GROUP BY customer_state
ORDER BY avg_order_value DESC;

-- ============================================================
-- 6. PRODUCT CATEGORIES
-- ============================================================

-- Business Question 16:
-- Which product categories generate the highest total sales revenue?
SELECT
    ct.product_category_name_english,
    SUM(oi.price) AS total_sales_revenue
FROM products AS p
JOIN order_items AS oi
USING (product_id)
JOIN category_translation AS ct
USING (product_category_name)
GROUP BY ct.product_category_name_english
ORDER BY total_sales_revenue DESC;

-- Business Question 17:
-- Which product categories have the highest number of items sold?
SELECT 
	ct.product_category_name_english,
    COUNT(*) AS number_of_items_sold
FROM products AS p
JOIN order_items AS oi
USING (product_id)
JOIN category_translation AS ct
USING (product_category_name)
GROUP BY ct.product_category_name_english
ORDER BY number_of_items_sold DESC;

-- Business Question 18:
-- Which product categories have the highest average product prices?
SELECT 
	ct.product_category_name_english,
    ROUND(
		AVG(oi.price),
	2) AS average_product_price
FROM products AS p
JOIN order_items AS oi
USING (product_id)
JOIN category_translation AS ct
USING (product_category_name)
GROUP BY ct.product_category_name_english
ORDER BY average_product_price DESC;


-- ============================================================
-- 7. REVIEWS & CUSTOMER SATISFACTION
-- ============================================================

-- Business Question 19:
-- How are customer review scores distributed across the marketplace?
SELECT
	review_score,
    COUNT(*) AS reviews_number
FROM reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- Business Question 20:
-- Which product categories have the highest and lowest average review scores?
WITH category_reviews AS (
    SELECT 
        ct.product_category_name_english,
        AVG(r.review_score) AS avg_review
    FROM products AS p
    JOIN order_items AS oi
        USING (product_id)
    JOIN reviews AS r
        USING (order_id)
	JOIN category_translation AS ct
		USING (product_category_name)
    GROUP BY ct.product_category_name_english
)

SELECT
    product_category_name_english,
    avg_review
FROM category_reviews
WHERE avg_review = (
    SELECT MAX(avg_review)
    FROM category_reviews
)
OR avg_review = (
    SELECT MIN(avg_review)
    FROM category_reviews
);
    

-- Business Question 21:
-- Is there a relationship between delivery performance and customer review scores?
WITH delivery_status AS (
    SELECT
        order_id,
        CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date
                THEN 'Late'
            ELSE 'On Time'
        END AS delivery_performance
    FROM orders
    WHERE order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
)

SELECT 
    ds.delivery_performance,
    AVG(r.review_score) AS avg_review_score
FROM delivery_status AS ds
JOIN reviews AS r
    USING (order_id)
GROUP BY ds.delivery_performance;

-- ============================================================
-- 8. SELLERS
-- ============================================================

-- Business Question 22:
-- Which sellers generate the highest total sales revenue?
SELECT
	seller_id,
    SUM(price) AS total_revenue
FROM order_items
GROUP BY seller_id
ORDER BY total_revenue DESC;

-- Business Question 23:
-- Which sellers sell the highest number of products?
SELECT
	seller_id,
    COUNT(*) AS number_of_items_sold
FROM order_items
GROUP BY seller_id
ORDER BY number_of_items_sold DESC;

-- Business Question 24:
-- Which sellers have the highest average customer review scores,
-- considering sellers with a sufficient number of reviews (>=10)?
SELECT 
	oi.seller_id,
    AVG(r.review_score) AS avg_review_score,
    COUNT(r.review_id) AS number_of_reviews
FROM reviews AS r
JOIN order_items AS oi
USING (order_id)
GROUP BY oi.seller_id
HAVING COUNT(review_id) >=10
ORDER BY avg_review_score DESC;


-- ============================================================
-- 9. ADVANCED BUSINESS ANALYSIS
-- ============================================================

-- Business Question 25:
-- How concentrated is Olist's revenue among its top 5 product categories?
WITH total_revenue AS (
    SELECT 
        ct.product_category_name_english,
        SUM(oi.price) AS total_revenue_sales
    FROM order_items AS oi
    JOIN products AS p
        USING (product_id)
    JOIN category_translation AS ct
        USING (product_category_name)
    GROUP BY ct.product_category_name_english
),

top_5_revenue AS (
    SELECT 
        product_category_name_english,
        total_revenue_sales AS top_5_revenue
    FROM total_revenue
    ORDER BY total_revenue_sales DESC
    LIMIT 5
)

SELECT 
    ROUND(
        (SELECT SUM(top_5_revenue)
         FROM top_5_revenue)
        /
        (SELECT SUM(total_revenue_sales)
         FROM total_revenue) * 100,
        2
    ) AS top_5_revenue_percentage;

    
-- Business Question 26:
-- What percentage of payments are considered high-value transactions (>1000),
-- and how much revenue do they represent?
WITH high_value_payments AS (
    SELECT
        payment_value
    FROM payments
    WHERE payment_value > 1000
)

SELECT
    ROUND(
        (SELECT COUNT(*)
         FROM high_value_payments)
        /
        (SELECT COUNT(*)
         FROM payments) * 100, 2
    ) AS high_value_payment_percentage,

    ROUND(
        (SELECT SUM(payment_value)
         FROM high_value_payments)
        /
        (SELECT SUM(payment_value)
         FROM payments) * 100, 2
    ) AS high_value_revenue_percentage;

-- Business Question 27:
-- Which states combine high sales volume (above state's average) with strong customer satisfaction (>=4)?
WITH customer_state AS (
	SELECT
		c.customer_state,
		SUM(oi.price) AS total_sales,
		AVG(r.review_score) AS avg_review_score
	FROM order_items AS oi
	JOIN orders AS o
	USING (order_id)
	JOIN reviews AS r
	USING (order_id)
	JOIN customers AS c
	USING (customer_id)
	GROUP BY c.customer_state
)

SELECT
	customer_state,
    total_sales,
    avg_review_score
FROM customer_state
WHERE total_sales > (
					SELECT 
						AVG(total_sales)
					FROM customer_state
                    )
AND avg_review_score >= 4
ORDER BY total_sales DESC;
	

-- Business Question 28:
-- Which product categories combine high sales volume,
-- strong revenue, and high customer satisfaction?

WITH category_performance AS (
    SELECT
        ct.product_category_name_english,
        SUM(oi.price) AS total_sales,
        AVG(r.review_score) AS avg_review_score,
        COUNT(*) AS items_sold
    FROM order_items AS oi
    JOIN orders AS o
        USING (order_id)
    JOIN reviews AS r
        USING (order_id)
    JOIN products AS p
        USING (product_id)
    JOIN category_translation AS ct
        USING (product_category_name)
    GROUP BY ct.product_category_name_english
)

SELECT
    product_category_name_english,
    total_sales,
    avg_review_score,
    items_sold
FROM category_performance
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM category_performance
)
AND avg_review_score >= 4
AND items_sold > (
    SELECT AVG(items_sold)
    FROM category_performance
)
ORDER BY total_sales DESC;
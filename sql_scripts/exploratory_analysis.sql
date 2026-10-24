USE ecommerce_analytics;

-- 1. Total Revenue Generated Overall
SELECT SUM(o.quantity * p.unit_price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id;


-- 2. Total Orders and Revenue by Product Category
SELECT 
    p.category,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS units_sold,
    SUM(o.quantity * p.unit_price) AS category_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- 3. Top 5 Customers by Total Spending
SELECT 
    c.first_name,
    c.last_name,
    c.city,
    SUM(o.quantity * p.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY total_spent DESC
LIMIT 5;
-- ============================================================
-- FILE: exploratory_analysis.sql
-- Description: High-level database profiling and exploratory checks 
--             to evaluate total revenue, category performance, and top spenders.
-- ============================================================

USE ecommerce_analytics;

-- ============================================================
-- QUERY 1: Total Revenue Generated Overall
-- Business Goal: Establish the core baseline metric for total business performance.
-- Insight: Multiplies quantity ordered by unit price across all joined orders 
--          to calculate gross cumulative revenue.
-- ============================================================
SELECT SUM(o.quantity * p.unit_price) AS total_revenue
FROM orders AS o
JOIN products AS p 
    ON o.product_id = p.product_id;


-- ============================================================
-- QUERY 2: Total Orders and Revenue by Product Category
-- Business Goal: Assess order volume and financial weight across product departments.
-- Insight: Aggregates total orders, units sold, and revenue per category, 
--          ranking them from highest to lowest revenue contribution.
-- ============================================================
SELECT 
    p.category,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS units_sold,
    SUM(o.quantity * p.unit_price) AS category_revenue
FROM orders AS o
JOIN products AS p 
    ON o.product_id = p.product_id
GROUP BY 
    p.category
ORDER BY 
    category_revenue DESC;


-- ============================================================
-- QUERY 3: Top 5 Customers by Total Spending
-- Business Goal: Quickly identify the top 5 highest-value customers (whales) 
--               driving the majority of sales volume.
-- Insight: Joins customer demographics with orders and products, computes 
--          cumulative spending, and limits the output to the top 5 records.
-- ============================================================
SELECT 
    c.first_name,
    c.last_name,
    c.city,
    SUM(o.quantity * p.unit_price) AS total_spent
FROM customers AS c
JOIN orders AS o 
    ON c.customer_id = o.customer_id
JOIN products AS p 
    ON o.product_id = p.product_id
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    c.city
ORDER BY 
    total_spent DESC
LIMIT 5;
-- ============================================================
-- QUERY 1: Regional Customer Segmentation
-- Business Goal: Identify customers located in Bangalore for targeted local promotions.
-- Insight: Filters customer database specifically for active buyers based in Bangalore.
-- ============================================================
SELECT first_name 
FROM customers 
WHERE city = 'Bangalore';


-- ============================================================
-- QUERY 2: Product Catalog & Category Pricing Filter
-- Business Goal: Retrieve all high-tech products and their listing prices under Electronics.
-- Insight: Provides pricing visibility across the Electronics product segment.
-- ============================================================
SELECT product_name, unit_price 
FROM products 
WHERE category = 'Electronics';


-- ============================================================
-- QUERY 3: Product Sales Volume Performance
-- Business Goal: Aggregate total order quantities across orders to identify top-selling items.
-- Insight: Measures overall product demand by joining transactional orders with product catalog.
-- ============================================================
SELECT p.product_name, SUM(o.quantity) AS total_quantity_sold
FROM orders o 
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name;


-- ============================================================
-- QUERY 4: VIP Customer Spending Threshold (`HAVING` Clause)
-- Business Goal: Identify high-value VIP customers who have spent more than ₹10,000.
-- Insight: Combines customer, order, and product data, aggregates total spending, 
--          and uses HAVING to filter post-aggregation for loyalty rewards programs.
-- ============================================================
SELECT 
    c.first_name, 
    c.last_name, 
    SUM(o.quantity * p.unit_price) AS total_spent
FROM customers AS c 
JOIN orders AS o 
    ON c.customer_id = o.customer_id
JOIN products AS p 
    ON o.product_id = p.product_id
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name
HAVING 
    SUM(o.quantity * p.unit_price) > 10000;

-- ============================================================
-- QUERY 5: Top-Selling Product Categories by Revenue
-- Business Goal: Determine which product categories generate the highest total revenue
--               to help the merchandising team allocate next quarter's marketing budget.
-- Insight: Joins orders with products, aggregates total revenue per category, 
--          and sorts in descending order to highlight top-performing departments.
-- ============================================================
SELECT 
    p.category, 
    SUM(o.quantity * p.unit_price) AS total_revenue
FROM orders AS o 
JOIN products AS p 
    ON o.product_id = p.product_id
GROUP BY 
    p.category
ORDER BY 
    total_revenue DESC;


-- ============================================================
-- QUERY 6: Repeat Customer Frequency & Spending Analysis
-- Business Goal: Identify repeat buyers (customers with 2 or more orders) 
--               and evaluate their total financial contribution for retention strategy.
-- Insight: Aggregates order count and total spend per customer, filtering for high-frequency 
--          buyers via HAVING count >= 2, and ranks them by overall spending.
-- ============================================================
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(o.order_id) AS total_orders, 
    SUM(o.quantity * p.unit_price) AS total_spend
FROM customers AS c
JOIN orders AS o 
    ON c.customer_id = o.customer_id
JOIN products AS p 
    ON o.product_id = p.product_id
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name
HAVING 
    COUNT(o.order_id) >= 2
ORDER BY 
    total_spend DESC;


-- ============================================================
-- QUERY 7: Monthly Sales Revenue Trend
-- Business Goal: Track revenue growth over time to analyze monthly sales 
--               trends and identify peak seasonal performance periods.
-- Insight: Extracts year-and-month from order dates using DATE_FORMAT, 
--          aggregates revenue via multi-table join, and sorts chronologically.
-- ============================================================
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    SUM(o.quantity * p.unit_price) AS total_monthly_revenue
FROM orders AS o
JOIN products AS p 
    ON o.product_id = p.product_id
GROUP BY 
    order_month
ORDER BY 
    order_month ASC;

-- ============================================================
-- QUERY 8: Unsold Inventory Analysis (LEFT JOIN Anti-Join)
-- Business Goal: Identify products that have zero order history to help 
--               inventory management decide on clearance sales or discontinuation.
-- Insight: Uses a LEFT JOIN from products to orders and filters for NULL order IDs 
--          to isolate inactive inventory items.
-- ============================================================
SELECT 
    p.product_id, 
    p.product_name 
FROM products AS p
LEFT JOIN orders AS o
    ON p.product_id = o.product_id
WHERE 
    o.order_id IS NULL;

-- ============================================================
-- QUERY 9: Average Order Value (AOV) per Customer
-- Business Goal: Analyze customer purchasing power by calculating the 
--               average monetary value per transaction for each buyer.
-- Insight: Joins customer, order, and product data, computes the average 
--          spend per order using AVG(), and ranks customers by purchasing scale.
-- ============================================================
SELECT 
    c.customer_id,
    c.first_name, 
    c.last_name, 
    AVG(o.quantity * p.unit_price) AS avg_order_value
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name
ORDER BY 
    avg_order_value DESC;



-- ============================================================
-- QUERY 10: Customer Spending Rank (Window Function)
-- Business Goal: Generate a competitive ranking of all customers based on their 
--               lifetime spending to identify top-tier clients for VIP outreach.
-- Insight: Uses a subquery to aggregate total spend per customer and applies 
--          the DENSE_RANK() window function to rank customers without skipping numbers.
-- ============================================================
SELECT 
    customer_spending.first_name, 
    customer_spending.last_name, 
    customer_spending.total_spent, 
    DENSE_RANK() OVER (ORDER BY customer_spending.total_spent DESC) AS spending_rank
FROM (
    SELECT 
        c.first_name, 
        c.last_name, 
        SUM(o.quantity * p.unit_price) AS total_spent
    FROM customers AS c
    JOIN orders AS o 
        ON c.customer_id = o.customer_id
    JOIN products AS p 
        ON o.product_id = p.product_id
    GROUP BY 
        c.first_name, 
        c.last_name
) AS customer_spending;
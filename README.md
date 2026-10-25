# 🛒 E-Commerce Data Analytics & Business Insights (MySQL)

## 📌 Project Overview
This repository contains an end-to-end SQL analytics project designed to simulate real-world e-commerce data operations. The goal of this project is to model transactional data, write production-grade MySQL queries, and translate raw retail data into actionable business intelligence across customer behavior, sales trends, and inventory performance.

---

## 🏗️ Relational Database Architecture
The project is built on a relational MySQL database (`ecommerce_analytics`) featuring three core entities:
* **`customers`**: Demographic data (Customer ID, Name, Email, City).
* **`products`**: Inventory catalog (Product ID, Name, Category, Unit Price).
* **`orders`**: Transactional order records (Order ID, Customer ID, Product ID, Order Date, Quantity).

---

## 📊 Core Business Queries & Key Analytical Insights

### Exploratory Data Analysis (`sql_scripts/exploratory_analysis.sql`)
* **Total Revenue Generation**: Established overall gross cumulative revenue baseline.
* **Category Performance Breakdown**: Evaluated total orders, units sold, and revenue contribution per product department.
* **Top Spenders Identification**: Filtered top-tier "whale" customers driving maximum sales volume using `LIMIT 5`.

### Advanced Business Analytics (`sql_scripts/analysis.sql`)
1. **Regional Demographics (`WHERE`)**: Filtered customer distributions across major cities to target localized marketing campaigns.
2. **Category Cataloging (`WHERE`)**: Isolated performance metrics within key departments.
3. **Product Sales Volume (`JOIN`, `GROUP BY`)**: Aggregated units sold per product to identify core revenue drivers.
4. **VIP Customer Loyalty Threshold (`HAVING`)**: Identified high-value buyers spending above target thresholds to support retention programs.
5. **Top-Selling Categories by Revenue (`ORDER BY`)**: Ranked product categories by total revenue generation.
6. **Repeat Customer Frequency (`HAVING COUNT()`)**: Isolated customers placing 2 or more orders to analyze purchasing cadence.
7. **Monthly Sales Revenue Trend (`DATE_FORMAT`)**: Formatted transaction dates into monthly buckets to evaluate chronological sales growth.
8. **Unsold Inventory Analysis (`LEFT JOIN Anti-Join`)**: Identified products with zero historical orders (`IS NULL`) for clearance strategy or discontinuation.
9. **Average Order Value (AOV) per Customer (`AVG()`)**: Calculated spending density per order to evaluate customer purchasing power.
10. **Customer Lifetime Rank (`DENSE_RANK() Window Function`)**: Applied advanced window functions to competitively rank customers based on lifetime spend without collapsing row data.

---

## 🚀 How to Run the Project
1. Clone this repository:
   ```bash
   git clone [https://github.com/sureshshivaramu/ecommerce-analytics.git](https://github.com/sureshshivaramu/ecommerce-analytics.git)
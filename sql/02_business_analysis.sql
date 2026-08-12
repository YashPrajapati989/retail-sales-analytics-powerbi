-- =====================================================
-- Retail Customer Analytics - Business Analysis
-- =====================================================

-- =====================================================
-- Query 1: Executive KPI Summary
-- =====================================================

SELECT
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(revenue) AS total_revenue,
    AVG(revenue) AS avg_transaction_value
FROM fact_sales;


-- =====================================================
-- Query 2: Monthly Revenue Trend
-- =====================================================

SELECT
    DATE_TRUNC('month', invoice_date) AS month,
    ROUND(SUM(revenue)::numeric,2) AS monthly_revenue
FROM fact_sales
GROUP BY month
ORDER BY month;


-- =====================================================
-- Query 3: Top 10 Countries by Revenue
-- =====================================================

SELECT
    country,
    ROUND(SUM(revenue)::numeric,2) AS total_revenue
FROM fact_sales
GROUP BY country
ORDER BY total_revenue DESC
LIMIT 10;


-- =====================================================
-- Query 4: Top 10 Customers by Revenue
-- =====================================================

SELECT
    customer_id,
    ROUND(SUM(revenue)::numeric,2) AS customer_revenue
FROM fact_sales
GROUP BY customer_id
ORDER BY customer_revenue DESC
LIMIT 10;


-- =====================================================
-- Query 5: Top 10 Products by Revenue
-- =====================================================

SELECT
    description,
    ROUND(SUM(revenue)::numeric,2) AS product_revenue
FROM fact_sales
GROUP BY description
ORDER BY product_revenue DESC
LIMIT 10;


-- =====================================================
-- Query 6: Revenue by Customer Segment
-- =====================================================

SELECT
    dc.segment,
    COUNT(DISTINCT dc.customer_id) AS customers,
    ROUND(SUM(dc.monetary)::numeric,2) AS segment_revenue,
    ROUND(AVG(dc.monetary)::numeric,2) AS avg_customer_value
FROM dim_customer dc
GROUP BY dc.segment
ORDER BY segment_revenue DESC;


-- =====================================================
-- Query 7: Segment Contribution %
-- =====================================================

SELECT
    segment,
    ROUND(
        SUM(monetary) * 100.0 /
        SUM(SUM(monetary)) OVER (),
        2
    ) AS revenue_percentage
FROM dim_customer
GROUP BY segment
ORDER BY revenue_percentage DESC;


-- =====================================================
-- Query 8: Average Order Value by Country
-- =====================================================

SELECT
    country,
    ROUND(
        SUM(revenue) /
        COUNT(DISTINCT invoice_no),
        2
    ) AS avg_order_value
FROM fact_sales
GROUP BY country
ORDER BY avg_order_value DESC;


-- =====================================================
-- Query 9: Repeat Customers
-- =====================================================

SELECT
    COUNT(*) AS repeat_customers
FROM dim_customer
WHERE frequency > 1;


-- =====================================================
-- Query 10: Customer Lifetime Value
-- =====================================================

SELECT
    customer_id,
    frequency,
    ROUND(monetary::numeric,2) AS lifetime_value,
    segment
FROM dim_customer
ORDER BY monetary DESC
LIMIT 20;
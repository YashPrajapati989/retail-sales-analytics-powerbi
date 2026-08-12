-- =====================================================
-- Retail Customer Analytics - SQL Views
-- =====================================================

-- =====================================================
-- View 1: Monthly Revenue
-- =====================================================

CREATE OR REPLACE VIEW vw_monthly_revenue AS

SELECT
    DATE_TRUNC('month', invoice_date) AS month,
    COUNT(DISTINCT invoice_no) AS total_orders,
    ROUND(SUM(revenue)::numeric,2) AS total_revenue
FROM fact_sales
GROUP BY month
ORDER BY month;


-- =====================================================
-- View 2: Country Performance
-- =====================================================

CREATE OR REPLACE VIEW vw_country_performance AS

SELECT
    country,
    COUNT(DISTINCT customer_id) AS customers,
    COUNT(DISTINCT invoice_no) AS orders,
    ROUND(SUM(revenue)::numeric,2) AS revenue
FROM fact_sales
GROUP BY country;


-- =====================================================
-- View 3: Product Performance
-- =====================================================

CREATE OR REPLACE VIEW vw_product_performance AS

SELECT
    stock_code,
    description,
    SUM(quantity) AS quantity_sold,
    ROUND(SUM(revenue)::numeric,2) AS revenue
FROM fact_sales
GROUP BY
    stock_code,
    description;


-- =====================================================
-- View 4: Top Customers
-- =====================================================

CREATE OR REPLACE VIEW vw_top_customers AS

SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS orders,
    ROUND(SUM(revenue)::numeric,2) AS revenue
FROM fact_sales
GROUP BY customer_id;


-- =====================================================
-- View 5: Customer Segments
-- =====================================================

CREATE OR REPLACE VIEW vw_customer_segments AS

SELECT
    segment,
    COUNT(*) AS customers,
    ROUND(SUM(monetary)::numeric,2) AS revenue,
    ROUND(AVG(monetary)::numeric,2) AS avg_customer_value
FROM dim_customer
GROUP BY segment;


-- =====================================================
-- View 6: Customer Lifetime Value
-- =====================================================

CREATE OR REPLACE VIEW vw_customer_ltv AS

SELECT
    customer_id,
    segment,
    frequency,
    ROUND(monetary::numeric,2) AS lifetime_value
FROM dim_customer;


-- =====================================================
-- View 7: Executive KPI Summary
-- =====================================================

CREATE OR REPLACE VIEW vw_executive_summary AS

SELECT
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(revenue)::numeric,2) AS total_revenue,
    ROUND(
        SUM(revenue) /
        COUNT(DISTINCT invoice_no),
        2
    ) AS average_order_value
FROM fact_sales;
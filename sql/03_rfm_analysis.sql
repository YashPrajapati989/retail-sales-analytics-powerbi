-- =====================================================
-- Retail Customer Analytics - RFM Analysis
-- =====================================================

-- =====================================================
-- Query 1: Customer Segment Distribution
-- =====================================================

SELECT
    segment,
    COUNT(*) AS customers
FROM dim_customer
GROUP BY segment
ORDER BY customers DESC;


-- =====================================================
-- Query 2: Revenue by Segment
-- =====================================================

SELECT
    segment,
    ROUND(SUM(monetary)::numeric,2) AS revenue
FROM dim_customer
GROUP BY segment
ORDER BY revenue DESC;


-- =====================================================
-- Query 3: Revenue Contribution %
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
-- Query 4: Average Customer Value by Segment
-- =====================================================

SELECT
    segment,
    ROUND(AVG(monetary)::numeric,2) AS avg_customer_value
FROM dim_customer
GROUP BY segment
ORDER BY avg_customer_value DESC;


-- =====================================================
-- Query 5: Champions Segment Analysis
-- =====================================================

SELECT
    COUNT(*) AS champion_customers,
    ROUND(SUM(monetary)::numeric,2) AS champion_revenue,
    ROUND(AVG(monetary)::numeric,2) AS avg_champion_value
FROM dim_customer
WHERE segment = 'Champions';


-- =====================================================
-- Query 6: Loyal Customers Analysis
-- =====================================================

SELECT
    COUNT(*) AS loyal_customers,
    ROUND(SUM(monetary)::numeric,2) AS loyal_revenue,
    ROUND(AVG(monetary)::numeric,2) AS avg_loyal_value
FROM dim_customer
WHERE segment = 'Loyal Customers';


-- =====================================================
-- Query 7: Potential Loyalists Opportunity
-- =====================================================

SELECT
    COUNT(*) AS potential_customers,
    ROUND(SUM(monetary)::numeric,2) AS potential_revenue,
    ROUND(AVG(monetary)::numeric,2) AS avg_potential_value
FROM dim_customer
WHERE segment = 'Potential Loyalists';


-- =====================================================
-- Query 8: At Risk Customers
-- =====================================================

SELECT
    customer_id,
    recency,
    frequency,
    ROUND(monetary::numeric,2) AS monetary
FROM dim_customer
WHERE segment = 'At Risk'
ORDER BY monetary DESC
LIMIT 20;


-- =====================================================
-- Query 9: Lost Customers
-- =====================================================

SELECT
    customer_id,
    recency,
    frequency,
    ROUND(monetary::numeric,2) AS monetary
FROM dim_customer
WHERE segment = 'Lost Customers'
ORDER BY monetary DESC
LIMIT 20;


-- =====================================================
-- Query 10: Top 20 Highest Value Customers
-- =====================================================

SELECT
    customer_id,
    segment,
    frequency,
    ROUND(monetary::numeric,2) AS customer_value
FROM dim_customer
ORDER BY monetary DESC
LIMIT 20;


-- =====================================================
-- Query 11: Segment Ranking
-- =====================================================

SELECT
    segment,
    COUNT(*) AS customers,
    ROUND(SUM(monetary)::numeric,2) AS revenue,
    ROUND(AVG(monetary)::numeric,2) AS avg_value
FROM dim_customer
GROUP BY segment
ORDER BY revenue DESC;


-- =====================================================
-- Query 12: Customer Retention Opportunity
-- =====================================================

SELECT
    COUNT(*) AS customers_to_recover,
    ROUND(SUM(monetary)::numeric,2) AS recoverable_revenue
FROM dim_customer
WHERE segment IN ('At Risk','Lost Customers');
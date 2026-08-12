DROP TABLE fact_sales;

CREATE TABLE fact_sales (
    invoice_no VARCHAR(20),
    stock_code VARCHAR(50),
    description TEXT,
    quantity INT,
    invoice_date TIMESTAMP,
    unit_price NUMERIC(12,2),
    customer_id BIGINT,
    country VARCHAR(100),
    revenue NUMERIC(14,2)
);


SELECT COUNT(*)
FROM fact_sales;


SELECT *
FROM fact_sales
LIMIT 5;


-- Dim Customer
DROP TABLE dim_customer;

CREATE TABLE dim_customer (
    customer_id BIGINT PRIMARY KEY,
    recency INT,
    frequency INT,
    monetary NUMERIC(14,2),
    r_score INT,
    f_score INT,
    m_score INT,
    rfm_score VARCHAR(10),
    segment VARCHAR(50)
);



CREATE TABLE dim_product (
    stock_code VARCHAR(50) PRIMARY KEY,
    description TEXT
);

Select * from dim_product;

INSERT INTO dim_product
SELECT
    stock_code,
    MIN(description) AS description
FROM fact_sales
GROUP BY stock_code;

TRUNCATE TABLE dim_product;
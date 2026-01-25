CREATE VIEW detailed_order_analysis AS
SELECT 
    o.order_id,
    o.customer_id,
    c.customer_state,
    c.customer_city,
    o.order_status,
    o.order_purchase_timestamp,
    DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) AS delivery_vs_estimated,
    DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) AS actual_delivery_days,
    oi.price,
    oi.freight_value,
    p.product_id,
    pt.product_category_name_english AS category,
    odr.review_score AS score,
    odr.review_creation_date
    
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN order_reviews odr ON oi.order_id = odr.order_id
JOIN category_name_translation pt ON p.product_category_name = pt.product_category_name
WHERE o.order_status = 'delivered';

SELECT customer_state, SUM(price) as total_sales
 FROM detailed_order_analysis
 GROUP BY 1
 ORDER BY 2 DESC;
 
 SELECT payment_type, COUNT(*) 
FROM order_payments
GROUP BY 1;            -- people tend to prefer using credit cards for payments

SELECT Count(review_score)
FROM order_reviews
WHERE review_score < 2; -- 11424 scores below 2 (11.51%)

SELECT Count(review_score)
FROM order_reviews
WHERE review_score < 3; -- 14575 scores below 3 (14.68%)

SELECT COUNT(*)
FROM order_reviews;  -- 99223 Total reviews out of which 14.68% have poor(2) or very poor(1) reviews that is 1/7th of the reviews. 

-- cannot suggest a diagnostic analysis and it is limited to descriptive analysis due to the data not having reviews correlated with product_id. 
-- could try plotting graphs to see how the trend for a product in terms of reviews. For example a sudden surge in negative reviews when a supplier changed can help diagnose the issue.

SELECT COUNT(order_status)
FROM orders;  -- Total orders = 99441

SELECT COUNT(*)
FROM orders
WHERE order_status = 'Delivered'  -- 96478 orders delivered (97.02%)
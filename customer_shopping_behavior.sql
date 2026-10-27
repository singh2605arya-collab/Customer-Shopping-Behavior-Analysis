create database customer_behavior;
use customer_behavior;
SELECT * FROM customer_data
LIMIT 10;

-- total revenue genrated by male and female customer 

SELECT
    gender,
    SUM(`purchase_amount_(usd)`) AS revenue
FROM customer_data
GROUP BY gender;

-- WHICH CUSTOMER APPLIED DISCOUNT BUT SPENT MORE THAN ABG PURCHASE AMOUNT 
SELECT
    customer_id,
    `purchase_amount_(usd)`
FROM customer_data
WHERE discount_applied = 'Yes'
  AND `purchase_amount_(usd)` >= (
      SELECT AVG(`purchase_amount_(usd)`)
      FROM customer_data
  );
  
-- top 5 products by reviwe ratings
Select item_purchased ,round(AVG(review_rating),2)as "PURCHASE REVIEW RATING"
FROM customer_data
group by item_purchased
order by avg(review_rating) desc 
limit 5 ;


-- Q4. Compare the average Purchase Amounts between Standard and Express Shipping.

SELECT
    shipping_type,
    ROUND(AVG(`purchase_amount_(usd)`), 2) AS average_purchase_amount
FROM customer_data
WHERE shipping_type IN ('Standard', 'Express')
GROUP BY shipping_type;
 
 --  Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?
SELECT subscription_status,
       COUNT(customer_id) AS repeat_buyers
FROM customer_data
WHERE previous_purchases > 5
GROUP BY subscription_status;

-- . What is the revenue contribution of each age group? 
SELECT 
    age_group,
    SUM('purchase_amount_(usd)') AS total_revenue
FROM customer_data
GROUP BY age_group
ORDER BY total_revenue desc;
 
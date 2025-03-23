-- How many transactions have been done by each gender?
SELECT 
    customer_info.gender,
    COUNT(sales.order_id) AS total_transaction
FROM
    customer_info
        JOIN
    sales ON sales.customer_id = customer_info.customer_id
GROUP BY customer_info.gender;

-- How many customers have placed an order from more than one store?
SELECT 
    COUNT(DISTINCT customer_id) AS customer_count, store_id
FROM
    sales
GROUP BY customer_id
HAVING COUNT(DISTINCT store_id > 1);

-- Which city has the highest number of orders?
SELECT 
    branch_details.city, COUNT(sales.order_id) AS num_of_orders
FROM
    branch_details
        JOIN
    sales ON branch_details.store_id = sales.store_id
GROUP BY city
ORDER BY num_of_orders DESC
LIMIT 1;

-- Which area has the highest sales?
SELECT
    bd.state,
    SUM(opm.quantity_ordered * pi.sale_price) AS TotalSales
FROM
    sales s
JOIN
    branch_details bd ON s.store_id = bd.store_id
JOIN
    order_product_maping opm ON s.order_id = opm.order_id
JOIN
    product_info pi ON opm.product_id = pi.product_id
GROUP BY
    bd.state
ORDER BY
    TotalSales DESC
LIMIT 1;

-- Which state has the highest number of customers?
SELECT 
    branch_details.state,
    SUM(sales.customer_id) AS highest_num_customer
FROM
    branch_details
        JOIN
    sales ON branch_details.store_id = sales.store_id
GROUP BY branch_details.state
ORDER BY highest_num_customer DESC
LIMIT 1;

-- SELECT
-- 	division, 
--     s.product_code,
--     product,
--     SUM(sold_quantity) as total_sales
-- FROM fact_sales_monthly s
-- JOIN dim_product p ON s.product_code = p.product_code
-- Where fiscal_year = 2021
-- GROUP BY division,s.product_code,product;


with cte1 as(
SELECT
	division, 
	s.product_code,
	product,
	SUM(sold_quantity) as total_sales
FROM fact_sales_monthly s
JOIN dim_product p ON s.product_code = p.product_code
Where fiscal_year = 2021
GROUP BY division,s.product_code,product
),
cte2 as(
SELECT
	*,
    rank() over(partition by division order by total_sales desc) as rank_num
FROM cte1)
SELECT
	*
FROM cte2
WHERE rank_num <=3;
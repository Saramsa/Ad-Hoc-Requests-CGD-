with cte1 as 
(SELECT
	customer_code,
	segment,
	COUNT(distinct(s.product_code)) as product_count_2020
from dim_product d
JOIN fact_sales_monthly s ON
d.product_code = s.product_code
WHERE s.fiscal_year = 2020
GROUP BY segment
order by product_count_2020 DESC),
cte2 as 
(SELECT
	customer_code,
	segment,
	COUNT(distinct(s.product_code)) as product_count_2021
from dim_product d
JOIN fact_sales_monthly s ON
d.product_code = s.product_code
WHERE s.fiscal_year = 2021
GROUP BY segment
order by product_count_2021 DESC)
SELECT
	c1.segment,
    c2.product_count_2021,
    c1.product_count_2020,
    (c2.product_count_2021-c1.product_count_2020) as difference
FROM cte1 c1
JOIN cte2 c2 ON
c1.segment = c2.segment
ORDER BY difference DESC;

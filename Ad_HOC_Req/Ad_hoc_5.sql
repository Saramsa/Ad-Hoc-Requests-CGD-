with cte1 as (SELECT
	d.product_code,
    d.product,
    round(SUM(m.manufacturing_cost),2) as Total_man_cost
from dim_product d
JOIN fact_manufacturing_cost m ON
d.product_code = m.product_code
GROUP BY d.product_code,d.product)
SELECT
	*
from cte1 
WHERE Total_man_cost in (SELECT MIN(Total_man_cost) FROM cte1) 
OR Total_man_cost in (SELECT MAX(Total_man_cost) FROM cte1);

SELECT * from fact_manufacturing_cost
WHERE product_code = "A6818160202";

SELECT F.product_code, P.product, F.manufacturing_cost 
FROM fact_manufacturing_cost F JOIN dim_product P
ON F.product_code = P.product_code
WHERE manufacturing_cost
IN (
	SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost
    UNION
    SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost
    ) 
ORDER BY manufacturing_cost DESC ;
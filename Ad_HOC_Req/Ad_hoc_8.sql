WITH cte1 as (
SELECT
	get_quarters(date) as Quarters,
    sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year = 2020)
SELECT
	Quarters,
    CONCAT(Round(SUM(sold_quantity)/1000000,1)," M") as total_sold_quantity
FROM cte1
group by Quarters;
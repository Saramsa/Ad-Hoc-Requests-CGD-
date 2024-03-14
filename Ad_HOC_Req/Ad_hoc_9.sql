-- with cte1 as (
-- SELECT
-- 	channel,
--     round(SUM(gross_price * sold_quantity)/1000000,1) as Gross_Sales_Amt
-- FROM fact_sales_monthly s
-- JOIN dim_customer d ON s.customer_code = d.customer_code
-- JOIN fact_gross_price g ON s.product_code = g.product_code
-- WHERE s.fiscal_year = 2021
-- GROUP BY channel)
-- SELECT
-- 		*,
--         round(Gross_Sales_Amt/SUM(Gross_Sales_Amt) over()*100,2) as Perc_Cont
-- FROM cte1;

with cte1 as (
SELECT
	round(SUM(gross_price * sold_quantity)/1000000,1) as Total_Gross_Sales
FROM fact_sales_monthly s
JOIN fact_gross_price g ON s.product_code = g.product_code
WHERE s.fiscal_year = 2021),
cte2 as(
SELECT
	channel,
    round(SUM(gross_price * sold_quantity)/1000000,1) as Gross_Sales_Amt,
    Total_Gross_Sales
FROM fact_sales_monthly s
JOIN dim_customer d ON s.customer_code = d.customer_code
JOIN fact_gross_price g ON s.product_code = g.product_code
CROSS JOIN cte1 c
WHERE s.fiscal_year = 2021
GROUP BY channel,Total_Gross_Sales)
SELECT
		channel,
        Gross_sales_Amt,
        round((Gross_Sales_Amt/Total_Gross_Sales)*100,2) As Percent_Contrib
FROM cte2;


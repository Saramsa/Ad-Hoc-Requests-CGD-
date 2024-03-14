with cte1 as
(select
	product_code,
	count(distinct(product_code)) as unique_products_2020
FROM fact_sales_monthly
where fiscal_year = 2020),
cte2 as
(select 
	product_code,
	count(distinct(product_code)) as unique_products_2021
FROM fact_sales_monthly
where fiscal_year = 2021)
select
	c1.unique_products_2020,
    c2.unique_products_2021,
    round(((c2.unique_products_2021 - c1.unique_products_2020) / c1.unique_products_2020),2) * 100 
AS PercentageChange
FROM cte1 c1 
JOIN cte2 c2 on c1.product_code = c2.product_code;

SET sql_mode=(SELECT REPLACE(@@sql_mode,'','ONLY_FULL_GROUP_BY'));
SET sql_mode=(SELECT CONCAT(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SHOW Variables like 'sql_mode';


SELECT
	DATE_FORMAT(date, '%b') as Month,
    YEAR(date) as Year, 
    Concat(round(SUM(sold_quantity * gross_price)/1000000,2)," M") as Gross_Sales_Amount
FROM fact_sales_monthly s
JOIN fact_gross_price g ON s.product_code = g.product_code
JOIN dim_customer d ON s.customer_code = d.customer_code
WHERE  d.customer = "Atliq Exclusive"
GROUP BY YEAR(s.date),DATE_FORMAT(s.date, '%b');






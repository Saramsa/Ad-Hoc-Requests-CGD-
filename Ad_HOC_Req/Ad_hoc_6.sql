SELECT
	customer,
    d.customer_code,
    round(AVG(pre_invoice_discount_pct),2) as average_discount_percentage
from dim_customer d
JOIN fact_pre_invoice_deductions fp
USING (customer_code)
WHERE d.market = "India" AND
fp.fiscal_year = 2021
GROUP BY d.customer_code,customer
ORDER BY average_discount_percentage DESC
LIMIT 5;
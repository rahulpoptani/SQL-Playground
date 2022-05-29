with runners as 
(
select 1 as id, 'John Doe' as name union all
select 2 as id, 'Jane Doe' as name union all
select 3 as id, 'Alice Jones' as name union all
select 4 as id, 'Bobby Louis' as name union all
select 5 as id, 'Lisa Romero' as name
),
races as (
select 1 as id, '100 meter dash' as event, 2 as winner_id union all
select 2 as id, '500 meter dash' as event, 2 as winner_id union all
select 3 as id, 'cross-country' as event, 2 as winner_id union all
select 4 as id, 'triathalon' as event, null as winner_id 
)
SELECT * FROM runners WHERE id NOT IN (SELECT winner_id FROM races);

-- new customers each day
with purchase as
(
select 1 as cust_id, '2021-01-01' as purchase_date, 'AX1221' as product_id union all
select 2 as cust_id, '2021-01-01' as purchase_date, 'AX9843' as product_id union all

select 1 as cust_id, '2021-01-02' as purchase_date, 'AX2312' as product_id union all
select 3 as cust_id, '2021-01-02' as purchase_date, 'AX2323' as product_id  union all

select 3 as cust_id, '2021-01-03' as purchase_date, 'AX2312' as product_id union all
select 4 as cust_id, '2021-01-03' as purchase_date, 'AX2312' as product_id union all

select 1 as cust_id, '2021-01-04' as purchase_date, 'AX2312' as product_id union all
select 2 as cust_id, '2021-01-04' as purchase_date, 'AX2312' as product_id
)
select purchase_date, sum(case when occurence = 1 then 1 else 0 end) as new_users 
from 
( 
	select cust_id, purchase_date, product_id, rank() over (partition by cust_id order by purchase_date) as occurence from purchase order by purchase_date 
) sub 
group by purchase_date;


-- Find Id where Sales us more than previous day
with purchase as
(
select 1 as id, str_to_date('2021-01-01', '%Y-%m-%d') as sales_date, 10 as sales_qty union all
select 2 as id, str_to_date('2021-01-02', '%Y-%m-%d') as sales_date, 20 as sales_qty union all
select 3 as id, str_to_date('2021-01-04', '%Y-%m-%d') as sales_date, 30 as sales_qty union all
select 4 as id, str_to_date('2021-01-05', '%Y-%m-%d') as sales_date, 30 as sales_qty union all
select 5 as id, str_to_date('2021-01-06', '%Y-%m-%d') as sales_date, 35 as sales_qty
)
select p2.id 
from
purchase p1 join purchase p2
-- on p2.sales_date - p1.sales_date = 1
on datediff(p2.sales_date, p1.sales_date) = 1
and p2.sales_qty > p1.sales_qty;


-- find monthly sales statement, for any month if there are no sales then return amount 0
with sales as
(
select str_to_date('2021-01-01', '%Y-%m-%d') as sales_date, 100 as amount union all
select str_to_date('2021-01-05', '%Y-%m-%d') as sales_date, 250 as amount union all
select str_to_date('2021-03-01', '%Y-%m-%d') as sales_date, 150 as amount union all
select str_to_date('2021-04-01', '%Y-%m-%d') as sales_date, 200 as amount union all
select str_to_date('2021-07-01', '%Y-%m-%d') as sales_date, 700 as amount union all
select str_to_date('2021-07-03', '%Y-%m-%d') as sales_date, 100 as amount
)
select date_format(sales_date, '%Y-%m') as monthly_sales, sum(amount) as monthly_sales
from sales 
group by date_format(sales_date, '%Y-%m');










 
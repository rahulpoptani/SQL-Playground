-- 2159: April & May Sign Up's 
with transactions as (
select 1 as transaction_id,	100 as signup_id,	'2020-04-30' as transaction_start_date,	24.9 as amt from dual union all
select 2 as transaction_id,	101 as signup_id,	'2020-04-16' as transaction_start_date,	24.9 as amt from dual union all
select 3 as transaction_id,	102 as signup_id,	'2020-04-28' as transaction_start_date,	9.9 as amt from dual union all
select 4 as transaction_id,	102 as signup_id,	'2020-05-28' as transaction_start_date,	9.9 as amt from dual union all
select 5 as transaction_id,	102 as signup_id,	'2020-06-27' as transaction_start_date,	9.9 as amt from dual union all
select 6 as transaction_id,	102 as signup_id,	'2020-07-27' as transaction_start_date,	9.9 as amt from dual union all
select 7 as transaction_id,	102 as signup_id,	'2020-08-26' as transaction_start_date,	9.9 as amt from dual union all
select 8 as transaction_id,	102 as signup_id,	'2020-09-25' as transaction_start_date,	9.9 as amt from dual union all
select 9 as transaction_id,	103 as signup_id,	'2020-04-11' as transaction_start_date,	24.9 as amt from dual union all
select 10 as transaction_id, 	104 as signup_id,	'2020-05-01' as transaction_start_date,	24.9 as amt from dual union all
select 11 as transaction_id, 	105 as signup_id,	'2020-04-21' as transaction_start_date,	9.9 as amt from dual union all
select 12 as transaction_id, 	105 as signup_id,	'2020-05-21' as transaction_start_date,	9.9 as amt from dual union all
select 13 as transaction_id, 	105 as signup_id,	'2020-06-20' as transaction_start_date,	9.9 as amt from dual union all
select 14 as transaction_id, 	106 as signup_id,	'2020-04-17' as transaction_start_date,	109.9 as amt from dual union all
select 15 as transaction_id, 	107 as signup_id,	'2020-04-14' as transaction_start_date,	109.9 as amt from dual union all
select 16 as transaction_id, 	108 as signup_id,	'2020-04-28' as transaction_start_date,	9.9 as amt from dual union all
select 17 as transaction_id, 	108 as signup_id,	'2020-05-28' as transaction_start_date,	9.9 as amt from dual union all
select 18 as transaction_id, 	109 as signup_id,	'2020-04-18' as transaction_start_date,	24.9 as amt from dual union all
select 19 as transaction_id, 	109 as signup_id,	'2020-07-17' as transaction_start_date,	24.9 as amt from dual union all
select 20 as transaction_id, 	110 as signup_id,	'2020-04-22' as transaction_start_date,	24.9 as amt from dual union all
select 21 as transaction_id, 	111 as signup_id,	'2020-04-11' as transaction_start_date,	109.9 as amt from dual union all
select 22 as transaction_id, 	112 as signup_id,	'2020-04-22' as transaction_start_date,	9.9 as amt from dual union all
select 23 as transaction_id,	112 as signup_id,	'2020-05-22' as transaction_start_date,	9.9 as amt from dual union all
select 24 as transaction_id, 	112 as signup_id,	'2020-06-21' as transaction_start_date,	9.9 as amt from dual union all
select 25 as transaction_id, 	112 as signup_id,	'2020-07-21' as transaction_start_date,	9.9 as amt from dual union all
select 26 as transaction_id, 	112 as signup_id,	'2020-08-20' as transaction_start_date,	9.9 as amt from dual union all
select 27 as transaction_id, 	113 as signup_id,	'2020-04-29' as transaction_start_date,	109.9 as amt from dual union all
select 28 as transaction_id, 	114 as signup_id,	'2020-04-27' as transaction_start_date,	24.9 as amt from dual union all
select 29 as transaction_id, 	115 as signup_id,	'2020-05-05' as transaction_start_date,	24.9 as amt from dual union all
select 30 as transaction_id, 	115 as signup_id,	'2020-08-03' as transaction_start_date,	24.9 as amt from dual union all
select 31 as transaction_id, 	116 as signup_id,	'2020-04-24' as transaction_start_date,	24.9 as amt from dual union all
select 32 as transaction_id, 	116 as signup_id,	'2020-07-23' as transaction_start_date,	24.9 as amt from dual union all
select 33 as transaction_id,   117 as signup_id,	'2020-04-29' as transaction_start_date,	109.9 as amt from dual union all
select 34 as transaction_id,   118 as signup_id,	'2020-04-11' as transaction_start_date,	109.9 as amt from dual union all
select 35 as transaction_id,   119 as signup_id,	'2020-04-28' as transaction_start_date,	24.9 as amt from dual union all
select 36 as transaction_id,   119 as signup_id,	'2020-07-27' as transaction_start_date,	24.9 as amt from dual union all
select 37 as transaction_id,   120 as signup_id,	'2020-04-17' as transaction_start_date,	24.9 as amt from dual union all
select 38 as transaction_id,   121 as signup_id,	'2020-04-29' as transaction_start_date,	109.9 as amt from dual union all
select 39 as transaction_id,   122 as signup_id,	'2020-04-20' as transaction_start_date,	9.9 as amt from dual union all
select 40 as transaction_id,   122 as signup_id,	'2020-05-20' as transaction_start_date,	9.9 as amt from dual union all
select 41 as transaction_id,   123 as signup_id,	'2020-04-20' as transaction_start_date,	9.9 as amt from dual union all
select 42 as transaction_id,   123 as signup_id,	'2020-05-20' as transaction_start_date,	9.9 as amt from dual union all
select 43 as transaction_id,   123 as signup_id,	'2020-06-19' as transaction_start_date,	9.9 as amt from dual union all
select 44 as transaction_id,   123 as signup_id,	'2020-07-19' as transaction_start_date,	9.9 as amt from dual union all
select 45 as transaction_id,   123 as signup_id,	'2020-08-18' as transaction_start_date,	9.9 as amt from dual union all
select 46 as transaction_id,   123 as signup_id,	'2020-09-17' as transaction_start_date,	9.9 as amt from dual union all
select 47 as transaction_id,   124 as signup_id,	'2020-04-25' as transaction_start_date,	24.9 as amt from dual union all
select 48 as transaction_id,   125 as signup_id,	'2020-04-23' as transaction_start_date,	9.9 as amt from dual union all
select 49 as transaction_id,   125 as signup_id,	'2020-05-23' as transaction_start_date,	9.9 as amt from dual union all
select 50 as transaction_id,   126 as signup_id,	'2020-04-28' as transaction_start_date,	24.9 as amt from dual union all
select 51 as transaction_id,   127 as signup_id,	'2020-05-01' as transaction_start_date,	24.9 as amt from dual union all
select 52 as transaction_id,   127 as signup_id,	'2020-07-30' as transaction_start_date,	24.9 as amt from dual union all
select 53 as transaction_id,   128 as signup_id,	'2020-05-04' as transaction_start_date,	9.9 as amt from dual union all
select 54 as transaction_id,   128 as signup_id,	'2020-06-03' as transaction_start_date,	9.9 as amt from dual union all
select 55 as transaction_id,   128 as signup_id,	'2020-07-03' as transaction_start_date,	9.9 as amt from dual union all
select 56 as transaction_id,   128 as signup_id,	'2020-08-02' as transaction_start_date,	9.9 as amt from dual union all
select 57 as transaction_id,   129 as signup_id,	'2020-04-11' as transaction_start_date,	109.9 as amt from dual union all
select 58 as transaction_id,   130 as signup_id,	'2020-04-14' as transaction_start_date,	109.9 as amt from dual union all
select 59 as transaction_id,   131 as signup_id,	'2020-04-29' as transaction_start_date,	24.9 as amt from dual union all
select 60 as transaction_id,   132 as signup_id,	'2020-04-13' as transaction_start_date,	9.9 as amt from dual union all
select 61 as transaction_id,   132 as signup_id,	'2020-05-13' as transaction_start_date,	9.9 as amt from dual union all
select 62 as transaction_id,   132 as signup_id,	'2020-06-12' as transaction_start_date,	9.9 as amt from dual union all
select 63 as transaction_id,   132 as signup_id,	'2020-07-12' as transaction_start_date,	9.9 as amt from dual union all
select 64 as transaction_id,   132 as signup_id,	'2020-08-11' as transaction_start_date,	9.9 as amt from dual union all
select 65 as transaction_id,   132 as signup_id,	'2020-09-10' as transaction_start_date,	9.9 as amt from dual union all
select 66 as transaction_id,   133 as signup_id,	'2020-04-22' as transaction_start_date,	9.9 as amt from dual union all
select 67 as transaction_id,   133 as signup_id,	'2020-05-22' as transaction_start_date,	9.9 as amt from dual union all
select 68 as transaction_id,   134 as signup_id,	'2020-05-06' as transaction_start_date,	24.9 as amt from dual union all
select 69 as transaction_id,   135 as signup_id,	'2020-04-25' as transaction_start_date,	24.9 as amt from dual union all
select 70 as transaction_id,   135 as signup_id,	'2020-07-24' as transaction_start_date,	24.9 as amt from dual union all
select 71 as transaction_id,   136 as signup_id,	'2020-05-05' as transaction_start_date,	24.9 as amt from dual union all
select 72 as transaction_id,   137 as signup_id,	'2020-04-22' as transaction_start_date,	9.9 as amt from dual union all
select 73 as transaction_id,   137 as signup_id,	'2020-05-22' as transaction_start_date,	9.9 as amt from dual union all
select 74 as transaction_id,   137 as signup_id,	'2020-06-21' as transaction_start_date,	9.9 as amt from dual union all
select 75 as transaction_id,   138 as signup_id,	'2020-05-01' as transaction_start_date,	24.9 as amt from dual union all
select 76 as transaction_id,   138 as signup_id,	'2020-07-30' as transaction_start_date,	24.9 as amt from dual union all
select 77 as transaction_id,   139 as signup_id,	'2020-05-05' as transaction_start_date,	24.9 as amt from dual union all
select 78 as transaction_id,   139 as signup_id,	'2020-08-03' as transaction_start_date,	24.9 as amt from dual union all
select 79 as transaction_id,   140 as signup_id,	'2020-04-24' as transaction_start_date,	24.9 as amt from dual union all
select 80 as transaction_id,   140 as signup_id,	'2020-07-23' as transaction_start_date,	24.9 as amt from dual union all
select 81 as transaction_id,   141 as signup_id,	'2020-05-04' as transaction_start_date,	9.9 as amt from dual union all
select 82 as transaction_id,   141 as signup_id,	'2020-06-03' as transaction_start_date,	9.9 as amt from dual union all
select 83 as transaction_id,   141 as signup_id,	'2020-07-03' as transaction_start_date,	9.9 as amt from dual union all
select 84 as transaction_id,   141 as signup_id,	'2020-08-02' as transaction_start_date,	9.9 as amt from dual union all
select 85 as transaction_id,   141 as signup_id,	'2020-09-01' as transaction_start_date,	9.9 as amt from dual union all
select 86 as transaction_id,   142 as signup_id,	'2020-04-16' as transaction_start_date,	24.9 as amt from dual union all
select 87 as transaction_id,   143 as signup_id,	'2020-05-06' as transaction_start_date,	24.9 as amt from dual union all
select 88 as transaction_id,   143 as signup_id,	'2020-08-04' as transaction_start_date,	24.9 as amt from dual union all
select 89 as transaction_id,   144 as signup_id,	'2020-04-20' as transaction_start_date,	109.9 as amt from dual union all
select 90 as transaction_id,   145 as signup_id,	'2020-05-06' as transaction_start_date,	24.9 as amt from dual union all
select 91 as transaction_id,   146 as signup_id,	'2020-05-02' as transaction_start_date,	109.9 as amt from dual union all
select 92 as transaction_id,   147 as signup_id,	'2020-05-01' as transaction_start_date,	24.9 as amt from dual union all
select 93 as transaction_id,   147 as signup_id,	'2020-07-30' as transaction_start_date,	24.9 as amt from dual union all
select 94 as transaction_id,   148 as signup_id,	'2020-05-06' as transaction_start_date,	9.9 as amt from dual union all
select 95 as transaction_id,   148 as signup_id,	'2020-06-05' as transaction_start_date,	9.9 as amt from dual union all
select 96 as transaction_id,   148 as signup_id,	'2020-07-05' as transaction_start_date,	9.9 as amt from dual union all
select 97 as transaction_id,   148 as signup_id,	'2020-08-04' as transaction_start_date,	9.9 as amt from dual union all
select 98 as transaction_id,   148 as signup_id,	'2020-09-03' as transaction_start_date,	9.9 as amt from dual union all
select 99 as transaction_id,   148 as signup_id,	'2020-10-03' as transaction_start_date,	9.9 as amt from dual union all
select 100 as transaction_id,  149 as signup_id,	'2020-05-05' as transaction_start_date,	109.9 as amt from dual
)
select distinct signup_id from transactions where extract(MONTH FROM to_date(transaction_start_date,'YYYY-MM-DD')) in (4,5);

--2160: Oregon's Prior Month's Sales
with online_orders as (
select 1 as product_id,  1 as promotion_id, 	2 as cost_in_dollars, 	1 as customer_id,  '2022-04-01' as "date", 4 as units_sold from dual union all
select 3 as product_id,	  3 as promotion_id, 	6 as cost_in_dollars, 	3 as customer_id,  '2022-05-24' as "date", 6 as units_sold from dual union all
select 1 as product_id,	  2 as promotion_id, 	2 as cost_in_dollars, 	10 as customer_id, '2022-05-01' as "date", 3 as units_sold from dual union all
select 1 as product_id,	  2 as promotion_id, 	3 as cost_in_dollars, 	2 as customer_id,  '2022-05-01' as "date", 9 as units_sold from dual union all
select 2 as product_id,	  2 as promotion_id, 	10 as cost_in_dollars, 	2 as customer_id,  '2022-05-01' as "date", 1 as units_sold from dual union all
select 9 as product_id,	  3 as promotion_id, 	1 as cost_in_dollars, 	2 as customer_id,  '2022-05-31' as "date", 5 as units_sold from dual union all
select 6 as product_id,	  1 as promotion_id, 	4 as cost_in_dollars, 	1 as customer_id,  '2022-04-07' as "date", 8 as units_sold from dual union all
select 6 as product_id,	  2 as promotion_id, 	2 as cost_in_dollars, 	1 as customer_id,  '2022-05-01' as "date", 12 as units_sold from dual union all
select 3 as product_id,	  3 as promotion_id, 	5 as cost_in_dollars, 	1 as customer_id,  '2022-05-25' as "date", 4 as units_sold from dual union all
select 3 as product_id,	  3 as promotion_id, 	6 as cost_in_dollars, 	2 as customer_id,  '2022-05-25' as "date", 6 as units_sold from dual union all
select 3 as product_id,	  3 as promotion_id, 	7 as cost_in_dollars, 	3 as customer_id,  '2022-05-25' as "date", 7 as units_sold from dual union all
select 2 as product_id,	  2 as promotion_id, 	12 as cost_in_dollars, 	3 as customer_id,  '2022-05-01' as "date", 1 as units_sold from dual union all
select 8 as product_id,	  2 as promotion_id, 	4 as cost_in_dollars, 	3 as customer_id,  '2022-05-01' as "date", 4 as units_sold from dual union all
select 9 as product_id,	  1 as promotion_id, 	1 as cost_in_dollars, 	10 as customer_id, '2022-04-07' as "date", 2 as units_sold from dual union all
select 9 as product_id,	  5 as promotion_id, 	2 as cost_in_dollars, 	3 as customer_id,  '2022-04-06' as "date", 20 as units_sold from dual union all
select 10 as product_id, 1 as promotion_id, 	3 as cost_in_dollars, 	2 as customer_id,  '2022-04-07' as "date", 4 as units_sold from dual union all
select 10 as product_id, 1 as promotion_id, 	3 as cost_in_dollars, 	1 as customer_id,  '2022-04-01' as "date", 5 as units_sold from dual union all
select 3 as product_id,	  1 as promotion_id, 	6 as cost_in_dollars, 	1 as customer_id,  '2022-04-02' as "date", 10 as units_sold from dual union all
select 2 as product_id,	  1 as promotion_id, 	10 as cost_in_dollars, 	10 as customer_id, '2022-04-04' as "date", 8 as units_sold from dual union all
select 2 as product_id,	  1 as promotion_id, 	11 as cost_in_dollars, 	3 as customer_id,  '2022-04-05' as "date", 6 as units_sold from dual union all
select 4 as product_id,	  2 as promotion_id, 	2 as cost_in_dollars, 	2 as customer_id,  '2022-05-02' as "date", 7 as units_sold from dual union all
select 5 as product_id,	  2 as promotion_id, 	8 as cost_in_dollars, 	1 as customer_id,  '2022-05-02' as "date", 7 as units_sold from dual union all
select 2 as product_id,	  3 as promotion_id, 	13 as cost_in_dollars, 	1 as customer_id,  '2022-05-30' as "date", 3 as units_sold from dual union all
select 1 as product_id,	  1 as promotion_id, 	2 as cost_in_dollars, 	2 as customer_id,  '2022-04-07' as "date", 3 as units_sold from dual union all
select 10 as product_id, 2 as promotion_id, 	2 as cost_in_dollars, 	3 as customer_id,  '2022-05-02' as "date", 9 as units_sold from dual union all
select 11 as product_id, 1 as promotion_id, 	5 as cost_in_dollars, 	1 as customer_id,  '2022-04-03' as "date", 9 as units_sold from dual union all
select 5 as product_id,	  1 as promotion_id, 	7 as cost_in_dollars, 	10 as customer_id, '2022-04-02' as "date", 9 as units_sold from dual union all
select 5 as product_id,	  4 as promotion_id, 	8 as cost_in_dollars, 	1 as customer_id,  '2022-06-06' as "date", 8 as units_sold from dual union all
select 1 as product_id,	  1 as promotion_id, 	2 as cost_in_dollars, 	2 as customer_id,  '2022-04-02' as "date", 9 as units_sold from dual union all
select 5 as product_id,	  2 as promotion_id, 	8 as cost_in_dollars, 	15 as customer_id, '2022-05-01' as "date", 2 as units_sold from dual union all
select 8 as product_id,	  2 as promotion_id, 	4 as cost_in_dollars, 	3 as customer_id,  '2022-05-11' as "date", 1 as units_sold from dual union all
select 8 as product_id,	  2 as promotion_id, 	4 as cost_in_dollars, 	3 as customer_id,  '2022-06-11' as "date", 1 as units_sold from dual
),
online_customers as (
select 1 as id,  'Max' as first_name, 		'George' as last_name,	26 as age,	'Max@company.com' as email, 	'Oregon' as state, 	 '2638 Richards Avenue' as address from dual union all
select 2 as id,  'George' as first_name, 	'Joe' as last_name,	50 as age,	'George@company.com' as email, 'California' as state,  '1003 Wyatt Street' as address from dual union all
select 3 as id,  'Laila' as first_name, 	'Mark' as last_name,	26 as age,	'Laila@company.com' as email, 	'Oregon' as state, 	 '3655 Spirit Drive' as address from dual union all
select 4 as id,  'Sarrah' as first_name, 	'Bicky' as last_name,	31 as age,	'Sarrah@company.com' as email, 'California' as state,  '1176 Tyler Avenue' as address from dual union all
select 5 as id,  'Suzan' as first_name, 	'Lee' as last_name,	34 as age,	'Suzan@company.com' as email, 	'Washington' as state, 	 '1275 Monroe Avenue' as address from dual union all
select 6 as id,  'Mandy' as first_name, 	'John' as last_name,	31 as age,	'Mandy@company.com' as email, 	'Washington' as state, 	 '2510 Maryland Avenue' as address from dual union all
select 7 as id,  'Britney' as first_name, 	'Berry' as last_name,	45 as age,	'Britney@company.com' as email, 'Washington' as state, '3946 Steve Hunt' as address from dual union all
select 8 as id,  'Jack' as first_name,		'Mick' as last_name,	29 as age,	'Jack@company.com' as email, 	'Arizona' as state, 	 '3762 Stratford Drive' as address from dual union all
select 9 as id,  'Ben' as first_name,		'Ten' as last_name,	43 as age,	'Ben@company.com' as email, 	'Oregon' as state, 	 '3055 Indiana Avenue' as address from dual union all
select 10 as id, 'Tom' as first_name,		'Fridy' as last_name,	32 as age,	'Tom@company.com' as email, 	'Arizona' as state, 	 '801 Stratford Drive' as address from dual union all
select 11 as id, 'Antoney' as first_name,	'Adam' as last_name,	34 as age,	'Antoney@company.com' as email, 'Montana' as state, 	 '3533 Randall Drive' as address from dual union all
select 12 as id, 'Morgan' as first_name,	'Matt' as last_name,	25 as age,	'Morgan@company.com' as email, 'Montana' as state, 	 '2641 Randall Drive' as address from dual union all
select 13 as id, 'Molly' as first_name,	'Sam' as last_name,	28 as age,	'Molly@company.com' as email, 	'Arizona' as state, 	 '3632 Polk Street' as address from dual union all
select 14 as id, 'Adam' as first_name,		'Morris' as last_name,	30 as age,	'Adam@company.com' as email, 	'Oregon' as state, 	 '4541 Ferry Street' as address from dual union all
select 15 as id, 'Mark' as first_name,		'Jon' as last_name,	28 as age,	'Mark@company.com' as email, 	'Oregon' as state, 	 '2522 George Avenue' as address from dual
)
select sum(oo.cost_in_dollars * oo.units_sold) as total_sales from online_customers oc join online_orders oo on oc.id = oo.customer_id
where oc.state = 'Oregon' and extract(MONTH FROM to_date(oo."date",'YYYY-MM-DD')) = 4;

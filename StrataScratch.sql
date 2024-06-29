-- Easy

-- 2159: April & May Sign Up's 
with transactions as (
select 1 as transaction_id,	100 as signup_id,	to_date('2020-04-30', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 2 as transaction_id,	101 as signup_id,	to_date('2020-04-16', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 3 as transaction_id,	102 as signup_id,	to_date('2020-04-28', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 4 as transaction_id,	102 as signup_id,	to_date('2020-05-28', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 5 as transaction_id,	102 as signup_id,	to_date('2020-06-27', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 6 as transaction_id,	102 as signup_id,	to_date('2020-07-27', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 7 as transaction_id,	102 as signup_id,	to_date('2020-08-26', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 8 as transaction_id,	102 as signup_id,	to_date('2020-09-25', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 9 as transaction_id,	103 as signup_id,	to_date('2020-04-11', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 10 as transaction_id, 	104 as signup_id,	to_date('2020-05-01', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 11 as transaction_id, 	105 as signup_id,	to_date('2020-04-21', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 12 as transaction_id, 	105 as signup_id,	to_date('2020-05-21', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 13 as transaction_id, 	105 as signup_id,	to_date('2020-06-20', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 14 as transaction_id, 	106 as signup_id,	to_date('2020-04-17', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 15 as transaction_id, 	107 as signup_id,	to_date('2020-04-14', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 16 as transaction_id, 	108 as signup_id,	to_date('2020-04-28', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 17 as transaction_id, 	108 as signup_id,	to_date('2020-05-28', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 18 as transaction_id, 	109 as signup_id,	to_date('2020-04-18', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 19 as transaction_id, 	109 as signup_id,	to_date('2020-07-17', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 20 as transaction_id, 	110 as signup_id,	to_date('2020-04-22', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 21 as transaction_id, 	111 as signup_id,	to_date('2020-04-11', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 22 as transaction_id, 	112 as signup_id,	to_date('2020-04-22', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 23 as transaction_id,	112 as signup_id,	to_date('2020-05-22', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 24 as transaction_id, 	112 as signup_id,	to_date('2020-06-21', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 25 as transaction_id, 	112 as signup_id,	to_date('2020-07-21', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 26 as transaction_id, 	112 as signup_id,	to_date('2020-08-20', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 27 as transaction_id, 	113 as signup_id,	to_date('2020-04-29', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 28 as transaction_id, 	114 as signup_id,	to_date('2020-04-27', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 29 as transaction_id, 	115 as signup_id,	to_date('2020-05-05', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 30 as transaction_id, 	115 as signup_id,	to_date('2020-08-03', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 31 as transaction_id, 	116 as signup_id,	to_date('2020-04-24', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 32 as transaction_id, 	116 as signup_id,	to_date('2020-07-23', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 33 as transaction_id,   117 as signup_id,	to_date('2020-04-29', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 34 as transaction_id,   118 as signup_id,	to_date('2020-04-11', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 35 as transaction_id,   119 as signup_id,	to_date('2020-04-28', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 36 as transaction_id,   119 as signup_id,	to_date('2020-07-27', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 37 as transaction_id,   120 as signup_id,	to_date('2020-04-17', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 38 as transaction_id,   121 as signup_id,	to_date('2020-04-29', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 39 as transaction_id,   122 as signup_id,	to_date('2020-04-20', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 40 as transaction_id,   122 as signup_id,	to_date('2020-05-20', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 41 as transaction_id,   123 as signup_id,	to_date('2020-04-20', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 42 as transaction_id,   123 as signup_id,	to_date('2020-05-20', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 43 as transaction_id,   123 as signup_id,	to_date('2020-06-19', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 44 as transaction_id,   123 as signup_id,	to_date('2020-07-19', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 45 as transaction_id,   123 as signup_id,	to_date('2020-08-18', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 46 as transaction_id,   123 as signup_id,	to_date('2020-09-17', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 47 as transaction_id,   124 as signup_id,	to_date('2020-04-25', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 48 as transaction_id,   125 as signup_id,	to_date('2020-04-23', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 49 as transaction_id,   125 as signup_id,	to_date('2020-05-23', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 50 as transaction_id,   126 as signup_id,	to_date('2020-04-28', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 51 as transaction_id,   127 as signup_id,	to_date('2020-05-01', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 52 as transaction_id,   127 as signup_id,	to_date('2020-07-30', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 53 as transaction_id,   128 as signup_id,	to_date('2020-05-04', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 54 as transaction_id,   128 as signup_id,	to_date('2020-06-03', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 55 as transaction_id,   128 as signup_id,	to_date('2020-07-03', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 56 as transaction_id,   128 as signup_id,	to_date('2020-08-02', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 57 as transaction_id,   129 as signup_id,	to_date('2020-04-11', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 58 as transaction_id,   130 as signup_id,	to_date('2020-04-14', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 59 as transaction_id,   131 as signup_id,	to_date('2020-04-29', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 60 as transaction_id,   132 as signup_id,	to_date('2020-04-13', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 61 as transaction_id,   132 as signup_id,	to_date('2020-05-13', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 62 as transaction_id,   132 as signup_id,	to_date('2020-06-12', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 63 as transaction_id,   132 as signup_id,	to_date('2020-07-12', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 64 as transaction_id,   132 as signup_id,	to_date('2020-08-11', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 65 as transaction_id,   132 as signup_id,	to_date('2020-09-10', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 66 as transaction_id,   133 as signup_id,	to_date('2020-04-22', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 67 as transaction_id,   133 as signup_id,	to_date('2020-05-22', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 68 as transaction_id,   134 as signup_id,	to_date('2020-05-06', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 69 as transaction_id,   135 as signup_id,	to_date('2020-04-25', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 70 as transaction_id,   135 as signup_id,	to_date('2020-07-24', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 71 as transaction_id,   136 as signup_id,	to_date('2020-05-05', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 72 as transaction_id,   137 as signup_id,	to_date('2020-04-22', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 73 as transaction_id,   137 as signup_id,	to_date('2020-05-22', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 74 as transaction_id,   137 as signup_id,	to_date('2020-06-21', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 75 as transaction_id,   138 as signup_id,	to_date('2020-05-01', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 76 as transaction_id,   138 as signup_id,	to_date('2020-07-30', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 77 as transaction_id,   139 as signup_id,	to_date('2020-05-05', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 78 as transaction_id,   139 as signup_id,	to_date('2020-08-03', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 79 as transaction_id,   140 as signup_id,	to_date('2020-04-24', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 80 as transaction_id,   140 as signup_id,	to_date('2020-07-23', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 81 as transaction_id,   141 as signup_id,	to_date('2020-05-04', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 82 as transaction_id,   141 as signup_id,	to_date('2020-06-03', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 83 as transaction_id,   141 as signup_id,	to_date('2020-07-03', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 84 as transaction_id,   141 as signup_id,	to_date('2020-08-02', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 85 as transaction_id,   141 as signup_id,	to_date('2020-09-01', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 86 as transaction_id,   142 as signup_id,	to_date('2020-04-16', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 87 as transaction_id,   143 as signup_id,	to_date('2020-05-06', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 88 as transaction_id,   143 as signup_id,	to_date('2020-08-04', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 89 as transaction_id,   144 as signup_id,	to_date('2020-04-20', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 90 as transaction_id,   145 as signup_id,	to_date('2020-05-06', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 91 as transaction_id,   146 as signup_id,	to_date('2020-05-02', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual union all
select 92 as transaction_id,   147 as signup_id,	to_date('2020-05-01', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 93 as transaction_id,   147 as signup_id,	to_date('2020-07-30', 'YYYY-MM-DD') as transaction_start_date,	24.9 as amt from dual union all
select 94 as transaction_id,   148 as signup_id,	to_date('2020-05-06', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 95 as transaction_id,   148 as signup_id,	to_date('2020-06-05', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 96 as transaction_id,   148 as signup_id,	to_date('2020-07-05', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 97 as transaction_id,   148 as signup_id,	to_date('2020-08-04', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 98 as transaction_id,   148 as signup_id,	to_date('2020-09-03', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 99 as transaction_id,   148 as signup_id,	to_date('2020-10-03', 'YYYY-MM-DD') as transaction_start_date,	9.9 as amt from dual union all
select 100 as transaction_id,  149 as signup_id,	to_date('2020-05-05', 'YYYY-MM-DD') as transaction_start_date,	109.9 as amt from dual
)
select distinct signup_id from transactions where extract(MONTH FROM transaction_start_date) in (4,5);

--2160: Oregon's Prior Month's Sales
product_id	promotion_id	cost_in_dollars	customer_id	date	units_sold

with online_orders as (
select 1 as product_id,  1 as promotion_id, 	2 as cost_in_dollars, 	1 as customer_id,  to_date('2022-04-01', 'YYYY-MM-DD') as "date", 4 as units_sold from dual union all
select 3 as product_id,	  3 as promotion_id, 	6 as cost_in_dollars, 	3 as customer_id,  to_date('2022-05-24', 'YYYY-MM-DD') as "date", 6 as units_sold from dual union all
select 1 as product_id,	  2 as promotion_id, 	2 as cost_in_dollars, 	10 as customer_id, to_date('2022-05-01', 'YYYY-MM-DD') as "date", 3 as units_sold from dual union all
select 1 as product_id,	  2 as promotion_id, 	3 as cost_in_dollars, 	2 as customer_id,  to_date('2022-05-01', 'YYYY-MM-DD') as "date", 9 as units_sold from dual union all
select 2 as product_id,	  2 as promotion_id, 	10 as cost_in_dollars, 	2 as customer_id,  to_date('2022-05-01', 'YYYY-MM-DD') as "date", 1 as units_sold from dual union all
select 9 as product_id,	  3 as promotion_id, 	1 as cost_in_dollars, 	2 as customer_id,  to_date('2022-05-31', 'YYYY-MM-DD') as "date", 5 as units_sold from dual union all
select 6 as product_id,	  1 as promotion_id, 	4 as cost_in_dollars, 	1 as customer_id,  to_date('2022-04-07', 'YYYY-MM-DD') as "date", 8 as units_sold from dual union all
select 6 as product_id,	  2 as promotion_id, 	2 as cost_in_dollars, 	1 as customer_id,  to_date('2022-05-01', 'YYYY-MM-DD') as "date", 12 as units_sold from dual union all
select 3 as product_id,	  3 as promotion_id, 	5 as cost_in_dollars, 	1 as customer_id,  to_date('2022-05-25', 'YYYY-MM-DD') as "date", 4 as units_sold from dual union all
select 3 as product_id,	  3 as promotion_id, 	6 as cost_in_dollars, 	2 as customer_id,  to_date('2022-05-25', 'YYYY-MM-DD') as "date", 6 as units_sold from dual union all
select 3 as product_id,	  3 as promotion_id, 	7 as cost_in_dollars, 	3 as customer_id,  to_date('2022-05-25', 'YYYY-MM-DD') as "date", 7 as units_sold from dual union all
select 2 as product_id,	  2 as promotion_id, 	12 as cost_in_dollars, 	3 as customer_id,  to_date('2022-05-01', 'YYYY-MM-DD') as "date", 1 as units_sold from dual union all
select 8 as product_id,	  2 as promotion_id, 	4 as cost_in_dollars, 	3 as customer_id,  to_date('2022-05-01', 'YYYY-MM-DD') as "date", 4 as units_sold from dual union all
select 9 as product_id,	  1 as promotion_id, 	1 as cost_in_dollars, 	10 as customer_id, to_date('2022-04-07', 'YYYY-MM-DD') as "date", 2 as units_sold from dual union all
select 9 as product_id,	  5 as promotion_id, 	2 as cost_in_dollars, 	3 as customer_id,  to_date('2022-04-06', 'YYYY-MM-DD') as "date", 20 as units_sold from dual union all
select 10 as product_id, 1 as promotion_id, 	3 as cost_in_dollars, 	2 as customer_id,  to_date('2022-04-07', 'YYYY-MM-DD') as "date", 4 as units_sold from dual union all
select 10 as product_id, 1 as promotion_id, 	3 as cost_in_dollars, 	1 as customer_id,  to_date('2022-04-01', 'YYYY-MM-DD') as "date", 5 as units_sold from dual union all
select 3 as product_id,	  1 as promotion_id, 	6 as cost_in_dollars, 	1 as customer_id,  to_date('2022-04-02', 'YYYY-MM-DD') as "date", 10 as units_sold from dual union all
select 2 as product_id,	  1 as promotion_id, 	10 as cost_in_dollars, 	10 as customer_id, to_date('2022-04-04', 'YYYY-MM-DD') as "date", 8 as units_sold from dual union all
select 2 as product_id,	  1 as promotion_id, 	11 as cost_in_dollars, 	3 as customer_id,  to_date('2022-04-05', 'YYYY-MM-DD') as "date", 6 as units_sold from dual union all
select 4 as product_id,	  2 as promotion_id, 	2 as cost_in_dollars, 	2 as customer_id,  to_date('2022-05-02', 'YYYY-MM-DD') as "date", 7 as units_sold from dual union all
select 5 as product_id,	  2 as promotion_id, 	8 as cost_in_dollars, 	1 as customer_id,  to_date('2022-05-02', 'YYYY-MM-DD') as "date", 7 as units_sold from dual union all
select 2 as product_id,	  3 as promotion_id, 	13 as cost_in_dollars, 	1 as customer_id,  to_date('2022-05-30', 'YYYY-MM-DD') as "date", 3 as units_sold from dual union all
select 1 as product_id,	  1 as promotion_id, 	2 as cost_in_dollars, 	2 as customer_id,  to_date('2022-04-07', 'YYYY-MM-DD') as "date", 3 as units_sold from dual union all
select 10 as product_id, 2 as promotion_id, 	2 as cost_in_dollars, 	3 as customer_id,  to_date('2022-05-02', 'YYYY-MM-DD') as "date", 9 as units_sold from dual union all
select 11 as product_id, 1 as promotion_id, 	5 as cost_in_dollars, 	1 as customer_id,  to_date('2022-04-03', 'YYYY-MM-DD') as "date", 9 as units_sold from dual union all
select 5 as product_id,	  1 as promotion_id, 	7 as cost_in_dollars, 	10 as customer_id, to_date('2022-04-02', 'YYYY-MM-DD') as "date", 9 as units_sold from dual union all
select 5 as product_id,	  4 as promotion_id, 	8 as cost_in_dollars, 	1 as customer_id,  to_date('2022-06-06', 'YYYY-MM-DD') as "date", 8 as units_sold from dual union all
select 1 as product_id,	  1 as promotion_id, 	2 as cost_in_dollars, 	2 as customer_id,  to_date('2022-04-02', 'YYYY-MM-DD') as "date", 9 as units_sold from dual union all
select 5 as product_id,	  2 as promotion_id, 	8 as cost_in_dollars, 	15 as customer_id, to_date('2022-05-01', 'YYYY-MM-DD') as "date", 2 as units_sold from dual union all
select 8 as product_id,	  2 as promotion_id, 	4 as cost_in_dollars, 	3 as customer_id,  to_date('2022-05-11', 'YYYY-MM-DD') as "date", 1 as units_sold from dual union all
select 8 as product_id,	  2 as promotion_id, 	4 as cost_in_dollars, 	3 as customer_id,  to_date('2022-06-11', 'YYYY-MM-DD') as "date", 1 as units_sold from dual
)
select * from online_orders;

-- Medium

-- Hard

-- What is the overall friend acceptance rate by date? Your output should have the rate of acceptances by the date the request was sent. Order by the earliest date to latest.
-- (StrataScratch) (Facebook)
with fb_friend_requests as (
select 'ad4943sdz' as user_id_sender, 		'948ksx123d' as user_id_receiver, 	'2020-01-04' as action_date, 'sent' as action FROM dual union all
select 'ad4943sdz' as user_id_sender, 		'948ksx123d' as user_id_receiver, 	'2020-01-06' as action_date, 'accepted' as action FROM dual union all
select 'dfdfxf9483' as user_id_sender, 		'9djjjd9283' as user_id_receiver, 	'2020-01-04' as action_date, 'sent' as action FROM dual union all
select 'dfdfxf9483' as user_id_sender, 		'9djjjd9283' as user_id_receiver, 	'2020-01-15' as action_date, 'accepted' as action FROM dual union all
select 'ffdfff4234234' as user_id_sender, 	'lpjzjdi4949' as user_id_receiver, 	'2020-01-06' as action_date, 'sent' as action FROM dual union all
select 'fffkfld9499' as user_id_sender, 	'993lsldidif' as user_id_receiver, 	'2020-01-06' as action_date, 'sent' as action FROM dual union all
select 'fffkfld9499' as user_id_sender, 	'993lsldidif' as user_id_receiver, 	'2020-01-10' as action_date, 'accepted' as action FROM dual union all
select 'fg503kdsdd' as user_id_sender, 		'ofp049dkd' as user_id_receiver, 	'2020-01-04' as action_date, 'sent' as action FROM dual union all
select 'fg503kdsdd' as user_id_sender, 		'ofp049dkd' as user_id_receiver, 	'2020-01-10' as action_date, 'accepted' as action FROM dual union all
select 'hh643dfert' as user_id_sender, 		'847jfkf203' as user_id_receiver, 	'2020-01-04' as action_date, 'sent' as action FROM dual union all
select 'r4gfgf2344' as user_id_sender, 		'234ddr4545' as user_id_receiver, 	'2020-01-06' as action_date, 'sent' as action FROM dual union all
select 'r4gfgf2344' as user_id_sender, 		'234ddr4545' as user_id_receiver, 	'2020-01-11' as action_date, 'accepted' as action FROM dual
)
select s.action_date, trunc(sum(case when a.action is not null then 1.0 else 0 end)/count(*),2) as percentage_acceptance
from
(select * from fb_friend_requests where action = 'sent') s
left join 
(select * from fb_friend_requests where action = 'accepted') a
on s.user_id_sender = a.user_id_sender and s.user_id_receiver = a.user_id_receiver
group by s.action_date
order by s.action_date;


-- 10368-population-density

WITH cities_population AS (
--city	country	population	area
SELECT 'Metropolis' AS city,	'Countryland' AS country,	1000000 AS population,		500 AS area FROM dual UNION all
SELECT 'Smallville' AS city,	'Countryland' AS country,	50000 AS population,		1000 AS area FROM dual UNION all
SELECT 'Coastcity' AS city,	'Oceanland' AS country, 	300000 AS population,		0 AS area FROM dual UNION all
SELECT 'Starcity' AS city,	'Mountainous' AS country,	600000 AS population,		600 AS area FROM dual UNION all
SELECT 'Gotham' AS city, 	'Islander' AS country,	 	1500000 AS population,		300 AS area FROM dual UNION all
SELECT 'Rivertown' AS city,	'Plainsland' AS country,	100000 AS population,		5000 AS area FROM dual UNION all
SELECT 'Lakecity' AS city,	'Forestland' AS country,	100000 AS population,		5000 AS area FROM dual UNION all
SELECT 'Hilltown' AS city,	'Hillside' AS country,		200000 AS population,		450 AS area FROM dual UNION all
SELECT 'Forestville' AS city,	'Forestland' AS country,	500000 AS population,		700 AS area FROM dual UNION all
SELECT 'Oceanview' AS city,	'Seaside' AS country,		800000 AS population,		0 AS area FROM dual
),
city_details AS (
SELECT city, country, round(CASE WHEN area > 0 THEN population/area ELSE 0 END) AS density FROM cities_population
),
ranked_city AS (
SELECT city, country, density, DENSE_RANK() OVER (ORDER BY density) AS min_rank, DENSE_RANK() OVER (ORDER BY density desc) AS max_rank
FROM city_details
)
SELECT city, country, density FROM ranked_city WHERE min_rank = 1 OR max_rank = 1
;







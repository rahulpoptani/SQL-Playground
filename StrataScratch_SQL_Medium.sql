-- 2000: Variable vs Fixed Rates
-- Write a query that returns binary description of rate type per loan_id. The results should have one row per loan_id and two columns: for fixed and variable type.
with submissions as (
select 1 as id,	5229.12 as balance, 	8.75 as interest_rate,	'variable' as rate_type,	2 as loan_id from dual union all
select 2 as id,	12727.52 as balance, 	11.37 as interest_rate,	'fixed' as rate_type,		4 as loan_id from dual union all
select 3 as id,	14996.58 as balance, 	8.25 as interest_rate,	'fixed' as rate_type,		9 as loan_id from dual union all
select 4 as id,	21149.00 as balance, 	4.75 as interest_rate,	'variable' as rate_type,	7 as loan_id from dual union all
select 5 as id,	14379.00 as balance, 	3.75 as interest_rate,	'variable' as rate_type,	5 as loan_id from dual union all
select 6 as id,	6221.12 as balance, 	6.75 as interest_rate,	'variable' as rate_type,	11 as loan_id from dual
)
select loan_id, case when rate_type = 'fixed' then 1 else 0 end as fixed, case when rate_type = 'variable' then 1 else 0 end as variable from submissions;

-- 2001: Share of Loan Balance
-- Write a query that returns the rate_type, loan_id, loan balance , and a column that shows with what percentage the loan's balance contributes to the total balance among the loans of the same rate type.
with submissions as (
select 1 as id,	5229.12 as balance, 	8.75 as interest_rate,	'variable' as rate_type,	2 as loan_id from dual union all
select 2 as id,	12727.52 as balance, 	11.37 as interest_rate,	'fixed' as rate_type,		4 as loan_id from dual union all
select 3 as id,	14996.58 as balance, 	8.25 as interest_rate,	'fixed' as rate_type,		9 as loan_id from dual union all
select 4 as id,	21149.00 as balance, 	4.75 as interest_rate,	'variable' as rate_type,	7 as loan_id from dual union all
select 5 as id,	14379.00 as balance, 	3.75 as interest_rate,	'variable' as rate_type,	5 as loan_id from dual union all
select 6 as id,	6221.12 as balance, 	6.75 as interest_rate,	'variable' as rate_type,	11 as loan_id from dual
)
select loan_id, rate_type, balance, round(balance/sum(balance) over (partition by rate_type) * 100, 3) as balance_share from submissions;

-- 2003: Recent Refinance Submissions
-- Write a query that joins this submissions table to the loans table and returns the total loan balance on each user’s most recent ‘Refinance’ submission. Return all users and the balance for each of them.
with loans as (
select 1 as id,		100 as user_id,	'2017-04-21' as created_at,	'prequal_completd_offer' as status,	'Refinance' as type from dual union all
select 2 as id,		100 as user_id,	'2017-04-27' as created_at,	'offer_accepted' as status,		'Refinance' as type from dual union all
select 3 as id,		101 as user_id,	'2017-04-22' as created_at,	'prequal_completd_no_offer' as status,	'Refinance' as type from dual union all
select 4 as id,		101 as user_id,	'2017-04-23' as created_at,	'offer_accepted' as status,		'Refinance' as type from dual union all
select 5 as id,		101 as user_id,	'2017-04-25' as created_at,	'offer_accepted' as status,		'Personal' as type from dual union all
select 6 as id,		102 as user_id,	'2017-04-27' as created_at,	'offer_accepted' as status,		'InSchool' as type from dual union all
select 7 as id,		107 as user_id,	'2017-04-27' as created_at,	'prequal_response_received' as status,	'Personal' as type from dual union all
select 8 as id,		108 as user_id,	'2017-04-21' as created_at,	'form_in_progress' as status,		'Refinance' as type from dual union all
select 9 as id,		108 as user_id,	'2017-04-27' as created_at,	'offer_accepted' as status,		'Refinance' as type from dual union all
select 10 as id,	108 as user_id,	'2017-04-27' as created_at,	'prequal_response_received' as status,	'InSchool' as type from dual union all
select 11 as id,	100 as user_id,	'2015-04-21' as created_at,	'prequal_completd_offer' as status,	'Refinance' as type from dual
),
submissions as (
select 1 as id,	5229.12 as balance,	8.75 as interest_rate,	'variable' as rate_type,	2 as loan_id from dual union all
select 2 as id,	12727.52 as balance,	11.37 as interest_rate,	'fixed' as rate_type,		4 as loan_id from dual union all
select 3 as id,	14996.58 as balance,	8.25 as interest_rate,	'fixed' as rate_type,		9 as loan_id from dual union all
select 4 as id,	21149.00 as balance,	4.75 as interest_rate,	'variable' as rate_type,	7 as loan_id from dual union all
select 5 as id,	14379.00 as balance,	3.75 as interest_rate,	'variable' as rate_type,	5 as loan_id from dual union all
select 6 as id,	6221.12 as balance,	6.75 as interest_rate,	'variable' as rate_type,	11 as loan_id from dual
),
ranked as (
select l.user_id, s.balance, rank() over (partition by l.user_id order by created_at desc) as rnk from loans l join submissions s on s.loan_id = l.id where l.type = 'Refinance')
select user_id, balance from ranked where rnk = 1;

-- 2005: Share of Active Users
-- Output share of US users that are active. Active users are the ones with an "open" status in the table.
with fb_active_users as (
select 33 as user_id,	'Amanda Leon' as name,		'open' as status,	'Australia' as country from dual union all
select 27 as user_id,	'Jessica Farrell' as name,	'open' as status,	'Luxembourg' as country from dual union all
select 18 as user_id,	'Wanda Ramirez' as name,	'open' as status,	'USA' as country from dual union all
select 50 as user_id,	'Samuel Miller' as name,	'closed' as status,	'Brazil' as country from dual union all
select 16 as user_id,	'Jacob York' as name,		'open' as status,	'Australia' as country from dual union all
select 25 as user_id,	'Natasha Bradford' as name,	'closed' as status,	'USA' as country from dual union all
select 34 as user_id,	'Donald Ross' as name,		'closed' as status,	'China' as country from dual union all
select 52 as user_id,	'Michelle Jimenez' as name,	'open' as status,	'USA' as country from dual union all
select 11 as user_id,	'Theresa John' as name,		'open' as status,	'China' as country from dual union all
select 37 as user_id,	'Michael Turner' as name,	'closed' as status,	'Australia' as country from dual union all
select 32 as user_id,	'Catherine Hurst' as name,	'closed' as status,	'Mali' as country from dual union all
select 61 as user_id,	'Tina Turner' as name,		'open' as status,	'Luxembourg' as country from dual union all
select 4 as user_id,	'Ashley Sparks' as name,	'open' as status,	'China' as country from dual union all
select 82 as user_id,	'Jacob York' as name,		'closed' as status,	'USA' as country from dual union all
select 87 as user_id,	'David Taylor' as name,		'closed' as status,	'USA' as country from dual union all
select 78 as user_id,	'Zachary Anderson' as name,	'open' as status,	'China' as country from dual union all
select 5 as user_id,	'Tiger Leon' as name,		'closed' as status,	'China' as country from dual union all
select 56 as user_id,	'Theresa Weaver' as name,	'closed' as status,	'Brazil' as country from dual union all
select 21 as user_id,	'Tonya Johnson' as name,	'closed' as status,	'Mali' as country from dual union all
select 89 as user_id,	'Kyle Curry' as name,		'closed' as status,	'Mali' as country from dual union all
select 7 as user_id,	'Donald Jim' as name,		'open' as status,	'USA' as country from dual union all
select 22 as user_id,	'Michael Bone' as name,		'open' as status,	'Canada' as country from dual union all
select 31 as user_id,	'Sara Michaels' as name,	'open' as status,	'Denmark' as country from dual
)
select sum(case when country='USA' and status='open' then 1 else 0 end) / sum(case when country='USA' then 1 else 0 end) as active_users_share from fb_active_users;


-- 2010: Top Streamers
-- List the top 10 users who accumulated the most sessions where they had more streaming sessions than viewing. Return the user_id, number of streaming sessions, and number of viewing sessions.
with twitch_sessions as (
select 0 as user_id,	'2020-08-11 05:51:31' as session_start,	'2020-08-11 05:54:45' as session_end,	'539' as session_id,	'streamer' as session_type from dual union all
select 2 as user_id,	'2020-07-11 03:36:54' as session_start,	'2020-07-11 03:37:08' as session_end,	'840' as session_id,	'streamer' as session_type from dual union all
select 3 as user_id,	'2020-11-26 11:41:47' as session_start,	'2020-11-26 11:52:01' as session_end,	'848' as session_id,	'streamer' as session_type from dual union all
select 1 as user_id,	'2020-11-19 06:24:24' as session_start,	'2020-11-19 07:24:38' as session_end,	'515' as session_id,	'viewer' as session_type from dual union all
select 2 as user_id,	'2020-11-14 03:36:05' as session_start,	'2020-11-14 03:39:19' as session_end,	'646' as session_id,	'viewer' as session_type from dual union all
select 0 as user_id,	'2020-03-11 03:01:40' as session_start,	'2020-03-11 03:01:59' as session_end,	'782' as session_id,	'streamer' as session_type from dual union all
select 0 as user_id,	'2020-08-11 03:50:45' as session_start,	'2020-08-11 03:55:59' as session_end,	'815' as session_id,	'viewer' as session_type from dual union all
select 3 as user_id,	'2020-10-11 22:15:14' as session_start,	'2020-10-11 22:18:28' as session_end,	'630' as session_id,	'viewer' as session_type from dual union all
select 1 as user_id,	'2020-11-20 06:59:57' as session_start,	'2020-11-20 07:20:11' as session_end,	'907' as session_id,	'streamer' as session_type from dual union all
select 2 as user_id,	'2020-07-11 14:32:19' as session_start,	'2020-07-11 14:42:33' as session_end,	'949' as session_id,	'viewer' as session_type from dual
)
select user_id, sum(case when session_type = 'streamer' then 1 else 0 end) as streaming, sum(case when session_type = 'viewer' then 1 else 0 end) as "view"
from twitch_sessions
group by user_id
having sum(case when session_type = 'streamer' then 1 else 0 end) > sum(case when session_type = 'viewer' then 1 else 0 end);


--2014: Hour With The Highest Order Volume
-- Which hour has the highest average order volume per day? Your output should have the hour which satisfies that condition, and average order volume.
with postmates_orders as (
select 1 as id,		102 as customer_id,	224 as courier_id,	79 as seller_id,	'2019-03-11 23:27:00' as order_timestamp_utc,	155.73 as amount,	47 as city_id from dual union all
select 2 as id,		104 as customer_id,	224 as courier_id,	75 as seller_id,	'2019-04-11 04:24:00' as order_timestamp_utc,	216.6 as amount,	44 as city_id from dual union all
select 3 as id,		100 as customer_id,	239 as courier_id,	79 as seller_id,	'2019-03-11 21:17:00' as order_timestamp_utc,	168.69 as amount,	47 as city_id from dual union all
select 4 as id,		101 as customer_id,	205 as courier_id,	79 as seller_id,	'2019-03-11 02:34:00' as order_timestamp_utc,	210.84 as amount,	43 as city_id from dual union all
select 5 as id,		103 as customer_id,	218 as courier_id,	71 as seller_id,	'2019-04-11 00:15:00' as order_timestamp_utc,	212.6 as amount,	47 as city_id from dual union all
select 6 as id,		102 as customer_id,	201 as courier_id,	77 as seller_id,	'2019-03-11 18:22:00' as order_timestamp_utc,	220.83 as amount,	47 as city_id from dual union all
select 7 as id,		103 as customer_id,	205 as courier_id,	79 as seller_id,	'2019-04-11 11:15:00' as order_timestamp_utc,	94.86 as amount,	49 as city_id from dual union all
select 8 as id,		101 as customer_id,	246 as courier_id,	77 as seller_id,	'2019-03-11 04:12:00' as order_timestamp_utc,	86.15 as amount,	49 as city_id from dual union all
select 9 as id,		101 as customer_id,	218 as courier_id,	79 as seller_id,	'2019-03-11 08:59:00' as order_timestamp_utc,	75.52 as amount,	43 as city_id from dual union all
select 10 as id,	103 as customer_id,	211 as courier_id,	77 as seller_id,	'2019-03-11 00:22:00' as order_timestamp_utc,	15.85 as amount,	49 as city_id from dual union all
select 11 as id,	102 as customer_id,	223 as courier_id,	79 as seller_id,	'2019-03-11 10:44:00' as order_timestamp_utc,	59.69 as amount,	49 as city_id from dual union all
select 12 as id,	104 as customer_id,	211 as courier_id,	77 as seller_id,	'2019-03-11 01:37:00' as order_timestamp_utc,	153.61 as amount,	44 as city_id from dual union all
select 13 as id,	100 as customer_id,	204 as courier_id,	71 as seller_id,	'2019-03-11 07:00:00' as order_timestamp_utc,	190.29 as amount,	43 as city_id from dual union all
select 14 as id,	100 as customer_id,	231 as courier_id,	79 as seller_id,	'2019-03-11 03:12:00' as order_timestamp_utc,	115.45 as amount,	49 as city_id from dual union all
select 15 as id,	104 as customer_id,	246 as courier_id,	75 as seller_id,	'2019-04-11 08:52:00' as order_timestamp_utc,	225.91 as amount,	47 as city_id from dual union all
select 16 as id,	102 as customer_id,	231 as courier_id,	77 as seller_id,	'2019-03-11 08:26:00' as order_timestamp_utc,	158.68 as amount,	43 as city_id from dual union all
select 17 as id,	102 as customer_id,	246 as courier_id,	79 as seller_id,	'2019-04-11 01:15:00' as order_timestamp_utc,	62.72 as amount,	49 as city_id from dual union all
select 18 as id,	100 as customer_id,	205 as courier_id,	77 as seller_id,	'2019-03-11 03:10:00' as order_timestamp_utc,	125.65 as amount,	49 as city_id from dual union all
select 19 as id,	104 as customer_id,	204 as courier_id,	77 as seller_id,	'2019-04-11 08:14:00' as order_timestamp_utc,	129.75 as amount,	44 as city_id from dual union all
select 20 as id,	101 as customer_id,	231 as courier_id,	75 as seller_id,	'2019-04-11 10:49:00' as order_timestamp_utc,	105.07 as amount,	43 as city_id from dual
),
hour_detail as (
select extract(DAY from to_timestamp(order_timestamp_utc, 'YYYY-DD-MM HH24:MI:SS')) as order_day, extract(HOUR from to_timestamp(order_timestamp_utc, 'YYYY-DD-MM HH24:MI:SS')) as "hour", id from postmates_orders
),
order_vol_detail as (
select order_day, "hour", count(*) as avg_orders from hour_detail group by order_day, "hour"
),
ranked_order as (
select order_day, "hour", avg_orders, rank() over (order by avg_orders desc) as rnk from order_vol_detail
) 
select distinct "hour", avg_orders from ranked_order where rnk = 1 order by "hour";


-- 2015: City With The Highest and Lowest Income Variance
-- What cities recorded the largest growth and biggest drop in order amount between March 11, 2019, and April 11, 2019. Just compare order amounts on those two dates. Your output should include the names of the cities and the amount of growth/drop.
with postmates_orders as (
select 1 as id,		102 as customer_id,	224 as courier_id,	79 as seller_id,	'2019-03-11 23:27:00' as order_timestamp_utc,	155.73 as amount,	47 as city_id from dual union all
select 2 as id,		104 as customer_id,	224 as courier_id,	75 as seller_id,	'2019-04-11 04:24:00' as order_timestamp_utc,	216.6 as amount,	44 as city_id from dual union all
select 3 as id,		100 as customer_id,	239 as courier_id,	79 as seller_id,	'2019-03-11 21:17:00' as order_timestamp_utc,	168.69 as amount,	47 as city_id from dual union all
select 4 as id,		101 as customer_id,	205 as courier_id,	79 as seller_id,	'2019-03-11 02:34:00' as order_timestamp_utc,	210.84 as amount,	43 as city_id from dual union all
select 5 as id,		103 as customer_id,	218 as courier_id,	71 as seller_id,	'2019-04-11 00:15:00' as order_timestamp_utc,	212.6 as amount,	47 as city_id from dual union all
select 6 as id,		102 as customer_id,	201 as courier_id,	77 as seller_id,	'2019-03-11 18:22:00' as order_timestamp_utc,	220.83 as amount,	47 as city_id from dual union all
select 7 as id,		103 as customer_id,	205 as courier_id,	79 as seller_id,	'2019-04-11 11:15:00' as order_timestamp_utc,	94.86 as amount,	49 as city_id from dual union all
select 8 as id,		101 as customer_id,	246 as courier_id,	77 as seller_id,	'2019-03-11 04:12:00' as order_timestamp_utc,	86.15 as amount,	49 as city_id from dual union all
select 9 as id,		101 as customer_id,	218 as courier_id,	79 as seller_id,	'2019-03-11 08:59:00' as order_timestamp_utc,	75.52 as amount,	43 as city_id from dual union all
select 10 as id,	103 as customer_id,	211 as courier_id,	77 as seller_id,	'2019-03-11 00:22:00' as order_timestamp_utc,	15.85 as amount,	49 as city_id from dual union all
select 11 as id,	102 as customer_id,	223 as courier_id,	79 as seller_id,	'2019-03-11 10:44:00' as order_timestamp_utc,	59.69 as amount,	49 as city_id from dual union all
select 12 as id,	104 as customer_id,	211 as courier_id,	77 as seller_id,	'2019-03-11 01:37:00' as order_timestamp_utc,	153.61 as amount,	44 as city_id from dual union all
select 13 as id,	100 as customer_id,	204 as courier_id,	71 as seller_id,	'2019-03-11 07:00:00' as order_timestamp_utc,	190.29 as amount,	43 as city_id from dual union all
select 14 as id,	100 as customer_id,	231 as courier_id,	79 as seller_id,	'2019-03-11 03:12:00' as order_timestamp_utc,	115.45 as amount,	49 as city_id from dual union all
select 15 as id,	104 as customer_id,	246 as courier_id,	75 as seller_id,	'2019-04-11 08:52:00' as order_timestamp_utc,	225.91 as amount,	47 as city_id from dual union all
select 16 as id,	102 as customer_id,	231 as courier_id,	77 as seller_id,	'2019-03-11 08:26:00' as order_timestamp_utc,	158.68 as amount,	43 as city_id from dual union all
select 17 as id,	102 as customer_id,	246 as courier_id,	79 as seller_id,	'2019-04-11 01:15:00' as order_timestamp_utc,	62.72 as amount,	49 as city_id from dual union all
select 18 as id,	100 as customer_id,	205 as courier_id,	77 as seller_id,	'2019-03-11 03:10:00' as order_timestamp_utc,	125.65 as amount,	49 as city_id from dual union all
select 19 as id,	104 as customer_id,	204 as courier_id,	77 as seller_id,	'2019-04-11 08:14:00' as order_timestamp_utc,	129.75 as amount,	44 as city_id from dual union all
select 20 as id,	101 as customer_id,	231 as courier_id,	75 as seller_id,	'2019-04-11 10:49:00' as order_timestamp_utc,	105.07 as amount,	43 as city_id from dual
),
postmates_markets as (
select 43 as id,	'Boston' as name,	'EST' as timezone from dual union all
select 44 as id,	'Seattle' as name,	'PST' as timezone from dual union all
select 47 as id,	'Denver' as name,	'MST' as timezone from dual union all
select 49 as id,	'Chicago' as name,	'CST' as timezone from dual
),
agg_res as (
select city_id, trunc(to_date(order_timestamp_utc, 'YYYY-MM-DD HH24:MI:SS')) as dayy, sum(amount), lead(sum(amount), 1) over (partition by city_id order by trunc(to_date(order_timestamp_utc, 'YYYY-MM-DD HH24:MI:SS'))) - sum(amount) as amount_difference
from postmates_orders po
group by city_id, trunc(to_date(order_timestamp_utc, 'YYYY-MM-DD HH24:MI:SS')))
select name, amount_difference from agg_res ar join postmates_markets pm on ar.city_id = pm.id where amount_difference in (select max(amount_difference) from agg_res union all select min(amount_difference) from agg_res);


-- 2016: Pizza Partners
-- Which partners have ‘pizza’ in their name and are located in Boston? And what is the average order amount? Output the partner name and the average order amount.
with postmates_orders as (
select 1 as id,		102 as customer_id,	224 as courier_id,	79 as seller_id,	'2019-03-11 23:27:00' as order_timestamp_utc,	155.73 as amount,	47 as city_id from dual union all
select 2 as id,		104 as customer_id,	224 as courier_id,	75 as seller_id,	'2019-04-11 04:24:00' as order_timestamp_utc,	216.6 as amount,	44 as city_id from dual union all
select 3 as id,		100 as customer_id,	239 as courier_id,	79 as seller_id,	'2019-03-11 21:17:00' as order_timestamp_utc,	168.69 as amount,	47 as city_id from dual union all
select 4 as id,		101 as customer_id,	205 as courier_id,	79 as seller_id,	'2019-03-11 02:34:00' as order_timestamp_utc,	210.84 as amount,	43 as city_id from dual union all
select 5 as id,		103 as customer_id,	218 as courier_id,	71 as seller_id,	'2019-04-11 00:15:00' as order_timestamp_utc,	212.6 as amount,	47 as city_id from dual union all
select 6 as id,		102 as customer_id,	201 as courier_id,	77 as seller_id,	'2019-03-11 18:22:00' as order_timestamp_utc,	220.83 as amount,	47 as city_id from dual union all
select 7 as id,		103 as customer_id,	205 as courier_id,	79 as seller_id,	'2019-04-11 11:15:00' as order_timestamp_utc,	94.86 as amount,	49 as city_id from dual union all
select 8 as id,		101 as customer_id,	246 as courier_id,	77 as seller_id,	'2019-03-11 04:12:00' as order_timestamp_utc,	86.15 as amount,	49 as city_id from dual union all
select 9 as id,		101 as customer_id,	218 as courier_id,	79 as seller_id,	'2019-03-11 08:59:00' as order_timestamp_utc,	75.52 as amount,	43 as city_id from dual union all
select 10 as id,	103 as customer_id,	211 as courier_id,	77 as seller_id,	'2019-03-11 00:22:00' as order_timestamp_utc,	15.85 as amount,	49 as city_id from dual union all
select 11 as id,	102 as customer_id,	223 as courier_id,	79 as seller_id,	'2019-03-11 10:44:00' as order_timestamp_utc,	59.69 as amount,	49 as city_id from dual union all
select 12 as id,	104 as customer_id,	211 as courier_id,	77 as seller_id,	'2019-03-11 01:37:00' as order_timestamp_utc,	153.61 as amount,	44 as city_id from dual union all
select 13 as id,	100 as customer_id,	204 as courier_id,	71 as seller_id,	'2019-03-11 07:00:00' as order_timestamp_utc,	190.29 as amount,	43 as city_id from dual union all
select 14 as id,	100 as customer_id,	231 as courier_id,	79 as seller_id,	'2019-03-11 03:12:00' as order_timestamp_utc,	115.45 as amount,	49 as city_id from dual union all
select 15 as id,	104 as customer_id,	246 as courier_id,	75 as seller_id,	'2019-04-11 08:52:00' as order_timestamp_utc,	225.91 as amount,	47 as city_id from dual union all
select 16 as id,	102 as customer_id,	231 as courier_id,	77 as seller_id,	'2019-03-11 08:26:00' as order_timestamp_utc,	158.68 as amount,	43 as city_id from dual union all
select 17 as id,	102 as customer_id,	246 as courier_id,	79 as seller_id,	'2019-04-11 01:15:00' as order_timestamp_utc,	62.72 as amount,	49 as city_id from dual union all
select 18 as id,	100 as customer_id,	205 as courier_id,	77 as seller_id,	'2019-03-11 03:10:00' as order_timestamp_utc,	125.65 as amount,	49 as city_id from dual union all
select 19 as id,	104 as customer_id,	204 as courier_id,	77 as seller_id,	'2019-04-11 08:14:00' as order_timestamp_utc,	129.75 as amount,	44 as city_id from dual union all
select 20 as id,	101 as customer_id,	231 as courier_id,	75 as seller_id,	'2019-04-11 10:49:00' as order_timestamp_utc,	105.07 as amount,	43 as city_id from dual
),
postmates_markets as (
select 43 as id,	'Boston' as name,	'EST' as timezone from dual union all
select 44 as id,	'Seattle' as name,	'PST' as timezone from dual union all
select 47 as id,	'Denver' as name,	'MST' as timezone from dual union all
select 49 as id,	'Chicago' as name,	'CST' as timezone from dual
),postmates_partners as (
select 71 as id,	'Papa John''s' as name,	  	'Pizza' as category from dual union all
select 75 as id,	'Domino''s Pizza' as name,	'Pizza' as category from dual union all
select 77 as id,	'Pizza Hut' as name,		'Pizza' as category from dual union all
select 79 as id,	'Papa Murphy''s' as name,	'Pizza' as category from dual
)
select pp.name, po.amount as avg from postmates_orders po join postmates_markets pm on po.city_id = pm.id join postmates_partners pp on po.seller_id = pp.id
where lower(pp.name) like '%pizza%' and pm.name = 'Boston';
	

-- 2019: Top 2 Users With Most Calls
-- Return the top 2 users in each company that called the most. Output the company_id, user_id, and the user's rank. If there are multiple users in the same rank, keep all of them.
with rc_calls as (
select 1218 as user_id,	 '2020-04-19 01:06:00' as "date",	0 as call_id from dual union all
select 1554 as user_id,	 '2020-03-01 16:51:00' as "date",	1 as call_id from dual union all
select 1857 as user_id,	 '2020-03-29 07:06:00' as "date",	2 as call_id from dual union all
select 1525 as user_id,	 '2020-03-07 02:01:00' as "date",	3 as call_id from dual union all
select 1271 as user_id,	 '2020-04-28 21:39:00' as "date",	4 as call_id from dual union all
select 1181 as user_id,	 '2020-03-18 04:49:00' as "date",	5 as call_id from dual union all
select 1950 as user_id,	 '2020-04-12 23:57:00' as "date",	6 as call_id from dual union all
select 1339 as user_id,	 '2020-04-11 02:15:00' as "date",	7 as call_id from dual union all
select 1910 as user_id,	 '2020-03-21 08:56:00' as "date",	8 as call_id from dual union all
select 1093 as user_id,	 '2020-03-07 15:47:00' as "date",	9 as call_id from dual union all
select 1859 as user_id,	 '2020-04-25 13:55:00' as "date",	10 as call_id from dual union all
select 1079 as user_id,	 '2020-04-17 16:38:00' as "date",	11 as call_id from dual union all
select 1519 as user_id,	 '2020-04-15 12:14:00' as "date",	12 as call_id from dual union all
select 1854 as user_id,	 '2020-04-25 19:59:00' as "date",	13 as call_id from dual union all
select 1968 as user_id,	 '2020-03-16 21:19:00' as "date",	14 as call_id from dual union all
select 1891 as user_id,	 '2020-03-30 23:11:00' as "date",	15 as call_id from dual union all
select 1575 as user_id,	 '2020-03-14 15:21:00' as "date",	16 as call_id from dual union all
select 1162 as user_id,	 '2020-04-06 18:39:00' as "date",	17 as call_id from dual union all
select 1503 as user_id,	 '2020-04-01 18:31:00' as "date",	18 as call_id from dual union all
select 1884 as user_id,	 '2020-04-08 08:44:00' as "date",	19 as call_id from dual union all
select 1854 as user_id,	 '2020-03-10 10:04:00' as "date",	20 as call_id from dual union all
select 1525 as user_id,	 '2020-03-04 14:44:00' as "date",	21 as call_id from dual union all
select 1181 as user_id,	 '2020-03-02 17:07:00' as "date",	22 as call_id from dual union all
select 1503 as user_id,	 '2020-03-29 11:17:00' as "date",	23 as call_id from dual union all
select 1859 as user_id,	 '2020-04-11 14:26:00' as "date",	24 as call_id from dual union all
select 1859 as user_id,	 '2020-03-13 23:52:00' as "date",	25 as call_id from dual union all
select 1859 as user_id,	 '2020-04-10 00:41:00' as "date",	26 as call_id from dual union all
select 1854 as user_id,	 '2020-03-28 00:35:00' as "date",	27 as call_id from dual union all
select 1891 as user_id,	 '2020-04-27 22:09:00' as "date",	28 as call_id from dual union all
select 1181 as user_id,	 '2020-04-19 06:39:00' as "date",	29 as call_id from dual union all
select 1525 as user_id,	 '2020-04-15 22:27:00' as "date",	30 as call_id from dual union all
select 1093 as user_id,	 '2020-03-17 15:21:00' as "date",	31 as call_id from dual union all
select 1857 as user_id,	 '2020-04-03 02:00:00' as "date",	32 as call_id from dual union all
select 1884 as user_id,	 '2020-03-20 14:41:00' as "date",	33 as call_id from dual union all
select 1950 as user_id,	 '2020-03-17 11:17:00' as "date",	34 as call_id from dual union all
select 1162 as user_id,	 '2020-04-15 03:38:00' as "date",	35 as call_id from dual union all
select 1162 as user_id,	 '2020-03-08 06:47:00' as "date",	36 as call_id from dual union all
select 1891 as user_id,	 '2020-04-22 01:46:00' as "date",	37 as call_id from dual union all
select 1554 as user_id,	 '2020-04-08 05:35:00' as "date",	38 as call_id from dual union all
select 1910 as user_id,	 '2020-03-11 08:33:00' as "date",	39 as call_id from dual
),
rc_users as (
select 1218 as user_id,	'free' as status,	1 as company_id from dual union all
select 1554 as user_id,	'inactive' as status,	1 as company_id from dual union all
select 1857 as user_id,	'free' as status,	2 as company_id from dual union all
select 1525 as user_id,	'paid' as status,	1 as company_id from dual union all
select 1271 as user_id,	'inactive' as status,	2 as company_id from dual union all
select 1181 as user_id,	'inactive' as status,	2 as company_id from dual union all
select 1950 as user_id,	'free' as status,	1 as company_id from dual union all
select 1339 as user_id,	'free' as status,	2 as company_id from dual union all
select 1910 as user_id,	'free' as status,	2 as company_id from dual union all
select 1093 as user_id,	'paid' as status,	3 as company_id from dual union all
select 1859 as user_id,	'free' as status,	1 as company_id from dual union all
select 1079 as user_id,	'paid' as status,	2 as company_id from dual union all
select 1519 as user_id,	'inactive' as status,	2 as company_id from dual union all
select 1854 as user_id,	'paid' as status,	1 as company_id from dual union all
select 1968 as user_id,	'inactive' as status,	2 as company_id from dual union all
select 1891 as user_id,	'paid' as status,	2 as company_id from dual union all
select 1575 as user_id,	'free' as status,	2 as company_id from dual union all
select 1162 as user_id,	'paid' as status,	2 as company_id from dual union all
select 1503 as user_id,	'inactive' as status,	3 as company_id from dual union all
select 1884 as user_id,	'free' as status,	1 as company_id from dual
),
agg_res as (
select ru.company_id, ru.user_id, count(*) as calls_made from rc_calls rc join rc_users ru on rc.user_id = ru.user_id
group by ru.company_id, ru.user_id
),
ranked_result as (
select company_id, user_id, calls_made, dense_rank() over (partition by company_id order by calls_made desc) as rnk from agg_res
) select company_id, user_id, rnk as "rank" from ranked_result where rnk in (1,2);


-- 2020: Call Declines
-- Which company had the biggest month call decline from March to April 2020? Return the company_id and calls difference for the company with the highest decline.
with rc_calls as (
select 1218 as user_id,	 '2020-04-19 01:06:00' as "date",	0 as call_id from dual union all
select 1554 as user_id,	 '2020-03-01 16:51:00' as "date",	1 as call_id from dual union all
select 1857 as user_id,	 '2020-03-29 07:06:00' as "date",	2 as call_id from dual union all
select 1525 as user_id,	 '2020-03-07 02:01:00' as "date",	3 as call_id from dual union all
select 1271 as user_id,	 '2020-04-28 21:39:00' as "date",	4 as call_id from dual union all
select 1181 as user_id,	 '2020-03-18 04:49:00' as "date",	5 as call_id from dual union all
select 1950 as user_id,	 '2020-04-12 23:57:00' as "date",	6 as call_id from dual union all
select 1339 as user_id,	 '2020-04-11 02:15:00' as "date",	7 as call_id from dual union all
select 1910 as user_id,	 '2020-03-21 08:56:00' as "date",	8 as call_id from dual union all
select 1093 as user_id,	 '2020-03-07 15:47:00' as "date",	9 as call_id from dual union all
select 1859 as user_id,	 '2020-04-25 13:55:00' as "date",	10 as call_id from dual union all
select 1079 as user_id,	 '2020-04-17 16:38:00' as "date",	11 as call_id from dual union all
select 1519 as user_id,	 '2020-04-15 12:14:00' as "date",	12 as call_id from dual union all
select 1854 as user_id,	 '2020-04-25 19:59:00' as "date",	13 as call_id from dual union all
select 1968 as user_id,	 '2020-03-16 21:19:00' as "date",	14 as call_id from dual union all
select 1891 as user_id,	 '2020-03-30 23:11:00' as "date",	15 as call_id from dual union all
select 1575 as user_id,	 '2020-03-14 15:21:00' as "date",	16 as call_id from dual union all
select 1162 as user_id,	 '2020-04-06 18:39:00' as "date",	17 as call_id from dual union all
select 1503 as user_id,	 '2020-04-01 18:31:00' as "date",	18 as call_id from dual union all
select 1884 as user_id,	 '2020-04-08 08:44:00' as "date",	19 as call_id from dual union all
select 1854 as user_id,	 '2020-03-10 10:04:00' as "date",	20 as call_id from dual union all
select 1525 as user_id,	 '2020-03-04 14:44:00' as "date",	21 as call_id from dual union all
select 1181 as user_id,	 '2020-03-02 17:07:00' as "date",	22 as call_id from dual union all
select 1503 as user_id,	 '2020-03-29 11:17:00' as "date",	23 as call_id from dual union all
select 1859 as user_id,	 '2020-04-11 14:26:00' as "date",	24 as call_id from dual union all
select 1859 as user_id,	 '2020-03-13 23:52:00' as "date",	25 as call_id from dual union all
select 1859 as user_id,	 '2020-04-10 00:41:00' as "date",	26 as call_id from dual union all
select 1854 as user_id,	 '2020-03-28 00:35:00' as "date",	27 as call_id from dual union all
select 1891 as user_id,	 '2020-04-27 22:09:00' as "date",	28 as call_id from dual union all
select 1181 as user_id,	 '2020-04-19 06:39:00' as "date",	29 as call_id from dual union all
select 1525 as user_id,	 '2020-04-15 22:27:00' as "date",	30 as call_id from dual union all
select 1093 as user_id,	 '2020-03-17 15:21:00' as "date",	31 as call_id from dual union all
select 1857 as user_id,	 '2020-04-03 02:00:00' as "date",	32 as call_id from dual union all
select 1884 as user_id,	 '2020-03-20 14:41:00' as "date",	33 as call_id from dual union all
select 1950 as user_id,	 '2020-03-17 11:17:00' as "date",	34 as call_id from dual union all
select 1162 as user_id,	 '2020-04-15 03:38:00' as "date",	35 as call_id from dual union all
select 1162 as user_id,	 '2020-03-08 06:47:00' as "date",	36 as call_id from dual union all
select 1891 as user_id,	 '2020-04-22 01:46:00' as "date",	37 as call_id from dual union all
select 1554 as user_id,	 '2020-04-08 05:35:00' as "date",	38 as call_id from dual union all
select 1910 as user_id,	 '2020-03-11 08:33:00' as "date",	39 as call_id from dual
),
rc_users as (
select 1218 as user_id,	'free' as status,	1 as company_id from dual union all
select 1554 as user_id,	'inactive' as status,	1 as company_id from dual union all
select 1857 as user_id,	'free' as status,	2 as company_id from dual union all
select 1525 as user_id,	'paid' as status,	1 as company_id from dual union all
select 1271 as user_id,	'inactive' as status,	2 as company_id from dual union all
select 1181 as user_id,	'inactive' as status,	2 as company_id from dual union all
select 1950 as user_id,	'free' as status,	1 as company_id from dual union all
select 1339 as user_id,	'free' as status,	2 as company_id from dual union all
select 1910 as user_id,	'free' as status,	2 as company_id from dual union all
select 1093 as user_id,	'paid' as status,	3 as company_id from dual union all
select 1859 as user_id,	'free' as status,	1 as company_id from dual union all
select 1079 as user_id,	'paid' as status,	2 as company_id from dual union all
select 1519 as user_id,	'inactive' as status,	2 as company_id from dual union all
select 1854 as user_id,	'paid' as status,	1 as company_id from dual union all
select 1968 as user_id,	'inactive' as status,	2 as company_id from dual union all
select 1891 as user_id,	'paid' as status,	2 as company_id from dual union all
select 1575 as user_id,	'free' as status,	2 as company_id from dual union all
select 1162 as user_id,	'paid' as status,	2 as company_id from dual union all
select 1503 as user_id,	'inactive' as status,	3 as company_id from dual union all
select 1884 as user_id,	'free' as status,	1 as company_id from dual
),
agg_res as (
select extract(MONTH from to_date("date", 'YYYY-MM-DD HH24:MI:SS')) as call_month, ru.company_id from rc_calls rc join rc_users ru on rc.user_id = ru.user_id
where extract(YEAR from to_date("date", 'YYYY-MM-DD HH24:MI:SS')) = 2020 and extract(MONTH from to_date("date", 'YYYY-MM-DD HH24:MI:SS')) in (3,4)
),
total_calls as (
select company_id, call_month, count(*) as total_calls from agg_res group by company_id, call_month
),
biggest_decline as (
select company_id, call_month, lead(total_calls, 1) over (partition by company_id order by call_month) - total_calls as variance from total_calls order by 3 nulls last
) 
select company_id, variance from biggest_decline where rownum = 1;


--2021: Initial Call Duration
-- Redfin helps clients to find agents. Each client will have a unique request_id and each request_id has several calls. For each request_id, the first call is an “initial call” and all the following calls are “update calls”.  What's the average call duration for all initial calls?
with redfin_call_tracking as (
select '2020-03-01 04:08:04' as created_on,	2 as request_id,	3 as call_duration,	1 as id from dual union all
select '2020-03-01 05:28:47' as created_on,	1 as request_id,	28 as call_duration,	2 as id from dual union all
select '2020-03-01 07:27:36' as created_on,	2 as request_id,	22 as call_duration,	3 as id from dual union all
select '2020-03-01 13:18:21' as created_on,	1 as request_id,	12 as call_duration,	4 as id from dual union all
select '2020-03-01 15:08:08' as created_on,	2 as request_id,	13 as call_duration,	5 as id from dual union all
select '2020-03-01 16:27:23' as created_on,	1 as request_id,	19 as call_duration,	6 as id from dual union all
select '2020-03-01 17:38:01' as created_on,	3 as request_id,	15 as call_duration,	7 as id from dual union all
select '2020-03-01 17:56:39' as created_on,	2 as request_id,	25 as call_duration,	8 as id from dual union all
select '2020-03-02 00:10:10' as created_on,	1 as request_id,	28 as call_duration,	9 as id from dual union all
select '2020-03-02 00:45:49' as created_on,	3 as request_id,	19 as call_duration,	10 as id from dual union all
select '2020-03-02 04:28:44' as created_on,	3 as request_id,	28 as call_duration,	11 as id from dual union all
select '2020-03-02 04:52:52' as created_on,	1 as request_id,	13 as call_duration,	12 as id from dual union all
select '2020-03-02 05:02:41' as created_on,	3 as request_id,	24 as call_duration,	13 as id from dual union all
select '2020-03-02 06:19:56' as created_on,	3 as request_id,	5 as call_duration,	14 as id from dual union all
select '2020-03-02 07:25:59' as created_on,	2 as request_id,	20 as call_duration,	15 as id from dual union all
select '2020-03-02 08:20:25' as created_on,	1 as request_id,	21 as call_duration,	16 as id from dual union all
select '2020-03-02 10:45:35' as created_on,	3 as request_id,	23 as call_duration,	17 as id from dual union all
select '2020-03-02 13:38:59' as created_on,	1 as request_id,	11 as call_duration,	18 as id from dual union all
select '2020-03-02 15:02:29' as created_on,	2 as request_id,	19 as call_duration,	19 as id from dual union all
select '2020-03-02 17:13:13' as created_on,	1 as request_id,	2 as call_duration,	20 as id from dual
)
select trunc(avg(call_duration),3) as avg from (
select call_duration, rank() over (partition by request_id order by created_on asc) as rnk from redfin_call_tracking
) where rnk = 1;


-- 2022: Update Call Duration
-- Redfin helps clients to find agents. Each client will have a unique request_id and each request_id has several calls. For each request_id, the first call is an “initial call” and all the following calls are “update calls”.  What's the average call duration for all update calls?
with redfin_call_tracking as (
select '2020-03-01 04:08:04' as created_on,	2 as request_id,	3 as call_duration,	1 as id from dual union all
select '2020-03-01 05:28:47' as created_on,	1 as request_id,	28 as call_duration,	2 as id from dual union all
select '2020-03-01 07:27:36' as created_on,	2 as request_id,	22 as call_duration,	3 as id from dual union all
select '2020-03-01 13:18:21' as created_on,	1 as request_id,	12 as call_duration,	4 as id from dual union all
select '2020-03-01 15:08:08' as created_on,	2 as request_id,	13 as call_duration,	5 as id from dual union all
select '2020-03-01 16:27:23' as created_on,	1 as request_id,	19 as call_duration,	6 as id from dual union all
select '2020-03-01 17:38:01' as created_on,	3 as request_id,	15 as call_duration,	7 as id from dual union all
select '2020-03-01 17:56:39' as created_on,	2 as request_id,	25 as call_duration,	8 as id from dual union all
select '2020-03-02 00:10:10' as created_on,	1 as request_id,	28 as call_duration,	9 as id from dual union all
select '2020-03-02 00:45:49' as created_on,	3 as request_id,	19 as call_duration,	10 as id from dual union all
select '2020-03-02 04:28:44' as created_on,	3 as request_id,	28 as call_duration,	11 as id from dual union all
select '2020-03-02 04:52:52' as created_on,	1 as request_id,	13 as call_duration,	12 as id from dual union all
select '2020-03-02 05:02:41' as created_on,	3 as request_id,	24 as call_duration,	13 as id from dual union all
select '2020-03-02 06:19:56' as created_on,	3 as request_id,	5 as call_duration,	14 as id from dual union all
select '2020-03-02 07:25:59' as created_on,	2 as request_id,	20 as call_duration,	15 as id from dual union all
select '2020-03-02 08:20:25' as created_on,	1 as request_id,	21 as call_duration,	16 as id from dual union all
select '2020-03-02 10:45:35' as created_on,	3 as request_id,	23 as call_duration,	17 as id from dual union all
select '2020-03-02 13:38:59' as created_on,	1 as request_id,	11 as call_duration,	18 as id from dual union all
select '2020-03-02 15:02:29' as created_on,	2 as request_id,	19 as call_duration,	19 as id from dual union all
select '2020-03-02 17:13:13' as created_on,	1 as request_id,	2 as call_duration,	20 as id from dual
)
select trunc(avg(call_duration),3) as avg from (
select call_duration, rank() over (partition by request_id order by created_on asc) as rnk from redfin_call_tracking
) where rnk = 1;


-- 2023: Rush Hour Calls
-- Redfin helps clients to find agents. Each client will have a unique request_id and each request_id has several calls. For each request_id, the first call is an “initial call” and all the following calls are “update calls”.  How many customers have called 3 or more times between 3 PM and 6 PM (initial and update calls combined)?
with redfin_call_tracking as (
select '2020-03-01 04:08:04' as created_on,	2 as request_id,	3 as call_duration,	1 as id from dual union all
select '2020-03-01 05:28:47' as created_on,	1 as request_id,	28 as call_duration,	2 as id from dual union all
select '2020-03-01 07:27:36' as created_on,	2 as request_id,	22 as call_duration,	3 as id from dual union all
select '2020-03-01 13:18:21' as created_on,	1 as request_id,	12 as call_duration,	4 as id from dual union all
select '2020-03-01 15:08:08' as created_on,	2 as request_id,	13 as call_duration,	5 as id from dual union all
select '2020-03-01 16:27:23' as created_on,	1 as request_id,	19 as call_duration,	6 as id from dual union all
select '2020-03-01 17:38:01' as created_on,	3 as request_id,	15 as call_duration,	7 as id from dual union all
select '2020-03-01 17:56:39' as created_on,	2 as request_id,	25 as call_duration,	8 as id from dual union all
select '2020-03-02 00:10:10' as created_on,	1 as request_id,	28 as call_duration,	9 as id from dual union all
select '2020-03-02 00:45:49' as created_on,	3 as request_id,	19 as call_duration,	10 as id from dual union all
select '2020-03-02 04:28:44' as created_on,	3 as request_id,	28 as call_duration,	11 as id from dual union all
select '2020-03-02 04:52:52' as created_on,	1 as request_id,	13 as call_duration,	12 as id from dual union all
select '2020-03-02 05:02:41' as created_on,	3 as request_id,	24 as call_duration,	13 as id from dual union all
select '2020-03-02 06:19:56' as created_on,	3 as request_id,	5 as call_duration,	14 as id from dual union all
select '2020-03-02 07:25:59' as created_on,	2 as request_id,	20 as call_duration,	15 as id from dual union all
select '2020-03-02 08:20:25' as created_on,	1 as request_id,	21 as call_duration,	16 as id from dual union all
select '2020-03-02 10:45:35' as created_on,	3 as request_id,	23 as call_duration,	17 as id from dual union all
select '2020-03-02 13:38:59' as created_on,	1 as request_id,	11 as call_duration,	18 as id from dual union all
select '2020-03-02 15:02:29' as created_on,	2 as request_id,	19 as call_duration,	19 as id from dual union all
select '2020-03-02 17:13:13' as created_on,	1 as request_id,	2 as call_duration,	20 as id from dual
)   
select count(*) as count from (
select request_id, count(*) from redfin_call_tracking where extract(HOUR from cast(to_date(created_on, 'YYYY-MM-DD HH24:MI:SS') as timestamp)) between 15 and 18
group by request_id having count(*) >= 3);


-- 2025: Users Exclusive Per Client
--Write a query that returns a number of users who are exclusive to only one client. Output the client_id and number of exclusive users.







-- 2125: Process a Refund
--with noom_signups as (
--select 'S001' as signup_id,	'2018-10-06' as started_at,	101 as plan_id from dual union all
--select 'S002' as signup_id,	'2018-11-01' as started_at,	101 as plan_id from dual union all
--select 'S003' as signup_id,	'2018-11-02' as started_at,	103 as plan_id from dual union all
--select 'S004' as signup_id,	'2018-11-05' as started_at,	103 as plan_id from dual union all
--select 'S005' as signup_id,	'2018-11-15' as started_at,	102 as plan_id from dual union all
--select 'S006' as signup_id,	'2018-12-14' as started_at,	102 as plan_id from dual union all
--select 'S007' as signup_id,	'2019-01-01' as started_at,	101 as plan_id from dual union all
--select 'S008' as signup_id,	'2019-01-14' as started_at,	102 as plan_id from dual union all
--select 'S009' as signup_id,	'2019-01-27' as started_at,	101 as plan_id from dual union all
--select 'S010' as signup_id,	'2019-02-04' as started_at,	102 as plan_id from dual union all
--select 'S011' as signup_id,	'2019-02-05' as started_at,	103 as plan_id from dual union all
--select 'S012' as signup_id,	'2019-02-23' as started_at,	102 as plan_id from dual union all
--select 'S013' as signup_id,	'2019-04-10' as started_at,	103 as plan_id from dual union all
--select 'S014' as signup_id,	'2019-05-20' as started_at,	101 as plan_id from dual union all
--select 'S015' as signup_id,	'2019-05-24' as started_at,	102 as plan_id from dual union all
--select 'S016' as signup_id,	'2019-06-30' as started_at,	103 as plan_id from dual union all
--select 'S017' as signup_id,	'2019-07-24' as started_at,	102 as plan_id from dual union all
--select 'S018' as signup_id,	'2019-08-10' as started_at,	103 as plan_id from dual union all
--select 'S019' as signup_id,	'2019-09-05' as started_at,	101 as plan_id from dual union all
--select 'S020' as signup_id,	'2019-09-09' as started_at,	101 as plan_id from dual union all
--select 'S021' as signup_id,	'2019-09-11' as started_at,	101 as plan_id from dual union all
--select 'S022' as signup_id,	'2019-09-23' as started_at,	102 as plan_id from dual union all
--select 'S023' as signup_id,	'2019-10-10' as started_at,	101 as plan_id from dual union all
--select 'S024' as signup_id,	'2019-12-10' as started_at,	101 as plan_id from dual union all
--select 'S025' as signup_id,	'2020-01-02' as started_at,	101 as plan_id from dual
--),
--noom_transactions as (
--select 1001 as transaction_id,	'S001' as signup_id,	'2019-02-09' as settled_at,	'2019-02-16' as refunded_at,	15 as usd_gross from dual union all
--select 1002 as transaction_id,	'S002' as signup_id,	'2019-02-27' as settled_at,	'2019-03-11' as refunded_at,	15 as usd_gross from dual union all
--select 1003 as transaction_id,	'S003' as signup_id,	'2019-03-09' as settled_at,	'2019-03-24' as refunded_at,	100 as usd_gross from dual union all
--select 1004 as transaction_id,	'S004' as signup_id,	'2019-03-10' as settled_at,	'2019-03-15' as refunded_at,	100 as usd_gross from dual union all
--select 1005 as transaction_id,	'S005' as signup_id,	'2019-03-27' as settled_at,	'2019-04-05' as refunded_at,	50 as usd_gross from dual union all
--select 1006 as transaction_id,	'S006' as signup_id,	'2019-04-01' as settled_at,	'2019-04-09' as refunded_at,	50 as usd_gross from dual union all
--select 1007 as transaction_id,	'S007' as signup_id,	'2019-04-18' as settled_at,	'2019-04-30' as refunded_at,	15 as usd_gross from dual union all
--select 1008 as transaction_id,	'S008' as signup_id,	'2019-05-03' as settled_at,	'2019-05-10' as refunded_at,	50 as usd_gross from dual union all
--select 1009 as transaction_id,	'S009' as signup_id,	'2019-05-10' as settled_at,	'2019-05-25' as refunded_at,	15 as usd_gross from dual union all
--select 1010 as transaction_id,	'S010' as signup_id,	'2019-07-10' as settled_at,	'2019-07-21' as refunded_at,	50 as usd_gross from dual union all
--select 1011 as transaction_id,	'S011' as signup_id,	'2019-07-28' as settled_at,	'2019-08-10' as refunded_at,	100 as usd_gross from dual union all
--select 1012 as transaction_id,	'S012' as signup_id,	'2019-09-09' as settled_at,	'2019-09-18' as refunded_at,	50 as usd_gross from dual union all
--select 1013 as transaction_id,	'S013' as signup_id,	'2019-09-15' as settled_at,	'2019-09-24' as refunded_at,	100 as usd_gross from dual union all
--select 1014 as transaction_id,	'S014' as signup_id,	'2019-11-08' as settled_at,	'2019-11-21' as refunded_at,	15 as usd_gross from dual union all
--select 1015 as transaction_id,	'S015' as signup_id,	'2019-11-22' as settled_at,	'2019-11-28' as refunded_at,	50 as usd_gross from dual union all
--select 1016 as transaction_id,	'S016' as signup_id,	'2019-12-03' as settled_at,	'2019-12-13' as refunded_at,	100 as usd_gross from dual union all
--select 1017 as transaction_id,	'S017' as signup_id,	'2019-12-11' as settled_at,	'2019-12-18' as refunded_at,	50 as usd_gross from dual union all
--select 1018 as transaction_id,	'S018' as signup_id,	'2020-01-23' as settled_at,	'2020-01-29' as refunded_at,	100 as usd_gross from dual union all
--select 1019 as transaction_id,	'S019' as signup_id,	'2020-04-30' as settled_at,	'2020-05-07' as refunded_at,	15 as usd_gross from dual union all
--select 1020 as transaction_id,	'S020' as signup_id,	'2020-07-05' as settled_at,	'2020-07-11' as refunded_at,	15 as usd_gross from dual union all
--select 1021 as transaction_id,	'S021' as signup_id,	'2020-07-07' as settled_at,	'2020-07-18' as refunded_at,	15 as usd_gross from dual union all
--select 1022 as transaction_id,	'S022' as signup_id,	'2020-07-14' as settled_at,	'2020-07-28' as refunded_at,	50 as usd_gross from dual union all
--select 1023 as transaction_id,	'S023' as signup_id,	'2020-09-03' as settled_at,	'2020-09-24' as refunded_at,	15 as usd_gross from dual union all
--select 1024 as transaction_id,	'S024' as signup_id,	'2020-09-27' as settled_at,	'2020-10-02' as refunded_at,	15 as usd_gross from dual union all
--select 1025 as transaction_id,	'S025' as signup_id,	'2020-12-21' as settled_at,	'2020-12-25' as refunded_at,	15 as usd_gross from dual
--),
--noom_plans as (
--select 101 as plan_id,	1 as billing_cycle_in_months,	15 as plan_rate from dual union all
--select 102 as plan_id,	6 as billing_cycle_in_months,	50 as plan_rate from dual union all
--select 103 as plan_id,	12 as billing_cycle_in_months,	100 as plan_rate from dual
--),
--combined as (
--select np.billing_cycle_in_months, to_date(nt.refunded_at,'YYYY-MM-DD') - to_date(nt.settled_at,'YYYY-MM-DD') process_days
--from noom_signups ns join noom_transactions nt on ns.signup_id = nt.signup_id
--join noom_plans np on ns.plan_id = np.plan_id
--where to_date(ns.started_at, 'YYYY-MM-DD') > to_date('2019-01-01','YYYY-MM-DD')
--)
--select billing_cycle_in_months, min(process_days) as min_days, avg(process_days) as avg_days, max(process_days) as max_days from combined group by billing_cycle_in_months;

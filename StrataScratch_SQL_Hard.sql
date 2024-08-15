-- 514: Marketing Campaign Success [Advanced]
-- You have a table of in-app purchases by user. Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases. Find the number of users that made additional in-app purchases due to the success of the marketing campaign.
-- The marketing campaign doesn't start until one day after the initial in-app purchase so users that only made one or multiple purchases on the first day do not count, nor do we count users that over time purchase only the products they purchased on the first day.
with marketing_campaign as (
select 10 as user_id,	'2019-01-01' as created_at,	101 as product_id,	3 as quantity,	55 as price from dual union all
select 10 as user_id,	'2019-01-02' as created_at,	119 as product_id,	5 as quantity,	29 as price from dual union all
select 10 as user_id,	'2019-03-31' as created_at,	111 as product_id,	2 as quantity,	149 as price from dual union all
select 11 as user_id,	'2019-01-02' as created_at,	105 as product_id,	3 as quantity,	234 as price from dual union all
select 11 as user_id,	'2019-03-31' as created_at,	120 as product_id,	3 as quantity,	99 as price from dual union all
select 12 as user_id,	'2019-01-02' as created_at,	112 as product_id,	2 as quantity,	200 as price from dual union all
select 12 as user_id,	'2019-03-31' as created_at,	110 as product_id,	2 as quantity,	299 as price from dual union all
select 13 as user_id,	'2019-01-05' as created_at,	113 as product_id,	1 as quantity,	67 as price from dual union all
select 13 as user_id,	'2019-03-31' as created_at,	118 as product_id,	3 as quantity,	35 as price from dual union all
select 14 as user_id,	'2019-01-06' as created_at,	109 as product_id,	5 as quantity,	199 as price from dual union all
select 14 as user_id,	'2019-01-06' as created_at,	107 as product_id,	2 as quantity,	27 as price from dual union all
select 14 as user_id,	'2019-03-31' as created_at,	112 as product_id,	3 as quantity,	200 as price from dual union all
select 15 as user_id,	'2019-01-08' as created_at,	105 as product_id,	4 as quantity,	234 as price from dual union all
select 15 as user_id,	'2019-01-09' as created_at,	110 as product_id,	4 as quantity,	299 as price from dual union all
select 15 as user_id,	'2019-03-31' as created_at,	116 as product_id,	2 as quantity,	499 as price from dual union all
select 16 as user_id,	'2019-01-10' as created_at,	113 as product_id,	2 as quantity,	67 as price from dual union all
select 16 as user_id,	'2019-03-31' as created_at,	107 as product_id,	4 as quantity,	27 as price from dual union all
select 17 as user_id,	'2019-01-11' as created_at,	116 as product_id,	2 as quantity,	499 as price from dual union all
select 17 as user_id,	'2019-03-31' as created_at,	104 as product_id,	1 as quantity,	154 as price from dual union all
select 18 as user_id,	'2019-01-12' as created_at,	114 as product_id,	2 as quantity,	248 as price from dual union all
select 18 as user_id,	'2019-01-12' as created_at,	113 as product_id,	4 as quantity,	67 as price from dual union all
select 19 as user_id,	'2019-01-12' as created_at,	114 as product_id,	3 as quantity,	248 as price from dual union all
select 20 as user_id,	'2019-01-15' as created_at,	117 as product_id,	2 as quantity,	999 as price from dual union all
select 21 as user_id,	'2019-01-16' as created_at,	105 as product_id,	3 as quantity,	234 as price from dual union all
select 21 as user_id,	'2019-01-17' as created_at,	114 as product_id,	4 as quantity,	248 as price from dual union all
select 22 as user_id,	'2019-01-18' as created_at,	113 as product_id,	3 as quantity,	67 as price from dual union all
select 22 as user_id,	'2019-01-19' as created_at,	118 as product_id,	4 as quantity,	35 as price from dual union all
select 23 as user_id,	'2019-01-20' as created_at,	119 as product_id,	3 as quantity,	29 as price from dual union all
select 24 as user_id,	'2019-01-21' as created_at,	114 as product_id,	2 as quantity,	248 as price from dual union all
select 25 as user_id,	'2019-01-22' as created_at,	114 as product_id,	2 as quantity,	248 as price from dual union all
select 25 as user_id,	'2019-01-22' as created_at,	115 as product_id,	2 as quantity,	72 as price from dual union all
select 25 as user_id,	'2019-01-24' as created_at,	114 as product_id,	5 as quantity,	248 as price from dual union all
select 25 as user_id,	'2019-01-27' as created_at,	115 as product_id,	1 as quantity,	72 as price from dual union all
select 26 as user_id,	'2019-01-25' as created_at,	115 as product_id,	1 as quantity,	72 as price from dual union all
select 27 as user_id,	'2019-01-26' as created_at,	104 as product_id,	3 as quantity,	154 as price from dual union all
select 28 as user_id,	'2019-01-27' as created_at,	101 as product_id,	4 as quantity,	55 as price from dual union all
select 29 as user_id,	'2019-01-27' as created_at,	111 as product_id,	3 as quantity,	149 as price from dual union all
select 30 as user_id,	'2019-01-29' as created_at,	111 as product_id,	1 as quantity,	149 as price from dual union all
select 31 as user_id,	'2019-01-30' as created_at,	104 as product_id,	3 as quantity,	154 as price from dual union all
select 32 as user_id,	'2019-01-31' as created_at,	117 as product_id,	1 as quantity,	999 as price from dual union all
select 33 as user_id,	'2019-01-31' as created_at,	117 as product_id,	2 as quantity,	999 as price from dual union all
select 34 as user_id,	'2019-01-31' as created_at,	110 as product_id,	3 as quantity,	299 as price from dual union all
select 35 as user_id,	'2019-02-03' as created_at,	117 as product_id,	2 as quantity,	999 as price from dual union all
select 36 as user_id,	'2019-02-04' as created_at,	102 as product_id,	4 as quantity,	82 as price from dual union all
select 37 as user_id,	'2019-02-05' as created_at,	102 as product_id,	2 as quantity,	82 as price from dual union all
select 38 as user_id,	'2019-02-06' as created_at,	113 as product_id,	2 as quantity,	67 as price from dual union all
select 39 as user_id,	'2019-02-07' as created_at,	120 as product_id,	5 as quantity,	99 as price from dual union all
select 40 as user_id,	'2019-02-08' as created_at,	115 as product_id,	2 as quantity,	72 as price from dual union all
select 41 as user_id,	'2019-02-08' as created_at,	114 as product_id,	1 as quantity,	248 as price from dual union all
select 42 as user_id,	'2019-02-10' as created_at,	105 as product_id,	5 as quantity,	234 as price from dual union all
select 43 as user_id,	'2019-02-11' as created_at,	102 as product_id,	1 as quantity,	82 as price from dual union all
select 43 as user_id,	'2019-03-05' as created_at,	104 as product_id,	3 as quantity,	154 as price from dual union all
select 44 as user_id,	'2019-02-12' as created_at,	105 as product_id,	3 as quantity,	234 as price from dual union all
select 44 as user_id,	'2019-03-05' as created_at,	102 as product_id,	4 as quantity,	82 as price from dual union all
select 45 as user_id,	'2019-02-13' as created_at,	119 as product_id,	5 as quantity,	29 as price from dual union all
select 45 as user_id,	'2019-03-05' as created_at,	105 as product_id,	3 as quantity,	234 as price from dual union all
select 46 as user_id,	'2019-02-14' as created_at,	102 as product_id,	4 as quantity,	82 as price from dual union all
select 46 as user_id,	'2019-02-14' as created_at,	102 as product_id,	5 as quantity,	29 as price from dual union all
select 46 as user_id,	'2019-03-09' as created_at,	102 as product_id,	2 as quantity,	35 as price from dual union all
select 46 as user_id,	'2019-03-10' as created_at,	103 as product_id,	1 as quantity,	199 as price from dual union all
select 46 as user_id,	'2019-03-11' as created_at,	103 as product_id,	1 as quantity,	199 as price from dual union all
select 47 as user_id,	'2019-02-14' as created_at,	110 as product_id,	2 as quantity,	299 as price from dual union all
select 47 as user_id,	'2019-03-11' as created_at,	105 as product_id,	5 as quantity,	234 as price from dual union all
select 48 as user_id,	'2019-02-14' as created_at,	115 as product_id,	4 as quantity,	72 as price from dual union all
select 48 as user_id,	'2019-03-12' as created_at,	105 as product_id,	3 as quantity,	234 as price from dual union all
select 49 as user_id,	'2019-02-18' as created_at,	106 as product_id,	2 as quantity,	123 as price from dual union all
select 49 as user_id,	'2019-02-18' as created_at,	114 as product_id,	1 as quantity,	248 as price from dual union all
select 49 as user_id,	'2019-02-18' as created_at,	112 as product_id,	4 as quantity,	200 as price from dual union all
select 49 as user_id,	'2019-02-18' as created_at,	116 as product_id,	1 as quantity,	499 as price from dual union all
select 50 as user_id,	'2019-02-20' as created_at,	118 as product_id,	4 as quantity,	35 as price from dual union all
select 50 as user_id,	'2019-02-21' as created_at,	118 as product_id,	4 as quantity,	29 as price from dual union all
select 50 as user_id,	'2019-03-13' as created_at,	118 as product_id,	5 as quantity,	299 as price from dual union all
select 50 as user_id,	'2019-03-14' as created_at,	118 as product_id,	2 as quantity,	199 as price from dual union all
select 51 as user_id,	'2019-02-21' as created_at,	120 as product_id,	2 as quantity,	99 as price from dual union all
select 51 as user_id,	'2019-03-13' as created_at,	108 as product_id,	4 as quantity,	120 as price from dual union all
select 52 as user_id,	'2019-02-23' as created_at,	117 as product_id,	2 as quantity,	999 as price from dual union all
select 52 as user_id,	'2019-03-18' as created_at,	112 as product_id,	5 as quantity,	200 as price from dual union all
select 53 as user_id,	'2019-02-24' as created_at,	120 as product_id,	4 as quantity,	99 as price from dual union all
select 53 as user_id,	'2019-03-19' as created_at,	105 as product_id,	5 as quantity,	234 as price from dual union all
select 54 as user_id,	'2019-02-25' as created_at,	119 as product_id,	4 as quantity,	29 as price from dual union all
select 54 as user_id,	'2019-03-20' as created_at,	110 as product_id,	1 as quantity,	299 as price from dual union all
select 55 as user_id,	'2019-02-26' as created_at,	117 as product_id,	2 as quantity,	999 as price from dual union all
select 55 as user_id,	'2019-03-20' as created_at,	117 as product_id,	5 as quantity,	999 as price from dual union all
select 56 as user_id,	'2019-02-27' as created_at,	115 as product_id,	2 as quantity,	72 as price from dual union all
select 56 as user_id,	'2019-03-20' as created_at,	116 as product_id,	2 as quantity,	499 as price from dual union all
select 57 as user_id,	'2019-02-28' as created_at,	105 as product_id,	4 as quantity,	234 as price from dual union all
select 57 as user_id,	'2019-02-28' as created_at,	106 as product_id,	1 as quantity,	123 as price from dual union all
select 57 as user_id,	'2019-03-20' as created_at,	108 as product_id,	1 as quantity,	120 as price from dual union all
select 57 as user_id,	'2019-03-20' as created_at,	103 as product_id,	1 as quantity,	79 as price from dual union all
select 58 as user_id,	'2019-02-28' as created_at,	104 as product_id,	1 as quantity,	154 as price from dual union all
select 58 as user_id,	'2019-03-01' as created_at,	101 as product_id,	3 as quantity,	55 as price from dual union all
select 58 as user_id,	'2019-03-02' as created_at,	119 as product_id,	2 as quantity,	29 as price from dual union all
select 58 as user_id,	'2019-03-25' as created_at,	102 as product_id,	2 as quantity,	82 as price from dual union all
select 59 as user_id,	'2019-03-04' as created_at,	117 as product_id,	4 as quantity,	999 as price from dual union all
select 60 as user_id,	'2019-03-05' as created_at,	114 as product_id,	3 as quantity,	248 as price from dual union all
select 61 as user_id,	'2019-03-26' as created_at,	120 as product_id,	2 as quantity,	99 as price from dual union all
select 62 as user_id,	'2019-03-27' as created_at,	106 as product_id,	1 as quantity,	123 as price from dual union all
select 63 as user_id,	'2019-03-27' as created_at,	120 as product_id,	5 as quantity,	99 as price from dual union all
select 64 as user_id,	'2019-03-27' as created_at,	105 as product_id,	3 as quantity,	234 as price from dual union all
select 65 as user_id,	'2019-03-27' as created_at,	103 as product_id,	4 as quantity,	79 as price from dual union all
select 66 as user_id,	'2019-03-31' as created_at,	107 as product_id,	2 as quantity,	27 as price from dual union all
select 67 as user_id,	'2019-03-31' as created_at,	102 as product_id,	5 as quantity,	82 as price from dual
),
day_one as (
select user_id, min(to_date(created_at, 'YYYY-MM-DD')) as day_one_date from marketing_campaign group by user_id order by 1
)
select count(distinct mc.user_id) as count from marketing_campaign mc join day_one do on mc.user_id = do.user_id and to_date(mc.created_at,'YYYY-MM-DD') > do.day_one_date and mc.product_id not in (select distinct product_id from marketing_campaign mc2 where mc2.user_id = do.user_id and to_date(mc2.created_at,'YYYY-MM-DD') = do.day_one_date);


-- 2007: Rank Variance Per Country
-- Which countries have risen in the rankings based on the number of comments between Dec 2019 vs Jan 2020? Hint: Avoid gaps between ranks when ranking countries.
with fb_comments_count as (
select 18 as user_id,	'2019-12-29' as created_at,	1 as number_of_comments from dual union all
select 25 as user_id,	'2019-12-21' as created_at,	1 as number_of_comments from dual union all
select 78 as user_id,	'2020-01-04' as created_at,	1 as number_of_comments from dual union all
select 37 as user_id,	'2020-02-01' as created_at,	1 as number_of_comments from dual union all
select 41 as user_id,	'2019-12-23' as created_at,	1 as number_of_comments from dual union all
select 99 as user_id,	'2020-02-02' as created_at,	1 as number_of_comments from dual union all
select 21 as user_id,	'2019-12-28' as created_at,	1 as number_of_comments from dual union all
select 18 as user_id,	'2020-01-31' as created_at,	1 as number_of_comments from dual union all
select 37 as user_id,	'2020-02-11' as created_at,	1 as number_of_comments from dual union all
select 58 as user_id,	'2020-01-26' as created_at,	1 as number_of_comments from dual union all
select 32 as user_id,	'2020-01-10' as created_at,	1 as number_of_comments from dual union all
select 24 as user_id,	'2020-02-03' as created_at,	1 as number_of_comments from dual union all
select 58 as user_id,	'2020-01-04' as created_at,	1 as number_of_comments from dual union all
select 8 as user_id,	'2020-02-10' as created_at,	1 as number_of_comments from dual union all
select 18 as user_id,	'2019-12-17' as created_at,	1 as number_of_comments from dual union all
select 18 as user_id,	'2019-12-30' as created_at,	1 as number_of_comments from dual union all
select 50 as user_id,	'2020-01-31' as created_at,	1 as number_of_comments from dual union all
select 82 as user_id,	'2019-12-22' as created_at,	1 as number_of_comments from dual union all
select 52 as user_id,	'2019-12-31' as created_at,	1 as number_of_comments from dual union all
select 78 as user_id,	'2020-02-10' as created_at,	1 as number_of_comments from dual union all
select 21 as user_id,	'2020-01-08' as created_at,	1 as number_of_comments from dual union all
select 4 as user_id,	'2019-12-22' as created_at,	1 as number_of_comments from dual union all
select 18 as user_id,	'2020-01-02' as created_at,	1 as number_of_comments from dual union all
select 89 as user_id,	'2019-12-25' as created_at,	1 as number_of_comments from dual union all
select 46 as user_id,	'2020-01-23' as created_at,	1 as number_of_comments from dual union all
select 32 as user_id,	'2020-01-17' as created_at,	1 as number_of_comments from dual union all
select 41 as user_id,	'2020-01-03' as created_at,	1 as number_of_comments from dual union all
select 8 as user_id,	'2020-02-05' as created_at,	1 as number_of_comments from dual union all
select 24 as user_id,	'2019-12-29' as created_at,	2 as number_of_comments from dual union all
select 56 as user_id,	'2019-12-25' as created_at,	1 as number_of_comments from dual union all
select 18 as user_id,	'2020-02-03' as created_at,	1 as number_of_comments from dual union all
select 56 as user_id,	'2019-12-21' as created_at,	1 as number_of_comments from dual union all
select 34 as user_id,	'2020-01-08' as created_at,	1 as number_of_comments from dual union all
select 27 as user_id,	'2020-01-10' as created_at,	1 as number_of_comments from dual union all
select 33 as user_id,	'2020-01-22' as created_at,	1 as number_of_comments from dual union all
select 78 as user_id,	'2020-01-07' as created_at,	1 as number_of_comments from dual union all
select 58 as user_id,	'2020-02-02' as created_at,	1 as number_of_comments from dual union all
select 82 as user_id,	'2019-12-30' as created_at,	1 as number_of_comments from dual union all
select 89 as user_id,	'2020-01-28' as created_at,	1 as number_of_comments from dual union all
select 46 as user_id,	'2019-12-23' as created_at,	1 as number_of_comments from dual union all
select 8 as user_id,	'2020-01-13' as created_at,	1 as number_of_comments from dual union all
select 9 as user_id,	'2020-02-02' as created_at,	1 as number_of_comments from dual union all
select 89 as user_id,	'2020-01-07' as created_at,	1 as number_of_comments from dual union all
select 87 as user_id,	'2020-01-08' as created_at,	1 as number_of_comments from dual union all
select 37 as user_id,	'2019-12-15' as created_at,	1 as number_of_comments from dual union all
select 95 as user_id,	'2020-02-10' as created_at,	1 as number_of_comments from dual union all
select 41 as user_id,	'2019-12-27' as created_at,	1 as number_of_comments from dual union all
select 82 as user_id,	'2020-01-16' as created_at,	1 as number_of_comments from dual union all
select 32 as user_id,	'2020-01-13' as created_at,	1 as number_of_comments from dual union all
select 99 as user_id,	'2020-01-05' as created_at,	1 as number_of_comments from dual union all
select 27 as user_id,	'2020-01-25' as created_at,	1 as number_of_comments from dual union all
select 52 as user_id,	'2020-01-01' as created_at,	1 as number_of_comments from dual union all
select 32 as user_id,	'2020-01-06' as created_at,	1 as number_of_comments from dual union all
select 56 as user_id,	'2019-12-19' as created_at,	1 as number_of_comments from dual union all
select 78 as user_id,	'2019-12-30' as created_at,	1 as number_of_comments from dual union all
select 33 as user_id,	'2020-01-28' as created_at,	1 as number_of_comments from dual union all
select 33 as user_id,	'2019-12-21' as created_at,	1 as number_of_comments from dual union all
select 32 as user_id,	'2020-01-04' as created_at,	2 as number_of_comments from dual union all
select 32 as user_id,	'2019-12-21' as created_at,	1 as number_of_comments from dual union all
select 89 as user_id,	'2020-01-16' as created_at,	1 as number_of_comments from dual union all
select 89 as user_id,	'2019-12-21' as created_at,	1 as number_of_comments from dual union all
select 52 as user_id,	'2019-12-20' as created_at,	1 as number_of_comments from dual union all
select 78 as user_id,	'2020-02-15' as created_at,	1 as number_of_comments from dual union all
select 32 as user_id,	'2019-12-23' as created_at,	1 as number_of_comments from dual union all
select 4 as user_id,	'2020-02-15' as created_at,	1 as number_of_comments from dual union all
select 99 as user_id,	'2020-02-03' as created_at,	1 as number_of_comments from dual union all
select 87 as user_id,	'2020-02-15' as created_at,	1 as number_of_comments from dual union all
select 34 as user_id,	'2020-01-15' as created_at,	1 as number_of_comments from dual union all
select 34 as user_id,	'2020-01-29' as created_at,	1 as number_of_comments from dual union all
select 32 as user_id,	'2019-12-18' as created_at,	1 as number_of_comments from dual union all
select 25 as user_id,	'2020-02-14' as created_at,	1 as number_of_comments from dual union all
select 89 as user_id,	'2020-01-05' as created_at,	1 as number_of_comments from dual union all
select 58 as user_id,	'2020-01-05' as created_at,	1 as number_of_comments from dual union all
select 46 as user_id,	'2020-01-29' as created_at,	1 as number_of_comments from dual union all
select 9 as user_id,	'2020-01-21' as created_at,	1 as number_of_comments from dual union all
select 9 as user_id,	'2020-01-06' as created_at,	1 as number_of_comments from dual union all
select 78 as user_id,	'2019-12-25' as created_at,	1 as number_of_comments from dual union all
select 46 as user_id,	'2019-12-29' as created_at,	1 as number_of_comments from dual union all
select 95 as user_id,	'2020-01-10' as created_at,	1 as number_of_comments from dual union all
select 95 as user_id,	'2020-01-17' as created_at,	1 as number_of_comments from dual union all
select 25 as user_id,	'2020-01-15' as created_at,	1 as number_of_comments from dual union all
select 87 as user_id,	'2019-12-25' as created_at,	1 as number_of_comments from dual union all
select 89 as user_id,	'2020-02-12' as created_at,	1 as number_of_comments from dual union all
select 25 as user_id,	'2020-01-20' as created_at,	1 as number_of_comments from dual union all
select 34 as user_id,	'2019-12-27' as created_at,	1 as number_of_comments from dual union all
select 27 as user_id,	'2019-12-21' as created_at,	1 as number_of_comments from dual union all
select 8 as user_id,	'2020-01-22' as created_at,	1 as number_of_comments from dual union all
select 37 as user_id,	'2020-01-19' as created_at,	2 as number_of_comments from dual union all
select 50 as user_id,	'2020-01-21' as created_at,	1 as number_of_comments from dual union all
select 18 as user_id,	'2019-12-27' as created_at,	1 as number_of_comments from dual union all
select 82 as user_id,	'2020-01-23' as created_at,	1 as number_of_comments from dual union all
select 21 as user_id,	'2019-12-24' as created_at,	1 as number_of_comments from dual union all
select 37 as user_id,	'2019-12-17' as created_at,	1 as number_of_comments from dual union all
select 33 as user_id,	'2019-12-31' as created_at,	1 as number_of_comments from dual union all
select 50 as user_id,	'2020-01-28' as created_at,	1 as number_of_comments from dual union all
select 32 as user_id,	'2019-12-19' as created_at,	1 as number_of_comments from dual union all
select 4 as user_id,	'2020-01-01' as created_at,	1 as number_of_comments from dual union all
select 22 as user_id,	'2020-02-15' as created_at,	1 as number_of_comments from dual union all
select 31 as user_id,	'2020-01-28' as created_at,	1 as number_of_comments from dual union all
select 22 as user_id,	'2020-04-04' as created_at,	1 as number_of_comments from dual union all
select 31 as user_id,	'2020-01-03' as created_at,	1 as number_of_comments from dual union all
select 22 as user_id,	'2019-12-19' as created_at,	1 as number_of_comments from dual union all
select 31 as user_id,	'2020-02-15' as created_at,	1 as number_of_comments from dual union all
select 22 as user_id,	'2019-12-01' as created_at,	1 as number_of_comments from dual union all
select 31 as user_id,	'2020-04-04' as created_at,	1 as number_of_comments from dual union all
select 16 as user_id,	'2019-12-27' as created_at,	1 as number_of_comments from dual union all
select 5 as user_id,	'2020-01-23' as created_at,	1 as number_of_comments from dual union all
select 7 as user_id,	'2019-12-24' as created_at,	1 as number_of_comments from dual union all
select 11 as user_id,	'2019-12-17' as created_at,	1 as number_of_comments from dual union all
select 61 as user_id,	'2019-12-31' as created_at,	1 as number_of_comments from dual union all
select 16 as user_id,	'2020-01-28' as created_at,	1 as number_of_comments from dual union all
select 5 as user_id,	'2019-12-19' as created_at,	1 as number_of_comments from dual union all
select 7 as user_id,	'2020-01-01' as created_at,	1 as number_of_comments from dual union all
select 11 as user_id,	'2020-02-15' as created_at,	1 as number_of_comments from dual union all
select 61 as user_id,	'2020-01-28' as created_at,	1 as number_of_comments from dual union all
select 11 as user_id,	'2020-04-04' as created_at,	1 as number_of_comments from dual union all
select 16 as user_id,	'2020-01-03' as created_at,	1 as number_of_comments from dual union all
select 5 as user_id,	'2019-12-19' as created_at,	1 as number_of_comments from dual union all
select 7 as user_id,	'2020-02-15' as created_at,	1 as number_of_comments from dual union all
select 11 as user_id,	'2019-12-01' as created_at,	1 as number_of_comments from dual union all
select 61 as user_id,	'2020-04-04' as created_at,	1 as number_of_comments from dual
),
fb_active_users as (
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
),
dec_report as (
select au.country, sum(cc.number_of_comments) as total_comments, dense_rank() over (order by sum(cc.number_of_comments) desc) as comments_rank 
from fb_comments_count cc join fb_active_users au on cc.user_id = au.user_id and au.country is not null where to_date(cc.created_at, 'YYYY-MM-DD') between to_date('2019-12-01', 'YYYY-MM-DD') and to_date('2019-12-31', 'YYYY-MM-DD')
group by au.country
),
jan_report as (
select au.country, sum(cc.number_of_comments) as total_comments, dense_rank() over (order by sum(cc.number_of_comments) desc) as comments_rank 
from fb_comments_count cc join fb_active_users au on cc.user_id = au.user_id and au.country is not null where to_date(cc.created_at, 'YYYY-MM-DD') between to_date('2020-01-01', 'YYYY-MM-DD') and to_date('2020-01-31', 'YYYY-MM-DD')
group by au.country
)
select j.country
from jan_report j left join dec_report d on j.country = d.country where j.comments_rank < d.comments_rank or d.country is null;


-- 2008: The Cheapest Airline Connection
-- COMPANY X employees are trying to find the cheapest flights to upcoming conferences. When people fly long distances, a direct city-to-city flight is often more expensive than taking two flights with a stop in a hub city. Travelers might save even more money by breaking the trip into three flights with two stops. But for the purposes of this challenge, let's assume that no one is willing to stop three times!
-- Your task is to produce a trips table that lists all the cheapest possible trips that can be done in two or fewer stops. Sort the output table by origin, then by destination.
-- Note: A flight from SFO to JFK is considered to be different than a flight from JFK to SFO.
with da_flights as (
select 1 as id,	'SFO' as origin,	'JFK' as destination,	500 as cost from dual union all
select 2 as id,	'SFO' as origin,	'DFW' as destination,	200 as cost from dual union all
select 3 as id,	'SFO' as origin,	'MCO' as destination,	400 as cost from dual union all
select 4 as id,	'DFW' as origin,	'MCO' as destination,	100 as cost from dual union all
select 5 as id,	'DFW' as origin,	'JFK' as destination,	200 as cost from dual union all
select 6 as id,	'JFK' as origin,	'LHR' as destination,	1000 as cost from dual
),
connections as (
select da1.origin as origin1, da1.destination as destination1, da1.cost as cost1,
da2.origin as origin2, da2.destination as destination2, da2.cost as cost2,
da3.origin as origin3, da3.destination as destination3, da3.cost as cost3
from da_flights da1 left join da_flights da2 on da2.origin = da1.destination left join da_flights da3 on da3.origin = da2.destination
),
union_data as (
select origin1 as origin, destination1 as destination, cost1 as cost from connections union all
select origin1 as origin, destination2 as destination, cost1+cost2 as cost from connections union all
select origin1 as origin, destination3 as destination, cost1+cost2+cost3 as cost from connections
)
select origin, destination, min(cost) from union_data where destination is not null and cost is not null
group by origin, destination
order by origin, destination;









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







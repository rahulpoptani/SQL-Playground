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


--2012: Viewers Turned Streamers
-- From users who had their first session as a viewer, how many streamer sessions have they had? Return the user id and number of sessions in descending order. 
-- In case there are users with the same number of sessions, order them by ascending user id.
with twitch_sessions as (
select 0 as user_id, '2020-08-11 05:51:31' as session_start,	'2020-08-11 05:54:45' as session_end,	539 as session_id,	'streamer' as session_type from dual union all
select 2 as user_id, '2020-07-11 03:36:54' as session_start,	'2020-07-11 03:37:08' as session_end,	840 as session_id,	'streamer' as session_type from dual union all
select 3 as user_id, '2020-11-26 11:41:47' as session_start,	'2020-11-26 11:52:01' as session_end,	848 as session_id,	'streamer' as session_type from dual union all
select 1 as user_id, '2020-11-19 06:24:24' as session_start,	'2020-11-19 07:24:38' as session_end,	515 as session_id,	'viewer' as session_type from dual union all
select 2 as user_id, '2020-11-14 03:36:05' as session_start,	'2020-11-14 03:39:19' as session_end,	646 as session_id,	'viewer' as session_type from dual union all
select 0 as user_id, '2020-03-11 03:01:40' as session_start,	'2020-03-11 03:01:59' as session_end,	782 as session_id,	'streamer' as session_type from dual union all
select 0 as user_id, '2020-08-11 03:50:45' as session_start,	'2020-08-11 03:55:59' as session_end,	815 as session_id,	'viewer' as session_type from dual union all
select 3 as user_id, '2020-10-11 22:15:14' as session_start,	'2020-10-11 22:18:28' as session_end,	630 as session_id,	'viewer' as session_type from dual union all
select 1 as user_id, '2020-11-20 06:59:57' as session_start,	'2020-11-20 07:20:11' as session_end,	907 as session_id,	'streamer' as session_type from dual union all
select 2 as user_id, '2020-07-11 14:32:19' as session_start,	'2020-07-11 14:42:33' as session_end,	949 as session_id,	'viewer' as session_type from dual
)
select user_id ,count(session_type)as n_sessions from twitch_sessions where user_id in
(
select user_id  from
(
select user_id,session_start,session_type ,rank()over(partition by user_id order by session_start)as rn
from twitch_sessions
)
where rn=1 and session_type='viewer'
)
and session_type='streamer'
group by user_id;


-- 2028: New And Existing Users
-- Calculate the share of new and existing users for each month in the table. Output the month, share of new users, and share of existing users as a ratio.
-- New users are defined as users who started using services in the current month (there is no usage history in previous months). Existing users are users who used services in current month, but they also used services in any previous month.
-- Assume that the dates are all from the year 2020.
with fact_events as (
select 1 as id,	'2020-02-28' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 2 as id,	'2020-02-28' as time_id,	'7892-POOKP' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 3 as id,	'2020-04-03' as time_id,	'9763-GRSKD' as user_id,	'Zoomit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 4 as id,	'2020-04-02' as time_id,	'9763-GRSKD' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 5 as id,	'2020-02-06' as time_id,	'9237-HQITU' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 6 as id,	'2020-02-27' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 7 as id,	'2020-04-03' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 8 as id,	'2020-03-01' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 9 as id,	'2020-04-02' as time_id,	'4190-MFLUW' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 10 as id,	'2020-04-21' as time_id,	'9763-GRSKD' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 11 as id,	'2020-02-28' as time_id,	'5129-JLPIS' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'mobile	video call started' as event_type,	6 as event_id from dual union all
select 12 as id,	'2020-03-31' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 13 as id,	'2020-03-21' as time_id,	'6388-TABGU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 14 as id,	'2020-03-03' as time_id,	'7469-LKBCI' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 15 as id,	'2020-02-11' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 16 as id,	'2020-03-01' as time_id,	'5575-GNVDE' as user_id,	'Zoomit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 17 as id,	'2020-03-02' as time_id,	'6388-TABGU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 18 as id,	'2020-04-06' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 19 as id,	'2020-02-13' as time_id,	'3668-QPYBK' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 20 as id,	'2020-04-03' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 21 as id,	'2020-03-15' as time_id,	'9305-CDSKC' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 22 as id,	'2020-04-01' as time_id,	'7892-POOKP' as user_id,	'eShop' as customer_id,	'mobile' as client_id,	'voice call started' as event_type,	8 as event_id from dual union all
select 23 as id,	'2020-04-09' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 24 as id,	'2020-04-08' as time_id,	'3668-QPYBK' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 25 as id,	'2020-03-05' as time_id,	'8191-XWSZG' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 26 as id,	'2020-02-24' as time_id,	'3668-QPYBK' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'api message received' as event_type,	5 as event_id from dual union all
select 27 as id,	'2020-03-26' as time_id,	'6388-TABGU' as user_id,	'Zoomit' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 28 as id,	'2020-02-03' as time_id,	'7795-CFOCW' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'api message received' as event_type,	5 as event_id from dual union all
select 29 as id,	'2020-03-19' as time_id,	'7892-POOKP' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 30 as id,	'2020-04-07' as time_id,	'9763-GRSKD' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 31 as id,	'2020-04-06' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 32 as id,	'2020-02-15' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 33 as id,	'2020-04-06' as time_id,	'4183-MYFRB' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 34 as id,	'2020-03-13' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 35 as id,	'2020-04-05' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 36 as id,	'2020-03-28' as time_id,	'6388-TABGU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 37 as id,	'2020-04-03' as time_id,	'4183-MYFRB' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 38 as id,	'2020-03-15' as time_id,	'5575-GNVDE' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'desktop	video call started' as event_type,	6 as event_id from dual union all
select 39 as id,	'2020-03-06' as time_id,	'8091-TTVAX' as user_id,	'Zoomit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 40 as id,	'2020-03-25' as time_id,	'4190-MFLUW' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 41 as id,	'2020-04-13' as time_id,	'9959-WOFKT' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 42 as id,	'2020-02-20' as time_id,	'7590-VHVEG' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 43 as id,	'2020-03-13' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 44 as id,	'2020-02-22' as time_id,	'1452-KIOVK' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'voice call started' as event_type,	8 as event_id from dual union all
select 45 as id,	'2020-04-18' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 46 as id,	'2020-02-04' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 47 as id,	'2020-04-06' as time_id,	'4190-MFLUW' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 48 as id,	'2020-03-22' as time_id,	'1452-KIOVK' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 49 as id,	'2020-04-06' as time_id,	'5129-JLPIS' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 50 as id,	'2020-04-04' as time_id,	'7469-LKBCI' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 51 as id,	'2020-02-14' as time_id,	'3668-QPYBK' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 52 as id,	'2020-03-28' as time_id,	'5575-GNVDE' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 53 as id,	'2020-04-05' as time_id,	'8091-TTVAX' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 54 as id,	'2020-03-01' as time_id,	'7469-LKBCI' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 55 as id,	'2020-02-20' as time_id,	'5129-JLPIS' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 56 as id,	'2020-03-13' as time_id,	'7590-VHVEG' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 57 as id,	'2020-04-09' as time_id,	'8091-TTVAX' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 58 as id,	'2020-02-27' as time_id,	'9237-HQITU' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 59 as id,	'2020-03-24' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 60 as id,	'2020-03-19' as time_id,	'7469-LKBCI' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 61 as id,	'2020-03-29' as time_id,	'7892-POOKP' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 62 as id,	'2020-03-14' as time_id,	'5129-JLPIS' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 63 as id,	'2020-03-07' as time_id,	'4190-MFLUW' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'desktop	message sent' as event_type,	3 as event_id from dual union all
select 64 as id,	'2020-03-05' as time_id,	'4190-MFLUW' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 65 as id,	'2020-02-06' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 66 as id,	'2020-02-08' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call started' as event_type,	8 as event_id from dual union all
select 67 as id,	'2020-02-24' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 68 as id,	'2020-03-25' as time_id,	'7469-LKBCI' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 69 as id,	'2020-02-12' as time_id,	'1452-KIOVK' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 70 as id,	'2020-02-08' as time_id,	'7795-CFOCW' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 71 as id,	'2020-03-10' as time_id,	'7469-LKBCI' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 72 as id,	'2020-03-09' as time_id,	'9237-HQITU' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 73 as id,	'2020-03-13' as time_id,	'5575-GNVDE' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 74 as id,	'2020-03-17' as time_id,	'7469-LKBCI' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'desktop	message received' as event_type,	4 as event_id from dual union all
select 75 as id,	'2020-03-02' as time_id,	'4190-MFLUW' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 76 as id,	'2020-04-09' as time_id,	'7892-POOKP' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 77 as id,	'2020-03-18' as time_id,	'7590-VHVEG' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 78 as id,	'2020-02-27' as time_id,	'3655-SNQYZ' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 79 as id,	'2020-02-03' as time_id,	'7469-LKBCI' as user_id,	'Zoomit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 80 as id,	'2020-02-03' as time_id,	'0280-XJGEX' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 81 as id,	'2020-02-25' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 82 as id,	'2020-02-19' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 83 as id,	'2020-03-26' as time_id,	'7590-VHVEG' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'desktop	video call received' as event_type,	7 as event_id from dual union all
select 84 as id,	'2020-03-19' as time_id,	'8091-TTVAX' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 85 as id,	'2020-02-17' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 86 as id,	'2020-03-14' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 87 as id,	'2020-02-17' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 88 as id,	'2020-02-13' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'voice call started' as event_type,	8 as event_id from dual union all
select 89 as id,	'2020-04-01' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 90 as id,	'2020-03-26' as time_id,	'7795-CFOCW' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 91 as id,	'2020-04-08' as time_id,	'7795-CFOCW' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 92 as id,	'2020-03-28' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 93 as id,	'2020-03-06' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 94 as id,	'2020-02-23' as time_id,	'9305-CDSKC' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 95 as id,	'2020-03-19' as time_id,	'5575-GNVDE' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 96 as id,	'2020-03-28' as time_id,	'3668-QPYBK' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 97 as id,	'2020-03-22' as time_id,	'8091-TTVAX' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 98 as id,	'2020-02-09' as time_id,	'3655-SNQYZ' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 99 as id,	'2020-03-18' as time_id,	'6388-TABGU' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 100 as id,	'2020-03-31' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 101 as id,	'2020-03-02' as time_id,	'5129-JLPIS' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 102 as id,	'2020-03-02' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 103 as id,	'2020-03-01' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 104 as id,	'2020-04-07' as time_id,	'5575-GNVDE' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 105 as id,	'2020-02-17' as time_id,	'8191-XWSZG' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 106 as id,	'2020-03-02' as time_id,	'0280-XJGEX' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'mobile	video call started' as event_type,	6 as event_id from dual union all
select 107 as id,	'2020-02-07' as time_id,	'7590-VHVEG' as user_id,	'eShop' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 108 as id,	'2020-03-06' as time_id,	'7892-POOKP' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 109 as id,	'2020-02-03' as time_id,	'9237-HQITU' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 110 as id,	'2020-03-02' as time_id,	'1452-KIOVK' as user_id,	'eShop' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 111 as id,	'2020-02-04' as time_id,	'7892-POOKP' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 112 as id,	'2020-03-02' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 113 as id,	'2020-03-25' as time_id,	'4183-MYFRB' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 114 as id,	'2020-02-23' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 115 as id,	'2020-03-02' as time_id,	'9305-CDSKC' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'voice call started' as event_type,	8 as event_id from dual union all
select 116 as id,	'2020-03-11' as time_id,	'7590-VHVEG' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'api message received' as event_type,	5 as event_id from dual union all
select 117 as id,	'2020-04-08' as time_id,	'8091-TTVAX' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 118 as id,	'2020-02-01' as time_id,	'6713-OKOMC' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'mobile	file received' as event_type,	2 as event_id from dual union all
select 119 as id,	'2020-03-24' as time_id,	'8091-TTVAX' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'desktop	message sent' as event_type,	3 as event_id from dual union all
select 120 as id,	'2020-03-06' as time_id,	'8091-TTVAX' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'mobile	file sent' as event_type,	1 as event_id from dual union all
select 121 as id,	'2020-03-09' as time_id,	'5575-GNVDE' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 122 as id,	'2020-03-22' as time_id,	'8091-TTVAX' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 123 as id,	'2020-03-02' as time_id,	'7469-LKBCI' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 124 as id,	'2020-03-23' as time_id,	'5575-GNVDE' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 125 as id,	'2020-03-30' as time_id,	'9305-CDSKC' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 126 as id,	'2020-03-25' as time_id,	'4190-MFLUW' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 127 as id,	'2020-03-09' as time_id,	'7590-VHVEG' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'api message received' as event_type,	5 as event_id from dual union all
select 128 as id,	'2020-03-14' as time_id,	'7795-CFOCW' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 129 as id,	'2020-04-04' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 130 as id,	'2020-03-31' as time_id,	'5129-JLPIS' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 131 as id,	'2020-03-27' as time_id,	'4183-MYFRB' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 132 as id,	'2020-04-03' as time_id,	'5129-JLPIS' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 133 as id,	'2020-03-01' as time_id,	'0280-XJGEX' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 134 as id,	'2020-04-16' as time_id,	'9763-GRSKD' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 135 as id,	'2020-03-07' as time_id,	'6388-TABGU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'api message received' as event_type,	5 as event_id from dual union all
select 136 as id,	'2020-03-20' as time_id,	'9305-CDSKC' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 137 as id,	'2020-03-10' as time_id,	'8091-TTVAX' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 138 as id,	'2020-03-20' as time_id,	'0280-XJGEX' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 139 as id,	'2020-02-23' as time_id,	'5129-JLPIS' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 140 as id,	'2020-02-18' as time_id,	'7590-VHVEG' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 141 as id,	'2020-02-18' as time_id,	'1452-KIOVK' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 142 as id,	'2020-02-08' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 143 as id,	'2020-04-13' as time_id,	'7469-LKBCI' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 144 as id,	'2020-03-22' as time_id,	'6388-TABGU' as user_id,	'eShop' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 145 as id,	'2020-03-13' as time_id,	'0280-XJGEX' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 146 as id,	'2020-03-07' as time_id,	'6388-TABGU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 147 as id,	'2020-03-21' as time_id,	'8091-TTVAX' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 148 as id,	'2020-04-03' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 149 as id,	'2020-02-22' as time_id,	'7795-CFOCW' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 150 as id,	'2020-02-14' as time_id,	'7590-VHVEG' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual
),
events as (
select id, time_id, trunc(to_date(time_id,'YYYY-MM-DD'), 'MONTH') as time_month, user_id from fact_events
)
select
extract(MONTH from e1.time_month) as month, round((count(distinct e1.user_id) - count(distinct e2.user_id))/count(distinct e1.user_id),3) as share_new_users, round((count(distinct e2.user_id))/count(distinct e1.user_id),3) as share_existing_users
from events e1 left join events e2 on e1.time_month > e2.time_month and e1.user_id = e2.user_id
group by e1.time_month order by e1.time_month;


--2029: The Most Popular Client_Id Among Users Using Video and Voice Calls
-- Select the most popular client_id based on a count of the number of users who have at least 50% of their events from the following list: 'video call received', 'video call sent', 'voice call received', 'voice call sent'.
with fact_events as (
select 1 as id,	'2020-02-28' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 2 as id,	'2020-02-28' as time_id,	'7892-POOKP' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 3 as id,	'2020-04-03' as time_id,	'9763-GRSKD' as user_id,	'Zoomit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 4 as id,	'2020-04-02' as time_id,	'9763-GRSKD' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 5 as id,	'2020-02-06' as time_id,	'9237-HQITU' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 6 as id,	'2020-02-27' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 7 as id,	'2020-04-03' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 8 as id,	'2020-03-01' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 9 as id,	'2020-04-02' as time_id,	'4190-MFLUW' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 10 as id,	'2020-04-21' as time_id,	'9763-GRSKD' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 11 as id,	'2020-02-28' as time_id,	'5129-JLPIS' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'mobile	video call started' as event_type,	6 as event_id from dual union all
select 12 as id,	'2020-03-31' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 13 as id,	'2020-03-21' as time_id,	'6388-TABGU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 14 as id,	'2020-03-03' as time_id,	'7469-LKBCI' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 15 as id,	'2020-02-11' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 16 as id,	'2020-03-01' as time_id,	'5575-GNVDE' as user_id,	'Zoomit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 17 as id,	'2020-03-02' as time_id,	'6388-TABGU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 18 as id,	'2020-04-06' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 19 as id,	'2020-02-13' as time_id,	'3668-QPYBK' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 20 as id,	'2020-04-03' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 21 as id,	'2020-03-15' as time_id,	'9305-CDSKC' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 22 as id,	'2020-04-01' as time_id,	'7892-POOKP' as user_id,	'eShop' as customer_id,	'mobile' as client_id,	'voice call started' as event_type,	8 as event_id from dual union all
select 23 as id,	'2020-04-09' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 24 as id,	'2020-04-08' as time_id,	'3668-QPYBK' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 25 as id,	'2020-03-05' as time_id,	'8191-XWSZG' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 26 as id,	'2020-02-24' as time_id,	'3668-QPYBK' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'api message received' as event_type,	5 as event_id from dual union all
select 27 as id,	'2020-03-26' as time_id,	'6388-TABGU' as user_id,	'Zoomit' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 28 as id,	'2020-02-03' as time_id,	'7795-CFOCW' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'api message received' as event_type,	5 as event_id from dual union all
select 29 as id,	'2020-03-19' as time_id,	'7892-POOKP' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 30 as id,	'2020-04-07' as time_id,	'9763-GRSKD' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 31 as id,	'2020-04-06' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 32 as id,	'2020-02-15' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 33 as id,	'2020-04-06' as time_id,	'4183-MYFRB' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 34 as id,	'2020-03-13' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 35 as id,	'2020-04-05' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 36 as id,	'2020-03-28' as time_id,	'6388-TABGU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 37 as id,	'2020-04-03' as time_id,	'4183-MYFRB' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 38 as id,	'2020-03-15' as time_id,	'5575-GNVDE' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'desktop	video call started' as event_type,	6 as event_id from dual union all
select 39 as id,	'2020-03-06' as time_id,	'8091-TTVAX' as user_id,	'Zoomit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 40 as id,	'2020-03-25' as time_id,	'4190-MFLUW' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 41 as id,	'2020-04-13' as time_id,	'9959-WOFKT' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 42 as id,	'2020-02-20' as time_id,	'7590-VHVEG' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 43 as id,	'2020-03-13' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 44 as id,	'2020-02-22' as time_id,	'1452-KIOVK' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'voice call started' as event_type,	8 as event_id from dual union all
select 45 as id,	'2020-04-18' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 46 as id,	'2020-02-04' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 47 as id,	'2020-04-06' as time_id,	'4190-MFLUW' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 48 as id,	'2020-03-22' as time_id,	'1452-KIOVK' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 49 as id,	'2020-04-06' as time_id,	'5129-JLPIS' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 50 as id,	'2020-04-04' as time_id,	'7469-LKBCI' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 51 as id,	'2020-02-14' as time_id,	'3668-QPYBK' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 52 as id,	'2020-03-28' as time_id,	'5575-GNVDE' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 53 as id,	'2020-04-05' as time_id,	'8091-TTVAX' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 54 as id,	'2020-03-01' as time_id,	'7469-LKBCI' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 55 as id,	'2020-02-20' as time_id,	'5129-JLPIS' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 56 as id,	'2020-03-13' as time_id,	'7590-VHVEG' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 57 as id,	'2020-04-09' as time_id,	'8091-TTVAX' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 58 as id,	'2020-02-27' as time_id,	'9237-HQITU' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 59 as id,	'2020-03-24' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 60 as id,	'2020-03-19' as time_id,	'7469-LKBCI' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 61 as id,	'2020-03-29' as time_id,	'7892-POOKP' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 62 as id,	'2020-03-14' as time_id,	'5129-JLPIS' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 63 as id,	'2020-03-07' as time_id,	'4190-MFLUW' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'desktop	message sent' as event_type,	3 as event_id from dual union all
select 64 as id,	'2020-03-05' as time_id,	'4190-MFLUW' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 65 as id,	'2020-02-06' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 66 as id,	'2020-02-08' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call started' as event_type,	8 as event_id from dual union all
select 67 as id,	'2020-02-24' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 68 as id,	'2020-03-25' as time_id,	'7469-LKBCI' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 69 as id,	'2020-02-12' as time_id,	'1452-KIOVK' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 70 as id,	'2020-02-08' as time_id,	'7795-CFOCW' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 71 as id,	'2020-03-10' as time_id,	'7469-LKBCI' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 72 as id,	'2020-03-09' as time_id,	'9237-HQITU' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 73 as id,	'2020-03-13' as time_id,	'5575-GNVDE' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 74 as id,	'2020-03-17' as time_id,	'7469-LKBCI' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'desktop	message received' as event_type,	4 as event_id from dual union all
select 75 as id,	'2020-03-02' as time_id,	'4190-MFLUW' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 76 as id,	'2020-04-09' as time_id,	'7892-POOKP' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 77 as id,	'2020-03-18' as time_id,	'7590-VHVEG' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 78 as id,	'2020-02-27' as time_id,	'3655-SNQYZ' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 79 as id,	'2020-02-03' as time_id,	'7469-LKBCI' as user_id,	'Zoomit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 80 as id,	'2020-02-03' as time_id,	'0280-XJGEX' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 81 as id,	'2020-02-25' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 82 as id,	'2020-02-19' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 83 as id,	'2020-03-26' as time_id,	'7590-VHVEG' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'desktop	video call received' as event_type,	7 as event_id from dual union all
select 84 as id,	'2020-03-19' as time_id,	'8091-TTVAX' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 85 as id,	'2020-02-17' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 86 as id,	'2020-03-14' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 87 as id,	'2020-02-17' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 88 as id,	'2020-02-13' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'voice call started' as event_type,	8 as event_id from dual union all
select 89 as id,	'2020-04-01' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 90 as id,	'2020-03-26' as time_id,	'7795-CFOCW' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 91 as id,	'2020-04-08' as time_id,	'7795-CFOCW' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 92 as id,	'2020-03-28' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 93 as id,	'2020-03-06' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 94 as id,	'2020-02-23' as time_id,	'9305-CDSKC' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 95 as id,	'2020-03-19' as time_id,	'5575-GNVDE' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 96 as id,	'2020-03-28' as time_id,	'3668-QPYBK' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 97 as id,	'2020-03-22' as time_id,	'8091-TTVAX' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 98 as id,	'2020-02-09' as time_id,	'3655-SNQYZ' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 99 as id,	'2020-03-18' as time_id,	'6388-TABGU' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 100 as id,	'2020-03-31' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 101 as id,	'2020-03-02' as time_id,	'5129-JLPIS' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 102 as id,	'2020-03-02' as time_id,	'9237-HQITU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 103 as id,	'2020-03-01' as time_id,	'9305-CDSKC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 104 as id,	'2020-04-07' as time_id,	'5575-GNVDE' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 105 as id,	'2020-02-17' as time_id,	'8191-XWSZG' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 106 as id,	'2020-03-02' as time_id,	'0280-XJGEX' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'mobile	video call started' as event_type,	6 as event_id from dual union all
select 107 as id,	'2020-02-07' as time_id,	'7590-VHVEG' as user_id,	'eShop' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 108 as id,	'2020-03-06' as time_id,	'7892-POOKP' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 109 as id,	'2020-02-03' as time_id,	'9237-HQITU' as user_id,	'Sendit' as customer_id,	'mobile' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 110 as id,	'2020-03-02' as time_id,	'1452-KIOVK' as user_id,	'eShop' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 111 as id,	'2020-02-04' as time_id,	'7892-POOKP' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 112 as id,	'2020-03-02' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 113 as id,	'2020-03-25' as time_id,	'4183-MYFRB' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 114 as id,	'2020-02-23' as time_id,	'6713-OKOMC' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 115 as id,	'2020-03-02' as time_id,	'9305-CDSKC' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'voice call started' as event_type,	8 as event_id from dual union all
select 116 as id,	'2020-03-11' as time_id,	'7590-VHVEG' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'api message received' as event_type,	5 as event_id from dual union all
select 117 as id,	'2020-04-08' as time_id,	'8091-TTVAX' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 118 as id,	'2020-02-01' as time_id,	'6713-OKOMC' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'mobile	file received' as event_type,	2 as event_id from dual union all
select 119 as id,	'2020-03-24' as time_id,	'8091-TTVAX' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'desktop	message sent' as event_type,	3 as event_id from dual union all
select 120 as id,	'2020-03-06' as time_id,	'8091-TTVAX' as user_id,	'Electric' as customer_id, 'Gravity' as client_id,	'mobile	file sent' as event_type,	1 as event_id from dual union all
select 121 as id,	'2020-03-09' as time_id,	'5575-GNVDE' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 122 as id,	'2020-03-22' as time_id,	'8091-TTVAX' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 123 as id,	'2020-03-02' as time_id,	'7469-LKBCI' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 124 as id,	'2020-03-23' as time_id,	'5575-GNVDE' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 125 as id,	'2020-03-30' as time_id,	'9305-CDSKC' as user_id,	'eShop' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 126 as id,	'2020-03-25' as time_id,	'4190-MFLUW' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 127 as id,	'2020-03-09' as time_id,	'7590-VHVEG' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'api message received' as event_type,	5 as event_id from dual union all
select 128 as id,	'2020-03-14' as time_id,	'7795-CFOCW' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 129 as id,	'2020-04-04' as time_id,	'9959-WOFKT' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 130 as id,	'2020-03-31' as time_id,	'5129-JLPIS' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 131 as id,	'2020-03-27' as time_id,	'4183-MYFRB' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 132 as id,	'2020-04-03' as time_id,	'5129-JLPIS' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 133 as id,	'2020-03-01' as time_id,	'0280-XJGEX' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 134 as id,	'2020-04-16' as time_id,	'9763-GRSKD' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 135 as id,	'2020-03-07' as time_id,	'6388-TABGU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'api message received' as event_type,	5 as event_id from dual union all
select 136 as id,	'2020-03-20' as time_id,	'9305-CDSKC' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 137 as id,	'2020-03-10' as time_id,	'8091-TTVAX' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call started' as event_type,	6 as event_id from dual union all
select 138 as id,	'2020-03-20' as time_id,	'0280-XJGEX' as user_id,	'Zoomit' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 139 as id,	'2020-02-23' as time_id,	'5129-JLPIS' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 140 as id,	'2020-02-18' as time_id,	'7590-VHVEG' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 141 as id,	'2020-02-18' as time_id,	'1452-KIOVK' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 142 as id,	'2020-02-08' as time_id,	'3668-QPYBK' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 143 as id,	'2020-04-13' as time_id,	'7469-LKBCI' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'video call received' as event_type,	7 as event_id from dual union all
select 144 as id,	'2020-03-22' as time_id,	'6388-TABGU' as user_id,	'eShop' as customer_id,	'mobile' as client_id,	'file sent' as event_type,	1 as event_id from dual union all
select 145 as id,	'2020-03-13' as time_id,	'0280-XJGEX' as user_id,	'Sendit' as customer_id,	'desktop' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 146 as id,	'2020-03-07' as time_id,	'6388-TABGU' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'voice call received' as event_type,	9 as event_id from dual union all
select 147 as id,	'2020-03-21' as time_id,	'8091-TTVAX' as user_id,	'Connectix' as customer_id,	'mobile' as client_id,	'message sent' as event_type,	3 as event_id from dual union all
select 148 as id,	'2020-04-03' as time_id,	'8191-XWSZG' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'file received' as event_type,	2 as event_id from dual union all
select 149 as id,	'2020-02-22' as time_id,	'7795-CFOCW' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual union all
select 150 as id,	'2020-02-14' as time_id,	'7590-VHVEG' as user_id,	'Connectix' as customer_id,	'desktop' as client_id,	'message received' as event_type,	4 as event_id from dual
),
popular_flag as (
select client_id, user_id, case when event_type in ('video call received', 'video call sent', 'voice call received', 'voice call sent') then 1 else 0 end as popular_event from fact_events
),
popular_ratio as (
select client_id, user_id, sum(popular_event) over (partition by user_id) / count(popular_event) over (partition by user_id) as popular_ratio from popular_flag
),
popular_client_rank as (
select client_id, dense_rank() over (order by count(*) desc) as popular_client_rank from popular_ratio where popular_ratio >= 0.5
group by client_id
)
select client_id from popular_client_rank where popular_client_rank = 1;


-- 2033: Find The Most Profitable Location
-- Find the most profitable location. Write a query that calculates the average signup duration and average transaction amount for each location, and then compare these two measures together by taking the ratio of the average transaction amount and average duration for each location.
-- Your output should include the location, average duration, average transaction amount, and ratio. Sort your results from highest ratio to lowest.
with signups as (
select 100 as signup_id,	'2020-04-23' as signup_start_date,	'2020-05-19' as signup_stop_date,	11 as plan_id,	'Rio De Janeiro' as location from dual union all
select 101 as signup_id,	'2020-04-09' as signup_start_date,	'2020-07-06' as signup_stop_date,	11 as plan_id,	'Mexico City' as location from dual union all
select 102 as signup_id,	'2020-04-21' as signup_start_date,	'2020-10-08' as signup_stop_date,	10 as plan_id,	'Mendoza' as location from dual union all
select 103 as signup_id,	'2020-04-04' as signup_start_date,	'2020-06-19' as signup_stop_date,	11 as plan_id,	'Rio De Janeiro' as location from dual union all
select 104 as signup_id,	'2020-04-24' as signup_start_date,	'2020-06-28' as signup_stop_date,	21 as plan_id,	'Las Vegas' as location from dual union all
select 105 as signup_id,	'2020-04-14' as signup_start_date,	'2020-07-15' as signup_stop_date,	20 as plan_id,	'Rio De Janeiro' as location from dual union all
select 106 as signup_id,	'2020-04-10' as signup_start_date,	'2020-07-29' as signup_stop_date,	22 as plan_id,	'Mexico City' as location from dual union all
select 107 as signup_id,	'2020-04-07' as signup_start_date,	'2020-08-26' as signup_stop_date,	12 as plan_id,	'Mexico City' as location from dual union all
select 108 as signup_id,	'2020-04-21' as signup_start_date,	'2020-05-31' as signup_stop_date,	10 as plan_id,	'New Jersey' as location from dual union all
select 109 as signup_id,	'2020-04-11' as signup_start_date,	'2020-09-17' as signup_stop_date,	21 as plan_id,	'Mendoza' as location from dual union all
select 110 as signup_id,	'2020-04-15' as signup_start_date,	'2020-05-08' as signup_stop_date,	11 as plan_id,	'Houston' as location from dual union all
select 111 as signup_id,	'2020-04-04' as signup_start_date,	'2020-09-03' as signup_stop_date,	12 as plan_id,	'New Jersey' as location from dual union all
select 112 as signup_id,	'2020-04-15' as signup_start_date,	'2020-08-31' as signup_stop_date,	20 as plan_id,	'New York' as location from dual union all
select 113 as signup_id,	'2020-04-22' as signup_start_date,	'2020-06-29' as signup_stop_date,	22 as plan_id,	'Las Vegas' as location from dual union all
select 114 as signup_id,	'2020-04-20' as signup_start_date,	'2020-06-21' as signup_stop_date,	11 as plan_id,	'Houston' as location from dual union all
select 115 as signup_id,	'2020-04-28' as signup_start_date,	'2020-09-25' as signup_stop_date,	21 as plan_id,	'Luxembourg' as location from dual union all
select 116 as signup_id,	'2020-04-17' as signup_start_date,	'2020-09-26' as signup_stop_date,	11 as plan_id,	'Las Vegas' as location from dual union all
select 117 as signup_id,	'2020-04-22' as signup_start_date,	'2020-06-30' as signup_stop_date,	22 as plan_id,	'New Jersey' as location from dual union all
select 118 as signup_id,	'2020-04-04' as signup_start_date,	'2020-05-28' as signup_stop_date,	12 as plan_id,	'Rio De Janeiro' as location from dual union all
select 119 as signup_id,	'2020-04-21' as signup_start_date,	'2020-08-13' as signup_stop_date,	11 as plan_id,	'New York' as location from dual union all
select 120 as signup_id,	'2020-04-10' as signup_start_date,	'2020-05-16' as signup_stop_date,	11 as plan_id,	'Luxembourg' as location from dual union all
select 121 as signup_id,	'2020-04-22' as signup_start_date,	'2020-08-13' as signup_stop_date,	22 as plan_id,	'Mexico City' as location from dual union all
select 122 as signup_id,	'2020-04-13' as signup_start_date,	'2020-06-12' as signup_stop_date,	20 as plan_id,	'Houston' as location from dual union all
select 123 as signup_id,	'2020-04-13' as signup_start_date,	'2020-10-09' as signup_stop_date,	10 as plan_id,	'Luxembourg' as location from dual union all
select 124 as signup_id,	'2020-04-18' as signup_start_date,	'2020-06-03' as signup_stop_date,	11 as plan_id,	'New York' as location from dual union all
select 125 as signup_id,	'2020-04-16' as signup_start_date,	'2020-06-15' as signup_stop_date,	10 as plan_id,	'Las Vegas' as location from dual union all
select 126 as signup_id,	'2020-04-21' as signup_start_date,	'2020-07-25' as signup_stop_date,	21 as plan_id,	'Rio De Janeiro' as location from dual union all
select 127 as signup_id,	'2020-04-24' as signup_start_date,	'2020-09-22' as signup_stop_date,	21 as plan_id,	'Mendoza' as location from dual union all
select 128 as signup_id,	'2020-04-27' as signup_start_date,	'2020-08-03' as signup_stop_date,	20 as plan_id,	'Houston' as location from dual union all
select 129 as signup_id,	'2020-04-04' as signup_start_date,	'2020-04-30' as signup_stop_date,	12 as plan_id,	'Mendoza' as location from dual union all
select 130 as signup_id,	'2020-04-07' as signup_start_date,	'2020-08-14' as signup_stop_date,	22 as plan_id,	'Mexico City' as location from dual union all
select 131 as signup_id,	'2020-04-22' as signup_start_date,	'2020-06-22' as signup_stop_date,	11 as plan_id,	'Mendoza' as location from dual union all
select 132 as signup_id,	'2020-04-06' as signup_start_date,	'2020-09-19' as signup_stop_date,	10 as plan_id,	'Las Vegas' as location from dual union all
select 133 as signup_id,	'2020-04-15' as signup_start_date,	'2020-06-13' as signup_stop_date,	20 as plan_id,	'Houston' as location from dual union all
select 134 as signup_id,	'2020-04-29' as signup_start_date,	'2020-05-28' as signup_stop_date,	21 as plan_id,	'New York' as location from dual union all
select 135 as signup_id,	'2020-04-18' as signup_start_date,	'2020-10-04' as signup_stop_date,	21 as plan_id,	'New Jersey' as location from dual union all
select 136 as signup_id,	'2020-04-28' as signup_start_date,	'2020-06-22' as signup_stop_date,	11 as plan_id,	'Las Vegas' as location from dual union all
select 137 as signup_id,	'2020-04-15' as signup_start_date,	'2020-07-13' as signup_stop_date,	20 as plan_id,	'Las Vegas' as location from dual union all
select 138 as signup_id,	'2020-04-24' as signup_start_date,	'2020-10-02' as signup_stop_date,	11 as plan_id,	'New Jersey' as location from dual union all
select 139 as signup_id,	'2020-04-28' as signup_start_date,	'2020-10-06' as signup_stop_date,	21 as plan_id,	'Houston' as location from dual union all
select 140 as signup_id,	'2020-04-17' as signup_start_date,	'2020-09-10' as signup_stop_date,	11 as plan_id,	'Houston' as location from dual union all
select 141 as signup_id,	'2020-04-27' as signup_start_date,	'2020-09-29' as signup_stop_date,	10 as plan_id,	'New Jersey' as location from dual union all
select 142 as signup_id,	'2020-04-09' as signup_start_date,	'2020-06-24' as signup_stop_date,	11 as plan_id,	'Luxembourg' as location from dual union all
select 143 as signup_id,	'2020-04-29' as signup_start_date,	'2020-10-16' as signup_stop_date,	21 as plan_id,	'New York' as location from dual union all
select 144 as signup_id,	'2020-04-13' as signup_start_date,	'2020-06-21' as signup_stop_date,	12 as plan_id,	'Las Vegas' as location from dual union all
select 145 as signup_id,	'2020-04-29' as signup_start_date,	'2020-07-15' as signup_stop_date,	11 as plan_id,	'Luxembourg' as location from dual union all
select 146 as signup_id,	'2020-04-25' as signup_start_date,	'2020-06-21' as signup_stop_date,	12 as plan_id,	'Houston' as location from dual union all
select 147 as signup_id,	'2020-04-24' as signup_start_date,	'2020-08-18' as signup_stop_date,	21 as plan_id,	'Las Vegas' as location from dual union all
select 148 as signup_id,	'2020-04-29' as signup_start_date,	'2020-10-07' as signup_stop_date,	20 as plan_id,	'Mexico City' as location from dual union all
select 149 as signup_id,	'2020-04-28' as signup_start_date,	'2020-09-23' as signup_stop_date,	12 as plan_id,	'Rio De Janeiro' as location from dual
),
transactions as (
select 1 as transaction_id,	100 as signup_id,	'2020-04-30' as transaction_start_date,	24.9 as amt from dual union all
select 2 as transaction_id,	101 as signup_id,	'2020-04-16' as transaction_start_date,	24.9 as amt from dual union all
select 3 as transaction_id,	102 as signup_id,	'2020-04-28' as transaction_start_date,	9.9 as amt from dual union all
select 4 as transaction_id,	102 as signup_id,	'2020-05-28' as transaction_start_date,	9.9 as amt from dual union all
select 5 as transaction_id,	102 as signup_id,	'2020-06-27' as transaction_start_date,	9.9 as amt from dual union all
select 6 as transaction_id,	102 as signup_id,	'2020-07-27' as transaction_start_date,	9.9 as amt from dual union all
select 7 as transaction_id,	102 as signup_id,	'2020-08-26' as transaction_start_date,	9.9 as amt from dual union all
select 8 as transaction_id,	102 as signup_id,	'2020-09-25' as transaction_start_date,	9.9 as amt from dual union all
select 9 as transaction_id,	103 as signup_id,	'2020-04-11' as transaction_start_date,	24.9 as amt from dual union all
select 10 as transaction_id,	104 as signup_id,	'2020-05-01' as transaction_start_date,	24.9 as amt from dual union all
select 11 as transaction_id,	105 as signup_id,	'2020-04-21' as transaction_start_date,	9.9 as amt from dual union all
select 12 as transaction_id,	105 as signup_id,	'2020-05-21' as transaction_start_date,	9.9 as amt from dual union all
select 13 as transaction_id,	105 as signup_id,	'2020-06-20' as transaction_start_date,	9.9 as amt from dual union all
select 14 as transaction_id,	106 as signup_id,	'2020-04-17' as transaction_start_date,	109.9 as amt from dual union all
select 15 as transaction_id,	107 as signup_id,	'2020-04-14' as transaction_start_date,	109.9 as amt from dual union all
select 16 as transaction_id,	108 as signup_id,	'2020-04-28' as transaction_start_date,	9.9 as amt from dual union all
select 17 as transaction_id,	108 as signup_id,	'2020-05-28' as transaction_start_date,	9.9 as amt from dual union all
select 18 as transaction_id,	109 as signup_id,	'2020-04-18' as transaction_start_date,	24.9 as amt from dual union all
select 19 as transaction_id,	109 as signup_id,	'2020-07-17' as transaction_start_date,	24.9 as amt from dual union all
select 20 as transaction_id,	110 as signup_id,	'2020-04-22' as transaction_start_date,	24.9 as amt from dual union all
select 21 as transaction_id,	111 as signup_id,	'2020-04-11' as transaction_start_date,	109.9 as amt from dual union all
select 22 as transaction_id,	112 as signup_id,	'2020-04-22' as transaction_start_date,	9.9 as amt from dual union all
select 23 as transaction_id,	112 as signup_id,	'2020-05-22' as transaction_start_date,	9.9 as amt from dual union all
select 24 as transaction_id,	112 as signup_id,	'2020-06-21' as transaction_start_date,	9.9 as amt from dual union all
select 25 as transaction_id,	112 as signup_id,	'2020-07-21' as transaction_start_date,	9.9 as amt from dual union all
select 26 as transaction_id,	112 as signup_id,	'2020-08-20' as transaction_start_date,	9.9 as amt from dual union all
select 27 as transaction_id,	113 as signup_id,	'2020-04-29' as transaction_start_date,	109.9 as amt from dual union all
select 28 as transaction_id,	114 as signup_id,	'2020-04-27' as transaction_start_date,	24.9 as amt from dual union all
select 29 as transaction_id,	115 as signup_id,	'2020-05-05' as transaction_start_date,	24.9 as amt from dual union all
select 30 as transaction_id,	115 as signup_id,	'2020-08-03' as transaction_start_date,	24.9 as amt from dual union all
select 31 as transaction_id,	116 as signup_id,	'2020-04-24' as transaction_start_date,	24.9 as amt from dual union all
select 32 as transaction_id,	116 as signup_id,	'2020-07-23' as transaction_start_date,	24.9 as amt from dual union all
select 33 as transaction_id,	117 as signup_id,	'2020-04-29' as transaction_start_date,	109.9 as amt from dual union all
select 34 as transaction_id,	118 as signup_id,	'2020-04-11' as transaction_start_date,	109.9 as amt from dual union all
select 35 as transaction_id,	119 as signup_id,	'2020-04-28' as transaction_start_date,	24.9 as amt from dual union all
select 36 as transaction_id,	119 as signup_id,	'2020-07-27' as transaction_start_date,	24.9 as amt from dual union all
select 37 as transaction_id,	120 as signup_id,	'2020-04-17' as transaction_start_date,	24.9 as amt from dual union all
select 38 as transaction_id,	121 as signup_id,	'2020-04-29' as transaction_start_date,	109.9 as amt from dual union all
select 39 as transaction_id,	122 as signup_id,	'2020-04-20' as transaction_start_date,	9.9 as amt from dual union all
select 40 as transaction_id,	122 as signup_id,	'2020-05-20' as transaction_start_date,	9.9 as amt from dual union all
select 41 as transaction_id,	123 as signup_id,	'2020-04-20' as transaction_start_date,	9.9 as amt from dual union all
select 42 as transaction_id,	123 as signup_id,	'2020-05-20' as transaction_start_date,	9.9 as amt from dual union all
select 43 as transaction_id,	123 as signup_id,	'2020-06-19' as transaction_start_date,	9.9 as amt from dual union all
select 44 as transaction_id,	123 as signup_id,	'2020-07-19' as transaction_start_date,	9.9 as amt from dual union all
select 45 as transaction_id,	123 as signup_id,	'2020-08-18' as transaction_start_date,	9.9 as amt from dual union all
select 46 as transaction_id,	123 as signup_id,	'2020-09-17' as transaction_start_date,	9.9 as amt from dual union all
select 47 as transaction_id,	124 as signup_id,	'2020-04-25' as transaction_start_date,	24.9 as amt from dual union all
select 48 as transaction_id,	125 as signup_id,	'2020-04-23' as transaction_start_date,	9.9 as amt from dual union all
select 49 as transaction_id,	125 as signup_id,	'2020-05-23' as transaction_start_date,	9.9 as amt from dual union all
select 50 as transaction_id,	126 as signup_id,	'2020-04-28' as transaction_start_date,	24.9 as amt from dual union all
select 51 as transaction_id,	127 as signup_id,	'2020-05-01' as transaction_start_date,	24.9 as amt from dual union all
select 52 as transaction_id,	127 as signup_id,	'2020-07-30' as transaction_start_date,	24.9 as amt from dual union all
select 53 as transaction_id,	128 as signup_id,	'2020-05-04' as transaction_start_date,	9.9 as amt from dual union all
select 54 as transaction_id,	128 as signup_id,	'2020-06-03' as transaction_start_date,	9.9 as amt from dual union all
select 55 as transaction_id,	128 as signup_id,	'2020-07-03' as transaction_start_date,	9.9 as amt from dual union all
select 56 as transaction_id,	128 as signup_id,	'2020-08-02' as transaction_start_date,	9.9 as amt from dual union all
select 57 as transaction_id,	129 as signup_id,	'2020-04-11' as transaction_start_date,	109.9 as amt from dual union all
select 58 as transaction_id,	130 as signup_id,	'2020-04-14' as transaction_start_date,	109.9 as amt from dual union all
select 59 as transaction_id,	131 as signup_id,	'2020-04-29' as transaction_start_date,	24.9 as amt from dual union all
select 60 as transaction_id,	132 as signup_id,	'2020-04-13' as transaction_start_date,	9.9 as amt from dual union all
select 61 as transaction_id,	132 as signup_id,	'2020-05-13' as transaction_start_date,	9.9 as amt from dual union all
select 62 as transaction_id,	132 as signup_id,	'2020-06-12' as transaction_start_date,	9.9 as amt from dual union all
select 63 as transaction_id,	132 as signup_id,	'2020-07-12' as transaction_start_date,	9.9 as amt from dual union all
select 64 as transaction_id,	132 as signup_id,	'2020-08-11' as transaction_start_date,	9.9 as amt from dual union all
select 65 as transaction_id,	132 as signup_id,	'2020-09-10' as transaction_start_date,	9.9 as amt from dual union all
select 66 as transaction_id,	133 as signup_id,	'2020-04-22' as transaction_start_date,	9.9 as amt from dual union all
select 67 as transaction_id,	133 as signup_id,	'2020-05-22' as transaction_start_date,	9.9 as amt from dual union all
select 68 as transaction_id,	134 as signup_id,	'2020-05-06' as transaction_start_date,	24.9 as amt from dual union all
select 69 as transaction_id,	135 as signup_id,	'2020-04-25' as transaction_start_date,	24.9 as amt from dual union all
select 70 as transaction_id,	135 as signup_id,	'2020-07-24' as transaction_start_date,	24.9 as amt from dual union all
select 71 as transaction_id,	136 as signup_id,	'2020-05-05' as transaction_start_date,	24.9 as amt from dual union all
select 72 as transaction_id,	137 as signup_id,	'2020-04-22' as transaction_start_date,	9.9 as amt from dual union all
select 73 as transaction_id,	137 as signup_id,	'2020-05-22' as transaction_start_date,	9.9 as amt from dual union all
select 74 as transaction_id,	137 as signup_id,	'2020-06-21' as transaction_start_date,	9.9 as amt from dual union all
select 75 as transaction_id,	138 as signup_id,	'2020-05-01' as transaction_start_date,	24.9 as amt from dual union all
select 76 as transaction_id,	138 as signup_id,	'2020-07-30' as transaction_start_date,	24.9 as amt from dual union all
select 77 as transaction_id,	139 as signup_id,	'2020-05-05' as transaction_start_date,	24.9 as amt from dual union all
select 78 as transaction_id,	139 as signup_id,	'2020-08-03' as transaction_start_date,	24.9 as amt from dual union all
select 79 as transaction_id,	140 as signup_id,	'2020-04-24' as transaction_start_date,	24.9 as amt from dual union all
select 80 as transaction_id,	140 as signup_id,	'2020-07-23' as transaction_start_date,	24.9 as amt from dual union all
select 81 as transaction_id,	141 as signup_id,	'2020-05-04' as transaction_start_date,	9.9 as amt from dual union all
select 82 as transaction_id,	141 as signup_id,	'2020-06-03' as transaction_start_date,	9.9 as amt from dual union all
select 83 as transaction_id,	141 as signup_id,	'2020-07-03' as transaction_start_date,	9.9 as amt from dual union all
select 84 as transaction_id,	141 as signup_id,	'2020-08-02' as transaction_start_date,	9.9 as amt from dual union all
select 85 as transaction_id,	141 as signup_id,	'2020-09-01' as transaction_start_date,	9.9 as amt from dual union all
select 86 as transaction_id,	142 as signup_id,	'2020-04-16' as transaction_start_date,	24.9 as amt from dual union all
select 87 as transaction_id,	143 as signup_id,	'2020-05-06' as transaction_start_date,	24.9 as amt from dual union all
select 88 as transaction_id,	143 as signup_id,	'2020-08-04' as transaction_start_date,	24.9 as amt from dual union all
select 89 as transaction_id,	144 as signup_id,	'2020-04-20' as transaction_start_date,	109.9 as amt from dual union all
select 90 as transaction_id,	145 as signup_id,	'2020-05-06' as transaction_start_date,	24.9 as amt from dual union all
select 91 as transaction_id,	146 as signup_id,	'2020-05-02' as transaction_start_date,	109.9 as amt from dual union all
select 92 as transaction_id,	147 as signup_id,	'2020-05-01' as transaction_start_date,	24.9 as amt from dual union all
select 93 as transaction_id,	147 as signup_id,	'2020-07-30' as transaction_start_date,	24.9 as amt from dual union all
select 94 as transaction_id,	148 as signup_id,	'2020-05-06' as transaction_start_date,	9.9 as amt from dual union all
select 95 as transaction_id,	148 as signup_id,	'2020-06-05' as transaction_start_date,	9.9 as amt from dual union all
select 96 as transaction_id,	148 as signup_id,	'2020-07-05' as transaction_start_date,	9.9 as amt from dual union all
select 97 as transaction_id,	148 as signup_id,	'2020-08-04' as transaction_start_date,	9.9 as amt from dual union all
select 98 as transaction_id,	148 as signup_id,	'2020-09-03' as transaction_start_date,	9.9 as amt from dual union all
select 99 as transaction_id,	148 as signup_id,	'2020-10-03' as transaction_start_date,	9.9 as amt from dual union all
select 100 as transaction_id,	149 as signup_id,	'2020-05-05' as transaction_start_date,	109.9 as amt from dual
),
avg_signups as (
select location, round(avg(to_date(signup_stop_date, 'YYYY-MM-DD') - to_date(signup_start_date, 'YYYY-MM-DD')),3) as avg_signup from signups group by location
),
avg_transactions as (
select s.location, round(avg(amt),3) as avg_transaction from signups s join transactions t on s.signup_id = t.signup_id group by s.location
)
select ss.location, avg_signup, avg_transaction, round((avg_transaction / avg_signup),3) as ratio from avg_transactions tt join avg_signups ss on tt.location = ss.location order by 4 desc;







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







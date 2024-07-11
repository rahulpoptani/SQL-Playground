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







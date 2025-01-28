-- Active User Retention: Facebook: https://datalemur.com/questions/user-retention
-- Assume you're given a table containing information on Facebook user actions. Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".
-- An active user is defined as a user who has performed actions such as 'sign-in', 'like', or 'comment' in both the current month and the previous month.

with user_actions as (
	select 445 as user_id, 7765 as event_id, 'sign-in' as event_type, '05/31/2022 12:00:00' as event_date from dual union all
	select 742 as user_id, 6458 as event_id, 'sign-in' as event_type, '06/03/2022 12:00:00' as event_date from dual union all
	select 445 as user_id, 3634 as event_id, 'like' as event_type, '06/05/2022 12:00:00' as event_date from dual union all
	select 742 as user_id, 1374 as event_id, 'comment' as event_type, '06/05/2022 12:00:00' as event_date from dual union all
	select 648 as user_id, 3124 as event_id, 'like' as event_type, '06/18/2022 12:00:00' as event_date from dual
),
user_action_formatted as (
	select user_id, event_type, to_date(event_date, 'MM/DD/YYYY HH24:MI:SS') as event_date from user_actions
)
select trim(0 from to_char(a.event_date, 'MM')) as month, count(distinct a.user_id) as monthly_active_users 
from user_action_formatted a join user_action_formatted b 
on add_months(trunc(a.event_date, 'month'), -1) = trunc(b.event_date, 'month') and a.user_id = b.user_id
where a.event_type in ('sign-in', 'like', 'comment') and b.event_type in ('sign-in', 'like', 'comment')
group by trim(0 from to_char(a.event_date, 'MM'));


--Y-on-Y Growth Rate: WayFair: https://datalemur.com/questions/yoy-growth-rate

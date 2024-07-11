-- 2000: Variable vs Fixed Rates
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


-- 2125: Process a Refund
with noom_signups as (
select 'S001' as signup_id,	'2018-10-06' as started_at,	101 as plan_id from dual union all
select 'S002' as signup_id,	'2018-11-01' as started_at,	101 as plan_id from dual union all
select 'S003' as signup_id,	'2018-11-02' as started_at,	103 as plan_id from dual union all
select 'S004' as signup_id,	'2018-11-05' as started_at,	103 as plan_id from dual union all
select 'S005' as signup_id,	'2018-11-15' as started_at,	102 as plan_id from dual union all
select 'S006' as signup_id,	'2018-12-14' as started_at,	102 as plan_id from dual union all
select 'S007' as signup_id,	'2019-01-01' as started_at,	101 as plan_id from dual union all
select 'S008' as signup_id,	'2019-01-14' as started_at,	102 as plan_id from dual union all
select 'S009' as signup_id,	'2019-01-27' as started_at,	101 as plan_id from dual union all
select 'S010' as signup_id,	'2019-02-04' as started_at,	102 as plan_id from dual union all
select 'S011' as signup_id,	'2019-02-05' as started_at,	103 as plan_id from dual union all
select 'S012' as signup_id,	'2019-02-23' as started_at,	102 as plan_id from dual union all
select 'S013' as signup_id,	'2019-04-10' as started_at,	103 as plan_id from dual union all
select 'S014' as signup_id,	'2019-05-20' as started_at,	101 as plan_id from dual union all
select 'S015' as signup_id,	'2019-05-24' as started_at,	102 as plan_id from dual union all
select 'S016' as signup_id,	'2019-06-30' as started_at,	103 as plan_id from dual union all
select 'S017' as signup_id,	'2019-07-24' as started_at,	102 as plan_id from dual union all
select 'S018' as signup_id,	'2019-08-10' as started_at,	103 as plan_id from dual union all
select 'S019' as signup_id,	'2019-09-05' as started_at,	101 as plan_id from dual union all
select 'S020' as signup_id,	'2019-09-09' as started_at,	101 as plan_id from dual union all
select 'S021' as signup_id,	'2019-09-11' as started_at,	101 as plan_id from dual union all
select 'S022' as signup_id,	'2019-09-23' as started_at,	102 as plan_id from dual union all
select 'S023' as signup_id,	'2019-10-10' as started_at,	101 as plan_id from dual union all
select 'S024' as signup_id,	'2019-12-10' as started_at,	101 as plan_id from dual union all
select 'S025' as signup_id,	'2020-01-02' as started_at,	101 as plan_id from dual
),
noom_transactions as (
select 1001 as transaction_id,	'S001' as signup_id,	'2019-02-09' as settled_at,	'2019-02-16' as refunded_at,	15 as usd_gross from dual union all
select 1002 as transaction_id,	'S002' as signup_id,	'2019-02-27' as settled_at,	'2019-03-11' as refunded_at,	15 as usd_gross from dual union all
select 1003 as transaction_id,	'S003' as signup_id,	'2019-03-09' as settled_at,	'2019-03-24' as refunded_at,	100 as usd_gross from dual union all
select 1004 as transaction_id,	'S004' as signup_id,	'2019-03-10' as settled_at,	'2019-03-15' as refunded_at,	100 as usd_gross from dual union all
select 1005 as transaction_id,	'S005' as signup_id,	'2019-03-27' as settled_at,	'2019-04-05' as refunded_at,	50 as usd_gross from dual union all
select 1006 as transaction_id,	'S006' as signup_id,	'2019-04-01' as settled_at,	'2019-04-09' as refunded_at,	50 as usd_gross from dual union all
select 1007 as transaction_id,	'S007' as signup_id,	'2019-04-18' as settled_at,	'2019-04-30' as refunded_at,	15 as usd_gross from dual union all
select 1008 as transaction_id,	'S008' as signup_id,	'2019-05-03' as settled_at,	'2019-05-10' as refunded_at,	50 as usd_gross from dual union all
select 1009 as transaction_id,	'S009' as signup_id,	'2019-05-10' as settled_at,	'2019-05-25' as refunded_at,	15 as usd_gross from dual union all
select 1010 as transaction_id,	'S010' as signup_id,	'2019-07-10' as settled_at,	'2019-07-21' as refunded_at,	50 as usd_gross from dual union all
select 1011 as transaction_id,	'S011' as signup_id,	'2019-07-28' as settled_at,	'2019-08-10' as refunded_at,	100 as usd_gross from dual union all
select 1012 as transaction_id,	'S012' as signup_id,	'2019-09-09' as settled_at,	'2019-09-18' as refunded_at,	50 as usd_gross from dual union all
select 1013 as transaction_id,	'S013' as signup_id,	'2019-09-15' as settled_at,	'2019-09-24' as refunded_at,	100 as usd_gross from dual union all
select 1014 as transaction_id,	'S014' as signup_id,	'2019-11-08' as settled_at,	'2019-11-21' as refunded_at,	15 as usd_gross from dual union all
select 1015 as transaction_id,	'S015' as signup_id,	'2019-11-22' as settled_at,	'2019-11-28' as refunded_at,	50 as usd_gross from dual union all
select 1016 as transaction_id,	'S016' as signup_id,	'2019-12-03' as settled_at,	'2019-12-13' as refunded_at,	100 as usd_gross from dual union all
select 1017 as transaction_id,	'S017' as signup_id,	'2019-12-11' as settled_at,	'2019-12-18' as refunded_at,	50 as usd_gross from dual union all
select 1018 as transaction_id,	'S018' as signup_id,	'2020-01-23' as settled_at,	'2020-01-29' as refunded_at,	100 as usd_gross from dual union all
select 1019 as transaction_id,	'S019' as signup_id,	'2020-04-30' as settled_at,	'2020-05-07' as refunded_at,	15 as usd_gross from dual union all
select 1020 as transaction_id,	'S020' as signup_id,	'2020-07-05' as settled_at,	'2020-07-11' as refunded_at,	15 as usd_gross from dual union all
select 1021 as transaction_id,	'S021' as signup_id,	'2020-07-07' as settled_at,	'2020-07-18' as refunded_at,	15 as usd_gross from dual union all
select 1022 as transaction_id,	'S022' as signup_id,	'2020-07-14' as settled_at,	'2020-07-28' as refunded_at,	50 as usd_gross from dual union all
select 1023 as transaction_id,	'S023' as signup_id,	'2020-09-03' as settled_at,	'2020-09-24' as refunded_at,	15 as usd_gross from dual union all
select 1024 as transaction_id,	'S024' as signup_id,	'2020-09-27' as settled_at,	'2020-10-02' as refunded_at,	15 as usd_gross from dual union all
select 1025 as transaction_id,	'S025' as signup_id,	'2020-12-21' as settled_at,	'2020-12-25' as refunded_at,	15 as usd_gross from dual
),
noom_plans as (
select 101 as plan_id,	1 as billing_cycle_in_months,	15 as plan_rate from dual union all
select 102 as plan_id,	6 as billing_cycle_in_months,	50 as plan_rate from dual union all
select 103 as plan_id,	12 as billing_cycle_in_months,	100 as plan_rate from dual
),
combined as (
select np.billing_cycle_in_months, to_date(nt.refunded_at,'YYYY-MM-DD') - to_date(nt.settled_at,'YYYY-MM-DD') process_days
from noom_signups ns join noom_transactions nt on ns.signup_id = nt.signup_id
join noom_plans np on ns.plan_id = np.plan_id
where to_date(ns.started_at, 'YYYY-MM-DD') > to_date('2019-01-01','YYYY-MM-DD')
)
select billing_cycle_in_months, min(process_days) as min_days, avg(process_days) as avg_days, max(process_days) as max_days from combined group by billing_cycle_in_months;

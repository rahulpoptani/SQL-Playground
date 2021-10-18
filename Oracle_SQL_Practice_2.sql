
-- list of employees with same salary
select a.empno, a.ename, a.job, a.sal
from emp a join emp b on a.sal = b.sal and a.empno <> b.empno;

-- median salary in each department
select deptno, percentile_cont(0.5) within group (order by sal desc) as median_salary
from emp group by deptno;

-- cast examples
with tmp as (select '2021-01-01' as dt from dual)
select dt, cast(dt as date) as dt_date1, to_date(dt, 'YYYY-MM-DD') as dt_date2 from tmp;

with tmp as (select 123.34 as dbl from dual)
select dbl, cast(dbl as char(10)) as string from tmp;

with tmp as (select '  1990 ' as string from dual)
select string, cast(string as number) as num from tmp;

with tmp as (select 123 as num from dual)
select num, cast(num as varchar2(10)) as string from tmp;


-- What is the overall friend acceptance rate by date? Your output should have the rate of acceptances by the date the request was sent. Order by the earliest date to latest.
-- (StrataScratch) (Facebook)
with fb_friend_requests as (
select 'ad4943sdz' as user_id_sender, '948ksx123d' as user_id_receiver, '2020-01-04' as action_date, 'sent' as action from dual union all
select 'ad4943sdz' as user_id_sender, '948ksx123d' as user_id_receiver, '2020-01-06' as action_date, 'accepted' as action from dual union all
select 'dfdfxf9483' as user_id_sender, '9djjjd9283' as user_id_receiver, '2020-01-04' as action_date, 'sent' as action from dual union all
select 'dfdfxf9483' as user_id_sender, '9djjjd9283' as user_id_receiver, '2020-01-15' as action_date, 'accepted' as action from dual union all
select 'ffdfff4234234' as user_id_sender, 'lpjzjdi4949' as user_id_receiver, '2020-01-06' as action_date, 'sent' as action from dual union all
select 'fffkfld9499' as user_id_sender, '993lsldidif' as user_id_receiver, '2020-01-06' as action_date, 'sent' as action from dual union all
select 'fffkfld9499' as user_id_sender, '993lsldidif' as user_id_receiver, '2020-01-10' as action_date, 'accepted' as action from dual union all
select 'fg503kdsdd' as user_id_sender, 'ofp049dkd' as user_id_receiver, '2020-01-04' as action_date, 'sent' as action from dual union all
select 'fg503kdsdd' as user_id_sender, 'ofp049dkd' as user_id_receiver, '2020-01-10' as action_date, 'accepted' as action from dual union all
select 'hh643dfert' as user_id_sender, '847jfkf203' as user_id_receiver, '2020-01-04' as action_date, 'sent' as action from dual union all
select 'r4gfgf2344' as user_id_sender, '234ddr4545' as user_id_receiver, '2020-01-06' as action_date, 'sent' as action from dual union all
select 'r4gfgf2344' as user_id_sender, '234ddr4545' as user_id_receiver, '2020-01-11' as action_date, 'accepted' as action from dual
)
select s.action_date, trunc(sum(case when a.action is not null then 1.0 else 0 end)/count(*),2) as percentage_acceptance
from
(select * from fb_friend_requests where action = 'sent') s
left join 
(select * from fb_friend_requests where action = 'accepted') a
on s.user_id_sender = a.user_id_sender and s.user_id_receiver = a.user_id_receiver
group by s.action_date
order by s.action_date;
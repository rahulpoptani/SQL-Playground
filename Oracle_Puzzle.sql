
-- Print A,B,C..Z in new rows
select chr(level) chr from dual
where level >= ascii('A') and level <= ascii('Z')
connect by level <= 100;

With blist (num, character) as 
(select level, chr(level + ascii('A')-1) from dual connect by level <= ascii('Z') - ascii('A')+1) 
select num, character from blist;


-- Find Breaks between dates
with dates as (
select to_date('2021-09-01', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-02', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-03', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-04', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-07', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-08', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-09', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-10', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-11', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-15', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-16', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-17', 'YYYY-MM-DD') dt from dual
)
select min(dt) start_dt, max(dt) end_dt, count(*) num_samples from (
select dt, dt - row_number() over (order by dt) delta from dates
) group by delta order by 1;

-- Another approach
with dates as (
select to_date('2021-09-01', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-02', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-03', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-04', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-07', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-08', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-09', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-10', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-11', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-15', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-16', 'YYYY-MM-DD') dt from dual union all
select to_date('2021-09-17', 'YYYY-MM-DD') dt from dual
)
select min(dt) start_dt, max(dt) as end_dt from 
(
    select dt, max(local) over (order by dt) as newlocal from 
    (
        select dt, case when nvl(lag(dt) over (order by dt), dt) != dt-1 then dt end local from dates
    ) 
) group by newlocal order by 1;


-- remove duplicate travel source and destinations.
with travel as (
select 'Delhi' as source, 'Mumbai' as destination, 100 as fare from dual union all
select 'Mumbai' as source, 'Delhi' as destination, 100 as fare from dual union all
select 'London' as source, 'New York' as destination, 500 as fare from dual
)
select * from (select source, destination, fare from travel union select destination as source, source as destination, fare from travel) where source < destination;


-- Get Cummulative Quanity at Each day - including missing days when there are no transactions
with inventory as (
select to_date('2021-01-01','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key, 100 as quantity from dual union all
select to_date('2021-01-02','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key, -20 as quantity from dual union all
select to_date('2021-01-03','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key, -30 as quantity from dual union all
select to_date('2021-01-05','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key,  20 as quantity from dual
),
dates as (
select (select min(date_key) from inventory) + level-1 as seq_date from dual connect by level <= (select (max(date_key)-min(date_key))+1 from inventory)
)
select seq_date as date_key, 
coalesce(product_key, first_value(product_key) over (order by date_key)) as product_key,
coalesce(store_key, first_value(store_key) over (order by date_key)) as store_key,
sum(quantity) over (order by seq_date) as quantity
from dates d left join inventory i on d.seq_date = i.date_key order by seq_date;


-- Get Cummulative Quanity at Each day - including missing days when there are no transactions (Multiple Products)
with inventory as (
select to_date('2021-01-01','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key, 100 as quantity from dual union all
select to_date('2021-01-01','YYYY-MM-DD') as date_key, 456 as product_key, 'A1' as store_key, 100 as quantity from dual union all
select to_date('2021-01-02','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key, -20 as quantity from dual union all
select to_date('2021-01-02','YYYY-MM-DD') as date_key, 456 as product_key, 'A1' as store_key, -20 as quantity from dual union all
select to_date('2021-01-03','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key, -30 as quantity from dual union all
select to_date('2021-01-03','YYYY-MM-DD') as date_key, 456 as product_key, 'A1' as store_key, -30 as quantity from dual union all
select to_date('2021-01-05','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key,  20 as quantity from dual union all
select to_date('2021-01-05','YYYY-MM-DD') as date_key, 456 as product_key, 'A1' as store_key,  20 as quantity from dual
),
dates as (
select (select min(date_key) from inventory) + level-1 as seq_date from dual connect by level <= (select (max(date_key)-min(date_key))+1 from inventory)
)
select * from dates;

-- create new session. New Session should be created after 30 mins of inactivity
with events as (
select 1 as user_id, to_date('2022-01-01 00:10:00','YYYY-MM-DD HH24:MI:SS') as event_timestamp from dual union all
select 1 as user_id, to_date('2022-01-01 00:20:00','YYYY-MM-DD HH24:MI:SS') as event_timestamp from dual union all
select 1 as user_id, to_date('2022-01-01 00:55:00','YYYY-MM-DD HH24:MI:SS') as event_timestamp from dual union all
select 1 as user_id, to_date('2022-01-01 01:10:00','YYYY-MM-DD HH24:MI:SS') as event_timestamp from dual union all
select 1 as user_id, to_date('2022-01-01 01:30:00','YYYY-MM-DD HH24:MI:SS') as event_timestamp from dual union all
select 1 as user_id, to_date('2022-01-01 02:20:00','YYYY-MM-DD HH24:MI:SS') as event_timestamp from dual
)
select user_id, event_timestamp, 'S' || sum(new_session) over (partition by user_id order by event_timestamp) as session_id from (
select user_id, event_timestamp, case when diff > 30 or diff is null then 1 else 0 end as new_session from (
select user_id, event_timestamp, trunc((event_timestamp - lag(event_timestamp, 1) over (partition by user_id order by event_timestamp)) * 24 * 60) as diff from events
));

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
select min(dt) start_dt, max(dt) as end_dt, count(*) as days from 
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


-- Get Cummulative Quanity at Each day
with inventory as (
select to_date('2021-01-01','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key, 100 as quantity from dual union all
select to_date('2021-01-02','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key, -20 as quantity from dual union all
select to_date('2021-01-03','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key, -30 as quantity from dual union all
select to_date('2021-01-05','YYYY-MM-DD') as date_key, 123 as product_key, 'A1' as store_key,  20 as quantity from dual
)
select date_key, product_key, store_key, sum(quantity) over (order by date_key) as quantity from inventory;


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
select 
	d.seq_date as date_key, 
	coalesce(i.product_key, last_value(i.product_key) ignore nulls over (order by d.seq_date)) as product_key,
	coalesce(i.store_key, last_value(i.store_key) ignore nulls over (order by d.seq_date)) as store_key,
	sum(i.quantity) over (order by seq_date) as quantity
from dates d left join inventory i on d.seq_date = i.date_key;

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

-- Bank Transaction: Previous Opposite Debit/Credit Transaction
drop table transactions;
create table transactions (trans_id integer, trans_date date, trans_type varchar2(10) check (trans_type in ('CREDIT','DEBIT')), amount number(10,2));
insert into transactions values (1, date'2015-01-06', 'DEBIT', 100);
insert into transactions values (2, date'2015-01-05', 'DEBIT', 200);
insert into transactions values (3, date'2015-01-04', 'CREDIT', 50);
insert into transactions values (4, date'2015-01-03', 'DEBIT', 99);
insert into transactions values (5, date'2015-01-02', 'CREDIT', 200);
insert into transactions values (6, date'2015-01-01', 'CREDIT', 40);
insert into transactions values (7, date'2015-01-01', 'CREDIT', 90);
insert into transactions values (8, date'2015-01-01', 'DEBIT', 80);
commit;
select * from transactions order by trans_date, trans_id;
select t.*, 
case when trans_type = 'CREDIT' 
then last_value(case when trans_type <> 'CREDIT' then trans_id end) ignore nulls over (order by trans_date, trans_id)
else
last_value(case when trans_type <> 'DEBIT' then trans_id end) ignore nulls over (order by trans_date, trans_id)
end prev_trans_id
from transactions t order by trans_date, trans_id;

-- new customers each day
with purchase as
(
    select 1 as cust_id, '2021-01-01' as purchase_date from dual union all
    select 2 as cust_id, '2021-01-01' as purchase_date from dual union all
    select 1 as cust_id, '2021-01-02' as purchase_date from dual union all
    select 3 as cust_id, '2021-01-02' as purchase_date from dual union all
    select 3 as cust_id, '2021-01-03' as purchase_date from dual union all
    select 4 as cust_id, '2021-01-03' as purchase_date from dual union all
    select 1 as cust_id, '2021-01-04' as purchase_date from dual union all
    select 2 as cust_id, '2021-01-04' as purchase_date from dual
)
select purchase_date, sum(case when occurence = 1 then 1 else 0 end) as new_users from (
	select cust_id, purchase_date, rank() over (partition by cust_id order by purchase_date) as occurence from purchase order by purchase_date
)
group by purchase_date;

-- Equivalent of Leetcode #739 challenge in SQL
with temperatures as (
	select 73 as temperature from dual union all
	select 74 as temperature from dual union all
	select 75 as temperature from dual union all
	select 71 as temperature from dual union all
	select 69 as temperature from dual union all
	select 72 as temperature from dual union all
	select 76 as temperature from dual union all
	select 73 as temperature from dual
),
with_rownum as (
	select temperature, row_number() over (order by null) as rn from temperatures
),
result as (
	select a.temperature as tmp1, a.rn as rn1, b.temperature as tmp2, b.rn as rn2, dense_rank() over (partition by a.temperature order by b.rn) as nearest_rank 
	from with_rownum a left join with_rownum b on a.temperature < b.temperature and a.rn < b.rn
)
select tmp1 as temperature, case when rn2 is not null then rn2-rn1 else 0 end as answer 
from result where nearest_rank = 1 or tmp2 is null 
order by rn1;
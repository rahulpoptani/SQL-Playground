-- Print A,B,C..Z in new rows
select chr(level) chr from dual
where level >= ascii('A') and level <= ascii('Z')
connect by level <= 100;

With blist (num, character) as 
(select level, chr(level+ascii('A')-1)  from dual  CONNECT BY LEVEL<= ascii('Z')-ascii('A')+1) 
select * from blist;


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





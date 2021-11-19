-- Trips and Users (Leetcode)
with trips as (
    select 1  id, 1 client_id, 10 driver_id, 'completed'            status, to_date('2013-10-01','YYYY-MM-DD') request_at from dual union all
    select 2  id, 2 client_id, 11 driver_id, 'cancelled_by_driver'  status, to_date('2013-10-01','YYYY-MM-DD') request_at from dual union all
    select 3  id, 3 client_id, 12 driver_id, 'completed'            status, to_date('2013-10-01','YYYY-MM-DD') request_at from dual union all
    select 4  id, 4 client_id, 13 driver_id, 'cancelled_by_client'  status, to_date('2013-10-01','YYYY-MM-DD') request_at from dual union all
    select 5  id, 1 client_id, 10 driver_id, 'completed'            status, to_date('2013-10-02','YYYY-MM-DD') request_at from dual union all
    select 6  id, 2 client_id, 11 driver_id, 'completed'            status, to_date('2013-10-02','YYYY-MM-DD') request_at from dual union all
    select 7  id, 3 client_id, 12 driver_id, 'completed'            status, to_date('2013-10-02','YYYY-MM-DD') request_at from dual union all
    select 8  id, 2 client_id, 12 driver_id, 'completed'            status, to_date('2013-10-03','YYYY-MM-DD') request_at from dual union all
    select 9  id, 3 client_id, 10 driver_id, 'completed'            status, to_date('2013-10-03','YYYY-MM-DD') request_at from dual union all
    select 10 id, 4 client_id, 13 driver_id, 'cancelled_by_driver'  status, to_date('2013-10-03','YYYY-MM-DD') request_at from dual
),
users as (
    select 1    users_id, 'No'  Banned, 'client' Role from dual union all
    select 2    users_id, 'Yes' Banned, 'client' Role from dual union all
    select 3    users_id, 'No'  Banned, 'client' Role from dual union all
    select 4    users_id, 'No'  Banned, 'client' Role from dual union all
    select 10   users_id, 'No'  Banned, 'driver' Role from dual union all
    select 11   users_id, 'No'  Banned, 'driver' Role from dual union all
    select 12   users_id, 'No'  Banned, 'driver' Role from dual union all
    select 13   users_id, 'No'  Banned, 'driver' Role from dual
)
select 
request_at Day, round(sum(case when status <> 'completed' then 1 else 0 end)/count(*),2) "Cancellation Rate"
from trips
where
request_at between '2013-10-01' and '2013-10-03'
and client_id not in (select users_id from users where banned = 'Yes')
and driver_id not in (select users_id from users where banned = 'Yes')
group by request_at
order by 1;



-- Human traffic in Stadium (Leetcode) -- Write an SQL query to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each
with stadium as (
    select 1 id, to_date('2017-01-01') visit_date, 10   people from dual union all
    select 2 id, to_date('2017-01-02') visit_date, 109  people from dual union all
    select 3 id, to_date('2017-01-03') visit_date, 150  people from dual union all
    select 4 id, to_date('2017-01-04') visit_date, 99   people from dual union all
    select 5 id, to_date('2017-01-05') visit_date, 145  people from dual union all
    select 6 id, to_date('2017-01-06') visit_date, 1455 people from dual union all
    select 7 id, to_date('2017-01-07') visit_date, 199  people from dual union all
    select 8 id, to_date('2017-01-09') visit_date, 188  people from dual
)
select id as "id", to_char(visit_date, 'YYYY-MM-DD') as "visit_date", people as "people" 
from (
    select distinct s1.id, s1.visit_date, s1.people 
    from stadium s1 cross join stadium s2 cross join stadium s3
    where 
    s1.people >= 100 and s2.people >= 100 and s3.people >= 100
    and 
    (
        (s1.id = s2.id-1 and s1.id = s3.id-2) or (s1.id = s2.id+1 and s1.id = s3.id+2) or (s1.id = s2.id-1 and s1.id = s3.id+1)
    )
    order by s1.visit_date
);


-- List of highest paid 3 employees from each department
select * from (
select deptno, ename, sal, dense_rank() over (partition by deptno order by sal desc) saldesc from emp
) where saldesc <= 3;



-- Delete duplicate email
drop table person;
create table person as
select 1 id, 'john@example.com' email from dual union all
select 2 id, 'bob@example.com' email from dual union all
select 3 id, 'john@example.com' email from dual;
select * from person;
-- Approach 1
delete from person where id not in (select min(id) from person group by email);
-- Approach 2
delete from person where id in (select p1.id from person p1 join person p2 on p1.email = p2.email and p1.id > p2.id);





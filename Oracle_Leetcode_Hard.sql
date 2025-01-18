-- #185 - Department Top 3 Salaries
with employee as (
select 1 as id, 'Joe' as name, 85000 as salary, 1 as departmentId from dual union all
select 2 as id, 'Henry' as name, 80000 as salary, 2 as departmentId from dual union all
select 3 as id, 'Sam' as name, 60000 as salary, 2 as departmentId from dual union all
select 4 as id, 'Max' as name, 90000 as salary, 1 as departmentId from dual union all
select 5 as id, 'Janet' as name, 69000 as salary, 1 as departmentId from dual union all
select 6 as id, 'Randy' as name, 85000 as salary, 1 as departmentId from dual union all
select 7 as id, 'Will' as name, 70000 as salary, 1 as departmentId from dual
),
department as (
select 1 as id, 'IT' as name from dual union all
select 2 as id, 'Sales' as name from dual
)
select department, employee, salary from (
select d.name as department, e.name as Employee, e.salary, dense_rank() over (partition by departmentId order by salary desc) as rn from employee e join department d on e.departmentId = d.id) where rn <= 3;


-- #262 - Trips and Users
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
select request_at Day, round(sum(case when status <> 'completed' then 1 else 0 end)/count(*),2) "Cancellation Rate" 
from trips where request_at between '2013-10-01' and '2013-10-03'
and client_id not in (select users_id from users where banned = 'Yes')
and driver_id not in (select users_id from users where banned = 'Yes')
group by request_at order by 1;


-- #569 - Median Employee Salary
with employee as (
select 1 as id, 'A' as company, 2341 as salary from dual union all
select 2 as id, 'A' as company, 341 as salary from dual union all
select 3 as id, 'A' as company, 15 as salary from dual union all
select 4 as id, 'A' as company, 15314 as salary from dual union all
select 5 as id, 'A' as company, 451 as salary from dual union all
select 6 as id, 'A' as company, 513 as salary from dual union all
select 7 as id, 'B' as company, 15 as salary from dual union all
select 8 as id, 'B' as company, 13 as salary from dual union all
select 9 as id, 'B' as company, 1154 as salary from dual union all
select 10 as id, 'B' as company, 1345 as salary from dual union all
select 11 as id, 'B' as company, 1221 as salary from dual union all
select 12 as id, 'B' as company, 234 as salary from dual union all
select 13 as id, 'C' as company, 2345 as salary from dual union all
select 14 as id, 'C' as company, 2645 as salary from dual union all
select 15 as id, 'C' as company, 2645 as salary from dual union all
select 16 as id, 'C' as company, 2652 as salary from dual union all
select 17 as id, 'C' as company, 65 as salary from dual
)
select id, company, salary 
from (select id, company, salary, dense_rank() over (partition by company order by salary,id) as rn, count(*) over (partition by company) / 2 as cn from employee) 
where rn between cn and cn+1;


-- #571 - Find Median Given Frequency of Number
with numbers as (
select 0 as num, 7 as frequency from dual union all
select 1 as num, 1 as frequency from dual union all
select 2 as num, 3 as frequency from dual union all
select 3 as num, 1 as frequency from dual
)
select avg(num) as median from (
select num, freq, row_number() over(order by num) as mean, count(*) over () / 2 as cnt from
(select distinct num, level as freq from numbers connect by level <= frequency order by num, level)
) where mean between cnt and cnt+1;


-- #601 - Human Traffic of Stadium - Display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each
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
select distinct s1.id, s1.visit_date, s1.people from stadium s1 cross join stadium s2 cross join stadium s3
where s1.people >= 100 and s2.people >= 100 and s3.people >= 100
and ((s1.id = s2.id-1 and s1.id = s3.id-2) or (s1.id = s2.id+1 and s1.id = s3.id+2));


-- #615 - Average Salary Department vs Company
with salary as (
select 1 as id, 1 as employee_id, 9000 as amount, to_date('2017-03-31','YYYY-MM-DD') as pay_date from dual union all
select 2 as id, 2 as employee_id, 6000 as amount, to_date('2017-03-31','YYYY-MM-DD') as pay_date from dual union all
select 3 as id, 3 as employee_id, 10000 as amount, to_date('2017-03-31','YYYY-MM-DD') as pay_date from dual union all
select 4 as id, 1 as employee_id, 7000 as amount, to_date('2017-02-28','YYYY-MM-DD') as pay_date from dual union all
select 5 as id, 2 as employee_id, 6000 as amount, to_date('2017-02-28','YYYY-MM-DD') as pay_date from dual union all
select 6 as id, 3 as employee_id, 8000 as amount, to_date('2017-02-28','YYYY-MM-DD') as pay_date from dual
),
employee as (
select 1 as employee_id, 1 as department_id from dual union all
select 2 as employee_id, 2 as department_id from dual union all
select 3 as employee_id, 2 as department_id from dual
)
select distinct to_char(pay_date,'YYYY-MM') as pay_month, department_id, case when avg_sal_dept > avg_sal_month then 'higher' when avg_sal_dept < avg_sal_month then 'lower' else 'same' end as comparison
from (select s.id, s.employee_id, s.amount, s.pay_date, e.department_id, avg(amount) over (partition by to_char(pay_date,'YYYY-MM')) as avg_sal_month, avg(amount) over (partition by department_id, to_char(pay_date,'YYYY-MM')) as avg_sal_dept
from salary s join employee e on e.employee_id = s.employee_id) order by pay_month;


-- #618 - Student Report By Geography - Pivot the continent column in this table so that each name is sorted alphabetically and displayed underneath its corresponding continent
with student as (
select 'Jack' as name, 'America' as continent from dual union all
select 'Pascal' as name, 'Europe' as continent from dual union all
select 'Xi' as name, 'Asia' as continent from dual union all
select 'Jane' as name, 'America' as continent from dual
)
select America, Asia, Europe from
(select name as America, row_number() over (order by name) as rn from student where continent = 'America') America
full join
(select name as Asia, row_number() over (order by name) as rn from student where continent = 'Asia') Asia on America.rn = Asia.rn
full join
(select name as Europe, row_number() over (order by name) as rn from student where continent = 'Europe') Europe on Asia.rn = Europe.rn;


-- #1097 - Game Play Analysis V
-- Report: players who install the game and also came next day divide by total players who install the game only on that given date
-- Player 1 and 3 install the game on same day, Player 1 came back next day hence 1/2 = 0.5
-- Player 2 install the game but didn't comes back hence 0/1 = 0.0
with activity as (
select 1 as player_id, 2 as device_id, to_date('2016-03-01', 'YYYY-MM-DD') as event_date, 5 as games_played from dual union all
select 1 as player_id, 2 as device_id, to_date('2016-03-02', 'YYYY-MM-DD') as event_date, 6 as games_played from dual union all
select 2 as player_id, 3 as device_id, to_date('2017-06-25', 'YYYY-MM-DD') as event_date, 1 as games_played from dual union all
select 3 as player_id, 1 as device_id, to_date('2016-03-01', 'YYYY-MM-DD') as event_date, 0 as games_played from dual union all
select 3 as player_id, 4 as device_id, to_date('2018-07-03', 'YYYY-MM-DD') as event_date, 5 as games_played from dual
)
select a.event_date as install_dt, count(a.player_id) as installs, count(b.player_id) as comes_next_day, count(b.player_id) / count(a.player_id) as Day1_rentention
from 
(select player_id, min(event_date) as event_date from activity group by player_id) a
left join activity b on a.player_id = b.player_id and a.event_date+1 = b.event_date
group by a.event_date;


-- #1127 - User Purchase Platform
with spending as (
select 1 as user_id, to_date('2019-07-01','YYYY-MM-DD') as spend_date, 'mobile' as platform, 100 as amount from dual union all
select 1 as user_id, to_date('2019-07-01','YYYY-MM-DD') as spend_date, 'desktop' as platform, 100 as amount from dual union all
select 2 as user_id, to_date('2019-07-01','YYYY-MM-DD') as spend_date, 'mobile' as platform, 100 as amount from dual union all
select 2 as user_id, to_date('2019-07-02','YYYY-MM-DD') as spend_date, 'mobile' as platform, 100 as amount from dual union all
select 3 as user_id, to_date('2019-07-01','YYYY-MM-DD') as spend_date, 'desktop' as platform, 100 as amount from dual union all
select 3 as user_id, to_date('2019-07-02','YYYY-MM-DD') as spend_date, 'desktop' as platform, 100 as amount from dual
)
select spend_date, case when items >= 2 then 'both' else purchased end as platform, sum(total_amount) as total_amount, count(distinct user_id) as total_users
from (
select spend_date, user_id, count(*) as items, max(platform) as purchased, sum(amount) as total_amount
from spending
group by spend_date, user_id
)
group by spend_date, case when items >= 2 then 'both' else purchased end
union all
select distinct spend_date, 'both' as platform, 0 as total_amount, 0 as total_users from spending where spend_date not in (select spend_date from spending group by spend_date, user_id having sum(case when platform = 'mobile' then 1 else 0 end) >= 1 and sum(case when platform = 'desktop' then 1 else 0 end) >= 1)
order by spend_date;


-- #1159 - Market Analysis II - Find for each user, whether the brand of the second item (by date) they sold is their favorite brand. If a user sold less than two items, report the answer for that user as no
with users as (
select 1 as user_id, to_date('2019-01-01','YYYY-MM-DD') as join_date, 'Lenovo' as favorite_brand from dual union all
select 2 as user_id, to_date('2019-02-09','YYYY-MM-DD') as join_date, 'Samsung' as favorite_brand from dual union all
select 3 as user_id, to_date('2019-01-19','YYYY-MM-DD') as join_date, 'LG' as favorite_brand from dual union all
select 4 as user_id, to_date('2019-05-21','YYYY-MM-DD') as join_date, 'HP' as favorite_brand from dual
),
orders as (
select 1 as order_id, to_date('2019-08-01','YYYY-MM-DD') as order_date, 4 as item_id, 1 as buyer_id, 2 as seller_id from dual union all
select 2 as order_id, to_date('2019-08-02','YYYY-MM-DD') as order_date, 2 as item_id, 1 as buyer_id, 3 as seller_id from dual union all
select 3 as order_id, to_date('2019-08-03','YYYY-MM-DD') as order_date, 3 as item_id, 2 as buyer_id, 3 as seller_id from dual union all
select 4 as order_id, to_date('2019-08-04','YYYY-MM-DD') as order_date, 1 as item_id, 4 as buyer_id, 2 as seller_id from dual union all
select 5 as order_id, to_date('2019-08-04','YYYY-MM-DD') as order_date, 1 as item_id, 3 as buyer_id, 4 as seller_id from dual union all
select 6 as order_id, to_date('2019-08-05','YYYY-MM-DD') as order_date, 2 as item_id, 2 as buyer_id, 4 as seller_id from dual
),
items as (
select 1 as item_id, 'Samsung' as item_brand from dual union all
select 2 as item_id, 'Lenovo' as item_brand from dual union all
select 3 as item_id, 'LG' as item_brand from dual union all
select 4 as item_id, 'HP' as item_brand from dual
)
select distinct a.user_id as seller_id, case when a.favorite_brand = i.item_brand then 'yes' else 'no' end as "2nd_item_fav_brand"
from (
select u.user_id, u.favorite_brand, o.order_id, o.order_date, o.item_id, o.buyer_id, o.seller_id, 
last_value(o.item_id) over (partition by o.seller_id order by o.order_date rows between unbounded preceding and 1 following) as second_prod
from users u left join orders o on o.seller_id = u.user_id
) a left join items i on i.item_id = a.second_prod
order by a.user_id;


-- #1194 - Tournament Winners - The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowest player_id wins
with players as (
select 15 as player_id, 1 as group_id from dual union all
select 25 as player_id, 1 as group_id from dual union all
select 30 as player_id, 1 as group_id from dual union all
select 45 as player_id, 1 as group_id from dual union all
select 10 as player_id, 2 as group_id from dual union all
select 35 as player_id, 2 as group_id from dual union all
select 50 as player_id, 2 as group_id from dual union all
select 20 as player_id, 3 as group_id from dual union all
select 40 as player_id, 3 as group_id from dual
),
matches as (
select 1 as match_id, 15 as first_player, 45 as second_player, 3 as first_score, 0 as second_score from dual union all
select 2 as match_id, 30 as first_player, 25 as second_player, 1 as first_score, 2 as second_score from dual union all
select 3 as match_id, 30 as first_player, 15 as second_player, 2 as first_score, 0 as second_score from dual union all
select 4 as match_id, 40 as first_player, 20 as second_player, 5 as first_score, 2 as second_score from dual union all
select 5 as match_id, 35 as first_player, 50 as second_player, 1 as first_score, 1 as second_score from dual
)
select distinct group_id, player_id from (
select a.*, p.*, dense_rank() over (partition by p.group_id order by first_score desc, player_id) as rn
from (
select match_id, first_player, first_score from matches 
union all 
select match_id, second_player, second_score from matches
) a join players p on p.player_id = a.first_player) where rn = 1 order by group_id;


-- #1225 - Report Contiguous Dates - Generate a report of period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31
with failed as (
select to_date('2018-12-28','YYYY-MM-DD') as fail_date from dual union all
select to_date('2018-12-29','YYYY-MM-DD') as fail_date from dual union all
select to_date('2019-01-04','YYYY-MM-DD') as fail_date from dual union all
select to_date('2019-01-05','YYYY-MM-DD') as fail_date from dual
),
succeeded as (
select to_date('2018-12-30','YYYY-MM-DD') as success_date from dual union all
select to_date('2018-12-31','YYYY-MM-DD') as success_date from dual union all
select to_date('2019-01-01','YYYY-MM-DD') as success_date from dual union all
select to_date('2019-01-02','YYYY-MM-DD') as success_date from dual union all
select to_date('2019-01-03','YYYY-MM-DD') as success_date from dual union all
select to_date('2019-01-06','YYYY-MM-DD') as success_date from dual
)
select 'failed' as period_state, min(fail_date) as start_date, max(fail_date) as end_date from (
select fail_date, fail_date - row_number() over (order by fail_date) as delta from failed where fail_date between to_date('2019-01-01','YYYY-MM-DD') and to_date('2019-12-31','YYYY-MM-DD')) group by delta
union all
select 'succeeded' as period_state, min(success_date) as start_date, max(success_date) as end_date from (
select success_date, success_date - row_number() over (order by success_date) as delta from succeeded where success_date between to_date('2019-01-01','YYYY-MM-DD') and to_date('2019-12-31','YYYY-MM-DD')) group by delta
order by start_date, end_date;


-- #1336 - Number of transactions per visit - How many users visited the bank and didn’t do any transactions, how many visited the bank and did one transaction and so on
with visits as (
select 1 as user_id, to_date('2020-01-01','YYYY-MM-DD') as visit_date from dual union all
select 2 as user_id, to_date('2020-01-02','YYYY-MM-DD') as visit_date from dual union all
select 12 as user_id, to_date('2020-01-01','YYYY-MM-DD') as visit_date from dual union all
select 19 as user_id, to_date('2020-01-03','YYYY-MM-DD') as visit_date from dual union all
select 1 as user_id, to_date('2020-01-02','YYYY-MM-DD') as visit_date from dual union all
select 2 as user_id, to_date('2020-01-03','YYYY-MM-DD') as visit_date from dual union all
select 1 as user_id, to_date('2020-01-04','YYYY-MM-DD') as visit_date from dual union all
select 7 as user_id, to_date('2020-01-11','YYYY-MM-DD') as visit_date from dual union all
select 9 as user_id, to_date('2020-01-25','YYYY-MM-DD') as visit_date from dual union all
select 8 as user_id, to_date('2020-01-28','YYYY-MM-DD') as visit_date from dual
),
transactions as (
select 1 as user_id, to_date('2020-01-02','YYYY-MM-DD') as transaction_date, 120 as amount from dual union all
select 2 as user_id, to_date('2020-01-03','YYYY-MM-DD') as transaction_date, 22 as amount from dual union all
select 7 as user_id, to_date('2020-01-11','YYYY-MM-DD') as transaction_date, 232 as amount from dual union all
select 1 as user_id, to_date('2020-01-04','YYYY-MM-DD') as transaction_date, 7 as amount from dual union all
select 9 as user_id, to_date('2020-01-25','YYYY-MM-DD') as transaction_date, 33 as amount from dual union all
select 9 as user_id, to_date('2020-01-25','YYYY-MM-DD') as transaction_date, 66 as amount from dual union all
select 8 as user_id, to_date('2020-01-28','YYYY-MM-DD') as transaction_date, 1 as amount from dual union all
select 9 as user_id, to_date('2020-01-25','YYYY-MM-DD') as transaction_date, 99 as amount from dual
)
select case when ll is null then 0 else ll end as transactions_count, case when visits is null then 0 else visits end as visits_count
from (select level as ll from dual connect by level <= (select max(trans) as maxtrans from (select count(*) trans from transactions group by user_id, transaction_Date))
) a full join (
select trans, count(*) as visits from (
select v.user_id, v.visit_date, count(t.user_id) as trans
from visits v left join transactions t on t.user_id = v.user_id and t.transaction_date = v.visit_date
group by v.user_id, v.visit_date)
group by trans
) b
on a.ll = b.trans
order by transactions_count;


-- #1369 - Get the second most recent activity - Show the second most recent activity of each user. If the user only has one activity, return that one
-- A user can’t perform more than one activity at the same time
with useractivity as (
select 'Alice' as username, 'Travel' as activity, to_date('2020-02-12','YYYY-MM-DD') as startDate, to_date('2020-02-20','YYYY-MM-DD') as endDate from dual union all
select 'Alice' as username, 'Dancing' as activity, to_date('2020-02-21','YYYY-MM-DD') as startDate, to_date('2020-02-23','YYYY-MM-DD') as endDate from dual union all
select 'Alice' as username, 'Travel' as activity, to_date('2020-02-24','YYYY-MM-DD') as startDate, to_date('2020-02-28','YYYY-MM-DD') as endDate from dual union all
select 'Bob' as username, 'Travel' as activity, to_date('2020-02-11','YYYY-MM-DD') as startDate, to_date('2020-02-18','YYYY-MM-DD') as endDate from dual
)
select distinct username, activity, startdate, enddate from (
select a.username, a.activity, a.startdate, a.enddate, rank() over (partition by a.username order by a.startdate) as rn1, count(a.activity) over (partition by a.username) as rn2 from useractivity a
) where (rn1 = 2 and rn2 <> 1) or (rn1 = 1 and rn2 = 1)
;


-- #1384 - Total Sales Amount by Year
with product as (
select 1 as product_id, 'LC Phone' as product_name from dual union all
select 2 as product_id, 'LC T-Shirt' as product_name from dual union all
select 3 as product_id, 'LC Keychain' as product_name from dual
),
sales as (
select 1 as product_id, to_date('2019-01-25','YYYY-MM-DD') as period_start, to_date('2019-02-28','YYYY-MM-DD') as period_end, 100 as average_daily_sales from dual union all
select 2 as product_id, to_date('2018-12-01','YYYY-MM-DD') as period_start, to_date('2020-01-01','YYYY-MM-DD') as period_end, 10 as average_daily_sales from dual union all
select 3 as product_id, to_date('2019-12-01','YYYY-MM-DD') as period_start, to_date('2020-01-31','YYYY-MM-DD') as period_end, 1 as average_daily_sales from dual
)
select p.product_id, p.product_name, a.year as report_year,case 
when a.year = to_char(s.period_start,'YYYY') and a.year = to_char(s.period_end,'YYYY') then s.period_end-s.period_start+1
when a.year > to_char(s.period_start,'YYYY') and a.year < to_char(s.period_end,'YYYY') then add_months(trunc(to_date(a.year,'YYYY'),'YEAR'),12) - trunc(to_date(a.year,'YYYY'),'YEAR')
when a.year = to_char(s.period_start,'YYYY') and a.year < to_char(s.period_end,'YYYY') then add_months(trunc(to_date(a.year,'YYYY'),'YEAR'),12) - s.period_start
when a.year > to_char(s.period_start,'YYYY') and a.year = to_char(s.period_end,'YYYY') then s.period_end - (trunc(to_date(a.year,'YYYY'),'YEAR')-1)
else null end * average_daily_sales as total_amount
from (
select level as year from dual where level >= (select to_char(min(period_start),'YYYY') from (select period_start from sales union all select period_end from sales)) connect by level <= (select to_char(max(period_start),'YYYY') from (select period_start from sales union all select period_end from sales))
)a left join sales s on a.year between to_char(s.period_start,'YYYY') and to_char(s.period_end,'YYYY')
join product p on p.product_id = s.product_id
order by p.product_id,report_year;


-- #1412 - Find the Quiet Student in All Exam - A “quite” student is the one who took at least one exam and didn’t score neither the high score nor the low score
with student as (
select 1 as student_id, 'Daniel' as student_name from dual union all
select 2 as student_id, 'Jade' as student_name from dual union all
select 3 as student_id, 'Stella' as student_name from dual union all
select 4 as student_id, 'Jonathan' as student_name from dual union all
select 5 as student_id, 'Will' as student_name from dual
),
exam as (
select 10 as exam_id, 1 as student_id, 70 as score from dual union all
select 10 as exam_id, 2 as student_id, 80 as score from dual union all
select 10 as exam_id, 3 as student_id, 90 as score from dual union all
select 20 as exam_id, 1 as student_id, 80 as score from dual union all
select 30 as exam_id, 1 as student_id, 70 as score from dual union all
select 30 as exam_id, 3 as student_id, 80 as score from dual union all
select 30 as exam_id, 4 as student_id, 90 as score from dual union all
select 40 as exam_id, 1 as student_id, 60 as score from dual union all
select 40 as exam_id, 2 as student_id, 70 as score from dual union all
select 40 as exam_id, 4 as student_id, 80 as score from dual
)
select student_id, student_name from student where student_id in (select distinct student_id from exam) 
and student_id not in (select student_id from (select student_id, dense_rank() over (order by score) minRank, dense_rank() over (order by score desc) maxRank from exam) where minRank = 1 or maxRank = 1);


-- #1479 - Sales by day of the week
with orders as (
select 1 as order_id, 1 as company_id, to_date('2020-06-01','YYYY-MM-DD') as order_date, 1 as item_id, 10 as quantity from dual union all
select 2 as order_id, 1 as company_id, to_date('2020-06-08','YYYY-MM-DD') as order_date, 2 as item_id, 10 as quantity from dual union all
select 3 as order_id, 2 as company_id, to_date('2020-06-02','YYYY-MM-DD') as order_date, 1 as item_id, 5 as quantity from dual union all
select 4 as order_id, 3 as company_id, to_date('2020-06-03','YYYY-MM-DD') as order_date, 3 as item_id, 5 as quantity from dual union all
select 5 as order_id, 4 as company_id, to_date('2020-06-04','YYYY-MM-DD') as order_date, 4 as item_id, 1 as quantity from dual union all
select 6 as order_id, 4 as company_id, to_date('2020-06-05','YYYY-MM-DD') as order_date, 5 as item_id, 5 as quantity from dual union all
select 7 as order_id, 5 as company_id, to_date('2020-06-05','YYYY-MM-DD') as order_date, 1 as item_id, 10 as quantity from dual union all
select 8 as order_id, 5 as company_id, to_date('2020-06-14','YYYY-MM-DD') as order_date, 4 as item_id, 5 as quantity from dual union all
select 9 as order_id, 5 as company_id, to_date('2020-06-21','YYYY-MM-DD') as order_date, 3 as item_id, 5 as quantity from dual
),
items as (
select 1 as item_id, 'LC Alg. Book' as item_name, 'Book' as category from dual union all
select 2 as item_id, 'LC DB. Book' as item_name, 'Book' as category from dual union all
select 3 as item_id, 'LC SmarthPhone' as item_name, 'Phone' as category from dual union all
select 4 as item_id, 'LC Phone 2020' as item_name, 'Phone' as category from dual union all
select 5 as item_id, 'LC SmartGlass' as item_name, 'Glasses' as category from dual union all
select 6 as item_id, 'LC T-Shirt XL' as item_name, 'T-Shirt' as category from dual
)
select category, nvl(monday,0) as monday, nvl(tuesday,0) as tuesday, nvl(wednesday,0) as wednesday, nvl(thursday,0) as thursday, nvl(friday,0) as friday, nvl(saturday,0) as saturday, nvl(sunday,0) as sunday
from (
select i.category, o.quantity, trim(to_char(o.order_date,'DAY')) as weekDay 
from orders o right join items i on o.item_id = i.item_id)
pivot (sum(quantity) for weekDay in ('MONDAY' as Monday,'TUESDAY' as Tuesday,'WEDNESDAY' as Wednesday,'THURSDAY' as Thursday,'FRIDAY' as Friday,'SATURDAY' as Saturday,'SUNDAY' as Sunday))
order by category;


-- #1635 - Hopper Company Queries I - Report the following statistics for each month of 2020
-- The number of drivers currently with the Hopper company by the end of the month (active_drivers)
-- The number of accepted rides in that month (accepted_rides)
with drivers as (
select 10 as driver_id, to_date('2019-12-10','YYYY-MM-DD') as join_date from dual union all
select 8 as driver_id, to_date('2020-01-13','YYYY-MM-DD') as join_date from dual union all
select 5 as driver_id, to_date('2020-02-16','YYYY-MM-DD') as join_date from dual union all
select 7 as driver_id, to_date('2020-03-08','YYYY-MM-DD') as join_date from dual union all
select 4 as driver_id, to_date('2020-05-17','YYYY-MM-DD') as join_date from dual union all
select 1 as driver_id, to_date('2020-10-24','YYYY-MM-DD') as join_date from dual union all
select 6 as driver_id, to_date('2021-01-05','YYYY-MM-DD') as join_date from dual
),
rides as (
select 6 as ride_id, 75 as user_id, to_date('2019-12-09','YYYY-MM-DD') as requested_at from dual union all
select 1 as ride_id, 54 as user_id, to_date('2020-02-09','YYYY-MM-DD') as requested_at from dual union all
select 10 as ride_id, 63 as user_id, to_date('2020-03-04','YYYY-MM-DD') as requested_at from dual union all
select 19 as ride_id, 39 as user_id, to_date('2020-04-06','YYYY-MM-DD') as requested_at from dual union all
select 3 as ride_id, 41 as user_id, to_date('2020-06-03','YYYY-MM-DD') as requested_at from dual union all
select 13 as ride_id, 52 as user_id, to_date('2020-06-22','YYYY-MM-DD') as requested_at from dual union all
select 7 as ride_id, 69 as user_id, to_date('2020-07-16','YYYY-MM-DD') as requested_at from dual union all
select 17 as ride_id, 70 as user_id, to_date('2020-08-25','YYYY-MM-DD') as requested_at from dual union all
select 20 as ride_id, 81 as user_id, to_date('2020-11-02','YYYY-MM-DD') as requested_at from dual union all
select 5 as ride_id, 57 as user_id, to_date('2020-11-09','YYYY-MM-DD') as requested_at from dual union all
select 2 as ride_id, 42 as user_id, to_date('2020-12-09','YYYY-MM-DD') as requested_at from dual union all
select 11 as ride_id, 68 as user_id, to_date('2021-01-11','YYYY-MM-DD') as requested_at from dual union all
select 15 as ride_id, 32 as user_id, to_date('2021-01-17','YYYY-MM-DD') as requested_at from dual union all
select 12 as ride_id, 11 as user_id, to_date('2021-01-19','YYYY-MM-DD') as requested_at from dual union all
select 14 as ride_id, 18 as user_id, to_date('2021-01-27','YYYY-MM-DD') as requested_at from dual
),
acceptedrides as (
select 10 as rider_id, 10 as driver_id, 63 as ride_distance, 38 as ride_duration from dual union all
select 13 as rider_id, 10 as driver_id, 73 as ride_distance, 96 as ride_duration from dual union all
select 7 as rider_id, 8 as driver_id, 100 as ride_distance, 28 as ride_duration from dual union all
select 17 as rider_id, 7 as driver_id, 119 as ride_distance, 68 as ride_duration from dual union all
select 20 as rider_id, 1 as driver_id, 121 as ride_distance, 92 as ride_duration from dual union all
select 5 as rider_id, 7 as driver_id, 42 as ride_distance, 101 as ride_duration from dual union all
select 2 as rider_id, 4 as driver_id, 6 as ride_distance, 38 as ride_duration from dual union all
select 11 as rider_id, 8 as driver_id, 37 as ride_distance, 43 as ride_duration from dual union all
select 15 as rider_id, 8 as driver_id, 108 as ride_distance, 82 as ride_duration from dual union all
select 12 as rider_id, 8 as driver_id, 38 as ride_distance, 34 as ride_duration from dual union all
select 14 as rider_id, 1 as driver_id, 90 as ride_distance, 74 as ride_duration from dual
)
select to_number(trim(leading 0 from to_char(month,'MM'))) as month, count(distinct d.driver_id) as active_drivers, sum(case when to_char(month,'YYYY-MM') = to_char(requested_at,'YYYY-MM') then 1 else 0 end) as accepted_rides
from (select add_months(to_date('2019-12-31'),level) as month from dual connect by level <= 12) a
left join drivers d on d.join_date <= a.month
left join acceptedrides ar on ar.driver_id = d.driver_id
left join rides r on r.ride_id = ar.rider_id and r.requested_at between to_date('2020-01-01','YYYY-MM-DD') and to_date('2020-12-31','YYYY-MM-DD')
group by to_char(month,'MM') 
order by month;


-- #1645 - Hopper Company Queries II - Report the percentage of working drivers (working_percentage) for each month of 2020 where
-- percentage_month = (# drivers that accepted at least one ride during the month) / (# available drivers during the month) * 100
with drivers as (
select 10 as driver_id, to_date('2019-12-10','YYYY-MM-DD') as join_date from dual union all
select 8 as driver_id, to_date('2020-01-13','YYYY-MM-DD') as join_date from dual union all
select 5 as driver_id, to_date('2020-02-16','YYYY-MM-DD') as join_date from dual union all
select 7 as driver_id, to_date('2020-03-08','YYYY-MM-DD') as join_date from dual union all
select 4 as driver_id, to_date('2020-05-17','YYYY-MM-DD') as join_date from dual union all
select 1 as driver_id, to_date('2020-10-24','YYYY-MM-DD') as join_date from dual union all
select 6 as driver_id, to_date('2021-01-05','YYYY-MM-DD') as join_date from dual
),
rides as (
select 6 as ride_id, 75 as user_id, to_date('2019-12-09','YYYY-MM-DD') as requested_at from dual union all
select 1 as ride_id, 54 as user_id, to_date('2020-02-09','YYYY-MM-DD') as requested_at from dual union all
select 10 as ride_id, 63 as user_id, to_date('2020-03-04','YYYY-MM-DD') as requested_at from dual union all
select 19 as ride_id, 39 as user_id, to_date('2020-04-06','YYYY-MM-DD') as requested_at from dual union all
select 3 as ride_id, 41 as user_id, to_date('2020-06-03','YYYY-MM-DD') as requested_at from dual union all
select 13 as ride_id, 52 as user_id, to_date('2020-06-22','YYYY-MM-DD') as requested_at from dual union all
select 7 as ride_id, 69 as user_id, to_date('2020-07-16','YYYY-MM-DD') as requested_at from dual union all
select 17 as ride_id, 70 as user_id, to_date('2020-08-25','YYYY-MM-DD') as requested_at from dual union all
select 20 as ride_id, 81 as user_id, to_date('2020-11-02','YYYY-MM-DD') as requested_at from dual union all
select 5 as ride_id, 57 as user_id, to_date('2020-11-09','YYYY-MM-DD') as requested_at from dual union all
select 2 as ride_id, 42 as user_id, to_date('2020-12-09','YYYY-MM-DD') as requested_at from dual union all
select 11 as ride_id, 68 as user_id, to_date('2021-01-11','YYYY-MM-DD') as requested_at from dual union all
select 15 as ride_id, 32 as user_id, to_date('2021-01-17','YYYY-MM-DD') as requested_at from dual union all
select 12 as ride_id, 11 as user_id, to_date('2021-01-19','YYYY-MM-DD') as requested_at from dual union all
select 14 as ride_id, 18 as user_id, to_date('2021-01-27','YYYY-MM-DD') as requested_at from dual
),
acceptedrides as (
select 10 as rider_id, 10 as driver_id, 63 as ride_distance, 38 as ride_duration from dual union all
select 13 as rider_id, 10 as driver_id, 73 as ride_distance, 96 as ride_duration from dual union all
select 7 as rider_id, 8 as driver_id, 100 as ride_distance, 28 as ride_duration from dual union all
select 17 as rider_id, 7 as driver_id, 119 as ride_distance, 68 as ride_duration from dual union all
select 20 as rider_id, 1 as driver_id, 121 as ride_distance, 92 as ride_duration from dual union all
select 5 as rider_id, 7 as driver_id, 42 as ride_distance, 101 as ride_duration from dual union all
select 2 as rider_id, 4 as driver_id, 6 as ride_distance, 38 as ride_duration from dual union all
select 11 as rider_id, 8 as driver_id, 37 as ride_distance, 43 as ride_duration from dual union all
select 15 as rider_id, 8 as driver_id, 108 as ride_distance, 82 as ride_duration from dual union all
select 12 as rider_id, 8 as driver_id, 38 as ride_distance, 34 as ride_duration from dual union all
select 14 as rider_id, 1 as driver_id, 90 as ride_distance, 74 as ride_duration from dual
)
select to_number(trim(leading 0 from to_char(month,'MM'))) as month, round((sum(case when to_char(month,'YYYY-MM') = to_char(requested_at,'YYYY-MM') then 1 else 0 end) / count(distinct d.driver_id))*100,2) as working_percentage
from (select add_months('2019-12-31',level) as month from dual connect by level <= 12) a left join drivers d on d.join_date < a.month
left join acceptedrides ar on ar.driver_id = d.driver_id
left join rides r on r.ride_id = ar.rider_id and r.requested_at between to_date('2020-01-01','YYYY-MM-DD') and to_date('2020-12-31','YYYY-MM-DD')
group by to_char(month,'MM')
order by month;


-- #1651 - Hopper Company Queries III - Compute the average_ride_distance and average_ride_duration of every 3-month window starting from January - March 2020 to October - December 2020
with drivers as (
select 10 as driver_id, to_date('2019-12-10','YYYY-MM-DD') as join_date from dual union all
select 8 as driver_id, to_date('2020-01-13','YYYY-MM-DD') as join_date from dual union all
select 5 as driver_id, to_date('2020-02-16','YYYY-MM-DD') as join_date from dual union all
select 7 as driver_id, to_date('2020-03-08','YYYY-MM-DD') as join_date from dual union all
select 4 as driver_id, to_date('2020-05-17','YYYY-MM-DD') as join_date from dual union all
select 1 as driver_id, to_date('2020-10-24','YYYY-MM-DD') as join_date from dual union all
select 6 as driver_id, to_date('2021-01-05','YYYY-MM-DD') as join_date from dual
),
rides as (
select 6 as ride_id, 75 as user_id, to_date('2019-12-09','YYYY-MM-DD') as requested_at from dual union all
select 1 as ride_id, 54 as user_id, to_date('2020-02-09','YYYY-MM-DD') as requested_at from dual union all
select 10 as ride_id, 63 as user_id, to_date('2020-03-04','YYYY-MM-DD') as requested_at from dual union all
select 19 as ride_id, 39 as user_id, to_date('2020-04-06','YYYY-MM-DD') as requested_at from dual union all
select 3 as ride_id, 41 as user_id, to_date('2020-06-03','YYYY-MM-DD') as requested_at from dual union all
select 13 as ride_id, 52 as user_id, to_date('2020-06-22','YYYY-MM-DD') as requested_at from dual union all
select 7 as ride_id, 69 as user_id, to_date('2020-07-16','YYYY-MM-DD') as requested_at from dual union all
select 17 as ride_id, 70 as user_id, to_date('2020-08-25','YYYY-MM-DD') as requested_at from dual union all
select 20 as ride_id, 81 as user_id, to_date('2020-11-02','YYYY-MM-DD') as requested_at from dual union all
select 5 as ride_id, 57 as user_id, to_date('2020-11-09','YYYY-MM-DD') as requested_at from dual union all
select 2 as ride_id, 42 as user_id, to_date('2020-12-09','YYYY-MM-DD') as requested_at from dual union all
select 11 as ride_id, 68 as user_id, to_date('2021-01-11','YYYY-MM-DD') as requested_at from dual union all
select 15 as ride_id, 32 as user_id, to_date('2021-01-17','YYYY-MM-DD') as requested_at from dual union all
select 12 as ride_id, 11 as user_id, to_date('2021-01-19','YYYY-MM-DD') as requested_at from dual union all
select 14 as ride_id, 18 as user_id, to_date('2021-01-27','YYYY-MM-DD') as requested_at from dual
),
acceptedrides as (
select 10 as rider_id, 10 as driver_id, 63 as ride_distance, 38 as ride_duration from dual union all
select 13 as rider_id, 10 as driver_id, 73 as ride_distance, 96 as ride_duration from dual union all
select 7 as rider_id, 8 as driver_id, 100 as ride_distance, 28 as ride_duration from dual union all
select 17 as rider_id, 7 as driver_id, 119 as ride_distance, 68 as ride_duration from dual union all
select 20 as rider_id, 1 as driver_id, 121 as ride_distance, 92 as ride_duration from dual union all
select 5 as rider_id, 7 as driver_id, 42 as ride_distance, 101 as ride_duration from dual union all
select 2 as rider_id, 4 as driver_id, 6 as ride_distance, 38 as ride_duration from dual union all
select 11 as rider_id, 8 as driver_id, 37 as ride_distance, 43 as ride_duration from dual union all
select 15 as rider_id, 8 as driver_id, 108 as ride_distance, 82 as ride_duration from dual union all
select 12 as rider_id, 8 as driver_id, 38 as ride_distance, 34 as ride_duration from dual union all
select 14 as rider_id, 1 as driver_id, 90 as ride_distance, 74 as ride_duration from dual
)
select to_number(trim(leading 0 from to_char(month,'MM'))) as month, round(sum(case when r.requested_at <= add_months(a.month,2) and r.requested_at >= trunc(a.month,'month') then ar.ride_distance else 0 end)/3,2) as average_ride_distance
from (select add_months('2019-12-31',level) as month from dual connect by level <= 12) a left join drivers d on d.join_date < a.month
left join acceptedrides ar on ar.driver_id = d.driver_id
left join rides r on r.ride_id = ar.rider_id and r.requested_at between to_date('2020-01-01','YYYY-MM-DD') and to_date('2020-12-31','YYYY-MM-DD')
where a.month < to_date('2020-11-01','YYYY-MM-DD')
group by a.month
order by a.month;


-- #1767 - Find the subtask that did not execute - Report the IDs of the missing subtasks for each task_id
with tasks as (
select 1 as task_id, 3 as subtasks_count from dual union all
select 2 as task_id, 2 as subtasks_count from dual union all
select 3 as task_id, 4 as subtasks_count from dual
),
executed as (
select 1 as task_id, 2 as subtask_id from dual union all
select 3 as task_id, 1 as subtask_id from dual union all
select 3 as task_id, 2 as subtask_id from dual union all
select 3 as task_id, 3 as subtask_id from dual union all
select 3 as task_id, 4 as subtask_id from dual
)
select a.task_id, a.seq as subtask_id
from (select distinct task_id, subtasks_count, level as seq from tasks connect by level <= subtasks_count) a left join executed b on a.task_id = b.task_id and a.seq = b.subtask_id
where b.task_id is null
order by a.task_id, a.seq;


-- #1892 - Page Recommendations II
with friendship as (
select 1 as user1_id, 2 as user2_id from dual union all
select 1 as user1_id, 3 as user2_id from dual union all
select 1 as user1_id, 4 as user2_id from dual union all
select 2 as user1_id, 3 as user2_id from dual union all
select 2 as user1_id, 4 as user2_id from dual union all
select 2 as user1_id, 5 as user2_id from dual union all
select 6 as user1_id, 1 as user2_id from dual
),
likes as (
select 1 as user_id, 88 as page_id from dual union all
select 2 as user_id, 23 as page_id from dual union all
select 3 as user_id, 24 as page_id from dual union all
select 4 as user_id, 56 as page_id from dual union all
select 5 as user_id, 11 as page_id from dual union all
select 6 as user_id, 33 as page_id from dual union all
select 2 as user_id, 77 as page_id from dual union all
select 3 as user_id, 77 as page_id from dual union all
select 6 as user_id, 88 as page_id from dual
)
select a.user1_id, l.page_id, count(distinct a.user2_id) as friends_likes
from (select user1_id as user1_id, user2_id as user2_id from friendship union all select user2_id as user1_id, user1_id as user2_id from friendship) a
left join likes l on a.user2_id = l.user_id 
where l.page_id not in (select page_id from likes where user_id = a.user1_id)
group by a.user1_id, l.page_id
order by user1_id, friends_likes desc, page_id;


-- #1917 - Leetcodify Friends Recommendations



-- #1919 - Leetcodify Similar Friends
-- #1972 - First and Last Call on the Same Day
-- #2004 - The Number of Seniors and Juniors to Join the Company
-- #2010 - The Number of Seniors and Juniors to Join the Company II
-- #2118 - Build the Equation
-- #2153 - The number of passangers in each Bus II
-- #2173 - Longest Winning Streak
-- #2199 - Find the topic of each post
-- #2252 - Dynamic Pivoting of a Table
-- #2253 - Dynamic UnPivotinf of a Table

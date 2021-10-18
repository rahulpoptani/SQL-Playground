select * from dept;

select * from emp;

-- left join => all rows from left table whether match found or not

-- right join => all rows of right table whether match found or not

-- full join => MYSQL does not support. To enumurate take union of left and right join

-- cross join without ON => cartesian product of two tables with m and n rows result in mxn rows (all possible combination)

-- cross join with ON => Same as Inner Join

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------
-- References: https://www.w3schools.com/sql/default.asp

-- add dates
select hiredate, adddate(hiredate, interval 1 day) as future_date, adddate(hiredate, interval -1 day) as past_date from emp limit 1;
-- subtract dates
select hiredate, date_sub(hiredate, interval 1 day) as previous_date from emp limit 1;


-- date and time
select current_date();
select current_time();
select current_timestamp();

-- extract date
select date(hiredate) from emp;

-- date difference
select datediff(hiredate+1, hiredate) from emp;

-- date format
with t as (select '2021-04-11 14:20:30' as time)
select 
time, 
date_format(time, '%Y') as year, 
date_format(time, '%m') as month, 
date_format(time, '%d') as day, 
date_format(time, '%a') as weekday, 
date_format(time, '%H') as hour, 
date_format(time, '%i') as minutes,
date_format(time, '%U') as week
from t;

-- Extract Year/Month/Day
with t as (select now() as time)
select 
time, 
year(time) as year, 
month(time) as month, 
day(time) as day,
week(time) as week,
yearweek(time) as yearweek,
weekday(time) as weekday,
minute(time) as minute,
quarter(time) as quarter,
second(time) as second
from t;

-- other date functions
with t as (select now() as time)
select 
time, 
dayname(time) as dayname,
dayofmonth(time) as dayofmonth,
dayofweek(time) as dayofweek,
dayofyear(time) as dayofyear,
extract(year from time) as year,
extract(second from time) as second,
extract(week from time) as week,
extract(quarter from time) as quarter,
extract(year_month from time) as yearmonth,
last_day(time) as lastdayofmonth,
str_to_date('2021-01-01','%Y-%m-%d') as string_to_date
from t;

select now(), sysdate();

-- other functions

select cast("2021-01-01" as date) as cast_date;

select coalesce(null, null, 'first not null value', null, 'second not null value', null) as return_first_not_null;

select current_user();

select database();

select if(10<20, 'yes', 'false') as if_cond;

select ifnull(null, 'fallback') as if_null_then;

select isnull(null) as return_one_if_null;

select nullif(20, 20) as return_null_if_equal;

select session_user();


















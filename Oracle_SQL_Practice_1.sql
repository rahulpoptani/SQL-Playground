
-- Split into quartiles with NTILE

with rws as (
select dbms_random.value(0,100) as x from dual connect by level <= 1000
), 
grps as (
select x, ntile(4) over (order by x) as grp from rws
)
select grp, count(*) as row#, round(min(x), 1) lower_bound, round(max(x), 1) upper_bound
from grps
group by grp order by grp;

-- NTILE - Partition the data
select level, ntile(4) over (order by level) part from dual connect by level <= 20;

select dbms_random.string(1,5) as random_string from dual connect by level < 10;


-- Split comma sep values into rows

with value as (select 'split,into,rows' as csv from dual)
select csv, regexp_substr(csv, '[^,]+', 1, level)
from value connect by level <= length(csv) - length(replace(csv, ','))+1;


-- With leading and training comma
with value as (select ',split,into,rows,' as csv from dual)
select csv, regexp_substr(csv, '[^,]+', 1, level)
from value connect by level <= length(trim(both ',' from csv)) - length(replace(csv, ','))+1;


-- real example 
with filternames as (select 'King,Kochhar,De Haan' csv from dual) 
select employee_id, first_name, last_name 
from hr.employees 
-- where last_name in ('King','Kochhar','De Haan');
-- where last_name in ('King,Kochhar,De Haan');
where last_name in (
select regexp_substr(csv, '[^,]+', 1, level) from filternames connect by level <= length(csv) - length(replace(csv, ','))+1
);


-- Explain Plan
explain plan for
select * from emp e join dept d on e.deptno = d.deptno;
select * from table(dbms_xplan.display());


-- Where exists
select * from emp e where exists (select 1 from dept d where d.deptno = e.deptno);


-- REGEXP_SUBSTR
with strings as (
select 'ABC123' str from dual union all 
select 'A1B2C3' str from dual union all 
select '123ABC' str from dual union all 
select '1A2B3C' str from dual union all
select 'AB123AB123' str from dual 
) 
select
str,
regexp_substr(str, '[0-9]') as "[0-9]", -- Returns the first number
regexp_substr(str, '[0-9]+') as "[0-9]+", -- Returns the first sequence of numbers
regexp_substr(str, '[0-9].*') as "[0-9].*", -- Returns the first number and the rest of the string
regexp_substr(str, '[A-Z][0-9]') as "[A-Z][0-9]", -- Returns the first letter with a following number
regexp_substr(str, '[A-Z]+[0-9]+') as "[A-Z]+[0-9]+" -- Returns the first letter, first number sequence
from strings;


with strings as ( 
select 'LHRJFK/010315/SAXONMR' str from dual union all 
select 'CDGLAX/050515/SMITHMRS' str from dual union all 
select 'LAXCDG/220515/SMITHMRS' str from dual union all 
select 'SFOJFK/010615/JONESMISS' str from dual 
) 
select 
str,
regexp_substr(str, '[A-Z]{6}') as "[A-Z]{6}", -- Returns the first string of 6 characters
regexp_substr(str, '[0-9]+') as "[0-9]+", -- Returns the first matching numbers
regexp_substr(str, '[A-Z].*$') as "[A-Z].*$", -- Returns the first letter followed by all other characters
regexp_substr(str, '[0-9].*$') as "[0-9].*$", -- Returns the first number followed by all other characters
regexp_substr(str, '/[A-Z].*$') as "/[A-Z].*$", -- Returns / followed by a letter then all other characters 
regexp_substr(str, '/[0-9].*$') as "/[0-9].*$", -- Returns / followed by a number then all other characters 
regexp_substr(str, '/[0-9]+/') as "/[0-9]+" -- Returns / followed by a numbers then /
from strings;


with emails as (
select 'example@company.com' str from dual union all
select '12345@company.com' str from dual union all
select 'example_123@company.com' str from dual union all
select 'example-123@company.com' str from dual union all
select 'example.123@company.com' str from dual union all
select '123.example@company.com' str from dual union all
select '123-example@company.com' str from dual union all
select '123_example@company.com' str from dual union all
select '1exa2mple@company.com' str from dual union all
select 'exa12mple@company.com' str from dual union all
select 'example' str from dual
)
select 
str,
regexp_substr(str, '[[:alnum:]]+\@[[:alnum:]]+\.[[:alnum:]]+') as "valid_email"
from emails;


-- All characters in new line
with line as (select 'Jack Sparrow' str from dual)
select substr(str, level, 1) as "char" from line connect by level <= length(str);


select
phone_number,
regexp_replace(phone_number, '([[:digit:]]{3})\.([[:digit:]]{3})\.([[:digit:]]{4})', '(\1) \2-\3') as "regexp_replace"
from hr.employees;


-- REGEXP_REPLACE
select regexp_replace('This is great', '^(\S*)', 'That') from dual; -- start the match at the beginning of the string as specified by ^ and then find the first word as specified by (\S*)

SELECT REGEXP_REPLACE ('2, 5, and 10 are numbers in this example', '\d', '#') FROM dual; --  replace all numeric digits in the string as specified by \d

SELECT REGEXP_REPLACE ('2, 5, and 10 are numbers in this example', '(\d)(\d)', '#') FROM dual; -- replace a number that has two digits side-by-side as specified by (\d)(\d)

SELECT REGEXP_REPLACE ('Anderson', 'a|e|i|o|u', 'G') FROM dual;
SELECT REGEXP_REPLACE ('Anderson', 'a|e|i|o|u', 'G', 1, 0, 'i') FROM dual;


-- REGEXP_LIKE
with dates as (   
select '2015-01-01' as dt from dual union all /* Valid date 1 Jan 2015 */   
select '2015-99-99' as dt from dual union all /* Invalid day and month 99 */   
select '01-01-2015' as dt from dual union all /* In DD-MM-YYYY format */   
select '2015-12-31' as dt from dual union all /* Valid date 31 Dec 2015 */   
select '2015-12-39' as dt from dual union all /* Invalid date 39 Dec 2015 */   
select '2015-31-12' as dt from dual /* Day and month in a wrong way */   
)   
select * from dates   
--where  regexp_like (dt, '[0-9]{4}-[0-9]{2}-[0-9]{2}'); -- validate only format
--where  regexp_like (dt, '[0-9]{4}-[0-1][0-9]-[0-3][0-9]'); -- further validate invalid date
where  regexp_like (dt, '[0-9]{4}-(0[0-9]|1[0-2])-([0-2][0-9]|3[0-1])'); -- Valid date


with xml as (   
select '<element>test<element>' as x from dual union all /* Incorrect closing tag '/' missing */  
select '<element>test</different_element>' as x from dual union all /* Different opening and closing tags */  
select '<element>test</element>' as x from dual /* Valid open and close tags*/  
)   
select * from xml   
--where  regexp_like (x, '<.*>.*</.*>');
where  regexp_like (x, '<(.*)>.*</(\1)>');


-- REGEXP_COUNT
select regexp_count('ABC123', '[A-Z]'), /* This matches "A", "B" & "C" so returns 3 */ 
       regexp_count('A1B2C3DD', '[A-Z]')  /* This matches "A", "B", "C" & "D" so returns 5 */ 
from dual;

select regexp_count('ABC123', '^[A-Z][0-9]') /* This has no match so returns 0 */, 
       regexp_count('A1B2C3', '^[A-Z][0-9]') /* This matches "A1" so returns 1 */ 
from dual;

select regexp_count('ABC123', '[A-Z][0-9]{2}'), /* This matches "C12" so returns 1 */ 
       regexp_count('A1B2C3', '[A-Z][0-9]{2}') /* This has no match so returns 0 */ 
from dual;

select regexp_count('ABC123', '([A-Z][0-9]){2}'), /* This has no match so returns 0 */ 
       regexp_count('A1B2C3', '([A-Z][0-9]){2}') /* This matches "A1B2" so returns 1 */ 
from dual;


with regexp_temp as (
select 'John Doe' as empName from dual union all
select 'Jane Doe' as empName from dual 
)
--SELECT empName, REGEXP_COUNT(empName, 'e', 1, 'c') "CASE_SENSITIVE_E" From regexp_temp;
--SELECT empName, REGEXP_COUNT(empName, 'o', 1, 'c') "CASE_SENSITIVE_O" From regexp_temp;
SELECT empName, REGEXP_COUNT(empName, 'do', 1, 'i') "CASE_INSENSITIVE_STRING" From regexp_temp;

select regexp_count('ABC123', '[A-Z]') Match_char_ABC_count,  
       regexp_count('A1B2C3', '[A-Z]') Match_char_ABC_count  
from dual;

select regexp_count('ABC123', '[A-Z][0-9]') Match_string_C1_count,  
       regexp_count('A1B2C3', '[A-Z][0-9]')  Match_strings_A1_B2_C3_count  
from dual;

select regexp_count('ABC123A5', '^[A-Z][0-9]') Char_num_like_A1_at_start,  
       regexp_count('A1B2C3', '^[A-Z][0-9]') Char_num_like_A1_at_start  
from dual;

select regexp_count('ABC123', '[A-Z][0-9]{2}') Char_num_like_A12_anywhere,   
       regexp_count('A1B2C34', '[A-Z][0-9]{2}') Char_num_like_A12_anywhere 
from dual;


-- CONTAINS
with string as (select 'some text text' txt from dual)
select * from string where contains(txt, 'text') > 0;


-- MERGE Command
drop table catalog1;
drop table catalog2;
create table catalog1 (id number(3), item varchar2 (20), price number(6));
insert into catalog1 values(1, 'laptop', 800);
insert into catalog1 values(2, 'iphone', 500);
insert into catalog1 values(3, 'camera', 700);
create table catalog2 (id number(3), item varchar2 (20), price number(6));
insert into catalog2 values(1, 'laptop', 899);
insert into catalog2 values(2, 'iphone', 599);
insert into catalog2 values(5, 'video camera', 799);
select * from catalog1;
select * from catalog2;
merge into catalog1 c1 using catalog2 c2 on (c1.id = c2.id)
when matched then update set c1.price = c2.price
when not matched then insert (id, item, price) values (c2.id, c2.item, c2.price);
select * from catalog1;


-- LAG
select ename, sal, lag(sal,1,0) over(order by sal) from emp;


-- INLINE Views
select deptno, dname, loc, (select count(*) from emp e where e.deptno = d.deptno) as total_emp from dept d;


-- Hierarchical Queries
select empno, ename, mgr, level from emp
where level <= 3
start with ename = 'JONES'
connect by prior empno = mgr
order by level;

select concat(lpad(' ',level*3-3),ename) ename
from emp
connect by prior empno = mgr
start with mgr is null
order siblings by emp.ename;

select ename, level, connect_by_root ename as Manager, sys_connect_by_path(ename, '/') as path
from emp
start with mgr is null
connect by nocycle prior empno = mgr order by level;


-- ROLLUP
select 
deptno, sum(sal) 
from emp group by rollup(deptno);


-- Duplicate Delete
drop table dept_dup;
create table dept_dup as select * from dept union all select * from dept union all select * from dept;
select * from dept_dup;
delete from dept_dup where rowid not in (select max(rowid) from dept_dup group by deptno, dname, loc);

drop table dept_dup1;
create table dept_dup1 as 
select rownum id, d.* from (
select * from dept
union all
select * from dept
union all
select * from dept) d;
select * from dept_dup1;
delete from dept_dup1 where id not in (select min(id) from dept_dup1 group by deptno, dname, loc);



-- Date formatting
with dates as (
select to_date('2021-09-27 14:12:40', 'YYYY-MM-DD HH24:MI:SS') dt from dual
)
select dt,
trunc(dt) as "nearest_day_start",
trunc(dt, 'DD') as "nearest_day",
trunc(dt, 'HH24') as "nearest_hour",
trunc(dt, 'MI') as "nearest_minute",
trunc(dt, 'WW') as "nearest_week",
trunc(dt, 'MM') as "nearest_month",
trunc(dt, 'YYYY') as "nearest_year",
to_char(dt, 'DD') as "day_month",
to_char(dt, 'IW') as "week_year",
to_char(dt, 'IW-YYYY') as "iso_week_and_year",
to_char(dt, 'W') as "week_month",
dt + 1/24 as "add_1_hour",
add_months(dt, 1) as "add_1_month"
from dates;


-- CDC In Oracle
create table words (word_no integer, word varchar2(10));
insert into words (word_no, word) values (1, 'Hello');
insert into words (word_no, word) values (2, 'World');
create table log (change_date  date, word_num integer, old_word varchar2(10), new_word varchar2(10));
create or replace trigger log_change_to_word
after update on words 
for each row 
begin 
  insert into log (change_date, word_num, old_word, new_word) values (SYSDATE, :old.word_no, :old.word, :new.word);
end;
/
update words set word = 'Bonjour' where word_no = 1;
update words set word = 'Monde' where word_no = 2;
select * from log;
drop table log;


-- Department with MAX Salary
select deptno, sumsal from (
select deptno, sum(sal) sumsal from emp group by deptno order by sum(sal) desc)
where rownum = 1;


-- Print A,B,C..Z in new rows
select chr(level) chr from dual
where level >= ascii('A') and level <= ascii('Z')
connect by level <= 100;

With blist (num, character) as 
(select level, chr(level+ascii('A')-1)  from dual  CONNECT BY LEVEL<= ascii('Z')-ascii('A')+1) 
select * from blist;


-- Compare two tables
with one as (
select 1 as ID, 'One' as str from dual union all
select 2 as ID, 'Two' as str from dual
), two as (
select 1 as ID, 'One' as str from dual union all
select 2 as ID, 'Three' as str from dual
)
select * from one
minus
select * from two
union all
select * from two
minus
select * from one
;



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
select * from transactions order  by trans_date, trans_id;
select t.*, 
case when trans_type = 'CREDIT' 
then last_value(case when trans_type <> 'CREDIT' then trans_id end) ignore nulls over (order by trans_date, trans_id)
else
last_value(case when trans_type <> 'DEBIT' then trans_id end) ignore nulls over (order by trans_date, trans_id)
end prev_trans_id
from transactions t order by trans_date, trans_id;



-- Windowing
select ename, sal, sum(sal) over (order by sal rows between unbounded preceding and current row) cumsal from emp;


-- LISTAGG
select deptno, listagg(ename, ',') within group (order by deptno) emp_names from emp group by deptno;


-- LAST_VALUE
select ename, deptno, last_value(ename) over (order by deptno) last_person from emp;


-- PIVOT
with t as (select deptno, sal from emp)
select * from t pivot (sum(sal) for deptno in (10,20,30,40));

with t as (select d.loc, e.job, e.sal from emp e join dept d on e.deptno = d.deptno)
select * from t pivot (sum(sal) for job in ('PRESIDENT' as PRESIDENT, 'MANAGER' as MANAGER, 'CLERK' as CLERK, 'ANALYST' as ANALYST));


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
select request_at Day, round(sum(case when status <> 'completed' then 1 else 0 end)/count(*),2) "Cancellation Rate"
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
select id as "id", to_char(visit_date, 'YYYY-MM-DD') as "visit_date", people as "people" from (
select distinct s1.id, s1.visit_date, s1.people from
stadium s1 cross join stadium s2 cross join stadium s3
where 
s1.people >= 100 and s2.people >= 100 and s3.people >= 100
and 
(
(s1.id = s2.id-1 and s1.id = s3.id-2) or (s1.id = s2.id+1 and s1.id = s3.id+2) or (s1.id = s2.id-1 and s1.id = s3.id+1)
)
order by s1.visit_date);

--select min(dt) start_dt, max(dt) as end_dt from 
--(
--    select dt, max(local) over (order by dt) as newlocal from 
--    (
--        select dt, case when nvl(lag(dt) over (order by dt), dt) != dt-1 then dt end local from dates
--    ) 
--) group by newlocal order by 1;

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
select csv, regexp_substr(csv, '[^,]+', 1, level) as word
from value connect by level <= (length(csv) - length(replace(csv, ','))) + 1;


-- With leading and training comma
with value as (select ',split,into,rows,' as csv from dual)
select csv, regexp_substr(csv, '[^,]+', 1, level)
from value connect by level <= length(trim(both ',' from csv)) - length(replace(csv, ','))+1;


-- real example 
with filternames as (select 'King,Kochhar,De Haan' csv from dual) 
select employee_id, first_name, last_name 
from hr.employees 
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

SELECT regexp_replace ('2, 5, and 10 are numbers in this example', '\d+', '#') FROM dual; --  replace all numeric digits in the string as specified by \d

SELECT regexp_replace ('2, 5, and 10 are numbers in this example', '(\d)(\d)', '#') FROM dual; -- replace a number that has two digits side-by-side as specified by (\d)(\d)

SELECT regexp_replace ('Anderson', 'a|e|i|o|u', 'G') FROM dual;
SELECT regexp_replace ('Anderson', 'a|e|i|o|u', 'G', 1, 0, 'i') FROM dual;


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
where  regexp_like (dt, '[0-9]{4}-(0[0-9]|1[0-2])-([0-2][0-9]|3[0-1])') -- Valid date
--


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
	select sysdate dt from dual
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

update words set word = 'Bonjour' where word_no = 1;
update words set word = 'Monde' where word_no = 2;
select * from log;
drop table log;



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

-- hierarchical functions

-- get hierarchical of each employee 
select empno, ename, mgr, level 
from emp start with mgr is null connect by prior empno = mgr;

-- people who are 4th level managers
with data as (
	select empno, ename, mgr, level as hierarchy 
	from emp start with mgr is null connect by prior empno = mgr
)
select * from data where hierarchy = 4;

select e1.empno, e1.ename, e2.empno, e2.ename, e3.empno, e3.ename, e4.empno, e4.ename
from emp e1 join emp e2 on e1.mgr = e2.empno
join emp e3 on e2.mgr = e3.empno
join emp e4 on e3.mgr = e4.empno;

-- sys_connect_by_path
select empno, ename, sys_connect_by_path(ename, '/') as hierarchy 
from emp start with mgr is null connect by prior empno = mgr;

select empno, ename, sys_connect_by_path(ename, '->') as hierarchy 
from emp start with empno = 7566 connect by prior empno = mgr;

-- connect_by_isleaf
select empno, ename, connect_by_isleaf as isleaf
from emp start with mgr is null connect by prior empno = mgr;

-- people who are not manager
with data as (
	select empno, ename, connect_by_isleaf as isleaf 
	from emp start with mgr is null connect by prior empno = mgr
)
select * from data where isleaf = 1;

-- connect_by_root
select empno, ename, connect_by_root ename as root
from emp start with mgr is null connect by prior empno = mgr;

-- order siblings by - This ensures that within the same level, employees are sorted alphabetically.
select empno, ename, level
from emp start with mgr is null connect by prior empno = mgr
order siblings by ename;

-- Lowest Common Ancestor (LCA) of two nodes
with data as (
	select empno, ename, sys_connect_by_path(ename, '/') as hierarchy, sys_connect_by_path(level, '/') as hierarchy_level
	from emp start with mgr is null connect by prior empno = mgr
)
select d.*, regexp_substr(d.hierarchy, '[^/]', 1, level) as ll
from data d where empno in (7876, 7369)
connect by level <= (length(hierarchy_level) - length(replace(hierarchy_level, '/', ''))) + 1;
-- Adams 7876 and Smith 7369 = LCA Jones 7566

-- pretty formatted hierarchical tree
select lpad(' ', level*4) || ename as name from emp
start with mgr is null connect by prior empno = mgr;

-- rank employee based on hierarchical depth
select empno, ename, level, dense_rank() over (order by level desc) as rn
from emp start with mgr is null connect by prior empno = mgr;



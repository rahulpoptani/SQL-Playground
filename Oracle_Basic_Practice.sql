-- Department with MAX Salary
select deptno, sumsal from (
select deptno, sum(sal) sumsal from emp group by deptno order by sum(sal) desc)
where rownum = 1;

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
select * from one;


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


-- list of employees with same salary
select a.empno, a.ename, a.job, a.sal
from emp a join emp b on a.sal = b.sal and a.empno <> b.empno;



-- new customers each day
with purchase as
(
    select 1 as cust_id, '2021-01-01' as purchase_date, 'AX1221' as product_id from dual union all
    select 2 as cust_id, '2021-01-01' as purchase_date, 'AX9843' as product_id from dual union all
    select 1 as cust_id, '2021-01-02' as purchase_date, 'AX2312' as product_id from dual union all
    select 3 as cust_id, '2021-01-02' as purchase_date, 'AX2323' as product_id from dual union all
    select 3 as cust_id, '2021-01-03' as purchase_date, 'AX2312' as product_id from dual union all
    select 4 as cust_id, '2021-01-03' as purchase_date, 'AX2312' as product_id from dual union all
    select 1 as cust_id, '2021-01-04' as purchase_date, 'AX2312' as product_id from dual union all
    select 2 as cust_id, '2021-01-04' as purchase_date, 'AX2312' as product_id from dual
)
select purchase_date, sum(case when occurence = 1 then 1 else 0 end) as new_users 
from 
    ( 
    select cust_id, purchase_date, product_id, rank() over (partition by cust_id order by purchase_date) as occurence from purchase order by purchase_date 
    ) sub 
group by purchase_date;



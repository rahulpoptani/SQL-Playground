-- Get the 5th week highest number of sales. Using emp table to structure the query. We can change the column and table name to project as per requirement
select a.hireweek, a.sumsal from (
select d.hireweek, d.sumsal , dense_rank() over (order by d.sumsal) as "rr" 
from (
select date_format(hiredate, '%U') as hireweek, sum(sal) as sumsal from emp group by hireweek order by 2 desc
)d)a where a.rr = 5;

-- with rollup => Returns total sum/avg/.. at end
select d.dname, sum(e.sal) from emp e join dept d on e.deptno = d.deptno group by d.dname with rollup;

-- corelated subquery example
-- Give me employee name whose department has 3 employees
select ename, deptno from emp e where 3 = (select count(*) from emp e1 where e1.deptno = e.deptno);
select ename, deptno from emp where deptno = (select a.deptno from (select deptno, count(*) num from emp group by deptno having num = 3)a);

-- Distinct Column Count
select count(distinct deptno) from emp;

-- Rows starting with 'a'
select * from emp where ename like 'J%';

-- Rows have 'a' in any position
select * from emp where ename like '%a%';

-- Cross Join
select * from emp cross join dept;

-- Self Join => Employee Manager
select e1.ename as Employee, e2.ename as Manager from emp e1 join emp e2 on e1.mgr = e2.empno;

-- Where Exists
select ename from emp e where exists (select 1 from dept d where e.deptno = d.deptno);

-- ANY
select * from emp where deptno = any(select deptno from dept);

-- CTE (common table expression)
with t as (select now() as time) select time from t;

-- Natural Join - lazy - will take matching column name to join
select count(*) from emp as e natural join dept as d;

--  CASE with WHEN Exists
select 
case when exists (select 1 from dept d where d.deptno = e.deptno) then 'Yes' else 'No' end
from emp e;

-- unbounded preceding example (order by not mandatory)
select ename, sal, sum(sal) over (order by sal rows unbounded preceding) as cum_sum_sal from emp;

-- rows between 2 preceding 3 following (order by not mandatory)
select ename, sal, sum(sal) over (order by sal rows between 2 preceding and 3 following) window_sum_sal from emp;

-- lead lag
select ename, sal, lead(sal, 1) over () as leadsal, lag(sal, 1) over () as lagsal from emp;

-- group_concat
select group_concat(ename order by ename, ',') empname from emp group by deptno;

-- employment years
select ename, hiredate, timestampdiff(year, hiredate, current_date()) emp_years from emp;

-- pivot
select 
sum(if(e.deptno = 10, 1, null)) as dept_10,
sum(if(e.deptno = 20, 1, null)) as dept_20,
sum(if(e.deptno = 30, 1, null)) as dept_30
from emp e;


-- delete duplicate rows
drop table if exists dept_dup;
create table dept_dup as select * from dept union all select * from dept;
select * from dept_dup;
select d.*, row_number() over (partition by d.deptno) rr from dept_dup d;

-- Print company code, founder name, total number of lead manager, senior manager, manager, employee
with 
company as 
	(
    select 'C1' as company_code, 'Monika' as founder union all select 'C2' as company_code, 'Samantha' as founder
    ),
lead_manager as 
	(
    select 'C1' as company_code, 'LM1' as lead_manager_code union all select 'C2' as company_code, 'LM2' as lead_manager_code
    ),
senior_manager as
	(
    select 'C1' as company_code, 'LM1' as lead_manager_code, 'SM1' as senior_manager_code union all select 'C1' as company_code, 'LM1' as lead_manager_code, 'SM2' as senior_manager_code union all select 'C2' as company_code, 'LM2' as lead_manager_code, 'SM3' as senior_manager_code
    ),
manager as
	(
    select 'C1' as company_code, 'LM1' as lead_manager_code, 'SM1' as senior_manager_code, 'M1' as manager_code union all select 'C2' as company_code, 'LM2' as lead_manager_code, 'SM3' as senior_manager_code, 'M2' as manager_code union all select 'C2' as company_code, 'LM2' as lead_manager_code, 'SM3' as senior_manager_code, 'M3' as manager_code
    ),
employee as
	(
    select 'C1' as company_code, 'LM1' as lead_manager_code, 'SM1' as senior_manager_code, 'M1' as manager_code, 'E1' as employee_code union all select 'C1' as company_code, 'LM1' as lead_manager_code, 'SM1' as senior_manager_code, 'M1' as manager_code, 'E2' as employee_code union all select 'C2' as company_code, 'LM2' as lead_manager_code, 'SM3' as senior_manager_code, 'M2' as manager_code, 'E3' as employee_code union all select 'C2' as company_code, 'LM2' as lead_manager_code, 'SM3' as senior_manager_code, 'M3' as manager_code, 'E4' as employee_code
    )
select
c.company_code, c.founder, count(distinct lm.lead_manager_code) as lead_count, count(distinct sm.senior_manager_code) as sm_count, count(distinct m.manager_code) as m_count, count(distinct e.employee_code) as e_count
from company c left join lead_manager lm on c.company_code = lm.company_code
left join senior_manager sm on sm.company_code = lm.company_code and sm.lead_manager_code = lm.lead_manager_code
left join manager m on m.company_code = sm.company_code and m.lead_manager_code = sm.lead_manager_code and m.senior_manager_code = sm.senior_manager_code
left join employee e on e.company_code = m.company_code and e.lead_manager_code = m.lead_manager_code and e.senior_manager_code = m.senior_manager_code and e.manager_code = m.manager_code
group by c.company_code, c.founder
order by 1
;


-- lpad
select lpad('', 5, '*');













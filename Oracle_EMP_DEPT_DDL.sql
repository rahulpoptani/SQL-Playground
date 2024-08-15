-- EMP DEPT Script
CREATE TABLE dept (
  deptno NUMBER(2,0),
  dname  VARCHAR2(14),
  loc    VARCHAR2(13),
  CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

INSERT INTO dept VALUES(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES(20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES(30, 'SALES', 'CHICAGO');
INSERT INTO dept VALUES(40, 'OPERATIONS', 'BOSTON');
COMMIT;

CREATE TABLE emp (
  empno    NUMBER(4,0),
  ename    VARCHAR2(10),
  job      VARCHAR2(9),
  mgr      NUMBER(4,0),
  hiredate DATE,
  sal      NUMBER(7,2),
  comm     NUMBER(7,2),
  deptno   NUMBER(2,0),
  CONSTRAINT pk_emp PRIMARY KEY (empno),
  CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES dept (deptno)
);

INSERT INTO emp VALUES(7839, 'KING', 'PRESIDENT', null, to_date('17-11-1981','dd-mm-yyyy'), 5000, null, 10 );
INSERT INTO emp VALUES(7698, 'BLAKE', 'MANAGER', 7839, to_date('1-5-1981','dd-mm-yyyy'), 2850, null, 30);
INSERT INTO emp VALUES(7782, 'CLARK', 'MANAGER', 7839, to_date('9-6-1981','dd-mm-yyyy'), 2450, null, 10);
INSERT INTO emp VALUES(7566, 'JONES', 'MANAGER', 7839, to_date('2-4-1981','dd-mm-yyyy'), 2975, null, 20);
INSERT INTO emp VALUES(7788, 'SCOTT', 'ANALYST', 7566, to_date('13-JUL-87','dd-mm-rr') - 85, 3000, null, 20);
INSERT INTO emp VALUES(7902, 'FORD', 'ANALYST', 7566, to_date('3-12-1981','dd-mm-yyyy'), 3000, null, 20 );
INSERT INTO emp VALUES(7369, 'SMITH', 'CLERK', 7902, to_date('17-12-1980','dd-mm-yyyy'), 800, null, 20 );
INSERT INTO emp VALUES(7499, 'ALLEN', 'SALESMAN', 7698, to_date('20-2-1981','dd-mm-yyyy'), 1600, 300, 30);
INSERT INTO emp VALUES(7521, 'WARD', 'SALESMAN', 7698, to_date('22-2-1981','dd-mm-yyyy'), 1250, 500, 30 );
INSERT INTO emp VALUES(7654, 'MARTIN', 'SALESMAN', 7698, to_date('28-9-1981','dd-mm-yyyy'), 1250, 1400, 30 );
INSERT INTO emp VALUES(7844, 'TURNER', 'SALESMAN', 7698, to_date('8-9-1981','dd-mm-yyyy'), 1500, 0, 30);
INSERT INTO emp VALUES(7876, 'ADAMS', 'CLERK', 7788, to_date('13-JUL-87', 'dd-mm-rr') - 51, 1100, null, 20 );
INSERT INTO emp VALUES(7900, 'JAMES', 'CLERK', 7698, to_date('3-12-1981','dd-mm-yyyy'), 950, null, 30 );
INSERT INTO emp VALUES(7934, 'MILLER', 'CLERK', 7782, to_date('23-1-1982','dd-mm-yyyy'), 1300, null, 10 );
COMMIT;

CREATE TABLE salgrade (
  grade NUMBER,
  losal NUMBER,
  hisal NUMBER
);

INSERT INTO salgrade VALUES (1, 700, 1200);
INSERT INTO salgrade VALUES (2, 1201, 1400);
INSERT INTO salgrade VALUES (3, 1401, 2000);
INSERT INTO salgrade VALUES (4, 2001, 3000);
INSERT INTO salgrade VALUES (5, 3001, 9999);
COMMIT;

--=====================================================================================================================

-- Employee with higher salary than Manager
select * from emp e join emp m on e.mgr = m.empno and e.sal > m.sal;

-- Manager who has the most number of employees under him
with ranked_data as (select m.ename, dense_rank() over (order by count(distinct e.empno) desc) as max_emp_rank
from emp e join emp m on e.mgr = m.empno 
group by m.ename)
select ename from ranked_data where max_emp_rank = 1;


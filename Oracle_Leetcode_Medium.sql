-- #176 - Second Highest Salary - Report the second highest salary. If there is no second highest salary, then null
with employee as (
select 1 as id, 100 as salary from dual union all
select 2 as id, 200 as salary from dual union all
select 3 as id, 300 as salary from dual
)
select salary from (select salary, dense_rank() over (order by salary) as rnk from employee) where rnk = 2;
--select max(salary) SecondHighestSalary from employee where salary <> (select max(salary) from employee);


-- #177 - Nth Highest Salary. If there is no nth salary then null
with employee as (
select 1 as id, 100 as salary from dual union all
select 2 as id, 200 as salary from dual union all
select 3 as id, 300 as salary from dual
)
select max(salary) as salary from (select salary, dense_rank() over (order by salary) as rr from employee) s where rr = 4;


-- #178 - Rank Scores
with scores as (
select 1 as id, 3.50 as score from dual union all
select 2 as id, 3.65 as score from dual union all
select 3 as id, 4.00 as score from dual union all
select 4 as id, 3.85 as score from dual union all
select 5 as id, 4.00 as score from dual union all
select 6 as id, 3.65 as score from dual
)
select score, dense_rank() over (order by score desc) as rank from scores;


-- #180 - Consecutive Numbers - Find all numbers that appear at least three times consecutively
with logs as (
select 1 as id, 1 as num from dual union all
select 2 as id, 1 as num from dual union all
select 3 as id, 1 as num from dual union all
select 4 as id, 2 as num from dual union all
select 5 as id, 1 as num from dual union all
select 6 as id, 2 as num from dual union all
select 7 as id, 2 as num from dual
)
select num from (select id, num, lead(num,1) over (order by id) as num1, lead(num,2) over (order by id) as num2 from logs) where num = num1 and num1 = num2;
--select l1.num from logs l1 join logs l2 on l1.id = l2.id - 1 join logs l3 on l1.id = l3.id - 2 and l2.id = l3.id - 1 and l1.num = l2.num and l2.num = l3.num;


-- #184 - Department Highest Salary - Find employees who have the highest salary in each of the departments
with employee as (
select 1 as id, 'Joe' as name, 70000 as salary, 1 as departmentId from dual union all
select 2 as id, 'Jim' as name, 90000 as salary, 1 as departmentId from dual union all
select 3 as id, 'Henry' as name, 80000 as salary, 2 as departmentId from dual union all
select 4 as id, 'Sam' as name, 60000 as salary, 2 as departmentId from dual union all
select 5 as id, 'Max' as name, 90000 as salary, 1 as departmentId from dual
),
department as (
select 1 as id, 'IT' as name from dual union all
select 2 as id, 'Sales' as name from dual
)
select d.name as department, e.name as Employee, e.salary from employee e join department d on e.departmentId = d.id where (departmentId, salary) in (select departmentId, max(salary) as maxsal from employee group by departmentId);


-- #570 - Managers with atleast 5 direct reports
with employee as (
select 101 as id, 'John'    as name, 'A' as department, null    as manager_id from dual union all
select 102 as id, 'Dan'     as name, 'A' as department, 101     as manager_id from dual union all
select 103 as id, 'James'   as name, 'A' as department, 101     as manager_id from dual union all
select 104 as id, 'Any'     as name, 'A' as department, 101     as manager_id from dual union all
select 105 as id, 'Anne'    as name, 'A' as department, 101     as manager_id from dual union all
select 106 as id, 'Ron'     as name, 'B' as department, 101     as manager_id from dual union all
select 106 as id, 'Joseph'  as name, 'B' as department, 102     as manager_id from dual union all
select 106 as id, 'Marcas'  as name, 'B' as department, 102     as manager_id from dual
)
select name from employee where id in (select manager_id from employee group by manager_id having count(distinct id) >= 5);


-- #574 - Winning Candidate
with candidate as (
select 1 as id, 'A' as name from dual union all
select 2 as id, 'B' as name from dual union all
select 3 as id, 'C' as name from dual union all
select 4 as id, 'D' as name from dual union all
select 5 as id, 'E' as name from dual
),
vote as (
select 1 as id, 2 as candidateId from dual union all
select 2 as id, 4 as candidateId from dual union all
select 3 as id, 3 as candidateId from dual union all
select 4 as id, 2 as candidateId from dual union all
select 5 as id, 5 as candidateId from dual
)
select c.name from (select candidateId, dense_rank() over (order by count(distinct id) desc) as voteRank from vote group by candidateId) s join candidate c on s.candidateId = c.id where voteRank = 1;


-- #578 - Get Highest answer rate question
with input as (
select 5 as id, 'show'      as action, 285 as question_id, null     as answer_id, 1 as q_num, 123 as timestamp from dual union all
select 5 as id, 'answer'    as action, 285 as question_id, 124124   as answer_id, 1 as q_num, 124 as timestamp from dual union all
select 5 as id, 'show'      as action, 369 as question_id, null     as answer_id, 2 as q_num, 125 as timestamp from dual union all
select 5 as id, 'skip'      as action, 369 as question_id, null     as answer_id, 2 as q_num, 126 as timestamp from dual
)
select question_id from (select question_id, dense_rank() over (order by sum(case when answer_id is not null then 1 else 0 end)/count(*) desc) as ans_rate from input group by question_id) where ans_rate = 1;
--select question_id from (select question_id, sum(case when answer_id is not null then 1 else 0 end) / count(*) as ans_rate from input group by question_id order by 2 desc) where rownum = 1;


-- #580 - Count student number in department
with student as (
select 1 as student_id, 'Jack' as student_name, 'M' as gender_name, 1 as dept_id from dual union all
select 2 as student_id, 'Jane' as student_name, 'F' as gender_name, 1 as dept_id from dual union all
select 3 as student_id, 'Mark' as student_name, 'M' as gender_name, 2 as dept_id from dual
),
department as (
select 1 as dept_id, 'Engineering' as dept_name from dual union all
select 2 as dept_id, 'Science' as dept_name from dual union all
select 3 as dept_id, 'Law' as dept_name from dual
)
select d.dept_name, count(s.student_id) as student_number from department d left join student s on s.dept_id = d.dept_id group by d.dept_name order by 2 desc;


-- #585 - Investments in 2016 - sum of all total investment values in 2016 (TIV_2016). 
-- Condition 1 - Have the same TIV_2015 value as one or more other policyholders. 
-- Condition 2 - Not located in the same city as any other policyholder 
with insurance as (
select 1 as pid, 10 as tiv_2015, 5 as tiv_2016, 10 as lat, 10 as lon from dual union all
select 2 as pid, 20 as tiv_2015, 20 as tiv_2016, 20 as lat, 20 as lon from dual union all
select 3 as pid, 10 as tiv_2015, 30 as tiv_2016, 20 as lat, 20 as lon from dual union all
select 4 as pid, 10 as tiv_2015, 40 as tiv_2016, 40 as lat, 40 as lon from dual
)
select sum(insurance.tiv_2016) as tiv_2016 from insurance where insurance.tiv_2015 in (select tiv_2015 from insurance group by tiv_2015 having count(*) > 1)
and concat(lat, lon) in (select concat(lat, lon) from insurance group by lat, lon having count(*) = 1);


-- #602 - Friend Request II - Who has the most friends
with request_accepted as (
select 1 as requester_id, 2 as accepter_id, to_date('2016-06-03','YYYY-MM-DD') as accept_date from dual union all
select 1 as requester_id, 3 as accepter_id, to_date('2016-06-08','YYYY-MM-DD') as accept_date from dual union all
select 2 as requester_id, 3 as accepter_id, to_date('2016-06-08','YYYY-MM-DD') as accept_date from dual union all
select 3 as requester_id, 4 as accepter_id, to_date('2016-06-09','YYYY-MM-DD') as accept_date from dual
)
select id, total_friends as num from (
select id, sum(friends) as total_friends from (
select requester_id as id, count(distinct accepter_id) as friends from request_accepted group by requester_id
union all
select accepter_id as id, count(distinct requester_id) as friends from request_accepted group by accepter_id
) group by id order by 2 desc
) where rownum = 1;


-- Open #608 - Tree Node. There are three kind of nodes. Lead, Inner and Root. Report node id and type of node, sort by node id
with tree as (
select 1 as id, null as p_id from dual union all
select 2 as id, 1 as p_id from dual union all
select 3 as id, 1 as p_id from dual union all
select 4 as id, 2 as p_id from dual union all
select 5 as id, 2 as p_id from dual
)
select id, 'Root' as type from tree where p_id is null
union
select id, 'Inner' as type from tree where p_id is not null and id in (select p_id from tree where p_id is not null) and p_id is not null
union
select id, 'Leaf' as type from tree where id not in (select p_id from tree where p_id is not null) and p_id is not null
order by id;


-- #612 - Shortest distance in a plane - Find shortest distance between these two points
with point_2d as (
select -1 as x, -1 as y from dual union all
select 0 as x, 0 as y from dual union all
select -1 as x, -2 as y from dual 
)
select min(sqrt(power(p2.x - p1.x, 2) + power(p2.y - p1.y, 2))) as shortest from point_2d p1 join point_2d p2 on concat(p1.x,p1.y) <> concat(p2.x,p2.y);


-- #614 - Second Degree Followers - Explaination: Both B and D exist in the follower list, when as a followee, B’s follower is C and D, and D’s follower is E. A does not exist in follower list
with follow as (
select 'A' as followee, 'B' as follower from dual union all
select 'B' as followee, 'C' as follower from dual union all
select 'B' as followee, 'D' as follower from dual union all
select 'D' as followee, 'E' as follower from dual
)
select followee as follower, count(distinct follower) as num from follow where followee in (select distinct follower from follow) group by followee order by 2 desc;


-- #626 - Exchange Seats
with seat as (
select 1 as id, 'Abbot' as student from dual union all
select 2 as id, 'Doris' as student from dual union all
select 3 as id, 'Emerson' as student from dual union all
select 4 as id, 'Green' as student from dual union all
select 5 as id, 'Jeames' as student from dual
)
select id, case when mod(id,2)=1 then nvl(lead(student,1) over(order by id),student) else lag(student,1) over (order by id) end as student from seat;


-- #1045 - Customers who bought all products
with customer as (
select 1 as customer_id, 5 as product_key from dual union all
select 2 as customer_id, 6 as product_key from dual union all
select 3 as customer_id, 5 as product_key from dual union all
select 3 as customer_id, 6 as product_key from dual union all
select 1 as customer_id, 6 as product_key from dual
),
product as (
select 5 as product_key from dual union all
select 6 as product_key from dual
)
select customer_id from customer group by customer_id having count(distinct product_key) = (select count(product_key) from product);


-- #1070 - Product Sales Analysis III
-- Find product_id, first_year, quantity, price for the first year product was sold
with sales as (
select 1 as sales_id, 100 as product_id, 2008 as year, 10 as quantity, 5000 as price from dual union all
select 2 as sales_id, 100 as product_id, 2009 as year, 12 as quantity, 5000 as price from dual union all
select 7 as sales_id, 200 as product_id, 2011 as year, 15 as quantity, 9000 as price from dual
),
product as (
select 100 as product_id, 'Nokia' as product_name from dual union all
select 200 as product_id, 'Apple' as product_name from dual union all
select 300 as product_id, 'Samsung' as product_name from dual
)
select product_id, year as first_year, quantity, price from sales where (product_id, year) in (select product_id, min(year) as minyear from sales group by product_id);


-- #1077 - Project Employees III - Report most experienced employees in each project. Report all in case of tie
with project as (
select 1 as project_id, 1 as employee_id from dual union all
select 1 as project_id, 2 as employee_id from dual union all
select 1 as project_id, 3 as employee_id from dual union all
select 2 as project_id, 1 as employee_id from dual union all
select 2 as project_id, 4 as employee_id from dual
),
employee as (
select 1 as employee_id, 'Khaled' as name, 3 as experience_years from dual union all
select 2 as employee_id, 'Ali' as name, 2 as experience_years from dual union all
select 3 as employee_id, 'John' as name, 3 as experience_years from dual union all
select 4 as employee_id, 'Doe' as name, 2 as experience_years from dual
)
select p.project_id, p.employee_id from project p join employee e on e.employee_id = p.employee_id where (p.project_id, e.experience_years) in (select p.project_id, max(e.experience_years) as exp from project p join employee e on e.employee_id = p.employee_id group by p.project_id);


-- #534 - GamePlay Analysis III - Games played so far by each player
with activity as (
    select 1 as player_id, 2 as device_id, to_date('2016-03-01', 'YYYY-MM-DD') as event_date, 5 as games_played from dual union all
    select 1 as player_id, 2 as device_id, to_date('2016-05-02', 'YYYY-MM-DD') as event_date, 6 as games_played from dual union all
    select 1 as player_id, 3 as device_id, to_date('2017-06-25', 'YYYY-MM-DD') as event_date, 1 as games_played from dual union all
    select 3 as player_id, 1 as device_id, to_date('2016-03-02', 'YYYY-MM-DD') as event_date, 0 as games_played from dual union all
    select 3 as player_id, 4 as device_id, to_date('2018-07-03', 'YYYY-MM-DD') as event_date, 5 as games_played from dual
)
select player_id, sum(games_played) over (partition by player_id order by event_date) as games_played_sofar from activity;


-- #550 - GamePlay Analysis IV - Reports the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places
with activity as (
    select 1 as player_id, 2 as device_id, to_date('2016-03-01', 'YYYY-MM-DD') as event_date, 5 as games_played from dual union all
    select 1 as player_id, 2 as device_id, to_date('2016-03-02', 'YYYY-MM-DD') as event_date, 6 as games_played from dual union all
    select 2 as player_id, 3 as device_id, to_date('2017-06-25', 'YYYY-MM-DD') as event_date, 1 as games_played from dual union all
    select 3 as player_id, 1 as device_id, to_date('2016-03-02', 'YYYY-MM-DD') as event_date, 0 as games_played from dual union all
    select 3 as player_id, 4 as device_id, to_date('2018-07-03', 'YYYY-MM-DD') as event_date, 5 as games_played from dual
)
select round(count(distinct b.player_id)/count(distinct a.player_id),2) as fraction from activity a left join activity b on a.player_id = b.player_id and a.event_date = b.event_date-1;


-- #1098 - Unpopular Books - Reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than 1 month from today. Assume today is 2019-06-23
with books as (
select 1 as book_id, 'Kalila And Demna' as name, to_date('2010-01-01','YYYY-MM-DD') as available_from from dual union all
select 2 as book_id, '28 Letters' as name, to_date('2012-05-12','YYYY-MM-DD') as available_from from dual union all
select 3 as book_id, 'The Hobbit' as name, to_date('2019-06-10','YYYY-MM-DD') as available_from from dual union all
select 4 as book_id, '13 Reasons Why' as name, to_date('2019-06-01','YYYY-MM-DD') as available_from from dual union all
select 5 as book_id, 'The Hunger Games' as name, to_date('2008-09-21','YYYY-MM-DD') as available_from from dual
),
orders as (
select 1 as order_id, 1 as book_id, 2 as quantity, to_date('2018-07-26','YYYY-MM-DD') as dispatch_date from dual union all
select 2 as order_id, 1 as book_id, 1 as quantity, to_date('2018-11-05','YYYY-MM-DD') as dispatch_date from dual union all
select 3 as order_id, 3 as book_id, 8 as quantity, to_date('2019-06-11','YYYY-MM-DD') as dispatch_date from dual union all
select 4 as order_id, 4 as book_id, 6 as quantity, to_date('2019-06-05','YYYY-MM-DD') as dispatch_date from dual union all
select 5 as order_id, 4 as book_id, 5 as quantity, to_date('2019-06-20','YYYY-MM-DD') as dispatch_date from dual union all
select 6 as order_id, 5 as book_id, 9 as quantity, to_date('2009-02-02','YYYY-MM-DD') as dispatch_date from dual union all
select 7 as order_id, 5 as book_id, 8 as quantity, to_date('2010-04-13','YYYY-MM-DD') as dispatch_date from dual
)
select book_id, name from books where available_from < add_months(to_date('2019-06-23','YYYY-MM-DD'),-1) and book_id not in (select book_id from orders where dispatch_date between add_months(to_date('2019-06-23','YYYY-MM-DD'),-12) and to_date('2019-06-23','YYYY-MM-DD') group by book_id having sum(quantity) >= 10);


-- #1107 - New Users Daily Count - Assume today is 2019-06-30. Reports for every date within at most 90 days from today, the number of users that logged in for the first time on that date
with traffic as (
select 1 as user_id, 'login' as activity, to_date('2019-05-01','YYYY-MM-DD') as activity_date from dual union all
select 1 as user_id, 'homepage' as activity, to_date('2019-05-01','YYYY-MM-DD') as activity_date from dual union all
select 1 as user_id, 'logout' as activity, to_date('2019-05-01','YYYY-MM-DD') as activity_date from dual union all
select 2 as user_id, 'login' as activity, to_date('2019-06-21','YYYY-MM-DD') as activity_date from dual union all
select 2 as user_id, 'logout' as activity, to_date('2019-06-21','YYYY-MM-DD') as activity_date from dual union all
select 3 as user_id, 'login' as activity, to_date('2019-01-01','YYYY-MM-DD') as activity_date from dual union all
select 3 as user_id, 'jobs' as activity, to_date('2019-01-01','YYYY-MM-DD') as activity_date from dual union all
select 3 as user_id, 'logout' as activity, to_date('2019-01-01','YYYY-MM-DD') as activity_date from dual union all
select 4 as user_id, 'login' as activity, to_date('2019-06-21','YYYY-MM-DD') as activity_date from dual union all
select 4 as user_id, 'groups' as activity, to_date('2019-06-21','YYYY-MM-DD') as activity_date from dual union all
select 4 as user_id, 'logout' as activity, to_date('2019-06-21','YYYY-MM-DD') as activity_date from dual union all
select 5 as user_id, 'login' as activity, to_date('2019-03-01','YYYY-MM-DD') as activity_date from dual union all
select 5 as user_id, 'logout' as activity, to_date('2019-03-01','YYYY-MM-DD') as activity_date from dual union all
select 5 as user_id, 'login' as activity, to_date('2019-06-21','YYYY-MM-DD') as activity_date from dual union all
select 5 as user_id, 'logout' as activity, to_date('2019-06-21','YYYY-MM-DD') as activity_date from dual
)
select first_login as login_date, count(distinct user_id) as user_count from (select user_id, min(activity_date) as first_login from traffic where activity = 'login' group by user_id) 
where first_login between to_date('2019-06-30','YYYY-MM-DD')-90 and to_date('2019-06-30','YYYY-MM-DD') group by first_login;


-- #1112 - Highest Grade for Each Student - Fnd the highest grade with its corresponding course for each student. In case of tie choose the record with smallest courseid
with enrollments as (
select 2 as student_id, 2 as course_id, 95 as grade from dual union all
select 2 as student_id, 3 as course_id, 95 as grade from dual union all
select 1 as student_id, 1 as course_id, 90 as grade from dual union all
select 1 as student_id, 2 as course_id, 99 as grade from dual union all
select 3 as student_id, 1 as course_id, 80 as grade from dual union all
select 3 as student_id, 2 as course_id, 75 as grade from dual union all
select 3 as student_id, 3 as course_id, 82 as grade from dual
)
select student_id, course_id, grade from (select student_id, course_id, grade, dense_rank() over (partition by student_id order by grade desc, course_id) as rr from enrollments) where rr = 1;


-- #1126 - Active Business - Business that has more than one event type with occurences greater than the average occurences of that event type among all businesses
-- Average for 'reviews', 'ads' and 'page views' are (7+3)/2=5, (11+7+6)/3=8, (3+12)/2=7.5 respectively. Business with id 1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8) so it is an active business.
with events as (
select 1 as business_id, 'reviews' as event_type, 7 as occurences from dual union all
select 3 as business_id, 'reviews' as event_type, 3 as occurences from dual union all
select 1 as business_id, 'ads' as event_type, 11 as occurences from dual union all
select 2 as business_id, 'ads' as event_type, 7 as occurences from dual union all
select 3 as business_id, 'ads' as event_type, 6 as occurences from dual union all
select 1 as business_id, 'page views' as event_type, 3 as occurences from dual union all
select 2 as business_id, 'page views' as event_type, 12 as occurences from dual
)
select business_id from (
select business_id, event_type, occurences, avg(occurences) over (partition by event_type) as avg_occ from events)
where occurences > avg_occ group by business_id having count(distinct event_type) > 1;


-- #1132 - Reported Posts II - Find the average for daily percentage of posts that got removed after being reported as spam, rounded to 2 decimal places
with actions as (
select 1 user_id, 1 as post_id, to_date('2019-07-01','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 1 user_id, 1 as post_id, to_date('2019-07-01','YYYY-MM-DD') as action_date, 'like' as action, null as extra from dual union all
select 1 user_id, 1 as post_id, to_date('2019-07-01','YYYY-MM-DD') as action_date, 'share' as action, null as extra from dual union all
select 2 user_id, 2 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 2 user_id, 2 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'report' as action, 'spam' as extra from dual union all
select 3 user_id, 4 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 3 user_id, 4 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'report' as action, 'spam' as extra from dual union all
select 4 user_id, 3 as post_id, to_date('2019-07-02','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 4 user_id, 3 as post_id, to_date('2019-07-02','YYYY-MM-DD') as action_date, 'report' as action, 'spam' as extra from dual union all
select 5 user_id, 2 as post_id, to_date('2019-07-03','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 5 user_id, 2 as post_id, to_date('2019-07-03','YYYY-MM-DD') as action_date, 'report' as action, 'racism' as extra from dual union all
select 5 user_id, 5 as post_id, to_date('2019-07-03','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 5 user_id, 5 as post_id, to_date('2019-07-03','YYYY-MM-DD') as action_date, 'report' as action, 'racism' as extra from dual
),
removals as ( -- indicates that some post was removed
select 2 as post_id, to_date('2019-07-20','YYYY-MM-DD') as remove_date from dual union all
select 3 as post_id, to_date('2019-07-18','YYYY-MM-DD') as remove_date from dual
)
select round(avg(daily_spam),2) as average_daily_percent from (select count(distinct b.post_id)/count(distinct a.post_id) * 100 as daily_spam from actions a left join removals b on a.post_id = b.post_id where extra = 'spam' group by action_date);


-- #1149 - Article View II - Find all the people who viewed more than one article on the same date, sorted in ascending order by their id
with views as (
select 1 as article_id, 3 as author_id, 5 as viewer_id, to_date('2019-08-01','YYYY-MM-DD') as view_date from dual union all
select 3 as article_id, 4 as author_id, 5 as viewer_id, to_date('2019-08-01','YYYY-MM-DD') as view_date from dual union all
select 1 as article_id, 3 as author_id, 6 as viewer_id, to_date('2019-08-02','YYYY-MM-DD') as view_date from dual union all
select 2 as article_id, 7 as author_id, 7 as viewer_id, to_date('2019-08-01','YYYY-MM-DD') as view_date from dual union all
select 2 as article_id, 7 as author_id, 6 as viewer_id, to_date('2019-08-02','YYYY-MM-DD') as view_date from dual union all
select 4 as article_id, 7 as author_id, 1 as viewer_id, to_date('2019-07-22','YYYY-MM-DD') as view_date from dual union all
select 3 as article_id, 4 as author_id, 4 as viewer_id, to_date('2019-07-21','YYYY-MM-DD') as view_date from dual union all
select 3 as article_id, 4 as author_id, 4 as viewer_id, to_date('2019-07-21','YYYY-MM-DD') as view_date from dual
)
select viewer_id from views group by viewer_id, view_date having count(distinct article_id) > 1;


-- #1158 - Market Analysis I - Find for each user, the join date and the number of orders they made as a buyer in 2019
with users as (
select 1 as user_id, to_date('2018-01-01', 'YYYY-MM-DD') as join_date, 'Lenovo' as favorite_brand from dual union all
select 2 as user_id, to_date('2018-02-09', 'YYYY-MM-DD') as join_date, 'Samsung' as favorite_brand from dual union all
select 3 as user_id, to_date('2018-01-19', 'YYYY-MM-DD') as join_date, 'LG' as favorite_brand from dual union all
select 4 as user_id, to_date('2018-05-21', 'YYYY-MM-DD') as join_date, 'HP' as favorite_brand from dual
),
orders as (
select 1 as order_id, to_date('2019-08-01', 'YYYY-MM-DD') as order_date, 4 as item_id, 1 as buyer_id, 2 as seller_id from dual union all
select 2 as order_id, to_date('2018-08-02', 'YYYY-MM-DD') as order_date, 2 as item_id, 1 as buyer_id, 3 as seller_id from dual union all
select 3 as order_id, to_date('2019-08-03', 'YYYY-MM-DD') as order_date, 3 as item_id, 2 as buyer_id, 3 as seller_id from dual union all
select 4 as order_id, to_date('2018-08-04', 'YYYY-MM-DD') as order_date, 1 as item_id, 4 as buyer_id, 2 as seller_id from dual union all
select 5 as order_id, to_date('2018-08-04', 'YYYY-MM-DD') as order_date, 1 as item_id, 3 as buyer_id, 4 as seller_id from dual union all
select 6 as order_id, to_date('2019-08-05', 'YYYY-MM-DD') as order_date, 2 as item_id, 2 as buyer_id, 4 as seller_id from dual
),
items as (
select 1 as item_id, 'Samsung' as item_brand from dual union all
select 2 as item_id, 'Lenovo' as item_brand from dual union all
select 3 as item_id, 'LG' as item_brand from dual union all
select 4 as item_id, 'HP' as item_brand from dual
)
select u.user_id as "buyer_id", to_char(u.join_date,'YYYY-MM-DD') as "join_date", count(distinct o.order_id) as "orders_in_2019" from users u left join (select * from orders where extract(year from order_date) = 2019) o on u.user_id = o.buyer_id group by u.user_id, u.join_date order by u.user_id;


-- #1164 - Product Price at a given date - Find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10
with products as (
select 1 as product_id, 20 as new_price, to_date('2019-08-14','YYYY-MM-DD') as change_date from dual union all
select 2 as product_id, 50 as new_price, to_date('2019-08-14','YYYY-MM-DD') as change_date from dual union all
select 1 as product_id, 30 as new_price, to_date('2019-08-15','YYYY-MM-DD') as change_date from dual union all
select 1 as product_id, 35 as new_price, to_date('2019-08-16','YYYY-MM-DD') as change_date from dual union all
select 2 as product_id, 65 as new_price, to_date('2019-08-17','YYYY-MM-DD') as change_date from dual union all
select 3 as product_id, 20 as new_price, to_date('2019-08-18','YYYY-MM-DD') as change_date from dual
)
select product_id, case when change_date <= to_date('2019-08-16','YYYY-MM-DD') then new_price else 10 end as price from (
select p.product_id, p.new_price, p.change_date, dense_rank() over (partition by p.product_id order by change_date desc) as rr from products p) where rr = 1;


-- #1174 - Immediate Food Delivery II
with delivery as (
select 1 as delivery_id, 1 as customer_id, to_date('2019-08-01','YYYY-MM-DD') as order_date, to_date('2019-08-02','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 2 as delivery_id, 2 as customer_id, to_date('2019-08-02','YYYY-MM-DD') as order_date, to_date('2019-08-02','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 3 as delivery_id, 1 as customer_id, to_date('2019-08-11','YYYY-MM-DD') as order_date, to_date('2019-08-12','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 4 as delivery_id, 3 as customer_id, to_date('2019-08-24','YYYY-MM-DD') as order_date, to_date('2019-08-24','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 5 as delivery_id, 3 as customer_id, to_date('2019-08-21','YYYY-MM-DD') as order_date, to_date('2019-08-22','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 6 as delivery_id, 2 as customer_id, to_date('2019-08-11','YYYY-MM-DD') as order_date, to_date('2019-08-13','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 7 as delivery_id, 4 as customer_id, to_date('2019-08-09','YYYY-MM-DD') as order_date, to_date('2019-08-09','YYYY-MM-DD') as customer_pref_delivery_date from dual
)
select sum(case when first_order = customer_pref_delivery_date then 1 else 0 end) / count(distinct customer_id) * 100 as immediate_percentage from (
select customer_id, order_date, customer_pref_delivery_date, min(order_date) over (partition by customer_id) as first_order from delivery);


-- #1193 - Monthly Transactions I - Find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount
with transactions as (
select 121 as id, 'US' as country, 'approved' as state, 1000 as amount, to_date('2018-12-18', 'YYYY-MM-DD') as trans_date from dual union all
select 122 as id, 'US' as country, 'declined' as state, 2000 as amount, to_date('2018-12-19', 'YYYY-MM-DD') as trans_date from dual union all
select 123 as id, 'US' as country, 'approved' as state, 2000 as amount, to_date('2019-01-01', 'YYYY-MM-DD') as trans_date from dual union all
select 124 as id, 'DE' as country, 'approved' as state, 2000 as amount, to_date('2019-01-07', 'YYYY-MM-DD') as trans_date from dual
)
select to_char(trans_date, 'YYYY-MM') as month, country, count(distinct id) as trans_count, sum(case when state = 'approved' then 1 else 0 end) as approved_count, sum(amount) as trans_total_amount, sum(case when state = 'approved' then amount else 0 end) as approved_total_amount from transactions group by to_char(trans_date, 'YYYY-MM'), country order by month, country desc;


-- #1204 - Last person to fit in the bus - Find the person_name of the last person who will fit in the elevator without exceeding the weight limit
-- The maximum weight the elevator can hold is 1000
with queue as (
select 5 as person_id, 'George Washington' as person_name, 250 as weight, 1 as turn from dual union all
select 3 as person_id, 'John Adams' as person_name, 350 as weight, 2 as turn from dual union all
select 6 as person_id, 'Thomas Jefferson' as person_name, 400 as weight, 3 as turn from dual union all
select 2 as person_id, 'Will Johnliams' as person_name, 200 as weight, 4 as turn from dual union all
select 4 as person_id, 'Thomas Jefferson' as person_name, 175 as weight, 5 as turn from dual union all
select 1 as person_id, 'James Elephant' as person_name, 500 as weight, 6 as turn from dual
)
select person_name from (select q.*, sum(weight) over (order by turn) as cum_weight from queue q order by turn desc) where cum_weight <= 1000 and rownum = 1;


-- #1205 - Monthly Transactions II - Find for each month and country, the number of approved transactions and their total amount, the number of chargebacks and their total amount.
with transactions as (
select 101 as id, 'US' as country, 'approved' as state, 1000 as amount, to_date('2019-05-18', 'YYYY-MM-DD') as trans_date from dual union all
select 102 as id, 'US' as country, 'declined' as state, 2000 as amount, to_date('2019-05-19', 'YYYY-MM-DD') as trans_date from dual union all
select 103 as id, 'US' as country, 'approved' as state, 3000 as amount, to_date('2019-06-10', 'YYYY-MM-DD') as trans_date from dual union all
select 104 as id, 'US' as country, 'approved' as state, 4000 as amount, to_date('2019-06-13', 'YYYY-MM-DD') as trans_date from dual union all
select 105 as id, 'US' as country, 'approved' as state, 5000 as amount, to_date('2019-06-15', 'YYYY-MM-DD') as trans_date from dual
),
chargebacks as (
select 102 as trans_id, to_date('2019-05-29','YYYY-MM-DD') as trans_date from dual union all
select 101 as trans_id, to_date('2019-06-30','YYYY-MM-DD') as trans_date from dual union all
select 105 as trans_id, to_date('2019-09-18','YYYY-MM-DD') as trans_date from dual
) -- Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table. trans_id is a foreign key to the id column of Transactions table. Each chargeback corresponds to a transaction made previously even if they were not approved.
select 
to_char(trans_date, 'YYYY-MM') as month, country, sum(case when state = 'approved' then 1 else 0 end) as approved_count, sum(case when state = 'approved' then amount else 0 end) asapproved_amount, sum(case when state = 'chargeback' then 1 else 0 end) as chargeback_count
from (select c.trans_id as id, t.country, 'chargeback' as state, t.amount, c.trans_date from chargebacks c join transactions t on t.id = c.trans_id union select * from transactions)
group by to_char(trans_date, 'YYYY-MM'), country
order by month;


-- #1212 - Team Scores in football tournament - Compute the scores of all teams after all matches
-- 3 points for win, 1 point for tie, 0 for loss
with teams as (
select 10 as team_id, 'Leetcode FC' as team_name from dual union all
select 20 as team_id, 'NewYork FC' as team_name from dual union all
select 30 as team_id, 'Atlanta FC' as team_name from dual union all
select 40 as team_id, 'Chicago FC' as team_name from dual union all
select 50 as team_id, 'Toronto FC' as team_name from dual
),
matches as (
select 1 as match_id, 10 as host_team, 20 as guest_team, 3 as host_goals, 0 as guest_goals from dual union all
select 2 as match_id, 30 as host_team, 10 as guest_team, 2 as host_goals, 2 as guest_goals from dual union all
select 3 as match_id, 10 as host_team, 50 as guest_team, 5 as host_goals, 1 as guest_goals from dual union all
select 4 as match_id, 20 as host_team, 30 as guest_team, 1 as host_goals, 0 as guest_goals from dual union all
select 5 as match_id, 50 as host_team, 30 as guest_team, 1 as host_goals, 0 as guest_goals from dual
)
select t.team_id, sum(case when s.host_goals > s.guest_goals then 3 when s.host_goals = s.guest_goals then 1 else 0 end) as num_points
from (select match_id, host_team, guest_team, host_goals, guest_goals from matches union select match_id, guest_team as host_team, host_team as guest_team, guest_goals as host_goals, host_goals as guest_goals from matches) s right join teams t on t.team_id = s.host_team
group by t.team_id order by t.team_id;


-- #1264 - Page Recommendations - Recommend pages to the user with user_id = 1 using the pages that your friends liked. It should not recommend pages you already liked
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
select distinct page_id from 
(select user1_id, user2_id from friendship where user1_id = 1 union select user2_id as user1_id, user1_id as user2_id from friendship where user2_id = 1) s
left join likes l on s.user2_id = l.user_id where page_id not in (select page_id from likes where user_id = 1);


-- #1270 - All People report to a given manager - Find employee_id for all employees that directly or indirectly report thier work to head of company
-- the head of the company is with employee_id = 1
with employee as (
select 1 as employee_id, 'Boss' as employee_name, 1 as manager_id from dual union all
select 3 as employee_id, 'Alice' as employee_name, 3 as manager_id from dual union all
select 2 as employee_id, 'Bob' as employee_name, 1 as manager_id from dual union all
select 4 as employee_id, 'Daniel' as employee_name, 2 as manager_id from dual union all
select 7 as employee_id, 'Luis' as employee_name, 4 as manager_id from dual union all
select 8 as employee_id, 'Jhon' as employee_name, 3 as manager_id from dual union all
select 9 as employee_id, 'Angela' as employee_name, 8 as manager_id from dual union all
select 77 as employee_id, 'Robert' as employee_name, 1 as manager_id from dual
)
--select e1.employee_id from employee e1 join employee e2 on e1.manager_id = e2.employee_id join employee e3 on e2.manager_id = e3.employee_id where e1.employee_id <> 1 and e3.manager_id = 1;
select employee_id, connect_by_root employee_name as Manager, sys_connect_by_path(employee_name, '/') as hierarchy from employee where employee_id <> 1 start with employee_id = 1 connect by nocycle prior employee_id = manager_id;


-- #1285 - Find the start and end number of continuous range
with logs as (
select 1 as log_id from dual union all
select 2 as log_id from dual union all
select 3 as log_id from dual union all
select 7 as log_id from dual union all
select 8 as log_id from dual union all
select 10 as log_id from dual
)
select min(log_id) as start_id, max(log_id) as end_id from (select log_id, log_id - row_number() over (order by log_id) as delta from logs) group by delta order by start_id;


-- #1308 - Running total for different genders
with scores as (
select 'Aron' as player_name, 'F' as gender, to_date('2020-01-01','YYYY-MM-DD') as day, 17 as score_points from dual union all
select 'Alice' as player_name, 'F' as gender, to_date('2020-01-07','YYYY-MM-DD') as day, 23 as score_points from dual union all
select 'Bajrang' as player_name, 'M' as gender, to_date('2020-01-07','YYYY-MM-DD') as day, 7 as score_points from dual union all
select 'Khali' as player_name, 'M' as gender, to_date('2019-12-25','YYYY-MM-DD') as day, 11 as score_points from dual union all
select 'Slaman' as player_name, 'M' as gender, to_date('2019-12-30','YYYY-MM-DD') as day, 13 as score_points from dual union all
select 'Joe' as player_name, 'M' as gender, to_date('2019-12-31','YYYY-MM-DD') as day, 3 as score_points from dual union all
select 'Jose' as player_name, 'M' as gender, to_date('2019-12-18','YYYY-MM-DD') as day, 2 as score_points from dual union all
select 'Priya' as player_name, 'F' as gender, to_date('2019-12-31','YYYY-MM-DD') as day, 23 as score_points from dual union all
select 'Priyanka' as player_name, 'F' as gender, to_date('2019-12-30','YYYY-MM-DD') as day, 17 as score_points from dual
)
select gender, day, sum(score_points) over (partition by gender order by day) as total from scores;


-- #1321 - Restaurant Growth - Compute moving average of how much customer paid in a 7 days window
with customers as (
select 1 as customer_id, 'Jhon' as name, to_date('2019-01-01','YYYY-MM-DD') as visited_on, 100 as amount from dual union all
select 2 as customer_id, 'Daniel' as name, to_date('2019-01-02','YYYY-MM-DD') as visited_on, 110 as amount from dual union all
select 3 as customer_id, 'Jade' as name, to_date('2019-01-03','YYYY-MM-DD') as visited_on, 120 as amount from dual union all
select 4 as customer_id, 'Khaled' as name, to_date('2019-01-04','YYYY-MM-DD') as visited_on, 130 as amount from dual union all
select 5 as customer_id, 'Winston' as name, to_date('2019-01-05','YYYY-MM-DD') as visited_on, 110 as amount from dual union all
select 6 as customer_id, 'Elvis' as name, to_date('2019-01-06','YYYY-MM-DD') as visited_on, 140 as amount from dual union all
select 7 as customer_id, 'Anna' as name, to_date('2019-01-07','YYYY-MM-DD') as visited_on, 150 as amount from dual union all
select 8 as customer_id, 'Maria' as name, to_date('2019-01-08','YYYY-MM-DD') as visited_on, 80 as amount from dual union all
select 9 as customer_id, 'Jaze' as name, to_date('2019-01-09','YYYY-MM-DD') as visited_on, 110 as amount from dual union all
select 1 as customer_id, 'Jhon' as name, to_date('2019-01-10','YYYY-MM-DD') as visited_on, 130 as amount from dual union all
select 3 as customer_id, 'Jade' as name, to_date('2019-01-10','YYYY-MM-DD') as visited_on, 150 as amount from dual
)
select distinct visited_on, amount, round(amount/7,2) as average_amount from (
select visited_on, sum(amount) over (order by visited_on range between 6 preceding and current row) as amount
from customers) where visited_on >= (select min(visited_on)+6 from customers) order by visited_on;


-- #1341 - Movie Rating
-- Find the name of the user who has rated the greatest number of movies. In case of a tie, return lexicographically smaller user name
-- Find the movie name with the highest average rating in February 2020. In case of a tie, return lexicographically smaller movie name
with movies as (
select 1 as movie_id, 'Avengers' as title from dual union all
select 2 as movie_id, 'Frozen 2' as title from dual union all
select 3 as movie_id, 'Joker' as title from dual
),
users as (
select 1 as user_id, 'Daniel' as name from dual union all
select 2 as user_id, 'Monica' as name from dual union all
select 3 as user_id, 'Maria' as name from dual union all
select 4 as user_id, 'James' as name from dual
),
movie_rating as (
select 1 as movie_id, 1 as user_id, 3 as rating, to_date('2020-01-12','YYYY-MM-DD') as created_at from dual union all
select 1 as movie_id, 2 as user_id, 4 as rating, to_date('2020-02-11','YYYY-MM-DD') as created_at from dual union all
select 1 as movie_id, 3 as user_id, 2 as rating, to_date('2020-02-12','YYYY-MM-DD') as created_at from dual union all
select 1 as movie_id, 4 as user_id, 1 as rating, to_date('2020-01-01','YYYY-MM-DD') as created_at from dual union all
select 2 as movie_id, 1 as user_id, 5 as rating, to_date('2020-02-17','YYYY-MM-DD') as created_at from dual union all
select 2 as movie_id, 2 as user_id, 2 as rating, to_date('2020-02-01','YYYY-MM-DD') as created_at from dual union all
select 2 as movie_id, 3 as user_id, 2 as rating, to_date('2020-03-01','YYYY-MM-DD') as created_at from dual union all
select 3 as movie_id, 1 as user_id, 3 as rating, to_date('2020-02-22','YYYY-MM-DD') as created_at from dual union all
select 3 as movie_id, 2 as user_id, 4 as rating, to_date('2020-02-25','YYYY-MM-DD') as created_at from dual
)
select name from (select u.name, count(distinct m.movie_id) as rated from movie_rating m join users u on m.user_id = u.user_id group by u.name order by rated desc, name) where rownum = 1
union
select title as name from (select m.title, avg(rating) avgrating from movie_rating mr join movies m on m.movie_id = mr.movie_id where to_char(created_at, 'YYYY-MM') = '2020-02' group by m.title order by avgrating desc, m.title) where rownum = 1;


-- #1355 - Activity Participants - Find the names of all the activities with neither maximum, nor minimum number of participants
with friends as (
select 1 as id, 'Jonathan D.' as name, 'Eating' as activity from dual union all
select 2 as id, 'Jade W.' as name, 'Singing' as activity from dual union all
select 3 as id, 'Victor J.' as name, 'Singing' as activity from dual union all
select 4 as id, 'Elvis Q.' as name, 'Eating' as activity from dual union all
select 5 as id, 'Daniel A.' as name, 'Eating' as activity from dual union all
select 6 as id, 'Bob B.' as name, 'Horse Riding' as activity from dual
),
activities as (
select 1 as id, 'Eating' as name from dual union all
select 2 as id, 'Singing' as name from dual union all
select 3 as id, 'Horse Riding' as name from dual
)
select activity from (select activity, dense_rank() over (order by count(distinct id)) as max_participants, dense_rank() over (order by count(distinct id) desc) as min_participants from friends group by activity) where max_participants <> 1 and min_participants <> 1;


-- #1364 - Number of trusted contacts of a customer - Find for each Invoice_ID - invoice_id, customer_name, price, contacts_cnt, trusted_contacts_cnt
with customers as ( -- customers are trusted contacts
select 1 as customer_id, 'Alice' as customer_name, 'alice@leetcode.com' as email from dual union all
select 2 as customer_id, 'Bob' as customer_name, 'bob@leetcode.com' as email from dual union all
select 13 as customer_id, 'John' as customer_name, 'john@leetcode.com' as email from dual union all
select 6 as customer_id, 'Alex' as customer_name, 'alex@leetcode.com' as email from dual
),
contacts as ( -- contains each users contact
select 1 as user_id, 'Bob' as contact_name, 'bob@leetcode.com' as contact_email from dual union all
select 1 as user_id, 'John' as contact_name, 'john@leetcode.com' as contact_email from dual union all
select 1 as user_id, 'Jal' as contact_name, 'jal@leetcode.com' as contact_email from dual union all
select 2 as user_id, 'Omar' as contact_name, 'omar@leetcode.com' as contact_email from dual union all
select 2 as user_id, 'Meir' as contact_name, 'meir@leetcode.com' as contact_email from dual union all
select 6 as user_id, 'Alice' as contact_name, 'alice@leetcode.com' as contact_email from dual
), 
invoices as ( -- Each row of this table indicates that user_id has an invoice with invoice_id and a price.
select 77 as invoice_id, 100 as price, 1 as user_id from dual union all
select 88 as invoice_id, 200 as price, 1 as user_id from dual union all
select 99 as invoice_id, 300 as price, 2 as user_id from dual union all
select 66 as invoice_id, 400 as price, 2 as user_id from dual union all
select 55 as invoice_id, 500 as price, 13 as user_id from dual union all
select 44 as invoice_id, 60 as price, 6 as user_id from dual
)
select i.invoice_id, c.customer_name, i.price, count(distinct co.contact_email) as contacts_cnt, count(distinct c1.customer_id) as trusted_contacts_cnt
from invoices i join customers c on c.customer_id = i.user_id left join contacts co on co.user_id = i.user_id left join customers c1 on c1.customer_name = co.contact_name group by i.invoice_id, c.customer_name, i.price;


-- Open #1393 - Capital Gain/Loss - Report the Capital gain/loss for each stock - The capital gain/loss of a stock is total gain or loss after buying and selling the stock one or many times
with stocks as (
select 'Leetcode' as stock_name, 'Buy' as operation, 1 as operation_day, 1000 as price from dual union all
select 'Corona Masks' as stock_name, 'Buy' as operation, 2 as operation_day, 10 as price from dual union all
select 'Leetcode' as stock_name, 'Sell' as operation, 5 as operation_day, 9000 as price from dual union all
select 'Handbags' as stock_name, 'Buy' as operation, 17 as operation_day, 30000 as price from dual union all
select 'Corona Masks' as stock_name, 'Sell' as operation, 3 as operation_day, 1010 as price from dual union all
select 'Corona Masks' as stock_name, 'Buy' as operation, 4 as operation_day, 1000 as price from dual union all
select 'Corona Masks' as stock_name, 'Sell' as operation, 5 as operation_day, 500 as price from dual union all
select 'Corona Masks' as stock_name, 'Buy' as operation, 6 as operation_day, 1000 as price from dual union all
select 'Handbags' as stock_name, 'Sell' as operation, 29 as operation_day, 7000 as price from dual union all
select 'Corona Masks' as stock_name, 'Sell' as operation, 10 as operation_day, 10000 as price from dual
)
select stock_name, sum(case when operation = 'Sell' then price else -price end) as capital_gain_loss from stocks group by stock_name;


-- #1398 - Customers who bought product A and B but not C
with customers as (
select 1 as customer_id, 'Daniel' as customer_name from dual union all
select 2 as customer_id, 'Diana' as customer_name from dual union all
select 3 as customer_id, 'Elizabeth' as customer_name from dual union all
select 4 as customer_id, 'Jhon' as customer_name from dual
),
orders as (
select 10 as order_id, 1 as customer_id, 'A' as product_name from dual union all
select 20 as order_id, 1 as customer_id, 'B' as product_name from dual union all
select 30 as order_id, 1 as customer_id, 'D' as product_name from dual union all
select 40 as order_id, 1 as customer_id, 'C' as product_name from dual union all
select 50 as order_id, 2 as customer_id, 'A' as product_name from dual union all
select 60 as order_id, 3 as customer_id, 'A' as product_name from dual union all
select 70 as order_id, 3 as customer_id, 'B' as product_name from dual union all
select 80 as order_id, 3 as customer_id, 'D' as product_name from dual union all
select 90 as order_id, 4 as customer_id, 'C' as product_name from dual
)
select c.customer_name from orders o join customers c on c.customer_id = o.customer_id group by c.customer_name having sum(case when o.product_name = 'A' then 1 else 0 end) >= 1 and sum(case when o.product_name = 'B' then 1 else 0 end) >= 1 and sum(case when o.product_name = 'C' then 1 else 0 end) = 0;


-- #1440 - Evaluate Boolean Expression
with variables as (
select 'x' as name, 66 as value from dual union all
select 'y' as name, 77 as value from dual
),
expressions as (
select 'x' as left_operand, '>' as operator, 'y' as right_operand from dual union all
select 'x' as left_operand, '<' as operator, 'y' as right_operand from dual union all
select 'x' as left_operand, '=' as operator, 'y' as right_operand from dual union all
select 'y' as left_operand, '>' as operator, 'x' as right_operand from dual union all
select 'y' as left_operand, '<' as operator, 'x' as right_operand from dual union all
select 'x' as left_operand, '=' as operator, 'x' as right_operand from dual
)
select left_operand, operator, right_operand,
case operator 
when '=' then (case when left_value = right_value then 'true' else 'false' end) 
when '<' then (case when left_value < right_value then 'true' else 'false' end) 
when '>' then (case when left_value > right_value then 'true' else 'false' end) 
end as value
from (select left_operand, operator, right_operand, v1.value as left_value, v2.value as right_value from expressions e join variables v1 on e.left_operand = v1.name join variables v2 on e.right_operand = v2.name) order by left_operand;


-- #1445 - Apple and Oranges - Report the difference between number of apples and oranges sold each day
with sales as (
select to_date('2020-05-01','YYYY-MM-DD') as sale_date, 'apples' as fruit, 10 as sold_num from dual union all
select to_date('2020-05-01','YYYY-MM-DD') as sale_date, 'oranges' as fruit, 8 as sold_num from dual union all
select to_date('2020-05-02','YYYY-MM-DD') as sale_date, 'apples' as fruit, 15 as sold_num from dual union all
select to_date('2020-05-02','YYYY-MM-DD') as sale_date, 'oranges' as fruit, 15 as sold_num from dual union all
select to_date('2020-05-03','YYYY-MM-DD') as sale_date, 'apples' as fruit, 20 as sold_num from dual union all
select to_date('2020-05-03','YYYY-MM-DD') as sale_date, 'oranges' as fruit, 0 as sold_num from dual union all
select to_date('2020-05-04','YYYY-MM-DD') as sale_date, 'apples' as fruit, 15 as sold_num from dual union all
select to_date('2020-05-04','YYYY-MM-DD') as sale_date, 'oranges' as fruit, 16 as sold_num from dual
)
select sale_date, sum(case when fruit = 'apples' then sold_num else -sold_num end) as diff from sales group by sale_date order by sale_date;


-- #1454 - Active Users - Active users are those who logged in to their accounts for 5 or more consecutive days
with accounts as (
select 1 as id, 'Winston' as name from dual union all
select 7 as id, 'Jonathan' as name from dual
),
logins as (
select 7 as id, to_date('2020-05-30','YYYY-MM-DD') as login_date from dual union all
select 1 as id, to_date('2020-05-30','YYYY-MM-DD') as login_date from dual union all
select 7 as id, to_date('2020-05-31','YYYY-MM-DD') as login_date from dual union all
select 7 as id, to_date('2020-06-01','YYYY-MM-DD') as login_date from dual union all
select 7 as id, to_date('2020-06-02','YYYY-MM-DD') as login_date from dual union all
select 7 as id, to_date('2020-06-02','YYYY-MM-DD') as login_date from dual union all
select 7 as id, to_date('2020-06-03','YYYY-MM-DD') as login_date from dual union all
select 1 as id, to_date('2020-06-07','YYYY-MM-DD') as login_date from dual union all
select 7 as id, to_date('2020-06-10','YYYY-MM-DD') as login_date from dual
)
select name from 
(select id, login_date, login_date - dense_rank() over (partition by id order by login_date) as occurence from (select distinct id, login_date from logins)) s 
join accounts a on s.id = a.id group by name, occurence having count(*) >= 5;


-- #1459 - Rectangles Area
with points as (
select 1 as id, 2 as x_value, 8 as y_value from dual union all
select 2 as id, 4 as x_value, 7 as y_value from dual union all
select 3 as id, 2 as x_value, 10 as y_value from dual
)
select * from (select a.id as p1, b.id as p2, abs(a.x_value - b.x_value) * abs(a.y_value - b.y_value) as area from points a join points b on a.id <> b.id and a.id < b.id) where area > 0;


-- #1468 - Calculate Salaries - Find the salaries of the employees after applying taxes
-- 0% If the max salary of any employee in the company is less than 1000$
-- 24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive
-- 49% If the max salary of any employee in the company is greater than 10000$
with salaries as (
select 1 as company_id, 1 as employee_id, 'Tony' as employee_name, 2000 as salary from dual union all
select 1 as company_id, 2 as employee_id, 'Pronub' as employee_name, 21300 as salary from dual union all
select 1 as company_id, 3 as employee_id, 'Tyrrox' as employee_name, 10800 as salary from dual union all
select 2 as company_id, 1 as employee_id, 'Pam' as employee_name, 300 as salary from dual union all
select 2 as company_id, 7 as employee_id, 'Bassem' as employee_name, 450 as salary from dual union all
select 2 as company_id, 9 as employee_id, 'Hermione' as employee_name, 700 as salary from dual union all
select 3 as company_id, 7 as employee_id, 'Bocaben' as employee_name, 100 as salary from dual union all
select 3 as company_id, 2 as employee_id, 'Ognjen' as employee_name, 2200 as salary from dual union all
select 3 as company_id, 13 as employee_id, 'Nyancat' as employee_name, 3300 as salary from dual union all
select 3 as company_id, 15 as employee_id, 'Morninngcat' as employee_name, 7777 as salary from dual
)
select company_id, employee_id, employee_name, round(case
when maxsal < 1000 then salary * 1.0
when maxsal between 1000 and 10000 then salary * (1 - 0.24)
else salary * (1 - 0.49)
end,2) as salary
from (select company_id, employee_id, employee_name, salary, max(salary) over (partition by company_id) as maxsal from salaries);


-- #1501 - Countries you can safely invest in
-- A telecommunications company wants to invest in new countries. The company intends to invest in the countries where the average call duration of the calls in this country is strictly greater than the global average call duration
-- The average call duration for Peru is (102 + 102 + 330 + 330 + 5 + 5) / 6 = 145.666667
-- The average call duration for Israel is (33 + 4 + 13 + 13 + 3 + 1 + 1 + 7) / 8 = 9.37500
-- The average call duration for Morocco is (33 + 4 + 59 + 59 + 3 + 7) / 6 = 27.5000 
-- Global call duration average = (2 * (33 + 3 + 59 + 102 + 330 + 5 + 13 + 3 + 1 + 7)) / 20 = 55.70000
-- Since Peru is the only country where average call duration is greater than the global average, it's the only recommended country.
with person as (
select 3 as id, 'Jonathan' as name, '051-1234567' as phone_number from dual union all
select 12 as id, 'Elvis' as name, '051-7654321' as phone_number from dual union all
select 1 as id, 'Moncef' as name, '212-1234567' as phone_number from dual union all
select 2 as id, 'Maroua' as name, '212-6523651' as phone_number from dual union all
select 7 as id, 'Meir' as name, '972-1234567' as phone_number from dual union all
select 9 as id, 'Rachel' as name, '972-0011100' as phone_number from dual
),
country as (
select 'Peru' as name, '051' as country_code from dual union all
select 'Israel' as name, '972' as country_code from dual union all
select 'Morocco' as name, '212' as country_code from dual union all
select 'Germany' as name, '049' as country_code from dual union all
select 'Ethiopia' as name, '251' as country_code from dual
),
calls as (
select 1 as caller_id, 9 as callee_id, 33 as duration from dual union all
select 2 as caller_id, 9 as callee_id, 4 as duration from dual union all
select 1 as caller_id, 2 as callee_id, 59 as duration from dual union all
select 3 as caller_id, 12 as callee_id, 102 as duration from dual union all
select 3 as caller_id, 12 as callee_id, 330 as duration from dual union all
select 12 as caller_id, 3 as callee_id, 5 as duration from dual union all
select 7 as caller_id, 9 as callee_id, 13 as duration from dual union all
select 7 as caller_id, 1 as callee_id, 3 as duration from dual union all
select 9 as caller_id, 7 as callee_id, 1 as duration from dual union all
select 1 as caller_id, 7 as callee_id, 7 as duration from dual
)
select c.name from
(select caller_id, callee_id, duration from calls union select callee_id as caller_id, caller_id as callee_id, duration from calls) s
join person p on p.id = s.caller_id join country c on substr(p.phone_number, 1,3) = c.country_code
group by c.name having avg(s.duration) > (select avg(duration) from calls);


-- #1532 - The most recent 3 orders - Find the most recent 3 orders of each user. If a user ordered less than 3 orders return all of their orders
with customers as (
select 1 as customer_id, 'Winston' as name from dual union all
select 2 as customer_id, 'Jonathan' as name from dual union all
select 3 as customer_id, 'Annabelle' as name from dual union all
select 4 as customer_id, 'Marwan' as name from dual union all
select 5 as customer_id, 'Khaled' as name from dual
),
orders as (
select 1 as order_id, to_date('2020-07-31','YYYY-MM-DD') as order_date, 1 as customer_id, 30 as cost from dual union all
select 2 as order_id, to_date('2020-07-30','YYYY-MM-DD') as order_date, 2 as customer_id, 40 as cost from dual union all
select 3 as order_id, to_date('2020-07-31','YYYY-MM-DD') as order_date, 3 as customer_id, 70 as cost from dual union all
select 4 as order_id, to_date('2020-07-29','YYYY-MM-DD') as order_date, 4 as customer_id, 100 as cost from dual union all
select 5 as order_id, to_date('2020-06-10','YYYY-MM-DD') as order_date, 1 as customer_id, 1010 as cost from dual union all
select 6 as order_id, to_date('2020-08-01','YYYY-MM-DD') as order_date, 2 as customer_id, 102 as cost from dual union all
select 7 as order_id, to_date('2020-08-01','YYYY-MM-DD') as order_date, 3 as customer_id, 111 as cost from dual union all
select 8 as order_id, to_date('2020-08-03','YYYY-MM-DD') as order_date, 1 as customer_id, 99 as cost from dual union all
select 9 as order_id, to_date('2020-08-07','YYYY-MM-DD') as order_date, 2 as customer_id, 32 as cost from dual union all
select 10 as order_id, to_date('2020-07-15','YYYY-MM-DD') as order_date, 1 as customer_id, 2 as cost from dual
)
select name, customer_id, order_id, order_date from (
select c.name, o.customer_id, o.order_id, o.order_date, dense_rank() over (partition by o.customer_id order by o.order_date desc) as order_seq from orders o join customers c on c.customer_id = o.customer_id) where order_seq <= 3 order by name, customer_id, order_date desc;


-- #1549 - The most recent orders for each product
with customers as (
select 1 as customer_id, 'Winston' as name from dual union all
select 2 as customer_id, 'Jonathan' as name from dual union all
select 3 as customer_id, 'Annabelle' as name from dual union all
select 4 as customer_id, 'Marwan' as name from dual union all
select 5 as customer_id, 'Khaled' as name from dual
),
orders as (
select 1 as order_id, to_date('2020-07-31','YYYY-MM-DD') as order_date, 1 as customer_id, 1 as product_id from dual union all
select 2 as order_id, to_date('2020-07-30','YYYY-MM-DD') as order_date, 2 as customer_id, 2 as product_id from dual union all
select 3 as order_id, to_date('2020-08-29','YYYY-MM-DD') as order_date, 3 as customer_id, 3 as product_id from dual union all
select 4 as order_id, to_date('2020-07-29','YYYY-MM-DD') as order_date, 4 as customer_id, 1 as product_id from dual union all
select 5 as order_id, to_date('2020-06-10','YYYY-MM-DD') as order_date, 1 as customer_id, 2 as product_id from dual union all
select 6 as order_id, to_date('2020-08-01','YYYY-MM-DD') as order_date, 2 as customer_id, 1 as product_id from dual union all
select 7 as order_id, to_date('2020-08-01','YYYY-MM-DD') as order_date, 3 as customer_id, 1 as product_id from dual union all
select 8 as order_id, to_date('2020-08-03','YYYY-MM-DD') as order_date, 1 as customer_id, 2 as product_id from dual union all
select 9 as order_id, to_date('2020-08-07','YYYY-MM-DD') as order_date, 2 as customer_id, 3 as product_id from dual union all
select 10 as order_id, to_date('2020-07-15','YYYY-MM-DD') as order_date, 1 as customer_id, 2 as product_id from dual
),
products as (
select 1 as product_id, 'keyboard' as product_name, 120 as price from dual union all
select 2 as product_id, 'mouse' as product_name, 80 as price from dual union all
select 3 as product_id, 'screen' as product_name, 600 as price from dual union all
select 4 as product_id, 'hard disk' as product_name, 450 as price from dual
)
select p.product_name, s.product_id, s.order_id, s.order_date from (
select product_id, order_id, order_date, dense_rank() over (partition by product_id order by order_date desc) as seq from orders) s
join products p on p.product_id = s.product_id where seq = 1;


-- #1555 - Bank Account Summary - Find out the current balance of all users and check wheter they have breached their credit limit (If their current credit is less than 0)
with users as (
select 1 as user_id, 'Moustafa' as user_name, 100 as credit from dual union all
select 2 as user_id, 'Jonathan' as user_name, 200 as credit from dual union all
select 3 as user_id, 'Winston' as user_name, 10000 as credit from dual union all
select 4 as user_id, 'Luis' as user_name, 800 as credit from dual
),
transactions as (
select 1 as trans_id, 1 as paid_by, 3 as paid_to, 400 as amount, to_date('2020-08-01','YYYY-MM-DD') as transacted_on from dual union all
select 2 as trans_id, 3 as paid_by, 2 as paid_to, 500 as amount, to_date('2020-08-02','YYYY-MM-DD') as transacted_on from dual union all
select 3 as trans_id, 2 as paid_by, 1 as paid_to, 200 as amount, to_date('2020-08-03','YYYY-MM-DD') as transacted_on from dual
)
select u.user_id, u.user_name, credit + nvl(bal,0) as credit, case when credit + nvl(bal,0) < 0 then 'Yes' else 'No' end as credit_limit_breached 
from users u join (select u.user_id, sum(-t1.amount + t2.amount) as bal from users u left join transactions t1 on u.user_id = t1.paid_by left join transactions t2 on u.user_id = t2.paid_to group by u.user_id) s on u.user_id = s.user_id;


-- #1596 - The most frequently ordered products for each customer
--Alice (customer 1) ordered the mouse three times and the keyboard one time, so the mouse is the most frquently ordered product for them.
--Bob (customer 2) ordered the keyboard, the mouse, and the screen one time, so those are the most frquently ordered products for them.
with customers as (
select 1 as customer_id, 'Alice' as name from dual union all
select 2 as customer_id, 'Bob' as name from dual union all
select 3 as customer_id, 'Tom' as name from dual union all
select 4 as customer_id, 'Jerry' as name from dual union all
select 5 as customer_id, 'John' as name from dual
),
orders as (
select 1 as order_id, to_date('2020-07-31','YYYY-MM-DD') as order_date, 1 as customer_id, 1 as product_id from dual union all
select 2 as order_id, to_date('2020-07-30','YYYY-MM-DD') as order_date, 2 as customer_id, 2 as product_id from dual union all
select 3 as order_id, to_date('2020-08-29','YYYY-MM-DD') as order_date, 3 as customer_id, 3 as product_id from dual union all
select 4 as order_id, to_date('2020-07-29','YYYY-MM-DD') as order_date, 4 as customer_id, 1 as product_id from dual union all
select 5 as order_id, to_date('2020-06-10','YYYY-MM-DD') as order_date, 1 as customer_id, 2 as product_id from dual union all
select 6 as order_id, to_date('2020-08-01','YYYY-MM-DD') as order_date, 2 as customer_id, 1 as product_id from dual union all
select 7 as order_id, to_date('2020-08-01','YYYY-MM-DD') as order_date, 3 as customer_id, 3 as product_id from dual union all
select 8 as order_id, to_date('2020-08-03','YYYY-MM-DD') as order_date, 1 as customer_id, 2 as product_id from dual union all
select 9 as order_id, to_date('2020-08-07','YYYY-MM-DD') as order_date, 2 as customer_id, 3 as product_id from dual union all
select 10 as order_id, to_date('2020-07-15','YYYY-MM-DD') as order_date, 1 as customer_id, 2 as product_id from dual
),
products as (
select 1 as product_id, 'keyboard' as product_name, 120 as price from dual union all
select 2 as product_id, 'mouse' as product_name, 80 as price from dual union all
select 3 as product_id, 'screen' as product_name, 600 as price from dual union all
select 4 as product_id, 'hard disk' as product_name, 450 as price from dual
)
select s.customer_id, s.product_id, p.product_name from (select customer_id, product_id, dense_rank() over(partition by customer_id order by count(product_id) desc) as freq from orders group by customer_id, product_id order by customer_id) s
join products p on p.product_id = s.product_id where s.freq = 1;


-- #1613 - Find the missing ID
with customers as (
select 1 as customer_id, 'Alice' as customer_name from dual union all
select 4 as customer_id, 'Bob' as customer_name from dual union all
select 5 as customer_id, 'Charlie' as customer_name from dual
)
select id from (
select level as id from dual where level >= (select min(customer_id) from customers) connect by level <= (select max(customer_id) from customers)) where id not in (select customer_id from customers) order by id;


-- #1699 - Number of calls between two persons - Report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2
with calls as (
select 1 as from_id, 2 as to_id, 59 as duration from dual union all
select 2 as from_id, 1 as to_id, 11 as duration from dual union all
select 1 as from_id, 3 as to_id, 20 as duration from dual union all
select 3 as from_id, 4 as to_id, 100 as duration from dual union all
select 3 as from_id, 4 as to_id, 200 as duration from dual union all
select 3 as from_id, 4 as to_id, 200 as duration from dual union all
select 4 as from_id, 3 as to_id, 499 as duration from dual
)
select from_id as person1, to_id as person2, count(duration) as call_count, sum(duration) as total_duration from (select from_id, to_id, duration from calls union all select to_id as from_id, from_id as to_id, duration from calls)
where from_id < to_id group by from_id, to_id;


-- #1709 - Biggest window between visits. Assume today is 2021-01-01
with ubervisits as (
select 1 as user_id, to_date('2020-11-28','YYYY-MM-DD') as visit_date from dual union all
select 1 as user_id, to_date('2020-10-20','YYYY-MM-DD') as visit_date from dual union all
select 1 as user_id, to_date('2020-12-03','YYYY-MM-DD') as visit_date from dual union all
select 2 as user_id, to_date('2020-10-05','YYYY-MM-DD') as visit_date from dual union all
select 2 as user_id, to_date('2020-12-09','YYYY-MM-DD') as visit_date from dual union all
select 3 as user_id, to_date('2020-11-11','YYYY-MM-DD') as visit_date from dual
)
select user_id, max(delta) as biggest_window from (select user_id, nvl(lead(visit_date) over (partition by user_id order by visit_date),to_date('2021-01-01','YYYY-MM-DD')) - visit_date as delta from ubervisits) group by user_id;


-- #1715 - Count Apple and Oranges - Count the number of Apples and oranges we have in the boxes. If a box contains a chest, you should also include the number of apples and oranges it has
-- Each box may contain a chest, which also can contain oranges and apples
with boxes as (
select 2 as box_id, null as chest_id, 6 as apple_count, 15 as orange_count from dual union all
select 18 as box_id, 14 as chest_id, 4 as apple_count, 15 as orange_count from dual union all
select 19 as box_id, 3 as chest_id, 8 as apple_count, 4 as orange_count from dual union all
select 12 as box_id, 2 as chest_id, 19 as apple_count, 20 as orange_count from dual union all
select 20 as box_id, 6 as chest_id, 12 as apple_count, 9 as orange_count from dual union all
select 8 as box_id, 6 as chest_id, 9 as apple_count, 9 as orange_count from dual union all
select 3 as box_id, 14 as chest_id, 16 as apple_count, 7 as orange_count from dual
),
chests as (
select 6 as chest_id, 5 as apple_count, 6 as orange_count from dual union all
select 14 as chest_id, 20 as apple_count, 10 as orange_count from dual union all
select 2 as chest_id, 8 as apple_count, 8 as orange_count from dual union all
select 3 as chest_id, 19 as apple_count, 4 as orange_count from dual union all
select 16 as chest_id, 19 as apple_count, 19 as orange_count from dual
)
select sum(b.apple_count) + sum(c.apple_count) as apple_count, sum(b.orange_count) + sum(c.orange_count) as orange_count from boxes b left join chests c on b.chest_id = c.chest_id;


-- #1747 - Leetflex banned accounts - An account should be banned if it was logged in at some moment from two different IP addresses
with loginfo as (
select 1 as account_id, 1 as ip_address, to_date('2021-02-01 09:00:00','YYYY-MM-DD HH24:MI:SS') as login, to_date('2021-02-01 09:30:00','YYYY-MM-DD HH24:MI:SS') as logout from dual union all
select 1 as account_id, 2 as ip_address, to_date('2021-02-01 08:00:00','YYYY-MM-DD HH24:MI:SS') as login, to_date('2021-02-01 11:30:00','YYYY-MM-DD HH24:MI:SS') as logout from dual union all
select 2 as account_id, 6 as ip_address, to_date('2021-02-01 20:30:00','YYYY-MM-DD HH24:MI:SS') as login, to_date('2021-02-01 22:00:00','YYYY-MM-DD HH24:MI:SS') as logout from dual union all
select 2 as account_id, 7 as ip_address, to_date('2021-02-02 20:30:00','YYYY-MM-DD HH24:MI:SS') as login, to_date('2021-02-02 22:00:00','YYYY-MM-DD HH24:MI:SS') as logout from dual union all
select 3 as account_id, 9 as ip_address, to_date('2021-02-01 16:00:00','YYYY-MM-DD HH24:MI:SS') as login, to_date('2021-02-01 16:59:59','YYYY-MM-DD HH24:MI:SS') as logout from dual union all
select 3 as account_id, 13 as ip_address, to_date('2021-02-01 17:00:00','YYYY-MM-DD HH24:MI:SS') as login, to_date('2021-02-01 17:59:59','YYYY-MM-DD HH24:MI:SS') as logout from dual union all
select 4 as account_id, 10 as ip_address, to_date('2021-02-01 16:00:00','YYYY-MM-DD HH24:MI:SS') as login, to_date('2021-02-01 17:00:00','YYYY-MM-DD HH24:MI:SS') as logout from dual union all
select 4 as account_id, 11 as ip_address, to_date('2021-02-01 17:00:00','YYYY-MM-DD HH24:MI:SS') as login, to_date('2021-02-01 17:59:59','YYYY-MM-DD HH24:MI:SS') as logout from dual
)
select distinct a.account_id from loginfo a join loginfo b on a.account_id = b.account_id and a.ip_address <> b.ip_address and (a.login between b.login and b.logout or b.login between a.login and a.logout);


-- #1783 - Grand Slam titles - Report the number of grand slam tournaments won by each player. Do not include the players who did not win any tournament.
with players as (
select 1 as player_id, 'Nadal' as player_name from dual union all
select 2 as player_id, 'Federer' as player_name from dual union all
select 3 as player_id, 'Novak' as player_name from dual
),
championships as (
select 2018 as year, 1 as Wimbledon, 1 as Fr_open, 1 as US_open, 1 as Au_open from dual union all
select 2019 as year, 1 as Wimbledon, 1 as Fr_open, 2 as US_open, 2 as Au_open from dual union all
select 2020 as year, 2 as Wimbledon, 1 as Fr_open, 2 as US_open, 2 as Au_open from dual
)
select player_id, player_name, 
sum(
case when Wimbledon = player_id then 1 else 0 end + 
case when Fr_open = player_id then 1 else 0 end + 
case when US_open = player_id then 1 else 0 end + 
case when Au_open = player_id then 1 else 0 end
) as grand_slams_count 
from players join championships on (player_id = Wimbledon or player_id = Fr_open or player_id = US_open or player_id = Au_open) group by player_id, player_name;


-- #1811 - Find Interview Candidates - Report the name and the mail of all interview candidates. A user is an interview candidate if at least one of these two conditions is true
-- 1. The user won any medal in three or more consecutive contests
-- 2. The user won the gold medal in three or more different contests (not necessarily consecutive)
with contests as (
select 190 as contest_id, 1 as gold_medal, 5 as silver_medal, 2 as bronze_medal from dual union all
select 191 as contest_id, 2 as gold_medal, 3 as silver_medal, 5 as bronze_medal from dual union all
select 192 as contest_id, 5 as gold_medal, 2 as silver_medal, 3 as bronze_medal from dual union all
select 193 as contest_id, 1 as gold_medal, 3 as silver_medal, 5 as bronze_medal from dual union all
select 194 as contest_id, 4 as gold_medal, 5 as silver_medal, 2 as bronze_medal from dual union all
select 195 as contest_id, 4 as gold_medal, 2 as silver_medal, 1 as bronze_medal from dual union all
select 196 as contest_id, 1 as gold_medal, 5 as silver_medal, 2 as bronze_medal from dual
),
users as (
select 1 as user_id, 'sarah@leetcode.com' as mail, 'Sarah' as name from dual union all
select 2 as user_id, 'bob@leetcode.com' as mail, 'Bob' as name from dual union all
select 3 as user_id, 'alice@leetcode.com' as mail, 'Alice' as name from dual union all
select 4 as user_id, 'hercy@leetcode.com' as mail, 'Hercy' as name from dual union all
select 5 as user_id, 'quarz@leetcode.com' as mail, 'Quarz' as name from dual
),
contest_medal as (
select * from contests unpivot (winner for medal in (gold_medal as 'GOLD', silver_medal as 'SILVER', bronze_medal as 'BRONZE'))
)
select * from contest_medal a join contest_medal b on a.contest_id = b.contest_id - 1 and a.medal = b.medal join contest_medal c on a.contest_id = c.contest_id - 2 and a.medal = c.medal and b.contest_id = c.contest_id - 1 and b.medal = c.medal ;


-- #1831 - Maximum transaction each day - Report TransactionID with maximum amount each day
with transactions as (
select 8 as transaction_id, to_date('2021-04-03 15:57:28','YYYY-MM-DD HH24:MI:SS') as day, 57 as amount from dual union all
select 9 as transaction_id, to_date('2021-04-28 08:47:25','YYYY-MM-DD HH24:MI:SS') as day, 21 as amount from dual union all
select 1 as transaction_id, to_date('2021-04-29 13:28:30','YYYY-MM-DD HH24:MI:SS') as day, 58 as amount from dual union all
select 5 as transaction_id, to_date('2021-04-28 16:39:59','YYYY-MM-DD HH24:MI:SS') as day, 40 as amount from dual union all
select 6 as transaction_id, to_date('2021-04-29 23:39:28','YYYY-MM-DD HH24:MI:SS') as day, 58 as amount from dual
)
select transaction_id from (
select transaction_id, day, amount, dense_rank() over (partition by to_char(day,'YYYY-MM-DD') order by amount desc) as rn from transactions order by day) where rn = 1 order by transaction_id;


-- #1841 - League Statistics
-- The winning team gets three points and the losing team gets no points. If a match ends with a draw, both teams get one point
-- Each row of the result table should contain:
--    team_name - The name of the team in the Teams table.
--    matches_played - The number of matches played as either a home or away team.
--    points - The total points the team has so far.
--    goal_for - The total number of goals scored by the team across all matches.
--    goal_against - The total number of goals scored by opponent teams against this team across all matches.
--    goal_diff - The result of goal_for - goal_against.

with teams as (
select 1 as team_id, 'Ajax' as team_name from dual union all
select 4 as team_id, 'Dortmund' as team_name from dual union all
select 6 as team_id, 'Arsenal' as team_name from dual
),
matches as (
select 1 as home_team_id, 4 as away_team_id, 0 as home_team_goals, 1 as away_team_goals from dual union all
select 1 as home_team_id, 6 as away_team_id, 3 as home_team_goals, 3 as away_team_goals from dual union all
select 4 as home_team_id, 1 as away_team_id, 5 as home_team_goals, 2 as away_team_goals from dual union all
select 6 as home_team_id, 1 as away_team_id, 0 as home_team_goals, 0 as away_team_goals from dual
)
select t.team_name, count(*) as macthes_played, sum(case when home_team_goals = away_team_goals then 1 when home_team_goals > away_team_goals then 3 else 0 end) as points, sum(home_team_goals) as goal_for, sum(away_team_goals) as goal_against, (sum(home_team_goals)-sum(away_team_goals)) as goal_diff
from (select home_team_id, away_team_id, home_team_goals, away_team_goals from matches union select away_team_id as home_team_id, home_team_id as away_team_id, away_team_goals as home_team_goals, home_team_goals as away_team_goals from matches) s join teams t on t.team_id = s.home_team_id
group by t.team_name order by t.team_name desc;


-- #1843 - Suspicious Bank - A bank account is suspicious if the total income exceeds the max_income for this account for two or more consecutive months.
-- The total income of an account in some month is the sum of all its deposits in that month (i.e., transactions of the type 'Creditor')
with accounts as (
select 3 as account_id, 21000 as max_income from dual union all
select 4 as account_id, 10400 as max_income from dual
),
transactions as (
select 2 as transaction_id, 3 as account_id, 'Creditor' as type, 107100 as amount, to_date('2021-06-02 11:38:14','YYYY-MM-DD HH24:MI:SS') as day from dual union all
select 4 as transaction_id, 4 as account_id, 'Creditor' as type, 10400 as amount, to_date('2021-06-20 12:39:18','YYYY-MM-DD HH24:MI:SS') as day from dual union all
select 11 as transaction_id, 4 as account_id, 'Debtor' as type, 58800 as amount, to_date('2021-07-23 12:41:55','YYYY-MM-DD HH24:MI:SS') as day from dual union all
select 1 as transaction_id, 4 as account_id, 'Creditor' as type, 49300 as amount, to_date('2021-05-03 16:11:04','YYYY-MM-DD HH24:MI:SS') as day from dual union all
select 15 as transaction_id, 3 as account_id, 'Debtor' as type, 75500 as amount, to_date('2021-05-23 14:40:20','YYYY-MM-DD HH24:MI:SS') as day from dual union all
select 10 as transaction_id, 3 as account_id, 'Creditor' as type, 102100 as amount, to_date('2021-06-15 10:37:16','YYYY-MM-DD HH24:MI:SS') as day from dual union all
select 14 as transaction_id, 4 as account_id, 'Creditor' as type, 56300 as amount, to_date('2021-07-21 12:12:25','YYYY-MM-DD HH24:MI:SS') as day from dual union all
select 19 as transaction_id, 4 as account_id, 'Debtor' as type, 101100 as amount, to_date('2021-05-09 15:21:49','YYYY-MM-DD HH24:MI:SS') as day from dual union all
select 8 as transaction_id, 3 as account_id, 'Creditor' as type, 64900 as amount, to_date('2021-07-26 15:09:56','YYYY-MM-DD HH24:MI:SS') as day from dual union all
select 7 as transaction_id, 3 as account_id, 'Creditor' as type, 90900 as amount, to_date('2021-06-14 11:23:07','YYYY-MM-DD HH24:MI:SS') as day from dual
)
select account_id from (
select s.account_id, a.max_income, s.year_month as current_month, lead(s.year_month) over (partition by s.account_id order by s.year_month) as next_month, s.received as current_month_received, lead(s.received) over (partition by s.account_id order by year_month) as next_month_received
from (select account_id, to_char(day,'YYYY-MM') as year_month, sum(amount) as received from transactions where type = 'Creditor' group by account_id, to_char(day,'YYYY-MM')) s join accounts a on a.account_id = s.account_id
) where current_month_received > max_income and next_month_received > max_income;


-- #1867 - Orders with maximum quantity above average of individual order
with order_detail as (
select 1 as order_id, 1 as product_id, 12 as quantity from dual union all
select 1 as order_id, 2 as product_id, 10 as quantity from dual union all
select 1 as order_id, 3 as product_id, 15 as quantity from dual union all
select 2 as order_id, 1 as product_id, 8 as quantity from dual union all
select 2 as order_id, 4 as product_id, 4 as quantity from dual union all
select 2 as order_id, 5 as product_id, 6 as quantity from dual union all
select 3 as order_id, 3 as product_id, 5 as quantity from dual union all
select 3 as order_id, 4 as product_id, 18 as quantity from dual union all
select 4 as order_id, 5 as product_id, 2 as quantity from dual union all
select 4 as order_id, 6 as product_id, 8 as quantity from dual union all
select 5 as order_id, 7 as product_id, 9 as quantity from dual union all
select 5 as order_id, 8 as product_id, 9 as quantity from dual union all
select 3 as order_id, 9 as product_id, 20 as quantity from dual union all
select 2 as order_id, 9 as product_id, 4 as quantity from dual
)
select order_id from order_detail group by order_id having max(quantity) > all (select avg(quantity) from order_detail group by order_id);


-- #1875 - Group Employees of Same Salary - Devide in team where All members on each team have same salary
-- Each team should consist of at least two employees
-- All the employees on a team should have the same salary
-- All the employees of the same salary should be assigned to the same team
-- If the salary of an employee is unique, we do not assign this employee to any team
-- A team’s ID is assigned based on the rank of the team’s salary relative to the other teams’ salaries, where the team with the lowest salary has team_id = 1
with employees as (
select 2 as employee_id, 'Meir' as name, 3000 as salary from dual union all
select 3 as employee_id, 'Michael' as name, 3000 as salary from dual union all
select 7 as employee_id, 'Addilyn' as name, 7400 as salary from dual union all
select 8 as employee_id, 'Juan' as name, 6100 as salary from dual union all
select 9 as employee_id, 'Kannon' as name, 7400 as salary from dual
)
select employee_id, name, salary, dense_rank() over (order by salary) as team_id 
from (select employee_id, name, salary, count(*) over (partition by salary) as group_count from employees) where group_count > 1 order by team_id, employee_id;


-- #1907 - Count Salary Categories
with accounts as (
select 3 as account_id, 108939 as income from dual union all
select 2 as account_id, 12747 as income from dual union all
select 8 as account_id, 87709 as income from dual union all
select 6 as account_id, 91796 as income from dual
)
select 'Low Salary' as category, count(*) as accounts_count from accounts where income < 20000
union
select 'Average Salary' as category, count(*) as accounts_count from accounts where income between 20000 and 50000
union
select 'High Salary' as category, count(*) as accounts_count from accounts where income > 50000;


-- #1934 - Confirmation Rate for each User - The confirmation rate of a user is the number of ‘confirmed’ messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0
with signups as (
select 3 as user_id, to_date('2020-03-21 10:16:13', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 7 as user_id, to_date('2020-01-04 13:57:59', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 2 as user_id, to_date('2020-07-29 23:09:44', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 6 as user_id, to_date('2020-12-09 10:39:37', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual
),
confirmations as (
select 3 as user_id, to_date('2021-01-06 03:30:46', 'YYYY-MM-DD HH24:MI:SS') as time_stamp, 'timeout' as action from dual union all
select 3 as user_id, to_date('2021-07-14 14:00:00', 'YYYY-MM-DD HH24:MI:SS') as time_stamp, 'timeout' as action from dual union all
select 7 as user_id, to_date('2021-06-12 11:57:29', 'YYYY-MM-DD HH24:MI:SS') as time_stamp, 'confirmed' as action from dual union all
select 7 as user_id, to_date('2021-06-13 12:58:28', 'YYYY-MM-DD HH24:MI:SS') as time_stamp, 'confirmed' as action from dual union all
select 7 as user_id, to_date('2021-06-14 13:59:27', 'YYYY-MM-DD HH24:MI:SS') as time_stamp, 'confirmed' as action from dual union all
select 2 as user_id, to_date('2021-01-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS') as time_stamp, 'confirmed' as action from dual union all
select 2 as user_id, to_date('2021-02-28 23:59:59', 'YYYY-MM-DD HH24:MI:SS') as time_stamp, 'timeout' as action from dual
)
select s.user_id, round(sum(case when c.action = 'confirmed' then 1 else 0 end)/count(*),2) as confirmation_rate from signups s left join confirmations c on c.user_id = s.user_id group by s.user_id;


-- #1949 - Strong Friendship - A friendship between a pair of friends x and y is strong if x and y have at least three common friends
with friendship as (
select 1 as user1_id, 2 as user2_id from dual union all
select 1 as user1_id, 3 as user2_id from dual union all
select 2 as user1_id, 3 as user2_id from dual union all
select 1 as user1_id, 4 as user2_id from dual union all
select 2 as user1_id, 4 as user2_id from dual union all
select 1 as user1_id, 5 as user2_id from dual union all
select 2 as user1_id, 5 as user2_id from dual union all
select 1 as user1_id, 7 as user2_id from dual union all
select 3 as user1_id, 7 as user2_id from dual union all
select 1 as user1_id, 6 as user2_id from dual union all
select 3 as user1_id, 6 as user2_id from dual union all
select 2 as user1_id, 6 as user2_id from dual
),
friends as (
select user1_id, user2_id from friendship union select user2_id as user1_id, user1_id as user2_id from friendship
)
select f1.user1_id, f2.user1_id as user2_id, count(f1.user2_id) as common_friend
from friends f1 join friends f2 on f1.user2_id = f2.user2_id where f1.user1_id < f2.user1_id and (f1.user1_id, f2.user1_id) in (select user1_id, user2_id from friendship)
group by f1.user1_id, f2.user1_id
having count(f2.user2_id)>=3;


-- #1951 - All the pairs with maximum number of common followers
with relations as (
select 1 user_id, 3 as follower_id from dual union all
select 2 user_id, 3 as follower_id from dual union all
select 7 user_id, 3 as follower_id from dual union all
select 1 user_id, 4 as follower_id from dual union all
select 2 user_id, 4 as follower_id from dual union all
select 7 user_id, 4 as follower_id from dual union all
select 1 user_id, 5 as follower_id from dual union all
select 2 user_id, 6 as follower_id from dual union all
select 7 user_id, 5 as follower_id from dual
)
select user1_id, user2_id from (
select a.user_id as user1_id, b.user_id as user2_id, dense_rank() over (order by count(*) desc) as rn
from relations a join relations b on a.user_id < b.user_id and a.follower_id = b.follower_id group by a.user_id, b.user_id) where rn = 1;


-- #1988 - Find cutoff score for each school
with school as (
select 11 as school_id, 151 as capacity from dual union all
select 5 as school_id, 48 as capacity from dual union all
select 9 as school_id, 9 as capacity from dual union all
select 10 as school_id, 99 as capacity from dual
),
exam as (
select 975 as score, 10 as student_count from dual union all
select 966 as score, 60 as student_count from dual union all
select 844 as score, 76 as student_count from dual union all
select 749 as score, 76 as student_count from dual union all
select 744 as score, 100 as student_count from dual
)
select school_id, nvl(score,-1) as score from (
select school_id, capacity, score, student_count, dense_rank() over (partition by school_id order by max(student_count) desc, score) as best_fit from school left join exam on student_count < capacity group by school_id, capacity, score, student_count)
where best_fit = 1;


-- #1990 - Count the number of experiments
with experiments as (
select 4 as experiment_id, 'IOS' as platform, 'Programming' as experiment_name from dual union all
select 13 as experiment_id, 'IOS' as platform, 'Sports' as experiment_name from dual union all
select 14 as experiment_id, 'Android' as platform, 'Reading' as experiment_name from dual union all
select 8 as experiment_id, 'Web' as platform, 'Reading' as experiment_name from dual union all
select 12 as experiment_id, 'Web' as platform, 'Reading' as experiment_name from dual union all
select 18 as experiment_id, 'Web' as platform, 'Programming' as experiment_name from dual
)
select a.platform, b.experiment_name, count(distinct experiment_id) as num_experiments from 
(select distinct platform from experiments) a cross join (select distinct experiment_name from experiments) b left join experiments c on a.platform = c.platform and b.experiment_name = c.experiment_name
group by a.platform, b.experiment_name order by 1;


-- #2020 - Number of accounts that did not stream
-- #2041 - Accepted candidates for the interview
-- #2051 - The category of each member in the store
-- #2066 - Account Balance
-- #2048 - Drop Type 1 Orders for Customers with Type 0 Orders
-- #2112 - The airport with the most traffic
-- #2142 - The number of passanger in each bus I
-- #2159 - Order two columns idependently
-- #2175 - The change in Global Ranking
-- #2228 - Users with two purchases with 7 days
-- #2238 - Number of times the driver was a passanger
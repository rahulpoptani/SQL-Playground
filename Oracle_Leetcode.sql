-- # Leetcode Easy

-- #175 - Combine Two Tables
with person as (
select 1 as personId, 'Wang' as lastName, 'Allen' as firstName from dual union all
select 2 as personId, 'Alice' as lastName, 'Bob' as firstName from dual
),
address as (
select 1 as addressId, 2 as personId, 'New York City' as city, 'New York' as state from dual union all
select 2 as addressId, 3 as personId, 'Los Angeles' as city, 'California' as state from dual
)
select p.firstName, p.lastName, d.city, d.state from person p left join address d on p.personId = d.personId;


-- #181 - Employees earning more than their Managers
with employee as (
select 1 as id, 'Joe' as name, 70000 as salary, 3 as managerId from dual union all
select 2 as id, 'Henry' as name, 80000 as salary, 4 as managerId from dual union all
select 3 as id, 'Sam' as name, 60000 as salary, null as managerId from dual union all
select 4 as id, 'Max' as name, 90000 as salary, null as managerId from dual
)
select e1.name as Employee from employee e1 join employee e2 on e1.managerId = e2.id and e1.salary > e2.salary;


-- #182 - Duplicate email
with person as (
select 1 as id, 'a@b.com' as email from dual union all
select 2 as id, 'c@b.com' as email from dual union all
select 3 as id, 'a@b.com' as email from dual
)
select email from person group by email having count(*) > 1;


-- #183 - Customers who never Order
with customers as (
select 1 as id, 'Joe' as name from dual union all
select 2 as id, 'Henry' as name from dual union all
select 3 as id, 'Sam' as name from dual union all
select 4 as id, 'Max' as name from dual
),
orders as (
select 1 as id, 3 as customerId from dual union all
select 2 as id, 1 as customerId from dual
)
select c.name as customers from customers c where not exists (select 1 from orders o where o.customerId = c.id);
--select name as customers from customers where id not in (select customerId from orders);
--select c.name as customers from customers c left join orders o on o.customerId = c.id where o.customerId is null;


-- #196 - Delete duplicate Emails - Keep only one unique email with minimum id.
drop table person;
create table person as
select 1 id, 'john@example.com' email from dual union all
select 2 id, 'bob@example.com' email from dual union all
select 3 id, 'john@example.com' email from dual;
select * from person;
delete from person where id not in (select min(id) from person group by email);
delete from person where id in (select p1.id from person p1 join person p2 on p1.email = p2.email and p1.id > p2.id);


-- #197 - Rising Temperature - higher temperature compare to previous day
with weather as (
select 1 as id, to_date('2015-01-01', 'YYYY-MM-DD') as recordDate, 10 as temperature from dual union all
select 2 as id, to_date('2015-01-02', 'YYYY-MM-DD') as recordDate, 25 as temperature from dual union all
select 3 as id, to_date('2015-01-03', 'YYYY-MM-DD') as recordDate, 20 as temperature from dual union all
select 4 as id, to_date('2015-01-04', 'YYYY-MM-DD') as recordDate, 30 as temperature from dual
)
--select id from (select w.*, lag(temperature, 1) over (order by recordDate) as previous_day_temp from weather w) where temperature > previous_day_temp;
select t1.id from weather t1 join weather t2 on t1.recordDate-1 = t2.recordDate and t1.temperature > t2.temperature;


-- #577 - Employee Bonus - All Employees and Bonus where bonus is less than 1000
with employee as (
select 1 as empId, 'John' as name, 3 as supervisor, 1000 as salary from dual union all
select 2 as empId, 'Dan' as name, 3 as supervisor, 2000 as salary from dual union all
select 3 as empId, 'Brad' as name, null as supervisor, 4000 as salary from dual union all
select 4 as empId, 'Thomas' as name, 3 as supervisor, 4000 as salary from dual
),
bonus as (
select 2 as empId, 500 as bonus from dual union all
select 4 as empId, 2000 as bonus from dual
)
select e.name, b.bonus from employee e left join bonus b on e.empId = b.empId where b.bonus < 1000 or b.bonus is null;


-- #584 - Find Customer Referee - Customers who are not reffered by Customer ID 2
with customer as (
select 1 as id, 'Will' as name, null as referee_id from dual union all
select 2 as id, 'Jane' as name, null as referee_id from dual union all
select 3 as id, 'Alex' as name, 2 as referee_id from dual union all
select 4 as id, 'Bill' as name, null as referee_id from dual union all
select 5 as id, 'Zack' as name, 1 as referee_id from dual union all
select 6 as id, 'Mark' as name, 2 as referee_id from dual
)
select name from customer where referee_id <> 2 or referee_id is null;


-- #586 - Customer placing the largest number of Orders
with orders as (
select 1 as order_number, 1 as customer_number from dual union all
select 2 as order_number, 2 as customer_number from dual union all
select 3 as order_number, 3 as customer_number from dual union all
select 4 as order_number, 3 as customer_number from dual
)
select customer_number from (select customer_number, dense_rank() over (order by count(order_number) desc) as rnk from orders group by customer_number) where rnk = 1;


-- #595 - Big Countries
with world as (
select 'Afghanistan' as name, 'Asia' as continent, 652230 as area, 25500100 as population, 20343000000 as gdp from dual union all
select 'Albania' as name, 'Europe' as continent, 28748 as area, 2831741 as population, 12960000000 as gdp from dual union all
select 'Algeria' as name, 'Africa' as continent, 2381741 as area, 37100000 as population, 188681000000 as gdp from dual union all
select 'Andorra' as name, 'Europe' as continent, 468 as area, 78115 as population, 3712000000 as gdp from dual union all
select 'Angola' as name, 'Africa' as continent, 1246700 as area, 20609294 as population, 100990000000 as gdp from dual
)
select name, population, area from world where area > 3000000 or population > 25000000;


-- #596 - Classes atleast 5 students
with courses as (
select 'A' as student, 'Math' as class from dual union all
select 'B' as student, 'English' as class from dual union all
select 'C' as student, 'Math' as class from dual union all
select 'D' as student, 'Biology' as class from dual union all
select 'E' as student, 'Math' as class from dual union all
select 'F' as student, 'Computer' as class from dual union all
select 'G' as student, 'Math' as class from dual union all
select 'H' as student, 'Math' as class from dual union all
select 'I' as student, 'Math' as class from dual
)
select class from courses group by class having count(distinct student) >= 5;


-- #597 - Friend Request 1 - Overall acceptance rate (rounded to 2 decimals), which is the number of acceptance divide the number of requests
with friend_request as (
select 1 as sender_id, 2 as send_to_id, to_date('2016-06-01','YYYY-MM-DD') as request_date from dual union all
select 1 as sender_id, 3 as send_to_id, to_date('2016-06-01','YYYY-MM-DD') as request_date from dual union all
select 1 as sender_id, 4 as send_to_id, to_date('2016-06-01','YYYY-MM-DD') as request_date from dual union all
select 2 as sender_id, 3 as send_to_id, to_date('2016-06-02','YYYY-MM-DD') as request_date from dual union all
select 3 as sender_id, 4 as send_to_id, to_date('2016-06-09','YYYY-MM-DD') as request_date from dual
),
request_accepted as (
select 1 as requester_id, 2 as accepter_id, to_date('2016-06-03','YYYY-MM-DD') as accept_date from dual union all
select 1 as requester_id, 3 as accepter_id, to_date('2016-06-08','YYYY-MM-DD') as accept_date from dual union all
select 2 as requester_id, 3 as accepter_id, to_date('2016-06-08','YYYY-MM-DD') as accept_date from dual union all
select 3 as requester_id, 4 as accepter_id, to_date('2016-06-09','YYYY-MM-DD') as accept_date from dual union all
select 3 as requester_id, 4 as accepter_id, to_date('2016-06-10','YYYY-MM-DD') as accept_date from dual
),
sentCount as (
select count(*) as request_sent from (select distinct sender_id, send_to_id from friend_request)
),
acceptedCount as (
select count(*) as request_accepted from (select distinct requester_id, accepter_id from request_accepted)
)
select round(request_accepted/request_sent,2) as accept_rate from sentCount cross join acceptedCount;


-- #603 - Consecutive available seats - 2 or more available seats are considered as consecuitive
with cinema as (
select 1 as seat_id, 1 as free from dual union all
select 2 as seat_id, 0 as free from dual union all
select 3 as seat_id, 1 as free from dual union all
select 4 as seat_id, 1 as free from dual union all
select 5 as seat_id, 1 as free from dual
)
select c1.seat_id from cinema c1 join cinema c2 on c1.seat_id - 1 = c2.seat_id where c1.free = 1;


-- #607 - Sales Person - Name all salespersons who did not have any orders related to company RED
with salesPerson as (
select 1 as sales_id, 'John' as name, 100000 as salary, 6 as commission_rate, to_date('4/1/2006','MM/DD/YYYY') as hire_date from dual union all
select 2 as sales_id, 'Amy' as name, 12000 as salary, 5 as commission_rate, to_date('5/1/2010','MM/DD/YYYY') as hire_date from dual union all
select 3 as sales_id, 'Mark' as name, 65000 as salary, 12 as commission_rate, to_date('12/25/2008','MM/DD/YYYY') as hire_date from dual union all
select 4 as sales_id, 'Pam' as name, 25000 as salary, 25 as commission_rate, to_date('1/1/2005','MM/DD/YYYY') as hire_date from dual union all
select 5 as sales_id, 'Alex' as name, 5000 as salary, 10 as commission_rate, to_date('2/3/2007','MM/DD/YYYY') as hire_date from dual
),
company as (
select 1 as com_id, 'RED' as name, 'Boston' as city from dual union all
select 2 as com_id, 'ORANGE' as name, 'New York' as city from dual union all
select 3 as com_id, 'YELLOW' as name, 'Boston' as city from dual union all
select 4 as com_id, 'GREEN' as name, 'Austin' as city from dual
),
orders as (
select 1 as order_id, to_date('1/1/2014','MM/DD/YYYY') as order_date, 3 as com_id, 4 as sales_id, 10000 as amount from dual union all
select 2 as order_id, to_date('1/2/2014','MM/DD/YYYY') as order_date, 4 as com_id, 5 as sales_id, 5000 as amount from dual union all
select 3 as order_id, to_date('1/3/2014','MM/DD/YYYY') as order_date, 1 as com_id, 1 as sales_id, 50000 as amount from dual union all
select 4 as order_id, to_date('1/4/2014','MM/DD/YYYY') as order_date, 1 as com_id, 4 as sales_id, 25000 as amount from dual
)
select s.name from salesPerson s where sales_id not in (select o.sales_id from orders o join company c on o.com_id = c.com_id where c.name = 'RED');


-- #610 - Triangle Judgement
with triangle as (
select 13 as x, 15 as y, 30 as z from dual union all
select 10 as x, 20 as y, 15 as z from dual
)
select x, y, z, case when x+y>z and x+z>y and y+z>x then 'Yes' else 'No' end as triange from triangle;


-- #613 - Shortest Distance in a line - Table holds X cordinates, Find shortest distance between two points
with points as (
select -5 as x from dual union all
select -3 as x from dual union all
select 2 as x from dual union all
select -1 as x from dual union all
select 0 as x from dual
)
select min(abs(abs(x)-abs(next_x))) as shortest from (select x, lead(x,1) over (order by x) as next_x from points);


-- #619 - Biggest single number - Out of many duplicate numbers, find number which appear only once and is the biggest
with my_numbers as (
select 8 as num from dual union all
select 8 as num from dual union all
select 3 as num from dual union all
select 3 as num from dual union all
select 1 as num from dual union all
select 4 as num from dual union all
select 5 as num from dual union all
select 6 as num from dual
)
select max(num) as num from (select num, count(*) from my_numbers group by num having count(*) = 1);


-- #620 - Not boring movies - Report movies with odd number ID and description not "boring"
with cinema as (
select 1 as id, 'War' as movie, 'great 3D' as description, 8.9 as rating from dual union all
select 2 as id, 'Science' as movie, 'fiction' as description, 8.5 as rating from dual union all
select 3 as id, 'irish' as movie, 'boring' as description, 6.2 as rating from dual union all
select 4 as id, 'Ice song' as movie, 'Fantacy' as description, 8.6 as rating from dual union all
select 5 as id, 'House card' as movie, 'Interesting' as description, 9.1 as rating from dual
)
select * from cinema where mod(id,2) = 1 and description <> 'boring' order by rating desc;


-- #627 - Swap Salary - Swap all 'm' to 'f' and viceversa
create table salary (id number, name char(1), sex char(1), salary number);
insert into salary
select 1 as id, 'A' as name, 'm' as sex, 2500 as salary from dual union all
select 2 as id, 'B' as name, 'f' as sex, 1500 as salary from dual union all
select 3 as id, 'C' as name, 'm' as sex, 5500 as salary from dual union all
select 4 as id, 'D' as name, 'f' as sex, 500 as salary from dual;
select * from salary;
update salary set sex = case sex when 'm' then 'f' else 'm' end;


-- #1050 - Actors and Directors Who Cooperated At Least Three Times
with ActorDirector as (
select 1 as actor_id, 1 as director_id, 0 as timestamp from dual union all
select 1 as actor_id, 1 as director_id, 1 as timestamp from dual union all
select 1 as actor_id, 1 as director_id, 2 as timestamp from dual union all
select 1 as actor_id, 2 as director_id, 3 as timestamp from dual union all
select 1 as actor_id, 2 as director_id, 4 as timestamp from dual union all
select 2 as actor_id, 1 as director_id, 5 as timestamp from dual union all
select 2 as actor_id, 1 as director_id, 6 as timestamp from dual
)
select actor_id, director_id from actordirector group by actor_id, director_id having count(*) >= 3;


-- #1068 - Product Sales Analysis 1 - Report all product names of the products in the Sales table along with their selling year and price
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
select product_name, year, price from sales s join product p on s.product_id = p.product_id;


-- #1069 - Product Sales Analysis 2 - Report total quantity sold for every product id.
-- Total sales per product
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
select product_id, sum(quantity) as total_quantity from sales group by product_id;


-- #1075 - Project Employees 1 - Report the average experience years of all the employees for each project, rounded to 2 digits
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
select 3 as employee_id, 'John' as name, 1 as experience_years from dual union all
select 4 as employee_id, 'Doe' as name, 2 as experience_years from dual
)
--select p.project_id, round(sum(e.experience_years)/count(e.employee_id),2) as average_years from project p join employee e on p.employee_id = e.employee_id group by p.project_id;
select p.project_id, round(avg(e.experience_years),2) as average_years from project p join employee e on p.employee_id = e.employee_id group by p.project_id;


-- #1076 - Project Employees 2 - Report all the projects that have the most employees
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
select 3 as employee_id, 'John' as name, 1 as experience_years from dual union all
select 4 as employee_id, 'Doe' as name, 2 as experience_years from dual
)
--select project_id from (select project_id from project group by project_id order by count(*) desc) where rownum = 1;
select project_id from (select project_id, dense_rank() over (order by count(employee_id) desc) as rnk from project group by project_id) where rnk = 1;


-- #1082 - Sales Analysis 1 - Best seller(s) with maximum sale, if there is tie, return them all
with product as (
select 1 as product_id, 'S8' as product_name, 1000 as unit_price from dual union all
select 2 as product_id, 'G4' as product_name, 800 as unit_price from dual union all
select 3 as product_id, 'iPhone' as product_name, 1400 as unit_price from dual
),
sales as (
select 1 as seller_id, 1 as product_id, 1 as buyer_id, to_date('2019-01-21', 'YYYY-MM-DD') as sale_date, 2 as quantity, 2000 as price from dual union all
select 1 as seller_id, 2 as product_id, 2 as buyer_id, to_date('2019-02-17', 'YYYY-MM-DD') as sale_date, 1 as quantity, 800 as price from dual union all
select 2 as seller_id, 2 as product_id, 3 as buyer_id, to_date('2019-06-02', 'YYYY-MM-DD') as sale_date, 1 as quantity, 800 as price from dual union all
select 3 as seller_id, 3 as product_id, 4 as buyer_id, to_date('2019-05-13', 'YYYY-MM-DD') as sale_date, 2 as quantity, 2800 as price from dual
)
--select seller_id from sales group by seller_id having sum(price) = (select max(sum(price)) from sales group by seller_id);
select seller_id from (select seller_id, dense_rank() over (order by sum(price) desc) as rnk from sales group by seller_id) where rnk =1;


-- #1083 - Sales Analysis 2 - Who bought S8 but not iPhone
with product as (
select 1 as product_id, 'S8' as product_name, 1000 as unit_price from dual union all
select 2 as product_id, 'G4' as product_name, 800 as unit_price from dual union all
select 3 as product_id, 'iPhone' as product_name, 1400 as unit_price from dual
),
sales as (
select 1 as seller_id, 1 as product_id, 1 as buyer_id, to_date('2019-01-21', 'YYYY-MM-DD') as sale_date, 2 as quantity, 2000 as price from dual union all
select 1 as seller_id, 2 as product_id, 2 as buyer_id, to_date('2019-02-17', 'YYYY-MM-DD') as sale_date, 1 as quantity, 800 as price from dual union all
select 2 as seller_id, 1 as product_id, 3 as buyer_id, to_date('2019-06-02', 'YYYY-MM-DD') as sale_date, 1 as quantity, 800 as price from dual union all
select 3 as seller_id, 3 as product_id, 3 as buyer_id, to_date('2019-05-13', 'YYYY-MM-DD') as sale_date, 2 as quantity, 2800 as price from dual
)

--select s1.buyer_id from sales s1 join product p on s1.product_id = p.product_id where p.product_name = 'S8' and not exists (select 1 from sales s2 join product p on s2.product_id = p.product_id where s1.buyer_id = s2.buyer_id and p.product_name = 'iPhone');
select s.buyer_id from sales s join product p on p.product_id = s.product_id group by s.buyer_id having sum(case when p.product_name = 'S8' then 1 else 0 end) >= 1 and sum(case when p.product_name = 'iPhone' then 1 else 0 end) = 0;


-- #1084 - Sales Analysis 3 - Products that were only sold between 2019-01-01 and 2019-03-31 inclusive
with product as (
select 1 as product_id, 'S8' as product_name, 1000 as unit_price from dual union all
select 2 as product_id, 'G4' as product_name, 800 as unit_price from dual union all
select 3 as product_id, 'iPhone' as product_name, 1400 as unit_price from dual
),
sales as (
select 1 as seller_id, 1 as product_id, 1 as buyer_id, to_date('2019-01-21', 'YYYY-MM-DD') as sale_date, 2 as quantity, 2000 as price from dual union all
select 1 as seller_id, 2 as product_id, 2 as buyer_id, to_date('2019-02-17', 'YYYY-MM-DD') as sale_date, 1 as quantity, 800 as price from dual union all
select 2 as seller_id, 2 as product_id, 3 as buyer_id, to_date('2019-06-02', 'YYYY-MM-DD') as sale_date, 1 as quantity, 800 as price from dual union all
select 3 as seller_id, 3 as product_id, 4 as buyer_id, to_date('2019-05-13', 'YYYY-MM-DD') as sale_date, 2 as quantity, 2800 as price from dual
)
select p.product_id, p.product_name from sales s join product p on s.product_id  = p.product_id
group by p.product_id, p.product_name
having min(s.sale_date) >= to_date('2019-01-01', 'YYYY-MM-DD') and max(s.sale_date) <= to_date('2019-03-31', 'YYYY-MM-DD');


-- #511 - Gameplay Analysis 1 - Report the first login date for each player
with activity as (
select 1 as player_id, 2 as device_id, to_date('2016-03-01', 'YYYY-MM-DD') as event_date, 5 as games_played from dual union all
select 1 as player_id, 2 as device_id, to_date('2016-05-02', 'YYYY-MM-DD') as event_date, 6 as games_played from dual union all
select 2 as player_id, 3 as device_id, to_date('2017-06-25', 'YYYY-MM-DD') as event_date, 1 as games_played from dual union all
select 3 as player_id, 1 as device_id, to_date('2016-03-02', 'YYYY-MM-DD') as event_date, 0 as games_played from dual union all
select 3 as player_id, 4 as device_id, to_date('2018-07-03', 'YYYY-MM-DD') as event_date, 5 as games_played from dual
)
select player_id as "player_id", to_char(min(event_date),'YYYY-MM-DD') as "first_login" from activity group by player_id;


-- #512 - Gameplay Analysis 2 - Find the device used in first login
with activity as (
    select 1 as player_id, 2 as device_id, to_date('2016-03-01', 'YYYY-MM-DD') as event_date, 5 as games_played from dual union all
    select 1 as player_id, 2 as device_id, to_date('2016-05-02', 'YYYY-MM-DD') as event_date, 6 as games_played from dual union all
    select 2 as player_id, 3 as device_id, to_date('2017-06-25', 'YYYY-MM-DD') as event_date, 1 as games_played from dual union all
    select 3 as player_id, 1 as device_id, to_date('2016-03-02', 'YYYY-MM-DD') as event_date, 0 as games_played from dual union all
    select 3 as player_id, 4 as device_id, to_date('2018-07-03', 'YYYY-MM-DD') as event_date, 5 as games_played from dual
)
select a.player_id, a.device_id from activity a join (select player_id, min(event_date) as first_login from activity group by player_id) b on a.player_id = b.player_id and a.event_date = b.first_login;


-- #1113 - Reported Posts - Reports the number of posts reported yesterday for each report reason. Assume today is 2019-07-05
with actions as (
select 1 as user_id, 1 as post_id, to_date('2019-07-01','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 1 as user_id, 1 as post_id, to_date('2019-07-01','YYYY-MM-DD') as action_date, 'like' as action, null as extra from dual union all
select 1 as user_id, 1 as post_id, to_date('2019-07-01','YYYY-MM-DD') as action_date, 'share' as action, null as extra from dual union all
select 2 as user_id, 4 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 2 as user_id, 4 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'report' as action, 'spam' as extra from dual union all
select 3 as user_id, 4 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 3 as user_id, 4 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'report' as action, 'spam' as extra from dual union all
select 4 as user_id, 3 as post_id, to_date('2019-07-02','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 4 as user_id, 3 as post_id, to_date('2019-07-02','YYYY-MM-DD') as action_date, 'report' as action, 'spam' as extra from dual union all
select 5 as user_id, 2 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 5 as user_id, 2 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'report' as action, 'racism' as extra from dual union all
select 5 as user_id, 5 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'view' as action, null as extra from dual union all
select 5 as user_id, 5 as post_id, to_date('2019-07-04','YYYY-MM-DD') as action_date, 'report' as action, 'racism' as extra from dual
)
select extra as report_reason, count(distinct post_id) as report_count from actions where action_date = to_date('2019-07-05','YYYY-MM-DD')-1 and action = 'report' group by extra;


-- #1141 - User activity for past 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day
with activity as (
select 1 as user_id, 1 as session_id, to_date('2019-07-20','YYYY-MM-DD') as activity_date, 'open_session' as activity_type from dual union all
select 1 as user_id, 1 as session_id, to_date('2019-07-20','YYYY-MM-DD') as activity_date, 'scroll_down' as activity_type from dual union all
select 1 as user_id, 1 as session_id, to_date('2019-07-20','YYYY-MM-DD') as activity_date, 'end_session' as activity_type from dual union all
select 2 as user_id, 4 as session_id, to_date('2019-07-20','YYYY-MM-DD') as activity_date, 'open_session' as activity_type from dual union all
select 2 as user_id, 4 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'send_message' as activity_type from dual union all
select 2 as user_id, 4 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'end_session' as activity_type from dual union all
select 3 as user_id, 2 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'open_session' as activity_type from dual union all
select 3 as user_id, 2 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'send_message' as activity_type from dual union all
select 3 as user_id, 2 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'end_session' as activity_type from dual union all
select 4 as user_id, 3 as session_id, to_date('2019-06-25','YYYY-MM-DD') as activity_date, 'open_session' as activity_type from dual union all
select 4 as user_id, 3 as session_id, to_date('2019-06-25','YYYY-MM-DD') as activity_date, 'end_session' as activity_type from dual
)
select to_char(activity_date,'YYYY-MM-DD') as "day", count(distinct user_id) as "active_users" from activity where activity_date between to_date('2019-07-27','YYYY-MM-DD')-30+1 and to_date('2019-07-27','YYYY-MM-DD') group by activity_date;


-- #1142 - User activity for past 30 days - Average number of sessions per user for a period of 30 days ending 2019-07-27 inclusively, rounded to 2 decimal places.
with activity as (
select 1 as user_id, 1 as session_id, to_date('2019-07-20','YYYY-MM-DD') as activity_date, 'open_session' as activity_type from dual union all
select 1 as user_id, 1 as session_id, to_date('2019-07-20','YYYY-MM-DD') as activity_date, 'scroll_down' as activity_type from dual union all
select 1 as user_id, 1 as session_id, to_date('2019-07-20','YYYY-MM-DD') as activity_date, 'end_session' as activity_type from dual union all
select 2 as user_id, 4 as session_id, to_date('2019-07-20','YYYY-MM-DD') as activity_date, 'open_session' as activity_type from dual union all
select 2 as user_id, 4 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'send_message' as activity_type from dual union all
select 2 as user_id, 4 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'end_session' as activity_type from dual union all
select 3 as user_id, 2 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'open_session' as activity_type from dual union all
select 3 as user_id, 2 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'send_message' as activity_type from dual union all
select 3 as user_id, 2 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'end_session' as activity_type from dual union all
select 3 as user_id, 5 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'open_session' as activity_type from dual union all
select 3 as user_id, 5 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'scroll_down' as activity_type from dual union all
select 3 as user_id, 5 as session_id, to_date('2019-07-21','YYYY-MM-DD') as activity_date, 'end_session' as activity_type from dual union all
select 4 as user_id, 3 as session_id, to_date('2019-06-25','YYYY-MM-DD') as activity_date, 'open_session' as activity_type from dual union all
select 4 as user_id, 3 as session_id, to_date('2019-06-25','YYYY-MM-DD') as activity_date, 'end_session' as activity_type from dual
)
select round(avg(sessions),2) as average_sessions_per_user from (select user_id, count(distinct session_id) as sessions from activity where activity_date between to_date('2019-07-27','YYYY-MM-DD')-30+1 and to_date('2019-07-27','YYYY-MM-DD') group by user_id);


-- #1148 - Article View 1 - Equal author_id and viewer_id indicate the same person - Find all the authors that viewed at least one of their own articles
with views as (
select 1 as article_id, 3 as author_id, 5 as viewer_id, to_date('2019-08-01','YYYY-MM-DD') as view_date from dual union all
select 1 as article_id, 3 as author_id, 6 as viewer_id, to_date('2019-08-02','YYYY-MM-DD') as view_date from dual union all
select 2 as article_id, 7 as author_id, 7 as viewer_id, to_date('2019-08-01','YYYY-MM-DD') as view_date from dual union all
select 2 as article_id, 7 as author_id, 6 as viewer_id, to_date('2019-08-02','YYYY-MM-DD') as view_date from dual union all
select 4 as article_id, 7 as author_id, 1 as viewer_id, to_date('2019-07-22','YYYY-MM-DD') as view_date from dual union all
select 3 as article_id, 4 as author_id, 4 as viewer_id, to_date('2019-07-21','YYYY-MM-DD') as view_date from dual union all
select 3 as article_id, 4 as author_id, 4 as viewer_id, to_date('2019-07-21','YYYY-MM-DD') as view_date from dual
)
select distinct author_id as id from views where author_id = viewer_id order by id;


-- #1173 - Immediate Food Delivery 1 - Find the percentage of immediate orders in the table, rounded to 2 decimal places
-- If the preferred delivery date of the customer is the same as the order date then the order is called immediate otherwise it's called scheduled
with delivery as (
select 1 as delivery_id, 1 as customer_id, to_date('2019-08-01','YYYY-MM-DD') as order_date, to_date('2019-08-02','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 2 as delivery_id, 5 as customer_id, to_date('2019-08-02','YYYY-MM-DD') as order_date, to_date('2019-08-02','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 3 as delivery_id, 1 as customer_id, to_date('2019-08-11','YYYY-MM-DD') as order_date, to_date('2019-08-11','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 4 as delivery_id, 3 as customer_id, to_date('2019-08-24','YYYY-MM-DD') as order_date, to_date('2019-08-26','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 5 as delivery_id, 4 as customer_id, to_date('2019-08-21','YYYY-MM-DD') as order_date, to_date('2019-08-22','YYYY-MM-DD') as customer_pref_delivery_date from dual union all
select 5 as delivery_id, 2 as customer_id, to_date('2019-08-11','YYYY-MM-DD') as order_date, to_date('2019-08-13','YYYY-MM-DD') as customer_pref_delivery_date from dual
)
select round(avg(case when order_date = customer_pref_delivery_date then 1 else 0 end) * 100,2) as immediate_percentage from delivery;


-- #1179 - Reformat Department Table - Pivot
with department as (
select 1 as id, 8000 as revenue, 'Jan' as month from dual union all
select 2 as id, 9000 as revenue, 'Jan' as month from dual union all
select 3 as id, 10000 as revenue, 'Feb' as month from dual union all
select 1 as id, 7000 as revenue, 'Feb' as month from dual union all
select 1 as id, 6000 as revenue, 'Mar' as month from dual
)
select * from department pivot (sum(revenue) for month in ('Jan' "Jan_Revenue", 'Feb' "Feb_Revenue", 'Mar' "Mar_Revenue", 'Apr' "Apr_Revenue", 'May' "May_Revenue", 'Jun' "Jun_Revenue", 'Jul' "Jul_Revenue", 'Aug' "Aug_Revenue", 'Sep' "Sep_Revenue", 'Oct' "Oct_Revenue", 'Nov' "Nov_Revenue", 'Dec' "Dec_Revenue"));


-- #1211 - Queries Quality and Percentage. Query Quality = AVG(Rating/Position). Poor Query % = % of queries with rating less than 3
with queries as (
select 'Dog' as query_name, 'Golden Retriever' as result, 1 as position, 5 as rating from dual union all
select 'Dog' as query_name, 'German Shepherd' as result, 2 as position, 5 as rating from dual union all
select 'Dog' as query_name, 'Mule' as result, 200 as position, 1 as rating from dual union all
select 'Cat' as query_name, 'Shirazi' as result, 5 as position, 2 as rating from dual union all
select 'Cat' as query_name, 'Siamese' as result, 3 as position, 3 as rating from dual union all
select 'Cat' as query_name, 'Sphynx' as result, 7 as position, 4 as rating from dual
)
select query_name, round(avg(rating/position),2) as quality, round(avg(case when rating < 3 then 1 else 0 end) * 100,2) as poor_query_percentage from queries group by query_name;


-- #1241 - Number of comments per post - Each row can be post or comment on post. Parent_ID is NULL for posts. Parent_ID for comments in SUB_ID for another post.
-- Find number of comments per each post, sorted by post_id in ascending order
with submissions as (
select 1    as sub_id,  null as parent_id   from dual union all
select 2    as sub_id,  null as parent_id   from dual union all
select 1    as sub_id,  null as parent_id   from dual union all
select 12   as sub_id,  null as parent_id   from dual union all
select 3    as sub_id,     1 as parent_id   from dual union all
select 5    as sub_id,     2 as parent_id   from dual union all
select 3    as sub_id,     1 as parent_id   from dual union all
select 4    as sub_id,     1 as parent_id   from dual union all
select 9    as sub_id,     1 as parent_id   from dual union all
select 10   as sub_id,     2 as parent_id   from dual union all
select 6    as sub_id,     7 as parent_id   from dual
)
select a.sub_id as post_id, count(distinct b.sub_id) as number_of_comments from (select distinct sub_id from submissions where parent_id is null) a left join submissions b on a.sub_id = b.parent_id group by a.sub_id;


-- #1251 - Average selling price for each product. Average selling price = Total Price of Product / Number of products sold
with prices as (
select 1 as product_id, to_date('2019-02-17','YYYY-MM-DD') as start_date, to_date('2019-02-28','YYYY-MM-DD') as end_date, 5 as price from dual union all
select 1 as product_id, to_date('2019-03-01','YYYY-MM-DD') as start_date, to_date('2019-03-22','YYYY-MM-DD') as end_date, 20 as price from dual union all
select 2 as product_id, to_date('2019-02-01','YYYY-MM-DD') as start_date, to_date('2019-02-20','YYYY-MM-DD') as end_date, 15 as price from dual union all
select 2 as product_id, to_date('2019-02-21','YYYY-MM-DD') as start_date, to_date('2019-03-31','YYYY-MM-DD') as end_date, 30 as price from dual
),
unitssold as (
select 1 as product_id, to_date('2019-02-25','YYYY-MM-DD') as purchase_date, 100 as units from dual union all
select 1 as product_id, to_date('2019-03-01','YYYY-MM-DD') as purchase_date, 15 as units from dual union all
select 2 as product_id, to_date('2019-02-10','YYYY-MM-DD') as purchase_date, 200 as units from dual union all
select 2 as product_id, to_date('2019-03-22','YYYY-MM-DD') as purchase_date, 30 as units from dual
)
select u.product_id, round(sum(u.units * p.price)/sum(u.units),2) as average_price from unitssold u join prices p on u.product_id = p.product_id and u.purchase_date between p.start_date and p.end_date group by u.product_id;


-- #1280 - Students and Examinations - Find the number of times each student attended each exam. Order by Student ID and Subject Name
with students as (
select 1 as student_id, 'Alice' as student_name from dual union all
select 2 as student_id, 'Bob' as student_name from dual union all
select 13 as student_id, 'John' as student_name from dual union all
select 6 as student_id, 'Alex' as student_name from dual
),
subjects as (
select 'Math' as subject_name from dual union all
select 'Physics' as subject_name from dual union all
select 'Programming' as subject_name from dual
),
examinations as (
select 1 as student_id, 'Math' as subject_name from dual union all
select 1 as student_id, 'Physics' as subject_name from dual union all
select 1 as student_id, 'Programming' as subject_name from dual union all
select 2 as student_id, 'Programming' as subject_name from dual union all
select 1 as student_id, 'Physics' as subject_name from dual union all
select 1 as student_id, 'Math' as subject_name from dual union all
select 13 as student_id, 'Math' as subject_name from dual union all
select 13 as student_id, 'Programming' as subject_name from dual union all
select 13 as student_id, 'Physics' as subject_name from dual union all
select 2 as student_id, 'Math' as subject_name from dual union all
select 1 as student_id, 'Math' as subject_name from dual
)
select st.student_id, st.student_name, su.subject_name, count(ex.student_id) as attended_exams from students st cross join subjects su left join examinations ex on st.student_id = ex.student_id and su.subject_name = ex.subject_name group by st.student_id, st.student_name, su.subject_name order by st.student_id, su.subject_name;


-- #1294 - Weather type in each country - Find the type of weather in each country for November 2019 - Cold <= 15, Hot >= 25 and Warm otherwise
with countries as (
select 2 as country_id, 'USA' as country_name from dual union all
select 3 as country_id, 'Australia' as country_name from dual union all
select 7 as country_id, 'Peru' as country_name from dual union all
select 5 as country_id, 'China' as country_name from dual union all
select 8 as country_id, 'Morocco' as country_name from dual union all
select 9 as country_id, 'Spain' as country_name from dual
),
weather as (
select 2 as country_id, 15 as weather_state, to_date('2019-11-01','YYYY-MM-DD') as day from dual union all
select 2 as country_id, 12 as weather_state, to_date('2019-10-28','YYYY-MM-DD') as day from dual union all
select 2 as country_id, 12 as weather_state, to_date('2019-10-27','YYYY-MM-DD') as day from dual union all
select 3 as country_id, -2 as weather_state, to_date('2019-11-10','YYYY-MM-DD') as day from dual union all
select 3 as country_id, 0 as weather_state, to_date('2019-11-11','YYYY-MM-DD') as day from dual union all
select 3 as country_id, 3 as weather_state, to_date('2019-11-12','YYYY-MM-DD') as day from dual union all
select 5 as country_id, 16 as weather_state, to_date('2019-11-07','YYYY-MM-DD') as day from dual union all
select 5 as country_id, 18 as weather_state, to_date('2019-11-09','YYYY-MM-DD') as day from dual union all
select 5 as country_id, 21 as weather_state, to_date('2019-11-23','YYYY-MM-DD') as day from dual union all
select 7 as country_id, 25 as weather_state, to_date('2019-11-28','YYYY-MM-DD') as day from dual union all
select 7 as country_id, 22 as weather_state, to_date('2019-12-01','YYYY-MM-DD') as day from dual union all
select 7 as country_id, 20 as weather_state, to_date('2019-12-02','YYYY-MM-DD') as day from dual union all
select 8 as country_id, 25 as weather_state, to_date('2019-11-05','YYYY-MM-DD') as day from dual union all
select 8 as country_id, 27 as weather_state, to_date('2019-11-15','YYYY-MM-DD') as day from dual union all
select 8 as country_id, 31 as weather_state, to_date('2019-11-25','YYYY-MM-DD') as day from dual union all
select 9 as country_id, 7 as weather_state, to_date('2019-10-23','YYYY-MM-DD') as day from dual union all
select 9 as country_id, 3 as weather_state, to_date('2019-12-23','YYYY-MM-DD') as day from dual
)
select c.country_name, case when avg(w.weather_state) <= 15 then 'Cold' when avg(w.weather_state) >=25 then 'Hot' else 'Worm' end as weather_type from weather w join countries c on c.country_id = w.country_id where day between to_date('2019-11-01','YYYY-MM-DD') and last_day(to_date('2019-11-01','YYYY-MM-DD')) group by c.country_name;


-- #1303 - Find the team size - Find the team size of each of the employees
with employee as (
select 1 as employee_id, 8 as team_id from dual union all
select 2 as employee_id, 8 as team_id from dual union all
select 3 as employee_id, 8 as team_id from dual union all
select 4 as employee_id, 7 as team_id from dual union all
select 5 as employee_id, 9 as team_id from dual union all
select 6 as employee_id, 9 as team_id from dual
)
select employee_id, count(*) over (partition by team_id) as team_size from employee;


-- #1322 - Ads Performance - Find the CTR (Click-Through Rate) of each Ad. Order by CTR descending ad_id acscending. CTR = Clicks / Impressions (ads shown)
with ads as (
select 1 as ad_id, 1 as user_id, 'Clicked' as action from dual union all
select 2 as ad_id, 2 as user_id, 'Clicked' as action from dual union all
select 3 as ad_id, 3 as user_id, 'Viewed' as action from dual union all
select 5 as ad_id, 5 as user_id, 'Ignored' as action from dual union all
select 1 as ad_id, 7 as user_id, 'Ignored' as action from dual union all
select 2 as ad_id, 7 as user_id, 'Viewed' as action from dual union all
select 3 as ad_id, 5 as user_id, 'Clicked' as action from dual union all
select 1 as ad_id, 4 as user_id, 'Viewed' as action from dual union all
select 2 as ad_id, 11 as user_id, 'Viewed' as action from dual union all
select 1 as ad_id, 2 as user_id, 'Clicked' as action from dual
)
select ad_id, round(case when impression = 0 then 0 else clicked/impression * 100 end,2) as ctr from (select ad_id, sum(case when action = 'Clicked' then 1 else 0 end) as clicked, sum(case when action <> 'Ignored' then 1 else 0 end) as impression from ads group by ad_id);


-- #1327 - List of products ordered in a period - Get the names of products with >= 100 units ordered in February 2020 and their amount
with products as (
select 1 as product_id, 'Leetcode Solutions' as product_name, 'Book' as product_category from dual union all
select 2 as product_id, 'Jewels of Stringology' as product_name, 'Book' as product_category from dual union all
select 3 as product_id, 'HP' as product_name, 'Laptop' as product_category from dual union all
select 4 as product_id, 'Lenovo' as product_name, 'Laptop' as product_category from dual union all
select 5 as product_id, 'Leetcode Kit' as product_name, 'T-shirt' as product_category from dual
),
orders as (
select 1 as product_id, to_date('2020-02-05','YYYY-MM-DD') as order_date, 60 as unit from dual union all
select 1 as product_id, to_date('2020-02-10','YYYY-MM-DD') as order_date, 70 as unit from dual union all
select 2 as product_id, to_date('2020-01-18','YYYY-MM-DD') as order_date, 30 as unit from dual union all
select 2 as product_id, to_date('2020-02-11','YYYY-MM-DD') as order_date, 80 as unit from dual union all
select 3 as product_id, to_date('2020-02-17','YYYY-MM-DD') as order_date, 2 as unit from dual union all
select 3 as product_id, to_date('2020-02-24','YYYY-MM-DD') as order_date, 3 as unit from dual union all
select 4 as product_id, to_date('2020-03-01','YYYY-MM-DD') as order_date, 20 as unit from dual union all
select 4 as product_id, to_date('2020-03-04','YYYY-MM-DD') as order_date, 30 as unit from dual union all
select 4 as product_id, to_date('2020-03-04','YYYY-MM-DD') as order_date, 60 as unit from dual union all
select 5 as product_id, to_date('2020-02-25','YYYY-MM-DD') as order_date, 50 as unit from dual union all
select 5 as product_id, to_date('2020-02-27','YYYY-MM-DD') as order_date, 50 as unit from dual union all
select 5 as product_id, to_date('2020-03-01','YYYY-MM-DD') as order_date, 50 as unit from dual
)
select p.product_name, sum(o.unit) as unit from orders o join products p on p.product_id = o.product_id where o.order_date between to_date('2020-02-01') and last_day(to_date('2020-02-01')) group by p.product_name having sum(o.unit) >= 100;


-- #1350 - Students with invalid departments - Find the id and the name of all students who are enrolled in departments that no longer exists
with departments as (
select 1 as id, 'Electrical Engineering' as name from dual union all
select 7 as id, 'Computer Engineering' as name from dual union all
select 13 as id, 'Bussiness Administration' as name from dual
),
students as (
select 23 as id, 'Alice' as name, 1 as department_id from dual union all
select 1 as id, 'Bob' as name, 7 as department_id from dual union all
select 5 as id, 'Jennifer' as name, 13 as department_id from dual union all
select 2 as id, 'John' as name, 14 as department_id from dual union all
select 4 as id, 'Jasmine' as name, 77 as department_id from dual union all
select 3 as id, 'Steve' as name, 74 as department_id from dual union all
select 6 as id, 'Luis' as name, 1 as department_id from dual union all
select 8 as id, 'Jonathan' as name, 7 as department_id from dual union all
select 7 as id, 'Daiana' as name, 33 as department_id from dual union all
select 11 as id, 'Madelynn' as name, 1 as department_id from dual
)
select s.id, s.name from students s left join departments d on d.id = s.department_id where d.id is null;


-- #1378 - Replace Employee ID with unique Identifier
with employees as (
select 1 as id, 'Alice' as name from dual union all
select 7 as id, 'Bob' as name from dual union all
select 11 as id, 'Meir' as name from dual union all
select 90 as id, 'Winston' as name from dual union all
select 3 as id, 'Jonathan' as name from dual
),
employeeUNI as (
select 3 as id, 1 as unique_id from dual union all
select 11 as id, 2 as unique_id from dual union all
select 90 as id, 3 as unique_id from dual
)
select uni.unique_id, e.name from employees e left join employeeUNI uni on e.id = uni.id;


-- #1407 - Top Travellers - Report the distance travelled by each user - ordered by travelled_distance, name in descending order
with users as (
select 1 as id, 'Alice' as name from dual union all
select 2 as id, 'Bob' as name from dual union all
select 3 as id, 'Alex' as name from dual union all
select 4 as id, 'Donald' as name from dual union all
select 7 as id, 'Lee' as name from dual union all
select 13 as id, 'Jonathan' as name from dual union all
select 19 as id, 'Elvis' as name from dual
),
rides as (
select 1 as id, 1 as user_id, 120 as distance from dual union all
select 2 as id, 2 as user_id, 317 as distance from dual union all
select 3 as id, 3 as user_id, 222 as distance from dual union all
select 4 as id, 7 as user_id, 100 as distance from dual union all
select 5 as id, 13 as user_id, 312 as distance from dual union all
select 6 as id, 19 as user_id, 50 as distance from dual union all
select 7 as id, 7 as user_id, 120 as distance from dual union all
select 8 as id, 19 as user_id, 400 as distance from dual union all
select 9 as id, 7 as user_id, 230 as distance from dual
)
select u.name, nvl(sum(r.distance),0) as travelled_distance from users u left join rides r on u.id = r.user_id group by u.name order by nvl(sum(r.distance),0) desc, name asc;


-- #1421 - NPV (Net Present Value) Queries
with npv as (
select 1 as id, 2018 as year, 100 as npv from dual union all
select 7 as id, 2020 as year, 30 as npv from dual union all
select 13 as id, 2019 as year, 40 as npv from dual union all
select 1 as id, 2019 as year, 113 as npv from dual union all
select 2 as id, 2008 as year, 121 as npv from dual union all
select 3 as id, 2009 as year, 12 as npv from dual union all
select 11 as id, 2020 as year, 99 as npv from dual union all
select 7 as id, 2019 as year, 0 as npv from dual
),
queries as (
select 1 as id, 2019 as year from dual union all
select 2 as id, 2008 as year from dual union all
select 3 as id, 2009 as year from dual union all
select 7 as id, 2018 as year from dual union all
select 7 as id, 2019 as year from dual union all
select 7 as id, 2020 as year from dual union all
select 13 as id, 2019 as year from dual
)
select q.id, q.year, nvl(sum(npv.npv),0) as npv from queries q left join npv on q.id = npv.id and q.year = npv.year group by q.id, q.year order by q.id;


-- #1435 - Create a Session Bar Chart 
-- How long a user visits your application. You decided to create bins of "[0-5>", "[5-10>", "[10-15>" and "15 minutes or more" and count the number of sessions on it
with sessions as (
select 1 as session_id, 30 as duration from dual union all
select 2 as session_id, 199 as duration from dual union all
select 3 as session_id, 299 as duration from dual union all
select 4 as session_id, 580 as duration from dual union all
select 5 as session_id, 1000 as duration from dual
) -- duration is in seconds
select '[0-5>' as bin, sum(case when duration between 0 and 300 then 1 else 0 end) as total from sessions
union all
select '[5-10>' as bin, sum(case when duration between 300 and 600 then 1 else 0 end) as total from sessions
union all
select '[10-15>' as bin, sum(case when duration between 600 and 900 then 1 else 0 end) as total from sessions
union all
select '15 or more' as bin, sum(case when duration > 900 then 1 else 0 end) as total from sessions;


-- #1484 - Group Sold product by Date - Find for each date, the number of distinct products sold and their names
with activities as (
select to_date('2020-05-30','YYYY-MM-DD') as sell_date, 'Headphone' as product from dual union all
select to_date('2020-06-01','YYYY-MM-DD') as sell_date, 'Pencil' as product from dual union all
select to_date('2020-06-02','YYYY-MM-DD') as sell_date, 'Mask' as product from dual union all
select to_date('2020-05-30','YYYY-MM-DD') as sell_date, 'Basketball' as product from dual union all
select to_date('2020-06-01','YYYY-MM-DD') as sell_date, 'Bible' as product from dual union all
select to_date('2020-06-02','YYYY-MM-DD') as sell_date, 'Mask' as product from dual union all
select to_date('2020-05-30','YYYY-MM-DD') as sell_date, 'T-Shirt' as product from dual
)
select to_char(sell_date,'YYYY-MM-DD') as sell_date, count(product) as num_sold, listagg(product,',') within group (order by sell_date) as products from (select distinct sell_date, product from activities) group by to_char(sell_date,'YYYY-MM-DD') order by sell_date;


-- #1495 - Friendly movies streamed last month - Report the distinct titles of the kid-friendly movies streamed in June 2020
with TVProgram as (
select to_date('2020-06-10 08:00','YYYY-MM-DD HH24:MI') as program_date, 1 as content_id, 'LC-Channel' as channel from dual union all
select to_date('2020-05-11 12:00','YYYY-MM-DD HH24:MI') as program_date, 2 as content_id, 'LC-Channel' as channel from dual union all
select to_date('2020-05-12 12:00','YYYY-MM-DD HH24:MI') as program_date, 3 as content_id, 'LC-Channel' as channel from dual union all
select to_date('2020-05-13 14:00','YYYY-MM-DD HH24:MI') as program_date, 4 as content_id, 'Disney Ch' as channel from dual union all
select to_date('2020-06-18 14:00','YYYY-MM-DD HH24:MI') as program_date, 4 as content_id, 'Disney Ch' as channel from dual union all
select to_date('2020-07-15 16:00','YYYY-MM-DD HH24:MI') as program_date, 5 as content_id, 'Disney Ch' as channel from dual
),
content as (
select 1 as content_id, 'Leetcode Movie' as title, 'N' as Kids_content, 'Movies' as content_type from dual union all
select 2 as content_id, 'Alg. for Kids' as title, 'Y' as Kids_content, 'Series' as content_type from dual union all
select 3 as content_id, 'Database Sols' as title, 'N' as Kids_content, 'Series' as content_type from dual union all
select 4 as content_id, 'Aladdin' as title, 'Y' as Kids_content, 'Movies' as content_type from dual union all
select 5 as content_id, 'Cinderella' as title, 'Y' as Kids_content, 'Movies' as content_type from dual
)
select c.title from TVProgram tv join content c on c.content_id = tv.content_id where tv.program_date between to_date('2020-06-01','YYYY-MM-DD') and last_day(to_date('2020-06-01','YYYY-MM-DD')) and c.kids_content = 'Y';


-- #1511 - Customer Order Frequency - Report the customer_id and customer_name of customers who have spent at least $100 in each month of June and July 2020
with customers as (
select 1 as customer_id, 'Winston' as name, 'USA' as country from dual union all
select 2 as customer_id, 'Jonathan' as name, 'Peru' as country from dual union all
select 3 as customer_id, 'Moustafa' as name, 'Egypt' as country from dual
),
product as (
select 10 as product_id, 'LC Phone' as description, 300 as price from dual union all
select 20 as product_id, 'LC T-Shirt' as description, 10 as price from dual union all
select 30 as product_id, 'LC Book' as description, 45 as price from dual union all
select 40 as product_id, 'LC Keychain' as description, 2 as price from dual
),
orders as (
select 1 as order_id, 1 as customer_id, 10 as product_id, to_date('2020-06-10','YYYY-MM-DD') as order_date, 1 as quantity from dual union all
select 2 as order_id, 1 as customer_id, 20 as product_id, to_date('2020-07-01','YYYY-MM-DD') as order_date, 1 as quantity from dual union all
select 3 as order_id, 1 as customer_id, 30 as product_id, to_date('2020-07-08','YYYY-MM-DD') as order_date, 2 as quantity from dual union all
select 4 as order_id, 2 as customer_id, 10 as product_id, to_date('2020-06-15','YYYY-MM-DD') as order_date, 2 as quantity from dual union all
select 5 as order_id, 2 as customer_id, 40 as product_id, to_date('2020-07-01','YYYY-MM-DD') as order_date, 10 as quantity from dual union all
select 6 as order_id, 3 as customer_id, 20 as product_id, to_date('2020-06-24','YYYY-MM-DD') as order_date, 2 as quantity from dual union all
select 7 as order_id, 3 as customer_id, 30 as product_id, to_date('2020-06-25','YYYY-MM-DD') as order_date, 2 as quantity from dual union all
select 9 as order_id, 3 as customer_id, 30 as product_id, to_date('2020-05-08','YYYY-MM-DD') as order_date, 3 as quantity from dual
)
select customer_id, name from (
    select o.customer_id, c.name,
    sum(case when to_char(o.order_date,'YYYY-MM') = '2020-06' then o.quantity * p.price end) as june_purchase,
    sum(case when to_char(o.order_date,'YYYY-MM') = '2020-07' then o.quantity * p.price end) as july_purchase
    from orders o join Product p on o.product_id = p.product_id join customers c on c.customer_id = o.customer_id
    group by o.customer_id, c.name
) where june_purchase >= 100 and july_purchase >= 100;


-- #1517 - Find Users with valid E-Mails - The prefix name is a string that may contain letters (upper or lower case), digits, underscore ‘_’, period ‘.’ and/or dash ‘-‘. The prefix name must start with a letter. The domain is @leetcode.com
with users as (
select 1 as user_id, 'Winston' as name, 'winston@leetcode.com' as email from dual union all
select 2 as user_id, 'Jonathan' as name, 'jonathanisgreat' as email from dual union all
select 3 as user_id, 'Annabelle' as name, 'bella-@leetcode.com' as email from dual union all
select 4 as user_id, 'Sally' as name, 'sally.come@leetcode.com' as email from dual union all
select 5 as user_id, 'Marwan' as name, 'quarz#2020@leetcode.com' as email from dual union all
select 6 as user_id, 'David' as name, 'david69@gmail.com' as email from dual union all
select 7 as user_id, 'Shapiro' as name, '.shapo@leetcode.com' as email from dual
)
select user_id, name, email from users where regexp_like(email, '^[a-zA-Z][a-zA-Z0-9._-]+@leetcode.com$');


-- #1527 - Patients with a condition, column 'conditions' contains 0 more spaces to seperate the condition. Report the patient_id, patient_name all conditions of patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1
with patients as (
select 1 as patient_id, 'Daniel' as patient_name, 'SADIAB100' as conditions from dual union all
select 2 as patient_id, 'Alice' as patient_name, null as conditions from dual union all
select 3 as patient_id, 'Bob' as patient_name, 'DIAB100 MYOP' as conditions from dual union all
select 4 as patient_id, 'George' as patient_name, 'ACNE DIAB100' as conditions from dual union all
select 5 as patient_id, 'Alain' as patient_name, 'DIAB201' as conditions from dual
)
select * from patients where regexp_like(conditions, '^DIAB1| DIAB1');


-- #1543 - Fix product name format - Report product_name in lowercase without leading or trailing white spaces, sale_date in the format 'YYYY-MM', total the number of times the product was sold in this month
with sales as (
select 1 as sale_id, '     LCPHONE    ' as product_name, to_date('2000-01-16','YYYY-MM-DD') as sale_date from dual union all
select 2 as sale_id, '   LCPhone      ' as product_name, to_date('2000-01-17','YYYY-MM-DD') as sale_date from dual union all
select 3 as sale_id, '    LcPhOnE     ' as product_name, to_date('2000-02-18','YYYY-MM-DD') as sale_date from dual union all
select 4 as sale_id, '     LCKeyCHAiN ' as product_name, to_date('2000-02-19','YYYY-MM-DD') as sale_date from dual union all
select 5 as sale_id, '  LCKeyChain    ' as product_name, to_date('2000-02-28','YYYY-MM-DD') as sale_date from dual union all
select 6 as sale_id, 'Matryoshka     ' as product_name, to_date('2000-03-31','YYYY-MM-DD') as sale_date from dual
)
select lower(trim(both ' ' from product_name)) as product_name, to_char(sale_date,'YYYY-MM') as sale_date, count(sale_id) as total from sales group by to_char(sale_date,'YYYY-MM'), lower(trim(both ' ' from product_name)) order by 1,2;


-- #1565 - Unique orders and customers per month - Find the number of unique orders and the number of unique customers with invoices > $20 for each different month
with orders as (
select 1 as order_id, to_date('2020-09-15','YYYY-MM-DD') as order_date, 1 as customer_id, 30 as invoice from dual union all
select 2 as order_id, to_date('2020-09-17','YYYY-MM-DD') as order_date, 2 as customer_id, 90 as invoice from dual union all
select 3 as order_id, to_date('2020-10-06','YYYY-MM-DD') as order_date, 3 as customer_id, 20 as invoice from dual union all
select 4 as order_id, to_date('2020-10-20','YYYY-MM-DD') as order_date, 3 as customer_id, 21 as invoice from dual union all
select 5 as order_id, to_date('2020-11-10','YYYY-MM-DD') as order_date, 1 as customer_id, 10 as invoice from dual union all
select 6 as order_id, to_date('2020-11-21','YYYY-MM-DD') as order_date, 2 as customer_id, 15 as invoice from dual union all
select 7 as order_id, to_date('2020-12-01','YYYY-MM-DD') as order_date, 4 as customer_id, 55 as invoice from dual union all
select 8 as order_id, to_date('2020-12-03','YYYY-MM-DD') as order_date, 4 as customer_id, 77 as invoice from dual union all
select 9 as order_id, to_date('2021-01-07','YYYY-MM-DD') as order_date, 3 as customer_id, 31 as invoice from dual union all
select 10 as order_id, to_date('2021-01-15','YYYY-MM-DD') as order_date, 2 as customer_id, 20 as invoice from dual
)
select to_char(order_date,'YYYY-MM') as month, count(distinct order_id) as order_count, count(distinct customer_id) as customer_count from orders where invoice > 20 group by to_char(order_date,'YYYY-MM') order by 1;


-- #1571 - Warehouse Manager - How much cubic feet of volume does the inventory occupy in each warehouse
with warehouse as (
select 'LCHouse1' as name, 1 as product_id, 1 as units from dual union all
select 'LCHouse1' as name, 2 as product_id, 10 as units from dual union all
select 'LCHouse1' as name, 3 as product_id, 5 as units from dual union all
select 'LCHouse2' as name, 1 as product_id, 2 as units from dual union all
select 'LCHouse2' as name, 2 as product_id, 2 as units from dual union all
select 'LCHouse3' as name, 4 as product_id, 1 as units from dual
),
products as (
select 1 as product_id, 'LC-TV' as product_name, 5 as width, 50 as length, 40 as height from dual union all
select 2 as product_id, 'LC-KeyChain' as product_name, 5 as width, 5 as length, 5 as height from dual union all
select 3 as product_id, 'LC-Phone' as product_name, 2 as width, 10 as length, 10 as height from dual union all
select 4 as product_id, 'LC-T-Shirt' as product_name, 4 as width, 10 as length, 20 as height from dual
)
select w.name as warehouse_name, sum(w.units * p.width * p.length * p.height) as volume from warehouse w join products p on p.product_id = w.product_id group by w.name;


-- #1582 - Customer who visited but did not make any transactions - Find the IDs of the users who visited without making any transactions and the number of times they made these types of visits
with visits as (
select 1 as visit_id, 23 as customer_id from dual union all
select 2 as visit_id, 9 as customer_id from dual union all
select 4 as visit_id, 30 as customer_id from dual union all
select 5 as visit_id, 54 as customer_id from dual union all
select 6 as visit_id, 96 as customer_id from dual union all
select 7 as visit_id, 54 as customer_id from dual union all
select 8 as visit_id, 54 as customer_id from dual
),
transactions as (
select 2 as transaction_id, 5 as visit_id, 310 as amount from dual union all
select 3 as transaction_id, 5 as visit_id, 300 as amount from dual union all
select 9 as transaction_id, 5 as visit_id, 200 as amount from dual union all
select 12 as transaction_id, 1 as visit_id, 910 as amount from dual union all
select 13 as transaction_id, 2 as visit_id, 970 as amount from dual
)
select v.customer_id, count(*) as count_no_trans from visits v where not exists (select 1 from transactions t where t.visit_id = v.visit_id) group by v.customer_id;


-- #1587 - Bank Account Summary II
with users as (
select 900001 as account, 'Alice' as name from dual union all
select 900002 as account, 'Bob' as name from dual union all
select 900003 as account, 'Charlie' as name from dual
),
transactions as (
select 1 as trans_id, 900001 as account, 7000 as amount, to_date('2020-08-01','YYYY-MM-DD') as transacted_on from dual union all
select 2 as trans_id, 900001 as account, 7000 as amount, to_date('2020-09-01','YYYY-MM-DD') as transacted_on from dual union all
select 3 as trans_id, 900001 as account, -3000 as amount, to_date('2020-09-02','YYYY-MM-DD') as transacted_on from dual union all
select 4 as trans_id, 900002 as account, 1000 as amount, to_date('2020-09-12','YYYY-MM-DD') as transacted_on from dual union all
select 5 as trans_id, 900003 as account, 6000 as amount, to_date('2020-08-07','YYYY-MM-DD') as transacted_on from dual union all
select 6 as trans_id, 900003 as account, 6000 as amount, to_date('2020-09-07','YYYY-MM-DD') as transacted_on from dual union all
select 7 as trans_id, 900003 as account, -4000 as amount, to_date('2020-09-11','YYYY-MM-DD') as transacted_on from dual
)
select u.name, sum(t.amount) as balance from transactions t join users u on u.account = t.account group by u.name having sum(t.amount) > 10000;


-- #1607 - Seller with no Sales - Report the names of all sellers who did not make any sales in 2020
with customer as (
select 101 as customer_id, 'Alice' as customer_name from dual union all
select 102 as customer_id, 'Bob' as customer_name from dual union all
select 103 as customer_id, 'Charlie' as customer_name from dual
),
orders as (
select 1 as order_id, to_date('2020-03-01','YYYY-MM-DD') as sale_date, 1500 as order_cost, 101 as customer_id, 1 as seller_id from dual union all
select 2 as order_id, to_date('2020-05-25','YYYY-MM-DD') as sale_date, 2400 as order_cost, 102 as customer_id, 2 as seller_id from dual union all
select 3 as order_id, to_date('2019-05-25','YYYY-MM-DD') as sale_date, 800 as order_cost, 101 as customer_id, 3 as seller_id from dual union all
select 4 as order_id, to_date('2020-09-13','YYYY-MM-DD') as sale_date, 1000 as order_cost, 103 as customer_id, 2 as seller_id from dual union all
select 5 as order_id, to_date('2019-02-11','YYYY-MM-DD') as sale_date, 700 as order_cost, 101 as customer_id, 2 as seller_id from dual
),
seller as (
select 1 as seller_id, 'Daniel' as seller_name from dual union all
select 2 as seller_id, 'Elizabeth' as seller_name from dual union all
select 3 as seller_id, 'Frank' as seller_name from dual
)
select s.seller_name from seller s where not exists (select 1 from orders o where o.seller_id = s.seller_id and extract(year from o.sale_date) = 2020);


-- #1623 - All valid Triplets - The country is joining a competition and wants to select one student from each school to represent the country such that
-- member_A is selected from SchoolA, member_B is selected from SchoolB, member_C is selected from SchoolC, and
-- The selected students’ names and IDs are pairwise distinct (i.e. no two students share the same name, and no two students share the same ID)
with schoolA as (
select 1 as student_id, 'Alice' as student_name from dual union all
select 2 as student_id, 'Bob' as student_name from dual
),
schoolB as (
select 3 as student_id, 'Tom' as student_name from dual
),
schoolC as (
select 3 as student_id, 'Tom' as student_name from dual union all
select 2 as student_id, 'Jerry' as student_name from dual union all
select 10 as student_id, 'Alice' as student_name from dual
)
select a.student_name as member_a, b.student_name as member_b, c.student_name as member_c from schoolA a join schoolB b on a.student_id <> b.student_id and a.student_name <> b.student_name join schoolC c on c.student_id <> b.student_id and c.student_name <> b.student_name and c.student_id <> a.student_id and c.student_name <> a.student_name;


-- #1633 - Percentage of Users Attended a contest - rounded to two decimals ordered by percentage in descending ,contest_id in ascending
with users as (
select 6 as user_id, 'Alice' as user_name from dual union all
select 2 as user_id, 'Bob' as user_name from dual union all
select 7 as user_id, 'Alex' as user_name from dual
),
register as (
select 215 as contest_id, 6 as user_id from dual union all
select 209 as contest_id, 2 as user_id from dual union all
select 208 as contest_id, 2 as user_id from dual union all
select 210 as contest_id, 6 as user_id from dual union all
select 208 as contest_id, 6 as user_id from dual union all
select 209 as contest_id, 7 as user_id from dual union all
select 209 as contest_id, 6 as user_id from dual union all
select 215 as contest_id, 7 as user_id from dual union all
select 208 as contest_id, 7 as user_id from dual union all
select 210 as contest_id, 2 as user_id from dual union all
select 207 as contest_id, 2 as user_id from dual union all
select 210 as contest_id, 7 as user_id from dual
)
select contest_id, round(count(distinct user_id) / (select count(*) from users) * 100,2) as percentage from register group by contest_id order by 2 desc,1;


-- #1661 - Average time of process per machine - The time to complete a process is the ‘end’ timestamp minus the ‘start’ timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run
with activity as (
select 0 as machine_id, 0 as process_id, 'start' as activity_type, 0.712 as timestamp from dual union all
select 0 as machine_id, 0 as process_id, 'end' as activity_type, 1.520 as timestamp from dual union all
select 0 as machine_id, 1 as process_id, 'start' as activity_type, 3.140 as timestamp from dual union all
select 0 as machine_id, 1 as process_id, 'end' as activity_type, 4.120 as timestamp from dual union all
select 1 as machine_id, 0 as process_id, 'start' as activity_type, 0.550 as timestamp from dual union all
select 1 as machine_id, 0 as process_id, 'end' as activity_type, 1.550 as timestamp from dual union all
select 1 as machine_id, 1 as process_id, 'start' as activity_type, 0.430 as timestamp from dual union all
select 1 as machine_id, 1 as process_id, 'end' as activity_type, 1.420 as timestamp from dual union all
select 2 as machine_id, 0 as process_id, 'start' as activity_type, 4.100 as timestamp from dual union all
select 2 as machine_id, 0 as process_id, 'end' as activity_type, 4.512 as timestamp from dual union all
select 2 as machine_id, 1 as process_id, 'start' as activity_type, 2.500 as timestamp from dual union all
select 2 as machine_id, 1 as process_id, 'end' as activity_type, 5.000 as timestamp from dual
)
select machine_id, round((sum(case when activity_type = 'end' then timestamp else 0 end) - sum(case when activity_type = 'start' then timestamp else 0 end))/count(distinct process_id),3) as processing_time from activity group by machine_id order by machine_id;


-- #1667 - Fix Names in a Table - Make the first character capitalize and other small
with users as (
select 1 as user_id, 'aLice' as name from dual union all
select 2 as user_id, 'bOB' as name from dual
)
select user_id, initcap(name) as name from users order by user_id;


-- #1677 - Product's worth over invoices - Return each product name with total amount due, paid, canceled, and refunded across all invoices
with product as (
select 0 as product_id, 'ham' as name from dual union all
select 1 as product_id, 'bacon' as name from dual
),
invoice as (
select 23 as invoice_id, 0 as product_id, 2 as rest, 0 as paid, 5 as cancelled, 0 as refunded from dual union all
select 12 as invoice_id, 0 as product_id, 0 as rest, 4 as paid, 0 as cancelled, 3 as refunded from dual union all
select 1 as invoice_id, 1 as product_id, 1 as rest, 1 as paid, 0 as cancelled, 1 as refunded from dual union all
select 2 as invoice_id, 1 as product_id, 1 as rest, 0 as paid, 1 as cancelled, 1 as refunded from dual union all
select 3 as invoice_id, 1 as product_id, 0 as rest, 1 as paid, 1 as cancelled, 1 as refunded from dual union all
select 4 as invoice_id, 1 as product_id, 1 as rest, 1 as paid, 1 as cancelled, 0 as refunded from dual
)
select p.name, sum(rest) as rest, sum(paid) as paid , sum(cancelled) as cancelled, sum(refunded) as refunded from invoice i join product p on p.product_id = i.product_id group by p.name;


-- #1683 - Invalid Tweets
with tweets as (
select 1 as tweet_id, 'Vote for Biden' as content from dual union all
select 2 as tweet_id, 'Let us make America great again!' as content from dual
)
select tweet_id from tweets where length(trim(content)) > 15;


-- #1693 - Daily leads and Partners - for each date_id and make_name, return the number of distinct lead_id’s and distinct partner_id’s.
with dailySales as (
select to_date('2020-12-08','YYYY-MM-DD') as date_id, 'toyota' as make_name, 0 as lead_id, 1 as partner_id from dual union all
select to_date('2020-12-08','YYYY-MM-DD') as date_id, 'toyota' as make_name, 1 as lead_id, 0 as partner_id from dual union all
select to_date('2020-12-08','YYYY-MM-DD') as date_id, 'toyota' as make_name, 1 as lead_id, 2 as partner_id from dual union all
select to_date('2020-12-07','YYYY-MM-DD') as date_id, 'toyota' as make_name, 0 as lead_id, 2 as partner_id from dual union all
select to_date('2020-12-07','YYYY-MM-DD') as date_id, 'toyota' as make_name, 0 as lead_id, 1 as partner_id from dual union all
select to_date('2020-12-08','YYYY-MM-DD') as date_id, 'honda' as make_name, 1 as lead_id, 2 as partner_id from dual union all
select to_date('2020-12-08','YYYY-MM-DD') as date_id, 'honda' as make_name, 2 as lead_id, 1 as partner_id from dual union all
select to_date('2020-12-07','YYYY-MM-DD') as date_id, 'honda' as make_name, 0 as lead_id, 1 as partner_id from dual union all
select to_date('2020-12-07','YYYY-MM-DD') as date_id, 'honda' as make_name, 1 as lead_id, 2 as partner_id from dual union all
select to_date('2020-12-07','YYYY-MM-DD') as date_id, 'honda' as make_name, 2 as lead_id, 1 as partner_id from dual
)
select to_char(date_id,'YYYY-MM-DD') as date_id, make_name, count(distinct lead_id) as unique_leads, count(distinct partner_id) as unique_partners from dailySales group by date_id, make_name;


-- #1729 - Find followers count
with followers as (
select 0 as user_id, 1 as follower_id from dual union all
select 1 as user_id, 0 as follower_id from dual union all
select 2 as user_id, 0 as follower_id from dual union all
select 2 as user_id, 1 as follower_id from dual
)
select user_id, count(distinct follower_id) as followers_count from followers group by user_id order by user_id;


-- #1731 - The Number of Employees which report to each employee
-- Write an SQL query to report the ids and the names of the people that other employees reported to (excluding null values), the number of employees who report to them, and the average age of those members rounded to the nearest integer
with employees as (
select 9 as employee_id, 'Hercy' as name, null as reports_to, 43 as age from dual union all
select 6 as employee_id, 'Alice' as name, 9 as reports_to, 41 as age from dual union all
select 4 as employee_id, 'Bob' as name, 9 as reports_to, 36 as age from dual union all
select 2 as employee_id, 'Winston' as name, null as reports_to, 37 as age from dual
)
select e1.employee_id, e1.name, count(e2.employee_id) as reports_count, round(avg(e2.age)) as average_age from employees e1 join employees e2 on e1.employee_id = e2.reports_to group by e1.employee_id, e1.name;


-- #1741 - Find total time spent by each Employee
with employees as (
select 1 as emp_id, to_date('2020-11-28','YYYY-MM-DD') as event_day, 4 as in_time, 32 as out_time from dual union all
select 1 as emp_id, to_date('2020-11-28','YYYY-MM-DD') as event_day, 55 as in_time, 200 as out_time from dual union all
select 1 as emp_id, to_date('2020-12-03','YYYY-MM-DD') as event_day, 1 as in_time, 42 as out_time from dual union all
select 2 as emp_id, to_date('2020-11-28','YYYY-MM-DD') as event_day, 3 as in_time, 33 as out_time from dual union all
select 2 as emp_id, to_date('2020-12-09','YYYY-MM-DD') as event_day, 47 as in_time, 74 as out_time from dual
)
select to_char(event_day,'YYYY-MM-DD') as day, emp_id, sum(out_time - in_time) as total_time from employees group by event_day, emp_id;


-- #1757 - Recyclable and Low Fat Products
with products as (
select 0 as product_id, 'Y' as low_fats, 'N' as recyclable from dual union all
select 1 as product_id, 'Y' as low_fats, 'Y' as recyclable from dual union all
select 2 as product_id, 'N' as low_fats, 'Y' as recyclable from dual union all
select 3 as product_id, 'Y' as low_fats, 'Y' as recyclable from dual union all
select 4 as product_id, 'N' as low_fats, 'N' as recyclable from dual
)
select product_id from products where low_fats = 'Y' and recyclable = 'Y';


-- #1777 - Product's Price for Each Store
with products as (
select 0 as product_id, 'store1' as store, 95 as price from dual union all
select 0 as product_id, 'store3' as store, 105 as price from dual union all
select 0 as product_id, 'store2' as store, 100 as price from dual union all
select 1 as product_id, 'store1' as store, 70 as price from dual union all
select 1 as product_id, 'store3' as store, 80 as price from dual
)
select product_id, store1, store2, store3 from products pivot (sum(price) for store in ('store1' as store1, 'store2' as store2, 'store3' as store3));


-- #1789 - Primary Department for each Employee - When employee belong to multiple department then use primary_flag
with employees as (
select 1 as employee_id, 1 as department_id, 'N' as primary_flag from dual union all
select 2 as employee_id, 1 as department_id, 'Y' as primary_flag from dual union all
select 2 as employee_id, 2 as department_id, 'N' as primary_flag from dual union all
select 3 as employee_id, 3 as department_id, 'N' as primary_flag from dual union all
select 4 as employee_id, 2 as department_id, 'N' as primary_flag from dual union all
select 4 as employee_id, 3 as department_id, 'Y' as primary_flag from dual union all
select 4 as employee_id, 4 as department_id, 'N' as primary_flag from dual
)
select employee_id, department_id from employees where primary_flag = 'Y' or employee_id in (select employee_id from employees group by employee_id having count(*) = 1);


-- #1795 - Rearrange Product Table
with products as (
select 0 as product_id, 95 as store1, 100 as store2, 105 as store3 from dual union all
select 1 as product_id, 70 as store1, null as store2, 80 as store3 from dual
)
select product_id, 'store1' as store, store1 as price from products where store1 is not null union all
select product_id, 'store2' as store, store2 as price from products where store2 is not null union all
select product_id, 'store3' as store, store3 as price from products where store3 is not null order by product_id, store;


-- #1809 - Ad-Free Sessions - It is guaranteed that start_time <= end_time and that two sessions for the same customer do not intersect. Report all the sessions that did not get shown any ads
-- Sessions where when lookup against playback the timestamp won't match between start and end time
with playback as (
select 1 as session_id, 1 as customer_id, 1 as start_time, 5 as end_time from dual union all
select 2 as session_id, 1 as customer_id, 15 as start_time, 23 as end_time from dual union all
select 3 as session_id, 2 as customer_id, 10 as start_time, 12 as end_time from dual union all
select 4 as session_id, 2 as customer_id, 17 as start_time, 28 as end_time from dual union all
select 5 as session_id, 2 as customer_id, 2 as start_time, 8 as end_time from dual
),
ads as (
select 1 as ad_id, 1 as customer_id, 5 as timestamp from dual union all
select 2 as ad_id, 2 as customer_id, 17 as timestamp from dual union all
select 3 as ad_id, 2 as customer_id, 20 as timestamp from dual
) -- timestamp is the moment of time at which the ad was shown
select session_id from playback p left join ads a on p.customer_id = a.customer_id and a.timestamp between p.start_time and p.end_time where a.ad_id is null;


-- #1821 - Find Customers with Positive Revenue This Year - Report the customers with postive revenue in the year 2021
with customers as (
select 1 as customer_id, 2018 as year, 50 as revenue from dual union all
select 1 as customer_id, 2021 as year, 30 as revenue from dual union all
select 1 as customer_id, 2020 as year, 70 as revenue from dual union all
select 2 as customer_id, 2021 as year, -50 as revenue from dual union all
select 3 as customer_id, 2018 as year, 10 as revenue from dual union all
select 3 as customer_id, 2016 as year, 50 as revenue from dual union all
select 4 as customer_id, 2021 as year, 20 as revenue from dual
)
select customer_id from customers where year = 2021 and revenue > 0;


-- #1853 - Convert Date Format
with days as (
select to_date('2022-04-12','YYYY-MM-DD') as day from dual union all
select to_date('2021-08-09','YYYY-MM-DD') as day from dual union all
select to_date('2020-06-26','YYYY-MM-DD') as day from dual
)
select trim(to_char(day,'Day'))||', '||trim(to_char(day,'Month'))||' '||extract(day from day)||', '||extract(year from day) as day from days;


-- Open #1873 - Calculate Special Bonus - The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee name does not start with the character ‘M’. The bonus of an employee is 0 otherwise.
with employees as (
select 2 as employee_id, 'Meir' as name, 3000 as salary from dual union all
select 3 as employee_id, 'Michael' as name, 3800 as salary from dual union all
select 7 as employee_id, 'Addilyn' as name, 7400 as salary from dual union all
select 8 as employee_id, 'Juan' as name, 6100 as salary from dual union all
select 9 as employee_id, 'Kannon' as name, 7700 as salary from dual
)
select employee_id, case when mod(employee_id,2) = 1 and lower(name) not like 'm%' then salary else 0 end as bonus from employees order by employee_id;


-- #1890 - The latest login in 2020
with logins as (
select 6 as user_id, to_date('2020-06-30 15:06:07', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 6 as user_id, to_date('2021-04-21 14:06:06', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 6 as user_id, to_date('2019-03-07 00:18:15', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 8 as user_id, to_date('2020-02-01 05:10:53', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 8 as user_id, to_date('2020-12-30 00:46:50', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 2 as user_id, to_date('2020-01-16 02:49:50', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 2 as user_id, to_date('2019-08-25 07:59:08', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 14 as user_id, to_date('2019-07-14 09:00:00', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 14 as user_id, to_date('2021-01-06 11:59:59', 'YYYY-MM-DD HH24:MI:SS') as time_stamp from dual
)
select user_id, max(time_stamp) as last_stamp from logins where extract(year from time_stamp) = 2020 group by user_id;


-- #1939 - Users that actively request confirmation messages - Write an SQL query to find the IDs of the users that requested a confirmation message twice within a 24-hour window. Two messages exactly 24 hours apart are considered to be within the window.
with signups as (
select 3 as user_id, to_date('2020-03-21 10:16:13','YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 7 as user_id, to_date('2020-01-04 13:57:59','YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 2 as user_id, to_date('2020-07-29 23:09:44','YYYY-MM-DD HH24:MI:SS') as time_stamp from dual union all
select 6 as user_id, to_date('2020-12-09 10:39:37','YYYY-MM-DD HH24:MI:SS') as time_stamp from dual
),
confirmations as (
select 3 as user_id, to_date('2021-01-06 03:30:46','YYYY-MM-DD HH24:MI:SS') as time_stamp, 'timeout' as action from dual union all
select 3 as user_id, to_date('2021-01-06 03:37:45','YYYY-MM-DD HH24:MI:SS') as time_stamp, 'timeout' as action from dual union all
select 7 as user_id, to_date('2021-06-12 11:57:29','YYYY-MM-DD HH24:MI:SS') as time_stamp, 'confirmed' as action from dual union all
select 7 as user_id, to_date('2021-06-13 11:57:30','YYYY-MM-DD HH24:MI:SS') as time_stamp, 'confirmed' as action from dual union all
select 2 as user_id, to_date('2021-01-22 00:00:00','YYYY-MM-DD HH24:MI:SS') as time_stamp, 'confirmed' as action from dual union all
select 2 as user_id, to_date('2021-01-23 00:00:00','YYYY-MM-DD HH24:MI:SS') as time_stamp, 'timeout' as action from dual union all
select 6 as user_id, to_date('2021-10-23 14:14:14','YYYY-MM-DD HH24:MI:SS') as time_stamp, 'confirmed' as action from dual union all
select 6 as user_id, to_date('2021-10-24 14:14:13','YYYY-MM-DD HH24:MI:SS') as time_stamp, 'timeout' as action from dual
)
select user_id from confirmations group by user_id having max(time_stamp) - min(time_stamp) <= 1;


-- Open #1956 - Employees with missing information - Either employee name is missing or salary is missing
with employees as (
select 2 as employee_id, 'Crew' as name from dual union all
select 4 as employee_id, 'Haven' as name from dual union all
select 5 as employee_id, 'Kristian' as name from dual
),
salaries as (
select 5 as employee_id, 76071 as salary from dual union all
select 1 as employee_id, 22517 as salary from dual union all
select 4 as employee_id, 63539 as salary from dual
)
select nvl(e.employee_id, s.employee_id) as employee_id from employees e full join salaries s on e.employee_id = s.employee_id where e.employee_id is null or s.employee_id is null order by 1;


-- #1978 - Employees whose Manager left the company - Write an SQL query to report the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. Return the result table ordered by employee_id
with employees as (
select 3 as employee_id, 'Mila' as name, 9 as manager_id, 60301 as salary from dual union all
select 12 as employee_id, 'Antonella' as name, null as manager_id, 31000 as salary from dual union all
select 13 as employee_id, 'Emery' as name, null as manager_id, 67084 as salary from dual union all
select 1 as employee_id, 'Kalel' as name, 11 as manager_id, 21241 as salary from dual union all
select 9 as employee_id, 'Mikaela' as name, null as manager_id, 50937 as salary from dual union all
select 11 as employee_id, 'Joziah' as name, 6 as manager_id, 28485 as salary from dual
)
select employee_id from employees where salary < 30000 and manager_id not in (select distinct employee_id from employees);


-- #2026 - Low-Quality problem. low-quality if the like percentage of the problem (number of likes divided by the total number of votes) is strictly less than 60%
with problems as (
select 6 as problem_id, 1290 as likes, 415 as dislikes from dual union all
select 11 as problem_id, 2677 as likes, 8659 as dislikes from dual union all
select 1 as problem_id, 4446 as likes, 2760 as dislikes from dual union all
select 7 as problem_id, 8569 as likes, 6086 as dislikes from dual union all
select 13 as problem_id, 2050 as likes, 4164 as dislikes from dual union all
select 10 as problem_id, 9002 as likes, 7446 as dislikes from dual
)
select problem_id from problems where (likes/(likes+dislikes))*100 < 60 order by problem_id;


-- # Leetcode Medium

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



-- # Leetcode Hard

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


















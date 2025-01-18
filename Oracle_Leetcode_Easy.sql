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
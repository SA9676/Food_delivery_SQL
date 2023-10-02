-- Create the database
CREATE DATABASE Project_work;
USE Project_work;

-- Create table goldusers_signup
DROP TABLE IF EXISTS goldusers_signup;
CREATE TABLE goldusers_signup (userid INTEGER, gold_signup_date DATE);

-- Insert data into goldusers_signup
INSERT INTO goldusers_signup (userid, gold_signup_date)
VALUES
    (1, '2017-07-22'),
    (3, '2017-04-21');

-- Create table users
DROP TABLE IF EXISTS users;
CREATE TABLE users (userid INTEGER, signup_date DATE);

-- Insert data into users
INSERT INTO users (userid, signup_date)
VALUES
    (1, '2014-09-02'),
    (2, '2015-01-15'),
    (3, '2014-04-11');

-- Create table sales
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (userid INTEGER, created_date DATE, product_id INTEGER);

-- Insert data into sales
INSERT INTO sales (userid, created_date, product_id)
VALUES
    (1, '2017-04-19', 2),
    (3, '2019-12-18', 1),
    (2, '2020-07-20', 3),
    (1, '2019-10-23', 2),
    (1, '2018-03-19', 3),
    (3, '2016-12-20', 2),
    (1, '2016-11-09', 1),
    (1, '2016-05-20', 3),
    (2, '2017-09-24', 1),
    (1, '2017-03-11', 2),
    (1, '2016-03-11', 1),
    (3, '2016-11-10', 1),
    (3, '2017-12-07', 2),
    (3, '2016-12-15', 2),
    (2, '2017-11-08', 2),
    (2, '2018-09-10', 3);

-- Create table product
DROP TABLE IF EXISTS product;
CREATE TABLE product (product_id INTEGER, product_name TEXT, price INTEGER);

-- Insert data into product
INSERT INTO product (product_id, product_name, price)
VALUES
    (1, 'p1', 980),
    (2, 'p2', 870),
    (3, 'p3', 330);

select * from sales;
select * from product;
select * from goldusers_signup; select * from users;

 -- 1) what is the total amount spent by each customer?
 -- So, the approach used was that first we need to join the tables and then do a group by.

 select s.userid,sum(p.price) as Total_spent_amount
 from sales s
 inner join product p on s.product_id=p.product_id
 group by s.userid;

 -- 2) The number of days for which customer has ordered from app?

 select userid,count( distinct created_date) as No_of_days
 from sales
 group by userid;

 -- 3) What was the first product purchased by each customer?

Select * from 
(select *, rank() over (partition by userid order by created_date) as rn
 from sales) A where rn=1;

 -- 4) What is the most purchased item by each customer and how many times?

 with B as
 (
 select *, rank() over (partition by userid order by no_of_purchase desc) as rn
from
 (select userid,product_id,count(1) as no_of_purchase
 from sales
 group by userid,product_id
 order by userid) A
 )

 select * from B
 where rn=1;


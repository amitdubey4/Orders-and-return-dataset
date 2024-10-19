select order_id, order_date, sales from orders_data;
select region from orders_data
group by region;

select * from orders_data
limit 10 offset 2;

select * from orders_data
order by order_date desc, profit desc;

#order of excution from - where - groupby - having - select - orderby - limit

select *, Round(profit/sales,2) as Ratio from orders_data;

select * from orders_data
where region = 'West';

select * from orders_data
where order_date = '2018-06-09';

select * from orders_data
where quantity > 3;

select * from orders_data
where region = 'central' and category = 'technology' and quantity >2;

select * from orders_data
where (region = 'west' or category = 'technology') and quantity >5;

select * from orders_data
#where quantity between 3 and 7
where quantity IN(3,4,5,6,7)
order by quantity;

select * from orders_data
where city IN('Los Angeles', 'Dover');

select * from orders_data
where order_date between '2018-08-27' and '2020-06-12'
order by order_date;

#pattern matching 

select * from orders_data
where customer_name like '_a%';

select * from orders_data
where customer_name REGEXP '^.[ae].*n$';

#aggregate
select sum(sales) as total_sales from orders_data;
select avg(sales) as average_sales from orders_data;
select count(sales) as count_of_sales from orders_data;
select max(sales) as max_sales from orders_data;
select min(sales) as min_sales from orders_data;

select * from orders_data;
SET SQL_SAFE_UPDATES = 0;

update orders_data
set region = NULL
where order_id = 'CA-2018-115812';

select * from orders_data
where region is not null;

select count(*), count(order_id), count(region), count(distinct(region)) from orders_data;

select distinct category, region from orders_data;

select category, Round(sum(sales), 4) as total_sales, Round(sum(profit), 4) as category_profit
from orders_data
group by category;

select category, coalesce(region,'No Value') as region, Round(sum(sales), 4) as total_sales, Round(sum(profit), 4) as category_profit
from orders_data
group by category, region
order by region;


select * from orders_data;
select city, sum(sales) as city_sales
from orders_data
where region = 'central'
group by city
having sum(sales)> 500
order by city
limit 2;

# from-> where-> group by-> having-> order by-> limit

select * from orders_data;
select * from returns_data;

select sum(sales)
from orders_data as OD
inner join returns_data as rd
on od.order_id = rd.order_id;

select category, sum(sales)
from orders_data as OD
inner join returns_data as rd
on od.order_id = rd.order_id
group by category;

select *
from orders_data as OD
left join returns_data as rd
on od.order_id = rd.order_id
where rd.return_reason is null;

select coalesce(new_return_reason, 'Succesfull Orders') as Return_orders, Round(sum(sales),2) as sum_of_sales_affect from orders_data as OD 
left join 
	(
		select *,
		case 
			when return_reason = 'Wrong Item' then 'Wrong Items' else return_reason end as new_return_reason
        from returns_data
    ) as RD
on OD.order_id = RD.order_id
group by RD.new_return_reason
order by sum_of_sales_affect;


select RD.new_return_reason as return_reason, Round(sum(sales),2) as sum_of_sales_affect from orders_data as OD 
left join 
	(
		select *,
		case 
			when return_reason = 'Wrong Item' then 'Wrong Items' else return_reason end as new_return_reason
        from returns_data
    ) as RD
on OD.order_id = RD.order_id
group by RD.new_return_reason
having return_reason is not null
order by sum_of_sales_affect;

select * from orders_data;

select *,
length(customer_name) as cust_len,
right(order_id, 6) as order_ids,
substring(order_id, 1,2) as country_code
from orders_data;

# date function
select Year(order_date) as Yearly_orders, Round(sum(sales),2) as Yearly_sales from orders_data
group by Year(order_date)
order by Yearly_orders;

select order_id, order_date, ship_date,
#datediff(ship_date, order_date) as delivery_days
TIMESTAMPDIFF(day, order_date, ship_date) as delivery_month
from orders_data;
# to extract hour, day, week, month, year

select order_id, order_date, ship_date,
date_add(order_date, interval 5 day) as new_order_date
from orders_data;

































































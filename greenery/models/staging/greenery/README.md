How many users do we have?

Query: 
select 
    count(distinct user_id) Total_Users
from dev_db.dbt_sanjeevramasamy.stg_greenery_users;

Result: 130

On average, how many orders do we receive per hour?
with cte as(

Query:
select 
    DATE(created_at),
    hour(created_at), 
    count(*) as CNT
from dev_db.dbt_sanjeevramasamy.stg_greenery_orders
group by DATE(created_at),hour(created_at)
)
select 
    avg(CNT) 
from cte;

Result: 7.520833

On average, how long does an order take from being placed to being delivered?

Query:
with cte as (
select 
    datediff(days, created_at, delivered_at) as Diff 
from dev_db.dbt_sanjeevramasamy.stg_greenery_orders
)

SELECT AVG(Diff) Avg_Days from cte;

Result: 3.891803

How many users have only made one purchase? Two purchases? Three+ purchases?
Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

Query:
with cte as
(select 
    user_id,
    count(order_id) orders 
from dev_db.dbt_sanjeevramasamy.stg_greenery_orders
group by user_id
 ),

cte2 as
(select
    case when orders = 1 then 'One Purchase'
    when orders = 2 then 'Two Purchases'
    else 'Three+ Purchases' end as Purchases 
from cte
) 

select 
    Purchases, 
    count(*) Numbers
from cte2
group by Purchases
 ;

PURCHASES	        NUMBERS
Three+ Purchases	71
One Purchase	    25
Two Purchases	    28

On average, how many unique sessions do we have per hour?
with cte as (
select 
    DATE(created_at),
    hour(created_at), 
    count(distinct session_id) unique_sessions
from dev_db.dbt_sanjeevramasamy.stg_greenery_events
group by DATE(created_at),hour(created_at)
)

select
    avg(unique_sessions) Avg_Uniq_Sessions
from cte;

Result:16.327586
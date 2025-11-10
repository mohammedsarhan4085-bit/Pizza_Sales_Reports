use pizza
GO
CREATE OR ALTER VIEW Total_Revenue AS
select
	SUM(total_price) as [Total Revenue] 
FROM 
	PIZZA_SALES;
GO
CREATE OR ALTER VIEW AVG_Order_Value AS
select
	sum(total_price) / COUNT(distinct order_id) as [AVG_Order_Value]
from
	pizza_sales;
GO
CREATE OR ALTER VIEW Total_Pizzas_Sold AS
select 
	SUM(quantity) as [Total_Pizzas_Sold]
FROM
	pizza_sales;
GO
CREATE OR ALTER VIEW Total_Orders AS
select
	COUNT(distinct order_id) as [Total_Orders]
from
	pizza_sales;
GO
CREATE OR ALTER VIEW AVG_Pizzas_Per_Order AS
select 
	format(
		cast(SUM(quantity) as decimal(10,2)) /
		cast(count(distinct order_id) as decimal(10,2)),
		'n2') as [AVG_Pizzas_Per_Order]
from
	pizza_sales;

GO
CREATE OR ALTER VIEW Daily_Trend_For_Total_Orders AS
SELECT 
    DATEPART(WEEKDAY,order_date) AS Day_Num,
    DATENAME(WEEKDAY,order_date) AS Order_day,
    COUNT(DISTINCT order_id) AS Total_orders
FROM
	pizza_sales
GROUP BY
	DATENAME(WEEKDAY,order_date),DATEPART(WEEKDAY,order_date);

GO
CREATE OR ALTER VIEW monthly_trend_for_total_orders AS	
SELECT 
    DATEPART(MONTH,order_date) AS Month_Num,
    DATENAME(MONTH,order_date) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_orders
FROM 
	pizza_sales
GROUP BY 
	DATENAME(MONTH,order_date),DATEPART(MONTH,order_date);

GO
CREATE OR ALTER VIEW percent_Of_Sales_By_Pizza_Category AS	
SELECT
	pizza_category,cast(sum(total_price)as decimal(10,2)) as Total_Revenue,
	cast(SUM(TOTAL_PRICE)*100/(select sum(total_price) from pizza_sales) as decimal(10,2)) as PCT
from
	pizza_sales
group by
	pizza_category
order by
	pizza_category;

GO
CREATE OR ALTER VIEW percent_Of_Sales_By_Pizza_Size AS	
SELECT
	pizza_size,cast(sum(total_price)as decimal(10,2)) as Total_Revenue,
	cast(SUM(TOTAL_PRICE)*100/(select sum(total_price) from pizza_sales) as decimal(10,2)) as PCT
from
	pizza_sales
group by
	pizza_size
order by 
	pizza_size;

GO
CREATE OR ALTER VIEW Total_Pizzas_Sold_by_Pizza_Category AS	
SELECT
	pizza_category,sum(quantity) as Total_Quantity_Sold
from
	pizza_sales
group by 
	pizza_category;

GO
CREATE OR ALTER VIEW Top_5_Pizzas_by_Revenue AS	
select top 5
	pizza_name,SUM(total_price) as [Total_Revenue] 
from
	pizza_sales
group by
	pizza_name
order by
	Total_Revenue desc;

GO
CREATE OR ALTER VIEW Bottom_5_Pizzas_by_Revenue AS	
select top 5
	pizza_name,SUM(total_price) as [Total_Revenue] 
from
	pizza_sales
group by
	pizza_name
order by
	Total_Revenue asc;

GO
CREATE OR ALTER VIEW Top_5_Pizzas_by_Quantity AS	
select top 5
	pizza_name,SUM(quantity) as [Total_Pizzas_Sold]
from
	pizza_sales
group by
	pizza_name
order by
	Total_Pizzas_Sold desc;

GO
CREATE OR ALTER VIEW bottom_5_Pizzas_by_Quantity AS
select top 5
	pizza_name,SUM(quantity) as [Total_Pizzas_Sold]
from
	pizza_sales
group by
	pizza_name
order by
	Total_Pizzas_Sold asc;

GO
CREATE OR ALTER VIEW top_5_Pizzas_by_Total_Order AS
select top 5
	pizza_name,COUNT(distinct order_id) as [Total_Orders]
from
	pizza_sales
group by
	pizza_name
order by
	Total_Orders desc;

GO
CREATE OR ALTER VIEW bottom_5_Pizzas_by_Total_Order AS
select top 5
	pizza_name,COUNT(distinct order_id) as [Total_Orders]
from
	pizza_sales
group by
	pizza_name
order by
	Total_Orders asc;
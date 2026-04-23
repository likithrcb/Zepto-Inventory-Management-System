create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

--data exploration

--count of rows

SELECT COUNT(*)FROM ZEPTO;

SELECT * FROM ZEPTO
ORDER BY ZEPTO;
LIMIT 10;

--null values
SELECT * FROM ZEPTO
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountpercent IS NULL
OR
discountedsellingprice IS NULL
OR
weightingms IS NULL
OR
outofstock IS NULL
OR
availablequantity IS NULL
OR
quantity is NULL;

--different product categories

SELECT DISTINCT category
from ZEPTO
ORDER BY category;

--product in stock and out of stock
SELECT outOfStock,COUNT(sku_id)
FROM ZEPTO
GROUP BY outOfStock;

--produvcts name present multiple time
SELECT name, COUNT(sku_id)as "Number of SKUs"
FROM ZEPTO
GROUP BY name
HAVING COUNT(sku_id)>1
ORDER BY COUNT(sku_id)DESV;

--data cleaning

--product price = 0 
SELECT * FROM ZEPTO
WHERE mrp = 0 OR discountedsellingprice = 0 ;

DELETE FROM zEPTO
WHERE mrp=0;

--converting paisa to rupees

UPDATE ZEPTO
SET mrp = mrp/100,
discountedsellingprice = discountedsellingprice/100;

SELECT mrp, discountedsellingprice FROM ZEPTO

--let's find most discount product percentage.
SELECT DISTINCT name, mrp,discountpercent
FROM ZEPTO
ORDER BY discountpercent DESC
LIMIT 10;

--let's see which product is high MRP but out of stock
SELECT DISTINCT name, mrp
FROM ZEPTO
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;

--calculating estimated revenue for each category
SELECT category,
SUM(discountedsellingprice * availableQuantity)AS total_revenue
FROM ZEPTO
GROUP BY category
ORDER BY total_revenue;


--FInding all the product where mrp is grater then 500 rsand discount is less then 10 %.
SELECT DISTINCT name,mrp , DiscountPercent
FROM ZEPTO
WHERE mrp>500 AND discountPercent <10
ORDER BY mrp DESC, discountPercent DESc;

--finding out the top5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM ZEPTO
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

--group the product into category like low , medium , bulk
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
     WHEN weightInGms < 5000 THEN 'Medium'
     ELSE 'Bulk'
     END AS weight_category
FROM zepto;

-- whatis the total inventory waight per category;
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;

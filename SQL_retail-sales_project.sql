
-- ---------------Data cleaning---------------
-- 1. work only on duplicate data(do not tamper with the original data)

CREATE TABLE retail_sales_staging 
SELECT * 
FROM retail_sales;

SELECT *
FROM retail_sales_staging
;


ALTER TABLE retail_sales_staging
RENAME COLUMN ï»¿transactions_id to transactions_id,
RENAME COLUMN quantiy to quantity;

-- SET all '' = NULL
UPDATE retail_sales_staging
SET
transactions_id = NULLIF(transactions_id, ''), 
sale_date = NULLIF(sale_date, ''),
sale_time = NULLIF(sale_time, ''),
customer_id = NULLIF(customer_id, ''), 
gender = NULLIF(gender, ''), 
age = NULLIF(age, ''),
category = NULLIF(category, ''),
quantity = NULLIF(quantity, ''),
price_per_unit = NULLIF(price_per_unit, ''),
cogs = NULLIF(cogs, ''),
total_sale = NULLIF(total_sale, '')
;


ALTER TABLE retail_sales_staging
MODIFY  COLUMN transactions_id INT NULL,
MODIFY  COLUMN sale_date DATE,
MODIFY  COLUMN sale_time TIME,
MODIFY  COLUMN customer_id INT NULL,
MODIFY  COLUMN age INT NULL,
MODIFY  COLUMN quantity INT NULL,
MODIFY  COLUMN price_per_unit INT NULL,
MODIFY  COLUMN cogs INT NULL,
MODIFY  COLUMN total_sale INT NULL
;

SELECT*
FROM retail_sales_staging
;

ALTER TABLE retail_sales_staging
MODIFY  COLUMN price_per_unit float NULL,
MODIFY  COLUMN cogs FLOAT NULL,
MODIFY  COLUMN total_sale FLOAT NULL
;
-- checking for duplicates or NULL before asigning priMARY KEY

SELECT transactions_id, count(*)
FROM retail_sales_staging
GROUP BY transactions_id
HAVING count(*) > 1;

ALTER TABLE retail_sales_staging
ADD PRIMARY KEY (transactions_id)
;

SELECT* FROM retail_sales_staging;

SELECT*
FROM
(
SELECT*,
    (transactions_id is NULL) +
    (sale_date is NULL)+
    (sale_time  is NULL)+
    (customer_id is NULL)+
    (category is NULL)+ 
    (quantity is NULL)+
    (price_per_unit is NULL)+
    (cogs is NULL)+
    (total_sale is NULL) as null_count
   FROM retail_sales_staging
    ) nullL_count
    
WHERE null_count >= 1
;


CREATE TABLE `retail_sales_staging1` (
    `transactions_id` INT NOT NULL,
    `sale_date` DATE DEFAULT NULL,
    `sale_time` TIME DEFAULT NULL,
    `customer_id` INT DEFAULT NULL,
    `gender` TEXT,
    `age` INT DEFAULT NULL,
    `category` TEXT,
    `quantity` INT DEFAULT NULL,
    `price_per_unit` FLOAT DEFAULT NULL,
    `cogs` FLOAT DEFAULT NULL,
    `total_sale` FLOAT DEFAULT NULL,
    `null_count` INT NULL,
    PRIMARY KEY (`transactions_id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI
;

INSERT INTo retail_sales_staging1
SELECT *,
    (transactions_id is NULL) +
    (sale_date is NULL)+
    (sale_time  is NULL)+
    (customer_id is NULL)+
    (category is NULL)+ 
    (quantity is NULL)+
    (price_per_unit is NULL)+
    (cogs is NULL)+
    (total_sale is NULL) as null_count
FROM retail_sales_staging

;
SELECT *
FROM retail_sales_staging1
WHERE null_count >=2;

ALTER TABLE retail_sales_staging1
drop column null_count;

ALTER TABLE retail_sales_staging1
RENAME COLUMN total_sale To total_price;



-- --------------------------------EDA--------------------------------
-- Total sales/record
SELECT COUNT(*)
FROM retail_sales_staging1;

-- How many customers we have(unique customers)
SELECT customer_id, count(*)
FROM retail_sales_staging1
GROUP BY customer_id
;

SELECT count(DISTINCT customer_id)
FROM retail_sales_staging1
;
-- how many distinct category
SELECT DISTINCT category
FROM retail_sales_staging1
;

-- Business key problems and answer

SELECT *
FROM retail_sales_staging1
WHERE sale_date = '2022-11-05'
;
-- Write a SQL query to retrieve all transactions WHERE the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT*
FROM retail_sales_staging1
WHERE 1=1
AND category LIKE 'clothing'
AND quantity >= 4
AND sale_date LIKE '2022-11%'
;
-- Write a SQL query to calculate the total sales (total_sale) for each category
SELECT category, SUM(total_price) as net_sales, COUNT(*) as total_order
FROM retail_sales_staging1
GROUP BY category
;

-- Write a SQL query to find the average age of customers who purchased items FROM the 'Beauty' category.
SELECT category, ROUND(AVG(age), 2)
FROM retail_sales_staging1
-- WHERE category = 'beauty'
GROUP BY category
;

-- Write a SQL query to find all transactions WHERE the total_sale is greater than 1000.
SELECT*
FROM retail_sales_staging1
WHERE total_price > 1000
;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender, COUNT(transactions_id) as total_num_transaction 
FROM retail_sales_staging1
GROUP BY category, gender
ORDER BY 1
;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

WITH best_selling_month_each_year AS
(
	SELECT 
		year(sale_date) as year, 
		month(sale_date) as month,
		ROUND(AVG(total_price), 2) as avg_sale, 
		RANK() OVER(PARTITION BY year(sale_date) ORDER BY ROUND(AVG(total_price), 2) DESC) AS rank_avg_sale
	FROM retail_sales_staging1
	GROUP BY year, month
	-- ORDER BY  1, 3 DESC
)
SELECT year, month, avg_sale
FROM best_selling_month_each_year
WHERE rank_avg_sale = 1 
;


SELECT year, month, avg_sale
FROM
(
	SELECT 
		year(sale_date) as year, 
		month(sale_date) as month,
	 	ROUND(AVG(total_price), 2) as avg_sale, 
		RANK() OVER(PARTITION BY year(sale_date) ORDER BY ROUND(AVG(total_price), 2) DESC) AS rank_avg_sale
	FROM retail_sales_staging1
	GROUP BY year, month
    -- ORDER BY  1, 3 DESC
) best_month_year
WHERE rank_avg_sale = 1
;

-- Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id, SUM(total_price) total_sales
FROM retail_sales_staging1 
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5
; 

-- Write a SQL query to find the number of unique customers who purchased items from each category

SELECT category, COUNT(DISTINCT customer_id) unique_customers
FROM retail_sales_staging1
GROUP BY category
;


-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT shift, COUNT(shift) as total_orders
FROM  
(
SELECT *,
	CASE
		WHEN hour(sale_time) < 12 THEN 'morning shift'
        WHEN hour(sale_time) BETWEEN 12 and 17 THEN 'afternoon shift'
        ELSE 'evening shift'
	END AS shift
FROM retail_sales_staging1
) t1
GROUP BY shift

-- endOfProject
;		



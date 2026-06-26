# 🛍️ Retail Sales Data Cleaning & Exploratory Data Analysis with SQL

## Project Overview

This project demonstrates an end-to-end SQL workflow for cleaning, preparing, and analyzing a retail sales dataset using **MySQL 8.0**.

Rather than querying the raw dataset directly, I followed a common data engineering practice by creating a **staging table** where all cleaning and transformations were performed. Once the data quality issues were resolved, I carried out exploratory data analysis (EDA) and answered a series of business questions to generate actionable insights.

This project showcases practical SQL skills commonly required in data analyst roles, including data cleaning, schema modification, exploratory analysis, aggregation, window functions, and business reporting.

---

## Project Objectives

* Create a staging table to preserve the raw dataset.
* Clean and standardize imported data.
* Detect duplicates and missing values.
* Enforce data integrity using a primary key.
* Perform exploratory data analysis.
* Answer real-world business questions using SQL.

---

## Dataset

The dataset contains retail transaction records with the following fields:

| Column                    |
| ------------------------- |
| Transaction ID            |
| Sale Date                 |
| Sale Time                 |
| Customer ID               |
| Gender                    |
| Age                       |
| Category                  |
| Quantity                  |
| Price per Unit            |
| Cost of Goods Sold (COGS) |
| Total Sale                |

---

## Data Cleaning Process

The following data cleaning steps were performed before analysis:

### 1. Created a Project Schema

Created a dedicated MySQL schema for the project.

### 2. Created a Staging Table

Copied the original dataset into a staging table to preserve the raw data.

### 3. Renamed Incorrect Columns

Corrected import issues including:

* `ï»¿transactions_id` → `transactions_id`
* `quantiy` → `quantity`

### 4. Handled Missing Values

Converted empty strings (`''`) into `NULL` values using `NULLIF()` to enable proper data type conversion.

### 5. Converted Data Types

Updated columns to appropriate data types including:

* INT
* DATE
* TIME
* FLOAT

### 6. Checked Data Integrity

Performed duplicate checks on the transaction ID before assigning it as the primary key.

### 7. Verified Missing Values

Created a temporary `null_count` column to identify rows containing missing values before removing the helper column.

---

## Exploratory Data Analysis

Performed exploratory analysis including:

* Total number of transactions
* Number of unique customers
* Product categories
* Sales distribution

---

## Business Questions Answered

This project answers the following business questions:

* Retrieve all sales made on a specific date.
* Find Clothing purchases with quantities > 4 during November 2022.
* Calculate total revenue by product category.
* Determine the average customer age by category.
* Identify high-value transactions exceeding 1,000.
* Count transactions by gender and product category.
* Determine the best-selling month in each year using window functions.
* Identify the top five customers by total spending.
* Calculate the number of unique customers in each category.
* Analyze order volume by time of day (Morning, Afternoon, Evening).

---

## SQL Concepts Demonstrated

This project demonstrates the use of:

* CREATE DATABASE
* CREATE TABLE
* ALTER TABLE
* UPDATE
* NULLIF()
* Aggregate Functions
* GROUP BY
* ORDER BY
* DISTINCT
* CASE WHEN
* Common Table Expressions (CTEs)
* Window Functions (`RANK()`)
* Subqueries
* Primary Keys
* Data Type Conversion

---

## Project Structure

```
Retail-Sales-SQL-Project/
│
├── data/
│   └── retail_sales.csv
│
├── sql/
│   └── SQL_retail-sales_project.sql
│
├── README.md
│
└── images/
```

---

## Key Skills Demonstrated

* SQL Data Cleaning
* Exploratory Data Analysis (EDA)
* Data Validation
* Data Transformation
* Business Analysis
* Relational Database Management
* MySQL

---

## Key Takeaways

Through this project I learned how to:

* Preserve raw datasets by working with staging tables.
* Clean imported datasets before analysis.
* Convert incorrect data types safely.
* Detect missing values and duplicate records.
* Use SQL to answer practical business questions.
* Apply window functions and common table expressions for advanced analysis.

---

## Future Improvements

Possible enhancements include:

* Creating SQL views for reusable reports.
* Building stored procedures for automation.
* Developing an interactive Power BI or Tableau dashboard using the cleaned dataset.
* Performing customer segmentation and sales trend analysis.

---

## Author

**Joshua Ndife**

First Class Graduate | Materials & Metallurgical Engineer
Data Analyst | SQL | MySQL | Python | Power BI | Excel

I enjoy transforming raw data into meaningful insights through data cleaning, analysis, and visualization.

---

## Acknowledgements

This project was completed as part of my SQL learning journey and portfolio development. It demonstrates practical SQL techniques used in real-world data analytics workflows.

Thank you for your support, and I look forward to connecting with you!

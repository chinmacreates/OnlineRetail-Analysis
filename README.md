# OnlineRetail-Analysis
Sales performance analysis using SQL and Power BI on real retail data


📊 Online Retail Sales Analysis – France
📌 Project Overview

This project analyzes transactional retail data to identify bestselling products and peak purchasing periods in France. The goal is to demonstrate a real-world analytics workflow using SQL for data preparation and Power BI for visualization.

**Business Questions**

Which products sell the most by quantity?

Which products generate the most revenue?

When do customers buy the most (hourly & daily patterns)?


 **Dataset**

Source: UCI Online Retail Dataset (via Kaggle)

Rows: 500K+

Subset Used: France (~8,500 rows after filtering)

Key Fields: InvoiceNo, Description, Quantity, UnitPrice, InvoiceDate, Country


 **Data Quality Notes**

Negative quantities represent returns/cancellations

Invoice numbers starting with C indicate canceled transactions

Missing CustomerIDs represent guest checkouts

Messy data was intentionally retained and documented


**Tools Used**

MySQL 8.0 (data cleaning & analysis)

Power BI (visualization)

Excel (initial data inspection)


**Data Preparation Summary**

Filtered for Country = 'France'

Removed canceled invoices

Converted InvoiceDate to datetime

Created a calculated Revenue field


**Key Analyses**

Top 10 bestselling products (by quantity)

Top 10 revenue-generating products

Sales trends by hour

Sales trends by day of week


 **Key Insights**

Sales peak between 10 AM – 2 PM

Thursday and Friday generate the highest revenue

High-volume products do not always generate the most revenue

 
 **Business Recommendations**

Schedule promotions during peak hours (10 AM – 12 PM)

Bundle high-volume, low-price items with premium products

Focus inventory planning around mid-week demand


 **Next Steps**

Analyze repeat customers

Compare France vs UK purchasing behavior

Perform product bundle analysis

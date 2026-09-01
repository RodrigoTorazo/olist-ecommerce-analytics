# Olist E-commerce Analytics Project

🌐 **Languages:** English | [Português](README.pt-BR.md) | [日本語](README.ja.md)

## Project Overview

This project analyzes the performance of a Brazilian e-commerce marketplace using publicly available data from Olist.

The goal is to transform transactional data into **actionable business insights**, focusing on:

* Sales and revenue performance
* Customer behavior and distribution
* Product and category performance
* Payment methods
* Delivery efficiency
* Customer satisfaction

The project follows an end-to-end analytics workflow:

**Data Exploration → Data Cleaning → Exploratory Data Analysis → SQL Analysis → Business Insights → Power BI Dashboard**

---

## Business Questions

### Sales Performance

* What is the total revenue and how does it evolve over time?
* Which product categories generate the most revenue?
* Which states contribute the most to sales?
* Which payment methods are most commonly used?

### Customer Analysis

* How many customers does the marketplace have?
* Which states have the highest concentration of customers?
* How are order values distributed?
* What is the repeat customer rate?

### Product & Category Analysis

* Which categories have the highest sales volume?
* Which categories receive the highest customer ratings?
* Which factors are most strongly associated with category revenue?

### Logistics & Customer Satisfaction

* What is the average delivery time?
* Which states have the highest incidence of delivery delays?
* What is the relationship between delivery delays and customer satisfaction?

---

## Tools & Technologies

### Programming & Analysis

* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn

### Database

* SQL
* MySQL

### Data Visualization

* Power BI

### Other Tools

* Jupyter Notebook
* GitHub

---

## Project Workflow

### 1. Data Exploration

The raw datasets were explored to understand:

* Data structure and volume
* Data types
* Relationships between tables
* Distribution of key variables
* Data quality issues

### 2. Data Cleaning

The cleaning process included:

* Handling missing values
* Identifying and removing duplicates
* Standardizing data types
* Handling blank values
* Validating geographic information
* Preparing datasets for analysis

### 3. Exploratory Data Analysis

Python was used to investigate:

* Revenue trends
* Customer behavior
* Product and category performance
* Payment methods
* Review score distribution
* Delivery performance
* Outliers and extreme values

### 4. SQL Analysis

The cleaned datasets were stored in a MySQL relational database.

The project includes **28 business questions answered using SQL**, covering:

* `JOIN`
* `GROUP BY`
* Aggregate Functions
* Common Table Expressions (CTEs)
* Window Functions
* Date Functions
* Ranking
* Subqueries

SQL analysis was also used to validate findings identified during the exploratory analysis.

### 5. Power BI Dashboard

An interactive Power BI dashboard was developed to transform the analytical findings into an interactive visual exploration tool.

The dashboard covers:

* Sales & Revenue
* Customers & Payments
* Products & Categories
* Delivery Performance

The visualizations include KPI cards, bar charts, a time-series chart, treemap, geographic map, and scatter plot.

---

## A Note on Terminology

The R$13.59M figure referenced throughout this project reflects **GMV (Gross Merchandise Value)** — the total value transacted through the marketplace — not platform revenue (which would be the commission Olist earns on each sale). This is the standard metric for marketplace-level analysis, but it is not equivalent to profit or platform earnings, since no cost or margin data is included in this dataset.

Correlations reported throughout this project (e.g., volume vs. revenue, delay vs. review score) describe **statistical association, not causation**. They indicate the strength and direction of a relationship, not a proven cause-and-effect mechanism.

---

# Key Insights

## Sales & Revenue

* The marketplace generated approximately **R$13.59 million in GMV**, across **112,650 items sold** and **[fill in: total number of orders]** orders.
* The **top 5 product categories account for 40.27% of total revenue**, indicating significant sales concentration.
* Items sold have a strong association with category revenue (**0.95 correlation**), while the association between average price and revenue is almost nonexistent (**0.02 correlation**).
* This indicates that **sales volume is much more strongly associated with category revenue than average price is**.

## Customers & Geography

* The marketplace serves **[fill in: total number of unique customers]** customers.
* São Paulo represents **41.98% of the customer base**, followed by Rio de Janeiro (**12.92%**) and Minas Gerais (**11.70%**).
* Together, SP, RJ, and MG account for **66.61% of the customer base**, highlighting strong geographic concentration in Brazil's Southeast region.

## Delivery & Operations

* On average, orders were delivered **11.18 days ahead of the estimated delivery date**.
* The overall late delivery rate was **8.11%** of all orders.
* Extreme delivery delays represented approximately **1% of analyzed deliveries**.
* Although relatively uncommon, extreme delays deserve attention because of their potential impact on customer experience.

## Reviews & Customer Satisfaction

* **57.78% of reviews received a 5-star rating**, making it the most common review score.
* Late deliveries had an average review score of **2.57**, compared with **4.29** for orders delivered on time — a **1.72-point gap**.
* The correlation between delivery delay and review score was **-0.27**, a moderate negative association, consistent with the gap observed above.

## Payments

* Credit cards account for **78.34% of total payment value**, making them the dominant payment method.
* **62.93% of credit card payments were made using three installments or fewer**.

## Sellers

* The marketplace has **3,095 sellers**.
* The **top 10% of sellers account for 67.56% of total sales**, indicating strong commercial concentration.
* No meaningful association was identified between seller sales volume and either average review score or on-time delivery rate.
* This suggests that **commercial performance and operational performance are relatively independent dimensions** in this marketplace.

---

# Business Recommendations

### 1. Prioritize High-Performing Categories

Since 40.27% of revenue is concentrated in just 5 categories, these categories should be prioritized in seller acquisition, inventory availability, and promotional planning. **Suggested success metric:** track revenue share of top 5 categories quarter-over-quarter to confirm growth isn't cannibalizing the broader catalog.

### 2. Monitor Regional Logistics Performance

States with delivery times or delay rates above the 7.87% average should be flagged for root-cause investigation (seller location, shipping distance, carrier performance). **Suggested success metric:** reduce late-delivery rate in the worst-performing states to within 2 points of the national average within two quarters.

### 3. Investigate Extreme Delivery Delays

Extreme delays (~1% of deliveries) are rare but linked to the sharpest review-score drops. Monitoring by state, seller, and category can help isolate recurring failure points. **Suggested success metric:** cut the extreme-delay rate in half, given its disproportionate impact on the 2.57 average score for late orders.

### 4. Reduce Seller Concentration Risk

With the top 10% of sellers generating 67.56% of sales, the marketplace carries meaningful concentration risk — losing a handful of top sellers could materially impact revenue. **Suggested success metric:** grow the sales share of mid-tier sellers (deciles 2–5) by a target percentage over the next year to diversify the base.

---

# Limitations

This analysis has some boundaries worth noting for anyone building on it:

* **Time period:** the dataset covers a fixed historical window and may not capture full seasonal cycles (e.g., holiday peaks, promotional periods) evenly.
* **No cost or margin data:** GMV figures reflect transacted value, not platform profit; recommendations around category or seller prioritization should be validated against actual margin data before being acted on commercially.
* **No customer-level lifetime data:** repeat-purchase and cohort behavior is limited by what a single historical snapshot can show.
* **Geographic granularity:** state-level analysis may mask city-level or regional logistics differences within large states like São Paulo.

---

# Dashboard Preview

The Power BI dashboard is organized into four analytical pages:

### 1. Sales & Revenue

![Sales & Revenue Dashboard](images/dashboard_sales_revenue.png)

### 2. Customers & Payments

![Customers & Payments Dashboard](images/dashboard_customers_payments.png)

### 3. Products & Categories

![Products & Categories Dashboard](images/dashboard_products_categories.png)

### 4. Delivery Performance

![Delivery Performance Dashboard](images/dashboard_delivery_performance.png)

The dashboard was designed to provide an interactive visual exploration of key sales, customer, product, category, payment, and logistics performance indicators.

---

# Project Structure

```text
Olist-Ecommerce-Analytics/
│
├── 01_data_exploration.ipynb
├── 02_data_cleaning.ipynb
├── 03_EDA.ipynb
│
├── 01_database_setup.sql
├── 02_business_analysis.sql
│
├── Olist_Ecommerce_Analytics_Dashboard.pbix
│
├── images/
│   ├── dashboard_sales_revenue.png
│   ├── dashboard_customers_payments.png
│   ├── dashboard_products_categories.png
│   └── dashboard_delivery_performance.png
│
├── README.md
├── README.pt-BR.md
└── README.ja.md
```

---

# Skills Demonstrated

* Data Cleaning
* Exploratory Data Analysis
* SQL Analysis
* Relational Database Design
* Business Analysis
* Data Visualization
* Power BI Dashboard Development
* KPI Development
* Geographic Analysis
* Customer Analysis
* Product & Category Analysis
* Logistics Analysis
* Statistical Correlation Analysis
* Business Recommendations

---

# Conclusion

This project demonstrates a complete data analytics workflow, from data exploration and preparation to SQL analysis, business insight generation, and interactive dashboard development.

The analysis highlights important characteristics of the marketplace, including **revenue concentration by category, geographic customer concentration, seller dependency, and the relationship between delivery performance and customer satisfaction**.

The project demonstrates how transactional data can be transformed into **actionable business insights and recommendations using Python, SQL, and Power BI**.

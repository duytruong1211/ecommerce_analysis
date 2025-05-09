# 🛒 E-commerce Delivery Experience Analysis

This project analyzes customer delivery experiences across various product categories, focusing on fulfillment times, shipping durations, and customer satisfaction metrics. The purpose is to explore the Brazilian e-commerce logistics landscape, uncover operational bottlenecks, and surface insights into how shipping performance impacts customer experience.


## 📊 Dashboard Access

Explore the interactive dashboard here: [View Dashboard](https://server-production-e214.up.railway.app/public/dashboards/aLqRQMYMN1E7eO9FjE9BgtZDq0tebK49YouUY50F?org_slug=default)


![Dashboard Screenshot](ecommerce_analysis/dashboard/ecommerce_dashboard_screenshot_1.png)
![Dashboard Screenshot](ecommerce_analysis/dashboard/ecommerce_dashboard_screenshot_2.png)



## 🔍 Key Metrics

- **Average Fulfillment Time:** Time from order approval to dispatch.
- **Average Shipping Time:** Duration from dispatch to customer delivery.
- **Customer Review Score:** Average rating provided by customers.
- **Delayed Delivery Rate:** Breakdown of late delivery rate.
- **Review Distribution:** Analysis of customer feedback.

## 🗂️ Project Structure

- `models/`: Contains dbt models for data transformation.
- `dashboards/`: Queries used in the Redash dashboard.

## ☁️ Hosting & Infrastructure

This project uses **[Railway](https://railway.app/)** to host the PostgreSQL database used for both dbt transformations and Redash queries.

- **PostgreSQL on Railway**: Stores raw CSV uploads, staging models, and final analytics tables
- **Redash**: Connects directly to Railway PostgreSQL for visualization and exploration
- **dbt**: Runs locally to transform data on the hosted database

Railway provides a cost-effective, cloud-hosted environment that’s easy to scale and ideal for personal analytics projects.


## 🧰 Technologies Used

- [dbt](https://www.getdbt.com/) for data transformation.
- [Redash](https://redash.io/) for data visualization.
- [Railway](https://railway.app/) for hosting the PostgreSQL database.
- [Dagster](https://dagster.io/) for orchestrating data pipelines (work in progress).


## 📂 Source Data

Based on [Olist Brazilian E-Commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) from Kaggle.

It contains ~100,000 orders placed between 2016 and 2018 across multiple cities in Brazil, covering order timelines, product details, payments, reviews, and seller-customer relationships. The dataset enables end-to-end analysis of the customer purchase and delivery experience.

## 📬 Contact

For questions or feedback, please reach out to [duytruong1211gmail.com](mailto:duytruong1211gmail.com).

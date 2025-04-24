
## 📊 Redash Queries

This folder contains SQL queries used to build the interactive dashboard on Redash. Each file corresponds to a chart or table used in the visual exploration of delivery experience metrics.

### 🔍 Query Organization

- Queries are grouped by **dashboard section** (e.g., Customer Experience and Delivery Delays)
- Queries use Redash-style parameters (e.g., `{{ date_range.start }}`, `{{ product_category }}`)

### 🧭 Purpose

Storing queries separately ensures reproducibility, transparency, and version control for all dashboard logic. This also makes it easier to migrate dashboards or audit business logic independently from dbt models.

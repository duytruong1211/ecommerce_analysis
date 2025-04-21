## 🏗️ ecommerce_dwh — Data Warehouse Layer (dbt)

This folder contains the dbt project that models Olist’s raw e-commerce data into a clean, analytics-ready data warehouse structure.

### 📦 Dataset Summary
The raw data comes from the [Olist Brazilian E-Commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce), including order details, customer and seller info, product metadata, payments, and reviews. It reflects ~100,000 orders across Brazil from 2016 to 2018.

---

### 🧱 Data Warehouse Structure

The warehouse is organized into **two main layers** using dbt:

#### 1. `staging/`  
- **Purpose**: Clean and normalize raw CSVs (e.g., cast types, handle nulls, rename columns)
- **Naming**: `stg_*`
- **Logic**: Minimal transformation to retain source fidelity  
- **Materialization**: Views

#### 2. `data/` (aka Analytics layer)  
- **Purpose**: Build final models used for BI and analysis
- **Includes**: Flexible schema that blends fact/dimension concepts with semantic clarity — optimized for business consumption, not rigid star schemas
- **Logic**: Business logic, joins, aggregation, derived fields (e.g., delivery delay flags, review scores)
- **Materialization**: Tables or incremental models depending on use case

---

### 🧪 Testing & Best Practices

- `dbt_utils` package is used for generating surrogate keys and running schema tests
- Data tests include:
  - Uniqueness
  - Not null constraints
  - Referential integrity across staging and final models

---

### 🔗 Output Usage

The final models power an interactive logistics dashboard that analyzes fulfillment time, shipping time, review scores, and delivery performance by product category and freight tier.  
📊 **[View the Dashboard](https://server-production-e214.up.railway.app/public/dashboards/aLqRQMYMN1E7eO9FjE9BgtZDq0tebK49YouUY50F?org_slug=default)**


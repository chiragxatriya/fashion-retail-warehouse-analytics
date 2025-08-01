# Fashion Retail Warehouse Analytics

## Overview

A complete, production-style data warehouse solution for the [Global Fashion Retail Sales](https://www.kaggle.com/datasets/ricgomes/global-fashion-retail-stores-dataset?select=transactions.csv) dataset, demonstrating best practices in data modeling, ETL, SQL optimization, and Power BI analytics.  
This project covers the entire analytics pipeline, from raw data ingestion to interactive reporting.

The total raw data size exceeds **1.3 GB** in the bronze schema, which is then optimized through transformation and normalization:  
- Silver schema reduces storage footprint by about 12%, storing around **1.18 GB** of cleansed, structured data.  
- Lookup schema contains highly optimized dimension tables totaling less than **1 MB**.  

The fact tables collectively hold **more than 1 billion rows**, showcasing the scale of the solution and its capability to handle large datasets efficiently.

> **Data Modeling Note:**  
> Based on the provided ERD and data dictionary, this project adopts a **normalized dimensional modeling** approach:  
> - All major dimension tables (e.g., Product, Customer, Store, Employee) reference core business descriptors (Category, Sub-Category, Color, Gender, Country, Size, Payment Method, etc.) through surrogate keys held in **specialized lookup tables**.  
> - This structure follows a **snowflake schema for dimension normalization**, reducing storage requirements, improving data consistency, and making the model highly scalable and maintainable, while the star-like fact-dimension join pattern supports analytical performance.

---

## Project Structure

- **raw_data/**: Cleaned CSV files from Kaggle (customers, discount, employees, products, stores, transactions)
- **docs/**: ER diagrams (see `entity-relationship.jpg`), a full data dictionary, and solution architecture outlines
- **scripts/**
  - **bronze/**: Scripts for raw table creation and importing data
  - **silver/**: Transformation, cleansing, lookup normalization, and business logic
  - **gold/views/**: Final reporting views (salesmart, invoice_details)
  - **optimization/**: Index scripts and tuning notes
- **powerbi/**: Power BI dashboard (.pbix) and screenshots

---

## Key Features

- **Layered Architecture**:
  - **Bronze**: Raw imported data (~1.34 GB, unprocessed)
  - **Silver**: Cleansed, standardized, enriched data (~1.18 GB) with fully normalized dimensions for query efficiency
  - **Lookup**: Small, highly normalized dimension tables (<1 MB) for optimized joins and consistency
  - **Gold**: Business-ready views for BI/reporting

- **Handles Large Volume**: Fact tables contain over **1 billion rows**, demonstrating ability to manage and analyze large-scale retail data.

- **Snowflake-Modeled Normalized Dimensions**:  
  - Dimensions reference all business descriptors (category, color, size, etc.) via dedicated lookup/normalization tables, minimizing storage and maximizing clarity.
  - The ERD illustrates this with all surrogate-key relationships from dimensions to lookups.

- **Advanced Data Transformations**:
  - Cleansing, standardization, deduplication, key lookups, enrichment, type conversion, date generation, and string manipulation.

- **Optimized for Analytics**:
  - Fact-and-dimension (snowflaked) schema, separate fact tables for sales & returns, and extensive indexing for query performance.

- **Interactive Power BI Reporting**:
  - Rich dashboards using best-practice SQL views and slicer-supporting lookups and dimensions.

## License

This project is licensed under the [MIT License](LICENSE).

---

## Credits

- Kaggle [Global Fashion Retail Sales](https://www.kaggle.com/datasets/datafiniti/global-fashion-retail-sales)  
- Built by [CHIRAG KSHATRIYA] for public portfolio

---

## Contributing

Contributions and suggestions are welcome! Please open an issue or submit a pull request.


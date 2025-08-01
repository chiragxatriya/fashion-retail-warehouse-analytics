# Fashion Retail Warehouse Analytics

## Overview

A complete, production-style data warehouse solution for the [Global Fashion Retail Sales](https://www.kaggle.com/datasets/ricgomes/global-fashion-retail-stores-dataset?select=transactions.csv) dataset, demonstrating best practices in data modeling, ETL, SQL optimization, and Power BI analytics.  
This project covers the entire analytics pipeline, from raw data ingestion to interactive reporting.

---

## Project Structure

- **raw_data/**: Cleaned CSV files from Kaggle (customers, discount, employees, products, stores, transactions)
- **docs/**: Data model diagrams, data dictionary, and solution architecture
- **sql/**
  - **bronze/**: Scripts for raw table creation and importing data
  - **silver/**: Transformation, cleansing, lookup optimization, and business logic
  - **gold/views/**: Final reporting views (salesmart, invoice details)
  - **optimization/**: Index scripts and tuning notes
  - **etl_scripts/**: End-to-end pipeline orchestration
- **powerbi/**: Power BI dashboard (.pbix) and screenshots
- **scripts/**: Additional helper scripts

---

## Key Features

- **Layered Architecture**:
  - **Bronze**: Raw imported data (mirrors CSVs)
  - **Silver**: Cleansed, standardized, enriched data with lookups and surrogate keys
  - **Gold**: Business-ready views for BI/reporting

- **Advanced Data Transformations**:
  - Cleansing, standardization, deduplication, key lookups, enrichment, type conversion, date generation, and string manipulation.

- **Optimized for Analytics**:
  - Star schema, separated fact tables for sales & returns, lookup tables for normalization, indexed for query performance.

- **Interactive Power BI Reporting**:
  - Rich dashboards using best-practice SQL views and slicer-supporting dimensions.


## License

This project is licensed under the [MIT License](LICENSE).

---

## Credits

- Kaggle [Global Fashion Retail Sales](https://www.kaggle.com/datasets/datafiniti/global-fashion-retail-sales)
- Built by [CHIRAG KSHATRIYA] for public portfolio

---

## Contributing

Contributions and suggestions are welcome! Please open an issue or submit a pull request.

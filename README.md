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

---

## Getting Started

1. **Clone the repository**  
   `git clone https://github.com/YOUR_GITHUB_USERNAME/fashion-retail-warehouse-analytics.git`

2. **Load Raw Data**  
   - Place the Kaggle CSVs into `/raw_data/`
   - Run `/sql/bronze/dml/import_raw_data.sql` to load CSVs into the bronze schema.

3. **Run Transformations**  
   - Execute scripts in `/sql/silver/` to transform, cleanse, deduplicate, and enrich data (see `/sql/silver/dml/transform_bronze_to_silver.sql`).

4. **Create Lookup Tables**  
   - Run `/sql/silver/lookup/create_lookup_tables.sql` after silver tables.

5. **Prepare Final Reporting Views**  
   - Use `/sql/gold/views/` to create `salesmart` and `invoice_details` views.

6. **Indexing & Optimization**  
   - Apply `/sql/optimization/create_indexes.sql` for best query performance.

7. **Quality Checks**  
   - Run quality scripts in `/sql/bronze/quality_checks/` and `/sql/silver/quality_checks/`.

8. **Open the Power BI Dashboard**  
   - Use `/powerbi/FashionRetailDashboard.pbix` to visualize and explore data.

---

## Documentation

- **ER Diagram**: ![ER Diagram](docs/ERD.png)
- **Data Dictionary**: [docs/data_dictionary.md](docs/data_dictionary.md)
- **Architecture**: [docs/architecture.md](docs/architecture.md)

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Credits

- Kaggle [Global Fashion Retail Sales](https://www.kaggle.com/datasets/datafiniti/global-fashion-retail-sales)
- Built by [YOUR NAME] for public portfolio

---

## Contributing

Contributions and suggestions are welcome! Please open an issue or submit a pull request.

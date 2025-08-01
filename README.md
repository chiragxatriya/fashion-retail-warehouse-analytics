# Fashion Retail Warehouse Analytics

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Data Size](https://img.shields.io/badge/Data%20Size-1.3GB%2B-blue)](https://www.kaggle.com/datasets/datafiniti/global-fashion-retail-sales)
[![Tables](https://img.shields.io/badge/Tables-18%2B-brightgreen)](#database-schema)

A comprehensive data warehouse project built on **Kaggle's Global Fashion Retail Sales** dataset, implementing a modern **Bronze-Silver-Gold** architecture for analytics and business intelligence. This project demonstrates end-to-end data engineering practices, from raw data ingestion to analytics-ready data marts.

## 📊 Project Overview

This project transforms over **1.3GB of raw fashion retail data** (1 billion+ transaction records) into a structured, analytics-ready data warehouse using modern data engineering principles and SQL-based ETL processes.

### Key Features
- **3-Layer Architecture**: Bronze (Raw) → Silver (Transformed) → Gold (Analytics)
- **18+ Database Objects**: 10 lookup tables, 6 dimension tables, 2 fact tables
- **Comprehensive ETL**: Data cleansing, deduplication, enrichment, and transformation
- **Quality Assurance**: Built-in data quality checks and validation
- **Analytics Ready**: Pre-built views for business intelligence and reporting

## 🗃️ Dataset Information

**Source**: [Kaggle Global Fashion Retail Sales Dataset](https://www.kaggle.com/datasets/datafiniti/global-fashion-retail-sales)

### Raw Data Files (Bronze Layer)
- `customers.csv` - Customer demographic and profile information
- `discount.csv` - Discount and promotion details
- `employees.csv` - Employee information and roles
- `products.csv` - Product catalog with categories, brands, and pricing
- `stores.csv` - Store locations and regional information
- `transactions.csv` - Sales and returns transaction data (1B+ records)

**Total Raw Data Size**: 1.3+ GB

## 🏗️ Architecture Overview

### Bronze Layer (Raw Data)
- Direct import of CSV files into database tables
- Minimal transformation, preserving original data structure
- Serves as single source of truth for all downstream processing

### Silver Layer (Transformed Data)

#### Data Transformations Applied:
- **Data Cleansing & Standardization**: Removed nulls, standardized formats
- **Deduplication**: Eliminated duplicate records across all tables
- **Key Lookup & Surrogate Keys**: Implemented efficient key management
- **Data Enrichment**: Enhanced records with derived attributes
- **Date Dimension Generation**: Created comprehensive date hierarchies
- **Data Type Conversion**: Optimized data types for performance
- **String Manipulation**: Standardized text fields and categories

#### Schema Structure:
- **Lookup Schema**: 10 optimized lookup tables for data normalization
- **Dimension Tables**: 6 core business dimensions
  - Customer Dimension
  - Product Dimension  
  - Store Dimension
  - Employee Dimension
  - Date Dimension
  - Discount Dimension
- **Fact Tables**: 2 transaction fact tables
  - Sales Fact (sales transactions)
  - Returns Fact (return transactions)

### Gold Layer (Analytics-Ready)
- **SalesMart View**: Comprehensive sales analytics with all dimensions
- **Invoice Details View**: Detailed transaction-level reporting
- Optimized for business intelligence tools and reporting

## 📁 Repository Structure

```
fashion-retail-warehouse-analytics/
├── README.md                          # Project documentation
├── LICENSE                            # MIT License
├── .gitignore                         # Git ignore rules
├── data/                              # Data storage
│   ├── raw/                           # Original CSV files
│   └── processed/                     # Intermediate processed data
├── sql/                               # SQL scripts organized by layer
│   ├── bronze/                        # Raw data import scripts
│   ├── silver/                        # Transformation scripts
│   ├── gold/                          # Analytics view scripts
│   └── quality_checks/                # Data quality validation
├── docs/                              # Documentation
│   ├── data_dictionary.md             # Comprehensive data dictionary
│   ├── er_diagrams/                   # Entity relationship diagrams
│   └── data_flow_diagrams/            # ETL process flow diagrams
├── scripts/                           # Automation scripts
└── tests/                             # Data quality tests
```

## 🚀 Getting Started

### Prerequisites
- SQL Database Engine (PostgreSQL, MySQL, SQL Server, etc.)
- Python 3.8+ (for automation scripts)
- 2GB+ available storage space

### Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/fashion-retail-warehouse-analytics.git
   cd fashion-retail-warehouse-analytics
   ```

2. **Download the dataset**
   - Download the [Global Fashion Retail Sales dataset](https://www.kaggle.com/datasets/datafiniti/global-fashion-retail-sales) from Kaggle
   - Extract CSV files to the `data/raw/` directory

3. **Set up database**
   ```bash
   # Update connection strings in scripts/setup_database.py
   python scripts/setup_database.py
   ```

4. **Run Bronze layer setup**
   ```sql
   -- Execute bronze layer scripts
   \i sql/bronze/create_bronze_schema.sql
   \i sql/bronze/import_raw_data.sql
   ```

5. **Execute Silver layer transformations**
   ```sql
   -- Create lookup and dimension tables
   \i sql/silver/create_lookup_tables.sql
   \i sql/silver/create_dimension_tables.sql
   \i sql/silver/create_fact_tables.sql
   \i sql/silver/data_transformations.sql
   ```

6. **Create Gold layer views**
   ```sql
   -- Create analytics views
   \i sql/gold/create_salesmart_view.sql
   \i sql/gold/create_invoice_details_view.sql
   ```

7. **Run data quality checks**
   ```sql
   \i sql/quality_checks/data_quality_tests.sql
   ```

## 📊 Database Schema

### Dimensional Model (Star Schema)

#### Dimension Tables
- **DIM_CUSTOMER**: Customer demographics and profiles
- **DIM_PRODUCT**: Product catalog with categories and attributes
- **DIM_STORE**: Store locations and regional information
- **DIM_EMPLOYEE**: Employee details and organizational structure
- **DIM_DATE**: Comprehensive date dimension with hierarchies
- **DIM_DISCOUNT**: Discount types and promotional information

#### Fact Tables
- **FACT_SALES**: Sales transaction measures and metrics
- **FACT_RETURNS**: Product return transactions and reasons

#### Analytics Views
- **SALESMART**: Pre-aggregated sales analytics with all dimensions
- **INVOICE_DETAILS**: Detailed invoice-level transaction data

For detailed schema information, see [Data Dictionary](docs/data_dictionary.md).

## 🔍 Data Quality & Testing

The project implements comprehensive data quality measures:

- **Completeness Checks**: Validation for required fields and referential integrity
- **Consistency Checks**: Cross-table validation and business rule enforcement
- **Accuracy Checks**: Data type validation and range checking
- **Uniqueness Checks**: Duplicate detection and surrogate key validation

Run quality checks using:
```sql
\i sql/quality_checks/data_quality_tests.sql
```

## 📈 Analytics & Use Cases

This data warehouse supports various analytical use cases:

- **Sales Performance Analysis**: Track sales trends, seasonality, and growth
- **Customer Segmentation**: Analyze customer behavior and demographics
- **Product Performance**: Identify top-selling products and categories
- **Store Performance**: Compare store performance across regions
- **Inventory Management**: Analyze product turnover and stock levels
- **Return Analysis**: Understand return patterns and reasons

## 🛠️ Technologies Used

- **Database**: SQL (PostgreSQL/MySQL/SQL Server compatible)
- **ETL**: Custom SQL-based transformations
- **Documentation**: Markdown, SQL comments
- **Version Control**: Git
- **Testing**: SQL-based data quality tests

## 📚 Documentation

- [Data Dictionary](docs/data_dictionary.md) - Comprehensive data definitions
- [ER Diagrams](docs/er_diagrams/) - Visual database schema documentation
- [Data Flow Diagrams](docs/data_flow_diagrams/) - ETL process visualization
- [SQL Documentation](sql/) - Detailed script documentation

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines
- Follow SQL coding standards and naming conventions
- Add comprehensive comments to all SQL scripts
- Update documentation for any schema changes
- Include data quality tests for new transformations
- Test thoroughly before submitting pull requests

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Kaggle** for providing the Global Fashion Retail Sales dataset
- **Datafiniti** for the original data collection and curation
- The open-source community for tools and inspiration

## 📞 Contact

For questions, suggestions, or collaboration opportunities, please open an issue or reach out through GitHub.

---

**⭐ If you find this project helpful, please give it a star!**

Built with ❤️ for the data engineering community
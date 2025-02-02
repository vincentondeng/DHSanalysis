# DHSanalysis: An R Package for Analyzing DHS Data

## Overview
`DHSanalysis` is an R package designed for efficiently handling, analyzing, and summarizing **Demographic and Health Survey (DHS)** data. The package provides tools for loading data from multiple formats (CSV, Stata, SPSS, SAS, Excel, and Shapefiles) and computing useful summary statistics, including **missing value analysis**.

## Features
### ✅ Data Loading
- Supports loading data from various formats:
  - **CSV (`.csv`)**
  - **Stata (`.dta`)**
  - **SPSS (`.sav`)**
  - **SAS (`.sas7bdat`)**
  - **Excel (`.xls`, `.xlsx`)**
  - **Shapefiles (`.shp`)** for geospatial analysis

### ✅ Data Summarization
- **`count_nulls(df)`**: Counts the number of missing values in each column of a dataset.
- More statistical functions for data summarization coming soon.

## Installation
To install the `DHSanalysis` package from GitHub:

```r
# Install devtools if not installed
install.packages("devtools")

# Install DHSanalysis from GitHub
devtools::install_github("your-github-username/DHSanalysis")
```

## Usage
### **1. Load the Package**
```r
library(DHSanalysis)
```

### **2. Load Data**
```r
data <- load_dhs_data("data_file.csv")
```

### **3. Count Missing Values**
```r
missing_values <- count_nulls(data)
print(missing_values)
```

## Contributing
Contributions are welcome! Feel free to fork the repository, submit issues, or open pull requests.

## Authors
Developed and maintained by **Vincent Ondeng**.

For questions, please contact: **vincent.ondeng@aims.ac.rw**

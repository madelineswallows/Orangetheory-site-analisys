# Orangetheory-site-analisys
Demographic and geospatial analysis of U.S. markets for OrangeTheory Fitness site selection. Combines Census ACS data, isochrone modeling, and Tableau dashboards to evaluate expansion opportunities using Python and SQL.
# E6 Site Analysis

This repository contains a full workflow for evaluating U.S. markets for boutique fitness studios, using **Orangetheory Fitness locations** as a proxy.  
The project integrates demographic data, spatial analysis, and scoring models to support **site selection decisions**.

---

## 📂 Project Overview
The analysis moves from **data collection → cleaning → enrichment → modeling → visualization**:

1. **Data Collection**
   - Pulled Orangetheory studio locations from the Orangetheory API.
   - Exported locations to CSV, cleaned fields, and removed unnecessary columns.
   - Collected U.S. Census ACS demographic data (population, employment, income, healthcare professionals).
   - Built isochrones around studio sites using GIS data.

2. **Data Preparation**
   - Standardized CSVs and loaded into **MySQL** for structured storage.
   - Joined location data with demographic data (using GEOIDs and isochrone IDs).
   - Computed derived features:
     - Population within isochrone
     - Income-weighted averages
     - Percentage of medical professionals

3. **Modeling**
   - Designed non-linear income participation curve (logistic function).
   - Scored cities and individual studio sites across multiple factors:
     - Population density
     - Household income (non-linear participation adjustment)
     - Professional employment
     - Isochrone demographics

4. **Visualization**
   - Exported analysis tables into **Tableau**.
   - Built dashboards including:
     - **Site Map** of Orangetheory locations
     - **Demographic Profiles** per site
     - **Scoring Tables** to compare potential markets
     - **Final Site Selection Dashboard**

---

## 📊 Dashboards
The Tableau dashboards provide:
- Interactive **map of locations**
- Final **ranked site scoring table**  

---

## 🛠️ Tech Stack
- **Python** (pandas, geopandas, shapely)
- **SQL / MySQL Workbench**
- **Excel** (cleaning & transformations)
- **Tableau** (final dashboards)
- **QGIS / GeoPandas** (isochrone generation)
- **GitHub** (version control & collaboration)

---

## 📑 License
This project is licensed under the [MIT License](LICENSE).  

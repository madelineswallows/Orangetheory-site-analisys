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

## 🧮 Scoring Methodology
Each candidate site was evaluated using a composite score based on two main demographic factors.  

1. **Population Factor**  
   - Total population within an 8-minute isochrone.  
   - Normalized using min–max scaling across all sites.  

2. **Household Income Factor**  
   - Fitness participation increases with income, but not linearly.  
   - Modeled with a **logistic curve** based on industry benchmarks:  
     - At $60,000 → ~8% participation  
     - At $150,000 → ~25% participation  
   - The logistic function was applied to each site’s **weighted average household income** to generate an estimated participation percentage.  

3. **Final Score**  
   - Weighted combination of normalized factors:  
     ```
     Final Score = (Population * w1) 
                 + (Income Participation * w2)
     ```
   - Example weights: `w1 = 0.5`, `w2 = 0.5` (can be adjusted for sensitivity).  
   - Scores were then ranked to identify the most promising markets.  

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

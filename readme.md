# README — IADQ Confirmatory Factor Analysis & Psychometrics (R)

**Repository author:** Ghaith Al‑Gburi

**Study DOI / citation:** Al‑Gburi M, Waleed MA, Shevlin M, Al‑Gburi G. *Translation and Validation of the Arabic International Adjustment Disorder Questionnaire Among Patients with Physical Illness and Their Families in Iraq.* Chronic Stress (Thousand Oaks). 2025 Apr 16;9:24705470251332801. DOI: `10.1177/24705470251332801`.


## Purpose
This repository contains `analysis_code.R` — an R script used to perform confirmatory factor analysis (CFA) and psychometric validation for the IADQ instrument. The script runs multiple CFA models for both continuous scores and endorsement (ordinal) rates, computes composite reliability, corrected item‑total correlations (Spearman), and tests concurrent validity (robust linear models and MANOVA).

> **Data privacy:** this repository does **not** include participant‑level identifiable data. 

---

## Files in this repo
- `analysis_code.R` — the main analysis script.  
- `IADQ_dataset.csv` — the CSV file containing the data related to the study referenced above.  
- `README.md` — this file.  

---

## Required R version & packages
- R (>= 4.0 recommended)
- Required packages: `lavaan`, `semTools`, `robustbase`, `car`, `dplyr`, `psych`

Install packages in R with:

```r
install.packages(c("lavaan","semTools","robustbase","car","dplyr","psych"))
```

---

## Expected data format (column names)
The script expects a CSV with these columns (continuous items and endorsement items):

- Continuous items: `ajd10`, `ajd11`, `ajd12`, `ajd13`, `ajd14`, `ajd15`  
- Endorsement (ordinal) items: `ajd10e`, `ajd11e`, `ajd12e`, `ajd13e`, `ajd14e`, `ajd15e`

Other variables used in the script for validity checks or regressions (examples):
- `preoc`, `fta`, `total` — the derived IADQ subscale/total scores.  
- `se` — the IADQ stressor scale (used as a predictor for intrinsic concurrent validity).  
- `phq9`, `gad7` — external measures used for concurrent validity (PHQ‑9 and GAD‑7).  

---

## How to run
From R (repository root):

```r
source("analysis_code.R")
```

From the command line:

```bash
Rscript analysis_code.R
```

---

## Outputs produced by the script (what to expect)
- CFA summaries for continuous models (`cont_modX_fit`) with standardized loadings and fit indices.  
- CFA summaries for endorsement (ordinal) models (`endo_modX_fit`) using `WLSMV`.  
- Chi‑square difference tests comparing nested models.  
- Spearman item‑total correlations (item.stats from `psych::alpha`) and composite reliabilities (`compRelSEM`).  
- Robust regressions (`robustbase::lmrob`) and MANOVAs for concurrent validity tests.  

---

## License & citation
**License:** This repository is released under the **MIT License**.

**How to cite the study using this code:**

```
Al‑Gburi M, Waleed MA, Shevlin M, Al‑Gburi G. Translation and Validation of the Arabic International Adjustment Disorder Questionnaire Among Patients with Physical Illness and Their Families in Iraq. Chronic Stress. 2025. DOI: 10.1177/24705470251332801
```

---

## Contact
- **Author:** Ghaith Al‑Gburi
- **Email:** ghaith.ali.khaleel@gmail.com 
- **GitHub:** `(https://github.com/GhaithAl-Gburi)`  
- **ORCID:** `0000-0001-7427-8310`



---

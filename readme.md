# README — IADQ Psychometric Analysis (R)

**Repository author:** Ghaith Al‑Gburi

**Study DOI / citation:** Al‑Gburi M, Waleed MA, Shevlin M, Al‑Gburi G. *Translation and Validation of the Arabic International Adjustment Disorder Questionnaire Among Patients with Physical Illness and Their Families in Iraq.* Chronic Stress (Thousand Oaks). 2025 Apr 16;9:24705470251332801. DOI: `10.1177/24705470251332801`.

[![Read the Study](https://img.shields.io/badge/Read%20the%20Study-DOI-blue)](https://doi.org/10.1177/24705470251332801)

## Quick view
Click to view the full analysis results and visualizations:
[Open the full analysis report (PDF)](https://rawcdn.githack.com/GhaithAl-Gburi/IADQ-Arabic-Validation/main/analysis_report.pdf)

## Purpose
This repository contains `iadq_psychometric_analysis.R` — an R script used to perform confirmatory factor analysis (CFA) and psychometric validation for the IADQ instrument. The script runs multiple CFA models for both continuous scores and endorsement (ordinal) rates, computes composite reliability, corrected item‑total correlations (Spearman), and tests concurrent validity (robust linear models and MANOVA).

> **Data privacy:** this repository does **not** include participant‑level identifiable data. 

---

## Files in this repository
- `iadq_psychometric_analysis.R` — R script.
- `iadq_psychometric_analysis.Rmd` — R Markdown (script + narrative + results).
- `analysis_report.pdf` — Rendered PDF report for the complete analysis workflow.  
- `IADQ_dataset.csv` — CSV file containing the data used for statistical analysis.
- `survey.docx` — Doc file containing the arabic and english version of the research survey.
- `README.md` — This file.
- `LICENSE` — AGPL-3.0 License (reuse and citation conditions).

---

## Required R version & packages
- R (>= 4.0 recommended)
- Required packages: `lavaan`, `semTools`, `robustbase`, `car`, `dplyr`, `psych`

---

## Expected data format
The script expects a CSV with these columns:

| Category                   | Variable names                                                                 |
|---------------------------|----------------------------------------------------------------------------------|
| IADQ continuous items     | `ajd10`, `ajd11`, `ajd12`, `ajd13`, `ajd14`, `ajd15`                           |
| IADQ endorsement items    | `ajd10e`, `ajd11e`, `ajd12e`, `ajd13e`, `ajd14e`, `ajd15e`                     |
| Derived IADQ scores       | `preoc`, `fta`, `total`                                                         |
| Stressor scale            | `se`                                                                            |
| Mental-health outcomes    | `phq9`, `gad7`                                                                  |

---

## How to run
From R (repository root):

```r
source("iadq_psychometric_analysis.R")
```

From the command line:

```bash
Rscript iadq_psychometric_analysis.R
```

---

## Outputs produced by the script
- CFA summaries for continuous models (`cont_modX_fit`) with standardized loadings and fit indices.  
- CFA summaries for endorsement (ordinal) models (`endo_modX_fit`) using `WLSMV`.  
- Chi‑square difference tests comparing nested models.  
- Spearman item‑total correlations (item.stats from `psych::alpha`) and composite reliabilities (`compRelSEM`).  
- Robust regressions (`robustbase::lmrob`) and MANOVAs for concurrent validity tests.  

---

## License & citation
**License:** This repository is released under the **AGPL-3.0 License**.

**How to cite this repository:**

```
Al-Gburi G. IADQ Arabic Validation: Psychometric Analysis. GitHub repository. Available at: https://github.com/GhaithAl-Gburi/IADQ-Arabic-Validation
```

---

## Contact
- **Author:** Ghaith Al‑Gburi
- **Email:** ghaith.ali.khaleel@gmail.com 
- **GitHub:** `(https://github.com/GhaithAl-Gburi)`  
- **ORCID:** `0000-0001-7427-8310`

---

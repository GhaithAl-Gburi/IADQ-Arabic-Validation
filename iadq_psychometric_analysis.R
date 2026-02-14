# Settings

## Clear working environment

rm(list = ls())

## Required package
#lavaan and semTools : Perform confirmatory factor analysis and measure composite reliability.
#robustbase and car  : Perform univariate and multivariate regression.
#dplyr and psych     : Perform corrected item-total correlations.

packages <- c("lavaan","semTools","robustbase","car","dplyr","psych")

for (package in packages) {
  
  if (!requireNamespace(package, quietly = TRUE))
    install.packages(package)
  
  suppressPackageStartupMessages(library(package, character.only = TRUE))
  
}

## Import and inspect data attributes

# load the data file
IADQ <- read.csv("IADQ dataset.csv")

attributes(IADQ)[names(attributes(IADQ)) != "row.names"]

# Confirmatory factor analysis for continous scales

## Model 1: 1-factor solution
cont_mod1 <-'f =~ ajd10 + ajd11 + ajd12 + ajd13 + ajd14 + ajd15'
cont_mod1_fit <- cfa(cont_mod1, 
                     data = IADQ, 
                     estimator = "MLR"
)
summary(cont_mod1_fit, 
        standardized = TRUE, 
        fit.measures = TRUE
)

## Model 2: 2-factor solution
cont_mod2 <- 'f1 =~ ajd10 + ajd11 + ajd12
              f2 =~ ajd13 + ajd14 + ajd15
              #Correlation between factors
              f1 ~~ f2'
cont_mod2_fit <- cfa(cont_mod2, 
                     data = IADQ, 
                     estimator = "MLR"
)
summary(cont_mod2_fit, 
        standardized = TRUE, 
        fit.measures = TRUE
)

## Model 3: modified 2-factor solution
cont_mod3 <- 'f1 =~ ajd10 + ajd11
              f2 =~ ajd12 + ajd13 + ajd14 + ajd15
              #Correlation between factors
              f1 ~~ f2'
cont_mod3_fit <- cfa(cont_mod3, 
                     data = IADQ, 
                     estimator = "MLR"
)
summary(cont_mod3_fit, 
        standardized = TRUE, 
        fit.measures = TRUE
)

## Model 4: overlapping 2-factor solution
cont_mod4 <- 'f1 =~ ajd10 + ajd11 + ajd12
              f2 =~ ajd12 + ajd13 + ajd14 + ajd15
              #Correlation between factors
              f1 ~~ f2'
cont_mod4_fit <- cfa(cont_mod4, 
                     data = IADQ, 
                     estimator = "MLR"
)
summary(cont_mod4_fit, 
        standardized = TRUE, 
        fit.measures = TRUE
)

# Confirmatory factor analysis for endorsement rates

## Store variable names
ordered_vars <- c("ajd10e", "ajd11e", "ajd12e", "ajd13e", "ajd14e", "ajd15e")

## Model 1: 1-factor solution
endo_mod1 <- 'fe =~ ajd10e + ajd11e + ajd12e + ajd13e + ajd14e + ajd15e'
endo_mod1_fit <- cfa(endo_mod1, 
                     data = IADQ, 
                     estimator = "WLSMV", 
                     ordered = ordered_vars
)
summary(endo_mod1_fit, 
        standardized = TRUE, 
        fit.measures = TRUE
)

## Model 2: 2-factor solution
endo_mod2 <- 'f1e =~ ajd10e + ajd11e + ajd12e
              f2e =~ ajd13e + ajd14e + ajd15e
              #Correlation between factors
              f1e ~~ f2e'
endo_mod2_fit <- cfa(endo_mod2, 
                     data=IADQ, 
                     estimator = "WLSMV", 
                     ordered = ordered_vars
)
summary(endo_mod2_fit, 
        standardized = TRUE, 
        fit.measures = TRUE
)

## Model 3: modified 2-factor solution
endo_mod3 <- 'f1e =~ ajd10e + ajd11e
              f2e =~ ajd12e + ajd13e + ajd14e + ajd15e
              #Correlation between factors
              f1e ~~ f2e'
endo_mod3_fit <- cfa(endo_mod3,
                     data = IADQ, 
                     estimator = "WLSMV", 
                     ordered = ordered_vars
)
summary(endo_mod3_fit, 
        standardized = TRUE, 
        fit.measures = TRUE
)

## Model 4: overlapping 2-factor solution
endo_mod4 <- 'f1e =~ ajd10e + ajd11e + ajd12e
              f2e =~ ajd12e + ajd13e + ajd14e + ajd15e
              #Correlation between factors
              f1e ~~ f2e'
endo_mod4_fit <- cfa(endo_mod4, 
                     data = IADQ, 
                     estimator = "WLSMV", 
                     ordered = ordered_vars
)
summary(endo_mod4_fit, 
        standardized = TRUE, 
        fit.measures = TRUE
)

## Relative fitness between endorsement models

### Relative fitness between the 2-factor solutions and the 1-factor solution
lavTestLRT(endo_mod1_fit, endo_mod2_fit)
lavTestLRT(endo_mod1_fit, endo_mod3_fit)
lavTestLRT(endo_mod1_fit, endo_mod4_fit)

### Relative fitness between the overlapped 2-factor solutions and the original 2-factor solution
lavTestLRT(endo_mod2_fit, endo_mod4_fit)

# Reliability analysis

## Store items of each factors
Preop <- select(IADQ, "ajd10", "ajd11", "ajd12")
FTA <- select(IADQ, "ajd13", "ajd14", "ajd15")

## Corrected item-total spearman's correlation

### Preoccupation items
Preop_rel <- alpha(cor(Preop, method = "spearman"))
Preop_rel$item.stats

### Failure to adapt items
FTA_rel <- alpha(cor(FTA, method = "spearman"))
FTA_rel$item.stats

## Spearman's correlation to other scales

### Preoccupation items
print(corr.test(IADQ$ajd10, IADQ$fta, method = "spearman"), digits = 3)
print(corr.test(IADQ$ajd11, IADQ$fta, method = "spearman"), digits = 3)
print(corr.test(IADQ$ajd12, IADQ$fta, method = "spearman"), digits = 3)

### Failure to adapt items
print(corr.test(IADQ$ajd13, IADQ$preoc, method = "spearman"), digits = 3)
print(corr.test(IADQ$ajd14, IADQ$preoc, method = "spearman"), digits = 3)
print(corr.test(IADQ$ajd15, IADQ$preoc, method = "spearman"), digits = 3)

## Composite reliability

### Model 1: 1-factor solution

#For the total symptoms scale provided by model 1
comp_rel1 <- compRelSEM(cont_mod1_fit)
print(comp_rel1, digits = 3)

### Model 2: 2-factor solution

#For the preoccupation and failure to adapt subscales provided by model 2
comp_rel2 <- compRelSEM(cont_mod2_fit)
print(comp_rel2, digits = 3)

# Concurrent validity

## Intrinsic validity: stressor scale ---> preoccupation, failure to adapt

# Univariate model: stressor scale ---> preoccupation
se_preoc <- lmrob(preoc ~ se, data = IADQ)
summary(se_preoc)

# Univariate model: stressor scale ---> failure to adapt
se_fta <- lmrob(fta ~ se, data = IADQ)
summary(se_fta)

# Multivariate model: stressor scale ---> preoccupation, failure to adapt
se_multi <- manova(cbind(preoc, fta) ~ se, data = IADQ)
Anova(se_multi, type = "III")

## Extrensic validity: preoccupation, failure to adapt ---> PHQ-9, GAD-7

### Univariate models with preoccupation as a predictor

# preoccupation ---> PHQ-9
preoc_phq9 <- lmrob(phq9 ~ preoc, data = IADQ)
summary(preoc_phq9)

# preoccupation ---> GAD-7
preoc_gad7 <- lmrob(gad7 ~ preoc, data = IADQ)
summary(preoc_gad7)

### Univariate models with failure to adapt as a predictor

# failure to adapt ---> PHQ-9
fta_phq9 <- lmrob(phq9 ~ fta, data = IADQ)
summary(fta_phq9)

# failure to adapt ---> GAD-7
fta_gad7 <- lmrob(gad7 ~ fta, data = IADQ)
summary(fta_gad7)

### Univariate models with preoccupation and failure to adapt as predictors

# preoccupation, failure to adapt ---> PHQ-9
iadq_phq9 <- lmrob(phq9 ~ preoc + fta, data = IADQ)
summary(iadq_phq9)

# preoccupation, failure to adapt ---> GAD-7
iadq_gad7 <- lmrob(gad7 ~ preoc + fta, data = IADQ)
summary(iadq_gad7)

### Univariate models with total symptoms scale as a predictor

# total symptoms scale ---> PHQ-9
total_phq9 <- lmrob(phq9 ~ total, data = IADQ)
summary(total_phq9)

# total symptoms scale ---> PHQ-9
total_gad7 <- lmrob(gad7 ~ total, data = IADQ)
summary(total_gad7)

### Multivariate models

# preoccupation ---> PHQ-9, GAD-7
preoc_multi <- manova(cbind(phq9, gad7) ~ preoc, data = IADQ)
Anova(preoc_multi, type = "III")

# failure to adapt ---> PHQ-9, GAD-7
fta_multi <- manova(cbind(phq9, gad7) ~ fta, data = IADQ)
Anova(fta_multi, type = "III")

# preoccupation, failure to adapt ---> PHQ-9, GAD-7
iadq_multi <- manova(cbind(phq9, gad7) ~ preoc + fta, data = IADQ)
Anova(iadq_multi, type = "III")

# total symptoms scale ---> PHQ-9, GAD-7
total_multi <- manova(cbind(phq9, gad7) ~ total, data = IADQ)
Anova(total_multi, type = "III")

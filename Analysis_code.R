#load lavaan and semTools packages to perform confirmatory factor analysis and measure composite reliability
library(lavaan)    
library(semTools)

#load robustbase and car packages to perform univariate and multivariate analyses
library(robustbase)
library(car)

#load dplyr and psych packages to calculate corrected item-total correlated based on spearman's correlation matrix
library(dplyr)
library(psych)

#load the data file
IADQ <- read.csv("IADQ dataset.csv")

#Confirmatory factor analyses of continuous data:

#Model 1: 1-factor solution
cont_mod1 <-'f =~ ajd10 + ajd11 + ajd12 + ajd13 + ajd14 + ajd15'
cont_mod1_fit <- cfa(cont_mod1, data=IADQ, estimator = "MLR")
summary(cont_mod1_fit, standardized = TRUE, fit.measures = TRUE)

#Model 2: 2-factor solution
cont_mod2 <- 'f1 =~ ajd10 + ajd11 + ajd12
              f2 =~ ajd13 + ajd14 + ajd15
              #Correlation between factors
              f1 ~~ f2'
cont_mod2_fit <- cfa(cont_mod2, data=IADQ, estimator = "MLR")
summary(cont_mod2_fit, standardized = TRUE, fit.measures = TRUE)

#Model 3: modified 2-factor solution
cont_mod3 <- 'f1 =~ ajd10 + ajd11
              f2 =~ ajd12 + ajd13 + ajd14 + ajd15
              #Correlation between factors
              f1 ~~ f2'
cont_mod3_fit <- cfa(cont_mod3, data=IADQ, estimator = "MLR")
summary(cont_mod3_fit, standardized = TRUE, fit.measures = TRUE)

#Model 4: overlapping 2-factor solution
cont_mod4 <- 'f1 =~ ajd10 + ajd11 + ajd12
              f2 =~ ajd12 + ajd13 + ajd14 + ajd15
              #Correlation between factors
              f1 ~~ f2'
cont_mod4_fit <- cfa(cont_mod4, data=IADQ, estimator = "MLR")
summary(cont_mod4_fit, standardized = TRUE, fit.measures = TRUE)


#Confirmatory factor analyses for endorsement rates:

#Model 1: 1-factor solution
endo_mod1 <- 'fe =~ ajd10e + ajd11e + ajd12e + ajd13e + ajd14e + ajd15e'
endo_mod1_fit <- cfa(endo_mod1, data=IADQ, estimator = "WLSMV", ordered = c("ajd10e", "ajd11e", "ajd12e", "ajd13e", "ajd14e", "ajd15e"))
summary(endo_mod1_fit, standardized = TRUE, fit.measures = TRUE)

#Model 2: 2-factor solution
endo_mod2 <- 'f1e =~ ajd10e + ajd11e + ajd12e
              f2e =~ ajd13e + ajd14e + ajd15e
              #Correlation between factors
              f1e ~~ f2e'
endo_mod2_fit <- cfa(endo_mod2, data=IADQ, estimator = "WLSMV", ordered = c("ajd10e", "ajd11e", "ajd12e", "ajd13e", "ajd14e", "ajd15e"))
summary(endo_mod2_fit, standardized = TRUE, fit.measures = TRUE)

#Model 3: modified 2-factor solution
endo_mod3 <- 'f1e =~ ajd10e + ajd11e
              f2e =~ ajd12e + ajd13e + ajd14e + ajd15e
              #Correlation between factors
              f1e ~~ f2e'
endo_mod3_fit <- cfa(endo_mod3, data=IADQ, estimator = "WLSMV", ordered = c("ajd10e", "ajd11e", "ajd12e", "ajd13e", "ajd14e", "ajd15e"))
summary(endo_mod3_fit, standardized = TRUE, fit.measures = TRUE)

#Model 4: overlapping 2-factor solution
endo_mod4 <- 'f1e =~ ajd10e + ajd11e + ajd12e
              f2e =~ ajd12e + ajd13e + ajd14e + ajd15e
              #Correlation between factors
              f1e ~~ f2e'
endo_mod4_fit <- cfa(endo_mod4, data=IADQ, estimator = "WLSMV", ordered = c("ajd10e", "ajd11e", "ajd12e", "ajd13e", "ajd14e", "ajd15e"))
summary(endo_mod4_fit, standardized = TRUE, fit.measures = TRUE)

#Perform the chi-square DiffTest to assess the relative fitness:

#Relative fitness between the 2-factor solutions and the 1-factor solution
anova(endo_mod1_fit, endo_mod2_fit)
anova(endo_mod1_fit, endo_mod3_fit)
anova(endo_mod1_fit, endo_mod4_fit)

#Relative fitness between the overlapped 2-factor solutions and the original 2-factor solution
anova(endo_mod2_fit, endo_mod4_fit)


#Calculating the correlation between each item and the two factors

#Store items of each factors
Preop <- select(IADQ, 23, 24, 25)
FTA <- select(IADQ, 26, 27, 28)

#Conducting reliability analysis for each factor and printing item statistics including the corrected-item total correlation
Preop_rel <- alpha(cor(Preop, method = "spearman"))
Preop_rel$item.stats
FTA_rel <- alpha(cor(FTA, method = "spearman"))
FTA_rel$item.stats

#Printing the correlation between the preoccupation items (Items: 10-12) and the failure to adapt subscale
print(corr.test(IADQ$ajd10, IADQ$fta, method = "spearman"), digits = 3)
print(corr.test(IADQ$ajd11, IADQ$fta, method = "spearman"), digits = 3)
print(corr.test(IADQ$ajd12, IADQ$fta, method = "spearman"), digits = 3)

#Printing the correlation between the failure to adapt items (Items: 13-15) and the preoccupation subscale
print(corr.test(IADQ$ajd13, IADQ$preoc, method = "spearman"), digits = 3)
print(corr.test(IADQ$ajd14, IADQ$preoc, method = "spearman"), digits = 3)
print(corr.test(IADQ$ajd15, IADQ$preoc, method = "spearman"), digits = 3)


# Calculate composite reliability:

#For the total symptoms scale provided by model 1
comp_rel1 <- compRelSEM(cont_mod1_fit)
print(comp_rel1, digits = 3)

#For the preoccupation and failure to adapt subscales provided by model 2
comp_rel2 <- compRelSEM(cont_mod2_fit)
print(comp_rel2, digits = 3)


#A) Intrinsic concurrent validity: Stressor scale ---> preoccupation, failure to adapt
se_preoc <- lmrob(preoc ~ se, data = IADQ)
summary(se_preoc)
se_fta <- lmrob(fta ~ se, data = IADQ)
summary(se_fta)
se_multi <- manova(cbind(preoc, fta) ~ se, data = IADQ)
Anova(se_multi, type = "III", robust = TRUE)

#Extrensic concurrent validity:

#B) Preoccupation ---> PHQ-9, GAD-7
preoc_phq9 <- lmrob(phq9 ~ preoc, data = IADQ)
summary(preoc_phq9)
preoc_gad7 <- lmrob(gad7 ~ preoc, data = IADQ)
summary(preoc_gad7)
preoc_multi <- manova(cbind(phq9, gad7) ~ preoc, data = IADQ)
Anova(preoc_multi, type = "III", robust = TRUE)

#C) Failure to adapt ---> PHQ-9, GAD-7
fta_phq9 <- lmrob(phq9 ~ fta, data = IADQ)
summary(fta_phq9)
fta_gad7 <- lmrob(gad7 ~ fta, data = IADQ)
summary(fta_gad7)
fta_multi <- manova(cbind(phq9, gad7) ~ fta, data = IADQ)
Anova(fta_multi, type = "III", robust = TRUE)

#D) Preoccupation, Failure to adapt ---> PHQ-9, GAD-7
iadq_phq9 <- lmrob(phq9 ~ preoc + fta, data = IADQ)
summary(iadq_phq9)
iadq_gad7 <- lmrob(gad7 ~ preoc + fta, data = IADQ)
summary(iadq_gad7)
iadq_multi <- manova(cbind(phq9, gad7) ~ preoc + fta, data = IADQ)
Anova(iadq_multi, type = "III", robust = TRUE)

#E) Preoccupation + Failure to adapt ---> PHQ-9, GAD-7
total_phq9 <- lmrob(phq9 ~ total, data = IADQ)
summary(total_phq9)
total_gad7 <- lmrob(gad7 ~ total, data = IADQ)
summary(total_gad7)
total_multi <- manova(cbind(phq9, gad7) ~ total, data = IADQ)
Anova(total_multi, type = "III", robust = TRUE)

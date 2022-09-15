# Haplotype Trend Regression with eXtra flexibility (HTRX)

This is the location for the Ancestry Anomaly quantification tool that was used in Barrie et al. 2022 (in prep).

## Authors: 
Yaoling Yang (yaoling.yang@bristol.ac.uk)   
Daniel Lawson (dan.lawson@bristol.ac.uk)

## Introduction:

Haplotype Trend Regression with eXtra flexibility (HTRX) searches for haplotype patterns that include single SNPs and non-contiguous haplotypes.

HTRX is a template gives a value for each SNP taking values of ‘0’ or ‘1’, reflecting whether the reference allele of each SNP is present or absent, or an ‘X’ meaning either value is allowed.

We used a two-step procedure to select the best HTRX model.    
Step 1: select candidate models;    
Step 2: select the best model using 10-fold cross-validation.

We also proposed "cumulative HTRX" to perform HTRX on longer haplotypes, i.e. haplotypes which include more than 7 SNPs.

## Examples:
[HTRX_simulation.R](https://github.com/YaolingYang/HTRX/blob/main/HTRX_simulation.R)

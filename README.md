# Haplotype Trend Regression with eXtra flexibility (HTRX)

This is the location for the HTRX tool that was used in Barrie et al. 2022 (submitted).

* Authors:   
Yaoling Yang (yaoling.yang@bristol.ac.uk)   
Daniel Lawson (dan.lawson@bristol.ac.uk)

* License: GPL-3.0-or-later

## Introduction:

Haplotype Trend Regression with eXtra flexibility (HTRX) searches for haplotype patterns that include single SNPs and non-contiguous haplotypes.

HTRX is a template gives a value for each SNP taking values of ‘0’ or ‘1’, reflecting whether the reference allele of each SNP is present or absent, or an ‘X’ meaning either value is allowed.

We used a two-step procedure to select the best HTRX model.    
Step 1: select candidate models;    
Step 2: select the best model using 10-fold cross-validation.

Longer haplotypes are important for discovering interactions. However, there are $3^k-1$ haplotypes in HTRX if the region contains $k$ SNPs, making it unrealistic for regions with large numbers of SNPs. To address this issue, we proposed "cumulative HTRX" that enables HTRX to run on longer haplotypes, i.e. haplotypes which include more than 7 SNPs (we recommend).

## Install R package "HTRX"
```
devtools::install_github("YaolingYang/HTRX")
```

## Examples:
```
library(HTRX)

## use dataset "SNP1", "SNP2" and "data_nosnp"  
## "SNP1" and "SNP2" are both genomes of 8 SNPs for 20,000 individuals  
## "data_nosnp" is a simulated dataset which contains the outcome (binary), sex, age and 18 PCs  
## we perform HTRX on the first 4 SNPs  
## we first generate all the haplotype data, as defined by HTRX  
HTRX_matrix=make_htrx(SNP1[,1:4],SNP2[,1:4])  

## next compute the maximum number of independent features  
featurecap=htrx_max(nsnp=4)  

## then perform HTRX using 2-step cross-validation  
do_cv(data_nosnp,HTRX_matrix,train_proportion=0.5,sim_times=3,featurecap=featurecap,
      usebinary=1,method="stratified",criteria="BIC",runparallel=FALSE)  

## we perform cumulative HTRX on all the 8 SNPs using 2-step cross-validation  
do_cumulative_htrx(data_nosnp,SNP1,SNP2,train_proportion=0.5,sim_times=2,featurecap=40,usebinary=1,
                   randomorder=TRUE,method="stratified",criteria="BIC",runparallel=FALSE)  

## Parallel programming is avilable by setting "runparallel=TRUE" on Linux or Mac.  
```

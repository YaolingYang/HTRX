
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Haplotype Trend Regression with eXtra flexibility (HTRX)

<!-- badges: start -->
<!-- badges: end -->

This is the location for the HTRX tool that was used in [Barrie, W. et
al. Genetic risk for Multiple Sclerosis originated in Pastoralist Steppe
populations. bioRxiv
(2022)](https://www.biorxiv.org/content/10.1101/2022.09.23.509097v1).

-   Authors:  
    Yaoling Yang (<yaoling.yang@bristol.ac.uk>)  
    Daniel Lawson (<dan.lawson@bristol.ac.uk>)

-   License: GPL-3

## Introduction:

Haplotype Trend Regression with eXtra flexibility (HTRX) searches for
haplotype patterns that include single nucleotide polymorphisms (SNPs)
and non-contiguous haplotypes.

HTRX is a template gives a value for each SNP taking values of ‘0’ or
‘1’, reflecting whether the reference allele of each SNP is present or
absent, or an ‘X’ meaning either value is allowed.

We used a two-step procedure to select the best HTRX model.  
Step 1: select candidate models;  
Step 2: select the best model using 10-fold cross-validation.

Longer haplotypes are important for discovering interactions. However,
there are $3^k-1$ haplotypes in HTRX if the region contains $k$ SNPs,
making it unrealistic for regions with large numbers of SNPs. To address
this issue, we proposed “cumulative HTRX” that enables HTRX to run on
longer haplotypes, i.e. haplotypes which include at least 7 SNPs (we
recommend).

## Install R package “HTRX”

``` r
devtools::install_github("YaolingYang/HTRX")
```

## Examples

``` r
library(HTRX)

## use dataset "example_hap1", "example_hap2" and "example_data_nosnp"
## "example_hap1" and "example_hap2" are both genomes of 8 SNPs for 5,000 individuals (diploid data) 
## "example_data_nosnp" is an example dataset which contains the outcome (binary), sex, age and 18 PCs

## visualise the covariates data
head(HTRX::example_data_nosnp)

## visualise the genotype data for the first genome
head(HTRX::example_hap1)

## we perform HTRX on the first 4 SNPs
## we first generate all the haplotype data, as defined by HTRX
HTRX_matrix=make_htrx(HTRX::example_hap1[,1:4],HTRX::example_hap2[,1:4])

## If the data is haploid, please set
## HTRX_matrix=make_htrx(HTRX::example_hap1[,1:4],HTRX::example_hap1[,1:4])

## next compute the maximum number of independent features
featurecap=htrx_max(nsnp=4)

## then perform HTRX using 2-step cross-validation
## to compute additional variance explained by haplotypes
## If you want to compute total variance explained, please set gain=FALSE
htrx_results <- do_cv(HTRX::example_data_nosnp,
                      HTRX_matrix,train_proportion=0.5,
                      sim_times=3,featurecap=featurecap,usebinary=1,
                      method="stratified",criteria="BIC",
                      gain=TRUE,runparallel=FALSE)

## If we want to compute the total variance explained
## we can set gain=FALSE in the above example

#' ## we perform cumulative HTRX on all the 8 SNPs using 2-step cross-validation
#' ## to compute additional variance explained by haplotypes
#' ## If the data is haploid, please set hap2=HTRX::example_hap1
#' ## If you want to compute total variance explained, please set gain=FALSE
#' ## For Linux/MAC users, we strongly encourage you to set runparallel=TRUE
cumu_htrx_results <- do_cumulative_htrx(data_nosnp=HTRX::example_data_nosnp,
                                        hap1=HTRX::example_hap1,
                                        hap2=HTRX::example_hap2,
                                        train_proportion=0.5,sim_times=1,
                                        featurecap=6,usebinary=1,
                                        randomorder=TRUE,method="stratified",
                                        criteria="BIC",runparallel=FALSE)
```

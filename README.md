# Haplotype Trend Regression with eXtra flexibility (HTRX)

This is the location for the HTRX tool that was used in Barrie et al. 2022 (in prep).

Authors:   
Yaoling Yang (yaoling.yang@bristol.ac.uk)   
Daniel Lawson (dan.lawson@bristol.ac.uk)

License: GPL-3.0-or-later

## Introduction:

Haplotype Trend Regression with eXtra flexibility (HTRX) searches for haplotype patterns that include single SNPs and non-contiguous haplotypes.

HTRX is a template gives a value for each SNP taking values of ‘0’ or ‘1’, reflecting whether the reference allele of each SNP is present or absent, or an ‘X’ meaning either value is allowed.

We used a two-step procedure to select the best HTRX model.    
Step 1: select candidate models;    
Step 2: select the best model using 10-fold cross-validation.

Longer haplotypes are important for discovering interactions. However, there are $3^k-1$ haplotypes in HTRX if the region contains $k$ SNPs, making it unrealistic for regions with large numbers of SNPs. To address this issue, we proposed "cumulative HTRX" that enables HTRX to run on longer haplotypes, i.e. haplotypes which include more than 7 SNPs (we recommend).

## Examples:
[HTRX_simulation.R](https://github.com/YaolingYang/HTRX/blob/main/HTRX_simulation.R)

Parallel programming is avilable by setting "runparallel=TRUE" on Linux or Mac.

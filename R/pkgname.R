#' @title HTRX: Haplotype Trend Regression with eXtra flexibility
#'
#' @description
#' This is the software for "HTRX - Haplotype Trend Regression with eXtra flexibility (HTRX)"
#' based on the papar Genetic risk for Multiple Sclerosis originated in Pastoralist Steppe populations, Barrie W, Yang Y, Attfield K E, et al (2022).
#'
#' HTRX searches for haplotype patterns that include single nucleotide polymorphisms (SNPs) and non-contiguous haplotypes.
#'
#' HTRX is a template gives a value for each SNP taking values of ‘0’ or ‘1’, reflecting
#' whether the reference allele of each SNP is present or absent, or an ‘X’ meaning either value is allowed.
#'
#' We used a two-step procedure to select the best HTRX model: \code{\link{do_cv}}.
#'
#' Step 1: select candidate models using AIC, BIC or lasso;
#'
#' Step 2: select the best model using 10-fold cross-validation.
#'
#' There is also an option to directly perform 10-fold cross-validation: \code{\link{do_cv_direct}}.
#' This method loses some accuracy and doesn't return the fixed features selected, but saves computational time.
#'
#' Longer haplotypes are important for discovering interactions.
#' However, too many haplotypes make original HTRX unrealistic for regions with large numbers of SNPs.
#' We proposed "cumulative HTRX" that enables HTRX to run on longer haplotypes: \code{\link{do_cumulative_htrx}}.
#'
#' The code for HTRX is hosted at \url{https://github.com/YaolingYang/HTRX}.
#'
#' @references
#' Yang Y, Lawson DJ. HTRX: an R package for learning non-contiguous haplotypes associated with a phenotype. Bioinformatics Advances 1.1 (2023): vbab038.
#'
#' Barrie, William, et al. "Genetic risk for Multiple Sclerosis originated in Pastoralist Steppe populations." bioRxiv (2022): 2022.09.23.509097.
#'
#' Eforn, B. "Bootstrap methods: another look at the jackknife." The Annals of Statistics 7 (1979): 1-26.
#'
#' Schwarz, Gideon. "Estimating the dimension of a model." The annals of statistics (1978): 461-464.
#'
#' McFadden, Daniel. "Conditional logit analysis of qualitative choice behavior." (1973).
#'
#' Akaike, Hirotugu. "A new look at the statistical model identification." IEEE transactions on automatic control 19.6 (1974): 716-723.
#'
#' Tibshirani, Robert. "Regression shrinkage and selection via the lasso." Journal of the Royal Statistical Society: Series B (Methodological) 58.1 (1996): 267-288.
#' @importFrom methods is
"_PACKAGE"
#> [1] "_PACKAGE"

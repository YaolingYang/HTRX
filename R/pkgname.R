#' @title HTRX: Haplotype Trend Regression with eXtra flexibility
#'
#' @description
#' This is the software for "HTRX - Haplotype Trend Regression with eXtra flexibility (HTRX)"
#' based on the papar Genetic risk for Multiple Sclerosis originated in Pastoralist Steppe populations, Barrie et al, 2022.
#'
#' HTRX searches for haplotype patterns that include single SNPs and non-contiguous haplotypes.
#'
#' HTRX is a template gives a value for each SNP taking values of ‘0’ or ‘1’, reflecting
#' whether the reference allele of each SNP is present or absent, or an ‘X’ meaning either value is allowed.
#'
#' We used a two-step procedure to select the best HTRX model: \code{\link{do_cv}}.
#'
#' Step 1: select candidate models;
#'
#' Step 2: select the best model using 10-fold cross-validation.
#'
#' Longer haplotypes are important for discovering interactions.
#' However, too many haplotypes make original HTRX unrealistic for regions with large numbers of SNPs.
#' We proposed "cumulative HTRX" that enables HTRX to run on longer haplotypes: \code{\link{do_cumulative_htrx}}.
#'
#' The code for HTRX is hosted at \url{https://github.com/YaolingYang/HTRX}.
#'
#' @references
#' Barrie, W. et al. Genetic risk for Multiple Sclerosis originated in Pastoralist Steppe populations. bioRxiv (2022).
#' @importFrom methods is
"_PACKAGE"
#> [1] "_PACKAGE"

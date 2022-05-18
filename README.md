HTRX is an extension to Haplotype trend regression (HTR).

This method is useful to find the important haplotypes of a gene region through defining haplotypes and stepwise regression.

We use "X" to denote the SNP which we don't care about the actual genotype.

For example, we have haplotype "10X1", which means the first SNP must be 1, the second SNP must be 0, we don't care the third SNP, and the fourth SNP must be 1.

For a region with N SNPs, there are 3^N - 1 different haplotypes.

Finally, we use forward regression to select haplotypes which add the largest cumulative adjusted R^2 in turn

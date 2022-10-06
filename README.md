
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
haplotype patterns that include single SNPs and non-contiguous
haplotypes.

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

    ##   outcome sex age        PC1        PC2         PC3        PC4        PC5
    ## 1       0   0  87 -0.3946290  0.1751632  0.72999405 -0.3049336 -0.2433724
    ## 2       0   0  34  0.2869138 -0.2055325  0.37361336 -0.8489118  0.5310107
    ## 3       0   1  39 -0.9252727 -0.5553259 -0.29047879 -0.9382730  0.8586864
    ## 4       0   1  61  0.7663851 -0.3355833 -0.54738804 -0.3394078 -0.8374060
    ## 5       0   0  67 -0.7261653  0.7791465  0.18467195 -0.2298223 -0.6523392
    ## 6       0   0  43 -0.4797803  0.7210223  0.01836757 -0.4580152 -0.6798745
    ##           PC6        PC7        PC8        PC9       PC10       PC11
    ## 1  0.80612553 0.78295954  0.8723872  0.6493171  0.5593460  0.3732597
    ## 2 -0.67914184 0.58863862  0.6281459 -0.5332201  0.9648134  0.2152402
    ## 3  0.90939275 0.97835009 -0.8923880 -0.2545172  0.7065566  0.3875244
    ## 4  0.84020819 0.19549188 -0.4765567 -0.8081984  0.8262028 -0.6937875
    ## 5  0.63487568 0.09996258  0.8454220 -0.5931054  0.2462421 -0.7392449
    ## 6 -0.08966436 0.20596299  0.5920217 -0.3022342 -0.4759106 -0.4967881
    ##          PC12       PC13      PC14       PC15       PC16       PC17       PC18
    ## 1 -0.24080400  0.7101190 0.4140822  0.8791142 -0.4973299 -0.4717865  0.7268139
    ## 2 -0.30544821  0.9231099 0.1959772 -0.6013541 -0.3590845 -0.9558931  0.4875206
    ## 3 -0.28885855 -0.2391711 0.2539153 -0.6055497  0.4396926  0.7460097 -0.5175669
    ## 4  0.13863946 -0.1630428 0.5843988 -0.5598429  0.1288273  0.1097582 -0.6868010
    ## 5 -0.02206002  0.1466805 0.8103998  0.9309086  0.4334223  0.8432429 -0.2139930
    ## 6  0.69803406 -0.2581290 0.4259062 -0.1399754  0.1839596 -0.5211869  0.3721842

    ##   SNP1 SNP2 SNP3 SNP4 SNP5 SNP6 SNP7 SNP8
    ## 1    0    0    1    1    0    0    0    1
    ## 2    1    1    0    0    0    0    1    1
    ## 3    1    0    1    1    0    0    1    1
    ## 4    0    1    1    1    0    0    1    1
    ## 5    0    1    0    1    0    0    1    0
    ## 6    0    0    1    1    0    0    0    0

    ## [1] "Training..."
    ## Adding Feature Number 1 
    ## ... trying feature 1 0000 with BIC 2193.873 
    ## ... trying feature 2 1000 with BIC 2218.934 
    ## ... trying feature 3 X000 with BIC 2214.765 
    ## ... trying feature 4 0100 with BIC 2192.351 
    ## ... trying feature 5 1100 with BIC 2213.57 
    ## ... trying feature 6 X100 with BIC 2218.502 
    ## ... trying feature 7 0X00 with BIC 2165.28 
    ## ... trying feature 8 1X00 with BIC 2211.424 
    ## ... trying feature 9 XX00 with BIC 2210.777 
    ## ... trying feature 10 0010 with BIC 2209.683 
    ## ... trying feature 11 1010 with BIC 2204.081 
    ## ... trying feature 12 X010 with BIC 2222.301

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 2185.689 
    ## ... trying feature 14 1110 with BIC 2218.282 
    ## ... trying feature 15 X110 with BIC 2214.281 
    ## ... trying feature 16 0X10 with BIC 2181.757 
    ## ... trying feature 17 1X10 with BIC 2202.132 
    ## ... trying feature 18 XX10 with BIC 2219.227 
    ## ... trying feature 19 00X0 with BIC 2183.347 
    ## ... trying feature 20 10X0 with BIC 2202.692 
    ## ... trying feature 21 X0X0 with BIC 2219.044

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 2154.209 
    ## ... trying feature 23 11X0 with BIC 2210.627 
    ## ... trying feature 24 X1X0 with BIC 2210.631 
    ## ... trying feature 25 0XX0 with BIC 2123.793 
    ## ... trying feature 26 1XX0 with BIC 2190.951 
    ## ... trying feature 27 XXX0 with BIC 2209.028 
    ## ... trying feature 28 0001 with BIC 2172.307 
    ## ... trying feature 29 1001 with BIC 2141.35 
    ## ... trying feature 30 X001 with BIC 2222.296 
    ## ... trying feature 31 0101 with BIC 2074.204 
    ## ... trying feature 32 1101 with BIC 2132.739 
    ## ... trying feature 33 X101 with BIC 2220.125 
    ## ... trying feature 34 0X01 with BIC 2049.05 
    ## ... trying feature 35 1X01 with BIC 2036.93 
    ## ... trying feature 36 XX01 with BIC 2221.335 
    ## ... trying feature 37 0011 with BIC 2182.912 
    ## ... trying feature 38 1011 with BIC 2045.127 
    ## ... trying feature 39 X011 with BIC 2207.994 
    ## ... trying feature 40 0111 with BIC 1999.057 
    ## ... trying feature 41 1111 with BIC 2027.746 
    ## ... trying feature 42 X111 with BIC 2222.272 
    ## ... trying feature 43 0X11 with BIC 2013.643 
    ## ... trying feature 44 1X11 with BIC 1788.303 
    ## ... trying feature 45 XX11 with BIC 2210.909 
    ## ... trying feature 46 00X1 with BIC 2114.212 
    ## ... trying feature 47 10X1 with BIC 1928.301 
    ## ... trying feature 48 X0X1 with BIC 2209.283 
    ## ... trying feature 49 01X1 with BIC 1822.588 
    ## ... trying feature 50 11X1 with BIC 1905.75 
    ## ... trying feature 51 X1X1 with BIC 2220.769 
    ## ... trying feature 52 0XX1 with BIC 1644.088 
    ## ... trying feature 53 1XX1 with BIC 1350.114 
    ## ... trying feature 54 XXX1 with BIC 2209.028 
    ## ... trying feature 55 000X with BIC 2147.586 
    ## ... trying feature 56 100X with BIC 2139.739 
    ## ... trying feature 57 X00X with BIC 2221.259 
    ## ... trying feature 58 010X with BIC 2037.719 
    ## ... trying feature 59 110X with BIC 2123.027 
    ## ... trying feature 60 X10X with BIC 2217.547 
    ## ... trying feature 61 0X0X with BIC 1977.042 
    ## ... trying feature 62 1X0X with BIC 2020.251 
    ## ... trying feature 63 XX0X with BIC 2215.969 
    ## ... trying feature 64 001X with BIC 2168.686 
    ## ... trying feature 65 101X with BIC 2023.705 
    ## ... trying feature 66 X01X with BIC 2208.619 
    ## ... trying feature 67 011X with BIC 1957.194 
    ## ... trying feature 68 111X with BIC 2028.035 
    ## ... trying feature 69 X11X with BIC 2220.667 
    ## ... trying feature 70 0X1X with BIC 1947.549 
    ## ... trying feature 71 1X1X with BIC 1756.88 
    ## ... trying feature 72 XX1X with BIC 2215.969 
    ## ... trying feature 73 00XX with BIC 2061.066 
    ## ... trying feature 74 10XX with BIC 1897.115 
    ## ... trying feature 75 X0XX with BIC 2214.967 
    ## ... trying feature 76 01XX with BIC 1729.184 
    ## ... trying feature 77 11XX with BIC 1893.858 
    ## ... trying feature 78 X1XX with BIC 2214.967 
    ## ... trying feature 79 0XXX with BIC 1225.758 
    ## ... trying feature 80 1XXX with BIC 1225.758 
    ## ... Using feature 79 0XXX 
    ## Adding Feature Number 2 
    ## ... trying feature 1 0000 with BIC 1227.245 
    ## ... trying feature 2 1000 with BIC 1225.035 
    ## ... trying feature 3 X000 with BIC 1218.705 
    ## ... trying feature 4 0100 with BIC 1222.198 
    ## ... trying feature 5 1100 with BIC 1233.231 
    ## ... trying feature 6 X100 with BIC 1227.701 
    ## ... trying feature 7 0X00 with BIC 1217.551 
    ## ... trying feature 8 1X00 with BIC 1226.13 
    ## ... trying feature 9 XX00 with BIC 1212.369 
    ## ... trying feature 10 0010 with BIC 1233.436 
    ## ... trying feature 11 1010 with BIC 1223.548 
    ## ... trying feature 12 X010 with BIC 1229.18

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1221.603 
    ## ... trying feature 14 1110 with BIC 1227.859 
    ## ... trying feature 15 X110 with BIC 1219.194 
    ## ... trying feature 16 0X10 with BIC 1231.274 
    ## ... trying feature 17 1X10 with BIC 1218.436 
    ## ... trying feature 18 XX10 with BIC 1217.509 
    ## ... trying feature 19 00X0 with BIC 1231.677 
    ## ... trying feature 20 10X0 with BIC 1213.943 
    ## ... trying feature 21 X0X0 with BIC 1215.586

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1209.871 
    ## ... trying feature 23 11X0 with BIC 1228.715 
    ## ... trying feature 24 X1X0 with BIC 1214.631 
    ## ... trying feature 25 0XX0 with BIC 1218.51 
    ## ... trying feature 26 1XX0 with BIC 1209.727 
    ## ... trying feature 27 XXX0 with BIC 1195.583 
    ## ... trying feature 28 0001 with BIC 1218.356 
    ## ... trying feature 29 1001 with BIC 1229.534 
    ## ... trying feature 30 X001 with BIC 1232.053 
    ## ... trying feature 31 0101 with BIC 1190.287 
    ## ... trying feature 32 1101 with BIC 1232.701 
    ## ... trying feature 33 X101 with BIC 1226.123 
    ## ... trying feature 34 0X01 with BIC 1233.521 
    ## ... trying feature 35 1X01 with BIC 1232.63 
    ## ... trying feature 36 XX01 with BIC 1232.776 
    ## ... trying feature 37 0011 with BIC 1169.026 
    ## ... trying feature 38 1011 with BIC 1231.409 
    ## ... trying feature 39 X011 with BIC 1191.751 
    ## ... trying feature 40 0111 with BIC 1173.112 
    ## ... trying feature 41 1111 with BIC 1221.157 
    ## ... trying feature 42 X111 with BIC 1231.76 
    ## ... trying feature 43 0X11 with BIC 1225.633 
    ## ... trying feature 44 1X11 with BIC 1216.003 
    ## ... trying feature 45 XX11 with BIC 1209.055 
    ## ... trying feature 46 00X1 with BIC 1091.191 
    ## ... trying feature 47 10X1 with BIC 1233.487 
    ## ... trying feature 48 X0X1 with BIC 1181.428 
    ## ... trying feature 49 01X1 with BIC 1116.723 
    ## ... trying feature 50 11X1 with BIC 1219.793 
    ## ... trying feature 51 X1X1 with BIC 1223.376 
    ## ... trying feature 52 0XX1 with BIC 1218.51 
    ## ... trying feature 53 1XX1 with BIC 1209.727 
    ## ... trying feature 54 XXX1 with BIC 1195.583 
    ## ... trying feature 55 000X with BIC 1226.048 
    ## ... trying feature 56 100X with BIC 1223.776 
    ## ... trying feature 57 X00X with BIC 1233.389 
    ## ... trying feature 58 010X with BIC 1177.473 
    ## ... trying feature 59 110X with BIC 1233.119 
    ## ... trying feature 60 X10X with BIC 1220.949 
    ## ... trying feature 61 0X0X with BIC 1229.328 
    ## ... trying feature 62 1X0X with BIC 1228.744 
    ## ... trying feature 63 XX0X with BIC 1224.387 
    ## ... trying feature 64 001X with BIC 1169.337 
    ## ... trying feature 65 101X with BIC 1233.564 
    ## ... trying feature 66 X01X with BIC 1203.384 
    ## ... trying feature 67 011X with BIC 1158.786 
    ## ... trying feature 68 111X with BIC 1227.724 
    ## ... trying feature 69 X11X with BIC 1225.815 
    ## ... trying feature 70 0X1X with BIC 1229.328 
    ## ... trying feature 71 1X1X with BIC 1228.744 
    ## ... trying feature 72 XX1X with BIC 1224.387 
    ## ... trying feature 73 00XX with BIC 1080.813 
    ## ... trying feature 74 10XX with BIC 1226.632 
    ## ... trying feature 75 X0XX with BIC 1207.956 
    ## ... trying feature 76 01XX with BIC 1080.813 
    ## ... trying feature 77 11XX with BIC 1226.632 
    ## ... trying feature 78 X1XX with BIC 1207.956 
    ## ... trying feature 80 1XXX with BIC 1225.758 
    ## ... Using feature 73 00XX 
    ## Adding Feature Number 3 
    ## ... trying feature 1 0000 with BIC 1072.974 
    ## ... trying feature 2 1000 with BIC 1079.377 
    ## ... trying feature 3 X000 with BIC 1064.412 
    ## ... trying feature 4 0100 with BIC 1088.286 
    ## ... trying feature 5 1100 with BIC 1088.372 
    ## ... trying feature 6 X100 with BIC 1088.279 
    ## ... trying feature 7 0X00 with BIC 1072.664 
    ## ... trying feature 8 1X00 with BIC 1080.8 
    ## ... trying feature 9 XX00 with BIC 1066.991 
    ## ... trying feature 10 0010 with BIC 1087.097 
    ## ... trying feature 11 1010 with BIC 1078.648 
    ## ... trying feature 12 X010 with BIC 1078.879

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1088.272 
    ## ... trying feature 14 1110 with BIC 1084.466 
    ## ... trying feature 15 X110 with BIC 1084.225 
    ## ... trying feature 16 0X10 with BIC 1086.96 
    ## ... trying feature 17 1X10 with BIC 1075.201 
    ## ... trying feature 18 XX10 with BIC 1075.047 
    ## ... trying feature 19 00X0 with BIC 1075.11 
    ## ... trying feature 20 10X0 with BIC 1068.278 
    ## ... trying feature 21 X0X0 with BIC 1054.929

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1087.885 
    ## ... trying feature 23 11X0 with BIC 1085.154 
    ## ... trying feature 24 X1X0 with BIC 1084.792 
    ## ... trying feature 25 0XX0 with BIC 1074.611 
    ## ... trying feature 26 1XX0 with BIC 1066.131 
    ## ... trying feature 27 XXX0 with BIC 1051.75 
    ## ... trying feature 28 0001 with BIC 1088.387 
    ## ... trying feature 29 1001 with BIC 1085.717 
    ## ... trying feature 30 X001 with BIC 1086.187 
    ## ... trying feature 31 0101 with BIC 1088.472 
    ## ... trying feature 32 1101 with BIC 1087.732 
    ## ... trying feature 33 X101 with BIC 1087.632 
    ## ... trying feature 34 0X01 with BIC 1088.441 
    ## ... trying feature 35 1X01 with BIC 1088.145 
    ## ... trying feature 36 XX01 with BIC 1087.968 
    ## ... trying feature 37 0011 with BIC 1080.191 
    ## ... trying feature 38 1011 with BIC 1087.309 
    ## ... trying feature 39 X011 with BIC 1080.729 
    ## ... trying feature 40 0111 with BIC 1088.63 
    ## ... trying feature 41 1111 with BIC 1076.76 
    ## ... trying feature 42 X111 with BIC 1076.889 
    ## ... trying feature 43 0X11 with BIC 1080.271 
    ## ... trying feature 44 1X11 with BIC 1073.852 
    ## ... trying feature 45 XX11 with BIC 1066.086 
    ## ... trying feature 46 00X1 with BIC 1075.11 
    ## ... trying feature 47 10X1 with BIC 1088.529 
    ## ... trying feature 48 X0X1 with BIC 1086.302

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1087.885 
    ## ... trying feature 50 11X1 with BIC 1075.121 
    ## ... trying feature 51 X1X1 with BIC 1074.777 
    ## ... trying feature 52 0XX1 with BIC 1074.611 
    ## ... trying feature 53 1XX1 with BIC 1066.131 
    ## ... trying feature 54 XXX1 with BIC 1051.75 
    ## ... trying feature 55 000X with BIC 1083.342 
    ## ... trying feature 56 100X with BIC 1080.008 
    ## ... trying feature 57 X00X with BIC 1074.69 
    ## ... trying feature 58 010X with BIC 1088.611 
    ## ... trying feature 59 110X with BIC 1088.113 
    ## ... trying feature 60 X10X with BIC 1088.089 
    ## ... trying feature 61 0X0X with BIC 1083.528 
    ## ... trying feature 62 1X0X with BIC 1084.676 
    ## ... trying feature 63 XX0X with BIC 1079.782 
    ## ... trying feature 64 001X with BIC 1083.342 
    ## ... trying feature 65 101X with BIC 1088.602 
    ## ... trying feature 66 X01X with BIC 1086.64 
    ## ... trying feature 67 011X with BIC 1088.611 
    ## ... trying feature 68 111X with BIC 1082.188 
    ## ... trying feature 69 X11X with BIC 1082.39 
    ## ... trying feature 70 0X1X with BIC 1083.528 
    ## ... trying feature 71 1X1X with BIC 1084.676 
    ## ... trying feature 72 XX1X with BIC 1079.782 
    ## ... trying feature 74 10XX with BIC 1080.915 
    ## ... trying feature 75 X0XX with BIC 1080.915 
    ## ... trying feature 76 01XX with BIC 1080.813 
    ## ... trying feature 77 11XX with BIC 1080.915 
    ## ... trying feature 78 X1XX with BIC 1080.915 
    ## ... trying feature 80 1XXX with BIC 1080.813 
    ## ... Using feature 27 XXX0 
    ## Adding Feature Number 4 
    ## ... trying feature 1 0000 with BIC 1056.37 
    ## ... trying feature 2 1000 with BIC 1058.901 
    ## ... trying feature 3 X000 with BIC 1055.847 
    ## ... trying feature 4 0100 with BIC 1059.466 
    ## ... trying feature 5 1100 with BIC 1057.555 
    ## ... trying feature 6 X100 with BIC 1057.686 
    ## ... trying feature 7 0X00 with BIC 1056.283 
    ## ... trying feature 8 1X00 with BIC 1059.504 
    ## ... trying feature 9 XX00 with BIC 1058.604 
    ## ... trying feature 10 0010 with BIC 1056.991 
    ## ... trying feature 11 1010 with BIC 1059.336 
    ## ... trying feature 12 X010 with BIC 1058.822

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1059.461 
    ## ... trying feature 14 1110 with BIC 1059.504 
    ## ... trying feature 15 X110 with BIC 1059.521 
    ## ... trying feature 16 0X10 with BIC 1057.101 
    ## ... trying feature 17 1X10 with BIC 1059.524 
    ## ... trying feature 18 XX10 with BIC 1058.604 
    ## ... trying feature 19 00X0 with BIC 1059.574 
    ## ... trying feature 20 10X0 with BIC 1058.397 
    ## ... trying feature 21 X0X0 with BIC 1058.219

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1059.35 
    ## ... trying feature 23 11X0 with BIC 1058.086 
    ## ... trying feature 24 X1X0 with BIC 1058.219 
    ## ... trying feature 25 0XX0 with BIC 1059.574 
    ## ... trying feature 26 1XX0 with BIC 1059.574 
    ## ... trying feature 28 0001 with BIC 1057.19 
    ## ... trying feature 29 1001 with BIC 1051.401 
    ## ... trying feature 30 X001 with BIC 1049.568 
    ## ... trying feature 31 0101 with BIC 1059.501 
    ## ... trying feature 32 1101 with BIC 1059.455 
    ## ... trying feature 33 X101 with BIC 1059.428 
    ## ... trying feature 34 0X01 with BIC 1057.343 
    ## ... trying feature 35 1X01 with BIC 1054.963 
    ## ... trying feature 36 XX01 with BIC 1052.729 
    ## ... trying feature 37 0011 with BIC 1057.269 
    ## ... trying feature 38 1011 with BIC 1059.572 
    ## ... trying feature 39 X011 with BIC 1058.398 
    ## ... trying feature 40 0111 with BIC 1059.561 
    ## ... trying feature 41 1111 with BIC 1053.427 
    ## ... trying feature 42 X111 with BIC 1053.62 
    ## ... trying feature 43 0X11 with BIC 1057.354 
    ## ... trying feature 44 1X11 with BIC 1055.098 
    ## ... trying feature 45 XX11 with BIC 1052.729 
    ## ... trying feature 46 00X1 with BIC 1059.574 
    ## ... trying feature 47 10X1 with BIC 1053.966 
    ## ... trying feature 48 X0X1 with BIC 1053.76

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1059.35 
    ## ... trying feature 50 11X1 with BIC 1053.849 
    ## ... trying feature 51 X1X1 with BIC 1053.76 
    ## ... trying feature 52 0XX1 with BIC 1059.574 
    ## ... trying feature 53 1XX1 with BIC 1059.574 
    ## ... trying feature 54 XXX1 with BIC 1051.75 
    ## ... trying feature 55 000X with BIC 1055.113 
    ## ... trying feature 56 100X with BIC 1050.814 
    ## ... trying feature 57 X00X with BIC 1046.423 
    ## ... trying feature 58 010X with BIC 1059.537 
    ## ... trying feature 59 110X with BIC 1058.927 
    ## ... trying feature 60 X10X with BIC 1058.893 
    ## ... trying feature 61 0X0X with BIC 1055.299 
    ## ... trying feature 62 1X0X with BIC 1055.773 
    ## ... trying feature 63 XX0X with BIC 1051.652 
    ## ... trying feature 64 001X with BIC 1055.113 
    ## ... trying feature 65 101X with BIC 1059.557 
    ## ... trying feature 66 X01X with BIC 1057.84 
    ## ... trying feature 67 011X with BIC 1059.537 
    ## ... trying feature 68 111X with BIC 1053.592 
    ## ... trying feature 69 X11X with BIC 1053.82 
    ## ... trying feature 70 0X1X with BIC 1055.299 
    ## ... trying feature 71 1X1X with BIC 1055.773 
    ## ... trying feature 72 XX1X with BIC 1051.652 
    ## ... trying feature 74 10XX with BIC 1052.124 
    ## ... trying feature 75 X0XX with BIC 1052.124 
    ## ... trying feature 76 01XX with BIC 1051.75 
    ## ... trying feature 77 11XX with BIC 1052.124 
    ## ... trying feature 78 X1XX with BIC 1052.124 
    ## ... trying feature 80 1XXX with BIC 1051.75 
    ## ... Using feature 57 X00X 
    ## Adding Feature Number 5 
    ## ... trying feature 1 0000 with BIC 1052.7 
    ## ... trying feature 2 1000 with BIC 1054.224 
    ## ... trying feature 3 X000 with BIC 1053.681 
    ## ... trying feature 4 0100 with BIC 1054.134 
    ## ... trying feature 5 1100 with BIC 1053.101 
    ## ... trying feature 6 X100 with BIC 1053.197 
    ## ... trying feature 7 0X00 with BIC 1052.629 
    ## ... trying feature 8 1X00 with BIC 1053.49 
    ## ... trying feature 9 XX00 with BIC 1054.246 
    ## ... trying feature 10 0010 with BIC 1053.048 
    ## ... trying feature 11 1010 with BIC 1053.514 
    ## ... trying feature 12 X010 with BIC 1054.216

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1054.141 
    ## ... trying feature 14 1110 with BIC 1054.22 
    ## ... trying feature 15 X110 with BIC 1054.21 
    ## ... trying feature 16 0X10 with BIC 1053.112 
    ## ... trying feature 17 1X10 with BIC 1053.546 
    ## ... trying feature 18 XX10 with BIC 1054.246 
    ## ... trying feature 19 00X0 with BIC 1054.238 
    ## ... trying feature 20 10X0 with BIC 1053.858 
    ## ... trying feature 21 X0X0 with BIC 1053.908

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1054.025 
    ## ... trying feature 23 11X0 with BIC 1053.843 
    ## ... trying feature 24 X1X0 with BIC 1053.908 
    ## ... trying feature 25 0XX0 with BIC 1054.245 
    ## ... trying feature 26 1XX0 with BIC 1054.245 
    ## ... trying feature 28 0001 with BIC 1053.061 
    ## ... trying feature 29 1001 with BIC 1053.798 
    ## ... trying feature 30 X001 with BIC 1053.681 
    ## ... trying feature 31 0101 with BIC 1054.165 
    ## ... trying feature 32 1101 with BIC 1054.211 
    ## ... trying feature 33 X101 with BIC 1054.227 
    ## ... trying feature 34 0X01 with BIC 1052.983 
    ## ... trying feature 35 1X01 with BIC 1053.841 
    ## ... trying feature 36 XX01 with BIC 1054.201 
    ## ... trying feature 37 0011 with BIC 1053.005 
    ## ... trying feature 38 1011 with BIC 1053.253 
    ## ... trying feature 39 X011 with BIC 1051.369 
    ## ... trying feature 40 0111 with BIC 1054.23 
    ## ... trying feature 41 1111 with BIC 1050.892 
    ## ... trying feature 42 X111 with BIC 1051.025 
    ## ... trying feature 43 0X11 with BIC 1052.988 
    ## ... trying feature 44 1X11 with BIC 1053.827 
    ## ... trying feature 45 XX11 with BIC 1054.201 
    ## ... trying feature 46 00X1 with BIC 1054.238 
    ## ... trying feature 47 10X1 with BIC 1052.27 
    ## ... trying feature 48 X0X1 with BIC 1052.114

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1054.025 
    ## ... trying feature 50 11X1 with BIC 1052.171 
    ## ... trying feature 51 X1X1 with BIC 1052.114 
    ## ... trying feature 52 0XX1 with BIC 1054.245 
    ## ... trying feature 53 1XX1 with BIC 1054.245 
    ## ... trying feature 54 XXX1 with BIC 1046.423 
    ## ... trying feature 55 000X with BIC 1053.904 
    ## ... trying feature 56 100X with BIC 1053.904 
    ## ... trying feature 58 010X with BIC 1054.204 
    ## ... trying feature 59 110X with BIC 1054.215 
    ## ... trying feature 60 X10X with BIC 1054.204 
    ## ... trying feature 61 0X0X with BIC 1053.87 
    ## ... trying feature 62 1X0X with BIC 1054.183 
    ## ... trying feature 63 XX0X with BIC 1054.204 
    ## ... trying feature 64 001X with BIC 1053.904 
    ## ... trying feature 65 101X with BIC 1052.606 
    ## ... trying feature 66 X01X with BIC 1051.561 
    ## ... trying feature 67 011X with BIC 1054.204 
    ## ... trying feature 68 111X with BIC 1051.381 
    ## ... trying feature 69 X11X with BIC 1051.527 
    ## ... trying feature 70 0X1X with BIC 1053.87 
    ## ... trying feature 71 1X1X with BIC 1054.183 
    ## ... trying feature 72 XX1X with BIC 1054.204 
    ## ... trying feature 74 10XX with BIC 1051.561 
    ## ... trying feature 75 X0XX with BIC 1051.561 
    ## ... trying feature 76 01XX with BIC 1046.423 
    ## ... trying feature 77 11XX with BIC 1051.561 
    ## ... trying feature 78 X1XX with BIC 1051.561 
    ## ... trying feature 80 1XXX with BIC 1046.423 
    ## ... Using feature 54 XXX1 
    ## Adding Feature Number 6 
    ## ... trying feature 1 0000 with BIC 1052.7 
    ## ... trying feature 2 1000 with BIC 1054.224 
    ## ... trying feature 3 X000 with BIC 1053.681 
    ## ... trying feature 4 0100 with BIC 1054.134 
    ## ... trying feature 5 1100 with BIC 1053.101 
    ## ... trying feature 6 X100 with BIC 1053.197 
    ## ... trying feature 7 0X00 with BIC 1052.629 
    ## ... trying feature 8 1X00 with BIC 1053.49 
    ## ... trying feature 9 XX00 with BIC 1054.246 
    ## ... trying feature 10 0010 with BIC 1053.048 
    ## ... trying feature 11 1010 with BIC 1053.514 
    ## ... trying feature 12 X010 with BIC 1054.216

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1054.141 
    ## ... trying feature 14 1110 with BIC 1054.22 
    ## ... trying feature 15 X110 with BIC 1054.21 
    ## ... trying feature 16 0X10 with BIC 1053.112 
    ## ... trying feature 17 1X10 with BIC 1053.546 
    ## ... trying feature 18 XX10 with BIC 1054.246 
    ## ... trying feature 19 00X0 with BIC 1054.238 
    ## ... trying feature 20 10X0 with BIC 1053.858 
    ## ... trying feature 21 X0X0 with BIC 1053.908

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1054.025 
    ## ... trying feature 23 11X0 with BIC 1053.843 
    ## ... trying feature 24 X1X0 with BIC 1053.908 
    ## ... trying feature 25 0XX0 with BIC 1054.245 
    ## ... trying feature 26 1XX0 with BIC 1054.245 
    ## ... trying feature 28 0001 with BIC 1053.061 
    ## ... trying feature 29 1001 with BIC 1053.798 
    ## ... trying feature 30 X001 with BIC 1053.681 
    ## ... trying feature 31 0101 with BIC 1054.165 
    ## ... trying feature 32 1101 with BIC 1054.211 
    ## ... trying feature 33 X101 with BIC 1054.227 
    ## ... trying feature 34 0X01 with BIC 1052.983 
    ## ... trying feature 35 1X01 with BIC 1053.841 
    ## ... trying feature 36 XX01 with BIC 1054.201 
    ## ... trying feature 37 0011 with BIC 1053.005 
    ## ... trying feature 38 1011 with BIC 1053.253 
    ## ... trying feature 39 X011 with BIC 1051.369 
    ## ... trying feature 40 0111 with BIC 1054.23 
    ## ... trying feature 41 1111 with BIC 1050.892 
    ## ... trying feature 42 X111 with BIC 1051.025 
    ## ... trying feature 43 0X11 with BIC 1052.988 
    ## ... trying feature 44 1X11 with BIC 1053.827 
    ## ... trying feature 45 XX11 with BIC 1054.201 
    ## ... trying feature 46 00X1 with BIC 1054.238 
    ## ... trying feature 47 10X1 with BIC 1052.27 
    ## ... trying feature 48 X0X1 with BIC 1052.114

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1054.025 
    ## ... trying feature 50 11X1 with BIC 1052.171 
    ## ... trying feature 51 X1X1 with BIC 1052.114 
    ## ... trying feature 52 0XX1 with BIC 1054.245 
    ## ... trying feature 53 1XX1 with BIC 1054.245 
    ## ... trying feature 55 000X with BIC 1053.904 
    ## ... trying feature 56 100X with BIC 1053.904 
    ## ... trying feature 58 010X with BIC 1054.204 
    ## ... trying feature 59 110X with BIC 1054.215 
    ## ... trying feature 60 X10X with BIC 1054.204 
    ## ... trying feature 61 0X0X with BIC 1053.87 
    ## ... trying feature 62 1X0X with BIC 1054.183 
    ## ... trying feature 63 XX0X with BIC 1054.204 
    ## ... trying feature 64 001X with BIC 1053.904 
    ## ... trying feature 65 101X with BIC 1052.606 
    ## ... trying feature 66 X01X with BIC 1051.561 
    ## ... trying feature 67 011X with BIC 1054.204 
    ## ... trying feature 68 111X with BIC 1051.381 
    ## ... trying feature 69 X11X with BIC 1051.527 
    ## ... trying feature 70 0X1X with BIC 1053.87 
    ## ... trying feature 71 1X1X with BIC 1054.183 
    ## ... trying feature 72 XX1X with BIC 1054.204 
    ## ... trying feature 74 10XX with BIC 1051.561 
    ## ... trying feature 75 X0XX with BIC 1051.561 
    ## ... trying feature 76 01XX with BIC 1046.423 
    ## ... trying feature 77 11XX with BIC 1051.561 
    ## ... trying feature 78 X1XX with BIC 1051.561 
    ## ... trying feature 80 1XXX with BIC 1046.423 
    ## ... Using feature 76 01XX 
    ## Adding Feature Number 7 
    ## ... trying feature 1 0000 with BIC 1052.7 
    ## ... trying feature 2 1000 with BIC 1054.224 
    ## ... trying feature 3 X000 with BIC 1053.681 
    ## ... trying feature 4 0100 with BIC 1054.134 
    ## ... trying feature 5 1100 with BIC 1053.101 
    ## ... trying feature 6 X100 with BIC 1053.197 
    ## ... trying feature 7 0X00 with BIC 1052.629 
    ## ... trying feature 8 1X00 with BIC 1053.49 
    ## ... trying feature 9 XX00 with BIC 1054.246 
    ## ... trying feature 10 0010 with BIC 1053.048 
    ## ... trying feature 11 1010 with BIC 1053.514 
    ## ... trying feature 12 X010 with BIC 1054.216

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1054.141 
    ## ... trying feature 14 1110 with BIC 1054.22 
    ## ... trying feature 15 X110 with BIC 1054.21 
    ## ... trying feature 16 0X10 with BIC 1053.112 
    ## ... trying feature 17 1X10 with BIC 1053.546 
    ## ... trying feature 18 XX10 with BIC 1054.246 
    ## ... trying feature 19 00X0 with BIC 1054.238 
    ## ... trying feature 20 10X0 with BIC 1053.858 
    ## ... trying feature 21 X0X0 with BIC 1053.908

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1054.025 
    ## ... trying feature 23 11X0 with BIC 1053.843 
    ## ... trying feature 24 X1X0 with BIC 1053.908 
    ## ... trying feature 25 0XX0 with BIC 1054.245 
    ## ... trying feature 26 1XX0 with BIC 1054.245 
    ## ... trying feature 28 0001 with BIC 1053.061 
    ## ... trying feature 29 1001 with BIC 1053.798 
    ## ... trying feature 30 X001 with BIC 1053.681 
    ## ... trying feature 31 0101 with BIC 1054.165 
    ## ... trying feature 32 1101 with BIC 1054.211 
    ## ... trying feature 33 X101 with BIC 1054.227 
    ## ... trying feature 34 0X01 with BIC 1052.983 
    ## ... trying feature 35 1X01 with BIC 1053.841 
    ## ... trying feature 36 XX01 with BIC 1054.201 
    ## ... trying feature 37 0011 with BIC 1053.005 
    ## ... trying feature 38 1011 with BIC 1053.253 
    ## ... trying feature 39 X011 with BIC 1051.369 
    ## ... trying feature 40 0111 with BIC 1054.23 
    ## ... trying feature 41 1111 with BIC 1050.892 
    ## ... trying feature 42 X111 with BIC 1051.025 
    ## ... trying feature 43 0X11 with BIC 1052.988 
    ## ... trying feature 44 1X11 with BIC 1053.827 
    ## ... trying feature 45 XX11 with BIC 1054.201 
    ## ... trying feature 46 00X1 with BIC 1054.238 
    ## ... trying feature 47 10X1 with BIC 1052.27 
    ## ... trying feature 48 X0X1 with BIC 1052.114

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1054.025 
    ## ... trying feature 50 11X1 with BIC 1052.171 
    ## ... trying feature 51 X1X1 with BIC 1052.114 
    ## ... trying feature 52 0XX1 with BIC 1054.245 
    ## ... trying feature 53 1XX1 with BIC 1054.245 
    ## ... trying feature 55 000X with BIC 1053.904 
    ## ... trying feature 56 100X with BIC 1053.904 
    ## ... trying feature 58 010X with BIC 1054.204 
    ## ... trying feature 59 110X with BIC 1054.215 
    ## ... trying feature 60 X10X with BIC 1054.204 
    ## ... trying feature 61 0X0X with BIC 1053.87 
    ## ... trying feature 62 1X0X with BIC 1054.183 
    ## ... trying feature 63 XX0X with BIC 1054.204 
    ## ... trying feature 64 001X with BIC 1053.904 
    ## ... trying feature 65 101X with BIC 1052.606 
    ## ... trying feature 66 X01X with BIC 1051.561 
    ## ... trying feature 67 011X with BIC 1054.204 
    ## ... trying feature 68 111X with BIC 1051.381 
    ## ... trying feature 69 X11X with BIC 1051.527 
    ## ... trying feature 70 0X1X with BIC 1053.87 
    ## ... trying feature 71 1X1X with BIC 1054.183 
    ## ... trying feature 72 XX1X with BIC 1054.204 
    ## ... trying feature 74 10XX with BIC 1051.561 
    ## ... trying feature 75 X0XX with BIC 1051.561 
    ## ... trying feature 77 11XX with BIC 1051.561 
    ## ... trying feature 78 X1XX with BIC 1051.561 
    ## ... trying feature 80 1XXX with BIC 1046.423 
    ## ... Using feature 80 1XXX 
    ## Adding Feature Number 8 
    ## ... trying feature 1 0000 with BIC 1052.7 
    ## ... trying feature 2 1000 with BIC 1054.224 
    ## ... trying feature 3 X000 with BIC 1053.681 
    ## ... trying feature 4 0100 with BIC 1054.134 
    ## ... trying feature 5 1100 with BIC 1053.101 
    ## ... trying feature 6 X100 with BIC 1053.197 
    ## ... trying feature 7 0X00 with BIC 1052.629 
    ## ... trying feature 8 1X00 with BIC 1053.49 
    ## ... trying feature 9 XX00 with BIC 1054.246 
    ## ... trying feature 10 0010 with BIC 1053.048 
    ## ... trying feature 11 1010 with BIC 1053.514 
    ## ... trying feature 12 X010 with BIC 1054.216

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1054.141 
    ## ... trying feature 14 1110 with BIC 1054.22 
    ## ... trying feature 15 X110 with BIC 1054.21 
    ## ... trying feature 16 0X10 with BIC 1053.112 
    ## ... trying feature 17 1X10 with BIC 1053.546 
    ## ... trying feature 18 XX10 with BIC 1054.246 
    ## ... trying feature 19 00X0 with BIC 1054.238 
    ## ... trying feature 20 10X0 with BIC 1053.858 
    ## ... trying feature 21 X0X0 with BIC 1053.908

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1054.025 
    ## ... trying feature 23 11X0 with BIC 1053.843 
    ## ... trying feature 24 X1X0 with BIC 1053.908 
    ## ... trying feature 25 0XX0 with BIC 1054.245 
    ## ... trying feature 26 1XX0 with BIC 1054.245 
    ## ... trying feature 28 0001 with BIC 1053.061 
    ## ... trying feature 29 1001 with BIC 1053.798 
    ## ... trying feature 30 X001 with BIC 1053.681 
    ## ... trying feature 31 0101 with BIC 1054.165 
    ## ... trying feature 32 1101 with BIC 1054.211 
    ## ... trying feature 33 X101 with BIC 1054.227 
    ## ... trying feature 34 0X01 with BIC 1052.983 
    ## ... trying feature 35 1X01 with BIC 1053.841 
    ## ... trying feature 36 XX01 with BIC 1054.201 
    ## ... trying feature 37 0011 with BIC 1053.005 
    ## ... trying feature 38 1011 with BIC 1053.253 
    ## ... trying feature 39 X011 with BIC 1051.369 
    ## ... trying feature 40 0111 with BIC 1054.23 
    ## ... trying feature 41 1111 with BIC 1050.892 
    ## ... trying feature 42 X111 with BIC 1051.025 
    ## ... trying feature 43 0X11 with BIC 1052.988 
    ## ... trying feature 44 1X11 with BIC 1053.827 
    ## ... trying feature 45 XX11 with BIC 1054.201 
    ## ... trying feature 46 00X1 with BIC 1054.238 
    ## ... trying feature 47 10X1 with BIC 1052.27 
    ## ... trying feature 48 X0X1 with BIC 1052.114

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1054.025 
    ## ... trying feature 50 11X1 with BIC 1052.171 
    ## ... trying feature 51 X1X1 with BIC 1052.114 
    ## ... trying feature 52 0XX1 with BIC 1054.245 
    ## ... trying feature 53 1XX1 with BIC 1054.245 
    ## ... trying feature 55 000X with BIC 1053.904 
    ## ... trying feature 56 100X with BIC 1053.904 
    ## ... trying feature 58 010X with BIC 1054.204 
    ## ... trying feature 59 110X with BIC 1054.215 
    ## ... trying feature 60 X10X with BIC 1054.204 
    ## ... trying feature 61 0X0X with BIC 1053.87 
    ## ... trying feature 62 1X0X with BIC 1054.183 
    ## ... trying feature 63 XX0X with BIC 1054.204 
    ## ... trying feature 64 001X with BIC 1053.904 
    ## ... trying feature 65 101X with BIC 1052.606 
    ## ... trying feature 66 X01X with BIC 1051.561 
    ## ... trying feature 67 011X with BIC 1054.204 
    ## ... trying feature 68 111X with BIC 1051.381 
    ## ... trying feature 69 X11X with BIC 1051.527 
    ## ... trying feature 70 0X1X with BIC 1053.87 
    ## ... trying feature 71 1X1X with BIC 1054.183 
    ## ... trying feature 72 XX1X with BIC 1054.204 
    ## ... trying feature 74 10XX with BIC 1051.561 
    ## ... trying feature 75 X0XX with BIC 1051.561 
    ## ... trying feature 77 11XX with BIC 1051.561 
    ## ... trying feature 78 X1XX with BIC 1051.561 
    ## ... Using feature 41 1111 
    ## Adding Feature Number 9 
    ## ... trying feature 1 0000 with BIC 1056.812 
    ## ... trying feature 2 1000 with BIC 1058.701 
    ## ... trying feature 3 X000 with BIC 1057.94 
    ## ... trying feature 4 0100 with BIC 1058.589 
    ## ... trying feature 5 1100 with BIC 1057.428 
    ## ... trying feature 6 X100 with BIC 1057.545 
    ## ... trying feature 7 0X00 with BIC 1056.725 
    ## ... trying feature 8 1X00 with BIC 1057.926 
    ## ... trying feature 9 XX00 with BIC 1058.702 
    ## ... trying feature 10 0010 with BIC 1057.776 
    ## ... trying feature 11 1010 with BIC 1058.194 
    ## ... trying feature 12 X010 with BIC 1058.681

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1058.601 
    ## ... trying feature 14 1110 with BIC 1058.713 
    ## ... trying feature 15 X110 with BIC 1058.708 
    ## ... trying feature 16 0X10 with BIC 1057.836 
    ## ... trying feature 17 1X10 with BIC 1058.292 
    ## ... trying feature 18 XX10 with BIC 1058.702 
    ## ... trying feature 19 00X0 with BIC 1058.702 
    ## ... trying feature 20 10X0 with BIC 1058.439 
    ## ... trying feature 21 X0X0 with BIC 1058.218

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1058.47 
    ## ... trying feature 23 11X0 with BIC 1058.129 
    ## ... trying feature 24 X1X0 with BIC 1058.218 
    ## ... trying feature 25 0XX0 with BIC 1058.686 
    ## ... trying feature 26 1XX0 with BIC 1058.686 
    ## ... trying feature 28 0001 with BIC 1057.987 
    ## ... trying feature 29 1001 with BIC 1058.6 
    ## ... trying feature 30 X001 with BIC 1057.94 
    ## ... trying feature 31 0101 with BIC 1058.637 
    ## ... trying feature 32 1101 with BIC 1058.565 
    ## ... trying feature 33 X101 with BIC 1058.53 
    ## ... trying feature 34 0X01 with BIC 1057.92 
    ## ... trying feature 35 1X01 with BIC 1058.708 
    ## ... trying feature 36 XX01 with BIC 1058.051 
    ## ... trying feature 37 0011 with BIC 1058.125 
    ## ... trying feature 38 1011 with BIC 1058.685 
    ## ... trying feature 39 X011 with BIC 1058.066 
    ## ... trying feature 40 0111 with BIC 1058.704 
    ## ... trying feature 42 X111 with BIC 1058.704 
    ## ... trying feature 43 0X11 with BIC 1058.111 
    ## ... trying feature 44 1X11 with BIC 1058.685 
    ## ... trying feature 45 XX11 with BIC 1058.051 
    ## ... trying feature 46 00X1 with BIC 1058.702 
    ## ... trying feature 47 10X1 with BIC 1058.51 
    ## ... trying feature 48 X0X1 with BIC 1058.542

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1058.47 
    ## ... trying feature 50 11X1 with BIC 1058.565 
    ## ... trying feature 51 X1X1 with BIC 1058.542 
    ## ... trying feature 52 0XX1 with BIC 1058.686 
    ## ... trying feature 53 1XX1 with BIC 1058.686 
    ## ... trying feature 55 000X with BIC 1058.642 
    ## ... trying feature 56 100X with BIC 1058.642 
    ## ... trying feature 58 010X with BIC 1058.68 
    ## ... trying feature 59 110X with BIC 1058.119 
    ## ... trying feature 60 X10X with BIC 1058.086 
    ## ... trying feature 61 0X0X with BIC 1058.624 
    ## ... trying feature 62 1X0X with BIC 1058.463 
    ## ... trying feature 63 XX0X with BIC 1058.086 
    ## ... trying feature 64 001X with BIC 1058.642 
    ## ... trying feature 65 101X with BIC 1058.485 
    ## ... trying feature 66 X01X with BIC 1058.194 
    ## ... trying feature 67 011X with BIC 1058.68 
    ## ... trying feature 68 111X with BIC 1058.713 
    ## ... trying feature 69 X11X with BIC 1058.701 
    ## ... trying feature 70 0X1X with BIC 1058.624 
    ## ... trying feature 71 1X1X with BIC 1058.463 
    ## ... trying feature 72 XX1X with BIC 1058.086 
    ## ... trying feature 74 10XX with BIC 1058.194 
    ## ... trying feature 75 X0XX with BIC 1058.194 
    ## ... trying feature 77 11XX with BIC 1058.194 
    ## ... trying feature 78 X1XX with BIC 1058.194 
    ## ... Using feature 7 0X00 
    ## BIC selects 4 features but we also keep models with 5 and 6 features 
    ## [1] "Training..."
    ## Adding Feature Number 1 
    ## ... trying feature 1 0000 with BIC 2195.828 
    ## ... trying feature 2 1000 with BIC 2220.582 
    ## ... trying feature 3 X000 with BIC 2210.873

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 2192.847 
    ## ... trying feature 5 1100 with BIC 2220.716 
    ## ... trying feature 6 X100 with BIC 2209.708 
    ## ... trying feature 7 0X00 with BIC 2168.065 
    ## ... trying feature 8 1X00 with BIC 2220.003 
    ## ... trying feature 9 XX00 with BIC 2199.292 
    ## ... trying feature 10 0010 with BIC 2207.207 
    ## ... trying feature 11 1010 with BIC 2207.705 
    ## ... trying feature 12 X010 with BIC 2220.705

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 2185.575 
    ## ... trying feature 14 1110 with BIC 2204.496 
    ## ... trying feature 15 X110 with BIC 2219.548 
    ## ... trying feature 16 0X10 with BIC 2178.975 
    ## ... trying feature 17 1X10 with BIC 2191.747 
    ## ... trying feature 18 XX10 with BIC 2219.084 
    ## ... trying feature 19 00X0 with BIC 2183.385 
    ## ... trying feature 20 10X0 with BIC 2210.477 
    ## ... trying feature 21 X0X0 with BIC 2213.592

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 2156.525 
    ## ... trying feature 23 11X0 with BIC 2207.317 
    ## ... trying feature 24 X1X0 with BIC 2211.313 
    ## ... trying feature 25 0XX0 with BIC 2125.559 
    ## ... trying feature 26 1XX0 with BIC 2196.993 
    ## ... trying feature 27 XXX0 with BIC 2202.956 
    ## ... trying feature 28 0001 with BIC 2175.938 
    ## ... trying feature 29 1001 with BIC 2151.183 
    ## ... trying feature 30 X001 with BIC 2221.266

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 0101 with BIC 2059.691 
    ## ... trying feature 32 1101 with BIC 2100.335 
    ## ... trying feature 33 X101 with BIC 2220.945 
    ## ... trying feature 34 0X01 with BIC 2053.532 
    ## ... trying feature 35 1X01 with BIC 2020.923 
    ## ... trying feature 36 XX01 with BIC 2220.953 
    ## ... trying feature 37 0011 with BIC 2198.497 
    ## ... trying feature 38 1011 with BIC 2057.673 
    ## ... trying feature 39 X011 with BIC 2200.794 
    ## ... trying feature 40 0111 with BIC 2005.773 
    ## ... trying feature 41 1111 with BIC 2061.269 
    ## ... trying feature 42 X111 with BIC 2219.61 
    ## ... trying feature 43 0X11 with BIC 2052.692 
    ## ... trying feature 44 1X11 with BIC 1838.042 
    ## ... trying feature 45 XX11 with BIC 2210.477 
    ## ... trying feature 46 00X1 with BIC 2137.884 
    ## ... trying feature 47 10X1 with BIC 1950.328 
    ## ... trying feature 48 X0X1 with BIC 2203.651 
    ## ... trying feature 49 01X1 with BIC 1816.032 
    ## ... trying feature 50 11X1 with BIC 1910.351 
    ## ... trying feature 51 X1X1 with BIC 2219.01 
    ## ... trying feature 52 0XX1 with BIC 1680.533 
    ## ... trying feature 53 1XX1 with BIC 1387.939 
    ## ... trying feature 54 XXX1 with BIC 2202.956 
    ## ... trying feature 55 000X with BIC 2154.505 
    ## ... trying feature 56 100X with BIC 2154.592 
    ## ... trying feature 57 X00X with BIC 2219.272

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 58 010X with BIC 2026.416 
    ## ... trying feature 59 110X with BIC 2108.239 
    ## ... trying feature 60 X10X with BIC 2217.952 
    ## ... trying feature 61 0X0X with BIC 1991.206 
    ## ... trying feature 62 1X0X with BIC 2029.398 
    ## ... trying feature 63 XX0X with BIC 2214.643 
    ## ... trying feature 64 001X with BIC 2186.168 
    ## ... trying feature 65 101X with BIC 2043.169 
    ## ... trying feature 66 X01X with BIC 2204.665 
    ## ... trying feature 67 011X with BIC 1964.824 
    ## ... trying feature 68 111X with BIC 2039.372 
    ## ... trying feature 69 X11X with BIC 2218.174 
    ## ... trying feature 70 0X1X with BIC 1988.697 
    ## ... trying feature 71 1X1X with BIC 1790.455 
    ## ... trying feature 72 XX1X with BIC 2214.643 
    ## ... trying feature 73 00XX with BIC 2091.184 
    ## ... trying feature 74 10XX with BIC 1933.289 
    ## ... trying feature 75 X0XX with BIC 2213.135 
    ## ... trying feature 76 01XX with BIC 1728.882 
    ## ... trying feature 77 11XX with BIC 1890.073 
    ## ... trying feature 78 X1XX with BIC 2213.135 
    ## ... trying feature 79 0XXX with BIC 1286.876 
    ## ... trying feature 80 1XXX with BIC 1286.876 
    ## ... Using feature 79 0XXX 
    ## Adding Feature Number 2 
    ## ... trying feature 1 0000 with BIC 1288.681 
    ## ... trying feature 2 1000 with BIC 1276.309 
    ## ... trying feature 3 X000 with BIC 1270.425

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1285.337 
    ## ... trying feature 5 1100 with BIC 1289.784 
    ## ... trying feature 6 X100 with BIC 1282.524 
    ## ... trying feature 7 0X00 with BIC 1280.877 
    ## ... trying feature 8 1X00 with BIC 1272.209 
    ## ... trying feature 9 XX00 with BIC 1258.818 
    ## ... trying feature 10 0010 with BIC 1294.6 
    ## ... trying feature 11 1010 with BIC 1289.053 
    ## ... trying feature 12 X010 with BIC 1292.448

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1281.454 
    ## ... trying feature 14 1110 with BIC 1294.639 
    ## ... trying feature 15 X110 with BIC 1289.889 
    ## ... trying feature 16 0X10 with BIC 1291.682 
    ## ... trying feature 17 1X10 with BIC 1291.065 
    ## ... trying feature 18 XX10 with BIC 1287.758 
    ## ... trying feature 19 00X0 with BIC 1292.839 
    ## ... trying feature 20 10X0 with BIC 1270.793 
    ## ... trying feature 21 X0X0 with BIC 1273.509

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1271.724 
    ## ... trying feature 23 11X0 with BIC 1292.199 
    ## ... trying feature 24 X1X0 with BIC 1279.944 
    ## ... trying feature 25 0XX0 with BIC 1280.238 
    ## ... trying feature 26 1XX0 with BIC 1271.674 
    ## ... trying feature 27 XXX0 with BIC 1257.198 
    ## ... trying feature 28 0001 with BIC 1283.622 
    ## ... trying feature 29 1001 with BIC 1288.392 
    ## ... trying feature 30 X001 with BIC 1294.445

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 0101 with BIC 1240.788 
    ## ... trying feature 32 1101 with BIC 1291.239 
    ## ... trying feature 33 X101 with BIC 1289.566 
    ## ... trying feature 34 0X01 with BIC 1293.949 
    ## ... trying feature 35 1X01 with BIC 1294.138 
    ## ... trying feature 36 XX01 with BIC 1293.444 
    ## ... trying feature 37 0011 with BIC 1210.583 
    ## ... trying feature 38 1011 with BIC 1293.757 
    ## ... trying feature 39 X011 with BIC 1247.903 
    ## ... trying feature 40 0111 with BIC 1224.185 
    ## ... trying feature 41 1111 with BIC 1282.134 
    ## ... trying feature 42 X111 with BIC 1290.615 
    ## ... trying feature 43 0X11 with BIC 1284.223 
    ## ... trying feature 44 1X11 with BIC 1280.195 
    ## ... trying feature 45 XX11 with BIC 1270.286 
    ## ... trying feature 46 00X1 with BIC 1133.257 
    ## ... trying feature 47 10X1 with BIC 1293.346 
    ## ... trying feature 48 X0X1 with BIC 1244.657 
    ## ... trying feature 49 01X1 with BIC 1157.09 
    ## ... trying feature 50 11X1 with BIC 1275.402 
    ## ... trying feature 51 X1X1 with BIC 1283.751 
    ## ... trying feature 52 0XX1 with BIC 1280.238 
    ## ... trying feature 53 1XX1 with BIC 1271.674 
    ## ... trying feature 54 XXX1 with BIC 1257.198 
    ## ... trying feature 55 000X with BIC 1289.482 
    ## ... trying feature 56 100X with BIC 1277.221 
    ## ... trying feature 57 X00X with BIC 1292.528

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 58 010X with BIC 1229.821 
    ## ... trying feature 59 110X with BIC 1293.731 
    ## ... trying feature 60 X10X with BIC 1283.069 
    ## ... trying feature 61 0X0X with BIC 1288.832 
    ## ... trying feature 62 1X0X with BIC 1286.43 
    ## ... trying feature 63 XX0X with BIC 1280.888 
    ## ... trying feature 64 001X with BIC 1211.452 
    ## ... trying feature 65 101X with BIC 1294.698 
    ## ... trying feature 66 X01X with BIC 1257.835 
    ## ... trying feature 67 011X with BIC 1207.752 
    ## ... trying feature 68 111X with BIC 1283.874 
    ## ... trying feature 69 X11X with BIC 1286.678 
    ## ... trying feature 70 0X1X with BIC 1288.832 
    ## ... trying feature 71 1X1X with BIC 1286.43 
    ## ... trying feature 72 XX1X with BIC 1280.888 
    ## ... trying feature 73 00XX with BIC 1122.138 
    ## ... trying feature 74 10XX with BIC 1281.672 
    ## ... trying feature 75 X0XX with BIC 1270.762 
    ## ... trying feature 76 01XX with BIC 1122.138 
    ## ... trying feature 77 11XX with BIC 1281.672 
    ## ... trying feature 78 X1XX with BIC 1270.762 
    ## ... trying feature 80 1XXX with BIC 1286.876 
    ## ... Using feature 73 00XX 
    ## Adding Feature Number 3 
    ## ... trying feature 1 0000 with BIC 1114.565 
    ## ... trying feature 2 1000 with BIC 1112.217 
    ## ... trying feature 3 X000 with BIC 1096.6

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1129.706 
    ## ... trying feature 5 1100 with BIC 1124.777 
    ## ... trying feature 6 X100 with BIC 1124.584 
    ## ... trying feature 7 0X00 with BIC 1114.339 
    ## ... trying feature 8 1X00 with BIC 1107.679 
    ## ... trying feature 9 XX00 with BIC 1091.894 
    ## ... trying feature 10 0010 with BIC 1127.789 
    ## ... trying feature 11 1010 with BIC 1123.708 
    ## ... trying feature 12 X010 with BIC 1121.951

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1129.613 
    ## ... trying feature 14 1110 with BIC 1129.937 
    ## ... trying feature 15 X110 with BIC 1129.956 
    ## ... trying feature 16 0X10 with BIC 1127.639 
    ## ... trying feature 17 1X10 with BIC 1126.835 
    ## ... trying feature 18 XX10 with BIC 1124.289 
    ## ... trying feature 19 00X0 with BIC 1115.577 
    ## ... trying feature 20 10X0 with BIC 1105.634 
    ## ... trying feature 21 X0X0 with BIC 1090.716

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1129.332 
    ## ... trying feature 23 11X0 with BIC 1128.147 
    ## ... trying feature 24 X1X0 with BIC 1127.905 
    ## ... trying feature 25 0XX0 with BIC 1115.145 
    ## ... trying feature 26 1XX0 with BIC 1107.881 
    ## ... trying feature 27 XXX0 with BIC 1091.14 
    ## ... trying feature 28 0001 with BIC 1128.019 
    ## ... trying feature 29 1001 with BIC 1124.472 
    ## ... trying feature 30 X001 with BIC 1123.091

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 0101 with BIC 1128.345 
    ## ... trying feature 32 1101 with BIC 1125.274 
    ## ... trying feature 33 X101 with BIC 1125.973 
    ## ... trying feature 34 0X01 with BIC 1127.693 
    ## ... trying feature 35 1X01 with BIC 1129.824 
    ## ... trying feature 36 XX01 with BIC 1128.346 
    ## ... trying feature 37 0011 with BIC 1115.89 
    ## ... trying feature 38 1011 with BIC 1129.416 
    ## ... trying feature 39 X011 with BIC 1120.447

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 40 0111 with BIC 1127.36 
    ## ... trying feature 41 1111 with BIC 1119.443 
    ## ... trying feature 42 X111 with BIC 1118.384 
    ## ... trying feature 43 0X11 with BIC 1114.811 
    ## ... trying feature 44 1X11 with BIC 1118.594 
    ## ... trying feature 45 XX11 with BIC 1103.596 
    ## ... trying feature 46 00X1 with BIC 1115.577 
    ## ... trying feature 47 10X1 with BIC 1128.503 
    ## ... trying feature 48 X0X1 with BIC 1129.318

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1129.332 
    ## ... trying feature 50 11X1 with BIC 1110.867 
    ## ... trying feature 51 X1X1 with BIC 1110.548 
    ## ... trying feature 52 0XX1 with BIC 1115.145 
    ## ... trying feature 53 1XX1 with BIC 1107.881 
    ## ... trying feature 54 XXX1 with BIC 1091.14 
    ## ... trying feature 55 000X with BIC 1120.474 
    ## ... trying feature 56 100X with BIC 1113.933 
    ## ... trying feature 57 X00X with BIC 1104.351

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 58 010X with BIC 1127.954 
    ## ... trying feature 59 110X with BIC 1128.479 
    ## ... trying feature 60 X10X with BIC 1128.878 
    ## ... trying feature 61 0X0X with BIC 1119.718 
    ## ... trying feature 62 1X0X with BIC 1123.559 
    ## ... trying feature 63 XX0X with BIC 1114.116 
    ## ... trying feature 64 001X with BIC 1120.474 
    ## ... trying feature 65 101X with BIC 1129.905 
    ## ... trying feature 66 X01X with BIC 1126.46

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 67 011X with BIC 1127.954 
    ## ... trying feature 68 111X with BIC 1119.833 
    ## ... trying feature 69 X11X with BIC 1119.003 
    ## ... trying feature 70 0X1X with BIC 1119.718 
    ## ... trying feature 71 1X1X with BIC 1123.559 
    ## ... trying feature 72 XX1X with BIC 1114.116 
    ## ... trying feature 74 10XX with BIC 1116.323 
    ## ... trying feature 75 X0XX with BIC 1116.323 
    ## ... trying feature 76 01XX with BIC 1122.138 
    ## ... trying feature 77 11XX with BIC 1116.323 
    ## ... trying feature 78 X1XX with BIC 1116.323 
    ## ... trying feature 80 1XXX with BIC 1122.138 
    ## ... Using feature 21 X0X0 
    ## Adding Feature Number 4 
    ## ... trying feature 1 0000 with BIC 1097.032 
    ## ... trying feature 2 1000 with BIC 1096.318 
    ## ... trying feature 3 X000 with BIC 1093.541

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1098.28 
    ## ... trying feature 5 1100 with BIC 1092.161 
    ## ... trying feature 6 X100 with BIC 1091.954 
    ## ... trying feature 7 0X00 with BIC 1096.881 
    ## ... trying feature 8 1X00 with BIC 1090.962 
    ## ... trying feature 9 XX00 with BIC 1087.693 
    ## ... trying feature 10 0010 with BIC 1094.4 
    ## ... trying feature 11 1010 with BIC 1098.293 
    ## ... trying feature 12 X010 with BIC 1093.541

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1098.207 
    ## ... trying feature 14 1110 with BIC 1098.537 
    ## ... trying feature 15 X110 with BIC 1098.522 
    ## ... trying feature 16 0X10 with BIC 1094.93 
    ## ... trying feature 17 1X10 with BIC 1098.456 
    ## ... trying feature 18 XX10 with BIC 1096.444 
    ## ... trying feature 19 00X0 with BIC 1097.717 
    ## ... trying feature 20 10X0 with BIC 1097.717

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1097.923 
    ## ... trying feature 23 11X0 with BIC 1095.792 
    ## ... trying feature 24 X1X0 with BIC 1095.52 
    ## ... trying feature 25 0XX0 with BIC 1097.992 
    ## ... trying feature 26 1XX0 with BIC 1095.074 
    ## ... trying feature 27 XXX0 with BIC 1095.52 
    ## ... trying feature 28 0001 with BIC 1091.315 
    ## ... trying feature 29 1001 with BIC 1088.42 
    ## ... trying feature 30 X001 with BIC 1081.003

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 0101 with BIC 1096.953 
    ## ... trying feature 32 1101 with BIC 1095.574 
    ## ... trying feature 33 X101 with BIC 1096.116 
    ## ... trying feature 34 0X01 with BIC 1090.747 
    ## ... trying feature 35 1X01 with BIC 1096.544 
    ## ... trying feature 36 XX01 with BIC 1089.999 
    ## ... trying feature 37 0011 with BIC 1093.164 
    ## ... trying feature 38 1011 with BIC 1098.536 
    ## ... trying feature 39 X011 with BIC 1095.889

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 40 0111 with BIC 1095.998 
    ## ... trying feature 41 1111 with BIC 1090.679 
    ## ... trying feature 42 X111 with BIC 1089.732 
    ## ... trying feature 43 0X11 with BIC 1092.425 
    ## ... trying feature 44 1X11 with BIC 1092.776 
    ## ... trying feature 45 XX11 with BIC 1086.348 
    ## ... trying feature 46 00X1 with BIC 1097.717 
    ## ... trying feature 47 10X1 with BIC 1092.055 
    ## ... trying feature 48 X0X1 with BIC 1090.405

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1097.923 
    ## ... trying feature 50 11X1 with BIC 1085.097 
    ## ... trying feature 51 X1X1 with BIC 1084.815 
    ## ... trying feature 52 0XX1 with BIC 1097.992 
    ## ... trying feature 53 1XX1 with BIC 1095.074 
    ## ... trying feature 54 XXX1 with BIC 1095.52 
    ## ... trying feature 55 000X with BIC 1089.582 
    ## ... trying feature 56 100X with BIC 1086.064 
    ## ... trying feature 57 X00X with BIC 1076.77

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 58 010X with BIC 1096.56 
    ## ... trying feature 59 110X with BIC 1098.059 
    ## ... trying feature 60 X10X with BIC 1098.27 
    ## ... trying feature 61 0X0X with BIC 1088.841 
    ## ... trying feature 62 1X0X with BIC 1092.208 
    ## ... trying feature 63 XX0X with BIC 1083.191 
    ## ... trying feature 64 001X with BIC 1089.582 
    ## ... trying feature 65 101X with BIC 1098.49 
    ## ... trying feature 66 X01X with BIC 1093.918

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 67 011X with BIC 1096.56 
    ## ... trying feature 68 111X with BIC 1091.448 
    ## ... trying feature 69 X11X with BIC 1090.724 
    ## ... trying feature 70 0X1X with BIC 1088.841 
    ## ... trying feature 71 1X1X with BIC 1092.208 
    ## ... trying feature 72 XX1X with BIC 1083.191 
    ## ... trying feature 74 10XX with BIC 1090.405 
    ## ... trying feature 75 X0XX with BIC 1090.405 
    ## ... trying feature 76 01XX with BIC 1090.716 
    ## ... trying feature 77 11XX with BIC 1090.405 
    ## ... trying feature 78 X1XX with BIC 1090.405 
    ## ... trying feature 80 1XXX with BIC 1090.716 
    ## ... Using feature 57 X00X 
    ## Adding Feature Number 5 
    ## ... trying feature 1 0000 with BIC 1084.025 
    ## ... trying feature 2 1000 with BIC 1084.31 
    ## ... trying feature 3 X000 with BIC 1083.535

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1084.322 
    ## ... trying feature 5 1100 with BIC 1076.445 
    ## ... trying feature 6 X100 with BIC 1076.215 
    ## ... trying feature 7 0X00 with BIC 1083.908 
    ## ... trying feature 8 1X00 with BIC 1079.417 
    ## ... trying feature 9 XX00 with BIC 1077.935 
    ## ... trying feature 10 0010 with BIC 1082.977 
    ## ... trying feature 11 1010 with BIC 1084.564 
    ## ... trying feature 12 X010 with BIC 1083.535

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1084.269 
    ## ... trying feature 14 1110 with BIC 1084.43 
    ## ... trying feature 15 X110 with BIC 1084.371 
    ## ... trying feature 16 0X10 with BIC 1083.247 
    ## ... trying feature 17 1X10 with BIC 1084.421 
    ## ... trying feature 18 XX10 with BIC 1084.473 
    ## ... trying feature 19 00X0 with BIC 1084.183 
    ## ... trying feature 20 10X0 with BIC 1084.183

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1083.974 
    ## ... trying feature 23 11X0 with BIC 1080.171 
    ## ... trying feature 24 X1X0 with BIC 1079.85 
    ## ... trying feature 25 0XX0 with BIC 1084.364 
    ## ... trying feature 26 1XX0 with BIC 1080.402 
    ## ... trying feature 27 XXX0 with BIC 1079.85 
    ## ... trying feature 28 0001 with BIC 1084.031 
    ## ... trying feature 29 1001 with BIC 1084.549 
    ## ... trying feature 30 X001 with BIC 1083.535

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 0101 with BIC 1083.09 
    ## ... trying feature 32 1101 with BIC 1083.194 
    ## ... trying feature 33 X101 with BIC 1083.541 
    ## ... trying feature 34 0X01 with BIC 1084.265 
    ## ... trying feature 35 1X01 with BIC 1083.874 
    ## ... trying feature 36 XX01 with BIC 1082.668 
    ## ... trying feature 37 0011 with BIC 1083.557 
    ## ... trying feature 38 1011 with BIC 1082.812 
    ## ... trying feature 39 X011 with BIC 1080.97

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 40 0111 with BIC 1082.153 
    ## ... trying feature 41 1111 with BIC 1080.591 
    ## ... trying feature 42 X111 with BIC 1079.885 
    ## ... trying feature 43 0X11 with BIC 1083.99 
    ## ... trying feature 44 1X11 with BIC 1084.361 
    ## ... trying feature 45 XX11 with BIC 1084.582 
    ## ... trying feature 46 00X1 with BIC 1084.183 
    ## ... trying feature 47 10X1 with BIC 1082.671 
    ## ... trying feature 48 X0X1 with BIC 1081.971

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1083.974 
    ## ... trying feature 50 11X1 with BIC 1077.694 
    ## ... trying feature 51 X1X1 with BIC 1077.471 
    ## ... trying feature 52 0XX1 with BIC 1084.364 
    ## ... trying feature 53 1XX1 with BIC 1080.402 
    ## ... trying feature 54 XXX1 with BIC 1079.85 
    ## ... trying feature 55 000X with BIC 1084.379 
    ## ... trying feature 56 100X with BIC 1084.379

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 58 010X with BIC 1082.689 
    ## ... trying feature 59 110X with BIC 1084.589 
    ## ... trying feature 60 X10X with BIC 1084.583 
    ## ... trying feature 61 0X0X with BIC 1084.529 
    ## ... trying feature 62 1X0X with BIC 1084.519 
    ## ... trying feature 63 XX0X with BIC 1084.583 
    ## ... trying feature 64 001X with BIC 1084.379 
    ## ... trying feature 65 101X with BIC 1082.743 
    ## ... trying feature 66 X01X with BIC 1081.971

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 67 011X with BIC 1082.689 
    ## ... trying feature 68 111X with BIC 1081.505 
    ## ... trying feature 69 X11X with BIC 1081.001 
    ## ... trying feature 70 0X1X with BIC 1084.529 
    ## ... trying feature 71 1X1X with BIC 1084.519 
    ## ... trying feature 72 XX1X with BIC 1084.583 
    ## ... trying feature 74 10XX with BIC 1081.971 
    ## ... trying feature 75 X0XX with BIC 1081.971 
    ## ... trying feature 76 01XX with BIC 1076.77 
    ## ... trying feature 77 11XX with BIC 1081.971 
    ## ... trying feature 78 X1XX with BIC 1081.971 
    ## ... trying feature 80 1XXX with BIC 1076.77 
    ## ... Using feature 6 X100 
    ## Adding Feature Number 6 
    ## ... trying feature 1 0000 with BIC 1083.545 
    ## ... trying feature 2 1000 with BIC 1083.873 
    ## ... trying feature 3 X000 with BIC 1083.267

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1083.995

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 5 1100 with BIC 1083.995 
    ## ... trying feature 7 0X00 with BIC 1083.527 
    ## ... trying feature 8 1X00 with BIC 1083.885 
    ## ... trying feature 9 XX00 with BIC 1083.267 
    ## ... trying feature 10 0010 with BIC 1082.508 
    ## ... trying feature 11 1010 with BIC 1083.945 
    ## ... trying feature 12 X010 with BIC 1083.267

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1083.703 
    ## ... trying feature 14 1110 with BIC 1083.799 
    ## ... trying feature 15 X110 with BIC 1083.726 
    ## ... trying feature 16 0X10 with BIC 1082.777 
    ## ... trying feature 17 1X10 with BIC 1083.716 
    ## ... trying feature 18 XX10 with BIC 1084.007 
    ## ... trying feature 19 00X0 with BIC 1083.614 
    ## ... trying feature 20 10X0 with BIC 1083.614

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1083.655 
    ## ... trying feature 23 11X0 with BIC 1083.81 
    ## ... trying feature 24 X1X0 with BIC 1083.726 
    ## ... trying feature 25 0XX0 with BIC 1083.741 
    ## ... trying feature 26 1XX0 with BIC 1083.414 
    ## ... trying feature 27 XXX0 with BIC 1083.726 
    ## ... trying feature 28 0001 with BIC 1083.249 
    ## ... trying feature 29 1001 with BIC 1083.849 
    ## ... trying feature 30 X001 with BIC 1083.267

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 0101 with BIC 1082.414 
    ## ... trying feature 32 1101 with BIC 1082.869 
    ## ... trying feature 33 X101 with BIC 1083.2 
    ## ... trying feature 34 0X01 with BIC 1083.553 
    ## ... trying feature 35 1X01 with BIC 1083.673 
    ## ... trying feature 36 XX01 with BIC 1082.547 
    ## ... trying feature 37 0011 with BIC 1082.717 
    ## ... trying feature 38 1011 with BIC 1080.86 
    ## ... trying feature 39 X011 with BIC 1078.241

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 40 0111 with BIC 1081.822 
    ## ... trying feature 41 1111 with BIC 1080.822 
    ## ... trying feature 42 X111 with BIC 1080.224 
    ## ... trying feature 43 0X11 with BIC 1083.19 
    ## ... trying feature 44 1X11 with BIC 1084.018 
    ## ... trying feature 45 XX11 with BIC 1083.205 
    ## ... trying feature 46 00X1 with BIC 1083.614 
    ## ... trying feature 47 10X1 with BIC 1080.186 
    ## ... trying feature 48 X0X1 with BIC 1079.188

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1083.655 
    ## ... trying feature 50 11X1 with BIC 1078.37 
    ## ... trying feature 51 X1X1 with BIC 1078.239 
    ## ... trying feature 52 0XX1 with BIC 1083.741 
    ## ... trying feature 53 1XX1 with BIC 1083.414 
    ## ... trying feature 54 XXX1 with BIC 1083.726 
    ## ... trying feature 55 000X with BIC 1083.651 
    ## ... trying feature 56 100X with BIC 1083.651

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 58 010X with BIC 1082.347 
    ## ... trying feature 59 110X with BIC 1082.859 
    ## ... trying feature 60 X10X with BIC 1083.2 
    ## ... trying feature 61 0X0X with BIC 1083.855 
    ## ... trying feature 62 1X0X with BIC 1083.821 
    ## ... trying feature 63 XX0X with BIC 1083.2 
    ## ... trying feature 64 001X with BIC 1083.651 
    ## ... trying feature 65 101X with BIC 1080.633 
    ## ... trying feature 66 X01X with BIC 1079.188

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 67 011X with BIC 1082.347 
    ## ... trying feature 68 111X with BIC 1081.711 
    ## ... trying feature 69 X11X with BIC 1081.308 
    ## ... trying feature 70 0X1X with BIC 1083.855 
    ## ... trying feature 71 1X1X with BIC 1083.821 
    ## ... trying feature 72 XX1X with BIC 1083.2 
    ## ... trying feature 74 10XX with BIC 1079.188 
    ## ... trying feature 75 X0XX with BIC 1079.188 
    ## ... trying feature 76 01XX with BIC 1076.215 
    ## ... trying feature 77 11XX with BIC 1079.188 
    ## ... trying feature 78 X1XX with BIC 1079.188 
    ## ... trying feature 80 1XXX with BIC 1076.215 
    ## ... Using feature 76 01XX 
    ## Adding Feature Number 7 
    ## ... trying feature 1 0000 with BIC 1083.545 
    ## ... trying feature 2 1000 with BIC 1083.873 
    ## ... trying feature 3 X000 with BIC 1083.267

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1083.995

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 5 1100 with BIC 1083.995 
    ## ... trying feature 7 0X00 with BIC 1083.527 
    ## ... trying feature 8 1X00 with BIC 1083.885 
    ## ... trying feature 9 XX00 with BIC 1083.267 
    ## ... trying feature 10 0010 with BIC 1082.508 
    ## ... trying feature 11 1010 with BIC 1083.945 
    ## ... trying feature 12 X010 with BIC 1083.267

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1083.703 
    ## ... trying feature 14 1110 with BIC 1083.799 
    ## ... trying feature 15 X110 with BIC 1083.726 
    ## ... trying feature 16 0X10 with BIC 1082.777 
    ## ... trying feature 17 1X10 with BIC 1083.716 
    ## ... trying feature 18 XX10 with BIC 1084.007 
    ## ... trying feature 19 00X0 with BIC 1083.614 
    ## ... trying feature 20 10X0 with BIC 1083.614

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1083.655 
    ## ... trying feature 23 11X0 with BIC 1083.81 
    ## ... trying feature 24 X1X0 with BIC 1083.726 
    ## ... trying feature 25 0XX0 with BIC 1083.741 
    ## ... trying feature 26 1XX0 with BIC 1083.414 
    ## ... trying feature 27 XXX0 with BIC 1083.726 
    ## ... trying feature 28 0001 with BIC 1083.249 
    ## ... trying feature 29 1001 with BIC 1083.849 
    ## ... trying feature 30 X001 with BIC 1083.267

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 0101 with BIC 1082.414 
    ## ... trying feature 32 1101 with BIC 1082.869 
    ## ... trying feature 33 X101 with BIC 1083.2 
    ## ... trying feature 34 0X01 with BIC 1083.553 
    ## ... trying feature 35 1X01 with BIC 1083.673 
    ## ... trying feature 36 XX01 with BIC 1082.547 
    ## ... trying feature 37 0011 with BIC 1082.717 
    ## ... trying feature 38 1011 with BIC 1080.86 
    ## ... trying feature 39 X011 with BIC 1078.241

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 40 0111 with BIC 1081.822 
    ## ... trying feature 41 1111 with BIC 1080.822 
    ## ... trying feature 42 X111 with BIC 1080.224 
    ## ... trying feature 43 0X11 with BIC 1083.19 
    ## ... trying feature 44 1X11 with BIC 1084.018 
    ## ... trying feature 45 XX11 with BIC 1083.205 
    ## ... trying feature 46 00X1 with BIC 1083.614 
    ## ... trying feature 47 10X1 with BIC 1080.186 
    ## ... trying feature 48 X0X1 with BIC 1079.188

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1083.655 
    ## ... trying feature 50 11X1 with BIC 1078.37 
    ## ... trying feature 51 X1X1 with BIC 1078.239 
    ## ... trying feature 52 0XX1 with BIC 1083.741 
    ## ... trying feature 53 1XX1 with BIC 1083.414 
    ## ... trying feature 54 XXX1 with BIC 1083.726 
    ## ... trying feature 55 000X with BIC 1083.651 
    ## ... trying feature 56 100X with BIC 1083.651

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 58 010X with BIC 1082.347 
    ## ... trying feature 59 110X with BIC 1082.859 
    ## ... trying feature 60 X10X with BIC 1083.2 
    ## ... trying feature 61 0X0X with BIC 1083.855 
    ## ... trying feature 62 1X0X with BIC 1083.821 
    ## ... trying feature 63 XX0X with BIC 1083.2 
    ## ... trying feature 64 001X with BIC 1083.651 
    ## ... trying feature 65 101X with BIC 1080.633 
    ## ... trying feature 66 X01X with BIC 1079.188

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 67 011X with BIC 1082.347 
    ## ... trying feature 68 111X with BIC 1081.711 
    ## ... trying feature 69 X11X with BIC 1081.308 
    ## ... trying feature 70 0X1X with BIC 1083.855 
    ## ... trying feature 71 1X1X with BIC 1083.821 
    ## ... trying feature 72 XX1X with BIC 1083.2 
    ## ... trying feature 74 10XX with BIC 1079.188 
    ## ... trying feature 75 X0XX with BIC 1079.188 
    ## ... trying feature 77 11XX with BIC 1079.188 
    ## ... trying feature 78 X1XX with BIC 1079.188 
    ## ... trying feature 80 1XXX with BIC 1076.215 
    ## ... Using feature 80 1XXX 
    ## Adding Feature Number 8 
    ## ... trying feature 1 0000 with BIC 1083.545 
    ## ... trying feature 2 1000 with BIC 1083.873 
    ## ... trying feature 3 X000 with BIC 1083.267

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1083.995

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 5 1100 with BIC 1083.995 
    ## ... trying feature 7 0X00 with BIC 1083.527 
    ## ... trying feature 8 1X00 with BIC 1083.885 
    ## ... trying feature 9 XX00 with BIC 1083.267 
    ## ... trying feature 10 0010 with BIC 1082.508 
    ## ... trying feature 11 1010 with BIC 1083.945 
    ## ... trying feature 12 X010 with BIC 1083.267

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1083.703 
    ## ... trying feature 14 1110 with BIC 1083.799 
    ## ... trying feature 15 X110 with BIC 1083.726 
    ## ... trying feature 16 0X10 with BIC 1082.777 
    ## ... trying feature 17 1X10 with BIC 1083.716 
    ## ... trying feature 18 XX10 with BIC 1084.007 
    ## ... trying feature 19 00X0 with BIC 1083.614 
    ## ... trying feature 20 10X0 with BIC 1083.614

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1083.655 
    ## ... trying feature 23 11X0 with BIC 1083.81 
    ## ... trying feature 24 X1X0 with BIC 1083.726 
    ## ... trying feature 25 0XX0 with BIC 1083.741 
    ## ... trying feature 26 1XX0 with BIC 1083.414 
    ## ... trying feature 27 XXX0 with BIC 1083.726 
    ## ... trying feature 28 0001 with BIC 1083.249 
    ## ... trying feature 29 1001 with BIC 1083.849 
    ## ... trying feature 30 X001 with BIC 1083.267

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 0101 with BIC 1082.414 
    ## ... trying feature 32 1101 with BIC 1082.869 
    ## ... trying feature 33 X101 with BIC 1083.2 
    ## ... trying feature 34 0X01 with BIC 1083.553 
    ## ... trying feature 35 1X01 with BIC 1083.673 
    ## ... trying feature 36 XX01 with BIC 1082.547 
    ## ... trying feature 37 0011 with BIC 1082.717 
    ## ... trying feature 38 1011 with BIC 1080.86 
    ## ... trying feature 39 X011 with BIC 1078.241

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 40 0111 with BIC 1081.822 
    ## ... trying feature 41 1111 with BIC 1080.822 
    ## ... trying feature 42 X111 with BIC 1080.224 
    ## ... trying feature 43 0X11 with BIC 1083.19 
    ## ... trying feature 44 1X11 with BIC 1084.018 
    ## ... trying feature 45 XX11 with BIC 1083.205 
    ## ... trying feature 46 00X1 with BIC 1083.614 
    ## ... trying feature 47 10X1 with BIC 1080.186 
    ## ... trying feature 48 X0X1 with BIC 1079.188

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1083.655 
    ## ... trying feature 50 11X1 with BIC 1078.37 
    ## ... trying feature 51 X1X1 with BIC 1078.239 
    ## ... trying feature 52 0XX1 with BIC 1083.741 
    ## ... trying feature 53 1XX1 with BIC 1083.414 
    ## ... trying feature 54 XXX1 with BIC 1083.726 
    ## ... trying feature 55 000X with BIC 1083.651 
    ## ... trying feature 56 100X with BIC 1083.651

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 58 010X with BIC 1082.347 
    ## ... trying feature 59 110X with BIC 1082.859 
    ## ... trying feature 60 X10X with BIC 1083.2 
    ## ... trying feature 61 0X0X with BIC 1083.855 
    ## ... trying feature 62 1X0X with BIC 1083.821 
    ## ... trying feature 63 XX0X with BIC 1083.2 
    ## ... trying feature 64 001X with BIC 1083.651 
    ## ... trying feature 65 101X with BIC 1080.633 
    ## ... trying feature 66 X01X with BIC 1079.188

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 67 011X with BIC 1082.347 
    ## ... trying feature 68 111X with BIC 1081.711 
    ## ... trying feature 69 X11X with BIC 1081.308 
    ## ... trying feature 70 0X1X with BIC 1083.855 
    ## ... trying feature 71 1X1X with BIC 1083.821 
    ## ... trying feature 72 XX1X with BIC 1083.2 
    ## ... trying feature 74 10XX with BIC 1079.188 
    ## ... trying feature 75 X0XX with BIC 1079.188 
    ## ... trying feature 77 11XX with BIC 1079.188 
    ## ... trying feature 78 X1XX with BIC 1079.188 
    ## ... Using feature 51 X1X1 
    ## Adding Feature Number 9 
    ## ... trying feature 1 0000 with BIC 1085.063 
    ## ... trying feature 2 1000 with BIC 1085.978 
    ## ... trying feature 3 X000 with BIC 1085.058

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1086.03

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 5 1100 with BIC 1086.03 
    ## ... trying feature 7 0X00 with BIC 1085.046 
    ## ... trying feature 8 1X00 with BIC 1085.984 
    ## ... trying feature 9 XX00 with BIC 1085.058 
    ## ... trying feature 10 0010 with BIC 1084.888 
    ## ... trying feature 11 1010 with BIC 1086.063 
    ## ... trying feature 12 X010 with BIC 1085.058

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1085.841 
    ## ... trying feature 14 1110 with BIC 1086.062 
    ## ... trying feature 15 X110 with BIC 1086.054 
    ## ... trying feature 16 0X10 with BIC 1085.047 
    ## ... trying feature 17 1X10 with BIC 1086.062 
    ## ... trying feature 18 XX10 with BIC 1085.678 
    ## ... trying feature 19 00X0 with BIC 1085.987 
    ## ... trying feature 20 10X0 with BIC 1085.987

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1085.806 
    ## ... trying feature 23 11X0 with BIC 1086.062 
    ## ... trying feature 24 X1X0 with BIC 1086.054 
    ## ... trying feature 25 0XX0 with BIC 1086.02 
    ## ... trying feature 26 1XX0 with BIC 1086.016 
    ## ... trying feature 27 XXX0 with BIC 1086.054 
    ## ... trying feature 28 0001 with BIC 1086.034 
    ## ... trying feature 29 1001 with BIC 1085.905 
    ## ... trying feature 30 X001 with BIC 1085.058

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 0101 with BIC 1084.324 
    ## ... trying feature 32 1101 with BIC 1085.999 
    ## ... trying feature 33 X101 with BIC 1085.867 
    ## ... trying feature 34 0X01 with BIC 1086.063 
    ## ... trying feature 35 1X01 with BIC 1086.056 
    ## ... trying feature 36 XX01 with BIC 1086.057 
    ## ... trying feature 37 0011 with BIC 1085.967 
    ## ... trying feature 38 1011 with BIC 1086.037 
    ## ... trying feature 39 X011 with BIC 1085.678

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 40 0111 with BIC 1083.919 
    ## ... trying feature 41 1111 with BIC 1086.015 
    ## ... trying feature 42 X111 with BIC 1085.867 
    ## ... trying feature 43 0X11 with BIC 1086.057 
    ## ... trying feature 44 1X11 with BIC 1086.062 
    ## ... trying feature 45 XX11 with BIC 1086.063 
    ## ... trying feature 46 00X1 with BIC 1085.987 
    ## ... trying feature 47 10X1 with BIC 1085.994 
    ## ... trying feature 48 X0X1 with BIC 1086.054

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1085.806

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 50 11X1 with BIC 1085.806 
    ## ... trying feature 52 0XX1 with BIC 1086.02 
    ## ... trying feature 53 1XX1 with BIC 1086.016 
    ## ... trying feature 54 XXX1 with BIC 1086.054 
    ## ... trying feature 55 000X with BIC 1086.002 
    ## ... trying feature 56 100X with BIC 1086.002

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 58 010X with BIC 1084.272 
    ## ... trying feature 59 110X with BIC 1086.001 
    ## ... trying feature 60 X10X with BIC 1085.867 
    ## ... trying feature 61 0X0X with BIC 1085.86 
    ## ... trying feature 62 1X0X with BIC 1086.063 
    ## ... trying feature 63 XX0X with BIC 1085.867 
    ## ... trying feature 64 001X with BIC 1086.002 
    ## ... trying feature 65 101X with BIC 1086.034 
    ## ... trying feature 66 X01X with BIC 1086.054

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 67 011X with BIC 1084.272 
    ## ... trying feature 68 111X with BIC 1086.035 
    ## ... trying feature 69 X11X with BIC 1085.949 
    ## ... trying feature 70 0X1X with BIC 1085.86 
    ## ... trying feature 71 1X1X with BIC 1086.063 
    ## ... trying feature 72 XX1X with BIC 1085.867 
    ## ... trying feature 74 10XX with BIC 1086.054 
    ## ... trying feature 75 X0XX with BIC 1086.054 
    ## ... trying feature 77 11XX with BIC 1086.054 
    ## ... trying feature 78 X1XX with BIC 1086.054

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... Using feature 40 0111 
    ## BIC selects 5 features but we also keep models with 6 and 7 features 
    ## [1] "Training..."
    ## Adding Feature Number 1 
    ## ... trying feature 1 0000 with BIC 2204.374 
    ## ... trying feature 2 1000 with BIC 2226.196 
    ## ... trying feature 3 X000 with BIC 2215.595

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 2200.763 
    ## ... trying feature 5 1100 with BIC 2224.99 
    ## ... trying feature 6 X100 with BIC 2217.43 
    ## ... trying feature 7 0X00 with BIC 2181.299 
    ## ... trying feature 8 1X00 with BIC 2225.552 
    ## ... trying feature 9 XX00 with BIC 2207.151 
    ## ... trying feature 10 0010 with BIC 2213.438 
    ## ... trying feature 11 1010 with BIC 2204.283 
    ## ... trying feature 12 X010 with BIC 2226.196

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 2190.898 
    ## ... trying feature 14 1110 with BIC 2220.405 
    ## ... trying feature 15 X110 with BIC 2218.84 
    ## ... trying feature 16 0X10 with BIC 2187.107 
    ## ... trying feature 17 1X10 with BIC 2199.64 
    ## ... trying feature 18 XX10 with BIC 2224.114 
    ## ... trying feature 19 00X0 with BIC 2193.582 
    ## ... trying feature 20 10X0 with BIC 2211.876 
    ## ... trying feature 21 X0X0 with BIC 2222.759

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 2164.961 
    ## ... trying feature 23 11X0 with BIC 2219.486 
    ## ... trying feature 24 X1X0 with BIC 2210.359 
    ## ... trying feature 25 0XX0 with BIC 2143.169 
    ## ... trying feature 26 1XX0 with BIC 2205.484 
    ## ... trying feature 27 XXX0 with BIC 2210.724 
    ## ... trying feature 28 0001 with BIC 2190.9 
    ## ... trying feature 29 1001 with BIC 2159.073 
    ## ... trying feature 30 X001 with BIC 2226.108 
    ## ... trying feature 31 0101 with BIC 2071.8 
    ## ... trying feature 32 1101 with BIC 2112.342 
    ## ... trying feature 33 X101 with BIC 2225.571 
    ## ... trying feature 34 0X01 with BIC 2076.716 
    ## ... trying feature 35 1X01 with BIC 2036.556 
    ## ... trying feature 36 XX01 with BIC 2226.179 
    ## ... trying feature 37 0011 with BIC 2188.659 
    ## ... trying feature 38 1011 with BIC 2035.119 
    ## ... trying feature 39 X011 with BIC 2208.326 
    ## ... trying feature 40 0111 with BIC 2015.725 
    ## ... trying feature 41 1111 with BIC 2086.659 
    ## ... trying feature 42 X111 with BIC 2223.74 
    ## ... trying feature 43 0X11 with BIC 2035.983 
    ## ... trying feature 44 1X11 with BIC 1846.334 
    ## ... trying feature 45 XX11 with BIC 2218.304 
    ## ... trying feature 46 00X1 with BIC 2133.609 
    ## ... trying feature 47 10X1 with BIC 1929.256 
    ## ... trying feature 48 X0X1 with BIC 2207.246 
    ## ... trying feature 49 01X1 with BIC 1825.371 
    ## ... trying feature 50 11X1 with BIC 1935.562 
    ## ... trying feature 51 X1X1 with BIC 2222.509 
    ## ... trying feature 52 0XX1 with BIC 1682.096 
    ## ... trying feature 53 1XX1 with BIC 1399.899 
    ## ... trying feature 54 XXX1 with BIC 2210.724 
    ## ... trying feature 55 000X with BIC 2172.873 
    ## ... trying feature 56 100X with BIC 2165.113 
    ## ... trying feature 57 X00X with BIC 2225.509 
    ## ... trying feature 58 010X with BIC 2042.201 
    ## ... trying feature 59 110X with BIC 2115.559 
    ## ... trying feature 60 X10X with BIC 2222.883 
    ## ... trying feature 61 0X0X with BIC 2021.121 
    ## ... trying feature 62 1X0X with BIC 2043.522 
    ## ... trying feature 63 XX0X with BIC 2221.867 
    ## ... trying feature 64 001X with BIC 2173.784 
    ## ... trying feature 65 101X with BIC 2003.486 
    ## ... trying feature 66 X01X with BIC 2208.386 
    ## ... trying feature 67 011X with BIC 1973.692 
    ## ... trying feature 68 111X with BIC 2078.341 
    ## ... trying feature 69 X11X with BIC 2219.572 
    ## ... trying feature 70 0X1X with BIC 1971.838 
    ## ... trying feature 71 1X1X with BIC 1800.723 
    ## ... trying feature 72 XX1X with BIC 2221.867 
    ## ... trying feature 73 00XX with BIC 2084.891 
    ## ... trying feature 74 10XX with BIC 1896.277 
    ## ... trying feature 75 X0XX with BIC 2213.495 
    ## ... trying feature 76 01XX with BIC 1742.09 
    ## ... trying feature 77 11XX with BIC 1925.075 
    ## ... trying feature 78 X1XX with BIC 2213.495 
    ## ... trying feature 79 0XXX with BIC 1310.44 
    ## ... trying feature 80 1XXX with BIC 1310.44 
    ## ... Using feature 79 0XXX 
    ## Adding Feature Number 2 
    ## ... trying feature 1 0000 with BIC 1313.837 
    ## ... trying feature 2 1000 with BIC 1294.112 
    ## ... trying feature 3 X000 with BIC 1290.873

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1308.517 
    ## ... trying feature 5 1100 with BIC 1316.124 
    ## ... trying feature 6 X100 with BIC 1309.595 
    ## ... trying feature 7 0X00 with BIC 1306.077 
    ## ... trying feature 8 1X00 with BIC 1295.102 
    ## ... trying feature 9 XX00 with BIC 1283.633 
    ## ... trying feature 10 0010 with BIC 1318.065 
    ## ... trying feature 11 1010 with BIC 1316.435 
    ## ... trying feature 12 X010 with BIC 1317.788

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1306.949 
    ## ... trying feature 14 1110 with BIC 1315.706 
    ## ... trying feature 15 X110 with BIC 1308.413 
    ## ... trying feature 16 0X10 with BIC 1316.529 
    ## ... trying feature 17 1X10 with BIC 1314.123 
    ## ... trying feature 18 XX10 with BIC 1312.475 
    ## ... trying feature 19 00X0 with BIC 1317.386 
    ## ... trying feature 20 10X0 with BIC 1298.46 
    ## ... trying feature 21 X0X0 with BIC 1302.423

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1296.897 
    ## ... trying feature 23 11X0 with BIC 1313.411 
    ## ... trying feature 24 X1X0 with BIC 1299.76 
    ## ... trying feature 25 0XX0 with BIC 1307.544 
    ## ... trying feature 26 1XX0 with BIC 1294.801 
    ## ... trying feature 27 XXX0 with BIC 1285.181 
    ## ... trying feature 28 0001 with BIC 1298.113 
    ## ... trying feature 29 1001 with BIC 1313.994 
    ## ... trying feature 30 X001 with BIC 1315.644 
    ## ... trying feature 31 0101 with BIC 1268.25 
    ## ... trying feature 32 1101 with BIC 1313.61 
    ## ... trying feature 33 X101 with BIC 1313.994 
    ## ... trying feature 34 0X01 with BIC 1318.257 
    ## ... trying feature 35 1X01 with BIC 1318.24 
    ## ... trying feature 36 XX01 with BIC 1318.26 
    ## ... trying feature 37 0011 with BIC 1263.376 
    ## ... trying feature 38 1011 with BIC 1316.963 
    ## ... trying feature 39 X011 with BIC 1285.192 
    ## ... trying feature 40 0111 with BIC 1249.748 
    ## ... trying feature 41 1111 with BIC 1310.385 
    ## ... trying feature 42 X111 with BIC 1313.057 
    ## ... trying feature 43 0X11 with BIC 1314.385 
    ## ... trying feature 44 1X11 with BIC 1307.61 
    ## ... trying feature 45 XX11 with BIC 1304.323 
    ## ... trying feature 46 00X1 with BIC 1171.075 
    ## ... trying feature 47 10X1 with BIC 1317.814 
    ## ... trying feature 48 X0X1 with BIC 1269.983 
    ## ... trying feature 49 01X1 with BIC 1183.931 
    ## ... trying feature 50 11X1 with BIC 1301.859 
    ## ... trying feature 51 X1X1 with BIC 1306.227 
    ## ... trying feature 52 0XX1 with BIC 1307.544 
    ## ... trying feature 53 1XX1 with BIC 1294.801 
    ## ... trying feature 54 XXX1 with BIC 1285.181 
    ## ... trying feature 55 000X with BIC 1305.026 
    ## ... trying feature 56 100X with BIC 1302.293 
    ## ... trying feature 57 X00X with BIC 1318.072 
    ## ... trying feature 58 010X with BIC 1257.278 
    ## ... trying feature 59 110X with BIC 1315.829 
    ## ... trying feature 60 X10X with BIC 1309.17 
    ## ... trying feature 61 0X0X with BIC 1316.505 
    ## ... trying feature 62 1X0X with BIC 1313.033 
    ## ... trying feature 63 XX0X with BIC 1311.622 
    ## ... trying feature 64 001X with BIC 1262.718 
    ## ... trying feature 65 101X with BIC 1317.964 
    ## ... trying feature 66 X01X with BIC 1290.015 
    ## ... trying feature 67 011X with BIC 1236.071 
    ## ... trying feature 68 111X with BIC 1313.698 
    ## ... trying feature 69 X11X with BIC 1306.95 
    ## ... trying feature 70 0X1X with BIC 1316.505 
    ## ... trying feature 71 1X1X with BIC 1313.033 
    ## ... trying feature 72 XX1X with BIC 1311.622 
    ## ... trying feature 73 00XX with BIC 1151.555 
    ## ... trying feature 74 10XX with BIC 1308.723 
    ## ... trying feature 75 X0XX with BIC 1291.755 
    ## ... trying feature 76 01XX with BIC 1151.555 
    ## ... trying feature 77 11XX with BIC 1308.723 
    ## ... trying feature 78 X1XX with BIC 1291.755 
    ## ... trying feature 80 1XXX with BIC 1310.44 
    ## ... Using feature 73 00XX 
    ## Adding Feature Number 3 
    ## ... trying feature 1 0000 with BIC 1147.831 
    ## ... trying feature 2 1000 with BIC 1137.124 
    ## ... trying feature 3 X000 with BIC 1126.047

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1159.111 
    ## ... trying feature 5 1100 with BIC 1158.041 
    ## ... trying feature 6 X100 with BIC 1157.898 
    ## ... trying feature 7 0X00 with BIC 1147.605 
    ## ... trying feature 8 1X00 with BIC 1139.41 
    ## ... trying feature 9 XX00 with BIC 1127.701 
    ## ... trying feature 10 0010 with BIC 1157.949 
    ## ... trying feature 11 1010 with BIC 1157.956 
    ## ... trying feature 12 X010 with BIC 1156.487

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1159.066 
    ## ... trying feature 14 1110 with BIC 1157.308 
    ## ... trying feature 15 X110 with BIC 1157.138 
    ## ... trying feature 16 0X10 with BIC 1157.838 
    ## ... trying feature 17 1X10 with BIC 1156.078 
    ## ... trying feature 18 XX10 with BIC 1154.589 
    ## ... trying feature 19 00X0 with BIC 1149.65 
    ## ... trying feature 20 10X0 with BIC 1141.828 
    ## ... trying feature 21 X0X0 with BIC 1133.124

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1158.775 
    ## ... trying feature 23 11X0 with BIC 1155.846 
    ## ... trying feature 24 X1X0 with BIC 1155.528 
    ## ... trying feature 25 0XX0 with BIC 1149.287 
    ## ... trying feature 26 1XX0 with BIC 1139.877 
    ## ... trying feature 27 XXX0 with BIC 1129.925 
    ## ... trying feature 28 0001 with BIC 1159.372 
    ## ... trying feature 29 1001 with BIC 1156.622 
    ## ... trying feature 30 X001 with BIC 1157.956 
    ## ... trying feature 31 0101 with BIC 1159.253 
    ## ... trying feature 32 1101 with BIC 1154.405 
    ## ... trying feature 33 X101 with BIC 1154.278 
    ## ... trying feature 34 0X01 with BIC 1159.378 
    ## ... trying feature 35 1X01 with BIC 1159.296 
    ## ... trying feature 36 XX01 with BIC 1159.345 
    ## ... trying feature 37 0011 with BIC 1155.365 
    ## ... trying feature 38 1011 with BIC 1159.201 
    ## ... trying feature 39 X011 with BIC 1156.611 
    ## ... trying feature 40 0111 with BIC 1159.377 
    ## ... trying feature 41 1111 with BIC 1152.491 
    ## ... trying feature 42 X111 with BIC 1152.574 
    ## ... trying feature 43 0X11 with BIC 1155.403 
    ## ... trying feature 44 1X11 with BIC 1153.262 
    ## ... trying feature 45 XX11 with BIC 1149.384 
    ## ... trying feature 46 00X1 with BIC 1149.65 
    ## ... trying feature 47 10X1 with BIC 1158.457 
    ## ... trying feature 48 X0X1 with BIC 1158.969

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1158.775 
    ## ... trying feature 50 11X1 with BIC 1143.768 
    ## ... trying feature 51 X1X1 with BIC 1143.489 
    ## ... trying feature 52 0XX1 with BIC 1149.287 
    ## ... trying feature 53 1XX1 with BIC 1139.877 
    ## ... trying feature 54 XXX1 with BIC 1129.925 
    ## ... trying feature 55 000X with BIC 1157.341 
    ## ... trying feature 56 100X with BIC 1147.248 
    ## ... trying feature 57 X00X with BIC 1147.386 
    ## ... trying feature 58 010X with BIC 1159.352 
    ## ... trying feature 59 110X with BIC 1156.243 
    ## ... trying feature 60 X10X with BIC 1156.217 
    ## ... trying feature 61 0X0X with BIC 1157.431 
    ## ... trying feature 62 1X0X with BIC 1156.726 
    ## ... trying feature 63 XX0X with BIC 1154.912 
    ## ... trying feature 64 001X with BIC 1157.341 
    ## ... trying feature 65 101X with BIC 1159.376 
    ## ... trying feature 66 X01X with BIC 1158.568 
    ## ... trying feature 67 011X with BIC 1159.352 
    ## ... trying feature 68 111X with BIC 1155.247 
    ## ... trying feature 69 X11X with BIC 1155.395 
    ## ... trying feature 70 0X1X with BIC 1157.431 
    ## ... trying feature 71 1X1X with BIC 1156.726 
    ## ... trying feature 72 XX1X with BIC 1154.912 
    ## ... trying feature 74 10XX with BIC 1149.368 
    ## ... trying feature 75 X0XX with BIC 1149.368 
    ## ... trying feature 76 01XX with BIC 1151.555 
    ## ... trying feature 77 11XX with BIC 1149.368 
    ## ... trying feature 78 X1XX with BIC 1149.368 
    ## ... trying feature 80 1XXX with BIC 1151.555 
    ## ... Using feature 3 X000 
    ## Adding Feature Number 4 
    ## ... trying feature 1 0000 with BIC 1133.736 
    ## ... trying feature 2 1000 with BIC 1133.736

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1133.629 
    ## ... trying feature 5 1100 with BIC 1132.587 
    ## ... trying feature 6 X100 with BIC 1132.46 
    ## ... trying feature 7 0X00 with BIC 1133.81 
    ## ... trying feature 8 1X00 with BIC 1132.607 
    ## ... trying feature 9 XX00 with BIC 1132.46 
    ## ... trying feature 10 0010 with BIC 1132.011 
    ## ... trying feature 11 1010 with BIC 1131.571 
    ## ... trying feature 12 X010 with BIC 1129.7

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1133.565 
    ## ... trying feature 14 1110 with BIC 1131.539 
    ## ... trying feature 15 X110 with BIC 1131.366 
    ## ... trying feature 16 0X10 with BIC 1131.891 
    ## ... trying feature 17 1X10 with BIC 1129.316 
    ## ... trying feature 18 XX10 with BIC 1127.44 
    ## ... trying feature 19 00X0 with BIC 1132.543 
    ## ... trying feature 20 10X0 with BIC 1131.42 
    ## ... trying feature 21 X0X0 with BIC 1129.7

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1133.303 
    ## ... trying feature 23 11X0 with BIC 1130.136 
    ## ... trying feature 24 X1X0 with BIC 1129.832 
    ## ... trying feature 25 0XX0 with BIC 1132.361 
    ## ... trying feature 26 1XX0 with BIC 1127.938 
    ## ... trying feature 27 XXX0 with BIC 1126.035 
    ## ... trying feature 28 0001 with BIC 1133.339 
    ## ... trying feature 29 1001 with BIC 1128.481 
    ## ... trying feature 30 X001 with BIC 1129.397 
    ## ... trying feature 31 0101 with BIC 1133.754 
    ## ... trying feature 32 1101 with BIC 1130.491 
    ## ... trying feature 33 X101 with BIC 1130.377 
    ## ... trying feature 34 0X01 with BIC 1133.407 
    ## ... trying feature 35 1X01 with BIC 1133.552 
    ## ... trying feature 36 XX01 with BIC 1133.128 
    ## ... trying feature 37 0011 with BIC 1132.104 
    ## ... trying feature 38 1011 with BIC 1133.866 
    ## ... trying feature 39 X011 with BIC 1132.958 
    ## ... trying feature 40 0111 with BIC 1133.87 
    ## ... trying feature 41 1111 with BIC 1128.511 
    ## ... trying feature 42 X111 with BIC 1128.579 
    ## ... trying feature 43 0X11 with BIC 1132.119 
    ## ... trying feature 44 1X11 with BIC 1130.134 
    ## ... trying feature 45 XX11 with BIC 1128.503 
    ## ... trying feature 46 00X1 with BIC 1132.543 
    ## ... trying feature 47 10X1 with BIC 1130.435 
    ## ... trying feature 48 X0X1 with BIC 1132.471

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1133.303 
    ## ... trying feature 50 11X1 with BIC 1122.352 
    ## ... trying feature 51 X1X1 with BIC 1122.111 
    ## ... trying feature 52 0XX1 with BIC 1132.361 
    ## ... trying feature 53 1XX1 with BIC 1127.938 
    ## ... trying feature 54 XXX1 with BIC 1126.035 
    ## ... trying feature 55 000X with BIC 1133.441 
    ## ... trying feature 56 100X with BIC 1128.29 
    ## ... trying feature 57 X00X with BIC 1129.397 
    ## ... trying feature 58 010X with BIC 1133.842 
    ## ... trying feature 59 110X with BIC 1131.942 
    ## ... trying feature 60 X10X with BIC 1131.91 
    ## ... trying feature 61 0X0X with BIC 1133.476 
    ## ... trying feature 62 1X0X with BIC 1133.034 
    ## ... trying feature 63 XX0X with BIC 1132.694 
    ## ... trying feature 64 001X with BIC 1133.441 
    ## ... trying feature 65 101X with BIC 1133.583 
    ## ... trying feature 66 X01X with BIC 1133.869 
    ## ... trying feature 67 011X with BIC 1133.842 
    ## ... trying feature 68 111X with BIC 1131.013 
    ## ... trying feature 69 X11X with BIC 1131.132 
    ## ... trying feature 70 0X1X with BIC 1133.476 
    ## ... trying feature 71 1X1X with BIC 1133.034 
    ## ... trying feature 72 XX1X with BIC 1132.694 
    ## ... trying feature 74 10XX with BIC 1127.232 
    ## ... trying feature 75 X0XX with BIC 1127.232 
    ## ... trying feature 76 01XX with BIC 1126.047 
    ## ... trying feature 77 11XX with BIC 1127.232 
    ## ... trying feature 78 X1XX with BIC 1127.232 
    ## ... trying feature 80 1XXX with BIC 1126.047 
    ## ... Using feature 51 X1X1 
    ## Adding Feature Number 5 
    ## ... trying feature 1 0000 with BIC 1129.91 
    ## ... trying feature 2 1000 with BIC 1129.91

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1129.782 
    ## ... trying feature 5 1100 with BIC 1129.277 
    ## ... trying feature 6 X100 with BIC 1129.213 
    ## ... trying feature 7 0X00 with BIC 1129.927 
    ## ... trying feature 8 1X00 with BIC 1129.383 
    ## ... trying feature 9 XX00 with BIC 1129.213 
    ## ... trying feature 10 0010 with BIC 1128.127 
    ## ... trying feature 11 1010 with BIC 1128.687 
    ## ... trying feature 12 X010 with BIC 1126.832

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1129.758 
    ## ... trying feature 14 1110 with BIC 1128.861 
    ## ... trying feature 15 X110 with BIC 1128.782 
    ## ... trying feature 16 0X10 with BIC 1128.058 
    ## ... trying feature 17 1X10 with BIC 1127.601 
    ## ... trying feature 18 XX10 with BIC 1125.699 
    ## ... trying feature 19 00X0 with BIC 1128.486 
    ## ... trying feature 20 10X0 with BIC 1128.716 
    ## ... trying feature 21 X0X0 with BIC 1126.832

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1129.598 
    ## ... trying feature 23 11X0 with BIC 1128.112 
    ## ... trying feature 24 X1X0 with BIC 1127.962 
    ## ... trying feature 25 0XX0 with BIC 1128.372 
    ## ... trying feature 26 1XX0 with BIC 1126.962 
    ## ... trying feature 27 XXX0 with BIC 1124.916 
    ## ... trying feature 28 0001 with BIC 1129.167 
    ## ... trying feature 29 1001 with BIC 1128.798 
    ## ... trying feature 30 X001 with BIC 1128.126 
    ## ... trying feature 31 0101 with BIC 1129.86 
    ## ... trying feature 32 1101 with BIC 1129.923 
    ## ... trying feature 33 X101 with BIC 1129.932 
    ## ... trying feature 34 0X01 with BIC 1129.238 
    ## ... trying feature 35 1X01 with BIC 1129.142 
    ## ... trying feature 36 XX01 with BIC 1128.485 
    ## ... trying feature 37 0011 with BIC 1127.676 
    ## ... trying feature 38 1011 with BIC 1124.853 
    ## ... trying feature 39 X011 with BIC 1123.006 
    ## ... trying feature 40 0111 with BIC 1129.933 
    ## ... trying feature 41 1111 with BIC 1129.931 
    ## ... trying feature 42 X111 with BIC 1129.932 
    ## ... trying feature 43 0X11 with BIC 1127.729 
    ## ... trying feature 44 1X11 with BIC 1126.643 
    ## ... trying feature 45 XX11 with BIC 1124.493 
    ## ... trying feature 46 00X1 with BIC 1128.486 
    ## ... trying feature 47 10X1 with BIC 1126.826 
    ## ... trying feature 48 X0X1 with BIC 1124.916

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1129.598

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 50 11X1 with BIC 1129.598 
    ## ... trying feature 52 0XX1 with BIC 1128.372 
    ## ... trying feature 53 1XX1 with BIC 1126.962 
    ## ... trying feature 54 XXX1 with BIC 1124.916 
    ## ... trying feature 55 000X with BIC 1129.225 
    ## ... trying feature 56 100X with BIC 1128.748 
    ## ... trying feature 57 X00X with BIC 1128.126 
    ## ... trying feature 58 010X with BIC 1129.908 
    ## ... trying feature 59 110X with BIC 1129.773 
    ## ... trying feature 60 X10X with BIC 1129.798 
    ## ... trying feature 61 0X0X with BIC 1129.271 
    ## ... trying feature 62 1X0X with BIC 1128.691 
    ## ... trying feature 63 XX0X with BIC 1128.094 
    ## ... trying feature 64 001X with BIC 1129.225 
    ## ... trying feature 65 101X with BIC 1126.84 
    ## ... trying feature 66 X01X with BIC 1126.704 
    ## ... trying feature 67 011X with BIC 1129.908 
    ## ... trying feature 68 111X with BIC 1129.782 
    ## ... trying feature 69 X11X with BIC 1129.764 
    ## ... trying feature 70 0X1X with BIC 1129.271 
    ## ... trying feature 71 1X1X with BIC 1128.691 
    ## ... trying feature 72 XX1X with BIC 1128.094 
    ## ... trying feature 74 10XX with BIC 1127.962 
    ## ... trying feature 75 X0XX with BIC 1127.962 
    ## ... trying feature 76 01XX with BIC 1122.111 
    ## ... trying feature 77 11XX with BIC 1127.962 
    ## ... trying feature 78 X1XX with BIC 1127.962 
    ## ... trying feature 80 1XXX with BIC 1122.111 
    ## ... Using feature 76 01XX 
    ## Adding Feature Number 6 
    ## ... trying feature 1 0000 with BIC 1129.91 
    ## ... trying feature 2 1000 with BIC 1129.91

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1129.782 
    ## ... trying feature 5 1100 with BIC 1129.277 
    ## ... trying feature 6 X100 with BIC 1129.213 
    ## ... trying feature 7 0X00 with BIC 1129.927 
    ## ... trying feature 8 1X00 with BIC 1129.383 
    ## ... trying feature 9 XX00 with BIC 1129.213 
    ## ... trying feature 10 0010 with BIC 1128.127 
    ## ... trying feature 11 1010 with BIC 1128.687 
    ## ... trying feature 12 X010 with BIC 1126.832

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1129.758 
    ## ... trying feature 14 1110 with BIC 1128.861 
    ## ... trying feature 15 X110 with BIC 1128.782 
    ## ... trying feature 16 0X10 with BIC 1128.058 
    ## ... trying feature 17 1X10 with BIC 1127.601 
    ## ... trying feature 18 XX10 with BIC 1125.699 
    ## ... trying feature 19 00X0 with BIC 1128.486 
    ## ... trying feature 20 10X0 with BIC 1128.716 
    ## ... trying feature 21 X0X0 with BIC 1126.832

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1129.598 
    ## ... trying feature 23 11X0 with BIC 1128.112 
    ## ... trying feature 24 X1X0 with BIC 1127.962 
    ## ... trying feature 25 0XX0 with BIC 1128.372 
    ## ... trying feature 26 1XX0 with BIC 1126.962 
    ## ... trying feature 27 XXX0 with BIC 1124.916 
    ## ... trying feature 28 0001 with BIC 1129.167 
    ## ... trying feature 29 1001 with BIC 1128.798 
    ## ... trying feature 30 X001 with BIC 1128.126 
    ## ... trying feature 31 0101 with BIC 1129.86 
    ## ... trying feature 32 1101 with BIC 1129.923 
    ## ... trying feature 33 X101 with BIC 1129.932 
    ## ... trying feature 34 0X01 with BIC 1129.238 
    ## ... trying feature 35 1X01 with BIC 1129.142 
    ## ... trying feature 36 XX01 with BIC 1128.485 
    ## ... trying feature 37 0011 with BIC 1127.676 
    ## ... trying feature 38 1011 with BIC 1124.853 
    ## ... trying feature 39 X011 with BIC 1123.006 
    ## ... trying feature 40 0111 with BIC 1129.933 
    ## ... trying feature 41 1111 with BIC 1129.931 
    ## ... trying feature 42 X111 with BIC 1129.932 
    ## ... trying feature 43 0X11 with BIC 1127.729 
    ## ... trying feature 44 1X11 with BIC 1126.643 
    ## ... trying feature 45 XX11 with BIC 1124.493 
    ## ... trying feature 46 00X1 with BIC 1128.486 
    ## ... trying feature 47 10X1 with BIC 1126.826 
    ## ... trying feature 48 X0X1 with BIC 1124.916

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1129.598

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 50 11X1 with BIC 1129.598 
    ## ... trying feature 52 0XX1 with BIC 1128.372 
    ## ... trying feature 53 1XX1 with BIC 1126.962 
    ## ... trying feature 54 XXX1 with BIC 1124.916 
    ## ... trying feature 55 000X with BIC 1129.225 
    ## ... trying feature 56 100X with BIC 1128.748 
    ## ... trying feature 57 X00X with BIC 1128.126 
    ## ... trying feature 58 010X with BIC 1129.908 
    ## ... trying feature 59 110X with BIC 1129.773 
    ## ... trying feature 60 X10X with BIC 1129.798 
    ## ... trying feature 61 0X0X with BIC 1129.271 
    ## ... trying feature 62 1X0X with BIC 1128.691 
    ## ... trying feature 63 XX0X with BIC 1128.094 
    ## ... trying feature 64 001X with BIC 1129.225 
    ## ... trying feature 65 101X with BIC 1126.84 
    ## ... trying feature 66 X01X with BIC 1126.704 
    ## ... trying feature 67 011X with BIC 1129.908 
    ## ... trying feature 68 111X with BIC 1129.782 
    ## ... trying feature 69 X11X with BIC 1129.764 
    ## ... trying feature 70 0X1X with BIC 1129.271 
    ## ... trying feature 71 1X1X with BIC 1128.691 
    ## ... trying feature 72 XX1X with BIC 1128.094 
    ## ... trying feature 74 10XX with BIC 1127.962 
    ## ... trying feature 75 X0XX with BIC 1127.962 
    ## ... trying feature 77 11XX with BIC 1127.962 
    ## ... trying feature 78 X1XX with BIC 1127.962 
    ## ... trying feature 80 1XXX with BIC 1122.111 
    ## ... Using feature 80 1XXX 
    ## Adding Feature Number 7 
    ## ... trying feature 1 0000 with BIC 1129.91 
    ## ... trying feature 2 1000 with BIC 1129.91

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1129.782 
    ## ... trying feature 5 1100 with BIC 1129.277 
    ## ... trying feature 6 X100 with BIC 1129.213 
    ## ... trying feature 7 0X00 with BIC 1129.927 
    ## ... trying feature 8 1X00 with BIC 1129.383 
    ## ... trying feature 9 XX00 with BIC 1129.213 
    ## ... trying feature 10 0010 with BIC 1128.127 
    ## ... trying feature 11 1010 with BIC 1128.687 
    ## ... trying feature 12 X010 with BIC 1126.832

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1129.758 
    ## ... trying feature 14 1110 with BIC 1128.861 
    ## ... trying feature 15 X110 with BIC 1128.782 
    ## ... trying feature 16 0X10 with BIC 1128.058 
    ## ... trying feature 17 1X10 with BIC 1127.601 
    ## ... trying feature 18 XX10 with BIC 1125.699 
    ## ... trying feature 19 00X0 with BIC 1128.486 
    ## ... trying feature 20 10X0 with BIC 1128.716 
    ## ... trying feature 21 X0X0 with BIC 1126.832

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1129.598 
    ## ... trying feature 23 11X0 with BIC 1128.112 
    ## ... trying feature 24 X1X0 with BIC 1127.962 
    ## ... trying feature 25 0XX0 with BIC 1128.372 
    ## ... trying feature 26 1XX0 with BIC 1126.962 
    ## ... trying feature 27 XXX0 with BIC 1124.916 
    ## ... trying feature 28 0001 with BIC 1129.167 
    ## ... trying feature 29 1001 with BIC 1128.798 
    ## ... trying feature 30 X001 with BIC 1128.126 
    ## ... trying feature 31 0101 with BIC 1129.86 
    ## ... trying feature 32 1101 with BIC 1129.923 
    ## ... trying feature 33 X101 with BIC 1129.932 
    ## ... trying feature 34 0X01 with BIC 1129.238 
    ## ... trying feature 35 1X01 with BIC 1129.142 
    ## ... trying feature 36 XX01 with BIC 1128.485 
    ## ... trying feature 37 0011 with BIC 1127.676 
    ## ... trying feature 38 1011 with BIC 1124.853 
    ## ... trying feature 39 X011 with BIC 1123.006 
    ## ... trying feature 40 0111 with BIC 1129.933 
    ## ... trying feature 41 1111 with BIC 1129.931 
    ## ... trying feature 42 X111 with BIC 1129.932 
    ## ... trying feature 43 0X11 with BIC 1127.729 
    ## ... trying feature 44 1X11 with BIC 1126.643 
    ## ... trying feature 45 XX11 with BIC 1124.493 
    ## ... trying feature 46 00X1 with BIC 1128.486 
    ## ... trying feature 47 10X1 with BIC 1126.826 
    ## ... trying feature 48 X0X1 with BIC 1124.916

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1129.598

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 50 11X1 with BIC 1129.598 
    ## ... trying feature 52 0XX1 with BIC 1128.372 
    ## ... trying feature 53 1XX1 with BIC 1126.962 
    ## ... trying feature 54 XXX1 with BIC 1124.916 
    ## ... trying feature 55 000X with BIC 1129.225 
    ## ... trying feature 56 100X with BIC 1128.748 
    ## ... trying feature 57 X00X with BIC 1128.126 
    ## ... trying feature 58 010X with BIC 1129.908 
    ## ... trying feature 59 110X with BIC 1129.773 
    ## ... trying feature 60 X10X with BIC 1129.798 
    ## ... trying feature 61 0X0X with BIC 1129.271 
    ## ... trying feature 62 1X0X with BIC 1128.691 
    ## ... trying feature 63 XX0X with BIC 1128.094 
    ## ... trying feature 64 001X with BIC 1129.225 
    ## ... trying feature 65 101X with BIC 1126.84 
    ## ... trying feature 66 X01X with BIC 1126.704 
    ## ... trying feature 67 011X with BIC 1129.908 
    ## ... trying feature 68 111X with BIC 1129.782 
    ## ... trying feature 69 X11X with BIC 1129.764 
    ## ... trying feature 70 0X1X with BIC 1129.271 
    ## ... trying feature 71 1X1X with BIC 1128.691 
    ## ... trying feature 72 XX1X with BIC 1128.094 
    ## ... trying feature 74 10XX with BIC 1127.962 
    ## ... trying feature 75 X0XX with BIC 1127.962 
    ## ... trying feature 77 11XX with BIC 1127.962 
    ## ... trying feature 78 X1XX with BIC 1127.962 
    ## ... Using feature 39 X011 
    ## Adding Feature Number 8 
    ## ... trying feature 1 0000 with BIC 1130.819 
    ## ... trying feature 2 1000 with BIC 1130.819

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 4 0100 with BIC 1130.702 
    ## ... trying feature 5 1100 with BIC 1130.597 
    ## ... trying feature 6 X100 with BIC 1130.561 
    ## ... trying feature 7 0X00 with BIC 1130.828 
    ## ... trying feature 8 1X00 with BIC 1130.631 
    ## ... trying feature 9 XX00 with BIC 1130.561 
    ## ... trying feature 10 0010 with BIC 1130.129 
    ## ... trying feature 11 1010 with BIC 1130.393 
    ## ... trying feature 12 X010 with BIC 1129.631

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 13 0110 with BIC 1130.69 
    ## ... trying feature 14 1110 with BIC 1130.309 
    ## ... trying feature 15 X110 with BIC 1130.261 
    ## ... trying feature 16 0X10 with BIC 1130.09 
    ## ... trying feature 17 1X10 with BIC 1129.865 
    ## ... trying feature 18 XX10 with BIC 1129.027 
    ## ... trying feature 19 00X0 with BIC 1130.283 
    ## ... trying feature 20 10X0 with BIC 1130.398 
    ## ... trying feature 21 X0X0 with BIC 1129.631

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 22 01X0 with BIC 1130.558 
    ## ... trying feature 23 11X0 with BIC 1130.03 
    ## ... trying feature 24 X1X0 with BIC 1129.939 
    ## ... trying feature 25 0XX0 with BIC 1130.22 
    ## ... trying feature 26 1XX0 with BIC 1129.614 
    ## ... trying feature 27 XXX0 with BIC 1128.675 
    ## ... trying feature 28 0001 with BIC 1129.509 
    ## ... trying feature 29 1001 with BIC 1130.728 
    ## ... trying feature 30 X001 with BIC 1128.675 
    ## ... trying feature 31 0101 with BIC 1130.764 
    ## ... trying feature 32 1101 with BIC 1130.828 
    ## ... trying feature 33 X101 with BIC 1130.83 
    ## ... trying feature 34 0X01 with BIC 1129.447 
    ## ... trying feature 35 1X01 with BIC 1130.79 
    ## ... trying feature 36 XX01 with BIC 1129.715 
    ## ... trying feature 37 0011 with BIC 1130.363 
    ## ... trying feature 38 1011 with BIC 1130.363 
    ## ... trying feature 40 0111 with BIC 1130.825 
    ## ... trying feature 41 1111 with BIC 1130.83 
    ## ... trying feature 42 X111 with BIC 1130.83 
    ## ... trying feature 43 0X11 with BIC 1130.36 
    ## ... trying feature 44 1X11 with BIC 1130.595 
    ## ... trying feature 45 XX11 with BIC 1130.83 
    ## ... trying feature 46 00X1 with BIC 1130.283 
    ## ... trying feature 47 10X1 with BIC 1129.535 
    ## ... trying feature 48 X0X1 with BIC 1128.675

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 49 01X1 with BIC 1130.558

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 50 11X1 with BIC 1130.558 
    ## ... trying feature 52 0XX1 with BIC 1130.22 
    ## ... trying feature 53 1XX1 with BIC 1129.614 
    ## ... trying feature 54 XXX1 with BIC 1128.675 
    ## ... trying feature 55 000X with BIC 1129.47 
    ## ... trying feature 56 100X with BIC 1130.748 
    ## ... trying feature 57 X00X with BIC 1128.675 
    ## ... trying feature 58 010X with BIC 1130.802 
    ## ... trying feature 59 110X with BIC 1130.782 
    ## ... trying feature 60 X10X with BIC 1130.795 
    ## ... trying feature 61 0X0X with BIC 1129.443 
    ## ... trying feature 62 1X0X with BIC 1130.828 
    ## ... trying feature 63 XX0X with BIC 1129.948 
    ## ... trying feature 64 001X with BIC 1129.47 
    ## ... trying feature 65 101X with BIC 1130.762 
    ## ... trying feature 66 X01X with BIC 1129.631 
    ## ... trying feature 67 011X with BIC 1130.802 
    ## ... trying feature 68 111X with BIC 1130.739 
    ## ... trying feature 69 X11X with BIC 1130.724 
    ## ... trying feature 70 0X1X with BIC 1129.443 
    ## ... trying feature 71 1X1X with BIC 1130.828 
    ## ... trying feature 72 XX1X with BIC 1129.948 
    ## ... trying feature 74 10XX with BIC 1129.939 
    ## ... trying feature 75 X0XX with BIC 1129.939 
    ## ... trying feature 77 11XX with BIC 1129.939 
    ## ... trying feature 78 X1XX with BIC 1129.939 
    ## ... Using feature 27 XXX0 
    ## BIC selects 4 features but we also keep models with 5 and 6 features 
    ## Step 1 selects 9 candidate models 
    ## Candidate model 1 has feature 0XXX 00XX XXX0 X00X 
    ## Relative gain =  0.5821303 
    ## Relative gain =  0.5504369 
    ## Relative gain =  0.5645611 
    ## Relative gain =  0.5051366 
    ## Relative gain =  0.5683831 
    ## Relative gain =  0.5045998 
    ## Relative gain =  0.4707148 
    ## Relative gain =  0.5576559 
    ## Relative gain =  0.5493402 
    ## Relative gain =  0.6522008 
    ## Average gain for candidate model 1 is 0.5505159 
    ## Candidate model 2 has feature 0XXX 00XX XXX0 X00X XXX1 
    ## Relative gain =  0.5821303 
    ## Relative gain =  0.5504369 
    ## Relative gain =  0.5645611 
    ## Relative gain =  0.5051366 
    ## Relative gain =  0.5683831 
    ## Relative gain =  0.5045998 
    ## Relative gain =  0.4707148 
    ## Relative gain =  0.5576559 
    ## Relative gain =  0.5493402 
    ## Relative gain =  0.6522008 
    ## Average gain for candidate model 2 is 0.5505159 
    ## Candidate model 3 has feature 0XXX 00XX XXX0 X00X XXX1 01XX 
    ## Relative gain =  0.5821303 
    ## Relative gain =  0.5504369 
    ## Relative gain =  0.5645611 
    ## Relative gain =  0.5051366 
    ## Relative gain =  0.5683831 
    ## Relative gain =  0.5045998 
    ## Relative gain =  0.4707148 
    ## Relative gain =  0.5576559 
    ## Relative gain =  0.5493402 
    ## Relative gain =  0.6522008 
    ## Average gain for candidate model 3 is 0.5505159 
    ## Candidate model 4 has feature 0XXX 00XX X0X0 X00X X100 
    ## Relative gain =  0.586136 
    ## Relative gain =  0.54397 
    ## Relative gain =  0.5624277 
    ## Relative gain =  0.4992824 
    ## Relative gain =  0.5713624 
    ## Relative gain =  0.5021279 
    ## Relative gain =  0.4736106 
    ## Relative gain =  0.5561038 
    ## Relative gain =  0.5409211 
    ## Relative gain =  0.6456297 
    ## Average gain for candidate model 4 is 0.5481571 
    ## Candidate model 5 has feature 0XXX 00XX X0X0 X00X X100 01XX 
    ## Relative gain =  0.586136 
    ## Relative gain =  0.54397 
    ## Relative gain =  0.5624277 
    ## Relative gain =  0.4992824 
    ## Relative gain =  0.5713624 
    ## Relative gain =  0.5021279 
    ## Relative gain =  0.4736106 
    ## Relative gain =  0.5561038 
    ## Relative gain =  0.5409211 
    ## Relative gain =  0.6456297 
    ## Average gain for candidate model 5 is 0.5481571 
    ## Candidate model 6 has feature 0XXX 00XX X0X0 X00X X100 01XX 1XXX 
    ## Relative gain =  0.586136 
    ## Relative gain =  0.54397 
    ## Relative gain =  0.5624277 
    ## Relative gain =  0.4992824 
    ## Relative gain =  0.5713624 
    ## Relative gain =  0.5021279 
    ## Relative gain =  0.4736106 
    ## Relative gain =  0.5561038 
    ## Relative gain =  0.5409211 
    ## Relative gain =  0.6456297 
    ## Average gain for candidate model 6 is 0.5481571 
    ## Candidate model 7 has feature 0XXX 00XX X000 X1X1 
    ## Relative gain =  0.5818248 
    ## Relative gain =  0.5441058 
    ## Relative gain =  0.560756 
    ## Relative gain =  0.5166898 
    ## Relative gain =  0.568912 
    ## Relative gain =  0.5181853 
    ## Relative gain =  0.4759132 
    ## Relative gain =  0.5545064 
    ## Relative gain =  0.5456746 
    ## Relative gain =  0.6376138 
    ## Average gain for candidate model 7 is 0.5504182 
    ## Candidate model 8 has feature 0XXX 00XX X000 X1X1 01XX 
    ## Relative gain =  0.5818248 
    ## Relative gain =  0.5441058 
    ## Relative gain =  0.560756 
    ## Relative gain =  0.5166898 
    ## Relative gain =  0.568912 
    ## Relative gain =  0.5181853 
    ## Relative gain =  0.4759132 
    ## Relative gain =  0.5545064 
    ## Relative gain =  0.5456746 
    ## Relative gain =  0.6376138 
    ## Average gain for candidate model 8 is 0.5504182 
    ## Candidate model 9 has feature 0XXX 00XX X000 X1X1 01XX 1XXX 
    ## Relative gain =  0.5818248 
    ## Relative gain =  0.5441058 
    ## Relative gain =  0.560756 
    ## Relative gain =  0.5166898 
    ## Relative gain =  0.568912 
    ## Relative gain =  0.5181853 
    ## Relative gain =  0.4759132 
    ## Relative gain =  0.5545064 
    ## Relative gain =  0.5456746 
    ## Relative gain =  0.6376138 
    ## Average gain for candidate model 9 is 0.5504182

    ## [1] "Creating null model..."
    ## [1] "Training..."
    ## Adding Feature Number 1 
    ## ... trying feature 1 000000 with gain 0.00595447 
    ## ... trying feature 2 100000 with gain 0.0006321047 
    ## ... trying feature 3 X00000 with gain 0.0008257949 
    ## ... trying feature 4 010000 with gain 0.009099522 
    ## ... trying feature 5 110000 with gain 0.01231393 
    ## ... trying feature 6 X10000 with gain 3.838116e-05 
    ## ... trying feature 7 0X0000 with gain 0.01298478 
    ## ... trying feature 8 1X0000 with gain 0.01261542 
    ## ... trying feature 9 XX0000 with gain 0.0002814986 
    ## ... trying feature 10 001000 with gain 0.009131807 
    ## ... trying feature 11 101000 with gain 0.0012834 
    ## ... trying feature 12 X01000 with gain 0.002670501 
    ## ... trying feature 13 011000 with gain 0.01298424 
    ## ... trying feature 14 111000 with gain 0.0219412 
    ## ... trying feature 15 X11000 with gain 2.753417e-06 
    ## ... trying feature 16 0X1000 with gain 0.01966501 
    ## ... trying feature 17 1X1000 with gain 0.02297086 
    ## ... trying feature 18 XX1000 with gain 0.0003061462 
    ## ... trying feature 19 00X000 with gain 0.01487361 
    ## ... trying feature 20 10X000 with gain 0.001812476 
    ## ... trying feature 21 X0X000 with gain 0.003429181 
    ## ... trying feature 22 01X000 with gain 0.02358513 
    ## ... trying feature 23 11X000 with gain 0.03566803 
    ## ... trying feature 24 X1X000 with gain 6.737685e-06 
    ## ... trying feature 25 0XX000 with gain 0.035409 
    ## ... trying feature 26 1XX000 with gain 0.03679157 
    ## ... trying feature 27 XXX000 with gain 0.0006553792 
    ## ... trying feature 28 000100 with gain 0.006875304 
    ## ... trying feature 29 100100 with gain 0.005338571 
    ## ... trying feature 30 X00100 with gain 0.0002925832

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 010100 with gain 0.03179536 
    ## ... trying feature 32 110100 with gain 0.02110637 
    ## ... trying feature 33 X10100 with gain 0.0003318606

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 34 0X0100 with gain 0.03936886 
    ## ... trying feature 35 1X0100 with gain 0.02574982 
    ## ... trying feature 36 XX0100 with gain 0.0005650738 
    ## ... trying feature 37 001100 with gain 0.007611092 
    ## ... trying feature 38 101100 with gain 0.001101514 
    ## ... trying feature 39 X01100 with gain 0.001583709 
    ## ... trying feature 40 011100 with gain 0.03997172 
    ## ... trying feature 41 111100 with gain 0.02041156 
    ## ... trying feature 42 X11100 with gain 0.001384351 
    ## ... trying feature 43 0X1100 with gain 0.04837129 
    ## ... trying feature 44 1X1100 with gain 0.02149041 
    ## ... trying feature 45 XX1100 with gain 0.002496302

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 46 00X100 with gain 0.01450781 
    ## ... trying feature 47 10X100 with gain 0.005215868 
    ## ... trying feature 48 X0X100 with gain 0.001663861 
    ## ... trying feature 49 01X100 with gain 0.07283934 
    ## ... trying feature 50 11X100 with gain 0.04268893 
    ## ... trying feature 51 X1X100 with gain 0.001731654 
    ## ... trying feature 52 0XX100 with gain 0.09066855 
    ## ... trying feature 53 1XX100 with gain 0.04827779 
    ## ... trying feature 54 XXX100 with gain 0.003148654

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 55 000X00 with gain 0.01276031 
    ## ... trying feature 56 100X00 with gain 0.003897021 
    ## ... trying feature 57 X00X00 with gain 0.001056078 
    ## ... trying feature 58 010X00 with gain 0.03174297 
    ## ... trying feature 59 110X00 with gain 0.03347053 
    ## ... trying feature 60 X10X00 with gain 0.0002939764 
    ## ... trying feature 61 0X0X00 with gain 0.04308692 
    ## ... trying feature 62 1X0X00 with gain 0.03810951 
    ## ... trying feature 63 XX0X00 with gain 0.0008716638 
    ## ... trying feature 64 001X00 with gain 0.01626633 
    ## ... trying feature 65 101X00 with gain 0.002407389 
    ## ... trying feature 66 X01X00 with gain 0.004253125 
    ## ... trying feature 67 011X00 with gain 0.04312848 
    ## ... trying feature 68 111X00 with gain 0.04438406 
    ## ... trying feature 69 X11X00 with gain 0.0005215626 
    ## ... trying feature 70 0X1X00 with gain 0.0595023 
    ## ... trying feature 71 1X1X00 with gain 0.04694097 
    ## ... trying feature 72 XX1X00 with gain 0.00226696 
    ## ... trying feature 73 00XX00 with gain 0.02916663 
    ## ... trying feature 74 10XX00 with gain 0.006113929 
    ## ... trying feature 75 X0XX00 with gain 0.00513294 
    ## ... trying feature 76 01XX00 with gain 0.08421297 
    ## ... trying feature 77 11XX00 with gain 0.08393684 
    ## ... trying feature 78 X1XX00 with gain 0.001015672 
    ## ... trying feature 79 0XXX00 with gain 0.1187584 
    ## ... trying feature 80 1XXX00 with gain 0.09254349 
    ## ... trying feature 81 XXXX00 with gain 0.004022467 
    ## ... trying feature 82 000010 with gain 0.0003261148 
    ## ... trying feature 83 100010 with gain 0.0001711091 
    ## ... trying feature 84 X00010 with gain 0.0004970285 
    ## ... trying feature 85 010010 with gain 0.0001066929 
    ## ... trying feature 86 110010 with gain 0.0005119861 
    ## ... trying feature 87 X10010 with gain 1.996055e-05 
    ## ... trying feature 88 0X0010 with gain 0.0002088303 
    ## ... trying feature 89 1X0010 with gain 0.0003287593 
    ## ... trying feature 90 XX0010 with gain 1.754644e-06 
    ## ... trying feature 91 001010 with gain 0.0002876396 
    ## ... trying feature 92 101010 with gain 0.0003201222 
    ## ... trying feature 93 X01010 with gain 3.721835e-05 
    ## ... trying feature 94 011010 with gain 7.568296e-05 
    ## ... trying feature 95 111010 with gain 0.002225135 
    ## ... trying feature 96 X11010 with gain 0.0007623133 
    ## ... trying feature 97 0X1010 with gain 1.184992e-07 
    ## ... trying feature 98 1X1010 with gain 0.001641805 
    ## ... trying feature 99 XX1010 with gain 0.0007808513 
    ## ... trying feature 100 00X010 with gain 3.536557e-05 
    ## ... trying feature 101 10X010 with gain 0.0004915972 
    ## ... trying feature 102 X0X010 with gain 2.846614e-05 
    ## ... trying feature 103 01X010 with gain 0.0001826689 
    ## ... trying feature 104 11X010 with gain 0.002687574 
    ## ... trying feature 105 X1X010 with gain 0.0005739376 
    ## ... trying feature 106 0XX010 with gain 0.0001044153 
    ## ... trying feature 107 1XX010 with gain 0.001912766 
    ## ... trying feature 108 XXX010 with gain 0.0004284016 
    ## ... trying feature 109 000110 with gain 0.0001805374 
    ## ... trying feature 110 100110 with gain 0.0003277344 
    ## ... trying feature 111 X00110 with gain 0.0005084636 
    ## ... trying feature 112 010110 with gain 0.001615857 
    ## ... trying feature 113 110110 with gain 0.006624472 
    ## ... trying feature 114 X10110 with gain 0.0003486369 
    ## ... trying feature 115 0X0110 with gain 0.001800782 
    ## ... trying feature 116 1X0110 with gain 0.003080283 
    ## ... trying feature 117 XX0110 with gain 0.0001012322 
    ## ... trying feature 118 001110 with gain 0.0004589975 
    ## ... trying feature 119 101110 with gain 0 
    ## ... trying feature 120 X01110 with gain 0.0004589975 
    ## ... trying feature 121 011110 with gain 0.001969237 
    ## ... trying feature 122 111110 with gain 0.0009560568 
    ## ... trying feature 123 X11110 with gain 5.50761e-06 
    ## ... trying feature 124 0X1110 with gain 0.002430097 
    ## ... trying feature 125 1X1110 with gain 0.0009560568 
    ## ... trying feature 126 XX1110 with gain 6.223988e-05 
    ## ... trying feature 127 00X110 with gain 0.0006403836 
    ## ... trying feature 128 10X110 with gain 0.0003277344 
    ## ... trying feature 129 X0X110 with gain 0.000968883 
    ## ... trying feature 130 01X110 with gain 0.003591478 
    ## ... trying feature 131 11X110 with gain 0.004403355 
    ## ... trying feature 132 X1X110 with gain 0.0001030787 
    ## ... trying feature 133 0XX110 with gain 0.00424106 
    ## ... trying feature 134 1XX110 with gain 0.003399348 
    ## ... trying feature 135 XXX110 with gain 3.072871e-07 
    ## ... trying feature 136 000X10 with gain 0.0005071315 
    ## ... trying feature 137 100X10 with gain 0.0004984195 
    ## ... trying feature 138 X00X10 with gain 0.001006632 
    ## ... trying feature 139 010X10 with gain 0.0008081999 
    ## ... trying feature 140 110X10 with gain 0.003348711 
    ## ... trying feature 141 X10X10 with gain 0.0002145544 
    ## ... trying feature 142 0X0X10 with gain 0.001102593 
    ## ... trying feature 143 1X0X10 with gain 0.002171749 
    ## ... trying feature 144 XX0X10 with gain 2.636018e-05 
    ## ... trying feature 145 001X10 with gain 5.948798e-06 
    ## ... trying feature 146 101X10 with gain 0.0003201222 
    ## ... trying feature 147 X01X10 with gain 2.133041e-05 
    ## ... trying feature 148 011X10 with gain 0.0009375176 
    ## ... trying feature 149 111X10 with gain 0.0031619 
    ## ... trying feature 150 X11X10 with gain 0.0004112863 
    ## ... trying feature 151 0X1X10 with gain 0.0006845502 
    ## ... trying feature 152 1X1X10 with gain 0.002612809 
    ## ... trying feature 153 XX1X10 with gain 0.0003027751 
    ## ... trying feature 154 00XX10 with gain 6.608457e-05 
    ## ... trying feature 155 10XX10 with gain 0.0008199682 
    ## ... trying feature 156 X0XX10 with gain 0.0004333196 
    ## ... trying feature 157 01XX10 with gain 0.001758383 
    ## ... trying feature 158 11XX10 with gain 0.006423592 
    ## ... trying feature 159 X1XX10 with gain 0.0006317723 
    ## ... trying feature 160 0XXX10 with gain 0.001755373 
    ## ... trying feature 161 1XXX10 with gain 0.004812135 
    ## ... trying feature 162 XXXX10 with gain 0.0002795728 
    ## ... trying feature 163 0000X0 with gain 0.006287832 
    ## ... trying feature 164 1000X0 with gain 0.0005270362 
    ## ... trying feature 165 X000X0 with gain 0.001029371 
    ## ... trying feature 166 0100X0 with gain 0.009023823 
    ## ... trying feature 167 1100X0 with gain 0.01289041 
    ## ... trying feature 168 X100X0 with gain 2.328577e-05 
    ## ... trying feature 169 0X00X0 with gain 0.01297133 
    ## ... trying feature 170 1X00X0 with gain 0.01297356 
    ## ... trying feature 171 XX00X0 with gain 0.0002760389 
    ## ... trying feature 172 0010X0 with gain 0.007377034 
    ## ... trying feature 173 1010X0 with gain 0.000997082 
    ## ... trying feature 174 X010X0 with gain 0.00236791 
    ## ... trying feature 175 0110X0 with gain 0.01298896 
    ## ... trying feature 176 1110X0 with gain 0.0244468 
    ## ... trying feature 177 X110X0 with gain 6.740297e-05 
    ## ... trying feature 178 0X10X0 with gain 0.01902339 
    ## ... trying feature 179 1X10X0 with gain 0.02497776 
    ## ... trying feature 180 XX10X0 with gain 0.0001096036 
    ## ... trying feature 181 00X0X0 with gain 0.01306746 
    ## ... trying feature 182 10X0X0 with gain 0.001457083 
    ## ... trying feature 183 X0X0X0 with gain 0.003409133 
    ## ... trying feature 184 01X0X0 with gain 0.02353714 
    ## ... trying feature 185 11X0X0 with gain 0.03915486 
    ## ... trying feature 186 X1X0X0 with gain 1.392195e-05 
    ## ... trying feature 187 0XX0X0 with gain 0.03474743 
    ## ... trying feature 188 1XX0X0 with gain 0.03958162 
    ## ... trying feature 189 XXX0X0 with gain 0.0003901171 
    ## ... trying feature 190 0001X0 with gain 0.007063567 
    ## ... trying feature 191 1001X0 with gain 0.00404578 
    ## ... trying feature 192 X001X0 with gain 0.0004387705

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 193 0101X0 with gain 0.03338062 
    ## ... trying feature 194 1101X0 with gain 0.02491604 
    ## ... trying feature 195 X101X0 with gain 0.0001783544

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 196 0X01X0 with gain 0.04120084 
    ## ... trying feature 197 1X01X0 with gain 0.02870604 
    ## ... trying feature 198 XX01X0 with gain 0.0004327161 
    ## ... trying feature 199 0011X0 with gain 0.008065652 
    ## ... trying feature 200 1011X0 with gain 0.001101514 
    ## ... trying feature 201 X011X0 with gain 0.001825491 
    ## ... trying feature 202 0111X0 with gain 0.04216073 
    ## ... trying feature 203 1111X0 with gain 0.02151514 
    ## ... trying feature 204 X111X0 with gain 0.001368048 
    ## ... trying feature 205 0X11X0 with gain 0.05112541 
    ## ... trying feature 206 1X11X0 with gain 0.02263602 
    ## ... trying feature 207 XX11X0 with gain 0.002586385

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 208 00X1X0 with gain 0.01516784 
    ## ... trying feature 209 10X1X0 with gain 0.004530524 
    ## ... trying feature 210 X0X1X0 with gain 0.002080344 
    ## ... trying feature 211 01X1X0 with gain 0.07672718 
    ## ... trying feature 212 11X1X0 with gain 0.04707625 
    ## ... trying feature 213 X1X1X0 with gain 0.001453974 
    ## ... trying feature 214 0XX1X0 with gain 0.09554899 
    ## ... trying feature 215 1XX1X0 with gain 0.05201857 
    ## ... trying feature 216 XXX1X0 with gain 0.003003942

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 217 000XX0 with gain 0.01329129 
    ## ... trying feature 218 100XX0 with gain 0.003186182 
    ## ... trying feature 219 X00XX0 with gain 0.001412828 
    ## ... trying feature 220 010XX0 with gain 0.03262341 
    ## ... trying feature 221 110XX0 with gain 0.03676351 
    ## ... trying feature 222 X10XX0 with gain 0.0001643348 
    ## ... trying feature 223 0X0XX0 with gain 0.04436258 
    ## ... trying feature 224 1X0XX0 with gain 0.04047865 
    ## ... trying feature 225 XX0XX0 with gain 0.0007543335 
    ## ... trying feature 226 001XX0 with gain 0.01451176 
    ## ... trying feature 227 101XX0 with gain 0.002086579 
    ## ... trying feature 228 X01XX0 with gain 0.004186492 
    ## ... trying feature 229 011XX0 with gain 0.04452856 
    ## ... trying feature 230 111XX0 with gain 0.04838923 
    ## ... trying feature 231 X11XX0 with gain 0.0003040939 
    ## ... trying feature 232 0X1XX0 with gain 0.06042571 
    ## ... trying feature 233 1X1XX0 with gain 0.05051462 
    ## ... trying feature 234 XX1XX0 with gain 0.001813129 
    ## ... trying feature 235 00XXX0 with gain 0.02750581 
    ## ... trying feature 236 10XXX0 with gain 0.005161783 
    ## ... trying feature 237 X0XXX0 with gain 0.005598932 
    ## ... trying feature 238 01XXX0 with gain 0.08707677 
    ## ... trying feature 239 11XXX0 with gain 0.09277066 
    ## ... trying feature 240 X1XXX0 with gain 0.0005897345 
    ## ... trying feature 241 0XXXX0 with gain 0.1221285 
    ## ... trying feature 242 1XXXX0 with gain 0.1004601 
    ## ... trying feature 243 XXXXX0 with gain 0.003374084 
    ## ... trying feature 244 000001 with gain 0.002828739 
    ## ... trying feature 245 100001 with gain 0.00316731 
    ## ... trying feature 246 X00001 with gain 1.415541e-05 
    ## ... trying feature 247 010001 with gain 0.005126497 
    ## ... trying feature 248 110001 with gain 0.0461698 
    ## ... trying feature 249 X10001 with gain 0.006129532 
    ## ... trying feature 250 0X0001 with gain 0.007336431 
    ## ... trying feature 251 1X0001 with gain 0.04935574 
    ## ... trying feature 252 XX0001 with gain 0.005265886 
    ## ... trying feature 253 001001 with gain 0.003387482 
    ## ... trying feature 254 101001 with gain 0.006223528 
    ## ... trying feature 255 X01001 with gain 1.214151e-05 
    ## ... trying feature 256 011001 with gain 0.01358793 
    ## ... trying feature 257 111001 with gain 0.02639612 
    ## ... trying feature 258 X11001 with gain 0.0001941971 
    ## ... trying feature 259 0X1001 with gain 0.01730896 
    ## ... trying feature 260 1X1001 with gain 0.03281515 
    ## ... trying feature 261 XX1001 with gain 0.0002128828 
    ## ... trying feature 262 00X001 with gain 0.00626183 
    ## ... trying feature 263 10X001 with gain 0.00947834 
    ## ... trying feature 264 X0X001 with gain 6.00914e-08 
    ## ... trying feature 265 01X001 with gain 0.02009627 
    ## ... trying feature 266 11X001 with gain 0.07616728 
    ## ... trying feature 267 X1X001 with gain 0.004781446 
    ## ... trying feature 268 0XX001 with gain 0.02715136 
    ## ... trying feature 269 1XX001 with gain 0.08773535 
    ## ... trying feature 270 XXX001 with gain 0.004496242 
    ## ... trying feature 271 000101 with gain 0.005591904 
    ## ... trying feature 272 100101 with gain 0.002620975 
    ## ... trying feature 273 X00101 with gain 4.061894e-05

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 274 010101 with gain 0.04036265 
    ## ... trying feature 275 110101 with gain 0.03055179 
    ## ... trying feature 276 X10101 with gain 8.085125e-05

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 277 0X0101 with gain 0.04636173 
    ## ... trying feature 278 1X0101 with gain 0.03207132 
    ## ... trying feature 279 XX0101 with gain 0.0001176252 
    ## ... trying feature 280 001101 with gain 0.01072272 
    ## ... trying feature 281 101101 with gain 4.258749e-11 
    ## ... trying feature 282 X01101 with gain 0.006289255 
    ## ... trying feature 283 011101 with gain 0.05698327 
    ## ... trying feature 284 111101 with gain 0.05615466 
    ## ... trying feature 285 X11101 with gain 4.263451e-05 
    ## ... trying feature 286 0X1101 with gain 0.06867078 
    ## ... trying feature 287 1X1101 with gain 0.0521364 
    ## ... trying feature 288 XX1101 with gain 0.0004328461

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 289 00X101 with gain 0.0163432 
    ## ... trying feature 290 10X101 with gain 0.001562746 
    ## ... trying feature 291 X0X101 with gain 0.003761771 
    ## ... trying feature 292 01X101 with gain 0.1004098 
    ## ... trying feature 293 11X101 with gain 0.0882918 
    ## ... trying feature 294 X1X101 with gain 3.944411e-07 
    ## ... trying feature 295 0XX101 with gain 0.119179 
    ## ... trying feature 296 1XX101 with gain 0.08747859 
    ## ... trying feature 297 XXX101 with gain 0.0005910175 
    ## ... trying feature 298 000X01 with gain 0.007028363 
    ## ... trying feature 299 100X01 with gain 0.005395983 
    ## ... trying feature 300 X00X01 with gain 4.815698e-05 
    ## ... trying feature 301 010X01 with gain 0.02809573 
    ## ... trying feature 302 110X01 with gain 0.08050271 
    ## ... trying feature 303 X10X01 with gain 0.003647212 
    ## ... trying feature 304 0X0X01 with gain 0.03559699 
    ## ... trying feature 305 1X0X01 with gain 0.08602642 
    ## ... trying feature 306 XX0X01 with gain 0.002986527 
    ## ... trying feature 307 001X01 with gain 0.01148629 
    ## ... trying feature 308 101X01 with gain 0.00418772 
    ## ... trying feature 309 X01X01 with gain 0.001981915 
    ## ... trying feature 310 011X01 with gain 0.05584664 
    ## ... trying feature 311 111X01 with gain 0.08467548 
    ## ... trying feature 312 X11X01 with gain 0.0002592536 
    ## ... trying feature 313 0X1X01 with gain 0.06966813 
    ## ... trying feature 314 1X1X01 with gain 0.09089926 
    ## ... trying feature 315 XX1X01 with gain 5.893928e-06 
    ## ... trying feature 316 00XX01 with gain 0.01887102 
    ## ... trying feature 317 10XX01 with gain 0.009615596 
    ## ... trying feature 318 X0XX01 with gain 0.001476917 
    ## ... trying feature 319 01XX01 with gain 0.09774632 
    ## ... trying feature 320 11XX01 with gain 0.1906162 
    ## ... trying feature 321 X1XX01 with gain 0.00398685 
    ## ... trying feature 322 0XXX01 with gain 0.1264517 
    ## ... trying feature 323 1XXX01 with gain 0.2072469 
    ## ... trying feature 324 XXXX01 with gain 0.001926346 
    ## ... trying feature 325 000011 with gain 0.0004730208 
    ## ... trying feature 326 100011 with gain 0.002236593 
    ## ... trying feature 327 X00011 with gain 0.0001772195 
    ## ... trying feature 328 010011 with gain 2.498936e-05 
    ## ... trying feature 329 110011 with gain 0.007414426 
    ## ... trying feature 330 X10011 with gain 0.002918196 
    ## ... trying feature 331 0X0011 with gain 0.0001093641 
    ## ... trying feature 332 1X0011 with gain 0.009047666 
    ## ... trying feature 333 XX0011 with gain 0.003087881 
    ## ... trying feature 334 001011 with gain 0.0006851177 
    ## ... trying feature 335 101011 with gain 0 
    ## ... trying feature 336 X01011 with gain 0.0006851177 
    ## ... trying feature 337 011011 with gain 1.713863e-05 
    ## ... trying feature 338 111011 with gain 0.002172913 
    ## ... trying feature 339 X11011 with gain 0.0004083535 
    ## ... trying feature 340 0X1011 with gain 9.093232e-06 
    ## ... trying feature 341 1X1011 with gain 0.002172913 
    ## ... trying feature 342 XX1011 with gain 0.0001654427 
    ## ... trying feature 343 00X011 with gain 0.001158861 
    ## ... trying feature 344 10X011 with gain 0.002236593 
    ## ... trying feature 345 X0X011 with gain 2.102805e-05 
    ## ... trying feature 346 01X011 with gain 1.056527e-09 
    ## ... trying feature 347 11X011 with gain 0.009599601 
    ## ... trying feature 348 X1X011 with gain 0.002713134 
    ## ... trying feature 349 0XX011 with gain 7.944559e-05 
    ## ... trying feature 350 1XX011 with gain 0.01126354 
    ## ... trying feature 351 XXX011 with gain 0.002358419 
    ## ... trying feature 352 000111 with gain 0.0006133789 
    ## ... trying feature 353 X00111 with gain 0.0006133789 
    ## ... trying feature 354 010111 with gain 0.001308673 
    ## ... trying feature 355 110111 with gain 0.000324651 
    ## ... trying feature 356 X10111 with gain 0.0001792104 
    ## ... trying feature 357 0X0111 with gain 0.001924589 
    ## ... trying feature 358 1X0111 with gain 0.000324651 
    ## ... trying feature 359 XX0111 with gain 0.0004938249 
    ## ... trying feature 360 001111 with gain 0.0001645617 
    ## ... trying feature 361 101111 with gain 0.0007533806 
    ## ... trying feature 362 X01111 with gain 0.0003448314 
    ## ... trying feature 363 011111 with gain 0.002866392 
    ## ... trying feature 364 111111 with gain 0.003891657 
    ## ... trying feature 365 X11111 with gain 0.0001108372 
    ## ... trying feature 366 0X1111 with gain 0.003030458 
    ## ... trying feature 367 1X1111 with gain 0.00465664 
    ## ... trying feature 368 XX1111 with gain 0.0002621624 
    ## ... trying feature 369 00X111 with gain 0.0007780198 
    ## ... trying feature 370 10X111 with gain 0.0007533806 
    ## ... trying feature 371 X0X111 with gain 1.65767e-08 
    ## ... trying feature 372 01X111 with gain 0.004181797 
    ## ... trying feature 373 11X111 with gain 0.004013044 
    ## ... trying feature 374 X1X111 with gain 5.533413e-06 
    ## ... trying feature 375 0XX111 with gain 0.004968575 
    ## ... trying feature 376 1XX111 with gain 0.004777374 
    ## ... trying feature 377 XXX111 with gain 4.520023e-06 
    ## ... trying feature 378 000X11 with gain 0.001088052 
    ## ... trying feature 379 100X11 with gain 0.002236593 
    ## ... trying feature 380 X00X11 with gain 9.078836e-06 
    ## ... trying feature 381 010X11 with gain 0.0003650093 
    ## ... trying feature 382 110X11 with gain 0.007373547 
    ## ... trying feature 383 X10X11 with gain 0.001839333 
    ## ... trying feature 384 0X0X11 with gain 0.0008423708 
    ## ... trying feature 385 1X0X11 with gain 0.00890044 
    ## ... trying feature 386 XX0X11 with gain 0.001537228 
    ## ... trying feature 387 001X11 with gain 0.0008502709 
    ## ... trying feature 388 101X11 with gain 0.0007533806 
    ## ... trying feature 389 X01X11 with gain 3.405298e-06 
    ## ... trying feature 390 011X11 with gain 0.0004878872 
    ## ... trying feature 391 111X11 with gain 0.006000878 
    ## ... trying feature 392 X11X11 with gain 0.0004975725 
    ## ... trying feature 393 0X1X11 with gain 0.0008156055 
    ## ... trying feature 394 1X1X11 with gain 0.006763676 
    ## ... trying feature 395 XX1X11 with gain 0.0004250461 
    ## ... trying feature 396 00XX11 with gain 0.00194113 
    ## ... trying feature 397 10XX11 with gain 0.002377547 
    ## ... trying feature 398 X0XX11 with gain 1.188346e-05 
    ## ... trying feature 399 01XX11 with gain 0.000842781 
    ## ... trying feature 400 11XX11 with gain 0.01347253 
    ## ... trying feature 401 X1XX11 with gain 0.002018214 
    ## ... trying feature 402 0XXX11 with gain 0.001633669 
    ## ... trying feature 403 1XXX11 with gain 0.01581927 
    ## ... trying feature 404 XXXX11 with gain 0.001726138 
    ## ... trying feature 405 0000X1 with gain 0.003159031 
    ## ... trying feature 406 1000X1 with gain 0.004131078 
    ## ... trying feature 407 X000X1 with gain 3.796379e-07 
    ## ... trying feature 408 0100X1 with gain 0.005036452 
    ## ... trying feature 409 1100X1 with gain 0.05329364 
    ## ... trying feature 410 X100X1 with gain 0.00822388 
    ## ... trying feature 411 0X00X1 with gain 0.007428359 
    ## ... trying feature 412 1X00X1 with gain 0.05721849 
    ## ... trying feature 413 XX00X1 with gain 0.007325199 
    ## ... trying feature 414 0010X1 with gain 0.00383951 
    ## ... trying feature 415 1010X1 with gain 0.006223528 
    ## ... trying feature 416 X010X1 with gain 1.225387e-07 
    ## ... trying feature 417 0110X1 with gain 0.01269663 
    ## ... trying feature 418 1110X1 with gain 0.02794508 
    ## ... trying feature 419 X110X1 with gain 0.0003362953 
    ## ... trying feature 420 0X10X1 with gain 0.01670646 
    ## ... trying feature 421 1X10X1 with gain 0.03444208 
    ## ... trying feature 422 XX10X1 with gain 0.0002998252 
    ## ... trying feature 423 00X0X1 with gain 0.007063331 
    ## ... trying feature 424 10X0X1 with gain 0.01053909 
    ## ... trying feature 425 X0X0X1 with gain 4.538774e-07 
    ## ... trying feature 426 01X0X1 with gain 0.0190775 
    ## ... trying feature 427 11X0X1 with gain 0.08536505 
    ## ... trying feature 428 X1X0X1 with gain 0.006792556 
    ## ... trying feature 429 0XX0X1 with gain 0.02669544 
    ## ... trying feature 430 1XX0X1 with gain 0.09810492 
    ## ... trying feature 431 XXX0X1 with gain 0.006383979 
    ## ... trying feature 432 0001X1 with gain 0.006213437 
    ## ... trying feature 433 1001X1 with gain 0.002620975 
    ## ... trying feature 434 X001X1 with gain 0.0001197543

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 435 0101X1 with gain 0.04181096 
    ## ... trying feature 436 1101X1 with gain 0.03085434 
    ## ... trying feature 437 X101X1 with gain 0.0001259396

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 438 0X01X1 with gain 0.04855329 
    ## ... trying feature 439 1X01X1 with gain 0.03241763 
    ## ... trying feature 440 XX01X1 with gain 0.0002179545 
    ## ... trying feature 441 0011X1 with gain 0.01089015 
    ## ... trying feature 442 1011X1 with gain 9.009838e-05 
    ## ... trying feature 443 X011X1 with gain 0.005180463 
    ## ... trying feature 444 0111X1 with gain 0.06019132 
    ## ... trying feature 445 1111X1 with gain 0.05993592 
    ## ... trying feature 446 X111X1 with gain 7.966331e-05 
    ## ... trying feature 447 0X11X1 with gain 0.07219718 
    ## ... trying feature 448 1X11X1 with gain 0.05682 
    ## ... trying feature 449 XX11X1 with gain 0.0002709558

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 450 00X1X1 with gain 0.01714838 
    ## ... trying feature 451 10X1X1 with gain 0.001999942 
    ## ... trying feature 452 X0X1X1 with gain 0.003573011 
    ## ... trying feature 453 01X1X1 with gain 0.1056399 
    ## ... trying feature 454 11X1X1 with gain 0.09300239 
    ## ... trying feature 455 X1X1X1 with gain 6.721379e-09 
    ## ... trying feature 456 0XX1X1 with gain 0.1258395 
    ## ... trying feature 457 1XX1X1 with gain 0.09326737 
    ## ... trying feature 458 XXX1X1 with gain 0.000551899 
    ## ... trying feature 459 000XX1 with gain 0.00793323 
    ## ... trying feature 460 100XX1 with gain 0.006270951 
    ## ... trying feature 461 X00XX1 with gain 5.560601e-05 
    ## ... trying feature 462 010XX1 with gain 0.02845986 
    ## ... trying feature 463 110XX1 with gain 0.08805821 
    ## ... trying feature 464 X10XX1 with gain 0.004915711 
    ## ... trying feature 465 0X0XX1 with gain 0.03695242 
    ## ... trying feature 466 1X0XX1 with gain 0.09448208 
    ## ... trying feature 467 XX0XX1 with gain 0.004089689 
    ## ... trying feature 468 001XX1 with gain 0.01220533 
    ## ... trying feature 469 101XX1 with gain 0.004757511 
    ## ... trying feature 470 X01XX1 with gain 0.001945875 
    ## ... trying feature 471 011XX1 with gain 0.05613928 
    ## ... trying feature 472 111XX1 with gain 0.09068931 
    ## ... trying feature 473 X11XX1 with gain 0.0004648156 
    ## ... trying feature 474 0X1XX1 with gain 0.07100048 
    ## ... trying feature 475 1X1XX1 with gain 0.09696557 
    ## ... trying feature 476 XX1XX1 with gain 8.030969e-06 
    ## ... trying feature 477 00XXX1 with gain 0.02049892 
    ## ... trying feature 478 10XXX1 with gain 0.01106287 
    ## ... trying feature 479 X0XXX1 with gain 0.001464857 
    ## ... trying feature 480 01XXX1 with gain 0.0995163 
    ## ... trying feature 481 11XXX1 with gain 0.2095255 
    ## ... trying feature 482 X1XXX1 with gain 0.005957699 
    ## ... trying feature 483 0XXXX1 with gain 0.1314633 
    ## ... trying feature 484 1XXXX1 with gain 0.2280939 
    ## ... trying feature 485 XXXXX1 with gain 0.003374084 
    ## ... trying feature 486 00000X with gain 0.007421 
    ## ... trying feature 487 10000X with gain 0.003419684 
    ## ... trying feature 488 X0000X with gain 0.0004596817 
    ## ... trying feature 489 01000X with gain 0.01434392 
    ## ... trying feature 490 11000X with gain 0.0588161 
    ## ... trying feature 491 X1000X with gain 0.003793614 
    ## ... trying feature 492 0X000X with gain 0.0204228 
    ## ... trying feature 493 1X000X with gain 0.06170753 
    ## ... trying feature 494 XX000X with gain 0.002486718 
    ## ... trying feature 495 00100X with gain 0.01150591 
    ## ... trying feature 496 10100X with gain 0.006986446 
    ## ... trying feature 497 X0100X with gain 0.001017259 
    ## ... trying feature 498 01100X with gain 0.02890016 
    ## ... trying feature 499 11100X with gain 0.05205339 
    ## ... trying feature 500 X1100X with gain 0.000157849 
    ## ... trying feature 501 0X100X with gain 0.04075297 
    ## ... trying feature 502 1X100X with gain 0.06083436 
    ## ... trying feature 503 XX100X with gain 1.734405e-06 
    ## ... trying feature 504 00X00X with gain 0.01928513 
    ## ... trying feature 505 10X00X with gain 0.01011841 
    ## ... trying feature 506 X0X00X with gain 0.001504226 
    ## ... trying feature 507 01X00X with gain 0.05313869 
    ## ... trying feature 508 11X00X with gain 0.1271058 
    ## ... trying feature 509 X1X00X with gain 0.003805619 
    ## ... trying feature 510 0XX00X with gain 0.07796898 
    ## ... trying feature 511 1XX00X with gain 0.143645 
    ## ... trying feature 512 XXX00X with gain 0.001741568 
    ## ... trying feature 513 00010X with gain 0.01257989 
    ## ... trying feature 514 10010X with gain 0.006585732 
    ## ... trying feature 515 X0010X with gain 0.0002669863

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 516 01010X with gain 0.07463995 
    ## ... trying feature 517 11010X with gain 0.05461446 
    ## ... trying feature 518 X1010X with gain 0.000385827

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 519 0X010X with gain 0.08904688 
    ## ... trying feature 520 1X010X with gain 0.06045788 
    ## ... trying feature 521 XX010X with gain 0.0006206906 
    ## ... trying feature 522 00110X with gain 0.01859566 
    ## ... trying feature 523 10110X with gain 0.000561122 
    ## ... trying feature 524 X0110X with gain 0.007260939 
    ## ... trying feature 525 01110X with gain 0.1017191 
    ## ... trying feature 526 11110X with gain 0.08002724 
    ## ... trying feature 527 X1110X with gain 0.0004154128 
    ## ... trying feature 528 0X110X with gain 0.123082 
    ## ... trying feature 529 1X110X with gain 0.07679535 
    ## ... trying feature 530 XX110X with gain 0.002618393

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 531 00X10X with gain 0.03158328 
    ## ... trying feature 532 10X10X with gain 0.005784608 
    ## ... trying feature 533 X0X10X with gain 0.005406704 
    ## ... trying feature 534 01X10X with gain 0.1862235 
    ## ... trying feature 535 11X10X with gain 0.1452537 
    ## ... trying feature 536 X1X10X with gain 0.0009613321 
    ## ... trying feature 537 0XX10X with gain 0.2289952 
    ## ... trying feature 538 1XX10X with gain 0.1505121 
    ## ... trying feature 539 XXX10X with gain 0.003852103 
    ## ... trying feature 540 000X0X with gain 0.01842987 
    ## ... trying feature 541 100X0X with gain 0.009236548 
    ## ... trying feature 542 X00X0X with gain 0.0007297378 
    ## ... trying feature 543 010X0X with gain 0.06632699 
    ## ... trying feature 544 110X0X with gain 0.1210319 
    ## ... trying feature 545 X10X0X with gain 0.001550485 
    ## ... trying feature 546 0X0X0X with gain 0.08699536 
    ## ... trying feature 547 1X0X0X with gain 0.1326019 
    ## ... trying feature 548 XX0X0X with gain 0.0006485939 
    ## ... trying feature 549 001X0X with gain 0.02758882 
    ## ... trying feature 550 101X0X with gain 0.006687338 
    ## ... trying feature 551 X01X0X with gain 0.006104787 
    ## ... trying feature 552 011X0X with gain 0.1179351 
    ## ... trying feature 553 111X0X with gain 0.1478958 
    ## ... trying feature 554 X11X0X with gain 1.882211e-05 
    ## ... trying feature 555 0X1X0X with gain 0.1593705 
    ## ... trying feature 556 1X1X0X with gain 0.1603083 
    ## ... trying feature 557 XX1X0X with gain 0.001901505 
    ## ... trying feature 558 00XX0X with gain 0.04798033 
    ## ... trying feature 559 10XX0X with gain 0.01582262 
    ## ... trying feature 560 X0XX0X with gain 0.006240518 
    ## ... trying feature 561 01XX0X with gain 0.2696278 
    ## ... trying feature 562 11XX0X with gain 0.3707707 
    ## ... trying feature 563 X1XX0X with gain 0.001884355 
    ## ... trying feature 564 0XXX0X with gain 0.4251183 
    ## ... trying feature 565 1XXX0X with gain 0.4265581 
    ## ... trying feature 566 XXXX0X with gain 0.001814422 
    ## ... trying feature 567 00001X with gain 0.000799451 
    ## ... trying feature 568 10001X with gain 0.0007725866 
    ## ... trying feature 569 X0001X with gain 2.142355e-07 
    ## ... trying feature 570 01001X with gain 0.0001120031 
    ## ... trying feature 571 11001X with gain 0.007093639 
    ## ... trying feature 572 X1001X with gain 0.002101762 
    ## ... trying feature 573 0X001X with gain 0.0003036359 
    ## ... trying feature 574 1X001X with gain 0.007864799 
    ## ... trying feature 575 XX001X with gain 0.001906211 
    ## ... trying feature 576 00101X with gain 7.930355e-06 
    ## ... trying feature 577 10101X with gain 0.0003201222 
    ## ... trying feature 578 X0101X with gain 8.019717e-05 
    ## ... trying feature 579 01101X with gain 2.879337e-06 
    ## ... trying feature 580 11101X with gain 0.003978179 
    ## ... trying feature 581 X1101X with gain 0.001154321 
    ## ... trying feature 582 0X101X with gain 6.886139e-06 
    ## ... trying feature 583 1X101X with gain 0.003202723 
    ## ... trying feature 584 XX101X with gain 0.0008456541 
    ## ... trying feature 585 00X01X with gain 0.0002766826 
    ## ... trying feature 586 10X01X with gain 0.0001597794 
    ## ... trying feature 587 X0X01X with gain 4.928108e-05 
    ## ... trying feature 588 01X01X with gain 6.950646e-05 
    ## ... trying feature 589 11X01X with gain 0.01112726 
    ## ... trying feature 590 X1X01X with gain 0.003096739 
    ## ... trying feature 591 0XX01X with gain 0.000181413 
    ## ... trying feature 592 1XX01X with gain 0.01090788 
    ## ... trying feature 593 XXX01X with gain 0.002586131 
    ## ... trying feature 594 00011X with gain 0.0007937193 
    ## ... trying feature 595 10011X with gain 0.0003277344 
    ## ... trying feature 596 X0011X with gain 0.001121348 
    ## ... trying feature 597 01011X with gain 0.002935631 
    ## ... trying feature 598 11011X with gain 0.004700667 
    ## ... trying feature 599 X1011X with gain 3.50023e-05 
    ## ... trying feature 600 0X011X with gain 0.003739417 
    ## ... trying feature 601 1X011X with gain 0.003048256 
    ## ... trying feature 602 XX011X with gain 4.577828e-05 
    ## ... trying feature 603 00111X with gain 0.0006238203 
    ## ... trying feature 604 10111X with gain 0.0007533806 
    ## ... trying feature 605 X0111X with gain 1.258796e-05 
    ## ... trying feature 606 01111X with gain 0.004856975 
    ## ... trying feature 607 11111X with gain 0.0044181 
    ## ... trying feature 608 X1111X with gain 4.256921e-05 
    ## ... trying feature 609 0X111X with gain 0.005486218 
    ## ... trying feature 610 1X111X with gain 0.005167362 
    ## ... trying feature 611 XX111X with gain 5.404588e-05 
    ## ... trying feature 612 00X11X with gain 0.001418246 
    ## ... trying feature 613 10X11X with gain 0.0001511941 
    ## ... trying feature 614 X0X11X with gain 0.0002990641 
    ## ... trying feature 615 01X11X with gain 0.007831978 
    ## ... trying feature 616 11X11X with gain 0.008496837 
    ## ... trying feature 617 X1X11X with gain 7.745864e-05 
    ## ... trying feature 618 0XX11X with gain 0.009286718 
    ## ... trying feature 619 1XX11X with gain 0.008216052 
    ## ... trying feature 620 XXX11X with gain 3.717935e-06 
    ## ... trying feature 621 000X1X with gain 0.001598223 
    ## ... trying feature 622 100X1X with gain 0.0001542004 
    ## ... trying feature 623 X00X1X with gain 0.0003888186 
    ## ... trying feature 624 010X1X with gain 0.001119711 
    ## ... trying feature 625 110X1X with gain 0.01069427 
    ## ... trying feature 626 X10X1X with gain 0.00178416 
    ## ... trying feature 627 0X0X1X with gain 0.001935441 
    ## ... trying feature 628 1X0X1X with gain 0.01032622 
    ## ... trying feature 629 XX0X1X with gain 0.001111169 
    ## ... trying feature 630 001X1X with gain 0.0001959933 
    ## ... trying feature 631 101X1X with gain 0.0001557639 
    ## ... trying feature 632 X01X1X with gain 2.120648e-05 
    ## ... trying feature 633 011X1X with gain 0.001277071 
    ## ... trying feature 634 111X1X with gain 0.008474245 
    ## ... trying feature 635 X11X1X with gain 0.000913999 
    ## ... trying feature 636 0X1X1X with gain 0.00148348 
    ## ... trying feature 637 1X1X1X with gain 0.008394246 
    ## ... trying feature 638 XX1X1X with gain 0.0007351735 
    ## ... trying feature 639 00XX1X with gain 0.00115963 
    ## ... trying feature 640 10XX1X with gain 0.0003114768 
    ## ... trying feature 641 X0XX1X with gain 0.0002727013 
    ## ... trying feature 642 01XX1X with gain 0.002418979 
    ## ... trying feature 643 11XX1X with gain 0.01931317 
    ## ... trying feature 644 X1XX1X with gain 0.002584144 
    ## ... trying feature 645 0XXX1X with gain 0.003400347 
    ## ... trying feature 646 1XXX1X with gain 0.01893575 
    ## ... trying feature 647 XXXX1X with gain 0.001814422 
    ## ... trying feature 648 0000XX with gain 0.008094303 
    ## ... trying feature 649 1000XX with gain 0.003967195 
    ## ... trying feature 650 X000XX with gain 0.0004442908 
    ## ... trying feature 651 0100XX with gain 0.01426889 
    ## ... trying feature 652 1100XX with gain 0.06620202 
    ## ... trying feature 653 X100XX with gain 0.005358227 
    ## ... trying feature 654 0X00XX with gain 0.02076383 
    ## ... trying feature 655 1X00XX with gain 0.06960542 
    ## ... trying feature 656 XX00XX with gain 0.003757824 
    ## ... trying feature 657 0010XX with gain 0.01097593 
    ## ... trying feature 658 1010XX with gain 0.006467716 
    ## ... trying feature 659 X010XX with gain 0.001099754 
    ## ... trying feature 660 0110XX with gain 0.02827595 
    ## ... trying feature 661 1110XX with gain 0.05625678 
    ## ... trying feature 662 X110XX with gain 0.0004485852 
    ## ... trying feature 663 0X10XX with gain 0.0398331 
    ## ... trying feature 664 1X10XX with gain 0.06437505 
    ## ... trying feature 665 XX10XX with gain 3.971412e-05 
    ## ... trying feature 666 00X0XX with gain 0.01930609 
    ## ... trying feature 667 10X0XX with gain 0.01028332 
    ## ... trying feature 668 X0X0XX with gain 0.001563344 
    ## ... trying feature 669 01X0XX with gain 0.05266863 
    ## ... trying feature 670 11X0XX with gain 0.1410593 
    ## ... trying feature 671 X1X0XX with gain 0.006530924 
    ## ... trying feature 672 0XX0XX with gain 0.07831176 
    ## ... trying feature 673 1XX0XX with gain 0.157712 
    ## ... trying feature 674 XXX0XX with gain 0.003691735 
    ## ... trying feature 675 0001XX with gain 0.01340359 
    ## ... trying feature 676 1001XX with gain 0.005917642 
    ## ... trying feature 677 X001XX with gain 0.0004988166

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 678 0101XX with gain 0.07755994 
    ## ... trying feature 679 1101XX with gain 0.0591523 
    ## ... trying feature 680 X101XX with gain 0.0003208026

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 681 0X01XX with gain 0.09288305 
    ## ... trying feature 682 1X01XX with gain 0.06404574 
    ## ... trying feature 683 XX01XX with gain 0.000665944 
    ## ... trying feature 684 0011XX with gain 0.01924064 
    ## ... trying feature 685 1011XX with gain 0.0008874952 
    ## ... trying feature 686 X011XX with gain 0.006764796 
    ## ... trying feature 687 0111XX with gain 0.1077654 
    ## ... trying feature 688 1111XX with gain 0.08512768 
    ## ... trying feature 689 X111XX with gain 0.0003400195 
    ## ... trying feature 690 0X11XX with gain 0.1299718 
    ## ... trying feature 691 1X11XX with gain 0.08301036 
    ## ... trying feature 692 XX11XX with gain 0.002357388

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 693 00X1XX with gain 0.03312315 
    ## ... trying feature 694 10X1XX with gain 0.005925008 
    ## ... trying feature 695 X0X1XX with gain 0.005755309 
    ## ... trying feature 696 01X1XX with gain 0.196599 
    ## ... trying feature 697 11X1XX with gain 0.1561056 
    ## ... trying feature 698 X1X1XX with gain 0.0007984192 
    ## ... trying feature 699 0XX1XX with gain 0.242633 
    ## ... trying feature 700 1XX1XX with gain 0.1622458 
    ## ... trying feature 701 XXX1XX with gain 0.003691735 
    ## ... trying feature 702 000XXX with gain 0.01985334 
    ## ... trying feature 703 100XXX with gain 0.00938012 
    ## ... trying feature 704 X00XXX with gain 0.0009426295 
    ## ... trying feature 705 010XXX with gain 0.06819364 
    ## ... trying feature 706 110XXX with gain 0.1335298 
    ## ... trying feature 707 X10XXX with gain 0.002601366 
    ## ... trying feature 708 0X0XXX with gain 0.0907555 
    ## ... trying feature 709 1X0XXX with gain 0.1454981 
    ## ... trying feature 710 XX0XXX with gain 0.001236243 
    ## ... trying feature 711 001XXX with gain 0.02725362 
    ## ... trying feature 712 101XXX with gain 0.006844669 
    ## ... trying feature 713 X01XXX with gain 0.006037411 
    ## ... trying feature 714 011XXX with gain 0.1216003 
    ## ... trying feature 715 111XXX with gain 0.1602744 
    ## ... trying feature 716 X11XXX with gain 2.571202e-05 
    ## ... trying feature 717 0X1XXX with gain 0.1646611 
    ## ... trying feature 718 1X1XXX with gain 0.1722823 
    ## ... trying feature 719 XX1XXX with gain 0.001236243 
    ## ... trying feature 720 00XXXX with gain 0.04900666 
    ## ... trying feature 721 10XXXX with gain 0.01618224 
    ## ... trying feature 722 X0XXXX with gain 0.006585601 
    ## ... trying feature 723 01XXXX with gain 0.2884186 
    ## ... trying feature 724 11XXXX with gain 0.4219042 
    ## ... trying feature 725 X1XXXX with gain 0.006585601 
    ## ... trying feature 726 0XXXXX with gain 0.4855356 
    ## ... trying feature 727 1XXXXX with gain 0.4855356 
    ## ... Using feature 726 0XXXXX 
    ## Adding Feature Number 2 
    ## ... trying feature 1 000000 with gain 0.4875369 
    ## ... trying feature 2 100000 with gain 0.4880758 
    ## ... trying feature 3 X00000 with gain 0.4896408 
    ## ... trying feature 4 010000 with gain 0.48665 
    ## ... trying feature 5 110000 with gain 0.4864764 
    ## ... trying feature 6 X10000 with gain 0.4855379 
    ## ... trying feature 7 0X0000 with gain 0.4859465 
    ## ... trying feature 8 1X0000 with gain 0.4880876 
    ## ... trying feature 9 XX0000 with gain 0.486088 
    ## ... trying feature 10 001000 with gain 0.4878973 
    ## ... trying feature 11 101000 with gain 0.4876502 
    ## ... trying feature 12 X01000 with gain 0.4900192 
    ## ... trying feature 13 011000 with gain 0.4899522 
    ## ... trying feature 14 111000 with gain 0.4871846 
    ## ... trying feature 15 X11000 with gain 0.4858008 
    ## ... trying feature 16 0X1000 with gain 0.4874992 
    ## ... trying feature 17 1X1000 with gain 0.488562 
    ## ... trying feature 18 XX1000 with gain 0.4856286 
    ## ... trying feature 19 00X000 with gain 0.4896007 
    ## ... trying feature 20 10X000 with gain 0.4899209 
    ## ... trying feature 21 X0X000 with gain 0.4937454 
    ## ... trying feature 22 01X000 with gain 0.4916104 
    ## ... trying feature 23 11X000 with gain 0.4884044 
    ## ... trying feature 24 X1X000 with gain 0.4857466 
    ## ... trying feature 25 0XX000 with gain 0.4881677 
    ## ... trying feature 26 1XX000 with gain 0.4917413 
    ## ... trying feature 27 XXX000 with gain 0.4860877 
    ## ... trying feature 28 000100 with gain 0.4874244 
    ## ... trying feature 29 100100 with gain 0.4855409 
    ## ... trying feature 30 X00100 with gain 0.4862527

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 010100 with gain 0.4953824 
    ## ... trying feature 32 110100 with gain 0.4859715 
    ## ... trying feature 33 X10100 with gain 0.4866532

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 34 0X0100 with gain 0.4973726 
    ## ... trying feature 35 1X0100 with gain 0.485898 
    ## ... trying feature 36 XX0100 with gain 0.4872025 
    ## ... trying feature 37 001100 with gain 0.4880375 
    ## ... trying feature 38 101100 with gain 0.4856007 
    ## ... trying feature 39 X01100 with gain 0.4866985 
    ## ... trying feature 40 011100 with gain 0.4957295 
    ## ... trying feature 41 111100 with gain 0.4857434 
    ## ... trying feature 42 X11100 with gain 0.4873305 
    ## ... trying feature 43 0X1100 with gain 0.4983151 
    ## ... trying feature 44 1X1100 with gain 0.4856535 
    ## ... trying feature 45 XX1100 with gain 0.4882828

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 46 00X100 with gain 0.4899602 
    ## ... trying feature 47 10X100 with gain 0.4855963 
    ## ... trying feature 48 X0X100 with gain 0.4874428 
    ## ... trying feature 49 01X100 with gain 0.5058446 
    ## ... trying feature 50 11X100 with gain 0.4861783 
    ## ... trying feature 51 X1X100 with gain 0.4887243 
    ## ... trying feature 52 0XX100 with gain 0.5108498 
    ## ... trying feature 53 1XX100 with gain 0.4859929 
    ## ... trying feature 54 XXX100 with gain 0.4904722

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 55 000X00 with gain 0.4894565 
    ## ... trying feature 56 100X00 with gain 0.4873995 
    ## ... trying feature 57 X00X00 with gain 0.4900135 
    ## ... trying feature 58 010X00 with gain 0.4859889 
    ## ... trying feature 59 110X00 with gain 0.4856213 
    ## ... trying feature 60 X10X00 with gain 0.4859853 
    ## ... trying feature 61 0X0X00 with gain 0.487119 
    ## ... trying feature 62 1X0X00 with gain 0.4862506 
    ## ... trying feature 63 XX0X00 with gain 0.4877346 
    ## ... trying feature 64 001X00 with gain 0.4900526 
    ## ... trying feature 65 101X00 with gain 0.487226 
    ## ... trying feature 66 X01X00 with gain 0.4910668 
    ## ... trying feature 67 011X00 with gain 0.4855501 
    ## ... trying feature 68 111X00 with gain 0.4860498 
    ## ... trying feature 69 X11X00 with gain 0.4857463 
    ## ... trying feature 70 0X1X00 with gain 0.4860575 
    ## ... trying feature 71 1X1X00 with gain 0.4869211 
    ## ... trying feature 72 XX1X00 with gain 0.4873947 
    ## ... trying feature 73 00XX00 with gain 0.4937251 
    ## ... trying feature 74 10XX00 with gain 0.4890474 
    ## ... trying feature 75 X0XX00 with gain 0.495509 
    ## ... trying feature 76 01XX00 with gain 0.4856807 
    ## ... trying feature 77 11XX00 with gain 0.4862184 
    ## ... trying feature 78 X1XX00 with gain 0.4862996 
    ## ... trying feature 79 0XXX00 with gain 0.4879693 
    ## ... trying feature 80 1XXX00 with gain 0.4882705 
    ## ... trying feature 81 XXXX00 with gain 0.4907006 
    ## ... trying feature 82 000010 with gain 0.4855447 
    ## ... trying feature 83 100010 with gain 0.4856949 
    ## ... trying feature 84 X00010 with gain 0.485704 
    ## ... trying feature 85 010010 with gain 0.4859847 
    ## ... trying feature 86 110010 with gain 0.4855858 
    ## ... trying feature 87 X10010 with gain 0.4856858 
    ## ... trying feature 88 0X0010 with gain 0.4859725 
    ## ... trying feature 89 1X0010 with gain 0.4856434 
    ## ... trying feature 90 XX0010 with gain 0.4856202 
    ## ... trying feature 91 001010 with gain 0.4861703 
    ## ... trying feature 92 101010 with gain 0.4859483 
    ## ... trying feature 93 X01010 with gain 0.4856123 
    ## ... trying feature 94 011010 with gain 0.4864183 
    ## ... trying feature 95 111010 with gain 0.4855735 
    ## ... trying feature 96 X11010 with gain 0.4860771 
    ## ... trying feature 97 0X1010 with gain 0.4870332 
    ## ... trying feature 98 1X1010 with gain 0.4855363 
    ## ... trying feature 99 XX1010 with gain 0.4861459 
    ## ... trying feature 100 00X010 with gain 0.4861317 
    ## ... trying feature 101 10X010 with gain 0.4861086 
    ## ... trying feature 102 X0X010 with gain 0.4855512 
    ## ... trying feature 103 01X010 with gain 0.4868209 
    ## ... trying feature 104 11X010 with gain 0.4855368 
    ## ... trying feature 105 X1X010 with gain 0.486204 
    ## ... trying feature 106 0XX010 with gain 0.4873625 
    ## ... trying feature 107 1XX010 with gain 0.485578 
    ## ... trying feature 108 XXX010 with gain 0.486173 
    ## ... trying feature 109 000110 with gain 0.4855388 
    ## ... trying feature 110 100110 with gain 0.4859404 
    ## ... trying feature 111 X00110 with gain 0.4859436 
    ## ... trying feature 112 010110 with gain 0.4864205 
    ## ... trying feature 113 110110 with gain 0.4861755 
    ## ... trying feature 114 X10110 with gain 0.485562 
    ## ... trying feature 115 0X0110 with gain 0.4864238 
    ## ... trying feature 116 1X0110 with gain 0.4855626 
    ## ... trying feature 117 XX0110 with gain 0.4856736 
    ## ... trying feature 118 001110 with gain 0.4856574 
    ## ... trying feature 119 101110 with gain 0.4855356 
    ## ... trying feature 120 X01110 with gain 0.4856574 
    ## ... trying feature 121 011110 with gain 0.4864768 
    ## ... trying feature 122 111110 with gain 0.4856524 
    ## ... trying feature 123 X11110 with gain 0.4861382 
    ## ... trying feature 124 0X1110 with gain 0.486598 
    ## ... trying feature 125 1X1110 with gain 0.4856524 
    ## ... trying feature 126 XX1110 with gain 0.4862147 
    ## ... trying feature 127 00X110 with gain 0.4856606 
    ## ... trying feature 128 10X110 with gain 0.4859404 
    ## ... trying feature 129 X0X110 with gain 0.4860659 
    ## ... trying feature 130 01X110 with gain 0.4873627 
    ## ... trying feature 131 11X110 with gain 0.4855411 
    ## ... trying feature 132 X1X110 with gain 0.4860076 
    ## ... trying feature 133 0XX110 with gain 0.4874894 
    ## ... trying feature 134 1XX110 with gain 0.4855547 
    ## ... trying feature 135 XXX110 with gain 0.4862647 
    ## ... trying feature 136 000X10 with gain 0.4855479 
    ## ... trying feature 137 100X10 with gain 0.4860989 
    ## ... trying feature 138 X00X10 with gain 0.4861113 
    ## ... trying feature 139 010X10 with gain 0.4855431 
    ## ... trying feature 140 110X10 with gain 0.485569 
    ## ... trying feature 141 X10X10 with gain 0.4855712 
    ## ... trying feature 142 0X0X10 with gain 0.4855418 
    ## ... trying feature 143 1X0X10 with gain 0.4855466 
    ## ... trying feature 144 XX0X10 with gain 0.4855363 
    ## ... trying feature 145 001X10 with gain 0.4858758 
    ## ... trying feature 146 101X10 with gain 0.4859483 
    ## ... trying feature 147 X01X10 with gain 0.4855616 
    ## ... trying feature 148 011X10 with gain 0.4855884 
    ## ... trying feature 149 111X10 with gain 0.4855389 
    ## ... trying feature 150 X11X10 with gain 0.4855451 
    ## ... trying feature 151 0X1X10 with gain 0.4857806 
    ## ... trying feature 152 1X1X10 with gain 0.4855845 
    ## ... trying feature 153 XX1X10 with gain 0.4855597 
    ## ... trying feature 154 00XX10 with gain 0.485852 
    ## ... trying feature 155 10XX10 with gain 0.4865154 
    ## ... trying feature 156 X0XX10 with gain 0.4855919 
    ## ... trying feature 157 01XX10 with gain 0.4855848 
    ## ... trying feature 158 11XX10 with gain 0.4855406 
    ## ... trying feature 159 X1XX10 with gain 0.4855761 
    ## ... trying feature 160 0XXX10 with gain 0.4857121 
    ## ... trying feature 161 1XXX10 with gain 0.485592 
    ## ... trying feature 162 XXXX10 with gain 0.4855455 
    ## ... trying feature 163 0000X0 with gain 0.4875463 
    ## ... trying feature 164 1000X0 with gain 0.4881986 
    ## ... trying feature 165 X000X0 with gain 0.4897802 
    ## ... trying feature 166 0100X0 with gain 0.4870075 
    ## ... trying feature 167 1100X0 with gain 0.4865392 
    ## ... trying feature 168 X100X0 with gain 0.4855579 
    ## ... trying feature 169 0X00X0 with gain 0.4861844 
    ## ... trying feature 170 1X00X0 with gain 0.4882342 
    ## ... trying feature 171 XX00X0 with gain 0.4859542 
    ## ... trying feature 172 0010X0 with gain 0.4868324 
    ## ... trying feature 173 1010X0 with gain 0.4879548 
    ## ... trying feature 174 X010X0 with gain 0.4892632 
    ## ... trying feature 175 0110X0 with gain 0.4906952 
    ## ... trying feature 176 1110X0 with gain 0.4869775 
    ## ... trying feature 177 X110X0 with gain 0.4860116 
    ## ... trying feature 178 0X10X0 with gain 0.4883405 
    ## ... trying feature 179 1X10X0 with gain 0.4884417 
    ## ... trying feature 180 XX10X0 with gain 0.4855437 
    ## ... trying feature 181 00X0X0 with gain 0.4882336 
    ## ... trying feature 182 10X0X0 with gain 0.4903494 
    ## ... trying feature 183 X0X0X0 with gain 0.4930862 
    ## ... trying feature 184 01X0X0 with gain 0.4929601 
    ## ... trying feature 185 11X0X0 with gain 0.4882786 
    ## ... trying feature 186 X1X0X0 with gain 0.4859902 
    ## ... trying feature 187 0XX0X0 with gain 0.4894501 
    ## ... trying feature 188 1XX0X0 with gain 0.491851 
    ## ... trying feature 189 XXX0X0 with gain 0.4857959 
    ## ... trying feature 190 0001X0 with gain 0.4874277 
    ## ... trying feature 191 1001X0 with gain 0.4856152 
    ## ... trying feature 192 X001X0 with gain 0.4864806

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 193 0101X0 with gain 0.4963329 
    ## ... trying feature 194 1101X0 with gain 0.4861377 
    ## ... trying feature 195 X101X0 with gain 0.4866627

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 196 0X01X0 with gain 0.4983295 
    ## ... trying feature 197 1X01X0 with gain 0.4859314 
    ## ... trying feature 198 XX01X0 with gain 0.4873483 
    ## ... trying feature 199 0011X0 with gain 0.488157 
    ## ... trying feature 200 1011X0 with gain 0.4856007 
    ## ... trying feature 201 X011X0 with gain 0.4867711 
    ## ... trying feature 202 0111X0 with gain 0.4966683 
    ## ... trying feature 203 1111X0 with gain 0.4856677 
    ## ... trying feature 204 X111X0 with gain 0.4877896 
    ## ... trying feature 205 0X11X0 with gain 0.4994122 
    ## ... trying feature 206 1X11X0 with gain 0.4856025 
    ## ... trying feature 207 XX11X0 with gain 0.488858

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 208 00X1X0 with gain 0.4900853 
    ## ... trying feature 209 10X1X0 with gain 0.48568 
    ## ... trying feature 210 X0X1X0 with gain 0.4877579 
    ## ... trying feature 211 01X1X0 with gain 0.5078889 
    ## ... trying feature 212 11X1X0 with gain 0.4861798 
    ## ... trying feature 213 X1X1X0 with gain 0.4892202 
    ## ... trying feature 214 0XX1X0 with gain 0.5131268 
    ## ... trying feature 215 1XX1X0 with gain 0.4859291 
    ## ... trying feature 216 XXX1X0 with gain 0.4912927

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 217 000XX0 with gain 0.4894695 
    ## ... trying feature 218 100XX0 with gain 0.4877637 
    ## ... trying feature 219 X00XX0 with gain 0.4904521 
    ## ... trying feature 220 010XX0 with gain 0.485926 
    ## ... trying feature 221 110XX0 with gain 0.4855914 
    ## ... trying feature 222 X10XX0 with gain 0.4858863 
    ## ... trying feature 223 0X0XX0 with gain 0.4869728 
    ## ... trying feature 224 1X0XX0 with gain 0.4862586 
    ## ... trying feature 225 XX0XX0 with gain 0.4876166 
    ## ... trying feature 226 001XX0 with gain 0.4887016 
    ## ... trying feature 227 101XX0 with gain 0.4874732 
    ## ... trying feature 228 X01XX0 with gain 0.490508 
    ## ... trying feature 229 011XX0 with gain 0.485566 
    ## ... trying feature 230 111XX0 with gain 0.4860531 
    ## ... trying feature 231 X11XX0 with gain 0.4857185 
    ## ... trying feature 232 0X1XX0 with gain 0.4858668 
    ## ... trying feature 233 1X1XX0 with gain 0.4870226 
    ## ... trying feature 234 XX1XX0 with gain 0.4872316 
    ## ... trying feature 235 00XXX0 with gain 0.491995 
    ## ... trying feature 236 10XXX0 with gain 0.4896676 
    ## ... trying feature 237 X0XXX0 with gain 0.4953903 
    ## ... trying feature 238 01XXX0 with gain 0.4856303 
    ## ... trying feature 239 11XXX0 with gain 0.4861689 
    ## ... trying feature 240 X1XXX0 with gain 0.4861797 
    ## ... trying feature 241 0XXXX0 with gain 0.4875221 
    ## ... trying feature 242 1XXXX0 with gain 0.4885038 
    ## ... trying feature 243 XXXXX0 with gain 0.490527 
    ## ... trying feature 244 000001 with gain 0.4855397 
    ## ... trying feature 245 100001 with gain 0.4888744 
    ## ... trying feature 246 X00001 with gain 0.4875943 
    ## ... trying feature 247 010001 with gain 0.4956157 
    ## ... trying feature 248 110001 with gain 0.4909464 
    ## ... trying feature 249 X10001 with gain 0.4999928 
    ## ... trying feature 250 0X0001 with gain 0.4945239 
    ## ... trying feature 251 1X0001 with gain 0.4879629 
    ## ... trying feature 252 XX0001 with gain 0.4954938 
    ## ... trying feature 253 001001 with gain 0.4857772 
    ## ... trying feature 254 101001 with gain 0.486379 
    ## ... trying feature 255 X01001 with gain 0.4856258 
    ## ... trying feature 256 011001 with gain 0.4949175 
    ## ... trying feature 257 111001 with gain 0.4871463 
    ## ... trying feature 258 X11001 with gain 0.4868053 
    ## ... trying feature 259 0X1001 with gain 0.4951661 
    ## ... trying feature 260 1X1001 with gain 0.4879026 
    ## ... trying feature 261 XX1001 with gain 0.4864685 
    ## ... trying feature 262 00X001 with gain 0.4856466 
    ## ... trying feature 263 10X001 with gain 0.4894382 
    ## ... trying feature 264 X0X001 with gain 0.4869407 
    ## ... trying feature 265 01X001 with gain 0.5101298 
    ## ... trying feature 266 11X001 with gain 0.485927 
    ## ... trying feature 267 X1X001 with gain 0.4999694 
    ## ... trying feature 268 0XX001 with gain 0.510127 
    ## ... trying feature 269 1XX001 with gain 0.4855598 
    ## ... trying feature 270 XXX001 with gain 0.4960415 
    ## ... trying feature 271 000101 with gain 0.4876605 
    ## ... trying feature 272 100101 with gain 0.4864566 
    ## ... trying feature 273 X00101 with gain 0.4877906

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 274 010101 with gain 0.4971398 
    ## ... trying feature 275 110101 with gain 0.486283 
    ## ... trying feature 276 X10101 with gain 0.4865983

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 277 0X0101 with gain 0.4994351 
    ## ... trying feature 278 1X0101 with gain 0.4856812 
    ## ... trying feature 279 XX0101 with gain 0.487986 
    ## ... trying feature 280 001101 with gain 0.4892833 
    ## ... trying feature 281 101101 with gain 0.486843 
    ## ... trying feature 282 X01101 with gain 0.4897891 
    ## ... trying feature 283 011101 with gain 0.499843 
    ## ... trying feature 284 111101 with gain 0.4906261 
    ## ... trying feature 285 X11101 with gain 0.4855677 
    ## ... trying feature 286 0X1101 with gain 0.5038483 
    ## ... trying feature 287 1X1101 with gain 0.4887355 
    ## ... trying feature 288 XX1101 with gain 0.4863213

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 289 00X101 with gain 0.4914629 
    ## ... trying feature 290 10X101 with gain 0.4877385 
    ## ... trying feature 291 X0X101 with gain 0.4919007 
    ## ... trying feature 292 01X101 with gain 0.5123219 
    ## ... trying feature 293 11X101 with gain 0.4913926 
    ## ... trying feature 294 X1X101 with gain 0.4862068 
    ## ... trying feature 295 0XX101 with gain 0.5193635 
    ## ... trying feature 296 1XX101 with gain 0.4885149 
    ## ... trying feature 297 XXX101 with gain 0.4887189 
    ## ... trying feature 298 000X01 with gain 0.4861369 
    ## ... trying feature 299 100X01 with gain 0.4891349 
    ## ... trying feature 300 X00X01 with gain 0.4895944 
    ## ... trying feature 301 010X01 with gain 0.4871087 
    ## ... trying feature 302 110X01 with gain 0.4917298 
    ## ... trying feature 303 X10X01 with gain 0.4925314 
    ## ... trying feature 304 0X0X01 with gain 0.4863496 
    ## ... trying feature 305 1X0X01 with gain 0.4878983 
    ## ... trying feature 306 XX0X01 with gain 0.4885469 
    ## ... trying feature 307 001X01 with gain 0.4859905 
    ## ... trying feature 308 101X01 with gain 0.487605 
    ## ... trying feature 309 X01X01 with gain 0.4878311 
    ## ... trying feature 310 011X01 with gain 0.4858868 
    ## ... trying feature 311 111X01 with gain 0.4858625 
    ## ... trying feature 312 X11X01 with gain 0.4861923 
    ## ... trying feature 313 0X1X01 with gain 0.4856102 
    ## ... trying feature 314 1X1X01 with gain 0.4855361 
    ## ... trying feature 315 XX1X01 with gain 0.4855726 
    ## ... trying feature 316 00XX01 with gain 0.4865931 
    ## ... trying feature 317 10XX01 with gain 0.4913096 
    ## ... trying feature 318 X0XX01 with gain 0.491861 
    ## ... trying feature 319 01XX01 with gain 0.4879149 
    ## ... trying feature 320 11XX01 with gain 0.4917509 
    ## ... trying feature 321 X1XX01 with gain 0.4938688 
    ## ... trying feature 322 0XXX01 with gain 0.4865706 
    ## ... trying feature 323 1XXX01 with gain 0.4872436 
    ## ... trying feature 324 XXXX01 with gain 0.4882933 
    ## ... trying feature 325 000011 with gain 0.4856728 
    ## ... trying feature 326 100011 with gain 0.4857558 
    ## ... trying feature 327 X00011 with gain 0.4855441 
    ## ... trying feature 328 010011 with gain 0.4867985 
    ## ... trying feature 329 110011 with gain 0.4872484 
    ## ... trying feature 330 X10011 with gain 0.4885508 
    ## ... trying feature 331 0X0011 with gain 0.4865144 
    ## ... trying feature 332 1X0011 with gain 0.4874122 
    ## ... trying feature 333 XX0011 with gain 0.4883867 
    ## ... trying feature 334 001011 with gain 0.4856723 
    ## ... trying feature 335 101011 with gain 0.4855356 
    ## ... trying feature 336 X01011 with gain 0.4856723 
    ## ... trying feature 337 011011 with gain 0.4881943 
    ## ... trying feature 338 111011 with gain 0.4861438 
    ## ... trying feature 339 X11011 with gain 0.4888207 
    ## ... trying feature 340 0X1011 with gain 0.4878363 
    ## ... trying feature 341 1X1011 with gain 0.4861438 
    ## ... trying feature 342 XX1011 with gain 0.4884546 
    ## ... trying feature 343 00X011 with gain 0.4858093 
    ## ... trying feature 344 10X011 with gain 0.4857558 
    ## ... trying feature 345 X0X011 with gain 0.4855407 
    ## ... trying feature 346 01X011 with gain 0.4894671 
    ## ... trying feature 347 11X011 with gain 0.4878654 
    ## ... trying feature 348 X1X011 with gain 0.4914481 
    ## ... trying feature 349 0XX011 with gain 0.4888058 
    ## ... trying feature 350 1XX011 with gain 0.4880332 
    ## ... trying feature 351 XXX011 with gain 0.490978 
    ## ... trying feature 352 000111 with gain 0.485551 
    ## ... trying feature 353 X00111 with gain 0.485551 
    ## ... trying feature 354 010111 with gain 0.4860509 
    ## ... trying feature 355 110111 with gain 0.4858406 
    ## ... trying feature 356 X10111 with gain 0.4855367 
    ## ... trying feature 357 0X0111 with gain 0.4860664 
    ## ... trying feature 358 1X0111 with gain 0.4858406 
    ## ... trying feature 359 XX0111 with gain 0.485536 
    ## ... trying feature 360 001111 with gain 0.4855386 
    ## ... trying feature 361 101111 with gain 0.4855405 
    ## ... trying feature 362 X01111 with gain 0.485541 
    ## ... trying feature 363 011111 with gain 0.4866749 
    ## ... trying feature 364 111111 with gain 0.4855393 
    ## ... trying feature 365 X11111 with gain 0.4858796 
    ## ... trying feature 366 0X1111 with gain 0.4866779 
    ## ... trying feature 367 1X1111 with gain 0.4855425 
    ## ... trying feature 368 XX1111 with gain 0.4858732 
    ## ... trying feature 369 00X111 with gain 0.485554 
    ## ... trying feature 370 10X111 with gain 0.4855405 
    ## ... trying feature 371 X0X111 with gain 0.4855445 
    ## ... trying feature 372 01X111 with gain 0.4871953 
    ## ... trying feature 373 11X111 with gain 0.4855962 
    ## ... trying feature 374 X1X111 with gain 0.4857693 
    ## ... trying feature 375 0XX111 with gain 0.4872141 
    ## ... trying feature 376 1XX111 with gain 0.4855785 
    ## ... trying feature 377 XXX111 with gain 0.4857772 
    ## ... trying feature 378 000X11 with gain 0.4856882 
    ## ... trying feature 379 100X11 with gain 0.4857558 
    ## ... trying feature 380 X00X11 with gain 0.4855403 
    ## ... trying feature 381 010X11 with gain 0.4860318 
    ## ... trying feature 382 110X11 with gain 0.4875426 
    ## ... trying feature 383 X10X11 with gain 0.4878995 
    ## ... trying feature 384 0X0X11 with gain 0.4858949 
    ## ... trying feature 385 1X0X11 with gain 0.4877018 
    ## ... trying feature 386 XX0X11 with gain 0.4877882 
    ## ... trying feature 387 001X11 with gain 0.4856753 
    ## ... trying feature 388 101X11 with gain 0.4855405 
    ## ... trying feature 389 X01X11 with gain 0.4855863 
    ## ... trying feature 390 011X11 with gain 0.4863497 
    ## ... trying feature 391 111X11 with gain 0.4856833 
    ## ... trying feature 392 X11X11 with gain 0.486463 
    ## ... trying feature 393 0X1X11 with gain 0.4862245 
    ## ... trying feature 394 1X1X11 with gain 0.4856503 
    ## ... trying feature 395 XX1X11 with gain 0.4862978 
    ## ... trying feature 396 00XX11 with gain 0.4858278 
    ## ... trying feature 397 10XX11 with gain 0.485568 
    ## ... trying feature 398 X0XX11 with gain 0.4855487 
    ## ... trying feature 399 01XX11 with gain 0.4868657 
    ## ... trying feature 400 11XX11 with gain 0.4873144 
    ## ... trying feature 401 X1XX11 with gain 0.4885075 
    ## ... trying feature 402 0XXX11 with gain 0.4865987 
    ## ... trying feature 403 1XXX11 with gain 0.4873127 
    ## ... trying feature 404 XXXX11 with gain 0.4882226 
    ## ... trying feature 405 0000X1 with gain 0.48555 
    ## ... trying feature 406 1000X1 with gain 0.4883795 
    ## ... trying feature 407 X000X1 with gain 0.4874108 
    ## ... trying feature 408 0100X1 with gain 0.4970239 
    ## ... trying feature 409 1100X1 with gain 0.4924235 
    ## ... trying feature 410 X100X1 with gain 0.5028862 
    ## ... trying feature 411 0X00X1 with gain 0.4957 
    ## ... trying feature 412 1X00X1 with gain 0.4891258 
    ## ... trying feature 413 XX00X1 with gain 0.4979853 
    ## ... trying feature 414 0010X1 with gain 0.4857247 
    ## ... trying feature 415 1010X1 with gain 0.486379 
    ## ... trying feature 416 X010X1 with gain 0.4856478 
    ## ... trying feature 417 0110X1 with gain 0.4975202 
    ## ... trying feature 418 1110X1 with gain 0.4868535 
    ## ... trying feature 419 X110X1 with gain 0.4878537 
    ## ... trying feature 420 0X10X1 with gain 0.4975902 
    ## ... trying feature 421 1X10X1 with gain 0.4875566 
    ## ... trying feature 422 XX10X1 with gain 0.4873238 
    ## ... trying feature 423 00X0X1 with gain 0.4855992 
    ## ... trying feature 424 10X0X1 with gain 0.4890942 
    ## ... trying feature 425 X0X0X1 with gain 0.4869258 
    ## ... trying feature 426 01X0X1 with gain 0.5159828 
    ## ... trying feature 427 11X0X1 with gain 0.4865106 
    ## ... trying feature 428 X1X0X1 with gain 0.5051107 
    ## ... trying feature 429 0XX0X1 with gain 0.5157688 
    ## ... trying feature 430 1XX0X1 with gain 0.4855883 
    ## ... trying feature 431 XXX0X1 with gain 0.5006012 
    ## ... trying feature 432 0001X1 with gain 0.4876763 
    ## ... trying feature 433 1001X1 with gain 0.4864566 
    ## ... trying feature 434 X001X1 with gain 0.4878014

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 435 0101X1 with gain 0.4976871 
    ## ... trying feature 436 1101X1 with gain 0.4864546 
    ## ... trying feature 437 X101X1 with gain 0.4865493

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 438 0X01X1 with gain 0.5000105 
    ## ... trying feature 439 1X01X1 with gain 0.4857617 
    ## ... trying feature 440 XX01X1 with gain 0.4879092 
    ## ... trying feature 441 0011X1 with gain 0.4892865 
    ## ... trying feature 442 1011X1 with gain 0.4867484 
    ## ... trying feature 443 X011X1 with gain 0.4895509 
    ## ... trying feature 444 0111X1 with gain 0.5010741 
    ## ... trying feature 445 1111X1 with gain 0.4902873 
    ## ... trying feature 446 X111X1 with gain 0.4856405 
    ## ... trying feature 447 0X11X1 with gain 0.5051415 
    ## ... trying feature 448 1X11X1 with gain 0.4884887 
    ## ... trying feature 449 XX11X1 with gain 0.4865525

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 450 00X1X1 with gain 0.4914825 
    ## ... trying feature 451 10X1X1 with gain 0.4876808 
    ## ... trying feature 452 X0X1X1 with gain 0.4917708 
    ## ... trying feature 453 01X1X1 with gain 0.5142765 
    ## ... trying feature 454 11X1X1 with gain 0.4914434 
    ## ... trying feature 455 X1X1X1 with gain 0.4863756 
    ## ... trying feature 456 0XX1X1 with gain 0.5214613 
    ## ... trying feature 457 1XX1X1 with gain 0.4885822 
    ## ... trying feature 458 XXX1X1 with gain 0.4890057 
    ## ... trying feature 459 000XX1 with gain 0.4862087 
    ## ... trying feature 460 100XX1 with gain 0.4888174 
    ## ... trying feature 461 X00XX1 with gain 0.4894144 
    ## ... trying feature 462 010XX1 with gain 0.4875377 
    ## ... trying feature 463 110XX1 with gain 0.4934325 
    ## ... trying feature 464 X10XX1 with gain 0.4944585 
    ## ... trying feature 465 0X0XX1 with gain 0.4866265 
    ## ... trying feature 466 1X0XX1 with gain 0.4891094 
    ## ... trying feature 467 XX0XX1 with gain 0.4899303 
    ## ... trying feature 468 001XX1 with gain 0.4860397 
    ## ... trying feature 469 101XX1 with gain 0.487565 
    ## ... trying feature 470 X01XX1 with gain 0.4878845 
    ## ... trying feature 471 011XX1 with gain 0.4862837 
    ## ... trying feature 472 111XX1 with gain 0.4859534 
    ## ... trying feature 473 X11XX1 with gain 0.4866351 
    ## ... trying feature 474 0X1XX1 with gain 0.4858115 
    ## ... trying feature 475 1X1XX1 with gain 0.4855447 
    ## ... trying feature 476 XX1XX1 with gain 0.4857059 
    ## ... trying feature 477 00XXX1 with gain 0.486715 
    ## ... trying feature 478 10XXX1 with gain 0.4909815 
    ## ... trying feature 479 X0XXX1 with gain 0.4917449 
    ## ... trying feature 480 01XXX1 with gain 0.4893553 
    ## ... trying feature 481 11XXX1 with gain 0.4938372 
    ## ... trying feature 482 X1XXX1 with gain 0.4973773 
    ## ... trying feature 483 0XXXX1 with gain 0.4875221 
    ## ... trying feature 484 1XXXX1 with gain 0.4885038 
    ## ... trying feature 485 XXXXX1 with gain 0.490527 
    ## ... trying feature 486 00000X with gain 0.4860989 
    ## ... trying feature 487 10000X with gain 0.4916707 
    ## ... trying feature 488 X0000X with gain 0.4915269 
    ## ... trying feature 489 01000X with gain 0.4968619 
    ## ... trying feature 490 11000X with gain 0.487141 
    ## ... trying feature 491 X1000X with gain 0.4961957 
    ## ... trying feature 492 0X000X with gain 0.4943502 
    ## ... trying feature 493 1X000X with gain 0.4855681 
    ## ... trying feature 494 XX000X with gain 0.49026 
    ## ... trying feature 495 00100X with gain 0.4859742 
    ## ... trying feature 496 10100X with gain 0.4883794 
    ## ... trying feature 497 X0100X with gain 0.4883238 
    ## ... trying feature 498 01100X with gain 0.5023689 
    ## ... trying feature 499 11100X with gain 0.489455 
    ## ... trying feature 500 X1100X with gain 0.4872886 
    ## ... trying feature 501 0X100X with gain 0.4991363 
    ## ... trying feature 502 1X100X with gain 0.4922212 
    ## ... trying feature 503 XX100X with gain 0.4858806 
    ## ... trying feature 504 00X00X with gain 0.4865335 
    ## ... trying feature 505 10X00X with gain 0.4942092 
    ## ... trying feature 506 X0X00X with gain 0.4937655 
    ## ... trying feature 507 01X00X with gain 0.5352448 
    ## ... trying feature 508 11X00X with gain 0.4861929 
    ## ... trying feature 509 X1X00X with gain 0.5010951 
    ## ... trying feature 510 0XX00X with gain 0.532237 
    ## ... trying feature 511 1XX00X with gain 0.4909563 
    ## ... trying feature 512 XXX00X with gain 0.4916997 
    ## ... trying feature 513 00010X with gain 0.4895602 
    ## ... trying feature 514 10010X with gain 0.4861897 
    ## ... trying feature 515 X0010X with gain 0.4883312

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 516 01010X with gain 0.5077772 
    ## ... trying feature 517 11010X with gain 0.4868188 
    ## ... trying feature 518 X1010X with gain 0.4878816

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 519 0X010X with gain 0.5124691 
    ## ... trying feature 520 1X010X with gain 0.4860522 
    ## ... trying feature 521 XX010X with gain 0.4899132 
    ## ... trying feature 522 00110X with gain 0.4918671 
    ## ... trying feature 523 10110X with gain 0.4865441 
    ## ... trying feature 524 X0110X with gain 0.4904843 
    ## ... trying feature 525 01110X with gain 0.511678 
    ## ... trying feature 526 11110X with gain 0.4901102 
    ## ... trying feature 527 X1110X with gain 0.4866934 
    ## ... trying feature 528 0X110X with gain 0.5191732 
    ## ... trying feature 529 1X110X with gain 0.4883798 
    ## ... trying feature 530 XX110X with gain 0.4890156

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 531 00X10X with gain 0.4960482 
    ## ... trying feature 532 10X10X with gain 0.4872178 
    ## ... trying feature 533 X0X10X with gain 0.4933228 
    ## ... trying feature 534 01X10X with gain 0.5382916 
    ## ... trying feature 535 11X10X with gain 0.4925585 
    ## ... trying feature 536 X1X10X with gain 0.4895679 
    ## ... trying feature 537 0XX10X with gain 0.553829 
    ## ... trying feature 538 1XX10X with gain 0.4895573 
    ## ... trying feature 539 XXX10X with gain 0.4956326 
    ## ... trying feature 540 000X0X with gain 0.4885108 
    ## ... trying feature 541 100X0X with gain 0.4911404 
    ## ... trying feature 542 X00X0X with gain 0.4941444 
    ## ... trying feature 543 010X0X with gain 0.4858781 
    ## ... trying feature 544 110X0X with gain 0.4890565 
    ## ... trying feature 545 X10X0X with gain 0.4888137 
    ## ... trying feature 546 0X0X0X with gain 0.4855566 
    ## ... trying feature 547 1X0X0X with gain 0.4860048 
    ## ... trying feature 548 XX0X0X with gain 0.485713 
    ## ... trying feature 549 001X0X with gain 0.4891697 
    ## ... trying feature 550 101X0X with gain 0.4894678 
    ## ... trying feature 551 X01X0X with gain 0.4929869 
    ## ... trying feature 552 011X0X with gain 0.485921 
    ## ... trying feature 553 111X0X with gain 0.4855404 
    ## ... trying feature 554 X11X0X with gain 0.4856596 
    ## ... trying feature 555 0X1X0X with gain 0.4856726 
    ## ... trying feature 556 1X1X0X with gain 0.4865303 
    ## ... trying feature 557 XX1X0X with gain 0.4865177 
    ## ... trying feature 558 00XX0X with gain 0.4924897 
    ## ... trying feature 559 10XX0X with gain 0.4952621 
    ## ... trying feature 560 X0XX0X with gain 0.5020505 
    ## ... trying feature 561 01XX0X with gain 0.4878839 
    ## ... trying feature 562 11XX0X with gain 0.4907313 
    ## ... trying feature 563 X1XX0X with gain 0.4929146 
    ## ... trying feature 564 0XXX0X with gain 0.48668 
    ## ... trying feature 565 1XXX0X with gain 0.4861033 
    ## ... trying feature 566 XXXX0X with gain 0.4871463 
    ## ... trying feature 567 00001X with gain 0.4856819 
    ## ... trying feature 568 10001X with gain 0.4855399 
    ## ... trying feature 569 X0001X with gain 0.4855457 
    ## ... trying feature 570 01001X with gain 0.4871677 
    ## ... trying feature 571 11001X with gain 0.4864906 
    ## ... trying feature 572 X1001X with gain 0.4881362 
    ## ... trying feature 573 0X001X with gain 0.486929 
    ## ... trying feature 574 1X001X with gain 0.4864323 
    ## ... trying feature 575 XX001X with gain 0.4878424 
    ## ... trying feature 576 00101X with gain 0.4858561 
    ## ... trying feature 577 10101X with gain 0.4859483 
    ## ... trying feature 578 X0101X with gain 0.4855579 
    ## ... trying feature 579 01101X with gain 0.4890909 
    ## ... trying feature 580 11101X with gain 0.4858529 
    ## ... trying feature 581 X1101X with gain 0.4888556 
    ## ... trying feature 582 0X101X with gain 0.4894142 
    ## ... trying feature 583 1X101X with gain 0.4856579 
    ## ... trying feature 584 XX101X with gain 0.4886211 
    ## ... trying feature 585 00X01X with gain 0.4856823 
    ## ... trying feature 586 10X01X with gain 0.4856319 
    ## ... trying feature 587 X0X01X with gain 0.4855391 
    ## ... trying feature 588 01X01X with gain 0.490711 
    ## ... trying feature 589 11X01X with gain 0.4867686 
    ## ... trying feature 590 X1X01X with gain 0.4911017 
    ## ... trying feature 591 0XX01X with gain 0.4907302 
    ## ... trying feature 592 1XX01X with gain 0.4864141 
    ## ... trying feature 593 XXX01X with gain 0.4906477 
    ## ... trying feature 594 00011X with gain 0.4855542 
    ## ... trying feature 595 10011X with gain 0.4859404 
    ## ... trying feature 596 X0011X with gain 0.485959 
    ## ... trying feature 597 01011X with gain 0.4869407 
    ## ... trying feature 598 11011X with gain 0.4862797 
    ## ... trying feature 599 X1011X with gain 0.4855464 
    ## ... trying feature 600 0X011X with gain 0.4869595 
    ## ... trying feature 601 1X011X with gain 0.4857629 
    ## ... trying feature 602 XX011X with gain 0.4856172 
    ## ... trying feature 603 00111X with gain 0.4856603 
    ## ... trying feature 604 10111X with gain 0.4855405 
    ## ... trying feature 605 X0111X with gain 0.4855801 
    ## ... trying feature 606 01111X with gain 0.4876217 
    ## ... trying feature 607 11111X with gain 0.4856081 
    ## ... trying feature 608 X1111X with gain 0.486445 
    ## ... trying feature 609 0X111X with gain 0.4877463 
    ## ... trying feature 610 1X111X with gain 0.4856132 
    ## ... trying feature 611 XX111X with gain 0.4864904 
    ## ... trying feature 612 00X11X with gain 0.485679 
    ## ... trying feature 613 10X11X with gain 0.4857234 
    ## ... trying feature 614 X0X11X with gain 0.4858146 
    ## ... trying feature 615 01X11X with gain 0.4890491 
    ## ... trying feature 616 11X11X with gain 0.4855897 
    ## ... trying feature 617 X1X11X with gain 0.4862313 
    ## ... trying feature 618 0XX11X with gain 0.4891955 
    ## ... trying feature 619 1XX11X with gain 0.4855385 
    ## ... trying feature 620 XXX11X with gain 0.4864215 
    ## ... trying feature 621 000X1X with gain 0.4857006 
    ## ... trying feature 622 100X1X with gain 0.4856289 
    ## ... trying feature 623 X00X1X with gain 0.4857085 
    ## ... trying feature 624 010X1X with gain 0.4858503 
    ## ... trying feature 625 110X1X with gain 0.4870809 
    ## ... trying feature 626 X10X1X with gain 0.4871848 
    ## ... trying feature 627 0X0X1X with gain 0.4857743 
    ## ... trying feature 628 1X0X1X with gain 0.486592 
    ## ... trying feature 629 XX0X1X with gain 0.4867331 
    ## ... trying feature 630 001X1X with gain 0.4856999 
    ## ... trying feature 631 101X1X with gain 0.4857265 
    ## ... trying feature 632 X01X1X with gain 0.4855357 
    ## ... trying feature 633 011X1X with gain 0.4862996 
    ## ... trying feature 634 111X1X with gain 0.4855783 
    ## ... trying feature 635 X11X1X with gain 0.4861489 
    ## ... trying feature 636 0X1X1X with gain 0.4864716 
    ## ... trying feature 637 1X1X1X with gain 0.4855383 
    ## ... trying feature 638 XX1X1X with gain 0.4860925 
    ## ... trying feature 639 00XX1X with gain 0.4855909 
    ## ... trying feature 640 10XX1X with gain 0.4858087 
    ## ... trying feature 641 X0XX1X with gain 0.4856019 
    ## ... trying feature 642 01XX1X with gain 0.4866218 
    ## ... trying feature 643 11XX1X with gain 0.4865437 
    ## ... trying feature 644 X1XX1X with gain 0.4875852 
    ## ... trying feature 645 0XXX1X with gain 0.48668 
    ## ... trying feature 646 1XXX1X with gain 0.4861033 
    ## ... trying feature 647 XXXX1X with gain 0.4871463 
    ## ... trying feature 648 0000XX with gain 0.4861654 
    ## ... trying feature 649 1000XX with gain 0.4913053 
    ## ... trying feature 650 X000XX with gain 0.4913748 
    ## ... trying feature 651 0100XX with gain 0.4989709 
    ## ... trying feature 652 1100XX with gain 0.4878069 
    ## ... trying feature 653 X100XX with gain 0.4988499 
    ## ... trying feature 654 0X00XX with gain 0.496149 
    ## ... trying feature 655 1X00XX with gain 0.4857326 
    ## ... trying feature 656 XX00XX with gain 0.4921243 
    ## ... trying feature 657 0010XX with gain 0.4857712 
    ## ... trying feature 658 1010XX with gain 0.4886462 
    ## ... trying feature 659 X010XX with gain 0.4880701 
    ## ... trying feature 660 0110XX with gain 0.5068103 
    ## ... trying feature 661 1110XX with gain 0.4888692 
    ## ... trying feature 662 X110XX with gain 0.488739 
    ## ... trying feature 663 0X10XX with gain 0.5037892 
    ## ... trying feature 664 1X10XX with gain 0.4916363 
    ## ... trying feature 665 XX10XX with gain 0.4866712 
    ## ... trying feature 666 00X0XX with gain 0.4863084 
    ## ... trying feature 667 10X0XX with gain 0.4942847 
    ## ... trying feature 668 X0X0XX with gain 0.4933598 
    ## ... trying feature 669 01X0XX with gain 0.5538445 
    ## ... trying feature 670 11X0XX with gain 0.4857457 
    ## ... trying feature 671 X1X0XX with gain 0.5085911 
    ## ... trying feature 672 0XX0XX with gain 0.5595961 
    ## ... trying feature 673 1XX0XX with gain 0.4895635 
    ## ... trying feature 674 XXX0XX with gain 0.4970523 
    ## ... trying feature 675 0001XX with gain 0.4895797 
    ## ... trying feature 676 1001XX with gain 0.4863685 
    ## ... trying feature 677 X001XX with gain 0.4886022

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 678 0101XX with gain 0.5093227 
    ## ... trying feature 679 1101XX with gain 0.4871997 
    ## ... trying feature 680 X101XX with gain 0.4878158

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 681 0X01XX with gain 0.51406 
    ## ... trying feature 682 1X01XX with gain 0.4861998 
    ## ... trying feature 683 XX01XX with gain 0.4899739 
    ## ... trying feature 684 0011XX with gain 0.491994 
    ## ... trying feature 685 1011XX with gain 0.4865213 
    ## ... trying feature 686 X011XX with gain 0.4904615 
    ## ... trying feature 687 0111XX with gain 0.5141492 
    ## ... trying feature 688 1111XX with gain 0.4896356 
    ## ... trying feature 689 X111XX with gain 0.487262 
    ## ... trying feature 690 0X11XX with gain 0.5219803 
    ## ... trying feature 691 1X11XX with gain 0.4880418 
    ## ... trying feature 692 XX11XX with gain 0.4899258

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 693 00X1XX with gain 0.4961968 
    ## ... trying feature 694 10X1XX with gain 0.4874024 
    ## ... trying feature 695 X0X1XX with gain 0.4936555 
    ## ... trying feature 696 01X1XX with gain 0.5432134 
    ## ... trying feature 697 11X1XX with gain 0.4927271 
    ## ... trying feature 698 X1X1XX with gain 0.4904081 
    ## ... trying feature 699 0XX1XX with gain 0.5595961 
    ## ... trying feature 700 1XX1XX with gain 0.4895635 
    ## ... trying feature 701 XXX1XX with gain 0.4970523 
    ## ... trying feature 702 000XXX with gain 0.4886287 
    ## ... trying feature 703 100XXX with gain 0.4912311 
    ## ... trying feature 704 X00XXX with gain 0.4943611 
    ## ... trying feature 705 010XXX with gain 0.4861039 
    ## ... trying feature 706 110XXX with gain 0.4903696 
    ## ... trying feature 707 X10XXX with gain 0.4901829 
    ## ... trying feature 708 0X0XXX with gain 0.4855358 
    ## ... trying feature 709 1X0XXX with gain 0.486511 
    ## ... trying feature 710 XX0XXX with gain 0.4861048 
    ## ... trying feature 711 001XXX with gain 0.4886044 
    ## ... trying feature 712 101XXX with gain 0.4896865 
    ## ... trying feature 713 X01XXX with gain 0.4926677 
    ## ... trying feature 714 011XXX with gain 0.4863918 
    ## ... trying feature 715 111XXX with gain 0.4855357 
    ## ... trying feature 716 X11XXX with gain 0.4858989 
    ## ... trying feature 717 0X1XXX with gain 0.4855358 
    ## ... trying feature 718 1X1XXX with gain 0.486511 
    ## ... trying feature 719 XX1XXX with gain 0.4861048 
    ## ... trying feature 720 00XXXX with gain 0.4919432 
    ## ... trying feature 721 10XXXX with gain 0.4956646 
    ## ... trying feature 722 X0XXXX with gain 0.5019796 
    ## ... trying feature 723 01XXXX with gain 0.4919432 
    ## ... trying feature 724 11XXXX with gain 0.4956646 
    ## ... trying feature 725 X1XXXX with gain 0.5019796 
    ## ... trying feature 727 1XXXXX with gain 0.4855356 
    ## ... Using feature 672 0XX0XX 
    ## Adding Feature Number 3 
    ## ... trying feature 1 000000 with gain 0.5629783 
    ## ... trying feature 2 100000 with gain 0.5619268 
    ## ... trying feature 3 X00000 with gain 0.5645916 
    ## ... trying feature 4 010000 with gain 0.5599743 
    ## ... trying feature 5 110000 with gain 0.5607211 
    ## ... trying feature 6 X10000 with gain 0.5610458 
    ## ... trying feature 7 0X0000 with gain 0.5608711 
    ## ... trying feature 8 1X0000 with gain 0.5622903 
    ## ... trying feature 9 XX0000 with gain 0.563591 
    ## ... trying feature 10 001000 with gain 0.565003 
    ## ... trying feature 11 101000 with gain 0.5623367 
    ## ... trying feature 12 X01000 with gain 0.5676153 
    ## ... trying feature 13 011000 with gain 0.5595999 
    ## ... trying feature 14 111000 with gain 0.5604365 
    ## ... trying feature 15 X11000 with gain 0.5600256 
    ## ... trying feature 16 0X1000 with gain 0.5606334 
    ## ... trying feature 17 1X1000 with gain 0.5618529 
    ## ... trying feature 18 XX1000 with gain 0.5627774 
    ## ... trying feature 19 00X000 with gain 0.5681669 
    ## ... trying feature 20 10X000 with gain 0.5643684 
    ## ... trying feature 21 X0X000 with gain 0.5721838 
    ## ... trying feature 22 01X000 with gain 0.5598417 
    ## ... trying feature 23 11X000 with gain 0.5617064 
    ## ... trying feature 24 X1X000 with gain 0.5614649 
    ## ... trying feature 25 0XX000 with gain 0.5625944 
    ## ... trying feature 26 1XX000 with gain 0.5649882 
    ## ... trying feature 27 XXX000 with gain 0.5677501 
    ## ... trying feature 28 000100 with gain 0.5596526 
    ## ... trying feature 29 100100 with gain 0.5596495 
    ## ... trying feature 30 X00100 with gain 0.5596646

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 010100 with gain 0.5599069 
    ## ... trying feature 32 110100 with gain 0.560263 
    ## ... trying feature 33 X10100 with gain 0.5601327

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 34 0X0100 with gain 0.5599734 
    ## ... trying feature 35 1X0100 with gain 0.5600646 
    ## ... trying feature 36 XX0100 with gain 0.559948 
    ## ... trying feature 37 001100 with gain 0.5596748 
    ## ... trying feature 38 101100 with gain 0.5598967 
    ## ... trying feature 39 X01100 with gain 0.5599305 
    ## ... trying feature 40 011100 with gain 0.5600262 
    ## ... trying feature 41 111100 with gain 0.5600314 
    ## ... trying feature 42 X11100 with gain 0.5601861 
    ## ... trying feature 43 0X1100 with gain 0.5599006 
    ## ... trying feature 44 1X1100 with gain 0.5597593 
    ## ... trying feature 45 XX1100 with gain 0.5598401

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 46 00X100 with gain 0.5597337 
    ## ... trying feature 47 10X100 with gain 0.5599298 
    ## ... trying feature 48 X0X100 with gain 0.5599808 
    ## ... trying feature 49 01X100 with gain 0.5596891 
    ## ... trying feature 50 11X100 with gain 0.5607366 
    ## ... trying feature 51 X1X100 with gain 0.5608153 
    ## ... trying feature 52 0XX100 with gain 0.559623 
    ## ... trying feature 53 1XX100 with gain 0.560203 
    ## ... trying feature 54 XXX100 with gain 0.5602295

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 55 000X00 with gain 0.5630351 
    ## ... trying feature 56 100X00 with gain 0.561481 
    ## ... trying feature 57 X00X00 with gain 0.5638107 
    ## ... trying feature 58 010X00 with gain 0.5600394 
    ## ... trying feature 59 110X00 with gain 0.5596711 
    ## ... trying feature 60 X10X00 with gain 0.5600315 
    ## ... trying feature 61 0X0X00 with gain 0.5609979 
    ## ... trying feature 62 1X0X00 with gain 0.5602978 
    ## ... trying feature 63 XX0X00 with gain 0.561673 
    ## ... trying feature 64 001X00 with gain 0.5650737 
    ## ... trying feature 65 101X00 with gain 0.5622716 
    ## ... trying feature 66 X01X00 with gain 0.5670974 
    ## ... trying feature 67 011X00 with gain 0.5595972 
    ## ... trying feature 68 111X00 with gain 0.559669 
    ## ... trying feature 69 X11X00 with gain 0.5596281 
    ## ... trying feature 70 0X1X00 with gain 0.5604651 
    ## ... trying feature 71 1X1X00 with gain 0.5604607 
    ## ... trying feature 72 XX1X00 with gain 0.5613471 
    ## ... trying feature 73 00XX00 with gain 0.5682954 
    ## ... trying feature 74 10XX00 with gain 0.5641011 
    ## ... trying feature 75 X0XX00 with gain 0.5712842 
    ## ... trying feature 76 01XX00 with gain 0.5597993 
    ## ... trying feature 77 11XX00 with gain 0.5597772 
    ## ... trying feature 78 X1XX00 with gain 0.5599765 
    ## ... trying feature 79 0XXX00 with gain 0.5624691 
    ## ... trying feature 80 1XXX00 with gain 0.5616238 
    ## ... trying feature 81 XXXX00 with gain 0.5643101 
    ## ... trying feature 82 000010 with gain 0.5596115 
    ## ... trying feature 83 100010 with gain 0.5596015 
    ## ... trying feature 84 X00010 with gain 0.5596169 
    ## ... trying feature 85 010010 with gain 0.5596569 
    ## ... trying feature 86 110010 with gain 0.5596241 
    ## ... trying feature 87 X10010 with gain 0.5596088 
    ## ... trying feature 88 0X0010 with gain 0.5596517 
    ## ... trying feature 89 1X0010 with gain 0.5596256 
    ## ... trying feature 90 XX0010 with gain 0.5596063 
    ## ... trying feature 91 001010 with gain 0.5598336 
    ## ... trying feature 92 101010 with gain 0.5603626 
    ## ... trying feature 93 X01010 with gain 0.5596153 
    ## ... trying feature 94 011010 with gain 0.5600031 
    ## ... trying feature 95 111010 with gain 0.5596006 
    ## ... trying feature 96 X11010 with gain 0.5597153 
    ## ... trying feature 97 0X1010 with gain 0.5602411 
    ## ... trying feature 98 1X1010 with gain 0.5597444 
    ## ... trying feature 99 XX1010 with gain 0.5596506 
    ## ... trying feature 100 00X010 with gain 0.5598091 
    ## ... trying feature 101 10X010 with gain 0.560368 
    ## ... trying feature 102 X0X010 with gain 0.5596197 
    ## ... trying feature 103 01X010 with gain 0.5599649 
    ## ... trying feature 104 11X010 with gain 0.5596172 
    ## ... trying feature 105 X1X010 with gain 0.5597105 
    ## ... trying feature 106 0XX010 with gain 0.5601511 
    ## ... trying feature 107 1XX010 with gain 0.559774 
    ## ... trying feature 108 XXX010 with gain 0.5596582 
    ## ... trying feature 109 000110 with gain 0.5595963 
    ## ... trying feature 110 100110 with gain 0.5596083 
    ## ... trying feature 111 X00110 with gain 0.5596084 
    ## ... trying feature 112 010110 with gain 0.5596203 
    ## ... trying feature 113 110110 with gain 0.560251 
    ## ... trying feature 114 X10110 with gain 0.5600136 
    ## ... trying feature 115 0X0110 with gain 0.5596205 
    ## ... trying feature 116 1X0110 with gain 0.5600767 
    ## ... trying feature 117 XX0110 with gain 0.5599669 
    ## ... trying feature 118 001110 with gain 0.5595992 
    ## ... trying feature 119 101110 with gain 0.5595961 
    ## ... trying feature 120 X01110 with gain 0.5595992 
    ## ... trying feature 121 011110 with gain 0.5596269 
    ## ... trying feature 122 111110 with gain 0.5598107 
    ## ... trying feature 123 X11110 with gain 0.5598265 
    ## ... trying feature 124 0X1110 with gain 0.55963 
    ## ... trying feature 125 1X1110 with gain 0.5598107 
    ## ... trying feature 126 XX1110 with gain 0.5598281 
    ## ... trying feature 127 00X110 with gain 0.5595993 
    ## ... trying feature 128 10X110 with gain 0.5596083 
    ## ... trying feature 129 X0X110 with gain 0.5596115 
    ## ... trying feature 130 01X110 with gain 0.5596515 
    ## ... trying feature 131 11X110 with gain 0.5595967 
    ## ... trying feature 132 X1X110 with gain 0.5595994 
    ## ... trying feature 133 0XX110 with gain 0.5596548 
    ## ... trying feature 134 1XX110 with gain 0.5595972 
    ## ... trying feature 135 XXX110 with gain 0.5596005 
    ## ... trying feature 136 000X10 with gain 0.5596117 
    ## ... trying feature 137 100X10 with gain 0.5596136 
    ## ... trying feature 138 X00X10 with gain 0.5596292 
    ## ... trying feature 139 010X10 with gain 0.5596487 
    ## ... trying feature 140 110X10 with gain 0.5596582 
    ## ... trying feature 141 X10X10 with gain 0.5597105 
    ## ... trying feature 142 0X0X10 with gain 0.5596439 
    ## ... trying feature 143 1X0X10 with gain 0.5596519 
    ## ... trying feature 144 XX0X10 with gain 0.5596995 
    ## ... trying feature 145 001X10 with gain 0.5598284 
    ## ... trying feature 146 101X10 with gain 0.5603626 
    ## ... trying feature 147 X01X10 with gain 0.5596159 
    ## ... trying feature 148 011X10 with gain 0.5599622 
    ## ... trying feature 149 111X10 with gain 0.5597093 
    ## ... trying feature 150 X11X10 with gain 0.5595979 
    ## ... trying feature 151 0X1X10 with gain 0.560193 
    ## ... trying feature 152 1X1X10 with gain 0.5599355 
    ## ... trying feature 153 XX1X10 with gain 0.5595966 
    ## ... trying feature 154 00XX10 with gain 0.5598043 
    ## ... trying feature 155 10XX10 with gain 0.5603803 
    ## ... trying feature 156 X0XX10 with gain 0.5596232 
    ## ... trying feature 157 01XX10 with gain 0.5599258 
    ## ... trying feature 158 11XX10 with gain 0.5596113 
    ## ... trying feature 159 X1XX10 with gain 0.559663 
    ## ... trying feature 160 0XXX10 with gain 0.5601033 
    ## ... trying feature 161 1XXX10 with gain 0.5597127 
    ## ... trying feature 162 XXXX10 with gain 0.5596303 
    ## ... trying feature 163 0000X0 with gain 0.5629946 
    ## ... trying feature 164 1000X0 with gain 0.561931 
    ## ... trying feature 165 X000X0 with gain 0.5646094 
    ## ... trying feature 166 0100X0 with gain 0.5598689 
    ## ... trying feature 167 1100X0 with gain 0.5607575 
    ## ... trying feature 168 X100X0 with gain 0.5608814 
    ## ... trying feature 169 0X00X0 with gain 0.5606546 
    ## ... trying feature 170 1X00X0 with gain 0.5623226 
    ## ... trying feature 171 XX00X0 with gain 0.5632741 
    ## ... trying feature 172 0010X0 with gain 0.5636083 
    ## ... trying feature 173 1010X0 with gain 0.5629291 
    ## ... trying feature 174 X010X0 with gain 0.5671095 
    ## ... trying feature 175 0110X0 with gain 0.5596023 
    ## ... trying feature 176 1110X0 with gain 0.5604176 
    ## ... trying feature 177 X110X0 with gain 0.5599055 
    ## ... trying feature 178 0X10X0 with gain 0.5602375 
    ## ... trying feature 179 1X10X0 with gain 0.5620734 
    ## ... trying feature 180 XX10X0 with gain 0.5624377 
    ## ... trying feature 181 00X0X0 with gain 0.5664947 
    ## ... trying feature 182 10X0X0 with gain 0.5649518 
    ## ... trying feature 183 X0X0X0 with gain 0.5717459 
    ## ... trying feature 184 01X0X0 with gain 0.5596957 
    ## ... trying feature 185 11X0X0 with gain 0.5617411 
    ## ... trying feature 186 X1X0X0 with gain 0.5611714 
    ## ... trying feature 187 0XX0X0 with gain 0.5618011 
    ## ... trying feature 188 1XX0X0 with gain 0.5653974 
    ## ... trying feature 189 XXX0X0 with gain 0.5672519 
    ## ... trying feature 190 0001X0 with gain 0.5596528 
    ## ... trying feature 191 1001X0 with gain 0.5596526 
    ## ... trying feature 192 X001X0 with gain 0.5596681

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 193 0101X0 with gain 0.5599354 
    ## ... trying feature 194 1101X0 with gain 0.5604815 
    ## ... trying feature 195 X101X0 with gain 0.5603171

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 196 0X01X0 with gain 0.560003 
    ## ... trying feature 197 1X01X0 with gain 0.5602398 
    ## ... trying feature 198 XX01X0 with gain 0.5600921 
    ## ... trying feature 199 0011X0 with gain 0.559678 
    ## ... trying feature 200 1011X0 with gain 0.5598967 
    ## ... trying feature 201 X011X0 with gain 0.5599319 
    ## ... trying feature 202 0111X0 with gain 0.5599724 
    ## ... trying feature 203 1111X0 with gain 0.5598655 
    ## ... trying feature 204 X111X0 with gain 0.5599812 
    ## ... trying feature 205 0X11X0 with gain 0.5598555 
    ## ... trying feature 206 1X11X0 with gain 0.5596742 
    ## ... trying feature 207 XX11X0 with gain 0.5597278

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 208 00X1X0 with gain 0.5597371 
    ## ... trying feature 209 10X1X0 with gain 0.5599344 
    ## ... trying feature 210 X0X1X0 with gain 0.559987 
    ## ... trying feature 211 01X1X0 with gain 0.5596567 
    ## ... trying feature 212 11X1X0 with gain 0.5606663 
    ## ... trying feature 213 X1X1X0 with gain 0.5607228 
    ## ... trying feature 214 0XX1X0 with gain 0.559607 
    ## ... trying feature 215 1XX1X0 with gain 0.5601664 
    ## ... trying feature 216 XXX1X0 with gain 0.560179

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 217 000XX0 with gain 0.5630516 
    ## ... trying feature 218 100XX0 with gain 0.5614928 
    ## ... trying feature 219 X00XX0 with gain 0.5638359 
    ## ... trying feature 220 010XX0 with gain 0.5599284 
    ## ... trying feature 221 110XX0 with gain 0.5596357 
    ## ... trying feature 222 X10XX0 with gain 0.5598885 
    ## ... trying feature 223 0X0XX0 with gain 0.5607775 
    ## ... trying feature 224 1X0XX0 with gain 0.5601647 
    ## ... trying feature 225 XX0XX0 with gain 0.5613119 
    ## ... trying feature 226 001XX0 with gain 0.5636748 
    ## ... trying feature 227 101XX0 with gain 0.5627818 
    ## ... trying feature 228 X01XX0 with gain 0.5667753 
    ## ... trying feature 229 011XX0 with gain 0.5596234 
    ## ... trying feature 230 111XX0 with gain 0.5597303 
    ## ... trying feature 231 X11XX0 with gain 0.5596234 
    ## ... trying feature 232 0X1XX0 with gain 0.5601189 
    ## ... trying feature 233 1X1XX0 with gain 0.560789 
    ## ... trying feature 234 XX1XX0 with gain 0.5613126 
    ## ... trying feature 235 00XXX0 with gain 0.5666174 
    ## ... trying feature 236 10XXX0 with gain 0.5646221 
    ## ... trying feature 237 X0XXX0 with gain 0.5710517 
    ## ... trying feature 238 01XXX0 with gain 0.5596746 
    ## ... trying feature 239 11XXX0 with gain 0.5598077 
    ## ... trying feature 240 X1XXX0 with gain 0.559877 
    ## ... trying feature 241 0XXXX0 with gain 0.5617234 
    ## ... trying feature 242 1XXXX0 with gain 0.5619446 
    ## ... trying feature 243 XXXXX0 with gain 0.5640225 
    ## ... trying feature 244 000001 with gain 0.5601866 
    ## ... trying feature 245 100001 with gain 0.5630566 
    ## ... trying feature 246 X00001 with gain 0.5631743 
    ## ... trying feature 247 010001 with gain 0.560723 
    ## ... trying feature 248 110001 with gain 0.5628096 
    ## ... trying feature 249 X10001 with gain 0.563495 
    ## ... trying feature 250 0X0001 with gain 0.5601136 
    ## ... trying feature 251 1X0001 with gain 0.560654 
    ## ... trying feature 252 XX0001 with gain 0.5610736 
    ## ... trying feature 253 001001 with gain 0.5597311 
    ## ... trying feature 254 101001 with gain 0.5602686 
    ## ... trying feature 255 X01001 with gain 0.5602634 
    ## ... trying feature 256 011001 with gain 0.5601265 
    ## ... trying feature 257 111001 with gain 0.5610062 
    ## ... trying feature 258 X11001 with gain 0.5596951 
    ## ... trying feature 259 0X1001 with gain 0.5598944 
    ## ... trying feature 260 1X1001 with gain 0.5616251 
    ## ... trying feature 261 XX1001 with gain 0.5599629 
    ## ... trying feature 262 00X001 with gain 0.5602261 
    ## ... trying feature 263 10X001 with gain 0.5633783 
    ## ... trying feature 264 X0X001 with gain 0.5632112 
    ## ... trying feature 265 01X001 with gain 0.5618977 
    ## ... trying feature 266 11X001 with gain 0.559722 
    ## ... trying feature 267 X1X001 with gain 0.5613083 
    ## ... trying feature 268 0XX001 with gain 0.5608507 
    ## ... trying feature 269 1XX001 with gain 0.5597652 
    ## ... trying feature 270 XXX001 with gain 0.559813 
    ## ... trying feature 271 000101 with gain 0.5596649 
    ## ... trying feature 272 100101 with gain 0.5606952 
    ## ... trying feature 273 X00101 with gain 0.5607386

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 274 010101 with gain 0.5599552 
    ## ... trying feature 275 110101 with gain 0.5608318 
    ## ... trying feature 276 X10101 with gain 0.5606389

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 277 0X0101 with gain 0.5600383 
    ## ... trying feature 278 1X0101 with gain 0.5598777 
    ## ... trying feature 279 XX0101 with gain 0.559792 
    ## ... trying feature 280 001101 with gain 0.5597104 
    ## ... trying feature 281 101101 with gain 0.5603876 
    ## ... trying feature 282 X01101 with gain 0.5604641 
    ## ... trying feature 283 011101 with gain 0.5598339 
    ## ... trying feature 284 111101 with gain 0.5632983 
    ## ... trying feature 285 X11101 with gain 0.5635174 
    ## ... trying feature 286 0X1101 with gain 0.5597242 
    ## ... trying feature 287 1X1101 with gain 0.5621473 
    ## ... trying feature 288 XX1101 with gain 0.5622689

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 289 00X101 with gain 0.5597835 
    ## ... trying feature 290 10X101 with gain 0.5615112 
    ## ... trying feature 291 X0X101 with gain 0.5616323 
    ## ... trying feature 292 01X101 with gain 0.5596122 
    ## ... trying feature 293 11X101 with gain 0.5649406 
    ## ... trying feature 294 X1X101 with gain 0.5649317 
    ## ... trying feature 295 0XX101 with gain 0.5595992 
    ## ... trying feature 296 1XX101 with gain 0.5624268 
    ## ... trying feature 297 XXX101 with gain 0.5623587 
    ## ... trying feature 298 000X01 with gain 0.5602201 
    ## ... trying feature 299 100X01 with gain 0.5635044 
    ## ... trying feature 300 X00X01 with gain 0.5640115 
    ## ... trying feature 301 010X01 with gain 0.5605986 
    ## ... trying feature 302 110X01 with gain 0.5644968 
    ## ... trying feature 303 X10X01 with gain 0.5647974 
    ## ... trying feature 304 0X0X01 with gain 0.5600231 
    ## ... trying feature 305 1X0X01 with gain 0.5610671 
    ## ... trying feature 306 XX0X01 with gain 0.5613752 
    ## ... trying feature 307 001X01 with gain 0.5597581 
    ## ... trying feature 308 101X01 with gain 0.5610283 
    ## ... trying feature 309 X01X01 with gain 0.5609391 
    ## ... trying feature 310 011X01 with gain 0.5602193 
    ## ... trying feature 311 111X01 with gain 0.5597883 
    ## ... trying feature 312 X11X01 with gain 0.5603053 
    ## ... trying feature 313 0X1X01 with gain 0.5599445 
    ## ... trying feature 314 1X1X01 with gain 0.5595961 
    ## ... trying feature 315 XX1X01 with gain 0.5597399 
    ## ... trying feature 316 00XX01 with gain 0.5602925 
    ## ... trying feature 317 10XX01 with gain 0.5649545 
    ## ... trying feature 318 X0XX01 with gain 0.5650474 
    ## ... trying feature 319 01XX01 with gain 0.5619086 
    ## ... trying feature 320 11XX01 with gain 0.5643149 
    ## ... trying feature 321 X1XX01 with gain 0.5666092 
    ## ... trying feature 322 0XXX01 with gain 0.5608136 
    ## ... trying feature 323 1XXX01 with gain 0.5606635 
    ## ... trying feature 324 XXXX01 with gain 0.5618783 
    ## ... trying feature 325 000011 with gain 0.5598606 
    ## ... trying feature 326 100011 with gain 0.5598019 
    ## ... trying feature 327 X00011 with gain 0.5595997 
    ## ... trying feature 328 010011 with gain 0.5600087 
    ## ... trying feature 329 110011 with gain 0.5617353 
    ## ... trying feature 330 X10011 with gain 0.5617969 
    ## ... trying feature 331 0X0011 with gain 0.5598195 
    ## ... trying feature 332 1X0011 with gain 0.5619026 
    ## ... trying feature 333 XX0011 with gain 0.5615114 
    ## ... trying feature 334 001011 with gain 0.5598039 
    ## ... trying feature 335 101011 with gain 0.5595961 
    ## ... trying feature 336 X01011 with gain 0.5598039 
    ## ... trying feature 337 011011 with gain 0.5605064 
    ## ... trying feature 338 111011 with gain 0.5605632 
    ## ... trying feature 339 X11011 with gain 0.561085 
    ## ... trying feature 340 0X1011 with gain 0.5602939 
    ## ... trying feature 341 1X1011 with gain 0.5605632 
    ## ... trying feature 342 XX1011 with gain 0.5608118 
    ## ... trying feature 343 00X011 with gain 0.5600676 
    ## ... trying feature 344 10X011 with gain 0.5598019 
    ## ... trying feature 345 X0X011 with gain 0.5596573 
    ## ... trying feature 346 01X011 with gain 0.5609223 
    ## ... trying feature 347 11X011 with gain 0.5626026 
    ## ... trying feature 348 X1X011 with gain 0.5630441 
    ## ... trying feature 349 0XX011 with gain 0.5605006 
    ## ... trying feature 350 1XX011 with gain 0.562774 
    ## ... trying feature 351 XXX011 with gain 0.562531 
    ## ... trying feature 352 000111 with gain 0.5595966 
    ## ... trying feature 353 X00111 with gain 0.5595966 
    ## ... trying feature 354 010111 with gain 0.5596107 
    ## ... trying feature 355 110111 with gain 0.5599216 
    ## ... trying feature 356 X10111 with gain 0.559887 
    ## ... trying feature 357 0X0111 with gain 0.5596112 
    ## ... trying feature 358 1X0111 with gain 0.5599216 
    ## ... trying feature 359 XX0111 with gain 0.5598859 
    ## ... trying feature 360 001111 with gain 0.5595961 
    ## ... trying feature 361 101111 with gain 0.5596578 
    ## ... trying feature 362 X01111 with gain 0.5596578 
    ## ... trying feature 363 011111 with gain 0.5596297 
    ## ... trying feature 364 111111 with gain 0.5596313 
    ## ... trying feature 365 X11111 with gain 0.5596205 
    ## ... trying feature 366 0X1111 with gain 0.5596297 
    ## ... trying feature 367 1X1111 with gain 0.5596594 
    ## ... trying feature 368 XX1111 with gain 0.5596445 
    ## ... trying feature 369 00X111 with gain 0.5595966 
    ## ... trying feature 370 10X111 with gain 0.5596578 
    ## ... trying feature 371 X0X111 with gain 0.559656 
    ## ... trying feature 372 01X111 with gain 0.5596446 
    ## ... trying feature 373 11X111 with gain 0.5598413 
    ## ... trying feature 374 X1X111 with gain 0.559798 
    ## ... trying feature 375 0XX111 with gain 0.5596451 
    ## ... trying feature 376 1XX111 with gain 0.559889 
    ## ... trying feature 377 XXX111 with gain 0.5598413 
    ## ... trying feature 378 000X11 with gain 0.5598611 
    ## ... trying feature 379 100X11 with gain 0.5598019 
    ## ... trying feature 380 X00X11 with gain 0.5595998 
    ## ... trying feature 381 010X11 with gain 0.5599926 
    ## ... trying feature 382 110X11 with gain 0.5620472 
    ## ... trying feature 383 X10X11 with gain 0.5621132 
    ## ... trying feature 384 0X0X11 with gain 0.5598092 
    ## ... trying feature 385 1X0X11 with gain 0.5622101 
    ## ... trying feature 386 XX0X11 with gain 0.5618231 
    ## ... trying feature 387 001X11 with gain 0.5598039 
    ## ... trying feature 388 101X11 with gain 0.5596578 
    ## ... trying feature 389 X01X11 with gain 0.5596156 
    ## ... trying feature 390 011X11 with gain 0.5604616 
    ## ... trying feature 391 111X11 with gain 0.5600756 
    ## ... trying feature 392 X11X11 with gain 0.560945 
    ## ... trying feature 393 0X1X11 with gain 0.5602585 
    ## ... trying feature 394 1X1X11 with gain 0.5601344 
    ## ... trying feature 395 XX1X11 with gain 0.5607732 
    ## ... trying feature 396 00XX11 with gain 0.5600681 
    ## ... trying feature 397 10XX11 with gain 0.5598295 
    ## ... trying feature 398 X0XX11 with gain 0.5596149 
    ## ... trying feature 399 01XX11 with gain 0.5608623 
    ## ... trying feature 400 11XX11 with gain 0.5624498 
    ## ... trying feature 401 X1XX11 with gain 0.5631893 
    ## ... trying feature 402 0XXX11 with gain 0.5604564 
    ## ... trying feature 403 1XXX11 with gain 0.5626794 
    ## ... trying feature 404 XXXX11 with gain 0.5627789 
    ## ... trying feature 405 0000X1 with gain 0.5603106 
    ## ... trying feature 406 1000X1 with gain 0.5625665 
    ## ... trying feature 407 X000X1 with gain 0.5630076 
    ## ... trying feature 408 0100X1 with gain 0.5610572 
    ## ... trying feature 409 1100X1 with gain 0.564152 
    ## ... trying feature 410 X100X1 with gain 0.564967 
    ## ... trying feature 411 0X00X1 with gain 0.5602887 
    ## ... trying feature 412 1X00X1 with gain 0.5615648 
    ## ... trying feature 413 XX00X1 with gain 0.5620194 
    ## ... trying feature 414 0010X1 with gain 0.5597793 
    ## ... trying feature 415 1010X1 with gain 0.5602686 
    ## ... trying feature 416 X010X1 with gain 0.5603375 
    ## ... trying feature 417 0110X1 with gain 0.5606106 
    ## ... trying feature 418 1110X1 with gain 0.5607254 
    ## ... trying feature 419 X110X1 with gain 0.5595963 
    ## ... trying feature 420 0X10X1 with gain 0.5602262 
    ## ... trying feature 421 1X10X1 with gain 0.5612973 
    ## ... trying feature 422 XX10X1 with gain 0.5597079 
    ## ... trying feature 423 00X0X1 with gain 0.560393 
    ## ... trying feature 424 10X0X1 with gain 0.5630438 
    ## ... trying feature 425 X0X0X1 with gain 0.5632683 
    ## ... trying feature 426 01X0X1 with gain 0.563297 
    ## ... trying feature 427 11X0X1 with gain 0.5601525 
    ## ... trying feature 428 X1X0X1 with gain 0.5630439 
    ## ... trying feature 429 0XX0X1 with gain 0.5618011 
    ## ... trying feature 430 1XX0X1 with gain 0.5595961 
    ## ... trying feature 431 XXX0X1 with gain 0.5606125 
    ## ... trying feature 432 0001X1 with gain 0.5596654 
    ## ... trying feature 433 1001X1 with gain 0.5606952 
    ## ... trying feature 434 X001X1 with gain 0.5607389

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 435 0101X1 with gain 0.5599728 
    ## ... trying feature 436 1101X1 with gain 0.561052 
    ## ... trying feature 437 X101X1 with gain 0.5608341

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 438 0X01X1 with gain 0.5600573 
    ## ... trying feature 439 1X01X1 with gain 0.5599864 
    ## ... trying feature 440 XX01X1 with gain 0.5598806 
    ## ... trying feature 441 0011X1 with gain 0.5597104 
    ## ... trying feature 442 1011X1 with gain 0.5602423 
    ## ... trying feature 443 X011X1 with gain 0.5603118 
    ## ... trying feature 444 0111X1 with gain 0.5597964 
    ## ... trying feature 445 1111X1 with gain 0.5632904 
    ## ... trying feature 446 X111X1 with gain 0.5634843 
    ## ... trying feature 447 0X11X1 with gain 0.5596991 
    ## ... trying feature 448 1X11X1 with gain 0.5622119 
    ## ... trying feature 449 XX11X1 with gain 0.5623148

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 450 00X1X1 with gain 0.5597841 
    ## ... trying feature 451 10X1X1 with gain 0.5613674 
    ## ... trying feature 452 X0X1X1 with gain 0.5614847 
    ## ... trying feature 453 01X1X1 with gain 0.5596022 
    ## ... trying feature 454 11X1X1 with gain 0.5652581 
    ## ... trying feature 455 X1X1X1 with gain 0.5652103 
    ## ... trying feature 456 0XX1X1 with gain 0.559607 
    ## ... trying feature 457 1XX1X1 with gain 0.562735 
    ## ... trying feature 458 XXX1X1 with gain 0.5626383 
    ## ... trying feature 459 000XX1 with gain 0.5603464 
    ## ... trying feature 460 100XX1 with gain 0.5631783 
    ## ... trying feature 461 X00XX1 with gain 0.5638931 
    ## ... trying feature 462 010XX1 with gain 0.5609099 
    ## ... trying feature 463 110XX1 with gain 0.566198 
    ## ... trying feature 464 X10XX1 with gain 0.5664668 
    ## ... trying feature 465 0X0XX1 with gain 0.5601803 
    ## ... trying feature 466 1X0XX1 with gain 0.5621435 
    ## ... trying feature 467 XX0XX1 with gain 0.5624381 
    ## ... trying feature 468 001XX1 with gain 0.5598096 
    ## ... trying feature 469 101XX1 with gain 0.5609212 
    ## ... trying feature 470 X01XX1 with gain 0.5609573 
    ## ... trying feature 471 011XX1 with gain 0.5607189 
    ## ... trying feature 472 111XX1 with gain 0.5599092 
    ## ... trying feature 473 X11XX1 with gain 0.5608302 
    ## ... trying feature 474 0X1XX1 with gain 0.5602853 
    ## ... trying feature 475 1X1XX1 with gain 0.5596134 
    ## ... trying feature 476 XX1XX1 with gain 0.5600002 
    ## ... trying feature 477 00XXX1 with gain 0.5604653 
    ## ... trying feature 478 10XXX1 with gain 0.5645427 
    ## ... trying feature 479 X0XXX1 with gain 0.5649315 
    ## ... trying feature 480 01XXX1 with gain 0.5632732 
    ## ... trying feature 481 11XXX1 with gain 0.5665064 
    ## ... trying feature 482 X1XXX1 with gain 0.5699878 
    ## ... trying feature 483 0XXXX1 with gain 0.5617234 
    ## ... trying feature 484 1XXXX1 with gain 0.5619446 
    ## ... trying feature 485 XXXXX1 with gain 0.5640225 
    ## ... trying feature 486 00000X with gain 0.5621935 
    ## ... trying feature 487 10000X with gain 0.5656507 
    ## ... trying feature 488 X0000X with gain 0.5681891 
    ## ... trying feature 489 01000X with gain 0.5598159 
    ## ... trying feature 490 11000X with gain 0.5602452 
    ## ... trying feature 491 X1000X with gain 0.5604398 
    ## ... trying feature 492 0X000X with gain 0.559635 
    ## ... trying feature 493 1X000X with gain 0.5596559 
    ## ... trying feature 494 XX000X with gain 0.5596967 
    ## ... trying feature 495 00100X with gain 0.5631124 
    ## ... trying feature 496 10100X with gain 0.5627358 
    ## ... trying feature 497 X0100X with gain 0.566236 
    ## ... trying feature 498 01100X with gain 0.559939 
    ## ... trying feature 499 11100X with gain 0.5622795 
    ## ... trying feature 500 X1100X with gain 0.5601918 
    ## ... trying feature 501 0X100X with gain 0.559742 
    ## ... trying feature 502 1X100X with gain 0.5648968 
    ## ... trying feature 503 XX100X with gain 0.5634134 
    ## ... trying feature 504 00X00X with gain 0.5660293 
    ## ... trying feature 505 10X00X with gain 0.5685271 
    ## ... trying feature 506 X0X00X with gain 0.574789 
    ## ... trying feature 507 01X00X with gain 0.5614528 
    ## ... trying feature 508 11X00X with gain 0.5603014 
    ## ... trying feature 509 X1X00X with gain 0.5596 
    ## ... trying feature 510 0XX00X with gain 0.5611015 
    ## ... trying feature 511 1XX00X with gain 0.5654511 
    ## ... trying feature 512 XXX00X with gain 0.5668168 
    ## ... trying feature 513 00010X with gain 0.5597235 
    ## ... trying feature 514 10010X with gain 0.5605131 
    ## ... trying feature 515 X0010X with gain 0.5605769

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 516 01010X with gain 0.5603359 
    ## ... trying feature 517 11010X with gain 0.5616436 
    ## ... trying feature 518 X1010X with gain 0.561299

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 519 0X010X with gain 0.5605254 
    ## ... trying feature 520 1X010X with gain 0.5603929 
    ## ... trying feature 521 XX010X with gain 0.5601758 
    ## ... trying feature 522 00110X with gain 0.559794 
    ## ... trying feature 523 10110X with gain 0.56061 
    ## ... trying feature 524 X0110X with gain 0.5607146

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 525 01110X with gain 0.5610704 
    ## ... trying feature 526 11110X with gain 0.5637777 
    ## ... trying feature 527 X1110X with gain 0.5643021

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 528 0X110X with gain 0.5607047 
    ## ... trying feature 529 1X110X with gain 0.5621243 
    ## ... trying feature 530 XX110X with gain 0.5624498

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 531 00X10X with gain 0.5599356 
    ## ... trying feature 532 10X10X with gain 0.5615754 
    ## ... trying feature 533 X0X10X with gain 0.5617488

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 534 01X10X with gain 0.5600663 
    ## ... trying feature 535 11X10X with gain 0.5672981 
    ## ... trying feature 536 X1X10X with gain 0.5675319 
    ## ... trying feature 537 0XX10X with gain 0.5597053 
    ## ... trying feature 538 1XX10X with gain 0.5638091 
    ## ... trying feature 539 XXX10X with gain 0.5638534 
    ## ... trying feature 540 000X0X with gain 0.562284 
    ## ... trying feature 541 100X0X with gain 0.5655323 
    ## ... trying feature 542 X00X0X with gain 0.5683488 
    ## ... trying feature 543 010X0X with gain 0.5597404 
    ## ... trying feature 544 110X0X with gain 0.5624364 
    ## ... trying feature 545 X10X0X with gain 0.561947 
    ## ... trying feature 546 0X0X0X with gain 0.5596834 
    ## ... trying feature 547 1X0X0X with gain 0.5597863 
    ## ... trying feature 548 XX0X0X with gain 0.5596139 
    ## ... trying feature 549 001X0X with gain 0.5632404 
    ## ... trying feature 550 101X0X with gain 0.5638161 
    ## ... trying feature 551 X01X0X with gain 0.5675162 
    ## ... trying feature 552 011X0X with gain 0.5601091 
    ## ... trying feature 553 111X0X with gain 0.5596294 
    ## ... trying feature 554 X11X0X with gain 0.5599777 
    ## ... trying feature 555 0X1X0X with gain 0.5596675 
    ## ... trying feature 556 1X1X0X with gain 0.5602243 
    ## ... trying feature 557 XX1X0X with gain 0.5602167 
    ## ... trying feature 558 00XX0X with gain 0.5662594 
    ## ... trying feature 559 10XX0X with gain 0.5699645 
    ## ... trying feature 560 X0XX0X with gain 0.5768694 
    ## ... trying feature 561 01XX0X with gain 0.5616253 
    ## ... trying feature 562 11XX0X with gain 0.5650896 
    ## ... trying feature 563 X1XX0X with gain 0.5671379 
    ## ... trying feature 564 0XXX0X with gain 0.5610054 
    ## ... trying feature 565 1XXX0X with gain 0.5603392 
    ## ... trying feature 566 XXXX0X with gain 0.561636 
    ## ... trying feature 567 00001X with gain 0.559876 
    ## ... trying feature 568 10001X with gain 0.5597379 
    ## ... trying feature 569 X0001X with gain 0.559603 
    ## ... trying feature 570 01001X with gain 0.5599983 
    ## ... trying feature 571 11001X with gain 0.560865 
    ## ... trying feature 572 X1001X with gain 0.5610848 
    ## ... trying feature 573 0X001X with gain 0.5598563 
    ## ... trying feature 574 1X001X with gain 0.5609897 
    ## ... trying feature 575 XX001X with gain 0.5609339 
    ## ... trying feature 576 00101X with gain 0.5596571 
    ## ... trying feature 577 10101X with gain 0.5603626 
    ## ... trying feature 578 X0101X with gain 0.5596704 
    ## ... trying feature 579 01101X with gain 0.56093 
    ## ... trying feature 580 11101X with gain 0.5597069 
    ## ... trying feature 581 X1101X with gain 0.5608635 
    ## ... trying feature 582 0X101X with gain 0.5609613 
    ## ... trying feature 583 1X101X with gain 0.5595963 
    ## ... trying feature 584 XX101X with gain 0.5604746 
    ## ... trying feature 585 00X01X with gain 0.5595964 
    ## ... trying feature 586 10X01X with gain 0.5597812 
    ## ... trying feature 587 X0X01X with gain 0.5596712 
    ## ... trying feature 588 01X01X with gain 0.5612703 
    ## ... trying feature 589 11X01X with gain 0.5606814 
    ## ... trying feature 590 X1X01X with gain 0.5621989 
    ## ... trying feature 591 0XX01X with gain 0.5611015 
    ## ... trying feature 592 1XX01X with gain 0.560275 
    ## ... trying feature 593 XXX01X with gain 0.5616681 
    ## ... trying feature 594 00011X with gain 0.5595968 
    ## ... trying feature 595 10011X with gain 0.5596083 
    ## ... trying feature 596 X0011X with gain 0.5596089 
    ## ... trying feature 597 01011X with gain 0.5596351 
    ## ... trying feature 598 11011X with gain 0.5604102 
    ## ... trying feature 599 X1011X with gain 0.5602831 
    ## ... trying feature 600 0X011X with gain 0.5596358 
    ## ... trying feature 601 1X011X with gain 0.5603644 
    ## ... trying feature 602 XX011X with gain 0.5602491 
    ## ... trying feature 603 00111X with gain 0.5595992 
    ## ... trying feature 604 10111X with gain 0.5596578 
    ## ... trying feature 605 X0111X with gain 0.5596484 
    ## ... trying feature 606 01111X with gain 0.559661 
    ## ... trying feature 607 11111X with gain 0.5596405 
    ## ... trying feature 608 X1111X with gain 0.5596544 
    ## ... trying feature 609 0X111X with gain 0.5596642 
    ## ... trying feature 610 1X111X with gain 0.5596207 
    ## ... trying feature 611 XX111X with gain 0.5596319 
    ## ... trying feature 612 00X11X with gain 0.5595998 
    ## ... trying feature 613 10X11X with gain 0.559631 
    ## ... trying feature 614 X0X11X with gain 0.559626 
    ## ... trying feature 615 01X11X with gain 0.5597013 
    ## ... trying feature 616 11X11X with gain 0.559692 
    ## ... trying feature 617 X1X11X with gain 0.5596622 
    ## ... trying feature 618 0XX11X with gain 0.5597053 
    ## ... trying feature 619 1XX11X with gain 0.5597121 
    ## ... trying feature 620 XXX11X with gain 0.5596777 
    ## ... trying feature 621 000X1X with gain 0.5598767 
    ## ... trying feature 622 100X1X with gain 0.559695 
    ## ... trying feature 623 X00X1X with gain 0.5596055 
    ## ... trying feature 624 010X1X with gain 0.5599715 
    ## ... trying feature 625 110X1X with gain 0.5615412 
    ## ... trying feature 626 X10X1X with gain 0.5616181 
    ## ... trying feature 627 0X0X1X with gain 0.5598362 
    ## ... trying feature 628 1X0X1X with gain 0.5616434 
    ## ... trying feature 629 XX0X1X with gain 0.5614318 
    ## ... trying feature 630 001X1X with gain 0.5596554 
    ## ... trying feature 631 101X1X with gain 0.5598965 
    ## ... trying feature 632 X01X1X with gain 0.559633 
    ## ... trying feature 633 011X1X with gain 0.5608438 
    ## ... trying feature 634 111X1X with gain 0.5596062 
    ## ... trying feature 635 X11X1X with gain 0.5603285 
    ## ... trying feature 636 0X1X1X with gain 0.5608789 
    ## ... trying feature 637 1X1X1X with gain 0.559605 
    ## ... trying feature 638 XX1X1X with gain 0.5601338 
    ## ... trying feature 639 00XX1X with gain 0.5595963 
    ## ... trying feature 640 10XX1X with gain 0.5596978 
    ## ... trying feature 641 X0XX1X with gain 0.5596421 
    ## ... trying feature 642 01XX1X with gain 0.5611631 
    ## ... trying feature 643 11XX1X with gain 0.560614 
    ## ... trying feature 644 X1XX1X with gain 0.5620489 
    ## ... trying feature 645 0XXX1X with gain 0.5610054 
    ## ... trying feature 646 1XXX1X with gain 0.5603392 
    ## ... trying feature 647 XXXX1X with gain 0.561636 
    ## ... trying feature 648 0000XX with gain 0.5623897 
    ## ... trying feature 649 1000XX with gain 0.565165 
    ## ... trying feature 650 X000XX with gain 0.5679611 
    ## ... trying feature 651 0100XX with gain 0.5600317 
    ## ... trying feature 652 1100XX with gain 0.5607829 
    ## ... trying feature 653 X100XX with gain 0.5611933 
    ## ... trying feature 654 0X00XX with gain 0.5595973 
    ## ... trying feature 655 1X00XX with gain 0.5596021 
    ## ... trying feature 656 XX00XX with gain 0.5595971 
    ## ... trying feature 657 0010XX with gain 0.5626567 
    ## ... trying feature 658 1010XX with gain 0.5632396 
    ## ... trying feature 659 X010XX with gain 0.5662477 
    ## ... trying feature 660 0110XX with gain 0.5605268 
    ## ... trying feature 661 1110XX with gain 0.5619507 
    ## ... trying feature 662 X110XX with gain 0.5597921 
    ## ... trying feature 663 0X10XX with gain 0.5595973 
    ## ... trying feature 664 1X10XX with gain 0.5647444 
    ## ... trying feature 665 XX10XX with gain 0.5623314 
    ## ... trying feature 666 00X0XX with gain 0.5657095 
    ## ... trying feature 667 10X0XX with gain 0.5687374 
    ## ... trying feature 668 X0X0XX with gain 0.574714 
    ## ... trying feature 669 01X0XX with gain 0.5657095 
    ## ... trying feature 670 11X0XX with gain 0.559847 
    ## ... trying feature 671 X1X0XX with gain 0.5602094 
    ## ... trying feature 673 1XX0XX with gain 0.5641425 
    ## ... trying feature 674 XXX0XX with gain 0.5641425 
    ## ... trying feature 675 0001XX with gain 0.5597242 
    ## ... trying feature 676 1001XX with gain 0.5605193 
    ## ... trying feature 677 X001XX with gain 0.5605838

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 678 0101XX with gain 0.5603932 
    ## ... trying feature 679 1101XX with gain 0.562139 
    ## ... trying feature 680 X101XX with gain 0.5617282

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 681 0X01XX with gain 0.5605898 
    ## ... trying feature 682 1X01XX with gain 0.5607018 
    ## ... trying feature 683 XX01XX with gain 0.5604298 
    ## ... trying feature 684 0011XX with gain 0.5597974 
    ## ... trying feature 685 1011XX with gain 0.5605104 
    ## ... trying feature 686 X011XX with gain 0.5606118

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 687 0111XX with gain 0.5609386 
    ## ... trying feature 688 1111XX with gain 0.5634032 
    ## ... trying feature 689 X111XX with gain 0.5638713

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 690 0X11XX with gain 0.5605898 
    ## ... trying feature 691 1X11XX with gain 0.5619215 
    ## ... trying feature 692 XX11XX with gain 0.5622073

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 693 00X1XX with gain 0.55994 
    ## ... trying feature 694 10X1XX with gain 0.5614889 
    ## ... trying feature 695 X0X1XX with gain 0.5616618

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 696 01X1XX with gain 0.55994 
    ## ... trying feature 697 11X1XX with gain 0.5675869 
    ## ... trying feature 698 X1X1XX with gain 0.5677627 
    ## ... trying feature 699 0XX1XX with gain 0.5595961 
    ## ... trying feature 700 1XX1XX with gain 0.5641425 
    ## ... trying feature 701 XXX1XX with gain 0.5641425 
    ## ... trying feature 702 000XXX with gain 0.5624819 
    ## ... trying feature 703 100XXX with gain 0.5652388 
    ## ... trying feature 704 X00XXX with gain 0.568235 
    ## ... trying feature 705 010XXX with gain 0.5599159 
    ## ... trying feature 706 110XXX with gain 0.5637629 
    ## ... trying feature 707 X10XXX with gain 0.5633172 
    ## ... trying feature 708 0X0XXX with gain 0.5596153 
    ## ... trying feature 709 1X0XXX with gain 0.5602843 
    ## ... trying feature 710 XX0XXX with gain 0.5598912 
    ## ... trying feature 711 001XXX with gain 0.5627782 
    ## ... trying feature 712 101XXX with gain 0.5641491 
    ## ... trying feature 713 X01XXX with gain 0.5674069 
    ## ... trying feature 714 011XXX with gain 0.5607714 
    ## ... trying feature 715 111XXX with gain 0.5596419 
    ## ... trying feature 716 X11XXX with gain 0.5603889 
    ## ... trying feature 717 0X1XXX with gain 0.5596153 
    ## ... trying feature 718 1X1XXX with gain 0.5602843 
    ## ... trying feature 719 XX1XXX with gain 0.5598912 
    ## ... trying feature 720 00XXXX with gain 0.5659347 
    ## ... trying feature 721 10XXXX with gain 0.5700981 
    ## ... trying feature 722 X0XXXX with gain 0.5766696 
    ## ... trying feature 723 01XXXX with gain 0.5659347 
    ## ... trying feature 724 11XXXX with gain 0.5700981 
    ## ... trying feature 725 X1XXXX with gain 0.5766696 
    ## ... trying feature 727 1XXXXX with gain 0.5595961 
    ## ... Using feature 560 X0XX0X 
    ## Adding Feature Number 4 
    ## ... trying feature 1 000000 with gain 0.5781041 
    ## ... trying feature 2 100000 with gain 0.5771514 
    ## ... trying feature 3 X00000 with gain 0.577783 
    ## ... trying feature 4 010000 with gain 0.5777689 
    ## ... trying feature 5 110000 with gain 0.5787169 
    ## ... trying feature 6 X10000 with gain 0.5796323 
    ## ... trying feature 7 0X0000 with gain 0.5781765 
    ## ... trying feature 8 1X0000 with gain 0.5790578 
    ## ... trying feature 9 XX0000 with gain 0.5804659 
    ## ... trying feature 10 001000 with gain 0.5782403 
    ## ... trying feature 11 101000 with gain 0.5769856 
    ## ... trying feature 12 X01000 with gain 0.57808 
    ## ... trying feature 13 011000 with gain 0.577156 
    ## ... trying feature 14 111000 with gain 0.5794631 
    ## ... trying feature 15 X11000 with gain 0.5790388 
    ## ... trying feature 16 0X1000 with gain 0.5776442 
    ## ... trying feature 17 1X1000 with gain 0.5794776 
    ## ... trying feature 18 XX1000 with gain 0.579928 
    ## ... trying feature 19 00X000 with gain 0.579332 
    ## ... trying feature 20 10X000 with gain 0.5772555 
    ## ... trying feature 21 X0X000 with gain 0.579275 
    ## ... trying feature 22 01X000 with gain 0.5782228 
    ## ... trying feature 23 11X000 with gain 0.5818111 
    ## ... trying feature 24 X1X000 with gain 0.582618 
    ## ... trying feature 25 0XX000 with gain 0.5794974 
    ## ... trying feature 26 1XX000 with gain 0.582085 
    ## ... trying feature 27 XXX000 with gain 0.5844805 
    ## ... trying feature 28 000100 with gain 0.5768873 
    ## ... trying feature 29 100100 with gain 0.5774164 
    ## ... trying feature 30 X00100 with gain 0.5773907

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 010100 with gain 0.5772258 
    ## ... trying feature 32 110100 with gain 0.5771267 
    ## ... trying feature 33 X10100 with gain 0.5770441

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 34 0X0100 with gain 0.5772473 
    ## ... trying feature 35 1X0100 with gain 0.577417 
    ## ... trying feature 36 XX0100 with gain 0.5772909 
    ## ... trying feature 37 001100 with gain 0.5768941 
    ## ... trying feature 38 101100 with gain 0.57703 
    ## ... trying feature 39 X01100 with gain 0.5770168 
    ## ... trying feature 40 011100 with gain 0.577202 
    ## ... trying feature 41 111100 with gain 0.5771409 
    ## ... trying feature 42 X11100 with gain 0.5772542 
    ## ... trying feature 43 0X1100 with gain 0.5771662 
    ## ... trying feature 44 1X1100 with gain 0.5772715 
    ## ... trying feature 45 XX1100 with gain 0.5773907

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 46 00X100 with gain 0.5769122 
    ## ... trying feature 47 10X100 with gain 0.5775424 
    ## ... trying feature 48 X0X100 with gain 0.5775034 
    ## ... trying feature 49 01X100 with gain 0.5769102 
    ## ... trying feature 50 11X100 with gain 0.5774427 
    ## ... trying feature 51 X1X100 with gain 0.5774796 
    ## ... trying feature 52 0XX100 with gain 0.5768943 
    ## ... trying feature 53 1XX100 with gain 0.5778923 
    ## ... trying feature 54 XXX100 with gain 0.57792

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 55 000X00 with gain 0.578123 
    ## ... trying feature 56 100X00 with gain 0.5768718 
    ## ... trying feature 57 X00X00 with gain 0.5770217 
    ## ... trying feature 58 010X00 with gain 0.5778767 
    ## ... trying feature 59 110X00 with gain 0.5773447 
    ## ... trying feature 60 X10X00 with gain 0.5783397 
    ## ... trying feature 61 0X0X00 with gain 0.5783071 
    ## ... trying feature 62 1X0X00 with gain 0.5772634 
    ## ... trying feature 63 XX0X00 with gain 0.578525 
    ## ... trying feature 64 001X00 with gain 0.5782611 
    ## ... trying feature 65 101X00 with gain 0.5768695 
    ## ... trying feature 66 X01X00 with gain 0.5774397 
    ## ... trying feature 67 011X00 with gain 0.5770679 
    ## ... trying feature 68 111X00 with gain 0.5777056 
    ## ... trying feature 69 X11X00 with gain 0.5778306 
    ## ... trying feature 70 0X1X00 with gain 0.5774994 
    ## ... trying feature 71 1X1X00 with gain 0.5776108 
    ## ... trying feature 72 XX1X00 with gain 0.5782508 
    ## ... trying feature 73 00XX00 with gain 0.5793742 
    ## ... trying feature 74 10XX00 with gain 0.5768713 
    ## ... trying feature 75 X0XX00 with gain 0.5777786 
    ## ... trying feature 76 01XX00 with gain 0.5781354 
    ## ... trying feature 77 11XX00 with gain 0.578531 
    ## ... trying feature 78 X1XX00 with gain 0.5798321 
    ## ... trying feature 79 0XXX00 with gain 0.5793826 
    ## ... trying feature 80 1XXX00 with gain 0.5783319 
    ## ... trying feature 81 XXXX00 with gain 0.5806402 
    ## ... trying feature 82 000010 with gain 0.5768885 
    ## ... trying feature 83 100010 with gain 0.5768769 
    ## ... trying feature 84 X00010 with gain 0.576896 
    ## ... trying feature 85 010010 with gain 0.5768737 
    ## ... trying feature 86 110010 with gain 0.5769634 
    ## ... trying feature 87 X10010 with gain 0.5768818 
    ## ... trying feature 88 0X0010 with gain 0.5768722 
    ## ... trying feature 89 1X0010 with gain 0.5769668 
    ## ... trying feature 90 XX0010 with gain 0.576885 
    ## ... trying feature 91 001010 with gain 0.5770089 
    ## ... trying feature 92 101010 with gain 0.5778334 
    ## ... trying feature 93 X01010 with gain 0.5769624 
    ## ... trying feature 94 011010 with gain 0.5770866 
    ## ... trying feature 95 111010 with gain 0.5769015 
    ## ... trying feature 96 X11010 with gain 0.5768917 
    ## ... trying feature 97 0X1010 with gain 0.5772255 
    ## ... trying feature 98 1X1010 with gain 0.5771572 
    ## ... trying feature 99 XX1010 with gain 0.5768698 
    ## ... trying feature 100 00X010 with gain 0.5769889 
    ## ... trying feature 101 10X010 with gain 0.5778409 
    ## ... trying feature 102 X0X010 with gain 0.576973 
    ## ... trying feature 103 01X010 with gain 0.5769972 
    ## ... trying feature 104 11X010 with gain 0.576966 
    ## ... trying feature 105 X1X010 with gain 0.5768712 
    ## ... trying feature 106 0XX010 with gain 0.5770901 
    ## ... trying feature 107 1XX010 with gain 0.5772573 
    ## ... trying feature 108 XXX010 with gain 0.5768777 
    ## ... trying feature 109 000110 with gain 0.5768696 
    ## ... trying feature 110 100110 with gain 0.5768835 
    ## ... trying feature 111 X00110 with gain 0.5768836 
    ## ... trying feature 112 010110 with gain 0.5768984 
    ## ... trying feature 113 110110 with gain 0.5773051 
    ## ... trying feature 114 X10110 with gain 0.5771046 
    ## ... trying feature 115 0X0110 with gain 0.5768985 
    ## ... trying feature 116 1X0110 with gain 0.5771583 
    ## ... trying feature 117 XX0110 with gain 0.5770683 
    ## ... trying feature 118 001110 with gain 0.5768735 
    ## ... trying feature 119 101110 with gain 0.5768694 
    ## ... trying feature 120 X01110 with gain 0.5768735 
    ## ... trying feature 121 011110 with gain 0.5768974 
    ## ... trying feature 122 111110 with gain 0.5771753 
    ## ... trying feature 123 X11110 with gain 0.5771922 
    ## ... trying feature 124 0X1110 with gain 0.5769015 
    ## ... trying feature 125 1X1110 with gain 0.5771753 
    ## ... trying feature 126 XX1110 with gain 0.5771947 
    ## ... trying feature 127 00X110 with gain 0.5768736 
    ## ... trying feature 128 10X110 with gain 0.5768835 
    ## ... trying feature 129 X0X110 with gain 0.5768877 
    ## ... trying feature 130 01X110 with gain 0.5769268 
    ## ... trying feature 131 11X110 with gain 0.5769061 
    ## ... trying feature 132 X1X110 with gain 0.5769197 
    ## ... trying feature 133 0XX110 with gain 0.5769311 
    ## ... trying feature 134 1XX110 with gain 0.5769093 
    ## ... trying feature 135 XXX110 with gain 0.5769244 
    ## ... trying feature 136 000X10 with gain 0.5768886 
    ## ... trying feature 137 100X10 with gain 0.576891 
    ## ... trying feature 138 X00X10 with gain 0.5769103 
    ## ... trying feature 139 010X10 with gain 0.5768716 
    ## ... trying feature 140 110X10 with gain 0.5768722 
    ## ... trying feature 141 X10X10 with gain 0.5768744 
    ## ... trying feature 142 0X0X10 with gain 0.5768706 
    ## ... trying feature 143 1X0X10 with gain 0.5768709 
    ## ... trying feature 144 XX0X10 with gain 0.5768721 
    ## ... trying feature 145 001X10 with gain 0.5770043 
    ## ... trying feature 146 101X10 with gain 0.5778334 
    ## ... trying feature 147 X01X10 with gain 0.5769639 
    ## ... trying feature 148 011X10 with gain 0.5770628 
    ## ... trying feature 149 111X10 with gain 0.5770854 
    ## ... trying feature 150 X11X10 with gain 0.5768914 
    ## ... trying feature 151 0X1X10 with gain 0.5771959 
    ## ... trying feature 152 1X1X10 with gain 0.577433 
    ## ... trying feature 153 XX1X10 with gain 0.5769424 
    ## ... trying feature 154 00XX10 with gain 0.5769849 
    ## ... trying feature 155 10XX10 with gain 0.5778552 
    ## ... trying feature 156 X0XX10 with gain 0.5769805 
    ## ... trying feature 157 01XX10 with gain 0.5769764 
    ## ... trying feature 158 11XX10 with gain 0.5769924 
    ## ... trying feature 159 X1XX10 with gain 0.5768739 
    ## ... trying feature 160 0XXX10 with gain 0.5770624 
    ## ... trying feature 161 1XXX10 with gain 0.5772336 
    ## ... trying feature 162 XXXX10 with gain 0.5769028 
    ## ... trying feature 163 0000X0 with gain 0.5781237 
    ## ... trying feature 164 1000X0 with gain 0.5771545 
    ## ... trying feature 165 X000X0 with gain 0.5777982 
    ## ... trying feature 166 0100X0 with gain 0.5776752 
    ## ... trying feature 167 1100X0 with gain 0.5788345 
    ## ... trying feature 168 X100X0 with gain 0.5795462 
    ## ... trying feature 169 0X00X0 with gain 0.5780586 
    ## ... trying feature 170 1X00X0 with gain 0.5791798 
    ## ... trying feature 171 XX00X0 with gain 0.5803652 
    ## ... trying feature 172 0010X0 with gain 0.5776279 
    ## ... trying feature 173 1010X0 with gain 0.5772943 
    ## ... trying feature 174 X010X0 with gain 0.578146 
    ## ... trying feature 175 0110X0 with gain 0.5770476 
    ## ... trying feature 176 1110X0 with gain 0.5794612 
    ## ... trying feature 177 X110X0 with gain 0.5788607 
    ## ... trying feature 178 0X10X0 with gain 0.5773696 
    ## ... trying feature 179 1X10X0 with gain 0.5798736 
    ## ... trying feature 180 XX10X0 with gain 0.5798386 
    ## ... trying feature 181 00X0X0 with gain 0.5784807 
    ## ... trying feature 182 10X0X0 with gain 0.5775913 
    ## ... trying feature 183 X0X0X0 with gain 0.5793274 
    ## ... trying feature 184 01X0X0 with gain 0.5779564 
    ## ... trying feature 185 11X0X0 with gain 0.5820082 
    ## ... trying feature 186 X1X0X0 with gain 0.5824712 
    ## ... trying feature 187 0XX0X0 with gain 0.5789754 
    ## ... trying feature 188 1XX0X0 with gain 0.5827746 
    ## ... trying feature 189 XXX0X0 with gain 0.5845544 
    ## ... trying feature 190 0001X0 with gain 0.5768875 
    ## ... trying feature 191 1001X0 with gain 0.5773949 
    ## ... trying feature 192 X001X0 with gain 0.5773704

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 193 0101X0 with gain 0.5772607 
    ## ... trying feature 194 1101X0 with gain 0.5772271 
    ## ... trying feature 195 X101X0 with gain 0.57712

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 196 0X01X0 with gain 0.5772828 
    ## ... trying feature 197 1X01X0 with gain 0.577539 
    ## ... trying feature 198 XX01X0 with gain 0.5773876 
    ## ... trying feature 199 0011X0 with gain 0.5768982 
    ## ... trying feature 200 1011X0 with gain 0.57703 
    ## ... trying feature 201 X011X0 with gain 0.5770147 
    ## ... trying feature 202 0111X0 with gain 0.5771617 
    ## ... trying feature 203 1111X0 with gain 0.5770051 
    ## ... trying feature 204 X111X0 with gain 0.5770828 
    ## ... trying feature 205 0X11X0 with gain 0.5771241 
    ## ... trying feature 206 1X11X0 with gain 0.5771067 
    ## ... trying feature 207 XX11X0 with gain 0.5771935

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 208 00X1X0 with gain 0.5769165 
    ## ... trying feature 209 10X1X0 with gain 0.577528 
    ## ... trying feature 210 X0X1X0 with gain 0.577486 
    ## ... trying feature 211 01X1X0 with gain 0.57689 
    ## ... trying feature 212 11X1X0 with gain 0.5773501 
    ## ... trying feature 213 X1X1X0 with gain 0.5773713 
    ## ... trying feature 214 0XX1X0 with gain 0.5768785 
    ## ... trying feature 215 1XX1X0 with gain 0.5777633 
    ## ... trying feature 216 XXX1X0 with gain 0.5777729

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 217 000XX0 with gain 0.5781427 
    ## ... trying feature 218 100XX0 with gain 0.576871 
    ## ... trying feature 219 X00XX0 with gain 0.5770321 
    ## ... trying feature 220 010XX0 with gain 0.5777843 
    ## ... trying feature 221 110XX0 with gain 0.5772995 
    ## ... trying feature 222 X10XX0 with gain 0.5781971 
    ## ... trying feature 223 0X0XX0 with gain 0.5781915 
    ## ... trying feature 224 1X0XX0 with gain 0.5772321 
    ## ... trying feature 225 XX0XX0 with gain 0.5783886 
    ## ... trying feature 226 001XX0 with gain 0.5776456 
    ## ... trying feature 227 101XX0 with gain 0.576943 
    ## ... trying feature 228 X01XX0 with gain 0.5775354 
    ## ... trying feature 229 011XX0 with gain 0.5769845 
    ## ... trying feature 230 111XX0 with gain 0.5779477 
    ## ... trying feature 231 X11XX0 with gain 0.5778925 
    ## ... trying feature 232 0X1XX0 with gain 0.577265 
    ## ... trying feature 233 1X1XX0 with gain 0.5780384 
    ## ... trying feature 234 XX1XX0 with gain 0.5784062 
    ## ... trying feature 235 00XXX0 with gain 0.5785176 
    ## ... trying feature 236 10XXX0 with gain 0.5769046 
    ## ... trying feature 237 X0XXX0 with gain 0.5778917 
    ## ... trying feature 238 01XXX0 with gain 0.5778972 
    ## ... trying feature 239 11XXX0 with gain 0.5788073 
    ## ... trying feature 240 X1XXX0 with gain 0.5798597 
    ## ... trying feature 241 0XXXX0 with gain 0.5789016 
    ## ... trying feature 242 1XXXX0 with gain 0.5788484 
    ## ... trying feature 243 XXXXX0 with gain 0.5808432 
    ## ... trying feature 244 000001 with gain 0.5770144 
    ## ... trying feature 245 100001 with gain 0.5772151 
    ## ... trying feature 246 X00001 with gain 0.5769085 
    ## ... trying feature 247 010001 with gain 0.5771429 
    ## ... trying feature 248 110001 with gain 0.5787685 
    ## ... trying feature 249 X10001 with gain 0.5785855 
    ## ... trying feature 250 0X0001 with gain 0.577256 
    ## ... trying feature 251 1X0001 with gain 0.5780912 
    ## ... trying feature 252 XX0001 with gain 0.5783008 
    ## ... trying feature 253 001001 with gain 0.5782265 
    ## ... trying feature 254 101001 with gain 0.5770462 
    ## ... trying feature 255 X01001 with gain 0.5783181 
    ## ... trying feature 256 011001 with gain 0.5769644 
    ## ... trying feature 257 111001 with gain 0.5799768 
    ## ... trying feature 258 X11001 with gain 0.5778864 
    ## ... trying feature 259 0X1001 with gain 0.5773168 
    ## ... trying feature 260 1X1001 with gain 0.5792264 
    ## ... trying feature 261 XX1001 with gain 0.5772318 
    ## ... trying feature 262 00X001 with gain 0.5782886 
    ## ... trying feature 263 10X001 with gain 0.5768841 
    ## ... trying feature 264 X0X001 with gain 0.5776287 
    ## ... trying feature 265 01X001 with gain 0.5773868 
    ## ... trying feature 266 11X001 with gain 0.5770433 
    ## ... trying feature 267 X1X001 with gain 0.5769085 
    ## ... trying feature 268 0XX001 with gain 0.578195 
    ## ... trying feature 269 1XX001 with gain 0.5770645 
    ## ... trying feature 270 XXX001 with gain 0.5770804 
    ## ... trying feature 271 000101 with gain 0.5768937 
    ## ... trying feature 272 100101 with gain 0.5770021 
    ## ... trying feature 273 X00101 with gain 0.5769923

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 274 010101 with gain 0.5772949 
    ## ... trying feature 275 110101 with gain 0.5774843 
    ## ... trying feature 276 X10101 with gain 0.5773329

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 277 0X0101 with gain 0.5773252 
    ## ... trying feature 278 1X0101 with gain 0.5775948 
    ## ... trying feature 279 XX0101 with gain 0.5774384 
    ## ... trying feature 280 001101 with gain 0.576907 
    ## ... trying feature 281 101101 with gain 0.5768898 
    ## ... trying feature 282 X01101 with gain 0.5768966 
    ## ... trying feature 283 011101 with gain 0.5770488 
    ## ... trying feature 284 111101 with gain 0.5788274 
    ## ... trying feature 285 X11101 with gain 0.578979 
    ## ... trying feature 286 0X1101 with gain 0.5770142 
    ## ... trying feature 287 1X1101 with gain 0.5786129 
    ## ... trying feature 288 XX1101 with gain 0.5787351

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 289 00X101 with gain 0.5769319 
    ## ... trying feature 290 10X101 with gain 0.5769138 
    ## ... trying feature 291 X0X101 with gain 0.5769034 
    ## ... trying feature 292 01X101 with gain 0.5768697 
    ## ... trying feature 293 11X101 with gain 0.5796872 
    ## ... trying feature 294 X1X101 with gain 0.5796443 
    ## ... trying feature 295 0XX101 with gain 0.5768715 
    ## ... trying feature 296 1XX101 with gain 0.5796395 
    ## ... trying feature 297 XXX101 with gain 0.5795721 
    ## ... trying feature 298 000X01 with gain 0.5770038 
    ## ... trying feature 299 100X01 with gain 0.5769011 
    ## ... trying feature 300 X00X01 with gain 0.5768728 
    ## ... trying feature 301 010X01 with gain 0.5770783 
    ## ... trying feature 302 110X01 with gain 0.5796452 
    ## ... trying feature 303 X10X01 with gain 0.5791842 
    ## ... trying feature 304 0X0X01 with gain 0.5771757 
    ## ... trying feature 305 1X0X01 with gain 0.5790827 
    ## ... trying feature 306 XX0X01 with gain 0.5790227 
    ## ... trying feature 307 001X01 with gain 0.5781702 
    ## ... trying feature 308 101X01 with gain 0.5769426 
    ## ... trying feature 309 X01X01 with gain 0.5779198 
    ## ... trying feature 310 011X01 with gain 0.577003 
    ## ... trying feature 311 111X01 with gain 0.577052 
    ## ... trying feature 312 X11X01 with gain 0.5768762 
    ## ... trying feature 313 0X1X01 with gain 0.5773816 
    ## ... trying feature 314 1X1X01 with gain 0.5769745 
    ## ... trying feature 315 XX1X01 with gain 0.5769188 
    ## ... trying feature 316 00XX01 with gain 0.5782222 
    ## ... trying feature 317 10XX01 with gain 0.5768722 
    ## ... trying feature 318 X0XX01 with gain 0.5777786 
    ## ... trying feature 319 01XX01 with gain 0.577381 
    ## ... trying feature 320 11XX01 with gain 0.5778465 
    ## ... trying feature 321 X1XX01 with gain 0.5784286 
    ## ... trying feature 322 0XXX01 with gain 0.5781577 
    ## ... trying feature 323 1XXX01 with gain 0.5778236 
    ## ... trying feature 324 XXXX01 with gain 0.5791009 
    ## ... trying feature 325 000011 with gain 0.5769806 
    ## ... trying feature 326 100011 with gain 0.5770344 
    ## ... trying feature 327 X00011 with gain 0.5768741 
    ## ... trying feature 328 010011 with gain 0.5770444 
    ## ... trying feature 329 110011 with gain 0.5785311 
    ## ... trying feature 330 X10011 with gain 0.5783257 
    ## ... trying feature 331 0X0011 with gain 0.576987 
    ## ... trying feature 332 1X0011 with gain 0.5786593 
    ## ... trying feature 333 XX0011 with gain 0.5782585 
    ## ... trying feature 334 001011 with gain 0.5771108 
    ## ... trying feature 335 101011 with gain 0.5768694 
    ## ... trying feature 336 X01011 with gain 0.5771108 
    ## ... trying feature 337 011011 with gain 0.5775542 
    ## ... trying feature 338 111011 with gain 0.5776114 
    ## ... trying feature 339 X11011 with gain 0.5779821 
    ## ... trying feature 340 0X1011 with gain 0.5773554 
    ## ... trying feature 341 1X1011 with gain 0.5776114 
    ## ... trying feature 342 XX1011 with gain 0.5777272 
    ## ... trying feature 343 00X011 with gain 0.5772214 
    ## ... trying feature 344 10X011 with gain 0.5770344 
    ## ... trying feature 345 X0X011 with gain 0.5769082 
    ## ... trying feature 346 01X011 with gain 0.5777034 
    ## ... trying feature 347 11X011 with gain 0.5791822 
    ## ... trying feature 348 X1X011 with gain 0.5792991 
    ## ... trying feature 349 0XX011 with gain 0.5774522 
    ## ... trying feature 350 1XX011 with gain 0.5793143 
    ## ... trying feature 351 XXX011 with gain 0.5789856 
    ## ... trying feature 352 000111 with gain 0.5768698 
    ## ... trying feature 353 X00111 with gain 0.5768698 
    ## ... trying feature 354 010111 with gain 0.5768837 
    ## ... trying feature 355 110111 with gain 0.5771019 
    ## ... trying feature 356 X10111 with gain 0.5770765 
    ## ... trying feature 357 0X0111 with gain 0.576884 
    ## ... trying feature 358 1X0111 with gain 0.5771019 
    ## ... trying feature 359 XX0111 with gain 0.5770759 
    ## ... trying feature 360 001111 with gain 0.5768694 
    ## ... trying feature 361 101111 with gain 0.5769062 
    ## ... trying feature 362 X01111 with gain 0.5769062 
    ## ... trying feature 363 011111 with gain 0.5769038 
    ## ... trying feature 364 111111 with gain 0.576875 
    ## ... trying feature 365 X11111 with gain 0.5768714 
    ## ... trying feature 366 0X1111 with gain 0.5769038 
    ## ... trying feature 367 1X1111 with gain 0.5768847 
    ## ... trying feature 368 XX1111 with gain 0.5768782 
    ## ... trying feature 369 00X111 with gain 0.5768698 
    ## ... trying feature 370 10X111 with gain 0.5769062 
    ## ... trying feature 371 X0X111 with gain 0.5769053 
    ## ... trying feature 372 01X111 with gain 0.5769183 
    ## ... trying feature 373 11X111 with gain 0.5769958 
    ## ... trying feature 374 X1X111 with gain 0.5769674 
    ## ... trying feature 375 0XX111 with gain 0.5769187 
    ## ... trying feature 376 1XX111 with gain 0.5770212 
    ## ... trying feature 377 XXX111 with gain 0.5769899 
    ## ... trying feature 378 000X11 with gain 0.5769809 
    ## ... trying feature 379 100X11 with gain 0.5770344 
    ## ... trying feature 380 X00X11 with gain 0.5768741 
    ## ... trying feature 381 010X11 with gain 0.5770354 
    ## ... trying feature 382 110X11 with gain 0.5787479 
    ## ... trying feature 383 X10X11 with gain 0.5785531 
    ## ... trying feature 384 0X0X11 with gain 0.5769801 
    ## ... trying feature 385 1X0X11 with gain 0.5788721 
    ## ... trying feature 386 XX0X11 with gain 0.5784836 
    ## ... trying feature 387 001X11 with gain 0.5771108 
    ## ... trying feature 388 101X11 with gain 0.5769062 
    ## ... trying feature 389 X01X11 with gain 0.57692 
    ## ... trying feature 390 011X11 with gain 0.5775159 
    ## ... trying feature 391 111X11 with gain 0.5771412 
    ## ... trying feature 392 X11X11 with gain 0.5777966 
    ## ... trying feature 393 0X1X11 with gain 0.5773265 
    ## ... trying feature 394 1X1X11 with gain 0.5771744 
    ## ... trying feature 395 XX1X11 with gain 0.5776273 
    ## ... trying feature 396 00XX11 with gain 0.5772218 
    ## ... trying feature 397 10XX11 with gain 0.5770379 
    ## ... trying feature 398 X0XX11 with gain 0.5768823 
    ## ... trying feature 399 01XX11 with gain 0.5776587 
    ## ... trying feature 400 11XX11 with gain 0.5789261 
    ## ... trying feature 401 X1XX11 with gain 0.5793217 
    ## ... trying feature 402 0XXX11 with gain 0.5774181 
    ## ... trying feature 403 1XXX11 with gain 0.5790872 
    ## ... trying feature 404 XXXX11 with gain 0.579078 
    ## ... trying feature 405 0000X1 with gain 0.5769726 
    ## ... trying feature 406 1000X1 with gain 0.5771225 
    ## ... trying feature 407 X000X1 with gain 0.5769003 
    ## ... trying feature 408 0100X1 with gain 0.5772598 
    ## ... trying feature 409 1100X1 with gain 0.5797375 
    ## ... trying feature 410 X100X1 with gain 0.5794497 
    ## ... trying feature 411 0X00X1 with gain 0.5773629 
    ## ... trying feature 412 1X00X1 with gain 0.578919 
    ## ... trying feature 413 XX00X1 with gain 0.5790702 
    ## ... trying feature 414 0010X1 with gain 0.5779288 
    ## ... trying feature 415 1010X1 with gain 0.5770462 
    ## ... trying feature 416 X010X1 with gain 0.5780792 
    ## ... trying feature 417 0110X1 with gain 0.577181 
    ## ... trying feature 418 1110X1 with gain 0.5795997 
    ## ... trying feature 419 X110X1 with gain 0.5774085 
    ## ... trying feature 420 0X10X1 with gain 0.5776347 
    ## ... trying feature 421 1X10X1 with gain 0.5789212 
    ## ... trying feature 422 XX10X1 with gain 0.5770064 
    ## ... trying feature 423 00X0X1 with gain 0.5779596 
    ## ... trying feature 424 10X0X1 with gain 0.5768738 
    ## ... trying feature 425 X0X0X1 with gain 0.5775021 
    ## ... trying feature 426 01X0X1 with gain 0.5779873 
    ## ... trying feature 427 11X0X1 with gain 0.5768724 
    ## ... trying feature 428 X1X0X1 with gain 0.5773489 
    ## ... trying feature 429 0XX0X1 with gain 0.5789754 
    ## ... trying feature 430 1XX0X1 with gain 0.5768751 
    ## ... trying feature 431 XXX0X1 with gain 0.5777169 
    ## ... trying feature 432 0001X1 with gain 0.5768941 
    ## ... trying feature 433 1001X1 with gain 0.5770021 
    ## ... trying feature 434 X001X1 with gain 0.5769922

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 435 0101X1 with gain 0.5773127 
    ## ... trying feature 436 1101X1 with gain 0.5776275 
    ## ... trying feature 437 X101X1 with gain 0.5774534

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 438 0X01X1 with gain 0.5773437 
    ## ... trying feature 439 1X01X1 with gain 0.5777318 
    ## ... trying feature 440 XX01X1 with gain 0.5775558 
    ## ... trying feature 441 0011X1 with gain 0.576907 
    ## ... trying feature 442 1011X1 with gain 0.5768792 
    ## ... trying feature 443 X011X1 with gain 0.576884 
    ## ... trying feature 444 0111X1 with gain 0.577017 
    ## ... trying feature 445 1111X1 with gain 0.5787903 
    ## ... trying feature 446 X111X1 with gain 0.5789223 
    ## ... trying feature 447 0X11X1 with gain 0.5769865 
    ## ... trying feature 448 1X11X1 with gain 0.5786118 
    ## ... trying feature 449 XX11X1 with gain 0.5787175

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 450 00X1X1 with gain 0.5769322 
    ## ... trying feature 451 10X1X1 with gain 0.5769242 
    ## ... trying feature 452 X0X1X1 with gain 0.5769125 
    ## ... trying feature 453 01X1X1 with gain 0.5768705 
    ## ... trying feature 454 11X1X1 with gain 0.5798609 
    ## ... trying feature 455 X1X1X1 with gain 0.5797897 
    ## ... trying feature 456 0XX1X1 with gain 0.5768785 
    ## ... trying feature 457 1XX1X1 with gain 0.5798416 
    ## ... trying feature 458 XXX1X1 with gain 0.5797473 
    ## ... trying feature 459 000XX1 with gain 0.5769639 
    ## ... trying feature 460 100XX1 with gain 0.5768851 
    ## ... trying feature 461 X00XX1 with gain 0.5768744 
    ## ... trying feature 462 010XX1 with gain 0.5771797 
    ## ... trying feature 463 110XX1 with gain 0.5808569 
    ## ... trying feature 464 X10XX1 with gain 0.5801909 
    ## ... trying feature 465 0X0XX1 with gain 0.5772694 
    ## ... trying feature 466 1X0XX1 with gain 0.5801746 
    ## ... trying feature 467 XX0XX1 with gain 0.5799582 
    ## ... trying feature 468 001XX1 with gain 0.5778829 
    ## ... trying feature 469 101XX1 with gain 0.5769547 
    ## ... trying feature 470 X01XX1 with gain 0.5777697 
    ## ... trying feature 471 011XX1 with gain 0.5772378 
    ## ... trying feature 472 111XX1 with gain 0.5769771 
    ## ... trying feature 473 X11XX1 with gain 0.5768938 
    ## ... trying feature 474 0X1XX1 with gain 0.5777046 
    ## ... trying feature 475 1X1XX1 with gain 0.5769179 
    ## ... trying feature 476 XX1XX1 with gain 0.5770555 
    ## ... trying feature 477 00XXX1 with gain 0.5779045 
    ## ... trying feature 478 10XXX1 with gain 0.5768823 
    ## ... trying feature 479 X0XXX1 with gain 0.5776439 
    ## ... trying feature 480 01XXX1 with gain 0.5779589 
    ## ... trying feature 481 11XXX1 with gain 0.5788454 
    ## ... trying feature 482 X1XXX1 with gain 0.580045 
    ## ... trying feature 483 0XXXX1 with gain 0.5789016 
    ## ... trying feature 484 1XXXX1 with gain 0.5788484 
    ## ... trying feature 485 XXXXX1 with gain 0.5808432 
    ## ... trying feature 486 00000X with gain 0.5769029 
    ## ... trying feature 487 10000X with gain 0.5776046 
    ## ... trying feature 488 X0000X with gain 0.5776076 
    ## ... trying feature 489 01000X with gain 0.5769273 
    ## ... trying feature 490 11000X with gain 0.5769597 
    ## ... trying feature 491 X1000X with gain 0.5768707 
    ## ... trying feature 492 0X000X with gain 0.5769541 
    ## ... trying feature 493 1X000X with gain 0.5768708 
    ## ... trying feature 494 XX000X with gain 0.5769255 
    ## ... trying feature 495 00100X with gain 0.576874 
    ## ... trying feature 496 10100X with gain 0.5768777 
    ## ... trying feature 497 X0100X with gain 0.5768862 
    ## ... trying feature 498 01100X with gain 0.5768992 
    ## ... trying feature 499 11100X with gain 0.583888 
    ## ... trying feature 500 X1100X with gain 0.5810661 
    ## ... trying feature 501 0X100X with gain 0.5768909 
    ## ... trying feature 502 1X100X with gain 0.5830101 
    ## ... trying feature 503 XX100X with gain 0.5805482 
    ## ... trying feature 504 00X00X with gain 0.5768741 
    ## ... trying feature 505 10X00X with gain 0.577253 
    ## ... trying feature 506 X0X00X with gain 0.5773979 
    ## ... trying feature 507 01X00X with gain 0.5772853 
    ## ... trying feature 508 11X00X with gain 0.5818496 
    ## ... trying feature 509 X1X00X with gain 0.5826557 
    ## ... trying feature 510 0XX00X with gain 0.5776816 
    ## ... trying feature 511 1XX00X with gain 0.582649 
    ## ... trying feature 512 XXX00X with gain 0.5833644 
    ## ... trying feature 513 00010X with gain 0.5769119 
    ## ... trying feature 514 10010X with gain 0.577422 
    ## ... trying feature 515 X0010X with gain 0.5773927

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 516 01010X with gain 0.5777499 
    ## ... trying feature 517 11010X with gain 0.5777881 
    ## ... trying feature 518 X1010X with gain 0.5775395

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 519 0X010X with gain 0.577817 
    ## ... trying feature 520 1X010X with gain 0.5782489 
    ## ... trying feature 521 XX010X with gain 0.5779479 
    ## ... trying feature 522 00110X with gain 0.5769322 
    ## ... trying feature 523 10110X with gain 0.5769135 
    ## ... trying feature 524 X0110X with gain 0.5769023

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 525 01110X with gain 0.5781185 
    ## ... trying feature 526 11110X with gain 0.5791768 
    ## ... trying feature 527 X1110X with gain 0.5795461

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 528 0X110X with gain 0.5780039 
    ## ... trying feature 529 1X110X with gain 0.5791703 
    ## ... trying feature 530 XX110X with gain 0.5794963

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 531 00X10X with gain 0.5769762 
    ## ... trying feature 532 10X10X with gain 0.5774529 
    ## ... trying feature 533 X0X10X with gain 0.5773979

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 534 01X10X with gain 0.5770954 
    ## ... trying feature 535 11X10X with gain 0.5809312 
    ## ... trying feature 536 X1X10X with gain 0.5810305 
    ## ... trying feature 537 0XX10X with gain 0.5769821 
    ## ... trying feature 538 1XX10X with gain 0.5817024 
    ## ... trying feature 539 XXX10X with gain 0.5817516 
    ## ... trying feature 540 000X0X with gain 0.5769099 
    ## ... trying feature 541 100X0X with gain 0.5768844 
    ## ... trying feature 542 X00X0X with gain 0.5769302 
    ## ... trying feature 543 010X0X with gain 0.5769838 
    ## ... trying feature 544 110X0X with gain 0.5777452 
    ## ... trying feature 545 X10X0X with gain 0.5770969 
    ## ... trying feature 546 0X0X0X with gain 0.5770228 
    ## ... trying feature 547 1X0X0X with gain 0.5775772 
    ## ... trying feature 548 XX0X0X with gain 0.5770101 
    ## ... trying feature 549 001X0X with gain 0.5768715 
    ## ... trying feature 550 101X0X with gain 0.5769216 
    ## ... trying feature 551 X01X0X with gain 0.5769302 
    ## ... trying feature 552 011X0X with gain 0.5768716 
    ## ... trying feature 553 111X0X with gain 0.5782239 
    ## ... trying feature 554 X11X0X with gain 0.5777236 
    ## ... trying feature 555 0X1X0X with gain 0.5768703 
    ## ... trying feature 556 1X1X0X with gain 0.5779334 
    ## ... trying feature 557 XX1X0X with gain 0.5775203 
    ## ... trying feature 558 00XX0X with gain 0.5768797 
    ## ... trying feature 559 10XX0X with gain 0.5768797 
    ## ... trying feature 561 01XX0X with gain 0.5772235 
    ## ... trying feature 562 11XX0X with gain 0.5770696 
    ## ... trying feature 563 X1XX0X with gain 0.5777734 
    ## ... trying feature 564 0XXX0X with gain 0.5776144 
    ## ... trying feature 565 1XXX0X with gain 0.5771148 
    ## ... trying feature 566 XXXX0X with gain 0.5777734 
    ## ... trying feature 567 00001X with gain 0.5769997 
    ## ... trying feature 568 10001X with gain 0.5769695 
    ## ... trying feature 569 X0001X with gain 0.5768702 
    ## ... trying feature 570 01001X with gain 0.5769887 
    ## ... trying feature 571 11001X with gain 0.5777102 
    ## ... trying feature 572 X1001X with gain 0.5776155 
    ## ... trying feature 573 0X001X with gain 0.5769514 
    ## ... trying feature 574 1X001X with gain 0.5777959 
    ## ... trying feature 575 XX001X with gain 0.5775885 
    ## ... trying feature 576 00101X with gain 0.5768856 
    ## ... trying feature 577 10101X with gain 0.5778334 
    ## ... trying feature 578 X0101X with gain 0.5770653 
    ## ... trying feature 579 01101X with gain 0.5777781 
    ## ... trying feature 580 11101X with gain 0.5768959 
    ## ... trying feature 581 X1101X with gain 0.577606 
    ## ... trying feature 582 0X101X with gain 0.5777379 
    ## ... trying feature 583 1X101X with gain 0.5769064 
    ## ... trying feature 584 XX101X with gain 0.577249 
    ## ... trying feature 585 00X01X with gain 0.5768696 
    ## ... trying feature 586 10X01X with gain 0.5771969 
    ## ... trying feature 587 X0X01X with gain 0.5770124 
    ## ... trying feature 588 01X01X with gain 0.5777652 
    ## ... trying feature 589 11X01X with gain 0.577462 
    ## ... trying feature 590 X1X01X with gain 0.5782807 
    ## ... trying feature 591 0XX01X with gain 0.5776816 
    ## ... trying feature 592 1XX01X with gain 0.5771377 
    ## ... trying feature 593 XXX01X with gain 0.577881 
    ## ... trying feature 594 00011X with gain 0.5768699 
    ## ... trying feature 595 10011X with gain 0.5768835 
    ## ... trying feature 596 X0011X with gain 0.576884 
    ## ... trying feature 597 01011X with gain 0.5769129 
    ## ... trying feature 598 11011X with gain 0.5774023 
    ## ... trying feature 599 X1011X with gain 0.5773008 
    ## ... trying feature 600 0X011X with gain 0.5769134 
    ## ... trying feature 601 1X011X with gain 0.5773646 
    ## ... trying feature 602 XX011X with gain 0.577273 
    ## ... trying feature 603 00111X with gain 0.5768735 
    ## ... trying feature 604 10111X with gain 0.5769062 
    ## ... trying feature 605 X0111X with gain 0.5768976 
    ## ... trying feature 606 01111X with gain 0.5769323 
    ## ... trying feature 607 11111X with gain 0.5769855 
    ## ... trying feature 608 X1111X with gain 0.5770062 
    ## ... trying feature 609 0X111X with gain 0.5769365 
    ## ... trying feature 610 1X111X with gain 0.5769584 
    ## ... trying feature 611 XX111X with gain 0.576978 
    ## ... trying feature 612 00X11X with gain 0.576874 
    ## ... trying feature 613 10X11X with gain 0.5768851 
    ## ... trying feature 614 X0X11X with gain 0.5768814 
    ## ... trying feature 615 01X11X with gain 0.5769772 
    ## ... trying feature 616 11X11X with gain 0.5768804 
    ## ... trying feature 617 X1X11X with gain 0.5768722 
    ## ... trying feature 618 0XX11X with gain 0.5769821 
    ## ... trying feature 619 1XX11X with gain 0.5768854 
    ## ... trying feature 620 XXX11X with gain 0.5768747 
    ## ... trying feature 621 000X1X with gain 0.5770002 
    ## ... trying feature 622 100X1X with gain 0.5769337 
    ## ... trying feature 623 X00X1X with gain 0.5768695 
    ## ... trying feature 624 010X1X with gain 0.5769746 
    ## ... trying feature 625 110X1X with gain 0.5781578 
    ## ... trying feature 626 X10X1X with gain 0.5779338 
    ## ... trying feature 627 0X0X1X with gain 0.5769401 
    ## ... trying feature 628 1X0X1X with gain 0.5782243 
    ## ... trying feature 629 XX0X1X with gain 0.5778877 
    ## ... trying feature 630 001X1X with gain 0.5768846 
    ## ... trying feature 631 101X1X with gain 0.5773573 
    ## ... trying feature 632 X01X1X with gain 0.5770134 
    ## ... trying feature 633 011X1X with gain 0.5777135 
    ## ... trying feature 634 111X1X with gain 0.5768803 
    ## ... trying feature 635 X11X1X with gain 0.5771951 
    ## ... trying feature 636 0X1X1X with gain 0.577678 
    ## ... trying feature 637 1X1X1X with gain 0.5769856 
    ## ... trying feature 638 XX1X1X with gain 0.5770234 
    ## ... trying feature 639 00XX1X with gain 0.5768695 
    ## ... trying feature 640 10XX1X with gain 0.5771025 
    ## ... trying feature 641 X0XX1X with gain 0.5769818 
    ## ... trying feature 642 01XX1X with gain 0.577692 
    ## ... trying feature 643 11XX1X with gain 0.5773313 
    ## ... trying feature 644 X1XX1X with gain 0.5780851 
    ## ... trying feature 645 0XXX1X with gain 0.5776144 
    ## ... trying feature 646 1XXX1X with gain 0.5771148 
    ## ... trying feature 647 XXXX1X with gain 0.5777734 
    ## ... trying feature 648 0000XX with gain 0.5769252 
    ## ... trying feature 649 1000XX with gain 0.5774931 
    ## ... trying feature 650 X000XX with gain 0.5775686 
    ## ... trying feature 651 0100XX with gain 0.5768854 
    ## ... trying feature 652 1100XX with gain 0.5771719 
    ## ... trying feature 653 X100XX with gain 0.5769619 
    ## ... trying feature 654 0X00XX with gain 0.5769078 
    ## ... trying feature 655 1X00XX with gain 0.5769205 
    ## ... trying feature 656 XX00XX with gain 0.57687 
    ## ... trying feature 657 0010XX with gain 0.5768817 
    ## ... trying feature 658 1010XX with gain 0.5768986 
    ## ... trying feature 659 X010XX with gain 0.5768715 
    ## ... trying feature 660 0110XX with gain 0.5768921 
    ## ... trying feature 661 1110XX with gain 0.5835058 
    ## ... trying feature 662 X110XX with gain 0.5800338 
    ## ... trying feature 663 0X10XX with gain 0.5769078 
    ## ... trying feature 664 1X10XX with gain 0.5830894 
    ## ... trying feature 665 XX10XX with gain 0.5797906 
    ## ... trying feature 666 00X0XX with gain 0.576873 
    ## ... trying feature 667 10X0XX with gain 0.5774517 
    ## ... trying feature 668 X0X0XX with gain 0.5775559 
    ## ... trying feature 669 01X0XX with gain 0.576873 
    ## ... trying feature 670 11X0XX with gain 0.5807267 
    ## ... trying feature 671 X1X0XX with gain 0.5807274 
    ## ... trying feature 673 1XX0XX with gain 0.5817949 
    ## ... trying feature 674 XXX0XX with gain 0.5817949 
    ## ... trying feature 675 0001XX with gain 0.5769124 
    ## ... trying feature 676 1001XX with gain 0.577411 
    ## ... trying feature 677 X001XX with gain 0.577382

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 678 0101XX with gain 0.5778185 
    ## ... trying feature 679 1101XX with gain 0.5780616 
    ## ... trying feature 680 X101XX with gain 0.5777591

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 681 0X01XX with gain 0.577889 
    ## ... trying feature 682 1X01XX with gain 0.5785354 
    ## ... trying feature 683 XX01XX with gain 0.5781851 
    ## ... trying feature 684 0011XX with gain 0.5769364 
    ## ... trying feature 685 1011XX with gain 0.5769245 
    ## ... trying feature 686 X011XX with gain 0.5769111

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 687 0111XX with gain 0.578004 
    ## ... trying feature 688 1111XX with gain 0.5788462 
    ## ... trying feature 689 X111XX with gain 0.5791656

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 690 0X11XX with gain 0.577889 
    ## ... trying feature 691 1X11XX with gain 0.578886 
    ## ... trying feature 692 XX11XX with gain 0.5791678

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 693 00X1XX with gain 0.576981 
    ## ... trying feature 694 10X1XX with gain 0.5774679 
    ## ... trying feature 695 X0X1XX with gain 0.5774102

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 696 01X1XX with gain 0.576981 
    ## ... trying feature 697 11X1XX with gain 0.5809758 
    ## ... trying feature 698 X1X1XX with gain 0.581029 
    ## ... trying feature 699 0XX1XX with gain 0.5768694 
    ## ... trying feature 700 1XX1XX with gain 0.5817949 
    ## ... trying feature 701 XXX1XX with gain 0.5817949 
    ## ... trying feature 702 000XXX with gain 0.5769339 
    ## ... trying feature 703 100XXX with gain 0.5768763 
    ## ... trying feature 704 X00XXX with gain 0.5769278 
    ## ... trying feature 705 010XXX with gain 0.5769222 
    ## ... trying feature 706 110XXX with gain 0.5784232 
    ## ... trying feature 707 X10XXX with gain 0.5774999 
    ## ... trying feature 708 0X0XXX with gain 0.5769608 
    ## ... trying feature 709 1X0XXX with gain 0.5782015 
    ## ... trying feature 710 XX0XXX with gain 0.5773299 
    ## ... trying feature 711 001XXX with gain 0.5768772 
    ## ... trying feature 712 101XXX with gain 0.5768696 
    ## ... trying feature 713 X01XXX with gain 0.5768761 
    ## ... trying feature 714 011XXX with gain 0.57694 
    ## ... trying feature 715 111XXX with gain 0.5783357 
    ## ... trying feature 716 X11XXX with gain 0.5774212 
    ## ... trying feature 717 0X1XXX with gain 0.5769608 
    ## ... trying feature 718 1X1XXX with gain 0.5782015 
    ## ... trying feature 719 XX1XXX with gain 0.5773299 
    ## ... trying feature 720 00XXXX with gain 0.576878 
    ## ... trying feature 721 10XXXX with gain 0.5768742 
    ## ... trying feature 722 X0XXXX with gain 0.5769818 
    ## ... trying feature 723 01XXXX with gain 0.576878 
    ## ... trying feature 724 11XXXX with gain 0.5768742 
    ## ... trying feature 725 X1XXXX with gain 0.5769818 
    ## ... trying feature 727 1XXXXX with gain 0.5768694 
    ## ... Using feature 189 XXX0X0 
    ## Adding Feature Number 5 
    ## ... trying feature 1 000000 with gain 0.5853776 
    ## ... trying feature 2 100000 with gain 0.5845551 
    ## ... trying feature 3 X00000 with gain 0.5847001 
    ## ... trying feature 4 010000 with gain 0.5845545 
    ## ... trying feature 5 110000 with gain 0.5847885 
    ## ... trying feature 6 X10000 with gain 0.5846869 
    ## ... trying feature 7 0X0000 with gain 0.5845858 
    ## ... trying feature 8 1X0000 with gain 0.5847738 
    ## ... trying feature 9 XX0000 with gain 0.5848087 
    ## ... trying feature 10 001000 with gain 0.5852751 
    ## ... trying feature 11 101000 with gain 0.5845967 
    ## ... trying feature 12 X01000 with gain 0.5847492 
    ## ... trying feature 13 011000 with gain 0.5851162 
    ## ... trying feature 14 111000 with gain 0.5846216 
    ## ... trying feature 15 X11000 with gain 0.5847765 
    ## ... trying feature 16 0X1000 with gain 0.5847611 
    ## ... trying feature 17 1X1000 with gain 0.5845815 
    ## ... trying feature 18 XX1000 with gain 0.5846337 
    ## ... trying feature 19 00X000 with gain 0.5859152 
    ## ... trying feature 20 10X000 with gain 0.5845713 
    ## ... trying feature 21 X0X000 with gain 0.5849665 
    ## ... trying feature 22 01X000 with gain 0.5850868 
    ## ... trying feature 23 11X000 with gain 0.5849401 
    ## ... trying feature 24 X1X000 with gain 0.584589 
    ## ... trying feature 25 0XX000 with gain 0.5846488 
    ## ... trying feature 26 1XX000 with gain 0.5848462 
    ## ... trying feature 27 XXX000 with gain 0.5847103 
    ## ... trying feature 28 000100 with gain 0.5845715 
    ## ... trying feature 29 100100 with gain 0.5848316 
    ## ... trying feature 30 X00100 with gain 0.5848157

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 010100 with gain 0.5849167 
    ## ... trying feature 32 110100 with gain 0.5846279 
    ## ... trying feature 33 X10100 with gain 0.5845882

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 34 0X0100 with gain 0.5849374 
    ## ... trying feature 35 1X0100 with gain 0.5847503 
    ## ... trying feature 36 XX0100 with gain 0.5846801 
    ## ... trying feature 37 001100 with gain 0.5845798 
    ## ... trying feature 38 101100 with gain 0.5846121 
    ## ... trying feature 39 X01100 with gain 0.5846046 
    ## ... trying feature 40 011100 with gain 0.5849036 
    ## ... trying feature 41 111100 with gain 0.5846003 
    ## ... trying feature 42 X11100 with gain 0.5846581 
    ## ... trying feature 43 0X1100 with gain 0.5848653 
    ## ... trying feature 44 1X1100 with gain 0.5846371 
    ## ... trying feature 45 XX1100 with gain 0.5847018

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 46 00X100 with gain 0.5845972 
    ## ... trying feature 47 10X100 with gain 0.5848557 
    ## ... trying feature 48 X0X100 with gain 0.5848314 
    ## ... trying feature 49 01X100 with gain 0.5845977 
    ## ... trying feature 50 11X100 with gain 0.5846806 
    ## ... trying feature 51 X1X100 with gain 0.5847029 
    ## ... trying feature 52 0XX100 with gain 0.5845812 
    ## ... trying feature 53 1XX100 with gain 0.5848417 
    ## ... trying feature 54 XXX100 with gain 0.5848634

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 55 000X00 with gain 0.5853954 
    ## ... trying feature 56 100X00 with gain 0.5846563 
    ## ... trying feature 57 X00X00 with gain 0.5845546 
    ## ... trying feature 58 010X00 with gain 0.5845612 
    ## ... trying feature 59 110X00 with gain 0.5845797 
    ## ... trying feature 60 X10X00 with gain 0.5845886 
    ## ... trying feature 61 0X0X00 with gain 0.5846164 
    ## ... trying feature 62 1X0X00 with gain 0.5845548 
    ## ... trying feature 63 XX0X00 with gain 0.5845882 
    ## ... trying feature 64 001X00 with gain 0.5852933 
    ## ... trying feature 65 101X00 with gain 0.5846628 
    ## ... trying feature 66 X01X00 with gain 0.5846165 
    ## ... trying feature 67 011X00 with gain 0.5852601 
    ## ... trying feature 68 111X00 with gain 0.5845551 
    ## ... trying feature 69 X11X00 with gain 0.5848825 
    ## ... trying feature 70 0X1X00 with gain 0.5848489 
    ## ... trying feature 71 1X1X00 with gain 0.5845635 
    ## ... trying feature 72 XX1X00 with gain 0.5847704 
    ## ... trying feature 73 00XX00 with gain 0.5859518 
    ## ... trying feature 74 10XX00 with gain 0.5848088 
    ## ... trying feature 75 X0XX00 with gain 0.5846075 
    ## ... trying feature 76 01XX00 with gain 0.585126 
    ## ... trying feature 77 11XX00 with gain 0.584576 
    ## ... trying feature 78 X1XX00 with gain 0.584738 
    ## ... trying feature 79 0XXX00 with gain 0.584665 
    ## ... trying feature 80 1XXX00 with gain 0.5845596 
    ## ... trying feature 81 XXXX00 with gain 0.5846648 
    ## ... trying feature 82 000010 with gain 0.5845629 
    ## ... trying feature 83 100010 with gain 0.5845594 
    ## ... trying feature 84 X00010 with gain 0.5845679 
    ## ... trying feature 85 010010 with gain 0.5846823 
    ## ... trying feature 86 110010 with gain 0.5845892 
    ## ... trying feature 87 X10010 with gain 0.5845922 
    ## ... trying feature 88 0X0010 with gain 0.5846775 
    ## ... trying feature 89 1X0010 with gain 0.5845908 
    ## ... trying feature 90 XX0010 with gain 0.584589 
    ## ... trying feature 91 001010 with gain 0.5848526 
    ## ... trying feature 92 101010 with gain 0.5854183 
    ## ... trying feature 93 X01010 with gain 0.5845776 
    ## ... trying feature 94 011010 with gain 0.5849279 
    ## ... trying feature 95 111010 with gain 0.5845681 
    ## ... trying feature 96 X11010 with gain 0.5847871 
    ## ... trying feature 97 0X1010 with gain 0.5852181 
    ## ... trying feature 98 1X1010 with gain 0.5846198 
    ## ... trying feature 99 XX1010 with gain 0.5846741 
    ## ... trying feature 100 00X010 with gain 0.5848355 
    ## ... trying feature 101 10X010 with gain 0.5854234 
    ## ... trying feature 102 X0X010 with gain 0.5845808 
    ## ... trying feature 103 01X010 with gain 0.5850206 
    ## ... trying feature 104 11X010 with gain 0.5845544 
    ## ... trying feature 105 X1X010 with gain 0.5848068 
    ## ... trying feature 106 0XX010 with gain 0.5852685 
    ## ... trying feature 107 1XX010 with gain 0.5846551 
    ## ... trying feature 108 XXX010 with gain 0.5847103 
    ## ... trying feature 109 000110 with gain 0.5845545 
    ## ... trying feature 110 100110 with gain 0.5845699 
    ## ... trying feature 111 X00110 with gain 0.58457 
    ## ... trying feature 112 010110 with gain 0.5845847 
    ## ... trying feature 113 110110 with gain 0.585009 
    ## ... trying feature 114 X10110 with gain 0.584799 
    ## ... trying feature 115 0X0110 with gain 0.5845848 
    ## ... trying feature 116 1X0110 with gain 0.5848517 
    ## ... trying feature 117 XX0110 with gain 0.5847593 
    ## ... trying feature 118 001110 with gain 0.5845587 
    ## ... trying feature 119 101110 with gain 0.5845544 
    ## ... trying feature 120 X01110 with gain 0.5845587 
    ## ... trying feature 121 011110 with gain 0.5845807 
    ## ... trying feature 122 111110 with gain 0.5849687 
    ## ... trying feature 123 X11110 with gain 0.5849858 
    ## ... trying feature 124 0X1110 with gain 0.5845851 
    ## ... trying feature 125 1X1110 with gain 0.5849687 
    ## ... trying feature 126 XX1110 with gain 0.5849887 
    ## ... trying feature 127 00X110 with gain 0.5845589 
    ## ... trying feature 128 10X110 with gain 0.5845699 
    ## ... trying feature 129 X0X110 with gain 0.5845744 
    ## ... trying feature 130 01X110 with gain 0.5846114 
    ## ... trying feature 131 11X110 with gain 0.584624 
    ## ... trying feature 132 X1X110 with gain 0.584641 
    ## ... trying feature 133 0XX110 with gain 0.584616 
    ## ... trying feature 134 1XX110 with gain 0.5846285 
    ## ... trying feature 135 XXX110 with gain 0.5846474 
    ## ... trying feature 136 000X10 with gain 0.584563 
    ## ... trying feature 137 100X10 with gain 0.5845749 
    ## ... trying feature 138 X00X10 with gain 0.5845836 
    ## ... trying feature 139 010X10 with gain 0.5846656 
    ## ... trying feature 140 110X10 with gain 0.5845766 
    ## ... trying feature 141 X10X10 with gain 0.5846747 
    ## ... trying feature 142 0X0X10 with gain 0.5846613 
    ## ... trying feature 143 1X0X10 with gain 0.5845723 
    ## ... trying feature 144 XX0X10 with gain 0.5846638 
    ## ... trying feature 145 001X10 with gain 0.5848435 
    ## ... trying feature 146 101X10 with gain 0.5854183 
    ## ... trying feature 147 X01X10 with gain 0.5845786 
    ## ... trying feature 148 011X10 with gain 0.5848945 
    ## ... trying feature 149 111X10 with gain 0.5846404 
    ## ... trying feature 150 X11X10 with gain 0.58456 
    ## ... trying feature 151 0X1X10 with gain 0.5851725 
    ## ... trying feature 152 1X1X10 with gain 0.5848807 
    ## ... trying feature 153 XX1X10 with gain 0.5845544 
    ## ... trying feature 154 00XX10 with gain 0.5848267 
    ## ... trying feature 155 10XX10 with gain 0.585439 
    ## ... trying feature 156 X0XX10 with gain 0.5845857 
    ## ... trying feature 157 01XX10 with gain 0.584972 
    ## ... trying feature 158 11XX10 with gain 0.5845781 
    ## ... trying feature 159 X1XX10 with gain 0.5846356 
    ## ... trying feature 160 0XXX10 with gain 0.5852067 
    ## ... trying feature 161 1XXX10 with gain 0.5847146 
    ## ... trying feature 162 XXXX10 with gain 0.5845956 
    ## ... trying feature 163 0000X0 with gain 0.5853864 
    ## ... trying feature 164 1000X0 with gain 0.5845553 
    ## ... trying feature 165 X000X0 with gain 0.5847042 
    ## ... trying feature 166 0100X0 with gain 0.5845647 
    ## ... trying feature 167 1100X0 with gain 0.5848253 
    ## ... trying feature 168 X100X0 with gain 0.5846405 
    ## ... trying feature 169 0X00X0 with gain 0.5845583 
    ## ... trying feature 170 1X00X0 with gain 0.5848098 
    ## ... trying feature 171 XX00X0 with gain 0.5847441 
    ## ... trying feature 172 0010X0 with gain 0.5848018 
    ## ... trying feature 173 1010X0 with gain 0.5845731 
    ## ... trying feature 174 X010X0 with gain 0.5847733 
    ## ... trying feature 175 0110X0 with gain 0.5853571 
    ## ... trying feature 176 1110X0 with gain 0.5845989 
    ## ... trying feature 177 X110X0 with gain 0.5849842 
    ## ... trying feature 178 0X10X0 with gain 0.5850365 
    ## ... trying feature 179 1X10X0 with gain 0.5846215 
    ## ... trying feature 180 XX10X0 with gain 0.5847441 
    ## ... trying feature 181 00X0X0 with gain 0.5852207 
    ## ... trying feature 182 10X0X0 with gain 0.5845702 
    ## ... trying feature 183 X0X0X0 with gain 0.5849933 
    ## ... trying feature 184 01X0X0 with gain 0.5855501 
    ## ... trying feature 185 11X0X0 with gain 0.5849381 
    ## ... trying feature 186 X1X0X0 with gain 0.5849933 
    ## ... trying feature 187 0XX0X0 with gain 0.5850155 
    ## ... trying feature 188 1XX0X0 with gain 0.5850155 
    ## ... trying feature 190 0001X0 with gain 0.5845717 
    ## ... trying feature 191 1001X0 with gain 0.5848167 
    ## ... trying feature 192 X001X0 with gain 0.5848016

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 193 0101X0 with gain 0.5849533 
    ## ... trying feature 194 1101X0 with gain 0.5846907 
    ## ... trying feature 195 X101X0 with gain 0.5846295

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 196 0X01X0 with gain 0.5849746 
    ## ... trying feature 197 1X01X0 with gain 0.5848335 
    ## ... trying feature 198 XX01X0 with gain 0.5847415 
    ## ... trying feature 199 0011X0 with gain 0.5845842 
    ## ... trying feature 200 1011X0 with gain 0.5846121 
    ## ... trying feature 201 X011X0 with gain 0.5846033 
    ## ... trying feature 202 0111X0 with gain 0.5848642 
    ## ... trying feature 203 1111X0 with gain 0.584556 
    ## ... trying feature 204 X111X0 with gain 0.5845747 
    ## ... trying feature 205 0X11X0 with gain 0.5848235 
    ## ... trying feature 206 1X11X0 with gain 0.5845688 
    ## ... trying feature 207 XX11X0 with gain 0.5845988

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 208 00X1X0 with gain 0.5846018 
    ## ... trying feature 209 10X1X0 with gain 0.5848462 
    ## ... trying feature 210 X0X1X0 with gain 0.5848199 
    ## ... trying feature 211 01X1X0 with gain 0.5845768 
    ## ... trying feature 212 11X1X0 with gain 0.5846324 
    ## ... trying feature 213 X1X1X0 with gain 0.5846446 
    ## ... trying feature 214 0XX1X0 with gain 0.5845647 
    ## ... trying feature 215 1XX1X0 with gain 0.5847645 
    ## ... trying feature 216 XXX1X0 with gain 0.5847747

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 217 000XX0 with gain 0.5854044 
    ## ... trying feature 218 100XX0 with gain 0.5846501 
    ## ... trying feature 219 X00XX0 with gain 0.584555 
    ## ... trying feature 220 010XX0 with gain 0.584555 
    ## ... trying feature 221 110XX0 with gain 0.5845676 
    ## ... trying feature 222 X10XX0 with gain 0.5845601 
    ## ... trying feature 223 0X0XX0 with gain 0.584574 
    ## ... trying feature 224 1X0XX0 with gain 0.5845546 
    ## ... trying feature 225 XX0XX0 with gain 0.5845612 
    ## ... trying feature 226 001XX0 with gain 0.5848144 
    ## ... trying feature 227 101XX0 with gain 0.5845568 
    ## ... trying feature 228 X01XX0 with gain 0.5846392 
    ## ... trying feature 229 011XX0 with gain 0.5855115 
    ## ... trying feature 230 111XX0 with gain 0.5845695 
    ## ... trying feature 231 X11XX0 with gain 0.5849107 
    ## ... trying feature 232 0X1XX0 with gain 0.5851511 
    ## ... trying feature 233 1X1XX0 with gain 0.584564 
    ## ... trying feature 234 XX1XX0 with gain 0.5847712 
    ## ... trying feature 235 00XXX0 with gain 0.5852492 
    ## ... trying feature 236 10XXX0 with gain 0.5846255 
    ## ... trying feature 237 X0XXX0 with gain 0.5846325 
    ## ... trying feature 238 01XXX0 with gain 0.5855731 
    ## ... trying feature 239 11XXX0 with gain 0.5845959 
    ## ... trying feature 240 X1XXX0 with gain 0.5848929 
    ## ... trying feature 241 0XXXX0 with gain 0.5850256 
    ## ... trying feature 242 1XXXX0 with gain 0.5845608 
    ## ... trying feature 243 XXXXX0 with gain 0.5847747 
    ## ... trying feature 244 000001 with gain 0.5845998 
    ## ... trying feature 245 100001 with gain 0.5852176 
    ## ... trying feature 246 X00001 with gain 0.5847907 
    ## ... trying feature 247 010001 with gain 0.5847571 
    ## ... trying feature 248 110001 with gain 0.5856327 
    ## ... trying feature 249 X10001 with gain 0.5847168 
    ## ... trying feature 250 0X0001 with gain 0.5846892 
    ## ... trying feature 251 1X0001 with gain 0.5850535 
    ## ... trying feature 252 XX0001 with gain 0.5846097 
    ## ... trying feature 253 001001 with gain 0.5852424 
    ## ... trying feature 254 101001 with gain 0.584632 
    ## ... trying feature 255 X01001 with gain 0.5852931 
    ## ... trying feature 256 011001 with gain 0.5850245 
    ## ... trying feature 257 111001 with gain 0.5901906 
    ## ... trying feature 258 X11001 with gain 0.5895837 
    ## ... trying feature 259 0X1001 with gain 0.5847035 
    ## ... trying feature 260 1X1001 with gain 0.5892648 
    ## ... trying feature 261 XX1001 with gain 0.588095 
    ## ... trying feature 262 00X001 with gain 0.5852269 
    ## ... trying feature 263 10X001 with gain 0.5847244 
    ## ... trying feature 264 X0X001 with gain 0.5846812 
    ## ... trying feature 265 01X001 with gain 0.5860036 
    ## ... trying feature 266 11X001 with gain 0.5859777 
    ## ... trying feature 267 X1X001 with gain 0.588295 
    ## ... trying feature 268 0XX001 with gain 0.585272 
    ## ... trying feature 269 1XX001 with gain 0.5862418 
    ## ... trying feature 270 XXX001 with gain 0.5878027 
    ## ... trying feature 271 000101 with gain 0.5845793 
    ## ... trying feature 272 100101 with gain 0.5845708 
    ## ... trying feature 273 X00101 with gain 0.5845676

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 274 010101 with gain 0.5849822 
    ## ... trying feature 275 110101 with gain 0.5847917 
    ## ... trying feature 276 X10101 with gain 0.584704

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 277 0X0101 with gain 0.5850132 
    ## ... trying feature 278 1X0101 with gain 0.5847938 
    ## ... trying feature 279 XX0101 with gain 0.5847101 
    ## ... trying feature 280 001101 with gain 0.5845891 
    ## ... trying feature 281 101101 with gain 0.5846861 
    ## ... trying feature 282 X01101 with gain 0.5846995 
    ## ... trying feature 283 011101 with gain 0.5847298 
    ## ... trying feature 284 111101 with gain 0.5855786 
    ## ... trying feature 285 X11101 with gain 0.5857001 
    ## ... trying feature 286 0X1101 with gain 0.5846981 
    ## ... trying feature 287 1X1101 with gain 0.5853315 
    ## ... trying feature 288 XX1101 with gain 0.5854253

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 289 00X101 with gain 0.5846145 
    ## ... trying feature 290 10X101 with gain 0.5845725 
    ## ... trying feature 291 X0X101 with gain 0.5845795 
    ## ... trying feature 292 01X101 with gain 0.5845545 
    ## ... trying feature 293 11X101 with gain 0.5859359 
    ## ... trying feature 294 X1X101 with gain 0.5859137 
    ## ... trying feature 295 0XX101 with gain 0.5845568 
    ## ... trying feature 296 1XX101 with gain 0.5857075 
    ## ... trying feature 297 XXX101 with gain 0.5856719 
    ## ... trying feature 298 000X01 with gain 0.5845943 
    ## ... trying feature 299 100X01 with gain 0.5848113 
    ## ... trying feature 300 X00X01 with gain 0.5846663 
    ## ... trying feature 301 010X01 with gain 0.584816 
    ## ... trying feature 302 110X01 with gain 0.5859978 
    ## ... trying feature 303 X10X01 with gain 0.584871 
    ## ... trying feature 304 0X0X01 with gain 0.5847404 
    ## ... trying feature 305 1X0X01 with gain 0.5854101 
    ## ... trying feature 306 XX0X01 with gain 0.5847341 
    ## ... trying feature 307 001X01 with gain 0.5852103 
    ## ... trying feature 308 101X01 with gain 0.5845544 
    ## ... trying feature 309 X01X01 with gain 0.5849105 
    ## ... trying feature 310 011X01 with gain 0.584934 
    ## ... trying feature 311 111X01 with gain 0.5861056 
    ## ... trying feature 312 X11X01 with gain 0.5865604 
    ## ... trying feature 313 0X1X01 with gain 0.5846607 
    ## ... trying feature 314 1X1X01 with gain 0.5860263 
    ## ... trying feature 315 XX1X01 with gain 0.5859516 
    ## ... trying feature 316 00XX01 with gain 0.5851869 
    ## ... trying feature 317 10XX01 with gain 0.5847408 
    ## ... trying feature 318 X0XX01 with gain 0.5846075 
    ## ... trying feature 319 01XX01 with gain 0.5859605 
    ## ... trying feature 320 11XX01 with gain 0.5845778 
    ## ... trying feature 321 X1XX01 with gain 0.5857886 
    ## ... trying feature 322 0XXX01 with gain 0.5852647 
    ## ... trying feature 323 1XXX01 with gain 0.5846753 
    ## ... trying feature 324 XXXX01 with gain 0.5856491 
    ## ... trying feature 325 000011 with gain 0.5847132 
    ## ... trying feature 326 100011 with gain 0.5847632 
    ## ... trying feature 327 X00011 with gain 0.5845573 
    ## ... trying feature 328 010011 with gain 0.5845768 
    ## ... trying feature 329 110011 with gain 0.5858374 
    ## ... trying feature 330 X10011 with gain 0.5853789 
    ## ... trying feature 331 0X0011 with gain 0.584558 
    ## ... trying feature 332 1X0011 with gain 0.5859888 
    ## ... trying feature 333 XX0011 with gain 0.5853323 
    ## ... trying feature 334 001011 with gain 0.5847889 
    ## ... trying feature 335 101011 with gain 0.5845544 
    ## ... trying feature 336 X01011 with gain 0.5847889 
    ## ... trying feature 337 011011 with gain 0.5849479 
    ## ... trying feature 338 111011 with gain 0.5852102 
    ## ... trying feature 339 X11011 with gain 0.5852733 
    ## ... trying feature 340 0X1011 with gain 0.5848147 
    ## ... trying feature 341 1X1011 with gain 0.5852102 
    ## ... trying feature 342 XX1011 with gain 0.5850905 
    ## ... trying feature 343 00X011 with gain 0.5849469 
    ## ... trying feature 344 10X011 with gain 0.5847632 
    ## ... trying feature 345 X0X011 with gain 0.5845888 
    ## ... trying feature 346 01X011 with gain 0.5849038 
    ## ... trying feature 347 11X011 with gain 0.5863934 
    ## ... trying feature 348 X1X011 with gain 0.586031 
    ## ... trying feature 349 0XX011 with gain 0.5847489 
    ## ... trying feature 350 1XX011 with gain 0.5865516 
    ## ... trying feature 351 XXX011 with gain 0.5858094 
    ## ... trying feature 352 000111 with gain 0.5845548 
    ## ... trying feature 353 X00111 with gain 0.5845548 
    ## ... trying feature 354 010111 with gain 0.5845693 
    ## ... trying feature 355 110111 with gain 0.5848023 
    ## ... trying feature 356 X10111 with gain 0.5847762 
    ## ... trying feature 357 0X0111 with gain 0.5845698 
    ## ... trying feature 358 1X0111 with gain 0.5848023 
    ## ... trying feature 359 XX0111 with gain 0.5847755 
    ## ... trying feature 360 001111 with gain 0.5845544 
    ## ... trying feature 361 101111 with gain 0.5845812 
    ## ... trying feature 362 X01111 with gain 0.5845812 
    ## ... trying feature 363 011111 with gain 0.5845903 
    ## ... trying feature 364 111111 with gain 0.5845555 
    ## ... trying feature 365 X11111 with gain 0.5845583 
    ## ... trying feature 366 0X1111 with gain 0.5845903 
    ## ... trying feature 367 1X1111 with gain 0.5845545 
    ## ... trying feature 368 XX1111 with gain 0.5845548 
    ## ... trying feature 369 00X111 with gain 0.5845548 
    ## ... trying feature 370 10X111 with gain 0.5845812 
    ## ... trying feature 371 X0X111 with gain 0.5845803 
    ## ... trying feature 372 01X111 with gain 0.5846055 
    ## ... trying feature 373 11X111 with gain 0.5846359 
    ## ... trying feature 374 X1X111 with gain 0.5846136 
    ## ... trying feature 375 0XX111 with gain 0.584606 
    ## ... trying feature 376 1XX111 with gain 0.5846529 
    ## ... trying feature 377 XXX111 with gain 0.5846282 
    ## ... trying feature 378 000X11 with gain 0.5847136 
    ## ... trying feature 379 100X11 with gain 0.5847632 
    ## ... trying feature 380 X00X11 with gain 0.5845573 
    ## ... trying feature 381 010X11 with gain 0.584574 
    ## ... trying feature 382 110X11 with gain 0.586089 
    ## ... trying feature 383 X10X11 with gain 0.5856047 
    ## ... trying feature 384 0X0X11 with gain 0.584557 
    ## ... trying feature 385 1X0X11 with gain 0.5862367 
    ## ... trying feature 386 XX0X11 with gain 0.5855504 
    ## ... trying feature 387 001X11 with gain 0.5847889 
    ## ... trying feature 388 101X11 with gain 0.5845812 
    ## ... trying feature 389 X01X11 with gain 0.5846136 
    ## ... trying feature 390 011X11 with gain 0.5849211 
    ## ... trying feature 391 111X11 with gain 0.5847171 
    ## ... trying feature 392 X11X11 with gain 0.5850897 
    ## ... trying feature 393 0X1X11 with gain 0.5847949 
    ## ... trying feature 394 1X1X11 with gain 0.5847393 
    ## ... trying feature 395 XX1X11 with gain 0.5849737 
    ## ... trying feature 396 00XX11 with gain 0.5849473 
    ## ... trying feature 397 10XX11 with gain 0.5847453 
    ## ... trying feature 398 X0XX11 with gain 0.5845691 
    ## ... trying feature 399 01XX11 with gain 0.5848773 
    ## ... trying feature 400 11XX11 with gain 0.5861432 
    ## ... trying feature 401 X1XX11 with gain 0.5860483 
    ## ... trying feature 402 0XXX11 with gain 0.5847308 
    ## ... trying feature 403 1XXX11 with gain 0.5863122 
    ## ... trying feature 404 XXXX11 with gain 0.5858727 
    ## ... trying feature 405 0000X1 with gain 0.5845731 
    ## ... trying feature 406 1000X1 with gain 0.5850444 
    ## ... trying feature 407 X000X1 with gain 0.5847615 
    ## ... trying feature 408 0100X1 with gain 0.5847177 
    ## ... trying feature 409 1100X1 with gain 0.5863204 
    ## ... trying feature 410 X100X1 with gain 0.5849877 
    ## ... trying feature 411 0X00X1 with gain 0.584675 
    ## ... trying feature 412 1X00X1 with gain 0.5855935 
    ## ... trying feature 413 XX00X1 with gain 0.5847912 
    ## ... trying feature 414 0010X1 with gain 0.5850608 
    ## ... trying feature 415 1010X1 with gain 0.584632 
    ## ... trying feature 416 X010X1 with gain 0.5851416 
    ## ... trying feature 417 0110X1 with gain 0.5847722 
    ## ... trying feature 418 1110X1 with gain 0.5896749 
    ## ... trying feature 419 X110X1 with gain 0.5884953 
    ## ... trying feature 420 0X10X1 with gain 0.5845977 
    ## ... trying feature 421 1X10X1 with gain 0.5888269 
    ## ... trying feature 422 XX10X1 with gain 0.587331 
    ## ... trying feature 423 00X0X1 with gain 0.5850063 
    ## ... trying feature 424 10X0X1 with gain 0.5846677 
    ## ... trying feature 425 X0X0X1 with gain 0.5846402 
    ## ... trying feature 426 01X0X1 with gain 0.5855266 
    ## ... trying feature 427 11X0X1 with gain 0.5852702 
    ## ... trying feature 428 X1X0X1 with gain 0.5867343 
    ## ... trying feature 429 0XX0X1 with gain 0.5850155 
    ## ... trying feature 430 1XX0X1 with gain 0.5854354 
    ## ... trying feature 431 XXX0X1 with gain 0.5864412 
    ## ... trying feature 432 0001X1 with gain 0.5845797 
    ## ... trying feature 433 1001X1 with gain 0.5845708 
    ## ... trying feature 434 X001X1 with gain 0.5845675

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 435 0101X1 with gain 0.5850008 
    ## ... trying feature 436 1101X1 with gain 0.5848979 
    ## ... trying feature 437 X101X1 with gain 0.5847871

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 438 0X01X1 with gain 0.5850327 
    ## ... trying feature 439 1X01X1 with gain 0.5848891 
    ## ... trying feature 440 XX01X1 with gain 0.5847854 
    ## ... trying feature 441 0011X1 with gain 0.5845891 
    ## ... trying feature 442 1011X1 with gain 0.5846579 
    ## ... trying feature 443 X011X1 with gain 0.5846697 
    ## ... trying feature 444 0111X1 with gain 0.5846972 
    ## ... trying feature 445 1111X1 with gain 0.5855248 
    ## ... trying feature 446 X111X1 with gain 0.5856294 
    ## ... trying feature 447 0X11X1 with gain 0.5846694 
    ## ... trying feature 448 1X11X1 with gain 0.585306 
    ## ... trying feature 449 XX11X1 with gain 0.5853866

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 450 00X1X1 with gain 0.584615 
    ## ... trying feature 451 10X1X1 with gain 0.584567 
    ## ... trying feature 452 X0X1X1 with gain 0.5845729 
    ## ... trying feature 453 01X1X1 with gain 0.584556 
    ## ... trying feature 454 11X1X1 with gain 0.5860459 
    ## ... trying feature 455 X1X1X1 with gain 0.5860028 
    ## ... trying feature 456 0XX1X1 with gain 0.5845647 
    ## ... trying feature 457 1XX1X1 with gain 0.5858266 
    ## ... trying feature 458 XXX1X1 with gain 0.5857721 
    ## ... trying feature 459 000XX1 with gain 0.5845697 
    ## ... trying feature 460 100XX1 with gain 0.5847425 
    ## ... trying feature 461 X00XX1 with gain 0.5846538 
    ## ... trying feature 462 010XX1 with gain 0.5847731 
    ## ... trying feature 463 110XX1 with gain 0.5868673 
    ## ... trying feature 464 X10XX1 with gain 0.5852639 
    ## ... trying feature 465 0X0XX1 with gain 0.5847253 
    ## ... trying feature 466 1X0XX1 with gain 0.5861307 
    ## ... trying feature 467 XX0XX1 with gain 0.5850436 
    ## ... trying feature 468 001XX1 with gain 0.5850352 
    ## ... trying feature 469 101XX1 with gain 0.5845551 
    ## ... trying feature 470 X01XX1 with gain 0.5848354 
    ## ... trying feature 471 011XX1 with gain 0.5847192 
    ## ... trying feature 472 111XX1 with gain 0.5859 
    ## ... trying feature 473 X11XX1 with gain 0.5860053 
    ## ... trying feature 474 0X1XX1 with gain 0.5845787 
    ## ... trying feature 475 1X1XX1 with gain 0.5858106 
    ## ... trying feature 476 XX1XX1 with gain 0.5855399 
    ## ... trying feature 477 00XXX1 with gain 0.5849752 
    ## ... trying feature 478 10XXX1 with gain 0.5846798 
    ## ... trying feature 479 X0XXX1 with gain 0.5845881 
    ## ... trying feature 480 01XXX1 with gain 0.5855123 
    ## ... trying feature 481 11XXX1 with gain 0.5846159 
    ## ... trying feature 482 X1XXX1 with gain 0.5848441 
    ## ... trying feature 483 0XXXX1 with gain 0.5850256 
    ## ... trying feature 484 1XXXX1 with gain 0.5845608 
    ## ... trying feature 485 XXXXX1 with gain 0.5847747 
    ## ... trying feature 486 00000X with gain 0.5845805 
    ## ... trying feature 487 10000X with gain 0.5850017 
    ## ... trying feature 488 X0000X with gain 0.5850171 
    ## ... trying feature 489 01000X with gain 0.5847041 
    ## ... trying feature 490 11000X with gain 0.5849119 
    ## ... trying feature 491 X1000X with gain 0.5845725 
    ## ... trying feature 492 0X000X with gain 0.5847371 
    ## ... trying feature 493 1X000X with gain 0.5846536 
    ## ... trying feature 494 XX000X with gain 0.5845615 
    ## ... trying feature 495 00100X with gain 0.5845689 
    ## ... trying feature 496 10100X with gain 0.5846927 
    ## ... trying feature 497 X0100X with gain 0.5847133 
    ## ... trying feature 498 01100X with gain 0.5845568 
    ## ... trying feature 499 11100X with gain 0.5892561 
    ## ... trying feature 500 X1100X with gain 0.5871415 
    ## ... trying feature 501 0X100X with gain 0.5845544 
    ## ... trying feature 502 1X100X with gain 0.5883072 
    ## ... trying feature 503 XX100X with gain 0.5865584 
    ## ... trying feature 504 00X00X with gain 0.5845544 
    ## ... trying feature 505 10X00X with gain 0.5846123 
    ## ... trying feature 506 X0X00X with gain 0.5846225 
    ## ... trying feature 507 01X00X with gain 0.5850105 
    ## ... trying feature 508 11X00X with gain 0.5869694 
    ## ... trying feature 509 X1X00X with gain 0.5877831 
    ## ... trying feature 510 0XX00X with gain 0.5853323 
    ## ... trying feature 511 1XX00X with gain 0.5871818 
    ## ... trying feature 512 XXX00X with gain 0.5879113 
    ## ... trying feature 513 00010X with gain 0.5845966 
    ## ... trying feature 514 10010X with gain 0.5847363 
    ## ... trying feature 515 X0010X with gain 0.5847206

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 516 01010X with gain 0.5854456 
    ## ... trying feature 517 11010X with gain 0.5848745 
    ## ... trying feature 518 X1010X with gain 0.5847374

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 519 0X010X with gain 0.5855128 
    ## ... trying feature 520 1X010X with gain 0.5850344 
    ## ... trying feature 521 XX010X with gain 0.584866 
    ## ... trying feature 522 00110X with gain 0.5846151 
    ## ... trying feature 523 10110X with gain 0.5845595 
    ## ... trying feature 524 X0110X with gain 0.5845638

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 525 01110X with gain 0.5858164 
    ## ... trying feature 526 11110X with gain 0.5855371 
    ## ... trying feature 527 X1110X with gain 0.5858033

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 528 0X110X with gain 0.5857047 
    ## ... trying feature 529 1X110X with gain 0.5854152 
    ## ... trying feature 530 XX110X with gain 0.5856392

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 531 00X10X with gain 0.5846588 
    ## ... trying feature 532 10X10X with gain 0.5846419 
    ## ... trying feature 533 X0X10X with gain 0.5846225

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 534 01X10X with gain 0.5847803 
    ## ... trying feature 535 11X10X with gain 0.5862492 
    ## ... trying feature 536 X1X10X with gain 0.5863188 
    ## ... trying feature 537 0XX10X with gain 0.5846693 
    ## ... trying feature 538 1XX10X with gain 0.5864385 
    ## ... trying feature 539 XXX10X with gain 0.5864737 
    ## ... trying feature 540 000X0X with gain 0.5845868 
    ## ... trying feature 541 100X0X with gain 0.5846007 
    ## ... trying feature 542 X00X0X with gain 0.5846582 
    ## ... trying feature 543 010X0X with gain 0.5847899 
    ## ... trying feature 544 110X0X with gain 0.585384 
    ## ... trying feature 545 X10X0X with gain 0.5846798 
    ## ... trying feature 546 0X0X0X with gain 0.5848342 
    ## ... trying feature 547 1X0X0X with gain 0.5851634 
    ## ... trying feature 548 XX0X0X with gain 0.5846096 
    ## ... trying feature 549 001X0X with gain 0.584564 
    ## ... trying feature 550 101X0X with gain 0.5846235 
    ## ... trying feature 551 X01X0X with gain 0.5846582 
    ## ... trying feature 552 011X0X with gain 0.5845605 
    ## ... trying feature 553 111X0X with gain 0.5858669 
    ## ... trying feature 554 X11X0X with gain 0.5852317 
    ## ... trying feature 555 0X1X0X with gain 0.5845675 
    ## ... trying feature 556 1X1X0X with gain 0.58556 
    ## ... trying feature 557 XX1X0X with gain 0.5850263 
    ## ... trying feature 558 00XX0X with gain 0.584556 
    ## ... trying feature 559 10XX0X with gain 0.584556 
    ## ... trying feature 561 01XX0X with gain 0.5849443 
    ## ... trying feature 562 11XX0X with gain 0.584767 
    ## ... trying feature 563 X1XX0X with gain 0.585529 
    ## ... trying feature 564 0XXX0X with gain 0.5852649 
    ## ... trying feature 565 1XXX0X with gain 0.5848745 
    ## ... trying feature 566 XXXX0X with gain 0.585529 
    ## ... trying feature 567 00001X with gain 0.5847217 
    ## ... trying feature 568 10001X with gain 0.5847004 
    ## ... trying feature 569 X0001X with gain 0.5845556 
    ## ... trying feature 570 01001X with gain 0.584678 
    ## ... trying feature 571 11001X with gain 0.5852983 
    ## ... trying feature 572 X1001X with gain 0.5852596 
    ## ... trying feature 573 0X001X with gain 0.5846306 
    ## ... trying feature 574 1X001X with gain 0.5854089 
    ## ... trying feature 575 XX001X with gain 0.5852313 
    ## ... trying feature 576 00101X with gain 0.5846267 
    ## ... trying feature 577 10101X with gain 0.5854183 
    ## ... trying feature 578 X0101X with gain 0.5846455 
    ## ... trying feature 579 01101X with gain 0.5853016 
    ## ... trying feature 580 11101X with gain 0.5847336 
    ## ... trying feature 581 X1101X with gain 0.5854664 
    ## ... trying feature 582 0X101X with gain 0.5853833 
    ## ... trying feature 583 1X101X with gain 0.5845578 
    ## ... trying feature 584 XX101X with gain 0.5851468 
    ## ... trying feature 585 00X01X with gain 0.5845671 
    ## ... trying feature 586 10X01X with gain 0.5847815 
    ## ... trying feature 587 X0X01X with gain 0.5846132 
    ## ... trying feature 588 01X01X with gain 0.5853462 
    ## ... trying feature 589 11X01X with gain 0.5854073 
    ## ... trying feature 590 X1X01X with gain 0.586091 
    ## ... trying feature 591 0XX01X with gain 0.5853323 
    ## ... trying feature 592 1XX01X with gain 0.5850314 
    ## ... trying feature 593 XXX01X with gain 0.5857654 
    ## ... trying feature 594 00011X with gain 0.584555 
    ## ... trying feature 595 10011X with gain 0.5845699 
    ## ... trying feature 596 X0011X with gain 0.5845704 
    ## ... trying feature 597 01011X with gain 0.5845999 
    ## ... trying feature 598 11011X with gain 0.5851125 
    ## ... trying feature 599 X1011X with gain 0.5850089 
    ## ... trying feature 600 0X011X with gain 0.5846005 
    ## ... trying feature 601 1X011X with gain 0.5850723 
    ## ... trying feature 602 XX011X with gain 0.5849788 
    ## ... trying feature 603 00111X with gain 0.5845587 
    ## ... trying feature 604 10111X with gain 0.5845812 
    ## ... trying feature 605 X0111X with gain 0.5845737 
    ## ... trying feature 606 01111X with gain 0.5846171 
    ## ... trying feature 607 11111X with gain 0.5847891 
    ## ... trying feature 608 X1111X with gain 0.5848158 
    ## ... trying feature 609 0X111X with gain 0.5846216 
    ## ... trying feature 610 1X111X with gain 0.5847547 
    ## ... trying feature 611 XX111X with gain 0.5847814 
    ## ... trying feature 612 00X11X with gain 0.5845593 
    ## ... trying feature 613 10X11X with gain 0.5845632 
    ## ... trying feature 614 X0X11X with gain 0.5845604 
    ## ... trying feature 615 01X11X with gain 0.5846641 
    ## ... trying feature 616 11X11X with gain 0.5845544 
    ## ... trying feature 617 X1X11X with gain 0.5845569 
    ## ... trying feature 618 0XX11X with gain 0.5846693 
    ## ... trying feature 619 1XX11X with gain 0.5845546 
    ## ... trying feature 620 XXX11X with gain 0.5845556 
    ## ... trying feature 621 000X1X with gain 0.5847223 
    ## ... trying feature 622 100X1X with gain 0.5846482 
    ## ... trying feature 623 X00X1X with gain 0.5845546 
    ## ... trying feature 624 010X1X with gain 0.5846624 
    ## ... trying feature 625 110X1X with gain 0.5857552 
    ## ... trying feature 626 X10X1X with gain 0.5855921 
    ## ... trying feature 627 0X0X1X with gain 0.584619 
    ## ... trying feature 628 1X0X1X with gain 0.5858481 
    ## ... trying feature 629 XX0X1X with gain 0.5855423 
    ## ... trying feature 630 001X1X with gain 0.584624 
    ## ... trying feature 631 101X1X with gain 0.5850082 
    ## ... trying feature 632 X01X1X with gain 0.5846192 
    ## ... trying feature 633 011X1X with gain 0.5852457 
    ## ... trying feature 634 111X1X with gain 0.5845548 
    ## ... trying feature 635 X11X1X with gain 0.584889 
    ## ... trying feature 636 0X1X1X with gain 0.5853252 
    ## ... trying feature 637 1X1X1X with gain 0.5846166 
    ## ... trying feature 638 XX1X1X with gain 0.5847591 
    ## ... trying feature 639 00XX1X with gain 0.5845661 
    ## ... trying feature 640 10XX1X with gain 0.5847236 
    ## ... trying feature 641 X0XX1X with gain 0.5846004 
    ## ... trying feature 642 01XX1X with gain 0.5852767 
    ## ... trying feature 643 11XX1X with gain 0.585087 
    ## ... trying feature 644 X1XX1X with gain 0.5857631 
    ## ... trying feature 645 0XXX1X with gain 0.5852649 
    ## ... trying feature 646 1XXX1X with gain 0.5848745 
    ## ... trying feature 647 XXXX1X with gain 0.585529 
    ## ... trying feature 648 0000XX with gain 0.5846067 
    ## ... trying feature 649 1000XX with gain 0.5849002 
    ## ... trying feature 650 X000XX with gain 0.5849853 
    ## ... trying feature 651 0100XX with gain 0.5846281 
    ## ... trying feature 652 1100XX with gain 0.5852404 
    ## ... trying feature 653 X100XX with gain 0.5847077 
    ## ... trying feature 654 0X00XX with gain 0.5846672 
    ## ... trying feature 655 1X00XX with gain 0.5848738 
    ## ... trying feature 656 XX00XX with gain 0.5845815 
    ## ... trying feature 657 0010XX with gain 0.584599 
    ## ... trying feature 658 1010XX with gain 0.5845665 
    ## ... trying feature 659 X010XX with gain 0.5846212 
    ## ... trying feature 660 0110XX with gain 0.5846168 
    ## ... trying feature 661 1110XX with gain 0.5887342 
    ## ... trying feature 662 X110XX with gain 0.5862616 
    ## ... trying feature 663 0X10XX with gain 0.5846672 
    ## ... trying feature 664 1X10XX with gain 0.5881728 
    ## ... trying feature 665 XX10XX with gain 0.5859058 
    ## ... trying feature 666 00X0XX with gain 0.5845555 
    ## ... trying feature 667 10X0XX with gain 0.5846973 
    ## ... trying feature 668 X0X0XX with gain 0.5846758 
    ## ... trying feature 669 01X0XX with gain 0.5845555 
    ## ... trying feature 670 11X0XX with gain 0.5860702 
    ## ... trying feature 671 X1X0XX with gain 0.5861298 
    ## ... trying feature 673 1XX0XX with gain 0.5864412 
    ## ... trying feature 674 XXX0XX with gain 0.5864412 
    ## ... trying feature 675 0001XX with gain 0.5845972 
    ## ... trying feature 676 1001XX with gain 0.5847301 
    ## ... trying feature 677 X001XX with gain 0.5847146

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 678 0101XX with gain 0.5855179 
    ## ... trying feature 679 1101XX with gain 0.5850635 
    ## ... trying feature 680 X101XX with gain 0.5848755

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 681 0X01XX with gain 0.5855887 
    ## ... trying feature 682 1X01XX with gain 0.5852327 
    ## ... trying feature 683 XX01XX with gain 0.5850183 
    ## ... trying feature 684 0011XX with gain 0.5846196 
    ## ... trying feature 685 1011XX with gain 0.5845568 
    ## ... trying feature 686 X011XX with gain 0.5845602

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 687 0111XX with gain 0.5857016 
    ## ... trying feature 688 1111XX with gain 0.5852745 
    ## ... trying feature 689 X111XX with gain 0.5854892

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 690 0X11XX with gain 0.5855887 
    ## ... trying feature 691 1X11XX with gain 0.5851951 
    ## ... trying feature 692 XX11XX with gain 0.5853749

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 693 00X1XX with gain 0.584664 
    ## ... trying feature 694 10X1XX with gain 0.5846475 
    ## ... trying feature 695 X0X1XX with gain 0.5846267

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 696 01X1XX with gain 0.584664 
    ## ... trying feature 697 11X1XX with gain 0.5862296 
    ## ... trying feature 698 X1X1XX with gain 0.5862656 
    ## ... trying feature 699 0XX1XX with gain 0.5845544 
    ## ... trying feature 700 1XX1XX with gain 0.5864412 
    ## ... trying feature 701 XXX1XX with gain 0.5864412 
    ## ... trying feature 702 000XXX with gain 0.5846153 
    ## ... trying feature 703 100XXX with gain 0.5845808 
    ## ... trying feature 704 X00XXX with gain 0.584653 
    ## ... trying feature 705 010XXX with gain 0.5846958 
    ## ... trying feature 706 110XXX with gain 0.586034 
    ## ... trying feature 707 X10XXX with gain 0.5849998 
    ## ... trying feature 708 0X0XXX with gain 0.5847511 
    ## ... trying feature 709 1X0XXX with gain 0.5857517 
    ## ... trying feature 710 XX0XXX with gain 0.5848415 
    ## ... trying feature 711 001XXX with gain 0.5845899 
    ## ... trying feature 712 101XXX with gain 0.584558 
    ## ... trying feature 713 X01XXX with gain 0.5845954 
    ## ... trying feature 714 011XXX with gain 0.5846886 
    ## ... trying feature 715 111XXX with gain 0.585914 
    ## ... trying feature 716 X11XXX with gain 0.5849574 
    ## ... trying feature 717 0X1XXX with gain 0.5847511 
    ## ... trying feature 718 1X1XXX with gain 0.5857517 
    ## ... trying feature 719 XX1XXX with gain 0.5848415 
    ## ... trying feature 720 00XXXX with gain 0.5845544 
    ## ... trying feature 721 10XXXX with gain 0.5845649 
    ## ... trying feature 722 X0XXXX with gain 0.5846004 
    ## ... trying feature 723 01XXXX with gain 0.5845544 
    ## ... trying feature 724 11XXXX with gain 0.5845649 
    ## ... trying feature 725 X1XXXX with gain 0.5846004 
    ## ... trying feature 727 1XXXXX with gain 0.5845544 
    ## ... Using feature 257 111001 
    ## Adding Feature Number 6 
    ## ... trying feature 1 000000 with gain 0.5909412 
    ## ... trying feature 2 100000 with gain 0.5901922 
    ## ... trying feature 3 X00000 with gain 0.5903241 
    ## ... trying feature 4 010000 with gain 0.5902074 
    ## ... trying feature 5 110000 with gain 0.5906333 
    ## ... trying feature 6 X10000 with gain 0.5903363 
    ## ... trying feature 7 0X0000 with gain 0.5901913 
    ## ... trying feature 8 1X0000 with gain 0.5906063 
    ## ... trying feature 9 XX0000 with gain 0.5904562 
    ## ... trying feature 10 001000 with gain 0.5906278 
    ## ... trying feature 11 101000 with gain 0.590253 
    ## ... trying feature 12 X01000 with gain 0.5902554 
    ## ... trying feature 13 011000 with gain 0.5910687 
    ## ... trying feature 14 111000 with gain 0.5904506 
    ## ... trying feature 15 X11000 with gain 0.5903815 
    ## ... trying feature 16 0X1000 with gain 0.5907016 
    ## ... trying feature 17 1X1000 with gain 0.5903387 
    ## ... trying feature 18 XX1000 with gain 0.5902997 
    ## ... trying feature 19 00X000 with gain 0.5911488 
    ## ... trying feature 20 10X000 with gain 0.5902142 
    ## ... trying feature 21 X0X000 with gain 0.5904158 
    ## ... trying feature 22 01X000 with gain 0.5912735 
    ## ... trying feature 23 11X000 with gain 0.5911948 
    ## ... trying feature 24 X1X000 with gain 0.5902033 
    ## ... trying feature 25 0XX000 with gain 0.5906941 
    ## ... trying feature 26 1XX000 with gain 0.5910007 
    ## ... trying feature 27 XXX000 with gain 0.5902898 
    ## ... trying feature 28 000100 with gain 0.5902082 
    ## ... trying feature 29 100100 with gain 0.5903818 
    ## ... trying feature 30 X00100 with gain 0.5903687

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 31 010100 with gain 0.5905574 
    ## ... trying feature 32 110100 with gain 0.5901981 
    ## ... trying feature 33 X10100 with gain 0.5902194

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 34 0X0100 with gain 0.5905786 
    ## ... trying feature 35 1X0100 with gain 0.5901966 
    ## ... trying feature 36 XX0100 with gain 0.5901907 
    ## ... trying feature 37 001100 with gain 0.5902145 
    ## ... trying feature 38 101100 with gain 0.5902698 
    ## ... trying feature 39 X01100 with gain 0.5902616 
    ## ... trying feature 40 011100 with gain 0.5905392 
    ## ... trying feature 41 111100 with gain 0.5902127 
    ## ... trying feature 42 X11100 with gain 0.5901918 
    ## ... trying feature 43 0X1100 with gain 0.5905032 
    ## ... trying feature 44 1X1100 with gain 0.5901922 
    ## ... trying feature 45 XX1100 with gain 0.5901944

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 46 00X100 with gain 0.5902323 
    ## ... trying feature 47 10X100 with gain 0.5904579 
    ## ... trying feature 48 X0X100 with gain 0.5904361 
    ## ... trying feature 49 01X100 with gain 0.5902323 
    ## ... trying feature 50 11X100 with gain 0.5902234 
    ## ... trying feature 51 X1X100 with gain 0.5902115 
    ## ... trying feature 52 0XX100 with gain 0.5902165 
    ## ... trying feature 53 1XX100 with gain 0.590191 
    ## ... trying feature 54 XXX100 with gain 0.5901927

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 55 000X00 with gain 0.5909595 
    ## ... trying feature 56 100X00 with gain 0.5902523 
    ## ... trying feature 57 X00X00 with gain 0.5901939 
    ## ... trying feature 58 010X00 with gain 0.5901937 
    ## ... trying feature 59 110X00 with gain 0.5905014 
    ## ... trying feature 60 X10X00 with gain 0.5903579 
    ## ... trying feature 61 0X0X00 with gain 0.5902008 
    ## ... trying feature 62 1X0X00 with gain 0.5903719 
    ## ... trying feature 63 XX0X00 with gain 0.5903643 
    ## ... trying feature 64 001X00 with gain 0.5906427 
    ## ... trying feature 65 101X00 with gain 0.5903465 
    ## ... trying feature 66 X01X00 with gain 0.5901931 
    ## ... trying feature 67 011X00 with gain 0.5912439 
    ## ... trying feature 68 111X00 with gain 0.5904245 
    ## ... trying feature 69 X11X00 with gain 0.590291 
    ## ... trying feature 70 0X1X00 with gain 0.5908326 
    ## ... trying feature 71 1X1X00 with gain 0.5902862 
    ## ... trying feature 72 XX1X00 with gain 0.5902738 
    ## ... trying feature 73 00XX00 with gain 0.5911815 
    ## ... trying feature 74 10XX00 with gain 0.590446 
    ## ... trying feature 75 X0XX00 with gain 0.5901984 
    ## ... trying feature 76 01XX00 with gain 0.5913173 
    ## ... trying feature 77 11XX00 with gain 0.5909878 
    ## ... trying feature 78 X1XX00 with gain 0.5901936 
    ## ... trying feature 79 0XXX00 with gain 0.5907202 
    ## ... trying feature 80 1XXX00 with gain 0.5906026 
    ## ... trying feature 81 XXXX00 with gain 0.5902003 
    ## ... trying feature 82 000010 with gain 0.5901988 
    ## ... trying feature 83 100010 with gain 0.5901959 
    ## ... trying feature 84 X00010 with gain 0.5902041 
    ## ... trying feature 85 010010 with gain 0.5902949 
    ## ... trying feature 86 110010 with gain 0.5902502 
    ## ... trying feature 87 X10010 with gain 0.5902065 
    ## ... trying feature 88 0X0010 with gain 0.5902908 
    ## ... trying feature 89 1X0010 with gain 0.5902522 
    ## ... trying feature 90 XX0010 with gain 0.5902045 
    ## ... trying feature 91 001010 with gain 0.5904972 
    ## ... trying feature 92 101010 with gain 0.5911386 
    ## ... trying feature 93 X01010 with gain 0.5902256 
    ## ... trying feature 94 011010 with gain 0.5905863 
    ## ... trying feature 95 111010 with gain 0.5901944 
    ## ... trying feature 96 X11010 with gain 0.590388 
    ## ... trying feature 97 0X1010 with gain 0.590887 
    ## ... trying feature 98 1X1010 with gain 0.5902939 
    ## ... trying feature 99 XX1010 with gain 0.5902792 
    ## ... trying feature 100 00X010 with gain 0.5904802 
    ## ... trying feature 101 10X010 with gain 0.591144 
    ## ... trying feature 102 X0X010 with gain 0.5902293 
    ## ... trying feature 103 01X010 with gain 0.5906394 
    ## ... trying feature 104 11X010 with gain 0.590196 
    ## ... trying feature 105 X1X010 with gain 0.5903749 
    ## ... trying feature 106 0XX010 with gain 0.5908921 
    ## ... trying feature 107 1XX010 with gain 0.5903533 
    ## ... trying feature 108 XXX010 with gain 0.5902898 
    ## ... trying feature 109 000110 with gain 0.5901908 
    ## ... trying feature 110 100110 with gain 0.5902096 
    ## ... trying feature 111 X00110 with gain 0.5902097 
    ## ... trying feature 112 010110 with gain 0.5902178 
    ## ... trying feature 113 110110 with gain 0.5905428 
    ## ... trying feature 114 X10110 with gain 0.5903706 
    ## ... trying feature 115 0X0110 with gain 0.5902179 
    ## ... trying feature 116 1X0110 with gain 0.590395 
    ## ... trying feature 117 XX0110 with gain 0.5903294 
    ## ... trying feature 118 001110 with gain 0.590196 
    ## ... trying feature 119 101110 with gain 0.5901906 
    ## ... trying feature 120 X01110 with gain 0.590196 
    ## ... trying feature 121 011110 with gain 0.5902119 
    ## ... trying feature 122 111110 with gain 0.5907969 
    ## ... trying feature 123 X11110 with gain 0.5908122 
    ## ... trying feature 124 0X1110 with gain 0.5902174 
    ## ... trying feature 125 1X1110 with gain 0.5907969 
    ## ... trying feature 126 XX1110 with gain 0.5908162 
    ## ... trying feature 127 00X110 with gain 0.5901962 
    ## ... trying feature 128 10X110 with gain 0.5902096 
    ## ... trying feature 129 X0X110 with gain 0.5902152 
    ## ... trying feature 130 01X110 with gain 0.5902394 
    ## ... trying feature 131 11X110 with gain 0.5903846 
    ## ... trying feature 132 X1X110 with gain 0.5904063 
    ## ... trying feature 133 0XX110 with gain 0.5902451 
    ## ... trying feature 134 1XX110 with gain 0.590393 
    ## ... trying feature 135 XXX110 with gain 0.5904177 
    ## ... trying feature 136 000X10 with gain 0.590199 
    ## ... trying feature 137 100X10 with gain 0.5902149 
    ## ... trying feature 138 X00X10 with gain 0.5902233 
    ## ... trying feature 139 010X10 with gain 0.5902815 
    ## ... trying feature 140 110X10 with gain 0.5901929 
    ## ... trying feature 141 X10X10 with gain 0.5902547 
    ## ... trying feature 142 0X0X10 with gain 0.5902777 
    ## ... trying feature 143 1X0X10 with gain 0.5901916 
    ## ... trying feature 144 XX0X10 with gain 0.5902461 
    ## ... trying feature 145 001X10 with gain 0.5904857 
    ## ... trying feature 146 101X10 with gain 0.5911386 
    ## ... trying feature 147 X01X10 with gain 0.590227 
    ## ... trying feature 148 011X10 with gain 0.5905575 
    ## ... trying feature 149 111X10 with gain 0.5903582 
    ## ... trying feature 150 X11X10 with gain 0.590191 
    ## ... trying feature 151 0X1X10 with gain 0.5908453 
    ## ... trying feature 152 1X1X10 with gain 0.5906729 
    ## ... trying feature 153 XX1X10 with gain 0.5902009 
    ## ... trying feature 154 00XX10 with gain 0.5904692 
    ## ... trying feature 155 10XX10 with gain 0.5911632 
    ## ... trying feature 156 X0XX10 with gain 0.5902364 
    ## ... trying feature 157 01XX10 with gain 0.5905979 
    ## ... trying feature 158 11XX10 with gain 0.5902885 
    ## ... trying feature 159 X1XX10 with gain 0.5902124 
    ## ... trying feature 160 0XXX10 with gain 0.5908372 
    ## ... trying feature 161 1XXX10 with gain 0.5905124 
    ## ... trying feature 162 XXXX10 with gain 0.5901943 
    ## ... trying feature 163 0000X0 with gain 0.5909497 
    ## ... trying feature 164 1000X0 with gain 0.5901924 
    ## ... trying feature 165 X000X0 with gain 0.5903281 
    ## ... trying feature 166 0100X0 with gain 0.5902431 
    ## ... trying feature 167 1100X0 with gain 0.5907005 
    ## ... trying feature 168 X100X0 with gain 0.5903007 
    ## ... trying feature 169 0X00X0 with gain 0.5901962 
    ## ... trying feature 170 1X00X0 with gain 0.5906718 
    ## ... trying feature 171 XX00X0 with gain 0.5904087 
    ## ... trying feature 172 0010X0 with gain 0.5902865 
    ## ... trying feature 173 1010X0 with gain 0.590205 
    ## ... trying feature 174 X010X0 with gain 0.590289 
    ## ... trying feature 175 0110X0 with gain 0.5913717 
    ## ... trying feature 176 1110X0 with gain 0.590416 
    ## ... trying feature 177 X110X0 with gain 0.5905634 
    ## ... trying feature 178 0X10X0 with gain 0.5911138 
    ## ... trying feature 179 1X10X0 with gain 0.5904437 
    ## ... trying feature 180 XX10X0 with gain 0.5904087 
    ## ... trying feature 181 00X0X0 with gain 0.5905834 
    ## ... trying feature 182 10X0X0 with gain 0.5902055 
    ## ... trying feature 183 X0X0X0 with gain 0.5904596 
    ## ... trying feature 184 01X0X0 with gain 0.591903 
    ## ... trying feature 185 11X0X0 with gain 0.5912618 
    ## ... trying feature 186 X1X0X0 with gain 0.5904596 
    ## ... trying feature 187 0XX0X0 with gain 0.5913786 
    ## ... trying feature 188 1XX0X0 with gain 0.5913786 
    ## ... trying feature 190 0001X0 with gain 0.5902084 
    ## ... trying feature 191 1001X0 with gain 0.5903674 
    ## ... trying feature 192 X001X0 with gain 0.5903551

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 193 0101X0 with gain 0.5905903 
    ## ... trying feature 194 1101X0 with gain 0.5901906 
    ## ... trying feature 195 X101X0 with gain 0.5901993

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 196 0X01X0 with gain 0.5906121 
    ## ... trying feature 197 1X01X0 with gain 0.5902127 
    ## ... trying feature 198 XX01X0 with gain 0.5901939 
    ## ... trying feature 199 0011X0 with gain 0.5902199 
    ## ... trying feature 200 1011X0 with gain 0.5902698 
    ## ... trying feature 201 X011X0 with gain 0.5902598 
    ## ... trying feature 202 0111X0 with gain 0.590507 
    ## ... trying feature 203 1111X0 with gain 0.5903133 
    ## ... trying feature 204 X111X0 with gain 0.5902485 
    ## ... trying feature 205 0X11X0 with gain 0.5904664 
    ## ... trying feature 206 1X11X0 with gain 0.5902455 
    ## ... trying feature 207 XX11X0 with gain 0.5902095

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 208 00X1X0 with gain 0.590238 
    ## ... trying feature 209 10X1X0 with gain 0.5904472 
    ## ... trying feature 210 X0X1X0 with gain 0.5904232 
    ## ... trying feature 211 01X1X0 with gain 0.5902143 
    ## ... trying feature 212 11X1X0 with gain 0.5902761 
    ## ... trying feature 213 X1X1X0 with gain 0.59026 
    ## ... trying feature 214 0XX1X0 with gain 0.5902018 
    ## ... trying feature 215 1XX1X0 with gain 0.5901991 
    ## ... trying feature 216 XXX1X0 with gain 0.5901962

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 217 000XX0 with gain 0.5909682 
    ## ... trying feature 218 100XX0 with gain 0.5902468 
    ## ... trying feature 219 X00XX0 with gain 0.5901955 
    ## ... trying feature 220 010XX0 with gain 0.5902131 
    ## ... trying feature 221 110XX0 with gain 0.5904721 
    ## ... trying feature 222 X10XX0 with gain 0.5902951 
    ## ... trying feature 223 0X0XX0 with gain 0.5901906 
    ## ... trying feature 224 1X0XX0 with gain 0.5903573 
    ## ... trying feature 225 XX0XX0 with gain 0.5903053 
    ## ... trying feature 226 001XX0 with gain 0.590295 
    ## ... trying feature 227 101XX0 with gain 0.5901996 
    ## ... trying feature 228 X01XX0 with gain 0.5902054 
    ## ... trying feature 229 011XX0 with gain 0.5915565 
    ## ... trying feature 230 111XX0 with gain 0.5905693 
    ## ... trying feature 231 X11XX0 with gain 0.5902869 
    ## ... trying feature 232 0X1XX0 with gain 0.5912675 
    ## ... trying feature 233 1X1XX0 with gain 0.5904896 
    ## ... trying feature 234 XX1XX0 with gain 0.5902545 
    ## ... trying feature 235 00XXX0 with gain 0.5906072 
    ## ... trying feature 236 10XXX0 with gain 0.5902533 
    ## ... trying feature 237 X0XXX0 with gain 0.5902161 
    ## ... trying feature 238 01XXX0 with gain 0.5919215 
    ## ... trying feature 239 11XXX0 with gain 0.5912416 
    ## ... trying feature 240 X1XXX0 with gain 0.5901908 
    ## ... trying feature 241 0XXXX0 with gain 0.5913802 
    ## ... trying feature 242 1XXXX0 with gain 0.5909776 
    ## ... trying feature 243 XXXXX0 with gain 0.5901962 
    ## ... trying feature 244 000001 with gain 0.5902374 
    ## ... trying feature 245 100001 with gain 0.5910827 
    ## ... trying feature 246 X00001 with gain 0.5905329 
    ## ... trying feature 247 010001 with gain 0.5906239 
    ## ... trying feature 248 110001 with gain 0.5904179 
    ## ... trying feature 249 X10001 with gain 0.5902146 
    ## ... trying feature 250 0X0001 with gain 0.5905137 
    ## ... trying feature 251 1X0001 with gain 0.5902044 
    ## ... trying feature 252 XX0001 with gain 0.5903042 
    ## ... trying feature 253 001001 with gain 0.5911012 
    ## ... trying feature 254 101001 with gain 0.5902289 
    ## ... trying feature 255 X01001 with gain 0.5909859 
    ## ... trying feature 256 011001 with gain 0.5909357 
    ## ... trying feature 258 X11001 with gain 0.5909357 
    ## ... trying feature 259 0X1001 with gain 0.5904655 
    ## ... trying feature 260 1X1001 with gain 0.5902289 
    ## ... trying feature 261 XX1001 with gain 0.5903819 
    ## ... trying feature 262 00X001 with gain 0.5910325 
    ## ... trying feature 263 10X001 with gain 0.5905226 
    ## ... trying feature 264 X0X001 with gain 0.5902816 
    ## ... trying feature 265 01X001 with gain 0.5928585 
    ## ... trying feature 266 11X001 with gain 0.5904179 
    ## ... trying feature 267 X1X001 with gain 0.5910541 
    ## ... trying feature 268 0XX001 with gain 0.5917415 
    ## ... trying feature 269 1XX001 with gain 0.5902241 
    ## ... trying feature 270 XXX001 with gain 0.590824 
    ## ... trying feature 271 000101 with gain 0.5902174 
    ## ... trying feature 272 100101 with gain 0.5901977 
    ## ... trying feature 273 X00101 with gain 0.5901955

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 274 010101 with gain 0.590641 
    ## ... trying feature 275 110101 with gain 0.590206 
    ## ... trying feature 276 X10101 with gain 0.5901912

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 277 0X0101 with gain 0.5906749 
    ## ... trying feature 278 1X0101 with gain 0.5902123 
    ## ... trying feature 279 XX0101 with gain 0.5901933 
    ## ... trying feature 280 001101 with gain 0.5902235 
    ## ... trying feature 281 101101 with gain 0.5904323 
    ## ... trying feature 282 X01101 with gain 0.5904486 
    ## ... trying feature 283 011101 with gain 0.5903883 
    ## ... trying feature 284 111101 with gain 0.5904042 
    ## ... trying feature 285 X11101 with gain 0.5904748 
    ## ... trying feature 286 0X1101 with gain 0.5903557 
    ## ... trying feature 287 1X1101 with gain 0.5902861 
    ## ... trying feature 288 XX1101 with gain 0.5903304

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 289 00X101 with gain 0.5902508 
    ## ... trying feature 290 10X101 with gain 0.5902547 
    ## ... trying feature 291 X0X101 with gain 0.590267 
    ## ... trying feature 292 01X101 with gain 0.5901908 
    ## ... trying feature 293 11X101 with gain 0.5904261 
    ## ... trying feature 294 X1X101 with gain 0.5904234 
    ## ... trying feature 295 0XX101 with gain 0.5901927 
    ## ... trying feature 296 1XX101 with gain 0.5903267 
    ## ... trying feature 297 XXX101 with gain 0.590319 
    ## ... trying feature 298 000X01 with gain 0.5902314 
    ## ... trying feature 299 100X01 with gain 0.5905831 
    ## ... trying feature 300 X00X01 with gain 0.5903863 
    ## ... trying feature 301 010X01 with gain 0.5907108 
    ## ... trying feature 302 110X01 with gain 0.5904408 
    ## ... trying feature 303 X10X01 with gain 0.590209 
    ## ... trying feature 304 0X0X01 with gain 0.5905932 
    ## ... trying feature 305 1X0X01 with gain 0.5902316 
    ## ... trying feature 306 XX0X01 with gain 0.590276 
    ## ... trying feature 307 001X01 with gain 0.5910638 
    ## ... trying feature 308 101X01 with gain 0.5902102 
    ## ... trying feature 309 X01X01 with gain 0.5905015 
    ## ... trying feature 310 011X01 with gain 0.5908119 
    ## ... trying feature 311 111X01 with gain 0.5904042 
    ## ... trying feature 312 X11X01 with gain 0.5902882 
    ## ... trying feature 313 0X1X01 with gain 0.5904012 
    ## ... trying feature 314 1X1X01 with gain 0.5903267 
    ## ... trying feature 315 XX1X01 with gain 0.5902004 
    ## ... trying feature 316 00XX01 with gain 0.590986 
    ## ... trying feature 317 10XX01 with gain 0.590615 
    ## ... trying feature 318 X0XX01 with gain 0.5901984 
    ## ... trying feature 319 01XX01 with gain 0.5927756 
    ## ... trying feature 320 11XX01 with gain 0.5908871 
    ## ... trying feature 321 X1XX01 with gain 0.5904605 
    ## ... trying feature 322 0XXX01 with gain 0.5917121 
    ## ... trying feature 323 1XXX01 with gain 0.5904436 
    ## ... trying feature 324 XXXX01 with gain 0.5904343 
    ## ... trying feature 325 000011 with gain 0.590356 
    ## ... trying feature 326 100011 with gain 0.5903454 
    ## ... trying feature 327 X00011 with gain 0.5901908 
    ## ... trying feature 328 010011 with gain 0.5902053 
    ## ... trying feature 329 110011 with gain 0.5911304 
    ## ... trying feature 330 X10011 with gain 0.5908011 
    ## ... trying feature 331 0X0011 with gain 0.5901913 
    ## ... trying feature 332 1X0011 with gain 0.591236 
    ## ... trying feature 333 XX0011 with gain 0.5907431 
    ## ... trying feature 334 001011 with gain 0.590449 
    ## ... trying feature 335 101011 with gain 0.5901906 
    ## ... trying feature 336 X01011 with gain 0.590449 
    ## ... trying feature 337 011011 with gain 0.5906894 
    ## ... trying feature 338 111011 with gain 0.5907275 
    ## ... trying feature 339 X11011 with gain 0.5909891 
    ## ... trying feature 340 0X1011 with gain 0.5905208 
    ## ... trying feature 341 1X1011 with gain 0.5907275 
    ## ... trying feature 342 XX1011 with gain 0.590775 
    ## ... trying feature 343 00X011 with gain 0.5906135 
    ## ... trying feature 344 10X011 with gain 0.5903454 
    ## ... trying feature 345 X0X011 with gain 0.5902611 
    ## ... trying feature 346 01X011 with gain 0.5905971 
    ## ... trying feature 347 11X011 with gain 0.5915679 
    ## ... trying feature 348 X1X011 with gain 0.5915326 
    ## ... trying feature 349 0XX011 with gain 0.5904143 
    ## ... trying feature 350 1XX011 with gain 0.5916799 
    ## ... trying feature 351 XXX011 with gain 0.5912821 
    ## ... trying feature 352 000111 with gain 0.5901911 
    ## ... trying feature 353 X00111 with gain 0.5901911 
    ## ... trying feature 354 010111 with gain 0.5902082 
    ## ... trying feature 355 110111 with gain 0.5903688 
    ## ... trying feature 356 X10111 with gain 0.5903457 
    ## ... trying feature 357 0X0111 with gain 0.5902086 
    ## ... trying feature 358 1X0111 with gain 0.5903688 
    ## ... trying feature 359 XX0111 with gain 0.5903452 
    ## ... trying feature 360 001111 with gain 0.5901906 
    ## ... trying feature 361 101111 with gain 0.5902348 
    ## ... trying feature 362 X01111 with gain 0.5902348 
    ## ... trying feature 363 011111 with gain 0.5902321 
    ## ... trying feature 364 111111 with gain 0.5902147 
    ## ... trying feature 365 X11111 with gain 0.590225 
    ## ... trying feature 366 0X1111 with gain 0.5902321 
    ## ... trying feature 367 1X1111 with gain 0.5901978 
    ## ... trying feature 368 XX1111 with gain 0.590204 
    ## ... trying feature 369 00X111 with gain 0.5901911 
    ## ... trying feature 370 10X111 with gain 0.5902348 
    ## ... trying feature 371 X0X111 with gain 0.5902337 
    ## ... trying feature 372 01X111 with gain 0.5902501 
    ## ... trying feature 373 11X111 with gain 0.5902125 
    ## ... trying feature 374 X1X111 with gain 0.5902013 
    ## ... trying feature 375 0XX111 with gain 0.5902505 
    ## ... trying feature 376 1XX111 with gain 0.5902287 
    ## ... trying feature 377 XXX111 with gain 0.5902132 
    ## ... trying feature 378 000X11 with gain 0.5903565 
    ## ... trying feature 379 100X11 with gain 0.5903454 
    ## ... trying feature 380 X00X11 with gain 0.5901908 
    ## ... trying feature 381 010X11 with gain 0.5902026 
    ## ... trying feature 382 110X11 with gain 0.5913115 
    ## ... trying feature 383 X10X11 with gain 0.5909639 
    ## ... trying feature 384 0X0X11 with gain 0.5901909 
    ## ... trying feature 385 1X0X11 with gain 0.5914142 
    ## ... trying feature 386 XX0X11 with gain 0.5908998 
    ## ... trying feature 387 001X11 with gain 0.590449 
    ## ... trying feature 388 101X11 with gain 0.5902348 
    ## ... trying feature 389 X01X11 with gain 0.590237 
    ## ... trying feature 390 011X11 with gain 0.5906528 
    ## ... trying feature 391 111X11 with gain 0.5902561 
    ## ... trying feature 392 X11X11 with gain 0.5907061 
    ## ... trying feature 393 0X1X11 with gain 0.5904941 
    ## ... trying feature 394 1X1X11 with gain 0.5902817 
    ## ... trying feature 395 XX1X11 with gain 0.5905897 
    ## ... trying feature 396 00XX11 with gain 0.5906139 
    ## ... trying feature 397 10XX11 with gain 0.5903561 
    ## ... trying feature 398 X0XX11 with gain 0.5902172 
    ## ... trying feature 399 01XX11 with gain 0.5905628 
    ## ... trying feature 400 11XX11 with gain 0.5912548 
    ## ... trying feature 401 X1XX11 with gain 0.5914301 
    ## ... trying feature 402 0XXX11 with gain 0.5903912 
    ## ... trying feature 403 1XXX11 with gain 0.591393 
    ## ... trying feature 404 XXXX11 with gain 0.5912502 
    ## ... trying feature 405 0000X1 with gain 0.5902094 
    ## ... trying feature 406 1000X1 with gain 0.5909107 
    ## ... trying feature 407 X000X1 with gain 0.5905162 
    ## ... trying feature 408 0100X1 with gain 0.5905748 
    ## ... trying feature 409 1100X1 with gain 0.590751 
    ## ... trying feature 410 X100X1 with gain 0.5901961 
    ## ... trying feature 411 0X00X1 with gain 0.5905009 
    ## ... trying feature 412 1X00X1 with gain 0.5903585 
    ## ... trying feature 413 XX00X1 with gain 0.5902039 
    ## ... trying feature 414 0010X1 with gain 0.5908615 
    ## ... trying feature 415 1010X1 with gain 0.5902289 
    ## ... trying feature 416 X010X1 with gain 0.5908118 
    ## ... trying feature 417 0110X1 with gain 0.5905728 
    ## ... trying feature 418 1110X1 with gain 0.5907275 
    ## ... trying feature 419 X110X1 with gain 0.5904734 
    ## ... trying feature 420 0X10X1 with gain 0.5902958 
    ## ... trying feature 421 1X10X1 with gain 0.5903628 
    ## ... trying feature 422 XX10X1 with gain 0.5902189 
    ## ... trying feature 423 00X0X1 with gain 0.5907602 
    ## ... trying feature 424 10X0X1 with gain 0.5904549 
    ## ... trying feature 425 X0X0X1 with gain 0.5902385 
    ## ... trying feature 426 01X0X1 with gain 0.5921915 
    ## ... trying feature 427 11X0X1 with gain 0.5908922 
    ## ... trying feature 428 X1X0X1 with gain 0.5903561 
    ## ... trying feature 429 0XX0X1 with gain 0.5913786 
    ## ... trying feature 430 1XX0X1 with gain 0.5904917 
    ## ... trying feature 431 XXX0X1 with gain 0.5902844 
    ## ... trying feature 432 0001X1 with gain 0.5902179 
    ## ... trying feature 433 1001X1 with gain 0.5901977 
    ## ... trying feature 434 X001X1 with gain 0.5901955

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 435 0101X1 with gain 0.5906631 
    ## ... trying feature 436 1101X1 with gain 0.5902375 
    ## ... trying feature 437 X101X1 with gain 0.5902032

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 438 0X01X1 with gain 0.590698 
    ## ... trying feature 439 1X01X1 with gain 0.5902435 
    ## ... trying feature 440 XX01X1 with gain 0.5902076 
    ## ... trying feature 441 0011X1 with gain 0.5902235 
    ## ... trying feature 442 1011X1 with gain 0.5903713 
    ## ... trying feature 443 X011X1 with gain 0.5903853 
    ## ... trying feature 444 0111X1 with gain 0.590348 
    ## ... trying feature 445 1111X1 with gain 0.5903682 
    ## ... trying feature 446 X111X1 with gain 0.5904253 
    ## ... trying feature 447 0X11X1 with gain 0.5903199 
    ## ... trying feature 448 1X11X1 with gain 0.5902721 
    ## ... trying feature 449 XX11X1 with gain 0.5903079

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 450 00X1X1 with gain 0.5902513 
    ## ... trying feature 451 10X1X1 with gain 0.5902382 
    ## ... trying feature 452 X0X1X1 with gain 0.5902488 
    ## ... trying feature 453 01X1X1 with gain 0.5901926 
    ## ... trying feature 454 11X1X1 with gain 0.5904546 
    ## ... trying feature 455 X1X1X1 with gain 0.5904419 
    ## ... trying feature 456 0XX1X1 with gain 0.5902018 
    ## ... trying feature 457 1XX1X1 with gain 0.5903583 
    ## ... trying feature 458 XXX1X1 with gain 0.5903424 
    ## ... trying feature 459 000XX1 with gain 0.5902057 
    ## ... trying feature 460 100XX1 with gain 0.5905125 
    ## ... trying feature 461 X00XX1 with gain 0.5903819 
    ## ... trying feature 462 010XX1 with gain 0.5906605 
    ## ... trying feature 463 110XX1 with gain 0.5908391 
    ## ... trying feature 464 X10XX1 with gain 0.5902063 
    ## ... trying feature 465 0X0XX1 with gain 0.590582 
    ## ... trying feature 466 1X0XX1 with gain 0.5904568 
    ## ... trying feature 467 XX0XX1 with gain 0.5901922 
    ## ... trying feature 468 001XX1 with gain 0.5908319 
    ## ... trying feature 469 101XX1 with gain 0.5902024 
    ## ... trying feature 470 X01XX1 with gain 0.5904318 
    ## ... trying feature 471 011XX1 with gain 0.5904967 
    ## ... trying feature 472 111XX1 with gain 0.590457 
    ## ... trying feature 473 X11XX1 with gain 0.5901985 
    ## ... trying feature 474 0X1XX1 with gain 0.5902625 
    ## ... trying feature 475 1X1XX1 with gain 0.590379 
    ## ... trying feature 476 XX1XX1 with gain 0.5901997 
    ## ... trying feature 477 00XXX1 with gain 0.5907241 
    ## ... trying feature 478 10XXX1 with gain 0.5905207 
    ## ... trying feature 479 X0XXX1 with gain 0.5901919 
    ## ... trying feature 480 01XXX1 with gain 0.592154 
    ## ... trying feature 481 11XXX1 with gain 0.5916179 
    ## ... trying feature 482 X1XXX1 with gain 0.5901933 
    ## ... trying feature 483 0XXXX1 with gain 0.5913802 
    ## ... trying feature 484 1XXXX1 with gain 0.5909776 
    ## ... trying feature 485 XXXXX1 with gain 0.5901962 
    ## ... trying feature 486 00000X with gain 0.5902077 
    ## ... trying feature 487 10000X with gain 0.5907951 
    ## ... trying feature 488 X0000X with gain 0.5907599 
    ## ... trying feature 489 01000X with gain 0.5904112 
    ## ... trying feature 490 11000X with gain 0.5901906 
    ## ... trying feature 491 X1000X with gain 0.590318 
    ## ... trying feature 492 0X000X with gain 0.5904398 
    ## ... trying feature 493 1X000X with gain 0.5902827 
    ## ... trying feature 494 XX000X with gain 0.5905232 
    ## ... trying feature 495 00100X with gain 0.5903266 
    ## ... trying feature 496 10100X with gain 0.5903041 
    ## ... trying feature 497 X0100X with gain 0.5905193 
    ## ... trying feature 498 01100X with gain 0.5901964 
    ## ... trying feature 499 11100X with gain 0.5904506 
    ## ... trying feature 500 X1100X with gain 0.5903094 
    ## ... trying feature 501 0X100X with gain 0.5901939 
    ## ... trying feature 502 1X100X with gain 0.5902672 
    ## ... trying feature 503 XX100X with gain 0.5902041 
    ## ... trying feature 504 00X00X with gain 0.5902416 
    ## ... trying feature 505 10X00X with gain 0.5903183 
    ## ... trying feature 506 X0X00X with gain 0.5902127 
    ## ... trying feature 507 01X00X with gain 0.5909219 
    ## ... trying feature 508 11X00X with gain 0.5903222 
    ## ... trying feature 509 X1X00X with gain 0.5908819 
    ## ... trying feature 510 0XX00X with gain 0.5910077 
    ## ... trying feature 511 1XX00X with gain 0.5904567 
    ## ... trying feature 512 XXX00X with gain 0.5909401 
    ## ... trying feature 513 00010X with gain 0.5902353 
    ## ... trying feature 514 10010X with gain 0.5903021 
    ## ... trying feature 515 X0010X with gain 0.5902894

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 516 01010X with gain 0.5911164 
    ## ... trying feature 517 11010X with gain 0.5901916 
    ## ... trying feature 518 X1010X with gain 0.5902022

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 519 0X010X with gain 0.5911889 
    ## ... trying feature 520 1X010X with gain 0.5902197 
    ## ... trying feature 521 XX010X with gain 0.5901918 
    ## ... trying feature 522 00110X with gain 0.5902478 
    ## ... trying feature 523 10110X with gain 0.5902047 
    ## ... trying feature 524 X0110X with gain 0.5902108

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 525 01110X with gain 0.5914947 
    ## ... trying feature 526 11110X with gain 0.5902685 
    ## ... trying feature 527 X1110X with gain 0.5903694

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 528 0X110X with gain 0.591387 
    ## ... trying feature 529 1X110X with gain 0.5902418 
    ## ... trying feature 530 XX110X with gain 0.5903177

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 531 00X10X with gain 0.590294 
    ## ... trying feature 532 10X10X with gain 0.5902239 
    ## ... trying feature 533 X0X10X with gain 0.5902127

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 534 01X10X with gain 0.5904167 
    ## ... trying feature 535 11X10X with gain 0.590275 
    ## ... trying feature 536 X1X10X with gain 0.5902942 
    ## ... trying feature 537 0XX10X with gain 0.5903067 
    ## ... trying feature 538 1XX10X with gain 0.5903211 
    ## ... trying feature 539 XXX10X with gain 0.5903328 
    ## ... trying feature 540 000X0X with gain 0.5902133 
    ## ... trying feature 541 100X0X with gain 0.5903296 
    ## ... trying feature 542 X00X0X with gain 0.5903992 
    ## ... trying feature 543 010X0X with gain 0.5905168 
    ## ... trying feature 544 110X0X with gain 0.590191 
    ## ... trying feature 545 X10X0X with gain 0.5903492 
    ## ... trying feature 546 0X0X0X with gain 0.5905556 
    ## ... trying feature 547 1X0X0X with gain 0.5902111 
    ## ... trying feature 548 XX0X0X with gain 0.5904717 
    ## ... trying feature 549 001X0X with gain 0.5903102 
    ## ... trying feature 550 101X0X with gain 0.5902299 
    ## ... trying feature 551 X01X0X with gain 0.5903992 
    ## ... trying feature 552 011X0X with gain 0.5901936 
    ## ... trying feature 553 111X0X with gain 0.5901964 
    ## ... trying feature 554 X11X0X with gain 0.5901908 
    ## ... trying feature 555 0X1X0X with gain 0.5902229 
    ## ... trying feature 556 1X1X0X with gain 0.5901907 
    ## ... trying feature 557 XX1X0X with gain 0.590209 
    ## ... trying feature 558 00XX0X with gain 0.5902275 
    ## ... trying feature 559 10XX0X with gain 0.5902275 
    ## ... trying feature 561 01XX0X with gain 0.5908337 
    ## ... trying feature 562 11XX0X with gain 0.5901986 
    ## ... trying feature 563 X1XX0X with gain 0.5908281 
    ## ... trying feature 564 0XXX0X with gain 0.5909364 
    ## ... trying feature 565 1XXX0X with gain 0.590268 
    ## ... trying feature 566 XXXX0X with gain 0.5908281 
    ## ... trying feature 567 00001X with gain 0.5903642 
    ## ... trying feature 568 10001X with gain 0.5902915 
    ## ... trying feature 569 X0001X with gain 0.5901916 
    ## ... trying feature 570 01001X with gain 0.5902857 
    ## ... trying feature 571 11001X with gain 0.5906612 
    ## ... trying feature 572 X1001X with gain 0.5906734 
    ## ... trying feature 573 0X001X with gain 0.5902435 
    ## ... trying feature 574 1X001X with gain 0.5907317 
    ## ... trying feature 575 XX001X with gain 0.5906362 
    ## ... trying feature 576 00101X with gain 0.5902558 
    ## ... trying feature 577 10101X with gain 0.5911386 
    ## ... trying feature 578 X0101X with gain 0.5903106 
    ## ... trying feature 579 01101X with gain 0.5910774 
    ## ... trying feature 580 11101X with gain 0.5902995 
    ## ... trying feature 581 X1101X with gain 0.5911086 
    ## ... trying feature 582 0X101X with gain 0.5911445 
    ## ... trying feature 583 1X101X with gain 0.5901926 
    ## ... trying feature 584 XX101X with gain 0.5907577 
    ## ... trying feature 585 00X01X with gain 0.5901999 
    ## ... trying feature 586 10X01X with gain 0.5905203 
    ## ... trying feature 587 X0X01X with gain 0.5902915 
    ## ... trying feature 588 01X01X with gain 0.5910367 
    ## ... trying feature 589 11X01X with gain 0.5907241 
    ## ... trying feature 590 X1X01X with gain 0.5915011 
    ## ... trying feature 591 0XX01X with gain 0.5910077 
    ## ... trying feature 592 1XX01X with gain 0.5904222 
    ## ... trying feature 593 XXX01X with gain 0.5911626 
    ## ... trying feature 594 00011X with gain 0.5901912 
    ## ... trying feature 595 10011X with gain 0.5902096 
    ## ... trying feature 596 X0011X with gain 0.5902102 
    ## ... trying feature 597 01011X with gain 0.5902356 
    ## ... trying feature 598 11011X with gain 0.5905889 
    ## ... trying feature 599 X1011X with gain 0.5905095 
    ## ... trying feature 600 0X011X with gain 0.5902362 
    ## ... trying feature 601 1X011X with gain 0.5905519 
    ## ... trying feature 602 XX011X with gain 0.5904812 
    ## ... trying feature 603 00111X with gain 0.590196 
    ## ... trying feature 604 10111X with gain 0.5902348 
    ## ... trying feature 605 X0111X with gain 0.5902237 
    ## ... trying feature 606 01111X with gain 0.5902539 
    ## ... trying feature 607 11111X with gain 0.5906336 
    ## ... trying feature 608 X1111X with gain 0.5906675 
    ## ... trying feature 609 0X111X with gain 0.5902595 
    ## ... trying feature 610 1X111X with gain 0.5905577 
    ## ... trying feature 611 XX111X with gain 0.5905917 
    ## ... trying feature 612 00X11X with gain 0.5901966 
    ## ... trying feature 613 10X11X with gain 0.5902079 
    ## ... trying feature 614 X0X11X with gain 0.5902035 
    ## ... trying feature 615 01X11X with gain 0.5903004 
    ## ... trying feature 616 11X11X with gain 0.5902398 
    ## ... trying feature 617 X1X11X with gain 0.5902624 
    ## ... trying feature 618 0XX11X with gain 0.5903067 
    ## ... trying feature 619 1XX11X with gain 0.5902267 
    ## ... trying feature 620 XXX11X with gain 0.5902472 
    ## ... trying feature 621 000X1X with gain 0.5903648 
    ## ... trying feature 622 100X1X with gain 0.5902444 
    ## ... trying feature 623 X00X1X with gain 0.5901939 
    ## ... trying feature 624 010X1X with gain 0.5902722 
    ## ... trying feature 625 110X1X with gain 0.5909833 
    ## ... trying feature 626 X10X1X with gain 0.5909077 
    ## ... trying feature 627 0X0X1X with gain 0.590234 
    ## ... trying feature 628 1X0X1X with gain 0.5910379 
    ## ... trying feature 629 XX0X1X with gain 0.5908498 
    ## ... trying feature 630 001X1X with gain 0.5902527 
    ## ... trying feature 631 101X1X with gain 0.5906301 
    ## ... trying feature 632 X01X1X with gain 0.5902664 
    ## ... trying feature 633 011X1X with gain 0.5910134 
    ## ... trying feature 634 111X1X with gain 0.5902335 
    ## ... trying feature 635 X11X1X with gain 0.5904334 
    ## ... trying feature 636 0X1X1X with gain 0.5910785 
    ## ... trying feature 637 1X1X1X with gain 0.5903758 
    ## ... trying feature 638 XX1X1X with gain 0.5903205 
    ## ... trying feature 639 00XX1X with gain 0.5901989 
    ## ... trying feature 640 10XX1X with gain 0.5904099 
    ## ... trying feature 641 X0XX1X with gain 0.5902632 
    ## ... trying feature 642 01XX1X with gain 0.590963 
    ## ... trying feature 643 11XX1X with gain 0.5903924 
    ## ... trying feature 644 X1XX1X with gain 0.5910416 
    ## ... trying feature 645 0XXX1X with gain 0.5909364 
    ## ... trying feature 646 1XXX1X with gain 0.590268 
    ## ... trying feature 647 XXXX1X with gain 0.5908281 
    ## ... trying feature 648 0000XX with gain 0.5902312 
    ## ... trying feature 649 1000XX with gain 0.5906986 
    ## ... trying feature 650 X000XX with gain 0.5907475 
    ## ... trying feature 651 0100XX with gain 0.5903264 
    ## ... trying feature 652 1100XX with gain 0.5902309 
    ## ... trying feature 653 X100XX with gain 0.5902089 
    ## ... trying feature 654 0X00XX with gain 0.5903692 
    ## ... trying feature 655 1X00XX with gain 0.5901973 
    ## ... trying feature 656 XX00XX with gain 0.5903248 
    ## ... trying feature 657 0010XX with gain 0.5903839 
    ## ... trying feature 658 1010XX with gain 0.590194 
    ## ... trying feature 659 X010XX with gain 0.5903495 
    ## ... trying feature 660 0110XX with gain 0.5902521 
    ## ... trying feature 661 1110XX with gain 0.5903181 
    ## ... trying feature 662 X110XX with gain 0.5901908 
    ## ... trying feature 663 0X10XX with gain 0.5903692 
    ## ... trying feature 664 1X10XX with gain 0.590271 
    ## ... trying feature 665 XX10XX with gain 0.5902202 
    ## ... trying feature 666 00X0XX with gain 0.5902525 
    ## ... trying feature 667 10X0XX with gain 0.5904599 
    ## ... trying feature 668 X0X0XX with gain 0.5902688 
    ## ... trying feature 669 01X0XX with gain 0.5902525 
    ## ... trying feature 670 11X0XX with gain 0.5901936 
    ## ... trying feature 671 X1X0XX with gain 0.5902208 
    ## ... trying feature 673 1XX0XX with gain 0.5902844 
    ## ... trying feature 674 XXX0XX with gain 0.5902844 
    ## ... trying feature 675 0001XX with gain 0.5902359 
    ## ... trying feature 676 1001XX with gain 0.5902964 
    ## ... trying feature 677 X001XX with gain 0.590284

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 678 0101XX with gain 0.5911892 
    ## ... trying feature 679 1101XX with gain 0.5902176 
    ## ... trying feature 680 X101XX with gain 0.5901909

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 681 0X01XX with gain 0.5912656 
    ## ... trying feature 682 1X01XX with gain 0.5902731 
    ## ... trying feature 683 XX01XX with gain 0.5902113 
    ## ... trying feature 684 0011XX with gain 0.5902534 
    ## ... trying feature 685 1011XX with gain 0.5901976 
    ## ... trying feature 686 X011XX with gain 0.5902026

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 687 0111XX with gain 0.5913764 
    ## ... trying feature 688 1111XX with gain 0.5901994 
    ## ... trying feature 689 X111XX with gain 0.5902433

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 690 0X11XX with gain 0.5912656 
    ## ... trying feature 691 1X11XX with gain 0.5901943 
    ## ... trying feature 692 XX11XX with gain 0.5902238

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 693 00X1XX with gain 0.5903003 
    ## ... trying feature 694 10X1XX with gain 0.5902304 
    ## ... trying feature 695 X0X1XX with gain 0.5902174

    ## Warning: fit_glm: fitted probabilities numerically 0 or 1 occurred

    ## ... trying feature 696 01X1XX with gain 0.5903003 
    ## ... trying feature 697 11X1XX with gain 0.5902406 
    ## ... trying feature 698 X1X1XX with gain 0.590248 
    ## ... trying feature 699 0XX1XX with gain 0.5901906 
    ## ... trying feature 700 1XX1XX with gain 0.5902844 
    ## ... trying feature 701 XXX1XX with gain 0.5902844 
    ## ... trying feature 702 000XXX with gain 0.5902394 
    ## ... trying feature 703 100XXX with gain 0.5903011 
    ## ... trying feature 704 X00XXX with gain 0.5904045 
    ## ... trying feature 705 010XXX with gain 0.5904172 
    ## ... trying feature 706 110XXX with gain 0.590283 
    ## ... trying feature 707 X10XXX with gain 0.5902048 
    ## ... trying feature 708 0X0XXX with gain 0.5904754 
    ## ... trying feature 709 1X0XXX with gain 0.5902121 
    ## ... trying feature 710 XX0XXX with gain 0.5902623 
    ## ... trying feature 711 001XXX with gain 0.5903636 
    ## ... trying feature 712 101XXX with gain 0.5901907 
    ## ... trying feature 713 X01XXX with gain 0.5902885 
    ## ... trying feature 714 011XXX with gain 0.5903262 
    ## ... trying feature 715 111XXX with gain 0.5902134 
    ## ... trying feature 716 X11XXX with gain 0.5902173 
    ## ... trying feature 717 0X1XXX with gain 0.5904754 
    ## ... trying feature 718 1X1XXX with gain 0.5902121 
    ## ... trying feature 719 XX1XXX with gain 0.5902623 
    ## ... trying feature 720 00XXXX with gain 0.5902367 
    ## ... trying feature 721 10XXXX with gain 0.5903091 
    ## ... trying feature 722 X0XXXX with gain 0.5902632 
    ## ... trying feature 723 01XXXX with gain 0.5902367 
    ## ... trying feature 724 11XXXX with gain 0.5903091 
    ## ... trying feature 725 X1XXXX with gain 0.5902632 
    ## ... trying feature 727 1XXXXX with gain 0.5901906 
    ## ... Using feature 265 01X001 
    ## [1] "Creating null model..."
    ## [1] "Training..."
    ## Adding Feature Number 1 
    ## ... trying feature 1 0XXXXX0 with gain 0.142575 
    ## ... trying feature 2 0XXXXX1 with gain 0.1138134 
    ## ... trying feature 3 0XXXXXX with gain 0.4855356 
    ## ... trying feature 4 0XX0XX0 with gain 0.03637713 
    ## ... trying feature 5 0XX0XX1 with gain 0.02572509 
    ## ... trying feature 6 0XX0XXX with gain 0.07831176 
    ## ... trying feature 7 X0XX0X0 with gain 0.003411393 
    ## ... trying feature 8 X0XX0X1 with gain 0.002501276 
    ## ... trying feature 9 X0XX0XX with gain 0.006240518 
    ## ... trying feature 10 XXX0X00 with gain 7.642974e-05 
    ## ... trying feature 11 XXX0X01 with gain 0.00124638 
    ## ... trying feature 12 XXX0X0X with gain 0.0003901171 
    ## ... trying feature 13 1110010 with gain 0.01616194 
    ## ... trying feature 14 1110011 with gain 0.009435003 
    ## ... trying feature 15 111001X with gain 0.02639612 
    ## ... trying feature 16 01X0010 with gain 0.0135866 
    ## ... trying feature 17 01X0011 with gain 0.00578677 
    ## ... trying feature 18 01X001X with gain 0.02009627 
    ## ... trying feature 19 XXXXXX0 with gain 0.0001334487 
    ## ... trying feature 20 XXXXXX1 with gain 0.0001334487 
    ## ... Using feature 3 0XXXXXX 
    ## Adding Feature Number 2 
    ## ... trying feature 1 0XXXXX0 with gain 0.485667 
    ## ... trying feature 2 0XXXXX1 with gain 0.485667 
    ## ... trying feature 4 0XX0XX0 with gain 0.4971325 
    ## ... trying feature 5 0XX0XX1 with gain 0.5026815 
    ## ... trying feature 6 0XX0XXX with gain 0.5595961 
    ## ... trying feature 7 X0XX0X0 with gain 0.4925763 
    ## ... trying feature 8 X0XX0X1 with gain 0.494297 
    ## ... trying feature 9 X0XX0XX with gain 0.5020505 
    ## ... trying feature 10 XXX0X00 with gain 0.48554 
    ## ... trying feature 11 XXX0X01 with gain 0.4860722 
    ## ... trying feature 12 XXX0X0X with gain 0.4857959 
    ## ... trying feature 13 1110010 with gain 0.4856273 
    ## ... trying feature 14 1110011 with gain 0.4875973 
    ## ... trying feature 15 111001X with gain 0.4871463 
    ## ... trying feature 16 01X0010 with gain 0.4925804 
    ## ... trying feature 17 01X0011 with gain 0.4987177 
    ## ... trying feature 18 01X001X with gain 0.5101298 
    ## ... trying feature 19 XXXXXX0 with gain 0.485553 
    ## ... trying feature 20 XXXXXX1 with gain 0.485553 
    ## ... Using feature 6 0XX0XXX 
    ## Adding Feature Number 3 
    ## ... trying feature 1 0XXXXX0 with gain 0.5598194 
    ## ... trying feature 2 0XXXXX1 with gain 0.5598194 
    ## ... trying feature 4 0XX0XX0 with gain 0.559823 
    ## ... trying feature 5 0XX0XX1 with gain 0.559823 
    ## ... trying feature 7 X0XX0X0 with gain 0.5655371 
    ## ... trying feature 8 X0XX0X1 with gain 0.5698722 
    ## ... trying feature 9 X0XX0XX with gain 0.5768694 
    ## ... trying feature 10 XXX0X00 with gain 0.5609512 
    ## ... trying feature 11 XXX0X01 with gain 0.564849 
    ## ... trying feature 12 XXX0X0X with gain 0.5672519 
    ## ... trying feature 13 1110010 with gain 0.5596518 
    ## ... trying feature 14 1110011 with gain 0.5615231 
    ## ... trying feature 15 111001X with gain 0.5610062 
    ## ... trying feature 16 01X0010 with gain 0.5597136 
    ## ... trying feature 17 01X0011 with gain 0.5617618 
    ## ... trying feature 18 01X001X with gain 0.5618977 
    ## ... trying feature 19 XXXXXX0 with gain 0.5596702 
    ## ... trying feature 20 XXXXXX1 with gain 0.5596702 
    ## ... Using feature 9 X0XX0XX 
    ## Adding Feature Number 4 
    ## ... trying feature 1 0XXXXX0 with gain 0.5771348 
    ## ... trying feature 2 0XXXXX1 with gain 0.5771348 
    ## ... trying feature 4 0XX0XX0 with gain 0.5771421 
    ## ... trying feature 5 0XX0XX1 with gain 0.5771421 
    ## ... trying feature 7 X0XX0X0 with gain 0.5770058 
    ## ... trying feature 8 X0XX0X1 with gain 0.5770058 
    ## ... trying feature 10 XXX0X00 with gain 0.5783831 
    ## ... trying feature 11 XXX0X01 with gain 0.5818345 
    ## ... trying feature 12 XXX0X0X with gain 0.5845544 
    ## ... trying feature 13 1110010 with gain 0.5773357 
    ## ... trying feature 14 1110011 with gain 0.5797827 
    ## ... trying feature 15 111001X with gain 0.5799768 
    ## ... trying feature 16 01X0010 with gain 0.576886 
    ## ... trying feature 17 01X0011 with gain 0.5778258 
    ## ... trying feature 18 01X001X with gain 0.5773868 
    ## ... trying feature 19 XXXXXX0 with gain 0.5768998 
    ## ... trying feature 20 XXXXXX1 with gain 0.5768998 
    ## ... Using feature 12 XXX0X0X 
    ## Adding Feature Number 5 
    ## ... trying feature 1 0XXXXX0 with gain 0.5848299 
    ## ... trying feature 2 0XXXXX1 with gain 0.5848299 
    ## ... trying feature 4 0XX0XX0 with gain 0.5848404 
    ## ... trying feature 5 0XX0XX1 with gain 0.5848404 
    ## ... trying feature 7 X0XX0X0 with gain 0.5847156 
    ## ... trying feature 8 X0XX0X1 with gain 0.5847156 
    ## ... trying feature 10 XXX0X00 with gain 0.5849702 
    ## ... trying feature 11 XXX0X01 with gain 0.5849702 
    ## ... trying feature 13 1110010 with gain 0.5858778 
    ## ... trying feature 14 1110011 with gain 0.5885867 
    ## ... trying feature 15 111001X with gain 0.5901906 
    ## ... trying feature 16 01X0010 with gain 0.5857845 
    ## ... trying feature 17 01X0011 with gain 0.584555 
    ## ... trying feature 18 01X001X with gain 0.5860036 
    ## ... trying feature 19 XXXXXX0 with gain 0.5845716 
    ## ... trying feature 20 XXXXXX1 with gain 0.5845716 
    ## ... Using feature 15 111001X 
    ## Adding Feature Number 6 
    ## ... trying feature 1 0XXXXX0 with gain 0.5903851 
    ## ... trying feature 2 0XXXXX1 with gain 0.5903851 
    ## ... trying feature 4 0XX0XX0 with gain 0.5903912 
    ## ... trying feature 5 0XX0XX1 with gain 0.5903912 
    ## ... trying feature 7 X0XX0X0 with gain 0.5903306 
    ## ... trying feature 8 X0XX0X1 with gain 0.5903306 
    ## ... trying feature 10 XXX0X00 with gain 0.5906976 
    ## ... trying feature 11 XXX0X01 with gain 0.5906976 
    ## ... trying feature 13 1110010 with gain 0.5905796 
    ## ... trying feature 14 1110011 with gain 0.5905796 
    ## ... trying feature 16 01X0010 with gain 0.5918057 
    ## ... trying feature 17 01X0011 with gain 0.5902545 
    ## ... trying feature 18 01X001X with gain 0.5928585 
    ## ... trying feature 19 XXXXXX0 with gain 0.5902398 
    ## ... trying feature 20 XXXXXX1 with gain 0.5902398 
    ## ... Using feature 18 01X001X 
    ## [1] "Training..."
    ## Adding Feature Number 1 
    ## ... trying feature 1 0XXX0XXX with BIC 1329.839 
    ## ... trying feature 2 0XXX1XXX with BIC 2201.934 
    ## ... trying feature 3 0XXXXXXX with BIC 1220.655 
    ## ... trying feature 4 00XX0XXX with BIC 2071.947 
    ## ... trying feature 5 00XX1XXX with BIC 2213.914 
    ## ... trying feature 6 00XXXXXX with BIC 2061.309 
    ## ... trying feature 7 XXX000XX with BIC 2211.578 
    ## ... trying feature 8 XXX010XX with BIC 2220.945 
    ## ... trying feature 9 XXX0X0XX with BIC 2210.09 
    ## ... trying feature 10 X00X0XXX with BIC 2222.153 
    ## ... trying feature 11 X00X1XXX with BIC 2222.973 
    ## ... trying feature 12 X00XXXXX with BIC 2222.167 
    ## ... trying feature 13 101100X1 with BIC 2166.652 
    ## ... trying feature 14 101110X1 with BIC 2222.896 
    ## ... trying feature 15 1011X0X1 with BIC 2168.482 
    ## ... trying feature 16 001100XX with BIC 2183.886 
    ## ... trying feature 17 001110XX with BIC 2220.459 
    ## ... trying feature 18 0011X0XX with BIC 2181.487 
    ## ... trying feature 19 XXXX0XXX with BIC 2220.88 
    ## ... trying feature 20 XXXX1XXX with BIC 2220.88 
    ## ... Using feature 3 0XXXXXXX 
    ## Adding Feature Number 2 
    ## ... trying feature 1 0XXX0XXX with BIC 1224.253 
    ## ... trying feature 2 0XXX1XXX with BIC 1224.253 
    ## ... trying feature 4 00XX0XXX with BIC 1075.631 
    ## ... trying feature 5 00XX1XXX with BIC 1227.655 
    ## ... trying feature 6 00XXXXXX with BIC 1075.592 
    ## ... trying feature 7 XXX000XX with BIC 1195.91 
    ## ... trying feature 8 XXX010XX with BIC 1227.248 
    ## ... trying feature 9 XXX0X0XX with BIC 1194.386 
    ## ... trying feature 10 X00X0XXX with BIC 1228.064 
    ## ... trying feature 11 X00X1XXX with BIC 1228.271 
    ## ... trying feature 12 X00XXXXX with BIC 1227.942 
    ## ... trying feature 13 101100X1 with BIC 1225.277 
    ## ... trying feature 14 101110X1 with BIC 1228.394 
    ## ... trying feature 15 1011X0X1 with BIC 1225.154 
    ## ... trying feature 16 001100XX with BIC 1178.187 
    ## ... trying feature 17 001110XX with BIC 1228.33 
    ## ... trying feature 18 0011X0XX with BIC 1177.708 
    ## ... trying feature 19 XXXX0XXX with BIC 1226.972 
    ## ... trying feature 20 XXXX1XXX with BIC 1226.972 
    ## ... Using feature 6 00XXXXXX 
    ## Adding Feature Number 3 
    ## ... trying feature 1 0XXX0XXX with BIC 1080.193 
    ## ... trying feature 2 0XXX1XXX with BIC 1080.193 
    ## ... trying feature 4 00XX0XXX with BIC 1080.303 
    ## ... trying feature 5 00XX1XXX with BIC 1080.303 
    ## ... trying feature 7 XXX000XX with BIC 1048.936 
    ## ... trying feature 8 XXX010XX with BIC 1082.539 
    ## ... trying feature 9 XXX0X0XX with BIC 1047.757 
    ## ... trying feature 10 X00X0XXX with BIC 1067.926 
    ## ... trying feature 11 X00X1XXX with BIC 1083.192 
    ## ... trying feature 12 X00XXXXX with BIC 1067.611 
    ## ... trying feature 13 101100X1 with BIC 1079.975 
    ## ... trying feature 14 101110X1 with BIC 1081.967 
    ## ... trying feature 15 1011X0X1 with BIC 1080.505 
    ## ... trying feature 16 001100XX with BIC 1078.518 
    ## ... trying feature 17 001110XX with BIC 1083.379 
    ## ... trying feature 18 0011X0XX with BIC 1078.664 
    ## ... trying feature 19 XXXX0XXX with BIC 1083.355 
    ## ... trying feature 20 XXXX1XXX with BIC 1083.355 
    ## ... Using feature 9 XXX0X0XX 
    ## Adding Feature Number 4 
    ## ... trying feature 1 0XXX0XXX with BIC 1052.221 
    ## ... trying feature 2 0XXX1XXX with BIC 1052.221 
    ## ... trying feature 4 00XX0XXX with BIC 1052.31 
    ## ... trying feature 5 00XX1XXX with BIC 1052.31 
    ## ... trying feature 7 XXX000XX with BIC 1055.488 
    ## ... trying feature 8 XXX010XX with BIC 1055.488 
    ## ... trying feature 10 X00X0XXX with BIC 1040.36 
    ## ... trying feature 11 X00X1XXX with BIC 1055.075 
    ## ... trying feature 12 X00XXXXX with BIC 1039.717 
    ## ... trying feature 13 101100X1 with BIC 1048.402 
    ## ... trying feature 14 101110X1 with BIC 1054.353 
    ## ... trying feature 15 1011X0X1 with BIC 1049.167 
    ## ... trying feature 16 001100XX with BIC 1054.38 
    ## ... trying feature 17 001110XX with BIC 1055.46 
    ## ... trying feature 18 0011X0XX with BIC 1054.513 
    ## ... trying feature 19 XXXX0XXX with BIC 1055.433 
    ## ... trying feature 20 XXXX1XXX with BIC 1055.433 
    ## ... Using feature 12 X00XXXXX 
    ## Adding Feature Number 5 
    ## ... trying feature 1 0XXX0XXX with BIC 1044.463 
    ## ... trying feature 2 0XXX1XXX with BIC 1044.463 
    ## ... trying feature 4 00XX0XXX with BIC 1044.561 
    ## ... trying feature 5 00XX1XXX with BIC 1044.561 
    ## ... trying feature 7 XXX000XX with BIC 1047.301 
    ## ... trying feature 8 XXX010XX with BIC 1047.301 
    ## ... trying feature 10 X00X0XXX with BIC 1047.541 
    ## ... trying feature 11 X00X1XXX with BIC 1047.541 
    ## ... trying feature 13 101100X1 with BIC 1034.983 
    ## ... trying feature 14 101110X1 with BIC 1046.636 
    ## ... trying feature 15 1011X0X1 with BIC 1035.906 
    ## ... trying feature 16 001100XX with BIC 1045.087 
    ## ... trying feature 17 001110XX with BIC 1047.205 
    ## ... trying feature 18 0011X0XX with BIC 1044.549 
    ## ... trying feature 19 XXXX0XXX with BIC 1047.496 
    ## ... trying feature 20 XXXX1XXX with BIC 1047.496 
    ## ... Using feature 13 101100X1 
    ## Adding Feature Number 6 
    ## ... trying feature 1 0XXX0XXX with BIC 1039.806 
    ## ... trying feature 2 0XXX1XXX with BIC 1039.806 
    ## ... trying feature 4 00XX0XXX with BIC 1039.899 
    ## ... trying feature 5 00XX1XXX with BIC 1039.899 
    ## ... trying feature 7 XXX000XX with BIC 1042.482 
    ## ... trying feature 8 XXX010XX with BIC 1042.482 
    ## ... trying feature 10 X00X0XXX with BIC 1042.807 
    ## ... trying feature 11 X00X1XXX with BIC 1042.807 
    ## ... trying feature 14 101110X1 with BIC 1042.133 
    ## ... trying feature 15 1011X0X1 with BIC 1042.133 
    ## ... trying feature 16 001100XX with BIC 1037.978 
    ## ... trying feature 17 001110XX with BIC 1042.463 
    ## ... trying feature 18 0011X0XX with BIC 1037.154 
    ## ... trying feature 19 XXXX0XXX with BIC 1042.731 
    ## ... trying feature 20 XXXX1XXX with BIC 1042.731 
    ## ... Using feature 18 0011X0XX 
    ## BIC selects 5 features but we also keep models with 6 and 4 features 
    ## Step 1 selects 3 candidate models 
    ## Candidate model 1 has feature 0XXXXXXX 00XXXXXX XXX0X0XX X00XXXXX 101100X1 
    ## Relative gain =  0.5204494 
    ## Relative gain =  0.5058991 
    ## Relative gain =  0.5379564 
    ## Relative gain =  0.5090641 
    ## Relative gain =  0.5871919 
    ## Relative gain =  0.5672963 
    ## Relative gain =  0.5803788 
    ## Relative gain =  0.5574816 
    ## Relative gain =  0.5824836 
    ## Relative gain =  0.5784052 
    ## Average gain for candidate model 1 is 0.5526606 
    ## Candidate model 2 has feature 0XXXXXXX 00XXXXXX XXX0X0XX X00XXXXX 101100X1 0011X0XX 
    ## Relative gain =  0.52058 
    ## Relative gain =  0.5077993 
    ## Relative gain =  0.5343201 
    ## Relative gain =  0.5148093 
    ## Relative gain =  0.584687 
    ## Relative gain =  0.5742424 
    ## Relative gain =  0.5885011 
    ## Relative gain =  0.5568641 
    ## Relative gain =  0.5764631 
    ## Relative gain =  0.5860549 
    ## Average gain for candidate model 2 is 0.5544321 
    ## Candidate model 3 has feature 0XXXXXXX 00XXXXXX XXX0X0XX X00XXXXX 
    ## Relative gain =  0.5140591 
    ## Relative gain =  0.5058314 
    ## Relative gain =  0.5317438 
    ## Relative gain =  0.5160962 
    ## Relative gain =  0.5837948 
    ## Relative gain =  0.5637688 
    ## Relative gain =  0.5848863 
    ## Relative gain =  0.5554142 
    ## Relative gain =  0.5780786 
    ## Relative gain =  0.5737943 
    ## Average gain for candidate model 3 is 0.5507467

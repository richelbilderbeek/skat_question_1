# skat_question_1

Branch   |[![GitHub Actions logo](GitHubActions.png)](https://github.com/richelbilderbeek/skat_question_1/actions)
---------|-------------------------------------------------------------------------------------------------------------------
`master` |![R-CMD-check](https://github.com/richelbilderbeek/skat_question_1/workflows/R-CMD-check/badge.svg?branch=master) 
`develop`|![R-CMD-check](https://github.com/richelbilderbeek/skat_question_1/workflows/R-CMD-check/badge.svg?branch=develop)

Question about the SKAT R package.

In this code, I simulate the phenotype, directly based on the 
genotype (i.e. no covariates), in three ways:

 * Linear: Phenotype is the sum of minor SNPs
 * Squared: Phenotype is the square of sum of minor SNPs
 * Cubed: Phenotype is the cube of sum of minor SNPs

From that, I let SKAT estimate if 
Why does SKAT estimates non-linear data (i.e. a non-linear relationship 
between genotype and phenotype) to be more linear than data with a 
perfectly linear relationship between genotype and phenotype?

![](p_values.png)

 * Code: [script.R](script.R)
 * Video: [YouTube](https://youtu.be/6Tmd6Y0RN-w) [download (.ogv)](http://richelbilderbeek.nl/skat_question_1.ogv)



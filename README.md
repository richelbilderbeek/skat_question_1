# skat_question_1

Branch   |[![GitHub Actions logo](GitHubActions.png)](https://github.com/richelbilderbeek/skat_question_1/actions)
---------|-------------------------------------------------------------------------------------------------------------------
`master` |![R-CMD-check](https://github.com/richelbilderbeek/skat_question_1/workflows/R-CMD-check/badge.svg?branch=master) 
`develop`|![R-CMD-check](https://github.com/richelbilderbeek/skat_question_1/workflows/R-CMD-check/badge.svg?branch=develop)

Question about the SKAT R package.

 * Code: [script.R](script.R)
 * Video: [YouTube](https://youtu.be/6Tmd6Y0RN-w) [download (.ogv)](http://richelbilderbeek.nl/skat_question_1.ogv)

In this code, I simulate the phenotype, directly based on the 
genotype (i.e. no covariates), in three ways:

 * `linear`: Phenotype is the sum of minor SNPs
 * `quadratic`: Phenotype is the square of sum of minor SNPs
 * `cubed`: Phenotype is the cube of sum of minor SNPs

Why can SKAT fit a linear null model to the `quadratic` best?

![](p_values.png)


## Answer

From [Zhangchen](https://groups.google.com/g/skat_slee/c/pmmYIwtAYtA/m/aDxn72HlBAAJ?pli=1):

> The true effect sizes between the linear model and quadratic model are 
> different. By your assumption, the effect size of all causal SNPs in the 
> quadratic model is larger than the linear model. At the same time, 
> we still can use linear models to describe the quadratic associations. 
> (The performance may not be as good as quadratic models). Because 
> of these two reasons, the estimated effect size in quadratic models 
> may be larger than linear models, thereby the p-values are more significant.


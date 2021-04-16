# Goal: get to understand SKAT
#
# 1. Do a SKAT analysis from the SKAT example
# 2. Simulate data (so results can predicted) + do a SKAT analysis
#
###############################################################################
# 1. Do the SKAT analysis as in the doc,
#    to prove I can get it to work
###############################################################################
# Adapted from doc
library(SKAT)

# Use Tidyverse-proof variable names
data(SKAT.example)
d <- SKAT.example
rm(SKAT.example)

# Can use tibbles with named columns, so my mom can understand the data better
t_covariates <- tibble::as_tibble(d$X)
names(t_covariates) <- c("is_rocket", "speed")
d$X <- t_covariates

# Linear null model based on continuous traits
linear_null_model_continuous <- SKAT_Null_Model(
  data = d,
  formula = y.c ~ 1,
  out_type = "C" # continuous
)
# p-value: 0.01874576
SKAT(Z = d$Z, linear_null_model_continuous)$p.value

linear_null_model_dichotomous <- SKAT_Null_Model(
  data = d,
  formula = y.b ~ 1,
  out_type = "D" # dichotomous
)
# p-value: 0.1145585
SKAT(Z = d$Z, linear_null_model_dichotomous)$p.value

###############################################################################
# 2. Simulate data
###############################################################################

###############################################################################
# 2.1. Continuous phenotype is the sum of the genotype
###############################################################################

# Simulate the data
sim_data <- d

# No covariates
sim_data$X[, 1] <- 0.0
sim_data$X[, 2] <- 0.0

# No dichotomous phenotype
sim_data$y.b <- 0

# Continuous phenotype is the sum of your SNPs,
# i.e. a very linear relationship :-)
sim_data$y.c <- rowSums(sim_data$Z)

# Linear null model based on continuous traits
linear_null_model_continuous <- SKAT_Null_Model(
  data = sim_data,
  formula = y.c ~ 1,
  out_type = "C" # continuous
)
# p-value: 1.334689e-67
linear_p_value <- SKAT(Z = d$Z, linear_null_model_continuous)$p.value

###############################################################################
# 2.2. Continuous phenotype is the sum of the genotype squared,
#      i.e. not linear
###############################################################################
sim_data <- d

# No covariates
sim_data$X[, 1] <- 0.0
sim_data$X[, 2] <- 0.0

# No dichotomous phenotype
sim_data$y.b <- 0

# Continuous phenotype is the sum of your SNPs squared
# i.e. a non linear relationship
sim_data$y.c <- rowSums(sim_data$Z) ^ 2

# Linear null model based on continuous traits
linear_null_model_continuous <- SKAT_Null_Model(
  data = sim_data,
  formula = y.c ~ 1,
  out_type = "C" # continuous
)
# p-value: 1.066488e-68
# WEIRD! I expect it is harder to reject the null hypothesis (data is linear)
# on non-linear data.
quadratic_p_value <- SKAT(Z = d$Z, linear_null_model_continuous)$p.value

###############################################################################
# 2.3. Continuous phenotype is the sum of the genotype squared,
#      i.e. not linear
###############################################################################
sim_data <- d

# No covariates
sim_data$X[, 1] <- 0.0
sim_data$X[, 2] <- 0.0

# No dichotomous phenotype
sim_data$y.b <- 0

# Continuous phenotype is the sum of your SNPs squared
# i.e. a non linear relationship
sim_data$y.c <- rowSums(sim_data$Z) ^ 3

# Linear null model based on continuous traits
linear_null_model_continuous <- SKAT_Null_Model(
  data = sim_data,
  formula = y.c ~ 1,
  out_type = "C" # continuous
)
# p-value: 3.153643e-62
# OK! It is harder to reject the null hypothesis (data is linear)
# on even more non-linear data.
cubic_p_value <- SKAT(Z = d$Z, linear_null_model_continuous)$p.value

t <- tibble::tribble(
  ~model,  ~p_value,
  "linear", linear_p_value,
  "quadratic", quadratic_p_value,
  "cubic",  cubic_p_value
)
t$model <- factor(
  c(t$model),
  levels = c("linear", "quadratic", "cubic")
)

ggplot2::ggplot(t, ggplot2::aes(model, p_value)) +
  ggplot2::geom_col() +
  ggplot2::scale_y_log10() + ggplot2::ggsave("p_values.png")

testthat::expect_true(quadratic_p_value < cubic_p_value)

# testthat::expect_true(linear_p_value < quadratic_p_value) # This will fail

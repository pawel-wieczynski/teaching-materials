set.seed(2137)
nobs = 1000
mu = c(5, 10)
S = matrix(c(1, 0.5, 0.5, 1), nrow = 2)

# 1st method - using MASS package
x1 = MASS::mvrnorm(nobs, mu, S)

# 2nd method
# Step 1: generate independent normal random variables
Z = matrix(rnorm(nobs * 2), nrow = nobs, ncol = 2)

# Step 2: Cholesky decomposition of covariance matrix
A = chol(S)

# Step 3: scale/shift z
x2 = Z %*% A + matrix(mu, nrow = nobs, ncol = 2, byrow = TRUE)

# Plot
library(ggplot2)

df = data.frame(
  Sample = rep(c('x1', 'x2'), each = nobs)
  , x = c(x1[, 1], x2[, 1])
  , y = c(x1[, 2], x2[, 2])
)

ggplot(df, aes(x = x, y = y, color = Sample)) +
  geom_point()

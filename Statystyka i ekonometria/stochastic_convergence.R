pacman::p_load(purrr, ggplot2, dplyr)

# Convergence in distribution ----
# Tossing a coin, let Xn be the fraction of heads after n tosses
set.seed(2137)

# X1 has Bernoulli-like distribution, it can have either 0% or 100% of heads
# simulate X1 k = 1e4 times
tosses = map_chr(1:1e4, ~ sample(c('H', 'T'), size = 1))
X1 = map_dbl(tosses, ~ sum(.x == 'H') / length(.x))
hist(X1)

# X2, X3, ... have binomial-like distribution
# simulate X4 k = 1e4 times, it can have either 0% or 25% or 50% or 75% or 100% heads
# but more balanced results (e.g. 50%) are more likely than unbalanced events (e.g. 0% of 100%)
tosses = map(1:1e4, ~ sample(c('H', 'T'), size = 4, replace = TRUE))
X4 = map_dbl(tosses, ~ sum(.x == 'H') / length(.x))
hist(X4)

# Xn has normal-like distribution
# simulate large n, let's say n = 1e4
tosses = map(1:1e4, ~ sample(c('H', 'T'), size = 1e4, replace = TRUE))
X1e4 = map_dbl(tosses, ~ sum(.x == 'H') / length(.x))
hist(X1e4)

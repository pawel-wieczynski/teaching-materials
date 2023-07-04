pacman::p_load(purrr)

# Convergence in distribution ----
# Tossing a coin, let Xn be the fraction of heads after n tosses
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

# Convergence in probability ----
# Tossing a coin and tracking the running proportion of heads
# It should convergence to 0.5 as n increases
# denote 0 = tails, 1 = heads
tosses = map_dbl(1:1e4, ~ sample(c(0, 1), size = 1))
plot(1:1e4, cumsum(tosses)/(1:1e4), type = 'l', ylim = c(0,1))
abline(h = 0.5, col = "red", lwd = 1)


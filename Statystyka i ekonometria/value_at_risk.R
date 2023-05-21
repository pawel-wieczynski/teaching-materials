if(!require(pacman)) install.packages('pacman')
pacman::p_load(rugarch, MASS, ggplot2)

dax = datasets::EuStockMarkets[, 1]
returns = diff(log(dax))

alpha = 0.05

# Historical method ----
VaR_historical = quantile(returns, alpha, names = FALSE)

# Parametric method (normal distribution) ----
mu = mean(returns)
sigma = sd(returns)
VaR_parametric_normal = qnorm(alpha, mu, sigma)

# Parametric method (t-Student distribution) ----
normalized_returns = (returns - mu) / sigma
fit = fitdistr(normalized_returns, 't')
df = fit$estimate['df']
VaR_parametric_t = mu + sigma * qt(alpha, df)

# Simulation method (t-Student distribution) ----
set.seed(2137)
returns_simulated_t = mu + sigma * rt(10000, df)
VaR_simulated_t = quantile(returns_simulated_t, alpha, names = FALSE)
  
# EWMA model ----
lambda = 0.94
var_ewma = rep(0, length(returns))

for (i in seq_along(returns)) {
  if (i == 1) {
    var_ewma[i] = var(returns)
  } else {
    var_ewma[i] = lambda * var_ewma[i-1] + (1 - lambda) * returns[i-1]^2
  }
}

VaR_EWMA = qt(alpha, df) * tail(sqrt(var_ewma), 1)

# GARCH model ----
spec = ugarchspec(
  variance.model = list(model = 'sGARCH', garchOrder = c(1, 1))
  , mean.model = list(armaOrder = c(0, 0), include.mean = TRUE)
  , distribution.model = 'norm'
)

fit = ugarchfit(spec, returns)
VaR_GARCH = qt(alpha, df) * tail(as.numeric(sigma(fit)), 1)

# Visualize results ----
var_data = data.frame(
  Method = c('Historical', 'Parametrical (normal)', 'Parametrical (t)', 'Simulated (t)', 'EWMA', 'GARCH')
  ,VaR = c(VaR_historical, VaR_parametric_normal, VaR_parametric_t, VaR_simulated_t, VaR_EWMA, VaR_GARCH)
)

ggplot(data.frame(returns = returns), aes(x = returns)) +
  geom_density(fill = 'blue', alpha = 0.4) +
  geom_vline(data = var_data, aes(xintercept = VaR, color = Method), linetype = 'dashed', size = 1) +
  guides(color = guide_legend(override.aes = list(linetype = 'solid', shape = 15))) +
  theme_bw() +
  theme(legend.position = c(0.2, 0.8), legend.background = element_blank())

# VaR vs different alpha levels ----
alpha_levels = seq(0.001, 0.1, length.out = 1000)
VaR_historical = sapply(alpha_levels, function(p) quantile(returns, p, names = FALSE))
VaR_parametric_normal = sapply(alpha_levels, function(p) qnorm(p, mu, sigma))
VaR_parametric_t = sapply(alpha_levels, function(p) mu + sigma * qt(p, df))
VaR_EWMA = sapply(alpha_levels, function(p) qt(p, df) * tail(sqrt(var_ewma), 1))
VaR_GARCH = sapply(alpha_levels, function(p) qt(p, df) * tail(as.numeric(sigma(fit)), 1))

plot_data = data.frame(
  Alpha = rep(alpha_levels, 5)
  ,VaR = c(VaR_historical, VaR_parametric_normal, VaR_parametric_t, VaR_EWMA, VaR_GARCH)
  ,Method = factor(rep(c('Historical', 'Parametrical (normal)', 'Parametrical (t)', 'EWMA', 'GARCH'), each = length(alpha_levels)))
)

ggplot(plot_data, aes(x = Alpha, y = VaR, color = Method)) +
  geom_line(size = 1) +
  labs(x = 'Alpha level', y = 'VaR', color = 'Method') +
  theme_bw() +
  theme(legend.position = c(0.8, 0.2), legend.background = element_blank())

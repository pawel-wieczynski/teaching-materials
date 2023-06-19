if(!require('pacman')) install.packages('pacman')
pacman::p_load(tidyverse)
theme_set(theme_bw())

df = read.csv('datasets\\stock_data.csv') %>%
  mutate(Data = as.Date(Data))

# Vizualize close prices
df %>%
  pivot_longer(
    cols = 2:5
    ,names_to = 'Asset'
    ,values_to = 'Close Price'
  ) %>%
  ggplot(aes(x = Data, y = `Close Price`)) +
  geom_line(aes(color = Asset), linewidth = 0.8) +
  facet_wrap(vars(Asset), scales = 'free') +
  theme(legend.position = 'none') +
  labs(y = '', x = '', title = 'Close prices of assets')

# Calculate daily log returns
returns_df = sapply(
  df %>% select(-Data)
  , function(x) diff(log(x), lag = 1)
) %>% as.data.frame()

# Calculate annualized mean returns, covariance matrix, and standard deviations
returns_mean = (colMeans(returns_df) + 1)^252 - 1
returns_cov = cov(returns_df) * 252
returns_sd = diag(returns_cov) %>% sqrt()

# Alpha level for Value-at-Risk measures
alpha = 0.05

# Calculate VaR and ES for particulat assets
returns_var = sapply(returns_df, quantile, probs = alpha)
returns_cvar = sapply(1:ncol(returns_df), function(i) {
  # Getting the returns of asset i
  asset_returns = returns_df[, i]
  # Getting VaR for asset i
  asset_var = returns_var[i]
  # Logical vector indicating which returns are below -VaR
  cvar_indicator = asset_returns < asset_var
  # Calculating CVaR (Expected Shortfall)
  cvar = sum(asset_returns * cvar_indicator) / sum(cvar_indicator)
  return(cvar)
})

# Set the annual risk-free rate
risk_free = 0.05

# Number of portfolios to simulate
num_of_portfolios = 1e4

# Initialize matrices for storing weights and metrics
weights = matrix(nrow = num_of_portfolios, ncol = ncol(returns_df))

portfolio_metrics = data.frame(
  returns = rep(0, num_of_portfolios)
  , volatility = rep(0, num_of_portfolios)
  , sharpe_volatility = rep(0, num_of_portfolios)
  , var = rep(0, num_of_portfolios)
  , sharpe_var = rep(0, num_of_portfolios)
  , cvar = rep(0, num_of_portfolios)
  , sharpe_cvar = rep(0, num_of_portfolios)
)

# Set seed for reproducibility
set.seed(2137)

# Simulate portfolios
for (i in 1:num_of_portfolios) {
  
  random_weights = runif(ncol(weights))
  random_weights = random_weights / sum(random_weights)
  weights[i, ] = random_weights
  
  portfolio_returns = as.numeric(as.matrix(returns_df) %*% random_weights)
  
  portfolio_metrics$returns[i] = random_weights %*% returns_mean
  portfolio_metrics$volatility[i] = sqrt(t(random_weights) %*% (returns_cov %*% random_weights))
  portfolio_metrics$sharpe_volatility[i] = (portfolio_metrics$returns[i] - risk_free) / portfolio_metrics$volatility[i]
  
  portfolio_metrics$var[i] = -quantile(portfolio_returns, alpha)
  portfolio_metrics$sharpe_var[i] = (portfolio_metrics$returns[i] - risk_free) / portfolio_metrics$var[i]
  
  cvar_indicator = portfolio_returns < -portfolio_metrics$var[i]
  portfolio_metrics$cvar[i] = -sum(portfolio_returns * cvar_indicator) / sum(cvar_indicator)
  portfolio_metrics$sharpe_cvar[i] = (portfolio_metrics$returns[i] - risk_free) / portfolio_metrics$cvar[i]
  
}

# Find optimal portfolios: min variance and max sharpe_volatility ratio
optimal_portfolios = data.frame(
  Min_Volatility = c(
    round(100 * weights[which.min(portfolio_metrics$volatility),], 2)
    ,round(100 * portfolio_metrics[which.min(portfolio_metrics$volatility), ], 2) %>% as.numeric()
  )
  ,Max_Sharpe_volatility = c(
    round(100 * weights[which.max(portfolio_metrics$sharpe_volatility),], 2)
    ,round(100 * portfolio_metrics[which.max(portfolio_metrics$sharpe_volatility), ], 2) %>% as.numeric()
  )
  ,Min_VaR = c(
    round(100*weights[which.min(portfolio_metrics$var),], 2)
    ,round(100*portfolio_metrics[which.min(portfolio_metrics$var), ], 2) %>% as.numeric()
  )
  ,Max_Sharpe_VaR = c(
    round(100*weights[which.max(portfolio_metrics$sharpe_var),], 2)
    ,round(100*portfolio_metrics[which.max(portfolio_metrics$sharpe_var), ], 2) %>% as.numeric()
  )
  ,Min_cVaR = c(
    round(100*weights[which.min(portfolio_metrics$cvar),], 2)
    ,round(100*portfolio_metrics[which.min(portfolio_metrics$cvar), ], 2) %>% as.numeric()
  )
  ,Max_Sharpe_cVaR = c(
    round(100*weights[which.max(portfolio_metrics$sharpe_cvar),], 2)
    ,round(100*portfolio_metrics[which.max(portfolio_metrics$sharpe_cvar), ], 2) %>% as.numeric()
  )
) %>% t() %>% as.data.frame()

# Set column names for the output
colnames(optimal_portfolios) = c(
  colnames(returns_df), 'Expected Return'
  , 'Volatility', 'Sharpe Ratio (Volatility)'
  , 'Value-at-Risk', 'Sharpe Ratio (Value-at-Risk)'
  , 'Expected Shortfall', 'Sharpe Ratio (Expected Shortfall)'
)

# Display optimal portfolios
optimal_portfolios

# Visualize optimal portfolios
# Risk measured by volatility (standard deviation)
ggplot(portfolio_metrics, aes(x = volatility, y = returns, color = sharpe_volatility)) +
  geom_point() +
  geom_point(aes(x = (optimal_portfolios$`Volatility`[1] / 100)
                 ,y = (optimal_portfolios$`Expected Return`)[1] / 100)
             ,color = 'black', size = 5, shape = 17) +
  geom_point(aes(x = (optimal_portfolios$`Volatility`[2] / 100)
                 ,y = (optimal_portfolios$`Expected Return`)[2] / 100)
             ,color = 'red', size = 5, shape = 17) +
  # xlim(0.15, 0.40) +
  theme_bw() +
  theme(legend.position = c(0.8, 0.5), legend.background = element_blank())

# Risk measured by Value-at-Risk
ggplot(portfolio_metrics, aes(x = var, y = returns, color = sharpe_var)) +
  geom_point() +
  geom_point(aes(x = (optimal_portfolios$`Value-at-Risk`[1] / 100)
                 ,y = (optimal_portfolios$`Expected Return`)[1] / 100)
             ,color = 'black', size = 5, shape = 17) +
  geom_point(aes(x = (optimal_portfolios$`Value-at-Risk`[2] / 100)
                 ,y = (optimal_portfolios$`Expected Return`)[2] / 100)
             ,color = 'red', size = 5, shape = 17) +
  # xlim(0, 0.040) +
  theme_bw() +
  theme(legend.position = c(0.8, 0.5), legend.background = element_blank())

# Risk measured by Expected Shortfall
ggplot(portfolio_metrics, aes(x = cvar, y = returns, color = sharpe_cvar)) +
  geom_point() +
  geom_point(aes(x = (optimal_portfolios$`Expected Shortfall`[1] / 100)
                 ,y = (optimal_portfolios$`Expected Return`)[1] / 100)
             ,color = 'black', size = 5, shape = 17) +
  geom_point(aes(x = (optimal_portfolios$`Expected Shortfall`[2] / 100)
                 ,y = (optimal_portfolios$`Expected Return`)[2] / 100)
             ,color = 'red', size = 5, shape = 17) +
  # xlim(0, 0.050)
  theme_bw() +
  theme(legend.position = c(0.8, 0.5), legend.background = element_blank())

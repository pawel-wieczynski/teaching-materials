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

# Set the annual risk-free rate
risk_free = 0.05

# Number of portfolios to simulate
num_of_portfolios = 1e4

# Initialize matrices for storing weights and metrics
weights = matrix(nrow = num_of_portfolios, ncol = ncol(returns_df))

portfolio_metrics = data.frame(
  returns = rep(0, num_of_portfolios)
  , volatility = rep(0, num_of_portfolios)
  , sharpe = rep(0, num_of_portfolios)
)

# Set seed for reproducibility
set.seed(2137)

# Simulate portfolios
for (i in 1:num_of_portfolios) {
  
  random_weights = runif(ncol(weights))
  random_weights = random_weights / sum(random_weights)
  weights[i, ] = random_weights
  
  portfolio_metrics$returns[i] = random_weights %*% returns_mean
  portfolio_metrics$volatility[i] = sqrt(t(random_weights) %*% (returns_cov %*% random_weights))
  portfolio_metrics$sharpe[i] = (portfolio_metrics$returns[i] - risk_free) / portfolio_metrics$volatility[i]
  
}

# Find optimal portfolios: min variance and max Sharpe ratio
optimal_portfolios = data.frame(
  Min_Variance = c(
    round(100 * weights[which.min(portfolio_metrics$volatility),], 2)
    ,round(100 * portfolio_metrics[which.min(portfolio_metrics$volatility), ], 2) %>% as.numeric()
  )
  ,Max_Sharpe = c(
    round(100 * weights[which.max(portfolio_metrics$sharpe),], 2)
    ,round(100 * portfolio_metrics[which.max(portfolio_metrics$sharpe), ], 2) %>% as.numeric()
  )
) %>% t() %>% as.data.frame()

# Set column names for the output
colnames(optimal_portfolios) = c(colnames(returns_df), 'Expected Return', 'Standard Deviation', 'Sharpe Ratio')

# Display optimal portfolios
optimal_portfolios

# Visualize optimal portfolios
ggplot(portfolio_metrics, aes(x = volatility, y = returns, color = sharpe)) +
  geom_point() +
  geom_point(aes(x = (optimal_portfolios$`Standard Deviation`[1] / 100)
                 ,y = (optimal_portfolios$`Expected Return`)[1] / 100)
             ,color = 'black', size = 5, shape = 17) +
  geom_point(aes(x = (optimal_portfolios$`Standard Deviation`[2] / 100)
                 ,y = (optimal_portfolios$`Expected Return`)[2] / 100)
             ,color = 'red', size = 5, shape = 17) +
  xlim(0.15, 0.40) +
  theme_bw() +
  theme(legend.position = c(0.8, 0.5), legend.background = element_blank())

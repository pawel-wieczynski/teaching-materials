library(tidyverse)
options(scipen = 20)
theme_set(theme_bw())

# Get data from stooq ----
df_daily = read.csv(url('https://stooq.pl/q/d/l/?s=dnp&i=d'), stringsAsFactors = FALSE) %>%
  mutate(Data = as.Date(Data)) %>%
  mutate(Returns = c(NA, diff(log(Zamkniecie)))) %>%
  mutate(Frequency = 'Daily') %>%
  na.omit()

df_weekly = read.csv(url('https://stooq.pl/q/d/l/?s=dnp&i=w'), stringsAsFactors = FALSE) %>%
  mutate(Data = as.Date(Data)) %>%
  mutate(Returns = c(NA, diff(log(Zamkniecie)))) %>%
  mutate(Frequency = 'Weekly') %>%
  na.omit()

# Volatility vs data frequency ----
bind_rows(df_daily, df_weekly) %>%
  ggplot(aes(x = Data, y = Returns, color = Frequency)) +
  geom_line() +
  labs(
    title = 'Returns over time'
    , x = 'Date'
    , y = 'Returns'
    , color = 'Frequency'
  ) +
  theme(legend.position = c(0.2, 0.85), legend.background = element_blank())

sd(df_daily$Returns)
sd(df_weekly$Returns)

var.test(
  df_weekly$Returns
  , df_daily$Returns
  , ratio = 1
  , alternative = 'greater'
)

# Plot densities ----
source('https://raw.githubusercontent.com/pawel-wieczynski/useful-functions/main/histogram_with_densities.R')
histogram_with_densities(df_daily, 'Returns', 'Daily returns of Dino Polska', 50)
histogram_with_densities(df_weekly, 'Returns', 'Weekly returns of Dino Polska', 30)

# Fit normal distribution ----
m_daily = mean(df_daily$Returns)
sd_daily = sd(df_daily$Returns)

m_weekly = mean(df_weekly$Returns)
sd_weekly = sd(df_weekly$Returns)

# Calculate VaR ----
alpha = 0.05

VaR_daily = qnorm(alpha, m_daily, sd_daily)
VaR_weekly = qnorm(alpha, m_weekly, sd_weekly)

H = 5 # trading week has 5 days
VaR_daily_H = VaR_daily * sqrt(H)

# Monte Carlo ----
N = 1e4
simulated_weekly_returns = c()

set.seed(2137)
for (i in 1:N) {
  returns = rnorm(H, m_daily, sd_daily)
  cum_return = sum(returns) # log-returns are additive
  simulated_weekly_returns = c(simulated_weekly_returns, cum_return)
}

VaR_MC = quantile(simulated_weekly_returns, alpha)

# Plot results ----
ggplot(df_weekly, aes(Returns)) + 
  geom_histogram(fill = 'steelblue', color = 'white', bins = 30) +
  geom_vline(aes(color = 'VaR from weekly returns', xintercept = VaR_weekly), size = 1) +
  geom_vline(aes(color = 'Square root of time', xintercept = VaR_daily_H), size = 1) +
  geom_vline(aes(color = 'Monte Carlo', xintercept = VaR_MC), size = 1) +
  theme(legend.position = c(0.8, 0.8), legend.background = element_blank()) +
  labs(color = 'Method', y = '', title = 'Weekly 5% Value-at-Risk')

# H = 1, ... 252 ----
H = 1:252
VaR_year = VaR_daily * sqrt(H)

VaR_year_MC = c()

set.seed(2137)
for (h in H) {
  simulated_returns = c()
  for (i in 1:N) {
    returns = rnorm(h, m_daily, sd_daily)
    cum_return = sum(returns)
    simulated_returns = c(simulated_returns, cum_return)
  }
  VaR_year_MC[h] = quantile(simulated_returns, alpha)
}

VaR_year_df = tibble(
  H = H
  , 'Pierwiastek kwadratowy z czasu' = -100 * VaR_year
  , 'Symulacje Monte Carlo' = -100 * VaR_year_MC
)

VaR_year_df %>%
  pivot_longer(
    cols = 2:3
    , names_to = 'Metoda'
    , values_to = 'Value-at-Risk'
  ) %>%
  ggplot(aes(x = H, y = `Value-at-Risk`)) +
  geom_line(aes(color = Metoda), size = 1) +
  theme(legend.position = c(0.2, 0.8), legend.background = element_blank()) +
  labs(title = '5% Value-at-Risk dla różnych horyzontów czasowych')

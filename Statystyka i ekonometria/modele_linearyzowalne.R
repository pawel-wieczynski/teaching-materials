if(!require('pacman')) install.packages('pacman')
pacman::p_load(purrr, dplyr, ggplot2, lmtest)

# Define regression formulas
formulas = list(
  'Linear' = formula('y ~ x')
  ,'Power' = formula('log(y) ~ log(x)')
  ,'Exponential' = formula('log(y) ~ x')
  ,'S-type' = formula('log(y) ~ I(1/x)')
  ,'Hyperbolic' = formula('I(1/y) ~ x')
  ,'Double-hyperbolic' = formula('I(1/y) ~ I(1/x)')
  ,'Root' = formula('y ~ sqrt(x)')
  ,'Log' = formula('y ~ log(x)')
  ,'Squared' = formula('y ~ I(x^2)')
)

# Fit models
models = map(formulas, ~ lm(.x, data = mtcars %>% mutate(x = disp, y = mpg)))

# Set significance level for model diagnostics
alpha = 0.05

# Model diagnostics
model_tests = list(
  # Get R^2
  `R Squared` = map_dbl(map(models, summary), 'r.squared')
  
  # Get coef significance
  ,`Coef significant` = map_lgl(map(models, summary), ~ .x[['coefficients']][2, 4] < alpha)
  
  # Test for residuals normality
  ,`Normal residuals` = map_lgl(map(models, 'residuals'), ~ shapiro.test(.x)[['p.value']] > alpha)
  
  # Test for residuals homoscedasticity
  ,`Homoscedastic residuals` = map_lgl(models, ~ bptest(.x)[['p.value']] > alpha)
  
  # Test for residuals independence
  ,`Independent residuals` = map_lgl(models, ~ dwtest(.x)[['p.value']] > alpha)
)

model_tests_df = as_tibble(model_tests) %>%
  mutate(Model = names(formulas), .before = 1)

# Plot R^2
ggplot(model_tests_df, aes(y = reorder(Model, `R Squared`), x = `R Squared`)) +
  geom_col(fill = '#00BFC4') +
  theme_bw() +
  labs(y = '')

# Plot models which satisfies linear regression assumptions
ggplot(mtcars, aes(x = disp, y = mpg)) +
  geom_point() +
  geom_smooth(method = 'lm', formula = 'y ~ log(x)', se = FALSE, aes(color = 'Log model')) +
  geom_smooth(method = 'lm', formula = 'y ~ exp(I(1/x))', se = FALSE, aes(color = 'S-type model'))+
  scale_color_manual(values = c("#00BFC4", "#7CAE00")) +
  theme_bw() +
  theme(
    legend.position = c(0.8, 0.8)
    , legend.background = element_blank()
    , legend.title = element_text(size = 15)
    , legend.text = element_text(size = 12)
  ) +
  labs(color = 'Model type')

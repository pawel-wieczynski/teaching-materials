if(!require('pacman')) install.packages('pacman')
pacman::p_load(purrr, dplyr, ggplot2, lmtest)
theme_set(theme_bw())
data(mtcars)

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

alpha = 0.05

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
  ,`Independent residuals` = map_lgl(models, ~ bptest(.x)[['p.value']] > alpha)
)

model_tests_df = as_tibble(model_tests) %>%
  mutate(Model = names(formulas), .before = 1)


ggplot(model_tests_df, aes(y = reorder(Model, `R Squared`), x = `R Squared`)) +
  geom_col(fill = 'steelblue')
# Plot models
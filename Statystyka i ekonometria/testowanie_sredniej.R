if(!require('pacman')) install.packages('pacman')
pacman::p_load(tidyverse, car)

# One-sample t-test ----
age = rnorm(100, 40, 5) %>% round(0)
shapiro.test(age)

mean(age)
t.test(age, mu = 40)

# Two-sample t-test (paired) ----
data(sleep)
shapiro.test(sleep %>% filter(group == 1) %>% pull(extra))
shapiro.test(sleep %>% filter(group == 2) %>% pull(extra))

t.test(
  sleep %>% filter(group == 1) %>% pull(extra)
  , sleep %>% filter(group == 2) %>% pull(extra)
  , paired = TRUE
)

t.test(sleep$extra ~ sleep$group, paired = TRUE)

sleep = sleep %>%
  pivot_wider(id_cols = 'ID', values_from = 'extra', names_from = 'group') %>%
  mutate(diff = `1` - `2`)

t.test(sleep$diff)

# Two-sample t-test (unpaired) ----
data(mtcars)
shapiro.test(mtcars %>% filter(am == 0) %>% pull(mpg))
shapiro.test(mtcars %>% filter(am == 1) %>% pull(mpg))

leveneTest(mpg ~ as.factor(am), data = mtcars)

t.test(mpg ~ am, data = mtcars, var.equal = TRUE)
t.test(mpg ~ am, data = mtcars, var.equal = FALSE)

# Wilcox test ----
data(ChickWeight)
shapiro.test(ChickWeight %>% filter(Diet == 1) %>% pull(weight))
shapiro.test(ChickWeight %>% filter(Diet == 2) %>% pull(weight))

wilcox.test(
  ChickWeight %>% filter(Diet == 1) %>% pull(weight)
  ,ChickWeight %>% filter(Diet == 2) %>% pull(weight)
)

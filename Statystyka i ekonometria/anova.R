if(!require('pacman')) install.packages('pacman')
pacman::p_load(purrr, dplyr, ggplot2, tseries, car)

# Create dataset ----
set.seed(2137)

# Function that takes sleep, noise, mean, and sd as arguments and returns the desired random value
generate_exam = function(sleep, noise, mean, sd) {
  tibble(
    sleep = sleep
    , noise = noise
    , exam = round(rnorm(10, mean = mean, sd = sd), 2)
  )
}

# Define possible conditions
conditions = tibble(
  sleep = rep(c('4 hours', '8 hours'), each = 3)
  , noise = rep(c('silence', 'intermediate noise', 'big noise'), times = 2)
  , mean = c(10, 7, 5, 15, 12, 10)
  , sd = rep(1, 6)
)

# Apply the function over multiple inputs
df <- pmap_dfr(conditions, generate_exam)

# Convert characters to factors
df = df %>% mutate_if(is.character, as.factor)

# One-way ANOVA ----
## Analyze dataset ----
df %>%
  group_by(noise) %>%
  summarize(
    mean = mean(exam)
    , sd = sd(exam)
  ) %>% 
  arrange(-mean)

ggplot(df, aes(x = noise, y = exam)) +
  geom_boxplot(aes(fill = noise)) +
  theme_bw() +
  theme(legend.position = 'none')

## Check assumptions ----
# Normality
df %>%
  group_by(noise) %>%
  summarise(p_value = tseries::jarque.bera.test(exam)$p.value)

# Variance homogeneity
car::leveneTest(exam ~ noise, data = df)

## Fit ANOVA ----
model = aov(exam ~ noise, data = df)
summary(model)

## Post-hoc analysis ----
TukeyHSD(model)

# Two-way ANOVA ----
## Analyze dataset ----
df %>%
  group_by(sleep, noise) %>%
  summarize(
    mean = mean(exam)
    , sd = sd(exam)
  ) %>% 
  arrange(-mean)

ggplot(df, aes(x = sleep, y = exam)) +
  geom_boxplot(aes(fill = noise)) +
  theme_bw() +
  theme(legend.position = 'none')

## Check assumptions ----
# Normality
df %>%
  group_by(sleep, noise) %>%
  summarise(p_value = tseries::jarque.bera.test(exam)$p.value)

# Variance homogenity
car::leveneTest(exam ~ sleep * noise, data = df)

## Fit ANOVA ----
model = aov(exam ~ sleep * noise, data = df)
summary(model)

## Post-hoc analysis ----
TukeyHSD(model)

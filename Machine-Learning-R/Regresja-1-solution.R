library(tidyverse)
library(broom)

# Krok 1: import danych ----
data(cars)

# Krok 2: analiza danych ----
summary(cars)

## przygotowanie danych ----
# Konwersja mil na km
cars$speed = cars$speed * 1.609344

# Konwersja stóp na metry
cars$dist = cars$dist * 0.3048

summary(cars)

## wizualizacja danych ----
ggplot(cars, aes(x = speed, y = dist)) +
  geom_point()

cars %>%
  pivot_longer(cols = 1:2, names_to = 'Variable', values_to = 'Value') %>%
  ggplot(aes(x = Variable, y = Value, fill = Variable)) +
  geom_boxplot() +
  theme(legend.position = 'none')

# Krok 3: wybór zmiennych ----

# Krok 4: trenowanie modelu ----
model_1 = lm(dist ~ speed, data = cars)
model_2 = lm(dist ~ I(speed^2), data = cars)

# Krok 5: ocena modelu ----
summary(model_1)
summary(model_2)

ggplot(cars, aes(x = speed, y = dist)) +
  geom_point() +
  geom_smooth(formula = 'y ~ x', method = 'lm', se = FALSE) +
  geom_smooth(formula = 'y ~ I(x^2)', method = 'lm', se = FALSE, color = 'red')

## reszty modelu ----
cars_model_1 = augment(model_1)
cars_model_2 = augment(model_2)

ggplot(cars_model_1, aes(.resid)) +
  geom_histogram(color = 'white', bins = 10)

ggplot(cars_model_2, aes(.resid)) +
  geom_histogram(color = 'white', bins = 10)

# Krok 6: prognozowanie ----
new_data = data.frame(speed = c(30, 50, 80))
predict(model_1, newdata = new_data)
predict(model_2, newdata = new_data)

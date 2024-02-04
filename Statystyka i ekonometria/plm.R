library(plm)

data(Grunfeld)
class(Grunfeld)

f = as.formula('inv ~ value + capital')

# Pooling model is just a regular OLS
model_1 = plm(f, Grunfeld, model = 'pooling')
model_2 = lm(f, Grunfeld)

summary(model_1)
summary(model_2)

# FE
model_3 = plm(f, Grunfeld, model = 'within')
summary(model_3)
fixef(model_3)

model_4 = plm(f, Grunfeld, model = 'within', effect = 'time')
summary(model_4)
fixef(model_4)

model_5 = plm(f, Grunfeld, model = 'within', effect = 'twoways')
summary(model_5, vcov = vcovHC)
fixef(model_5, effect = 'individual')
fixef(model_5, effect = 'time')

# RE
model_6 = plm(f, Grunfeld, model = 'random')
summary(model_6)

model_7 = plm(f, Grunfeld, model = 'random', effect = 'time')
summary(model_7)

model_8 = plm(f, Grunfeld, model = 'random', effect = 'twoways')
summary(model_8, vcov = vcovHC)

# Data simulation
library(ggplot2)
set.seed(2137)
beta_pop = -0.25

x = c(
  seq(0, 30, length.out = 50)
  , seq(25, 60, length.out = 50)
  , seq(50, 80, length.out = 50)
)

y = c(
  20 + beta_pop * x[1:50] + rnorm(50, 0, 2)
  , 30 + beta_pop * x[51:100] + rnorm(50, 2, 3)
  , 40 + beta_pop * x[101:150] + rnorm(50, 1, 2.5)
)

f = as.factor(rep(c('A', 'B', 'C'), each = 50))

df = data.frame(x = x, y = y, f = f)

ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

ggplot(df, aes(x = x, y = y, color = f)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)
















library(ggplot2)
set.seed(2137)
df = data.frame(
  Country = as.factor(c(rep('Germany', 30), rep('Poland', 30), rep('Sweden', 30)))
  ,Marketing = c(
    seq(1, 10, length.out = 30)
    , seq(6, 15, length.out = 30)
    , seq(8, 17, length.out = 30)
  )
  ,Income = c(
    2*seq(1, 10, length.out = 30) + 5 + rnorm(30, 3, 5)
    , 4*seq(5, 15, length.out = 30) + 1 + rnorm(30, 10, 8)
    , 6*seq(8, 17, length.out = 30) + 10 + rnorm(30, 5, 10)
  )
)

ggplot(df, aes(x = Marketing, y = Income, color = Country)) +
  geom_point(size = 3) +
  geom_smooth(method = 'lm', se = FALSE)

summary(lm(Income ~ Marketing + Country , data = df))
write.csv(df, 'panel_data.csv', row.names = FALSE)

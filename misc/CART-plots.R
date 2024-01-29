pacman::p_load(tidyverse, tree)
options(scipen = 20)
theme_set(theme_bw())

df = read.csv('Machine-Learning-R\\data\\insurance.csv', stringsAsFactors = TRUE) %>% arrange(smoker)

set.seed(234)
df_sample = rbind(
  df[sample(1:sum(df$smoker == 'no'), size = 100), ]
  , df[sample((sum(df$smoker == 'no')+1):nrow(df), size = 100), ]
)

model = tree(charges ~ age + smoker, data = df_sample)
model

ggplot(df_sample, aes(x = age, y = smoker, color = charges)) +
  geom_jitter(height = 0.2, size = 3) +
  scale_colour_gradient(high = '#F8766D', low = '#7CAE00') +
  # Split 1
  geom_hline(yintercept = 1.5, linewidth = 1, color = 'black') +
  # Split 2
  geom_segment(x = 46.5, xend = 46.5, y = 0, yend = 1.5, color = 'black', linewidth = 1) +
  # Split 3
  geom_segment(x = 43.5, xend = 43.5, y = 1.5, yend = 3, color = 'black', linewidth = 1) +
  # Labels
  geom_label(x = 30, y = 1, label = 5731, size = 5, color = 'black') +
  geom_label(x = 58, y = 1, label = 12810, size = 5, color = 'black') +
  geom_label(x = 28, y = 2, label = 29020, size = 5, color = 'black') +
  geom_label(x = 50, y = 2, label = 37060, size = 5, color = 'black')

if (!require('pacman')) install.packages('pacman')
pacman::p_load('dplyr', 'tidyr', 'ggplot2', 'xgboost')

# Get data from stooq ----
df = read.csv(url('https://stooq.pl/q/d/l/?s=dnp&i=d'), stringsAsFactors = FALSE) %>%
  mutate(Data = as.Date(Data)) %>%
  rename(Date = Data, Close = Zamkniecie) %>%
  arrange(Date) %>%
  # One day shift - we will predict tomorrow's Close based on today's Close
  mutate(Close_lag = lag(Close)) %>%
  na.omit()

# Split data
train <- df %>% filter(Date < as.Date('2022/07/01'))
test <- df %>% filter(Date >= as.Date('2022/07/01'))

# Prepare data for xgboost model
train_data <- data.matrix(train[ , 'Close_lag'])
train_label <- train$Close
test_data <- data.matrix(test[ , 'Close_lag'])
test_label <- test$Close

# Parameters for the xgboost model
param <- list('objective' = 'reg:squarederror')  

# Create xgboost specific matrix
xgb_train <- xgb.DMatrix(data = train_data, label = train_label)
xgb_test <- xgb.DMatrix(data = test_data, label = test_label)

# Train model
xgb_model <- xgb.train(params = param, data = xgb_train, nrounds = 100)

# Predict on the test set
preds <- predict(xgb_model, xgb_test)

# Combine predictions with the original data
full_data <- test %>%
  mutate(Preds = preds) %>%
  bind_rows(train) %>%
  arrange(Date)

# Plot the actual values and predictions
full_data %>%
  gather(key = 'Type', value = 'Value', Close, Preds) %>%
  ggplot(aes(x = Date, y = Value, color = Type)) +
  geom_line(size = 0.75) +
  theme_bw() +
  theme(legend.position = 'none')

require(caret)
require(jsonlite)

idx <- createDataPartition(mtcars$vs, p = .7, list = FALSE)

x_train <- mtcars[idx,]
y_test <- mtcars[-idx,]

model <- lm(hp ~ ., data = x_train)

param <- coef(model)
param

df <- data.frame(features = names(param), value = param)
colnames(df) <- NULL
json <- toJSON(df)

handle <- file('data/params.json', open = 'wt')
write(json, file = handle)
close(handle)
require(caret)

idx <- createDataPartition(mtcars$vs, p = .7, list = FALSE)

train <- mtcars[idx,]
train$vs <- factor(train$vs, labels = c('V', 'S'))
test <- mtcars[-idx,]
test$vs <- factor(test$vs, labels = c('V', 'S'))

model <- caret::train(vs ~ mpg + cyl + hp + wt,
                      data = train,
                      method = "LogitBoost",
                      preProcess = c('center', 'scale'))

y_pred <- predict(model, newdata = test)

caret::confusionMatrix(y_pred, test$vs)

saveRDS(model, file = "data/model.RDS")
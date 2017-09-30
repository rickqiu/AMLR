require(mlbench)
require(caret)
data(DNA)

idx <- createDataPartition(DNA$Class, p = .7, list = FALSE)
X_train <- DNA[idx,]
X_test <- DNA[-idx,]

model <- caret::train(Class ~ ., data = X_train, method = 'multinom')

model

y_test_pred <- predict(model, X_test)
cm <- caret::confusionMatrix(y_test_pred, X_test$Class)
cm$byClass[, 'F1']
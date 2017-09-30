#https://topepo.github.io/caret/train-models-by-tag.html
require(mlbench)
require(caret)
#install.packages("glmnet")
require(glmnet)

data("Sonar")

X <- Sonar[ , 1:(NCOL(Sonar)-1)]
y <- Sonar$Class

train_idx <- createDataPartition(y, p = .7, list = FALSE)

X_train <- X[train_idx,]
y_train <- y[train_idx]

X_test <- X[-train_idx,]
y_test <- y[-train_idx]

trctl <- trainControl(method = 'cv', number = 5, savePredictions = TRUE)
model <- train(x = X_train, y = y_train, method = "glmnet", trControl = trctl)
model

# tuning grid
tune_grid <- expand.grid(alpha = 20:40/100, lambda = 5:15/1000)
trctl <- trainControl(method = 'cv', number = 10, savePredictions = TRUE)
model <- train(x = X_train, y = y_train, 
               tuneGrid = tune_grid,
               method = "glmnet", 
               trControl = trctl)

summary(model$results$Accuracy)
print(model$bestTune)


pred <- predict(model, X_test)
cm <- confusionMatrix(pred, y_test)
print(cm$byClass['F1'])
cm$table
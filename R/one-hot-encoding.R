require(mlbench)
require(caret)
require(nnet)
require(mda)
data(DNA)

ydf <- data.frame(Class = DNA$Class)
encoder <- dummyVars(~ ., data = ydf)
y <- predict(encoder, newdata = ydf)

idx <- createDataPartition(DNA$Class, p = .7, list = FALSE)
X <- sapply(DNA[, -ncol(DNA)], as.integer)
X_train <- X[idx,]
X_test <- X[-idx,]
y_train <- y[idx,]
y_test <- y[-idx,]

model <- mlp(x = X_train, y = y_train, linOut = FALSE, size = c(20, 10))
model

y_test_pred <- predict(model, X_test)
head(y_test_pred)
softmax(y_test_pred)

colnames(y_test_pred) <- colnames(y)
y_test_pred_sm <- softmax(y_test_pred)
y_test
cm <- caret::confusionMatrix(y_test_pred_sm, softmax(y_test))
cm
cm$byClass[,'F1']

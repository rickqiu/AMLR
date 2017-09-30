df <- read.csv(file = "data/mtcars.csv", header = TRUE, sep = ",")
features <- c('hp', 'wt')
X <- as.matrix(df[, features])
rownames(X) <- df$model
y <- df$qsec

layer1 <- matrix(runif(8), nrow = 2)
colnames(layer1) <- paste('neuron', 1:4, sep = '')
rownames(layer1) <- features
layer1

out1 <- X %*% layer1
head(out1)

layer2 <- matrix(runif(4), nrow = 4)
colnames(layer2) <- c('output1')
rownames(layer2) <- paste('input', 1:4, sep = '')
layer2

out2 <- out1 %*% layer2
head(out2)

head(y)

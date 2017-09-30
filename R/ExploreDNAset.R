require(mlbench)
require(caret)

help(DNA)

data(DNA)
dim(DNA)
names(DNA)
summary(DNA$V1)
summary(DNA$Class)
class(DNA$V1)

X <- DNA[, 1:(NCOL(DNA)-1)]
X <- sapply(X, as.integer)
y <- as.integer(DNA$Class == 'ei')
correlations <- cor(x=X, y=y)
correlations[order(correlations), keep=TRUE]
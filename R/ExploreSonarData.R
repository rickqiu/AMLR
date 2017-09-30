#install.packages("mlbench")
library(mlbench)

data("Sonar")
dim(Sonar)
colnames(Sonar)
head(Sonar)

table(Sonar$Class)

x <- Sonar[ , 1:(NCOL(Sonar)-1)]
y <- Sonar$Class

correlations <- cor(x, as.integer(y == 'M'))
correlations[order(correlations),,drop = FALSE]
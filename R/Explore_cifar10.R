require(tensorflow)
require(keras)
require(grid)

cf <- dataset_cifar10()


class(cf)
names(cf)
str(cf)
class(cf$train$x)
dim(cf$train$x)

# 1 channel (Red) for first image
cf$train$x[1,,,1]

# list label
cf$train$y[1]

# https://www.cs.toronto.edu/~kriz/cifar.html
factor_labels <- function(y) {
    return (factor(as.vector(y), labels = 
                       c('airplane',
                         'automobile',
                         'bird',
                         'cat',
                         'deer',
                         'dog',
                         'frog',
                         'horse',
                         'ship',
                         'truck'
                         )))
}

y_train <- factor_labels(cf$train$y)
y_test <- factor_labels(cf$test$y)
table(y_train)
table(y_test)


# show image
show_image <- function(set, labels, index){
    r <- set$x[index,,,1] / 255
    g <- set$x[index,,,2] / 255
    b <- set$x[index,,,3] / 255
    img <- rgb(r,g,b)
    dim(img) <- dim(r)
    
    grid.raster(img, interpolate = FALSE, width = 1, height = 1)
    print(paste('showing image', index, ':', labels[index], sep = ""))
}

show_image(cf$train, y_train, 1)
show_image(cf$train, y_train, 2)
# This program needs to run on GPU
require(tensorflow)
require(keras)

cf <- dataset_cifar10()

n_classes <- length(unique(c(cf$train$y, cf$test$y)))
batch_size = 500
epochs = 50

x_train <- cf$train$x / 255
x_test <- cf$test$x / 255

y_train <- to_categorical(cf$train$y, n_classes)
y_test <- to_categorical(cf$test$y, n_classes)
#dim(y_test)
dim(x_train)

model <- keras_model_sequential()

model %>%
    layer_conv_2d(filters = 64,
                  kernel_size = c(6,6),
                  strides = c(1,1),
                  padding = 'same',
                  data_format = "channels_last",
                  dtype = "float32",
                  input_shape = dim(x_train[1,,,])) %>%
    layer_activation('relu') %>%
    layer_conv_2d(filters = 64, kernel_size = c(3,3), strides = c(1,1)) %>%
    layer_activation('relu') %>%
    layer_max_pooling_2d(pool_size = c(2,2)) %>%
    
    layer_conv_2d(filters = 128, kernel_size = c(3,3), padding = 'same') %>%
    layer_activation('relu') %>%
    layer_conv_2d(128, kernel_size = c(3,3)) %>%
    layer_activation('relu') %>%
    layer_max_pooling_2d(pool_size = c(2,2)) %>%
    
    layer_flatten() %>%
    layer_dense(512) %>%
    layer_activation('relu') %>%
    layer_dropout(.5) %>%
    layer_dense(n_classes) %>%
    layer_activation('softmax')

model %>% compile(optimizer = optimizer_rmsprop(),
                  loss = 'categorical_crossentropy',
                  metrics = c('accuracy'))

history <- model %>%
    fit(x = x_train, y = y_train, bach_size = batch_size,
        epochs = epochs, validation_split = .2)

#plot(history)

loss_and_matrics <- model %>% evaluate(x_test, y_test)
str(loss_and_matrics)
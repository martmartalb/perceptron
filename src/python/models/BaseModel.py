import tensorflow as tf
import numpy as np


class BaseModel:

    def __init__(self, epochs, optimizer, _seed=1234):
        self.epochs = epochs
        self.optimizer = optimizer

        self.set_seed(_seed)

    def set_seed(self, _seed):
        """Set seed for reproducible results
        """
        tf.random.set_seed(_seed)   # Tensorflow random
        np.random.seed(_seed)       # Numpy random

    def loss(self, y_true, y_pred):
        return - tf.reduce_sum(y_true * tf.math.log(tf.squeeze(y_pred)) + (1-y_true)*tf.math.log(1-tf.squeeze(y_pred)))

    def accuracy(self, y_true, y_pred):
        correct_prediction = tf.equal(y_true, y_pred)
        return tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

    def run_optimization(self, train_x, train_y):
        with tf.GradientTape() as g:
            pred = self.predict(train_x)
            loss = self.loss(train_y, pred)
        gradients = g.gradient(loss, [self.weights, self.bias])
        self.optimizer.apply_gradients(zip(gradients, [self.weights, self.bias]))
        return loss

    def fit(self, train, validation=None):
        for i in range(self.epochs):
            loss = self.run_optimization(*train)

            if validation is not None:
                y_pred = self.predict_classes(validation[0])
                y_true = validation[1]
            else:
                y_pred = self.predict_classes(train[0])
                y_true = train[1]

            acc = self.accuracy(y_true, y_pred)

            print(f"Epoch {i} ---> loss: {loss}, accuracy: {acc}")

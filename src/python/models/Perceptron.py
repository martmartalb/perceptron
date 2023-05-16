import tensorflow as tf
from .BaseModel import BaseModel


class Perceptron(BaseModel):

    def __init__(self, num_features, **kwargs):

        super().__init__(**kwargs)
        self.weights = tf.Variable(tf.random.normal([num_features, 1],
                                                    mean=0.,
                                                    stddev=0.01,
                                                    name="W"), dtype='float32')
        self.bias = tf.Variable(0, dtype='float32')
        self.activation = tf.nn.sigmoid

    def predict(self, x):
        result = tf.matmul(x, self.weights, name="apply_weight")
        result = tf.add(result, self.bias, name="add_bias")
        return self.activation(result, name="activation")

    def predict_classes(self, x):
        y_pred = self.predict(x)
        return tf.round(tf.squeeze(y_pred))

from data import load_iris_dataset
import tensorflow as tf
from models import Perceptron


train, test = load_iris_dataset()

numFeatures = 4
epochs = 50
learningRate = tf.keras.optimizers.schedules.ExponentialDecay(initial_learning_rate=0.001,
                                                              decay_rate=0.95,
                                                              decay_steps=epochs,
                                                              staircase=True)
optimizer = tf.keras.optimizers.SGD(learningRate)

model = Perceptron(numFeatures, epochs=epochs, optimizer=optimizer)
model.fit(train, test)

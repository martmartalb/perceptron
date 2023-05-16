from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
import numpy as np
import tensorflow as tf


def load_iris_dataset(binary=True, test_size=0.3):
    iris = load_iris()
    data, labels = iris.data, iris.target
    if binary:
        index = np.logical_or(labels == 0, labels == 1)
        data = data[index]
        labels = labels[index]

    train_data, test_data, train_labels, test_labels = train_test_split(data,
                                                                        labels,
                                                                        test_size=test_size,
                                                                        random_state=69)
    train_data = tf.constant(train_data, dtype='float32')
    test_data = tf.constant(test_data, dtype='float32')
    train_labels = tf.constant(train_labels, dtype='float32')
    test_labels = tf.constant(test_labels, dtype='float32')

    return (train_data, train_labels), (test_data, test_labels)

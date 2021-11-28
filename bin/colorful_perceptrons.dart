import 'neural_network.dart';
import 'perceptron.dart';

void main(List<String> arguments) {
  final network = NeuralNetwork(
    inputSize: 3,
    neuronCount: 8,
    learningRate: 0.01,
  );

  network.train([
    [1, -1, -1],
    [-1, 1, -1],
    [-1, -1, 1],
    [-1, -1, -1],
    [1, 1, 1],
    [1, 1, -1],
    [1, -1, 1],
    [-1, 1, 1]
  ], [
    [1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0],
    [-1.0, 1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0],
    [-1.0, -1.0, 1.0, -1.0, -1.0, -1.0, -1.0, -1.0],
    [-1.0, -1.0, -1.0, 1.0, -1.0, -1.0, -1.0, -1.0],
    [-1.0, -1.0, -1.0, -1.0, 1.0, -1.0, -1.0, -1.0],
    [-1.0, -1.0, -1.0, -1.0, -1.0, 1.0, -1.0, -1.0],
    [-1.0, -1.0, -1.0, -1.0, -1.0, -1.0, 1.0, -1.0],
    [-1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, 1.0]
  ]);

  print(network.evaluate([-1, -1, -1]));
}

void perceptronTest() {
  final perceptron = Perceptron(inputCount: 2);

  perceptron.train([
    [-1, -1],
    [1, -1],
    [-1, 1],
    [1, 1]
  ], [
    -1.0,
    1.0,
    -1.0,
    1.0
  ]);

  print(perceptron.evaluate([-1, -1]));
}

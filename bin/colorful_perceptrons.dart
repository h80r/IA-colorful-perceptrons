import 'neural_network.dart';
import 'utils.dart';

void main(List<String> arguments) {
  final trainingData = <List<double>>[
    [1, -1, -1],
    [-1, 1, -1],
    [-1, -1, 1],
    [-1, -1, -1],
    [1, 1, 1],
    [1, 1, -1],
    [1, -1, 1],
    [-1, 1, 1]
  ];

  final expectedOutput = [
    [1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0],
    [-1.0, 1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0],
    [-1.0, -1.0, 1.0, -1.0, -1.0, -1.0, -1.0, -1.0],
    [-1.0, -1.0, -1.0, 1.0, -1.0, -1.0, -1.0, -1.0],
    [-1.0, -1.0, -1.0, -1.0, 1.0, -1.0, -1.0, -1.0],
    [-1.0, -1.0, -1.0, -1.0, -1.0, 1.0, -1.0, -1.0],
    [-1.0, -1.0, -1.0, -1.0, -1.0, -1.0, 1.0, -1.0],
    [-1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, 1.0]
  ];

  final network = NeuralNetwork(
    inputSize: 3,
    neuronCount: 8,
    learningRate: 0.12345,
  );

  network.train(trainingData, expectedOutput);

  print(getColor(network.evaluate([-1, -1, -1])));
}

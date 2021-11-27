import 'perceptron.dart';

void main(List<String> arguments) {
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

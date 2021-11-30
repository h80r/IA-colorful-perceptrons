import 'dart:math';

import 'utils.dart';

class Neuron {
  Neuron({
    required int inputCount,
    this.bias = 1.0,
    this.learningRate = 0.5,
  }) {
    final rand = Random();

    weights = List.generate(inputCount, (_) => rand.nextDouble());
  }

  late final List<double> weights;
  final double bias;
  final double learningRate;

  double evaluate(List<double> input) {
    final result = input
        .zip(weights)
        .map((e) => e.first * e.last)
        .fold(bias, (double a, b) => a + b);

    return result;
  }

  void adjustWeights(List<double> input, double error) {
    for (var index = 0; index < weights.length; index++) {
      weights[index] += learningRate * error * input[index];
    }
  }
}

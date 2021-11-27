import 'dart:math';

import 'utils.dart';

class Perceptron {
  Perceptron({
    int? inputCount,
    List<double>? weights,
    this.bias = 1.0,
    this.learningRate = 0.5,
    this.threshold = 1.0,
    this.maxIterations = 1000,
  }) : assert(
          (inputCount != null && weights == null) ||
              (inputCount == null && weights != null),
          'Either inputCount or weights must be provided.',
        ) {
    final rand = Random();

    this.weights = weights ??= List.generate(
      inputCount!,
      (_) => rand.nextDouble(),
    );
  }

  late final List<double> weights;
  final double bias;
  final double learningRate;
  final double threshold;
  final int maxIterations;

  double evaluate(List<double> input, {bool isLinear = false}) {
    if (input.length != weights.length) {
      throw Exception('Input length must be equal to weights length');
    }

    final result = input
        .zip(weights)
        .map((e) => e.first * e.last)
        .fold(bias, (double a, b) => a + b);

    if (isLinear) return result;
    return result >= threshold ? 1 : -1;
  }

  bool train(
    List<List<double>> trainingData,
    List<double> target, [
    int iteration = 0,
  ]) {
    if (iteration >= maxIterations) return false;

    final results = trainingData.map((e) => evaluate(e)).toList();
    if (results == target) return true;

    for (var i = 0; i < trainingData.length; i++) {
      final error = target[i] - results[i];
      for (var w = 0; w < weights.length; w++) {
        weights[w] += learningRate * error * trainingData[i][w];
      }
    }

    return train(trainingData, target, iteration + 1);
  }
}

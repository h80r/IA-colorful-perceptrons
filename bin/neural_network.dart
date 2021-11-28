import 'dart:math';

import 'utils.dart';

import 'perceptron.dart';

class NeuralNetwork {
  NeuralNetwork({
    required int inputSize,
    required int neuronCount,
    this.bias = 1.0,
    this.learningRate = 0.5,
    this.maxIterations = 1000,
  }) {
    neurons = List.generate(
      neuronCount,
      (i) => Perceptron(
        inputCount: inputSize,
        bias: bias,
        learningRate: learningRate,
      ),
    );
  }

  late final List<Perceptron> neurons;
  final double bias;
  final double learningRate;
  final int maxIterations;
  int totalIterations = 0;

  List<double> evaluate(List<double> input) {
    final results = neurons
        .map((e) => e.evaluate(
              input,
              isLinear: true,
            ))
        .toList();
    final winnerIndex = results.indexOf(results.reduce(max));

    return List.generate(
      neurons.length,
      (index) => index == winnerIndex ? 1.0 : -1.0,
    );
  }

  void train(List<List<double>> trainingData, List<List<double>> target) {
    if (totalIterations >= maxIterations) return;

    final results = trainingData.map((input) => evaluate(input)).toList();
    if (results.isEquals(target)) return;

    for (var i = 0; i < trainingData.length; i++) {
      for (var n = 0; n < neurons.length; n++) {
        final error = target[i][n] -
            neurons[n].evaluate(
              trainingData[i],
              isLinear: true,
            );

        neurons[n].adjustWeights(trainingData[i], error);
      }
    }

    totalIterations++;
    return train(trainingData, target);
  }
}

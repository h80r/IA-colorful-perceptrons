import 'dart:math';

import 'package:cli_dialog/cli_dialog.dart';

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

  List<double> evaluate(List<double> input, {bool isDebug = false}) {
    final results = neurons
        .map((e) => e.evaluate(
              input,
              isLinear: true,
            ))
        .toList();
    final winnerIndex = results.indexOf(results.reduce(max));

    final parsedResults = List.generate(
      neurons.length,
      (index) => index == winnerIndex ? 1.0 : -1.0,
    );

    if (isDebug) {
      print('\nEntrada gerada: $input');
      print('Resultados obtidos:');

      final dialog = CLI_Dialog(
        listQuestions: [
          [
            {
              'question': 'Qual resultado você deseja observar?',
              'options': [
                'Antes da competição',
                'Depois da competição',
                'Ambos'
              ]
            },
            'competition'
          ]
        ],
      );
      final competition = dialog.ask()['competition'];

      for (var i = 0; i < results.length; i++) {
        if (competition == 'Antes da competição') {
          print(results[i]);
        } else if (competition == 'Depois da competição') {
          print(parsedResults[i]);
        } else {
          print('${results[i]} => ${parsedResults[i]}');
        }
      }
    }

    return parsedResults;
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

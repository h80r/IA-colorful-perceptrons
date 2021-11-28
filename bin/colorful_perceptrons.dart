import 'package:cli_dialog/cli_dialog.dart';

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

  final dialog = CLI_Dialog(
    messages: [
      ['Bem vindo ao ColorfulPerceptrons!', 'welcome'],
      ['Iremos agora selecionar as cores que serão misturadas...', 'start'],
    ],
    booleanQuestions: [
      ['Adicionar vermelho?', 'red'],
      ['Adicionar verde?', 'green'],
      ['Adicionar azul?', 'blue'],
      ['Finalmente, deseja ativar o debug avançado?', 'debug'],
    ],
  );

  final answers = dialog.ask();

  final red = answers['red'] ? 1.0 : -1.0;
  final green = answers['green'] ? 1.0 : -1.0;
  final blue = answers['blue'] ? 1.0 : -1.0;
  final debug = answers['debug'];

  print('\nA cor gerada foi: ' +
      getColor(network.evaluate(
        [red, green, blue],
        isDebug: debug,
      )));
}

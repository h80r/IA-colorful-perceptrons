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
      [
        'Iremos agora selecionar as cores que serão misturadas, insira valores '
            'entre 0 e 255, por favor.',
        'start',
      ],
    ],
    questions: [
      ['Digite o valor para a cor vermelha: ', 'red'],
      ['Digite o valor para a cor verde: ', 'green'],
      ['Digite o valor para a cor azul: ', 'blue'],
    ],
    booleanQuestions: [
      ['Finalmente, deseja ativar o debug avançado?', 'debug'],
    ],
  );

  final answers = dialog.ask();

  final red = int.tryParse(answers['red']);
  final green = int.tryParse(answers['green']);
  final blue = int.tryParse(answers['blue']);
  final debug = answers['debug'];

  if (red == null || green == null || blue == null) {
    print('Por favor, insira valores válidos.');
    return main(arguments);
  } else if (red < 0 ||
      red > 255 ||
      green < 0 ||
      green > 255 ||
      blue < 0 ||
      blue > 255) {
    print('Por favor, insira valores entre 0 e 255.');
    return main(arguments);
  } else {
    print('\nA cor gerada foi: ' +
        getColor(network.evaluate(
          [normalizeHex(red), normalizeHex(green), normalizeHex(blue)],
          isDebug: debug,
        )));
  }
}

import 'package:cli_dialog/cli_dialog.dart';

import 'perceptron.dart';
import 'utils.dart';

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

List<double> userInterface() {
  print(
    'Iremos agora selecionar as cores que serão misturadas,'
    ' insira valores entre 0 e 255, por favor.',
  );

  final colors = CLI_Dialog(
    questions: [
      ['Digite o valor para a cor vermelha: ', 'red'],
      ['Digite o valor para a cor verde: ', 'green'],
      ['Digite o valor para a cor azul: ', 'blue'],
    ],
  ).ask().values.map((e) => int.tryParse(e));

  if (colors.any((e) => e == null)) {
    print('Por favor, insira valores válidos.');
    return userInterface();
  } else if (colors.any((e) => e! < 0 || e > 255)) {
    print('Por favor, insira valores entre 0 e 255.');
    return userInterface();
  }

  return [for (var x in colors) normalizeHex(x!)];
}

void interactionLoop(Perceptron trainedPerceptron) {
  final colors = userInterface();

  final isDebug = CLI_Dialog(booleanQuestions: [
    ['Você deseja ativar o debug avançado?', 'debug'],
  ]).ask().values.first as bool;

  print('A cor inserida foi: ' +
      getColor(trainedPerceptron.evaluate(colors, isDebug: isDebug)));

  (CLI_Dialog(booleanQuestions: [
    ['Deseja tentar outra cor?', 'continue'],
  ]).ask().values.first as bool)
      ? interactionLoop(trainedPerceptron)
      : null;
}

void main(List<String> arguments) {
  print('Bem vindo ao ColorfulPerceptrons!');

  final perceptron = Perceptron(
    inputSize: 3,
    neuronCount: 8,
  );

  print('Iremos agora efetuar o treinamento da rede neural...');

  final stopwatch = Stopwatch()..start();
  perceptron.train(trainingData, expectedOutput);
  stopwatch.stop();

  print('Treinamento concluído em ' +
      stopwatch.elapsedMilliseconds.toString() +
      'ms!');

  interactionLoop(perceptron);
}

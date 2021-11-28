import 'dart:math';

extension Zipper on List<double> {
  List<List<double>> zip(List<double> other) {
    return List.generate(
      min(length, other.length),
      (index) => [this[index], other[index]],
    );
  }

  bool isEquals(List<double> other) {
    if (length != other.length) return false;
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}

extension Equalizer on List<List<double>> {
  bool isEquals(List<List<double>> other) {
    if (length != other.length) return false;
    for (var i = 0; i < length; i++) {
      if (!this[i].isEquals(other[i])) return false;
    }
    return true;
  }
}

String getColor(List<double> output) {
  final index = output.indexOf(1);
  return [
    'Vermelho',
    'Verde',
    'Azul',
    'Preto',
    'Branco',
    'Amarelo',
    'Magenta',
    'Ciano'
  ][index];
}

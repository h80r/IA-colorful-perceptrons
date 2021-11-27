import 'dart:math';

extension Zipper on List {
  List<List<T>> zip<T>(List<T> other) {
    return List.generate(
      min(length, other.length),
      (index) => [this[index], other[index]],
    );
  }
}

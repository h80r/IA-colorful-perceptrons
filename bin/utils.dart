import 'dart:math';

extension Zipper on List {
  List<List<T>> zip<T>(List<T> other) {
    return List.generate(
      min(length, other.length),
      (index) => [this[index], other[index]],
    );
  }

  bool isEquals(List other) {
    if (length != other.length) return false;
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}

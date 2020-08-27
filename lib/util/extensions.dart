extension Getter<T> on List<T> {
  T getOrNull(int index, {bool keepDash = false}) {
    try {
      var text = this[index];
      if (!keepDash && text == '-') {
        return null;
      }
      return this[index];
    } catch (e) {
      return null;
    }
  }
}

extension ToInt on String {
  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return null;
    }
  }
}

extension ToDouble on String {
  double toDouble() {
    try {
      return double.parse(this);
    } catch (e) {
      return null;
    }
  }
}

extension IsNullOrEmpty on String {
  bool isNullOrEmpty() {
    return this == null || this.isEmpty;
  }
}

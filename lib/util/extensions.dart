extension ListHelpers<T> on List<T> {
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

  bool isNullOrEmpty() {
    return this == null || this.isEmpty;
  }
}

extension StringHelpers on String {
  bool isNullOrEmpty() {
    return this == null || this.isEmpty;
  }

  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return null;
    }
  }

  double toDouble() {
    try {
      return double.parse(this);
    } catch (e) {
      return null;
    }
  }
}

import 'package:rentoptions/util/extensions.dart';

class Status {
  final String name;
  String notes;
  String color;

  Status({this.name, this.notes, this.color});

  static fromValues({String name, String notes, String color}) {
    if (!name.isNullOrEmpty()) {
      return Status(name: name, notes: notes, color: color);
    }
    return null;
  }
}

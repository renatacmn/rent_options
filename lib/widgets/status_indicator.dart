import 'package:flutter/material.dart';
import 'package:rentoptions/models/status.dart';
import 'package:rentoptions/util/extensions.dart';

class StatusIndicator extends StatelessWidget {
  final Status status;

  const StatusIndicator({@required this.status});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(
        status.name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];

    if (!status.notes.isNullOrEmpty()) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            status.notes,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: status.color.isNotEmpty
            ? Color(int.parse(status.color))
            : Colors.teal,
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

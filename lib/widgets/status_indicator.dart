import 'package:flutter/material.dart';
import 'package:rentoptions/models/status.dart';

class StatusIndicator extends StatelessWidget {
  final Status status;

  const StatusIndicator({@required this.status});

  @override
  Widget build(BuildContext context) {
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
      child: Text(
        status.name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

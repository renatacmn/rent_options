import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String status;

  const StatusIndicator({@required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.teal,
      ),
      child: Text(
        status,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

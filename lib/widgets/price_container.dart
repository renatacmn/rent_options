import 'package:flutter/material.dart';

class PriceContainer extends StatelessWidget {
  final Widget child;

  const PriceContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.deepPurple,
      ),
      child: child,
    );
  }
}

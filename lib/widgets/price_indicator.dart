import 'package:flutter/material.dart';
import 'package:rentoptions/util/styles.dart';

class PriceIndicator extends StatelessWidget {
  final String price;

  const PriceIndicator({@required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Styles.getAccentColor(),
      ),
      child: Text(
        price,
        style: Theme.of(context).textTheme.subtitle2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

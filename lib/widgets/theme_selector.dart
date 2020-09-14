import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeSelector extends StatelessWidget {
  final Gradient gradient;
  final bool isSelected;
  final Function onSelected;

  const ThemeSelector({this.gradient, this.isSelected, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected ? Theme.of(context).accentColor : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}

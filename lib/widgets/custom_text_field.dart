import 'package:flutter/material.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final TextEditingController controller;

  const CustomTextFieldWithLabel(
      {this.label, this.isEnabled = true, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        TextField(
          controller: controller,
          enabled: isEnabled,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          maxLines: null,
          decoration: InputDecoration(
            filled: isEnabled,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey.withAlpha(50),
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

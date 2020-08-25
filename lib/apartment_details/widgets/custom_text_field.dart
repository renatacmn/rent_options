import 'package:flutter/material.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomTextFieldWithLabel({this.label, this.controller});

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
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          maxLines: null,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey.withAlpha(50),
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

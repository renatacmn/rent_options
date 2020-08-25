import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void showShortToast(BuildContext context, String message) {
  Toast.show(
    message,
    context,
    duration: Toast.LENGTH_SHORT,
  );
}

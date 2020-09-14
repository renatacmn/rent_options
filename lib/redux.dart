import 'package:flutter/material.dart';

class AppState {
  AppState({@required this.selectedStyle});

  int selectedStyle;
}

class UpdateStyle {
  UpdateStyle({@required this.selectedStyle});

  final int selectedStyle;
}

AppState reducer(AppState state, dynamic action) {
  if (action is UpdateStyle) {
    return AppState(
      selectedStyle: action.selectedStyle,
    );
  }

  return state;
}

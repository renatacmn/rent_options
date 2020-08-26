import 'package:flutter/cupertino.dart';

class Styles {
  static const backgroundGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.2, 0.7],
    colors: [
      Color(0xff78cabc),
      Color(0xffdacce8),
    ],
  );

  static const backgroundImage = DecorationImage(
    image: AssetImage('assets/background.jpg'),
    fit: BoxFit.cover,
  );
}

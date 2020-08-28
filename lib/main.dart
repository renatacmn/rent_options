import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/apartment_list/apartment_list_page.dart';

bool demoVersion = false;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent Options',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Color(0xff78cabc),
        accentColor: Colors.deepPurple,
        appBarTheme: AppBarTheme.of(context).copyWith(
          brightness: Brightness.dark,
          iconTheme: IconTheme.of(context).copyWith(
            color: Colors.white,
          ),
          textTheme: TextTheme(
            headline6: GoogleFonts.quicksandTextTheme().headline6.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        textTheme: GoogleFonts.quicksandTextTheme(),
        tabBarTheme: Theme.of(context).tabBarTheme.copyWith(
              labelStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
              unselectedLabelStyle: GoogleFonts.quicksand(),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.teal,
            ),
      ),
      home: ApartmentListPage(),
    );
  }
}

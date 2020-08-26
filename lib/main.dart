import 'package:flutter/material.dart';
import 'package:rentoptions/apartment_list/apartment_list_page.dart';

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
        appBarTheme: AppBarTheme.of(context).copyWith(
          brightness: Brightness.dark,
          iconTheme: IconTheme.of(context).copyWith(
            color: Colors.white,
          ),
          textTheme: TextTheme(
            headline6: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
      home: ApartmentListPage(),
    );
  }
}

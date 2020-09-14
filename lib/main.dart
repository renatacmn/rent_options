import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:rentoptions/redux.dart';
import 'package:rentoptions/util/styles.dart';

import 'features/apartment_list/apartment_list_page.dart';

bool demoVersion = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Styles.init();

  final store = Store<AppState>(
    reducer,
    distinct: true,
    initialState: AppState(
      selectedStyle: Styles.currentStyleNumber,
    ),
  );

  runApp(
    StoreProvider<AppState>(
      store: store,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      distinct: true,
      converter: (store) => store.state.selectedStyle,
      builder: (_, int selectedStyle) {
        return MaterialApp(
          title: 'Rent Options',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Styles.getPrimaryColor(styleNumber: selectedStyle),
            accentColor: Styles.getAccentColor(styleNumber: selectedStyle),
            iconTheme: IconTheme.of(context).copyWith(
              color: Styles.getAccentColor(styleNumber: selectedStyle),
            ),
            appBarTheme: AppBarTheme.of(context).copyWith(
              brightness: Brightness.dark,
              textTheme: TextTheme(
                headline6: GoogleFonts.lora().copyWith(
                  color: Styles.getColorOnPrimary(styleNumber: selectedStyle),
                  fontSize: 20,
                ),
              ),
              iconTheme: IconTheme.of(context).copyWith(
                color: Styles.getColorOnPrimary(styleNumber: selectedStyle),
              ),
              actionsIconTheme: IconTheme.of(context).copyWith(
                color: Styles.getColorOnPrimary(styleNumber: selectedStyle),
              ),
            ),
            textTheme: GoogleFonts.quicksandTextTheme(),
            tabBarTheme: Theme.of(context).tabBarTheme.copyWith(
                  labelStyle:
                      GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: GoogleFonts.quicksand(),
                  labelColor:
                      Styles.getColorOnPrimary(styleNumber: selectedStyle),
                  unselectedLabelColor: Styles.getTabBarUnselectedItemColor(
                      styleNumber: selectedStyle),
                ),
          ),
          home: ApartmentListPage(),
        );
      },
    );
  }
}

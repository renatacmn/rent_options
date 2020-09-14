import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:rentoptions/redux.dart';
import 'package:rentoptions/util/shared_prefs_util.dart';
import 'package:rentoptions/util/styles.dart';
import 'package:rentoptions/widgets/theme_selector.dart';
import 'package:rentoptions/widgets/translucent_card.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _selectStyle(Store store, int index) {
    SharedPrefsUtil.instance.saveChosenStyle(index);
    store.dispatch(UpdateStyle(selectedStyle: index));
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
      builder: (BuildContext context, Store<AppState> store) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: Styles.getBackgroundGradient(),
            ),
            child: _buildThemeConfiguration(store, store.state.selectedStyle),
          ),
        );
      },
    );
  }

  Widget _buildThemeConfiguration(Store store, int selectedStyle) {
    return TranslucentCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Theme',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: _buildThemeSelectors(store, selectedStyle),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildThemeSelectors(Store store, int selectedStyle) {
    List<Widget> list = [];
    for (int i = 0; i < Styles.numStyles; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.all(4),
          child: ThemeSelector(
            gradient: Styles.getBackgroundGradient(styleNumber: i),
            isSelected: i == selectedStyle,
            onSelected: () => _selectStyle(store, i),
          ),
        ),
      );
    }
    return list;
  }
}

import 'package:flutter/material.dart';
import 'package:rentoptions/apartment_details/widgets/custom_text_field.dart';
import 'package:rentoptions/apartment_list/widgets/apartment_list_item.dart';
import 'package:rentoptions/data/spreadsheet_manager.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/util/toast_util.dart';
import 'package:rentoptions/util/url_util.dart';

class ApartmentDetailsPage extends StatefulWidget {
  final Apartment apartment;

  const ApartmentDetailsPage({this.apartment});

  @override
  _ApartmentDetailsPageState createState() =>
      _ApartmentDetailsPageState(apartment.listOrder + 1);
}

class _ApartmentDetailsPageState extends State<ApartmentDetailsPage> {
  final int _rowNumber;

  List<String> sections = [];
  List<String> currentData = [];
  List<TextEditingController> controllers = [];
  bool _showLoadingProgressIndicator = true;
  bool _showSavingProgressIndicator = false;

  _ApartmentDetailsPageState(this._rowNumber);

  void _saveData() async {
    setState(() => _showSavingProgressIndicator = true);
    List<String> data = [];
    controllers.forEach((controller) => data.add(controller.text));
    await SpreadsheetManager.instance.saveNotesDataInRow(_rowNumber, data);
    setState(() => _showSavingProgressIndicator = false);
    showShortToast(context, 'Saved!');
  }

  @override
  void initState() {
    super.initState();
    _initForm();
  }

  Future _initForm() async {
    setState(() => _showLoadingProgressIndicator = true);
    await _initSections();
    await _initCurrentData();
    _initControllers();
    print('Form initialized!');
    setState(() => _showLoadingProgressIndicator = false);
  }

  Future _initSections() async {
    print('Initializing form sections...');
    sections = await SpreadsheetManager.instance.fetchNotesSections();
    print(sections);
  }

  Future _initCurrentData() async {
    print('Fetching current data...');
    currentData =
        await SpreadsheetManager.instance.fetchNotesDataFromRow(_rowNumber);
    print(currentData);
  }

  void _initControllers() {
    print('Initializing controllers...');
    for (int i = 0; i < sections.length; i++) {
      var controller = TextEditingController();
      try {
        controller.text = currentData[i];
      } finally {
        controllers.add(controller);
      }
    }
  }

  @override
  void dispose() {
    controllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.apartment.address),
        actions: [
          IconButton(
            icon: Icon(Icons.open_in_new),
            onPressed: () => openUrl(context, widget.apartment.url),
          ),
        ],
      ),
      body: _showLoadingProgressIndicator
          ? Center(child: CircularProgressIndicator())
          : _buildForm(),
    );
  }

  Widget _buildForm() {
    List<Widget> children = [
      ApartmentListItem(apartment: widget.apartment),
      SizedBox(height: 24),
    ];

    for (int i = 0; i < sections.length; i++) {
      children.add(CustomTextFieldWithLabel(
        label: sections[i],
        controller: controllers[i],
      ));
    }

    children.add(_buildButton());

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      height: 50,
      width: double.infinity,
      child: RaisedButton(
        child: _showSavingProgressIndicator
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
        color: Colors.teal,
        onPressed: _saveData,
      ),
    );
  }
}

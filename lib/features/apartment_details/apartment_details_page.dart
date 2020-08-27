import 'package:flutter/material.dart';
import 'package:rentoptions/data/repository.dart';
import 'package:rentoptions/main.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/util/styles.dart';
import 'package:rentoptions/util/toast_util.dart';
import 'package:rentoptions/widgets/apartment_info.dart';
import 'package:rentoptions/widgets/custom_text_field.dart';
import 'package:rentoptions/widgets/image_carousel.dart';
import 'package:rentoptions/widgets/translucent_card.dart';

class ApartmentDetailsPage extends StatefulWidget {
  final Apartment apartment;

  const ApartmentDetailsPage({@required this.apartment});

  @override
  _ApartmentDetailsPageState createState() =>
      _ApartmentDetailsPageState(apartment.listOrder + 1);
}

class _ApartmentDetailsPageState extends State<ApartmentDetailsPage> {
  final Repository _repository = Repository.instance;
  final int _rowNumber;

  List<String> _sections = [];
  List<String> _currentData = [];
  List<TextEditingController> _controllers = [];

  bool _showLoadingProgressIndicator = true;
  bool _showSavingProgressIndicator = false;
  bool _isInEditMode = false;

  Future<List<String>> _futureHomeImages;

  _ApartmentDetailsPageState(this._rowNumber);

  void _onSavePressed() async {
    if (demoVersion) {
      _showDemoDialog();
    } else {
      _saveData();
    }
  }

  void _showDemoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Demo version'),
          content:
              Text('This is a demo version, the changes will not be saved. ;)'),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    ).then((value) => _setReadOnlyMode());
  }

  void _saveData() async {
    setState(() => _showSavingProgressIndicator = true);

    List<String> data = [];
    _controllers.forEach((controller) => data.add(controller.text));
    await _repository.saveNotesDataInRow(_rowNumber, data);

    _setReadOnlyMode();
    showShortToast(context, 'Saved!');
  }

  void _setReadOnlyMode() {
    setState(() {
      _showSavingProgressIndicator = false;
      _isInEditMode = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initForm();
    _fetchPictures();
  }

  Future _initForm() async {
    print('Initializing form...');
    setState(() => _showLoadingProgressIndicator = true);
    await _initSections();
    await _initCurrentData();
    _initControllers();
    print('Form initialized!');
    setState(() => _showLoadingProgressIndicator = false);
  }

  void _fetchPictures() {
    _futureHomeImages = _repository.fetchApartmentImages(widget.apartment.id);
  }

  Future _initSections() async {
    print('Initializing form sections...');
    _sections = await _repository.fetchNotesSections();
  }

  Future _initCurrentData() async {
    print('Fetching current data...');
    _currentData = await _repository.fetchNotesDataFromRow(_rowNumber);
  }

  void _initControllers() {
    print('Initializing controllers...');
    for (int i = 0; i < _sections.length; i++) {
      var controller = TextEditingController();
      try {
        controller.text = _currentData[i];
      } catch (e) {
        // No op
      } finally {
        _controllers.add(controller);
      }
    }
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget appBarAction;
    if (_isInEditMode) {
      appBarAction = IconButton(
        icon: Icon(Icons.save_alt),
        onPressed: _onSavePressed,
      );
    } else {
      appBarAction = IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          setState(() => _isInEditMode = true);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.apartment.address),
        actions: [appBarAction],
      ),
      body: _showLoadingProgressIndicator
          ? Center(child: CircularProgressIndicator())
          : _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: Styles.backgroundGradient,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: TranslucentCard(child: _buildContent()),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          _buildCarousel(),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: _getFormChildren(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return FutureBuilder(
        future: _futureHomeImages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ImageCarousel(imageUrls: snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  List<Widget> _getFormChildren() {
    List<Widget> children = [
      ApartmentInfo(apartment: widget.apartment),
      SizedBox(height: 24),
      Divider(color: Colors.deepPurple),
    ];

    for (int i = 0; i < _sections.length; i++) {
      children.add(CustomTextFieldWithLabel(
        label: _sections[i],
        isEnabled: _isInEditMode,
        controller: _controllers[i],
      ));
    }

    if (_isInEditMode) {
      children.add(_buildButton());
    }

    return children;
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
        onPressed: _onSavePressed,
      ),
    );
  }
}

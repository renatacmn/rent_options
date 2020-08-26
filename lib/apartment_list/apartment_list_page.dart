import 'package:flutter/material.dart';
import 'package:rentoptions/apartment_list/widgets/apartment_list_item.dart';
import 'package:rentoptions/data/spreadsheet_manager.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/util/toast_util.dart';

class ApartmentListPage extends StatefulWidget {
  @override
  _ApartmentListPageState createState() => _ApartmentListPageState();
}

class _ApartmentListPageState extends State<ApartmentListPage> {
  List<Apartment> _apartmentList = [];
  bool _loading = true;

  void _showFilterOptions(BuildContext context) {
    showShortToast(context, 'Filter');
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future _initData() async {
    await SpreadsheetManager.instance.initSpreadsheet();
    _apartmentList = await SpreadsheetManager.instance.fetchApartmentList();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Rent Options'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () => _showFilterOptions(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.2, 0.8],
            colors: [
              Color(0xff78cabc),
              Color(0xff6bb4a7),
            ],
          ),
        ),
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _apartmentList.length,
      itemBuilder: (context, position) =>
          ApartmentListItem(apartment: _apartmentList[position]),
    );
  }
}

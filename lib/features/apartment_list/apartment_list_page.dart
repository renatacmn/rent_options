import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:rentoptions/data/repository.dart';
import 'package:rentoptions/features/apartment_list/list_for_mobile.dart';
import 'package:rentoptions/features/apartment_list/list_for_web.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/models/status.dart';
import 'package:rentoptions/util/styles.dart';
import 'package:rentoptions/util/toast_util.dart';

class ApartmentListPage extends StatefulWidget {
  @override
  _ApartmentListPageState createState() => _ApartmentListPageState();
}

class _ApartmentListPageState extends State<ApartmentListPage> {
  final Repository _repository = Repository.instance;
  List<Status> _statusList = [];
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
    await _repository.init();
    await _loadData();
    setState(() => _loading = false);
  }

  Future _loadData() async {
    var statusList = await _repository.fetchStatusList();
    var apartmentList = await _repository.fetchApartmentList();
    setState(() {
      _statusList = statusList;
      _apartmentList = apartmentList;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [Tab(text: 'All')];
    tabs.addAll(_statusList.map((status) => Tab(text: status.name)).toList());

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Rent Options'),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list, color: Colors.white),
              onPressed: () => _showFilterOptions(context),
            ),
          ],
          bottom: TabBar(
            tabs: tabs,
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: tabs.map((tab) => _buildBody(tab.text)).toList(),
        ),
      ),
    );
  }

  Widget _buildBody(String statusName) {
    return RefreshIndicator(
      onRefresh: () {
        _repository.reset();
        return _loadData();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: Styles.backgroundGradient,
        ),
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : _buildListView(statusName),
      ),
    );
  }

  Widget _buildListView(String statusName) {
    var filteredApartmentList = [];
    if (statusName == 'All') {
      filteredApartmentList = _apartmentList;
    } else {
      filteredApartmentList = _apartmentList.where((apartment) {
        return apartment.status?.name == statusName;
      }).toList();
    }

    if (filteredApartmentList.isEmpty) {
      return _buildEmptyState();
    } else {
      if (kIsWeb) {
        return ApartmentListForWeb(apartmentList: filteredApartmentList);
      } else {
        return ApartmentListForMobile(apartmentList: filteredApartmentList);
      }
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No apartments in this category',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

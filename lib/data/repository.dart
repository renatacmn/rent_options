import 'package:rentoptions/data/network/requests.dart';
import 'package:rentoptions/data/spreadsheet/spreadsheet_manager.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/models/status.dart';

class Repository {
  List<Status> _statusList;
  List<Apartment> _apartmentList;
  List<String> _notesSections;
  Map<int, List<String>> _notesMap = Map();
  Map<String, List<String>> _imagesMap = Map();

  static final Repository _instance = Repository._privateConstructor();

  static Repository get instance => _instance;

  Repository._privateConstructor();

  void reset() {
    _statusList = null;
    _apartmentList = null;
    _notesSections = null;
    _notesMap = Map();
    _imagesMap = Map();
  }

  Future init() async {
    await SpreadsheetManager.instance.initSpreadsheet();
  }

  Future<List<Status>> fetchStatusList() async {
    if (_statusList == null) {
      _statusList = await SpreadsheetManager.instance.fetchStatusList();
    }
    return _statusList;
  }

  Future<List<Apartment>> fetchApartmentList() async {
    if (_apartmentList == null) {
      _apartmentList = await SpreadsheetManager.instance.fetchApartmentList();
      _setApartmentStatusColor();
    }
    return _apartmentList;
  }

  Future<List<String>> fetchNotesSections() async {
    if (_notesSections == null) {
      _notesSections = await SpreadsheetManager.instance.fetchNotesSections();
    }
    return _notesSections;
  }

  Future<List<String>> fetchNotesDataFromRow(int row) async {
    if (!_notesMap.containsKey(row)) {
      var notes = await SpreadsheetManager.instance.fetchNotesDataFromRow(row);
      _notesMap[row] = notes;
    }
    return _notesMap[row];
  }

  Future saveNotesDataInRow(int rowNumber, List<String> row) async {
    _notesMap[rowNumber] = row;
    await SpreadsheetManager.instance.saveNotesDataInRow(rowNumber, row);
  }

  Future<List<String>> fetchApartmentImages(String id) async {
    if (!_imagesMap.containsKey(id)) {
      var images = await Network.fetchApartmentImages(id);
      print(images);
      _imagesMap[id] = images;
    }
    return Future.value(_imagesMap[id]);
  }

  void _setApartmentStatusColor() {
    if (_apartmentList?.isNotEmpty == true && _statusList?.isNotEmpty == true) {
      _apartmentList.forEach((apartment) {
        var foundStatus = _statusList
            .firstWhere((status) => status?.name == apartment?.status?.name);
        if (foundStatus != null) {
          apartment.status.color = foundStatus.color;
        }
      });
    }
  }
}

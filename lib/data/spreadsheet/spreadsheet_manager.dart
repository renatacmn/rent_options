import 'package:gsheets/gsheets.dart';
import 'package:rentoptions/data/spreadsheet/google_api_credentials.dart';
import 'package:rentoptions/models/apartment.dart';
import 'package:rentoptions/models/status.dart';

const _spreadsheetId = '1irQHqJNH7G--zEWCS3s_CuRpYdtcHHwGj2DbKMnefk0';

class SpreadsheetManager {
  Spreadsheet _spreadsheet;

  static final SpreadsheetManager _instance =
      SpreadsheetManager._privateConstructor();

  static SpreadsheetManager get instance => _instance;

  SpreadsheetManager._privateConstructor();

  Future initSpreadsheet() async {
    final gSheets = GSheets(credentials);
    _spreadsheet = await gSheets.spreadsheet(_spreadsheetId);
  }

  Future<List<Status>> fetchStatusList() async {
    var worksheet = _spreadsheet.worksheetByTitle('Status');
    var rows = await worksheet.values.allRows();
    return rows.map((row) {
      return Status(name: row[0], color: row[1]);
    }).toList();
  }

  Future<List<Apartment>> fetchApartmentList() async {
    var worksheet = _spreadsheet.worksheetByTitle('Apartments');
    var rows = await worksheet.values.allRows();
    rows.removeAt(0); // Remove headers
    return rows
        .map((row) => Apartment.fromRow(row))
        .where((apartment) => apartment != null)
        .toList();
  }

  Future<List<String>> fetchNotesSections() async {
    var worksheet = _spreadsheet.worksheetByTitle('Notes');
    return await worksheet.values.row(1);
  }

  Future<List<String>> fetchNotesDataFromRow(int row) async {
    var worksheet = _spreadsheet.worksheetByTitle('Notes');
    return await worksheet.values.row(row);
  }

  Future saveNotesDataInRow(int rowNumber, List<String> row) async {
    var worksheet = _spreadsheet.worksheetByTitle('Notes');
    await worksheet.values.insertRow(rowNumber, row);
  }
}

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import "package:path_provider/path_provider.dart";
import 'package:note_maker/models/notes.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable = "notes";
  String colId = "id";
  String colTitle = "title";
  String colContent = "content";
  String colRemindMe = "remindMe";
  String colRemindTime = "remindTime";
  String colCreatedTime = "createdTime";
  String colUpdatedTime = "updatedTime";

  DatabaseHelper._createDataBase(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createDataBase();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "notes.db";

    var notesDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, "
            " $colContent TEXT, $colRemindMe INTEGER, $colRemindTime TEXT, $colRemindTime TEXT, "
                "$colCreatedTime TEXT, $colUpdatedTime TEXT )");
  }

  Future<List<Map<String, dynamic>>> getNoteMapList({String option = "created", String order="asc"}) async{
    Database db = await this.database;
    var result;
    switch(option){
      case "updated":
        switch(order){
          case "desc":
            result = await db.rawQuery(
                "SELECT * FROM $noteTable ORDER BY $colUpdatedTime DESC");
            break;
          default:
            result = await db.rawQuery(
                "SELECT * FROM $noteTable ORDER BY $colUpdatedTime ASC");
            break;
        }
        break;
      default:
        switch(order) {
          case "desc":
            result = await db.rawQuery(
                "SELECT * FROM $noteTable ORDER BY $colCreatedTime DESC");
            break;
          default:
            result = await db.rawQuery(
                "SELECT * FROM $noteTable ORDER BY $colCreatedTime ASC");
            break;
        }
        break;
    }
    return result;
  }
}

import 'package:note_maker/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import "package:path_provider/path_provider.dart";
import 'package:note_maker/models/notes.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable = "notes";
  String categoryTable = "categories";
  String colId = "id";
  String colTitle = "title";
  String colContent = "content";
  String colRemindMe = "remindMe";
  String colRemindTime = "remindTime";
  String colCreatedTime = "createdTime";
  String colUpdatedTime = "updatedTime";
  String colCategory = "category";
  String colName = "name";
  String colColor = "color";

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
        " $colContent TEXT, $colRemindMe INTEGER, $colRemindTime TEXT, "
        "$colCreatedTime TEXT, $colUpdatedTime TEXT, $colCategory INTEGER )");
    await db.execute(
        "CREATE TABLE $categoryTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colColor TEXT)");
  }

  Future<List<Map<String, dynamic>>> getNoteMapList(
      {String option = "created", String order = "asc"}) async {
    Database db = await this.database;
    var result;
    switch (option) {
      case "updated":
        switch (order) {
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
        switch (order) {
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

  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: "$colId = ?", whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete("DELETE FROM $noteTable WHERE $colId = $id");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery("SELECT COUNT(*) FROM $noteTable");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList(
      {String option = "created", String order = "asc"}) async {
    var noteMapList = await getNoteMapList(option: option, order: order);
    int count = noteMapList.length;
    List<Note> noteList = List<Note>();
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

  Future<List<Map<String, dynamic>>> getCategoryMapList() async{
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $categoryTable");
    return result;
  }

  Future<int> insertCategory(Category category) async {
    Database db = await this.database;
    var result = await db.insert(categoryTable, category.toMap());
    return result;
  }

  Future<int> updateCategory(Category category) async {
    var db = await this.database;
    var result = await db.update(categoryTable, category.toMap(),
        where: "$colId = ?", whereArgs: [category.id]);
    return result;
  }

  Future<int> deleteCategory(int id) async {
    var db = await this.database;
    int result =
    await db.rawDelete("DELETE FROM $categoryTable WHERE $colId = $id");
    return result;
  }

  Future<List<Category>> getCategoryList() async {
    var categoryMapList = await getCategoryMapList();
    int count = categoryMapList.length;
    List<Category> categoryList = List<Category>();
    for (int i = 0; i < count; i++) {
      categoryList.add(Category.fromMapObject(categoryMapList[i]));
    }
    return categoryList;
  }
}

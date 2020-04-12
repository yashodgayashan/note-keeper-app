import 'package:flutter/material.dart';
import 'package:note_maker/utils/database_helper.dart';
import 'package:note_maker/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Maker"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[Text("Add list of items Here")],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Button clicked");
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}

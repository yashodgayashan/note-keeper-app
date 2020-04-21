import 'package:flutter/material.dart';
import 'package:note_maker/utils/database_helper.dart';
import 'package:note_maker/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:note_maker/screens/notes_detail.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Note Maker"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () => _scaffoldKey.currentState.openEndDrawer())
        ],
      ),
      endDrawer: getEndDrawer(width),
      drawer: getDrawer(width),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Text("Add list of items Here"),
          Text("Add list of items Here")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          debugPrint("Button clicked");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NoteDatails();
          }));
        },
      ),
    );
  }

  Widget getEndDrawer(double width){
    return SafeArea(
      child: Container(
        width: width / 2,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text('Header'),
              ),
              ListTile(
                title: Text('First Menu Item'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Second Menu Item'),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('About'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDrawer(double width){
    return SafeArea(
      child: Container(
        width: width / 2,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text('Header'),
              ),
              ListTile(
                title: Text('First Menu Item'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Second Menu Item'),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('About'),
                onTap: () {},
              ),
            ],
          ),
        ),
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

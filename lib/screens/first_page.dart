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
      appBar: getAppBar(),
      endDrawer: getEndDrawer(width),
      drawer: getDrawer(width),
      body: getBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: getFloatingActionButton(),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  Widget getBody() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        getListItem(title: "Note one", color: Colors.green),
        getListItem(title: "Note two", color: Colors.yellow)
      ],
    );
  }

  Widget getListItem({
    String title,
    Color color,
  }) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.all(
            Radius.circular(10.0) //         <--- border radius here
            ),
      ),
      child: ListTile(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.book),
          color: color,
          onPressed: () {
            debugPrint("$title clicked");
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline),
          color: Colors.red,
          onPressed: () {
            debugPrint("$title deleted");
          },
        ),
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: Text("Note Maker"),
      leading: getAppBarLeadingIcon(),
      actions: <Widget>[getAppBarEndIcon()],
    );
  }

  Widget getAppBarLeadingIcon() {
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () => _scaffoldKey.currentState.openDrawer(),
    );
  }

  Widget getAppBarEndIcon() {
    return IconButton(
        icon: Icon(Icons.filter_list),
        onPressed: () => _scaffoldKey.currentState.openEndDrawer());
  }

  Widget getEndDrawer(double width) {
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

  Widget getDrawer(double width) {
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

  Widget getBottomNavigationBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: TextFormField(
            decoration: InputDecoration(
                labelText: "Search", prefixIcon: Icon(Icons.search)),
          ))
        ],
      ),
    );
  }

  Widget getFloatingActionButton() {
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          debugPrint("Button clicked");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NoteDatails();
          }));
        });
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

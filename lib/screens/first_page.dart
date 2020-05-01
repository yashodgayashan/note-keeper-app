import 'package:flutter/material.dart';
import 'package:note_maker/utils/database_helper.dart';
import 'package:note_maker/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:note_maker/screens/notes_detail.dart';
import 'package:note_maker/screens/search_page.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  bool isSwitchedDark = false;

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
        getListItem(title: "Note one", color: Colors.green, date: "2020-04-17"),
        getListItem(title: "Note two", color: Colors.yellow, date: "2020-04-19")
      ],
    );
  }

  Widget getListItem({String title, Color color, String date}) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(
            Radius.circular(10.0) //         <--- border radius here
            ),
      ),
      child: ListTile(
        title: Align(
          child: Text(title),
          alignment: Alignment(-1.2, 0),
        ),
        subtitle: Align(
          child: Text("Date : $date"),
          alignment: Alignment(-1.27, 0),
        ),
        leading: IconButton(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(0.0),
          icon: Icon(Icons.book),
          color: color,
          onPressed: () {
            debugPrint("$title clicked");
          },
        ),
        trailing: IconButton(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(0.0),
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
        icon: Icon(Icons.settings),
        onPressed: () => _scaffoldKey.currentState.openEndDrawer());
  }

  Widget getEndDrawer(double width) {
    return SafeArea(
      child: Container(
        width: width / 2,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 20.0,top: 10.0,bottom: 10.0),
                child: Text('Sort by',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                    ),
                ),
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: 1,
                    onChanged: (val) {
                      print('Radio : $val');
                    },
                  ),
                  Text('Date created'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 2,
                    groupValue: 1,
                    onChanged: (val) {
                      print('Radio : $val');
                    },
                  ),
                  Text('Date modified'),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 20.0,top: 10.0,bottom: 10.0),
                child: Text('Dark theme',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                child: Row(
                  children: <Widget>[
                    Text('Enable'),
                    Spacer(),
                    Switch(
                      value: isSwitchedDark,
                      onChanged: (value) {
                        setState(() {
                          isSwitchedDark = value;
                          print(isSwitchedDark);
                        });
                      },
                      activeTrackColor: Colors.lightBlueAccent,
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
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
        width: (3 * width) / 4,
        child: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              getLeftDrawerHeader(),
              Container(
                height: 100.0,
                child: ListView(
                  children: <Widget>[
                    getLeftDrawerListTile(
                        title: "First label", color: Colors.yellow),
                    getLeftDrawerListTile(
                        title: "Secont label", color: Colors.blue),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: () {
                      debugPrint("add");
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getLeftDrawerHeader() {
    return DrawerHeader(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                'Labels',
                textScaleFactor: 1.5,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Align(
            child: Container(
              child: Text(
                "Organize your notes with labels \nIt is super easy with note maker "
                "\nMake your notes and labels them \nCategorize your notes with labels "
                "\nEasy to manage, search and organize  ",
                style: TextStyle(fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );
  }

  Widget getLeftDrawerListTile(
      {@required String title, @required Color color}) {
    return ListTile(
      leading: Icon(
        Icons.book,
        color: color,
      ),
      title: Text("$title"),
      trailing: Icon(Icons.more_horiz),
      onTap: () {
        debugPrint("$title is pressed");
      },
    );
  }

  Widget getBottomNavigationBar() {
    return BottomAppBar(
      color: Colors.grey[300],
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Search();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0), //
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Search",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: 40,
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 80.0, 5.0),
              ),
            ),
          )
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

import 'package:flutter/material.dart';
import 'package:note_maker/utils/notes.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
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
}


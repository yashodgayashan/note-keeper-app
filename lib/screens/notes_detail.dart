import 'package:flutter/material.dart';

class NoteDatails extends StatefulWidget {
  @override
  _NoteDatailsState createState() => _NoteDatailsState();
}

class _NoteDatailsState extends State<NoteDatails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note title"),
      ),
      body: Text("Hi"),
    );
  }
}

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
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.0),
                height: 40.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: 50.0,
                      color: Colors.black12,
                      child: Icon(Icons.keyboard),
                    ),
                    Container(
                      width: 50.0,
                      color: Colors.black38,
                      child: Icon(Icons.brush),
                    ),
                    Container(
                      width: 50.0,
                      color: Colors.black12,
                      child: Icon(Icons.gesture),
                    ),
                    Container(
                      width: 170.0,
                      color: Colors.black38,
                      child: Text("Save"),
                    ),
                    Container(
                      width: 20.0,
                      color: Colors.black12,
                      child: Icon(Icons.attach_file),
                    ),
                    Container(
                      width: 20.0,
                      color: Colors.black38,
                      child: Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Start typing...',
                    hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

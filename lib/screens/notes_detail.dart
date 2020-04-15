import 'package:flutter/material.dart';

class NoteDatails extends StatefulWidget {
  @override
  _NoteDatailsState createState() => _NoteDatailsState();
}

class _NoteDatailsState extends State<NoteDatails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomPadding:false,
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: OutlineButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.priority_high,
                      color: Colors.red,
                    ),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: OutlineButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.alarm,
                      color: Colors.blueAccent,
                    ),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              decoration: InputDecoration.collapsed(
                hintText: 'Start typing...',
                hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Transform.scale(
            scale: 0.9,
            child: FloatingActionButton(
              child: Icon(
                Icons.delete,
              ),
              backgroundColor: Colors.red,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Transform.scale(
            scale: 1.2,
            child: FloatingActionButton(
              child: Icon(
                Icons.save,
              ),
              backgroundColor: Colors.blue,
              onPressed: () => {},
            ),
          ),
        ],
      ),
    );
  }
}

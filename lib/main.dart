import 'package:flutter/material.dart';
import 'package:note_maker/screens/first_page.dart';
import 'package:note_maker/screens/notes_detail.dart';
import 'package:note_maker/screens/search_page.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Note Maker",
        initialRoute: '/',
        routes: {
          '/': (context) => MainMenu(),
          '/notes': (context) => NoteDatails(),
          '/search': (context) => Search(),
        },

      ),
    );

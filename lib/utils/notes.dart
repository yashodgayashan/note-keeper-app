import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Notes {
  int id;
  String title;
  String content;
  bool remindMe;
  String remindTime;
  String createdTime;
  String updatedTime;

  /**
   *  Using Notes.createNotes named constructor will be used when a note is created.
   *  it will take the title as the required parameter and other as optional.
   *  remind me value will be false default and the created time will be assigned at the created time
   */
  Notes.createNote(
      {@required String title, String content, bool remindMe = false}) {
    this.title = title;
    this.content = content;
    this.remindMe = remindMe;
    this.createdTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  }
}

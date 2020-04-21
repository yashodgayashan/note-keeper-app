import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Note {
  int _id;
  String _title;
  String _content;
  int _remindMe;
  String _remindTime;
  String _createdTime;
  String _updatedTime;
  String _category;

  /**
   *  Using Notes.createNotes named constructor will be used when a note is created.
   *  it will take the title as the required parameter and other as optional.
   *  remind me value will be false default and the created time will be assigned at the created time
   */
  Note.createNote(
      {@required String title, String content, int remindMe = 0, String remindTime, String category}) {
    this._title = title;
    this._content = content;
    this._remindMe = remindMe;
    this._createdTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    this._updatedTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
    this._remindTime = remindTime;
    this._category = category;
  }

  int get id => _id;

  String get title => _title;

  String get content => _content;

  int get remindMe => _remindMe;

  String get remindTime => _remindTime;

  String get createdTime => _createdTime;

  String get updatedTime => _updatedTime;

  String get category => _category;

  set title(String newTitle) => this._title = newTitle;

  set content(String newContent) => this._content = newContent;

  set remindMe(int newRemindMe) => this._remindMe = newRemindMe;

  set remindTime(String newRemindTime) => this._remindTime = newRemindTime;

  set updatedTime(String newUpdatedTime) => this._updatedTime = newUpdatedTime;

  set category(String newCategory) => this._category = newCategory;

  setRemindTime(DateTime time) {
    remindTime = DateFormat('yyyy-MM-dd – kk:mm').format(time);
  }

  setUpdateTime() {
    updatedTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = _id;
    }
    map["title"] = _title;
    map["content"] = _content;
    map["remindMe"] = _remindMe;
    map["remindTime"] = _remindTime;
    map["createdTime"] = _createdTime;
    map["updatedTime"] = _updatedTime;
    map["category"] = _category;
    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._title = map["title"];
    this._content = map["content"];
    this._remindMe = map["remindMe"];
    this._remindTime = map["remindTime"];
    this._createdTime = map["createdTime"];
    this._updatedTime = map["updatedTime"];
    this._category = map["category"];
  }
}

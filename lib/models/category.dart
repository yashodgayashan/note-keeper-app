import 'package:flutter/foundation.dart';

class Category {
  int _id;
  String _name;

  Category(this._name);

  String get name => _name;

  int get id => _id;

  set name(String newName) => this._name = newName;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = _id;
    }
    map["name"] = _name;
    return map;
  }

  Category.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._name = map["name"];
  }
}

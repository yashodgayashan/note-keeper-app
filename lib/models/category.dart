import 'package:flutter/foundation.dart';

class Category {
  int _id;
  String _name;
  String _color;

  Category(this._name, this._color);

  String get name => _name;

  int get id => _id;

  String get color => _color;

  set name(String newName) => this._name = newName;

  set color(String newColor) => this._color = newColor;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = _id;
    }
    map["name"] = _name;
    map["color"] = _color;
    return map;
  }

  Category.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._name = map["name"];
    this._color = map["color"];
  }
}

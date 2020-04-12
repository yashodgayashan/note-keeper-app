import 'package:flutter/foundation.dart';

class Notes{
  int id;
  String title;
  String content;
  bool remindMe;
  String time;

  Notes({@required this.title, this.content, this.remindMe, this.time});

}
import 'dart:collection';

class Fermi {
  String user;
  String name;
  int dateStarted;
  int dateCreated;
  List<String> images;

  Fermi(this.user, this.name, this.dateStarted, this.dateCreated, this.images);

  Map<String, dynamic> toMap() {
    var map = HashMap<String, dynamic>();
    map["user"] = this.user;
    map["name"] = this.name;
    map["dateStarted"] = this.dateStarted;
    map["dateCreated"] = this.dateCreated;
    map["images"] = this.images;
    return map;
  }
}

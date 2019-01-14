import 'package:firebase_database/firebase_database.dart';

class Room {
  String id;
  String name; 
  String color; 
  List<String> devices;

  Room({this.id, this.name, this.color, this.devices});

  Room.fromJson(String id, Map<dynamic, dynamic> json) {
    this.id = id;
    this.name = json['name'];
    this.color = json['color'];
    this.devices = json['devices'] == null ? new List<String>() : List<String>.from(json['devices'].keys);
  }

  Room.fromSnapshot(DataSnapshot snapshot) {
    this.id = snapshot.key;
    this.name = snapshot.value['name'];
    this.color = snapshot.value['color'];
    this.devices = snapshot.value['devices'] == null ? new List<String>() : List<String>.from(snapshot.value['devices'].keys);
  }
}